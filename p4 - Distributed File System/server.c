#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <signal.h>
#include <stdbool.h>
#include <math.h>

#include "udp.h"
#include "ufs.h"
#include "mfs.h"
#include "server.h"

#define BUFFER_SIZE (1000)


// server.c
struct sockaddr_in server_addr;
message reply;
int serverPort;
int sd;
int fd;
bool debug;


unsigned int fileSize;
unsigned int numInodes;
unsigned int numBlocks;
super_t *superPtr;
bitmap_t *inodeBitmapPtr;
bitmap_t *dataBitmapPtr;
inode_t *inodesPtr;
inode_block *inodeBlockTable;
dir_ent_t *dataEntriesPtr;
dir_block_t *dataBlocksPtr;
unsigned int currSize;

void intHandler(int dummy) {
    UDP_Close(sd);
    exit(130);
}


unsigned int get_bit(unsigned int *bitmap, int position) {
    int index = position / 32;
    int offset = 31 - (position % 32);
    return (bitmap[index] >> offset) & 0x1;
}

void set_bit(unsigned int *bitmap, int position) {
    int index = position / 32;
    int offset = 31 - (position % 32);
    bitmap[index] |=  0x1 << offset;
}

int server__Init(char *imgFile) {
    int fd = open(imgFile, O_RDONLY | O_CREAT, S_IRWXU);

    if (fd < 0) {
	return -1;
    }

    char data[MFS_BLOCK_SIZE];
    MFS_DirEnt_t *entry = (MFS_DirEnt_t *)data;
    strcpy(entry->name, ".");
    entry->inum = 0;
    entry++;
    strcpy(entry->name, "..");
    entry->inum = 0;

    int blockSize = MFS_BLOCK_SIZE / sizeof(MFS_DirEnt_t);

    for (int i = 0; i < blockSize - 2; i++) {
	entry++;
	strcpy(entry->name, "");
	entry->inum = -1;
    }

    int sync = fsync(fd);

    if (sync < 0) {
	return -1;
    }
    return fd;
}

void printInode(int inum) {
    inode_t inode;
    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (inum * sizeof(inode_t));
    printf("inodeAddr: %d\n", inodeAddr);
    lseek(fd, inodeAddr, SEEK_SET);
    if ((read(fd, &inode, sizeof(inode_t))) < 0) {
	printf("printInode: read() inode failed\n");
    }

    int type = inode.type;
    int size = inode.size;
    dir_block_t dataBlock;
    int addr = 0;

    dir_ent_t dirEntry;
    int dirEntryAddr = 0;
    printf("inode.inum: %d   inode.type: %d   inode.size: %d\n", inum, type, size);
    for (int i = 0; i < DIRECT_PTRS; i++) {
	if (inode.direct[i] != -1) {
	    printf("inode.direct[%d]: %d\n", i, inode.direct[i]);
	    addr = (inode.direct[i] * UFS_BLOCK_SIZE);

	    printf("addr: %d\n", addr);
	    lseek(fd, addr, SEEK_SET);
	    read(fd, &dataBlock, sizeof(dir_block_t));
	    //int done = inode.size / 32;
	    for (int j = 0; j < (inode.size / 32); j++) {
		dirEntryAddr = (inode.direct[i] * UFS_BLOCK_SIZE) + (j * sizeof(dir_ent_t)); 
		//printf("dirEntryAddr: %d\n", dirEntryAddr);
		lseek(fd, dirEntryAddr, SEEK_SET);
		read(fd, &dirEntry, sizeof(dir_ent_t));
		printf("dirEntryAddr: %d   dirEntry.name: %s   dirEntry.inum: %d\n", dirEntryAddr, dirEntry.name, dirEntry.inum);
		//printf("dataBlock.entries[%d].name: %s  dataBlock.entries[%d].inum: %d\n", j, dataBlock.entries[j].name, j, dataBlock.entries[j].inum);
	    }
	}
    }
}


int server_LookUp(int pinum, char *name) {
    debug = false;
    if (strlen(name) > 28) {
	printf("server_LookUp(): name too long!\n");
	return -1;
    }

    printf("pinum: %d   name: %s\n", pinum, name);
    //printInode(pinum);
    // first check bit map
    // then go through
    // check whether inode bitmap is valid?
    //check for invalid pinum
    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE , SEEK_SET);
    int rc = read(fd, (void *) inodeBitmapPtr, sizeof(bitmap_t));
    if (rc < 0) {
	printf("server_LookUp(): Read failed\n");
	return -1;
    }
    if (!get_bit(inodeBitmapPtr->bits, pinum)) {
	printf("server_Lookup(): pinum not allocated\n");
	return -1;
    }
    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (pinum * sizeof(inode_t));
    inode_t parentInode;
    lseek(fd, inodeAddr, SEEK_SET);
    read(fd, (void *) &parentInode, sizeof(inode_t));
    if (parentInode.type != MFS_DIRECTORY) {
	return -1;
    }
    dir_ent_t dr;
    for(int h = 0; h < DIRECT_PTRS; h++) {
	//get the addr of each direct entry
	int addr = parentInode.direct[h] * UFS_BLOCK_SIZE;
	if(parentInode.direct[h]  == -1){
	    continue;
	}
	for(int j = 0; j < UFS_BLOCK_SIZE; j+=sizeof(dir_ent_t)) {  
	    if (debug) printf("server_LookUp(): addr: %d\n", addr + j); 
	    lseek(fd, addr+j, SEEK_SET);
	    read(fd,&dr,sizeof(dir_ent_t));
	    if (debug && dr.inum != -1) {
		printf("dr.name: %s\n", dr.name);
	    }
	    if (strcmp(dr.name, name) == 0) {
		if (debug) printf("dr.inum: %d\n", dr.inum);
		return dr.inum;
	    }
	}
    }
    return -1;

}

int server_Stat(message *m) {
    debug = false;
    int inum = m->inum;

    bitmap_t inodeBitmap;
    lseek(fd, (superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE), SEEK_SET);
    read(fd, &inodeBitmap, sizeof(bitmap_t));

    // or can we check inodeBitMap?
    if (get_bit(inodeBitmap.bits, inum) == 0) {
	return -1;
    }


    // unsure about calculation of offset
    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) +  (inum * sizeof(inode_t));

    inode_t inode;
    lseek(fd, inodeAddr, SEEK_SET);
    read(fd, &inode, sizeof(inode_t));


    m->size = inode.size;
    m->type = inode.type;

    if (debug) printf("m->size %d  m->type %d\n", m->size, m->type);
    //return m;
    return 0;
}


int hasDuplicates(inode_t inode, char *name) {
    int numDir = inode.size / sizeof(dir_ent_t);
    int dirNum;
    dir_ent_t currDirEnt;
    for (int i = 0; i < numDir; i++) {
	dirNum = inode.direct[i];
	currDirEnt = dataEntriesPtr[dirNum];
	if (strcmp(currDirEnt.name, name) == 0) {
	    return -1;
	}
    }
    return 0;
}

int getBlock(int inum) {
    return (inum * sizeof(inode_t)) / MFS_BLOCK_SIZE;
}

void printFile(int inum) {
    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (inum * sizeof(inode_t));
    inode_t inode;
    lseek(fd, inodeAddr, SEEK_SET);
    int ret = read(fd, &inode, sizeof(inode_t));
    if (ret < 0) {
	printf("printFile(): reading inode failed\n");
	return;
    }
    if (inode.type == MFS_DIRECTORY) {
	printf("printFile(): inode is a directory. Returning\n");
	return;
    }
    printf("inode.size: %d || inode.type: %d\n", inode.size, inode.type);

    int dataAddr = 0;
    dir_block_t dataBlock;
    for (int i = 0; i < DIRECT_PTRS; i++) {
	if (inode.direct[i] != -1) {
	    dataAddr = inode.direct[i] * UFS_BLOCK_SIZE;
	    lseek(fd, dataAddr, SEEK_SET);
	    ret = read(fd, &dataBlock, sizeof(dir_block_t));
	    if (ret < 0) {
		printf("printFile(): reading data block at direct[%d] failed\n", i);
		return;
	    }
	    char *contents = (char *) &dataBlock;
	    printf("%s\n", contents);
	}
    }

}

int server_Read(int inum, char *buffer, int offset, int nbytes) {
    // go to inode bit map, make sure inode is correct
    // check if the position is out of file  nbytes to be 4096 and ij0dexsize > nbytes + offset

    // (offset+nbytes)/size check to make sure offset+nbytes % size != 0 -> incremnt
    // incrmenet > DIRECT_PTR -> -1

    // make sure inode is valid
    bitmap_t inodeBitmap;
    int ret = 0;
    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    if ((ret = read(fd, &inodeBitmap, sizeof(bitmap_t))) < 0)
    { // int remainingBytes = (offset % UFS_BLOCK_SIZE) + nbytes = UFS_BLOCK_SIZE
      // int firstByte = nbytes - remainingBytes
	printf("server_Write: Could not read inodeBitmap\n");
    }

    if (get_bit(inodeBitmap.bits, inum) == 0)
    {
	printf("Inode bit map failed\n");
	return -1;
    }

    // get the inode

    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (inum * sizeof(inode_t));
    inode_t inode;
    lseek(fd, inodeAddr, SEEK_SET);
    read(fd, &inode, sizeof(inode_t));
    // posiiton to read out of file?
    if ((inode.size > (nbytes + offset)) && (inode.size < UFS_BLOCK_SIZE))
    {
	printf("when size > nbytes+offset or inode.size < UFS_BLOCK_SIZE\n");
	return -1;
    }

    int numBlocks = (offset + nbytes) / UFS_BLOCK_SIZE;
    if (((offset + nbytes) % UFS_BLOCK_SIZE) != 0)
    {
	numBlocks++;
    }

    if (numBlocks > DIRECT_PTRS + 1)
    {
	printf("BLOCK EXCEED LIMIT\n");
	return -1;
    }

    if (inode.size == 0)
    {
	printf("Trying to read empty data\n");
	return -1;
    }

    //  check to see if we can find

    //printf(" offset+nbytes %d\n",offset+nbytes);
    int numBlockReading = 0;
    if ((offset % UFS_BLOCK_SIZE) + nbytes > UFS_BLOCK_SIZE)
    {
	numBlockReading = 2;
    }
    else
    {
	numBlockReading = 1;
    }

    int dataBlockIdx = inode.direct[offset/UFS_BLOCK_SIZE];

    //printf(" Data Block: %d\n",dataBlockIdx);

    if(inode.direct[offset/UFS_BLOCK_SIZE] == -1){
	printf("Invalid read\n");	
	return -1;
    }		

    //printf("here\n");

    int idxBlockFound = -1;

    //printf("Data we are looking for %d\n",dataBlockIdx);

    for(int s = 0; s < DIRECT_PTRS; s++){
	printf("%d\n", inode.direct[s]);
	if(inode.direct[s] == dataBlockIdx){
	    idxBlockFound = s;
	    break;
	}
    }

    //printf("here2\n");
    if(idxBlockFound == -1){
	printf("Invalid read\n");
	return -1;
    }

    // check to make sure we can read more than 2 data
   // if (numBlockReading == 2)
   // {
//	if (inode.direct[idxBlockFound + 1] == -1)
//	{
//	    printf("If have to read 2 block and next one doesn't exist\n");
//	    return -1;
//	}
  //  }

    // check to see the current directBlock we are reading will go past DIRECT Size
    // will read invalid
    if ((idxBlockFound + 1 > DIRECT_PTRS) && numBlockReading == 2)
    {
	printf("If we are reading 2 blocks and the size exceed buffer size\n");
	return -1;
    }

    //printf("here3\n");
	
    // same
    if (inode.type == UFS_DIRECTORY || inode.type == UFS_REGULAR_FILE)
    {
	if (numBlockReading == 2)
	{
	    //printf("Seg fault likely here1\n");
 	   
	    char buff[4096];
	    int b1bytes = UFS_BLOCK_SIZE - (offset%UFS_BLOCK_SIZE);
	    int b2bytes = nbytes - b1bytes;
	    data_block_t dataBlock1;
	    data_block_t dataBlock2;

	    lseek(fd, (inode.direct[offset / UFS_BLOCK_SIZE] * UFS_BLOCK_SIZE) + (offset / UFS_BLOCK_SIZE), SEEK_SET);
    	    read(fd, &dataBlock1, b1bytes);
	
	    memcpy(&buffer, &dataBlock1.data[offset/UFS_BLOCK_SIZE], b1bytes);
		

	    lseek(fd, (inode.direct[(offset/UFS_BLOCK_SIZE)+1] * UFS_BLOCK_SIZE), SEEK_SET);
	    read(fd, &dataBlock2, b2bytes);

	    char *latterHalf =  buffer + b1bytes;
	    memcpy(&latterHalf, &dataBlock2.data[offset / UFS_BLOCK_SIZE], b2bytes);
	  	  //  memcpy(&buffer,(void *)((long)((inode.direct[offset/UFS_BLOCK_SIZE] * UFS_BLOCK_SIZE) + (offset/UFS_BLOCK_SIZE))),b1bytes);

	   // memcpy(&buffer,(void *)((long)(inode.direct[(offset/UFS_BLOCK_SIZE)+1] * UFS_BLOCK_SIZE)),b2bytes);

	}
	else{
	    //printf("Seg fault likely here2\n");
	    // read in one block directory
	    char buff[4096];
	
	    data_block_t dataBlock;
	    lseek(fd, (inode.direct[offset / UFS_BLOCK_SIZE] * UFS_BLOCK_SIZE), SEEK_SET);
	    read(fd, &dataBlock, nbytes);
	    //+ (offset / UFS_BLOCK_SIZE),
	    memcpy(&buffer, &dataBlock.data[offset / UFS_BLOCK_SIZE], nbytes);
	  
	    //memcpy(&buffer,(void *)((long)(inode.direct[offset/UFS_BLOCK_SIZE] * UFS_BLOCK_SIZE)),nbytes);

	}
    }else{
	printf("Wrong type\n");
	return -1;

    }
    return 0; 

}


int isFileNew(inode_t inode) {
    if (inode.size != 0) {
	return 0;
    } 
    for (int i = 0; i < DIRECT_PTRS; i++) {
	if (inode.direct[i] != -1) {
	    return 0;
	}
    }
    return 1;
}

int server_Write(int inum, char *buffer, int offset, int nbytes) {
    //if (inum == 4172) return 0;
    if (inum > (superPtr->inode_region_len * UFS_BLOCK_SIZE) / sizeof(inode_t)) {
	printf("inode too big\n");
	return -1;
    }

    //printf("offset: %d  nbytes: %d\n", offset, nbytes);
    // make sure the inum is valid
    bitmap_t inodeBitmap;
    int ret = 0;
    debug = false;
    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    if ((ret = read(fd, &inodeBitmap, sizeof(bitmap_t))) < 0) { // int remainingBytes = (offset % UFS_BLOCK_SIZE) + nbytes = UFS_BLOCK_SIZE
								// int firstByte = nbytes - remainingBytes
	printf("server_Write: Could not read inodeBitmap\n");
    }

    if(get_bit(inodeBitmap.bits,inum) == 0) {
	printf("inum is not allocated\n");
	return -1;
    }

    // getting the inode

    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (inum * sizeof(inode_t));
    inode_t inode;
    lseek(fd, inodeAddr, SEEK_SET);

    if ((ret = read(fd, &inode, sizeof(inode_t))) < 0) {
	printf("cannot read inode\n");
	return -1;
    }

    // check if the end position is out of file
    //&& innercall == 0
    if (inode.type != MFS_REGULAR_FILE ) {
	printf("inode is not a regular file\n");
	return -1;
    }

    //printf("working till here\n");

    int lastAddr = offset + nbytes;
    int new_blocks = 0;
    // do we need more than 2 block?
    if (inode.size < lastAddr) {
	// update size
	int new_size = lastAddr;
	// how many block new size need?
	new_blocks = new_size / UFS_BLOCK_SIZE;
	int old_blocks = inode.size / UFS_BLOCK_SIZE;
	// # extra block new size will need
	if (new_size % UFS_BLOCK_SIZE != 0) {
	    new_blocks++;
	}

	//printf("work2\n");
	//printf("New_block: %d\n", new_blocks);	
	// check for MAXSIZE
	/*if (new_blocks > DIRECT_PTRS) {
	    printf("NewBlock > DIRECT_PTRS\n");
	    return -1;
	}*/
	if (inode.size % UFS_BLOCK_SIZE != 0) {
	    old_blocks++;
	}

	// how many blocks do we need?
	int needed_blocks = new_blocks - old_blocks;
	int inode_dir_index = old_blocks;
	bitmap_t dataBitmap;
	int ret;
	lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
	if ((ret = read(fd, &dataBitmap, sizeof(bitmap_t))) < 0){ 
	    // int remainingBytes = (offset % UFS_BLOCK_SIZE) + nbytes = UFS_BLOCK_SIZE
	    // int firstByte = nbytes - remainingBytes
	    printf("server_Write: Could not read inodeBitmap\n");
	}

	//printf("here5\n");

	// get specified amount of extra block needed
	for (int i = 0; i < superPtr->data_region_len && needed_blocks > 0; i++)
	{
	    if (get_bit(dataBitmap.bits,i) == 0) {
		inode.direct[inode_dir_index] = superPtr->data_region_addr + i;
		set_bit(dataBitmap.bits, i);
		lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
		write(fd, dataBitmap.bits, sizeof(bitmap_t));
		needed_blocks--;
	    }
	} 

	// means we cannot find enough block to satisfy needed block
	if (needed_blocks != 0) {
	    printf("needed blocks does not equal 0, meaning we cant find enough blocks to satisfy needed blocks\n");
	    return -1;
	}
	inode.size = new_size;
 
    }

    //printf("here6\n");

    int start_index_block = offset / UFS_BLOCK_SIZE;
    int start_offset_block = offset % UFS_BLOCK_SIZE;
    int index_last_block = lastAddr / UFS_BLOCK_SIZE;
    int offset_last_block = lastAddr % UFS_BLOCK_SIZE;

    if (offset_last_block == 0) {
	index_last_block--;
    }

    if (start_index_block == index_last_block) {
	// condition for only 1 block
	//if (offset
	// void *start = (void *)((long)start_offset_block + inode.direct[start_index_block] * UFS_BLOCK_SIZE);
	// NOT SURE
	//
	int testing = ((new_blocks * UFS_BLOCK_SIZE) + (3 * UFS_BLOCK_SIZE) + (superPtr->inode_region_len * UFS_BLOCK_SIZE));
	//printf("Need to add more space to the file. Testing: %d\n", testing);
	//if (((new_blocks * UFS_BLOCK_SIZE) + (3 * UFS_BLOCK_SIZE) + (superPtr->inode_region_len * UFS_BLOCK_SIZE)) >= fileSize) {

    //}	
	data_block_t dataBlock;
	int startAddr = start_offset_block + inode.direct[start_index_block] * UFS_BLOCK_SIZE;
	//if ((New_block
	//printf("startAddr: %d\n", startAddr);	
	if (debug) printf("startAddr: %d\n", startAddr);
	lseek(fd, startAddr, SEEK_SET);
	ret = read(fd, &dataBlock, sizeof(data_block_t));
	if (ret < 0) {
	    printf("read() failed\n");
	    return -1;
	}

	//printf("Block writing to: %d\n", offset/UFS_BLOCK_SIZE);
	int startOffset = offset % UFS_BLOCK_SIZE;
	memcpy(&dataBlock.data[startOffset], buffer, nbytes);
	
	if (ret < 0) {
	    printf("memcpy() failed\n");
	    return -1;
	}

	lseek(fd, startAddr, SEEK_SET);
	//printf("test1\n");
	ret = write(fd, (void *) &dataBlock, sizeof(data_block_t));
	//printf("test2\n");
	if (ret < 0) {
	    printf("write() failed\n");
	    return -1;
	}
	//void *start = (void *)((long)start_offset_block + inode.direct[start_index_block] * UFS_BLOCK_SIZE);
	//memcpy(&start, buffer, nbytes);
	//lseek(fd, (long)start_offset_block + inode.direct[start_index_block] * UFS_BLOCK_SIZE, SEEK_SET);
	//ret = write(fd, start, nbytes);
	//if (ret < 0) {
	//printf("server_Write(): write failed first of two numBlocks\n");
	//return -1;
	//}

    }
    else{
	//printf("seg here2\n");

	// condition for when there are 2 block
	data_block_t dataBlock1;
	data_block_t dataBlock2;
	int startAddr1 = start_offset_block + inode.direct[start_index_block] * UFS_BLOCK_SIZE;
	lseek(fd, startAddr1, SEEK_SET);
	ret = read(fd, &dataBlock1, UFS_BLOCK_SIZE - start_offset_block);
	if (ret < 0) {
	    printf("case2 write(): read() failed\n");
	    return -1;
	}

	memcpy(&dataBlock1.data[offset/UFS_BLOCK_SIZE], buffer, UFS_BLOCK_SIZE - start_offset_block);
	lseek(fd, startAddr1, SEEK_SET);
	ret = write(fd, (void *) &dataBlock1, UFS_BLOCK_SIZE - start_offset_block);
	if (ret < 0) {
	    printf("server_Write(): write failed in case2\n");
	    return -1;
	}

	int startAddr2 = inode.direct[index_last_block] * UFS_BLOCK_SIZE;
	lseek(fd, startAddr2, SEEK_SET);
	ret = read(fd, &dataBlock2, offset_last_block);
	if (ret < 0) {
	    printf("server_Write(): read() failed for dataBlock2\n");
	    return -1;
	}

	char *latterBuffer = (UFS_BLOCK_SIZE - start_offset_block) + buffer;
	memcpy(&dataBlock2.data[0], latterBuffer, offset_last_block);
	lseek(fd, inode.direct[index_last_block] * UFS_BLOCK_SIZE, SEEK_SET);
	ret = write(fd, (void *) &dataBlock2, offset_last_block);
	if (ret < 0) {
	    printf("server_Write(): write() failed for datablock2\n");
	    return -1;
	}

    }
    lseek(fd, inodeAddr, SEEK_SET);
    write(fd, &inode, sizeof(inode_t));

    fsync(fd);
    return 0;
}

int server_Creat(int pinum, int type, char *name) {
    debug = false;
    if (pinum < 0 || pinum > 4095) {
	printf("server.c error: pinum is invalid: %d\n", pinum);
	return -1;
    }
    if (type != MFS_REGULAR_FILE && type != MFS_DIRECTORY) {
	printf("server.c error: type is invalid\n");
	return -1;
    }
    if (debug) printf("server_Creat: pinum: %d   type: %d   name: %s\n", pinum, type, name);
    int ret = 0;

    bitmap_t inodeBitmap;
    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    read(fd, &inodeBitmap, sizeof(bitmap_t));
    if (get_bit(inodeBitmap.bits, pinum) == 0) {
	printf("pinum not allocated\n");
	return -1;
    }


    //If the same name already exists in the pinum, return. Else, continue.
    if (server_LookUp(pinum, name) != -1) {
	if (debug) printf("server_Creat: server_LookUp found the file in the directory\n");
	return -1; //name is already in pinum
    }
    else {
	if (debug) printf("server_Creat(): server_LookUp() did not find a file with this name\n");
    }


    //Read the inode of the parent, then read it in to a variable.
    int parentInodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (pinum * sizeof(inode_t));
    inode_t parentInode;
    lseek(fd, parentInodeAddr, SEEK_SET);
    if ((ret = read(fd, &parentInode, sizeof(inode_t))) < 0) {
	printf("server_Creat: read() parentInode failed\n");
	return -1;
    }
    printf("pinode before changes\n");
    printInode(pinum);

    if (parentInode.type == MFS_REGULAR_FILE) {
	printf("server_Creat(): parentInode is a file\n");
	return -1;
    }
    if (debug) printf("server_Creat: parentInodeAddr is %d\n", parentInodeAddr);  

    if (debug) {
	printf("printing pinode before changes\n\n");
	printInode(pinum);
    }

    // Another route the TA last night told us. If size is a multiple of 4096, then all blocks are filled
    // otherwise go to block size / 4096, and fill it in the entry size % 4096

    //dir_block_t dataBlock;
    //int dataBlockAddr = 0;
    //dir_ent_t dataEntry;
    //int dataEntryAddr = 0;
    int numDataEntriesPerBlock = UFS_BLOCK_SIZE / sizeof(dir_ent_t); //Loop thru entries
    if (debug) printf("server_Creat: numDataEntriesPerBlock: %d\n", numDataEntriesPerBlock);
    int newInum = 0;//Index of the new inode
		    //bitmap_t inodeBitmap;
    int freeDataBlock = 0;//Index of the new dataBlock.
    bitmap_t dataBlockBitmap;//QUESTION: Does the data bitmap map to dataBlocks or data entries?
    int flag = 0;


    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    if ((ret = read(fd, &inodeBitmap, sizeof(bitmap_t))) < 0) {    //int remainingBytes = (offset % UFS_BLOCK_SIZE) + nbytes = UFS_BLOCK_SIZE
								   //int firstByte = nbytes - remainingBytes


	printf("server_Creat: Could not read inodeBitmap\n");
    }
    while (get_bit(inodeBitmap.bits, newInum)) newInum++;
    if (debug) printf("server_Creat: newInum %d\n", newInum);
    set_bit(inodeBitmap.bits, newInum);
    set_bit(inodeBitmapPtr->bits, newInum);
    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    write(fd, (void *) &inodeBitmap, sizeof(bitmap_t));
    if (type == MFS_DIRECTORY) {
	lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
	if ((ret = read(fd, &dataBlockBitmap, sizeof(bitmap_t))) < 0) {
	    printf("server_Creat: Could not read dataBlockBitmap\n");
	}
	while (get_bit(dataBlockBitmap.bits, freeDataBlock)) freeDataBlock++;
	if (debug) printf("server_Creat: freeDataBlock: %d\n", freeDataBlock);
	set_bit(dataBlockBitmap.bits, freeDataBlock);
	set_bit(dataBitmapPtr->bits, freeDataBlock);
	lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
	write(fd, (void *) &dataBlockBitmap, sizeof(bitmap_t)    //int remainingBytes = (offset % UFS_BLOCK_SIZE) + nbytes = UFS_BLOCK_SIZE
								 //int firstByte = nbytes - remainingBytes

	     );
    }

    if (debug) printf("New inum: %d\n", newInum);
    //if (debug) printf("newInum: %d   freeDataBlock: %d\n", newInum, freeDataBlock);

    //QUESTION: Is an inode's direct field a pointer to a data block or data entry?
    //QUESTION: Should dataBlock.entries[0].name be "." or the paramater 'name'?
    //if (debug) printf("parentInodeAddr: %d\n", parentInodeAddr);
    //if (debug) printf("parentInode.type: %d  parentInode.size: %d\n", parentInode.type, parentInode.size);
    parentInode.size += 32;
    inodeBlockTable->inodes[pinum].size += 32;

    lseek(fd, parentInodeAddr, SEEK_SET);
    write(fd, (void *) &parentInode, sizeof(inode_t));


    //if (type == MFS_DIRECTORY) {
    dir_block_t block;
    int newAddr = 0;
    flag = 0;
    for (int i = 0; i < DIRECT_PTRS; i++) {
	if (parentInode.direct[i] != -1) {
	    newAddr = parentInode.direct[i] * UFS_BLOCK_SIZE;
	    if (debug) printf("newAddr: %d\n", newAddr);
	    lseek(fd, newAddr, SEEK_SET);
	    if ((read(fd, &block, sizeof(dir_block_t)) < 0)) {
		printf("server_Creat(): read() failed\n");
		return -1;
	    }
	    for (int j = 2; j < (UFS_BLOCK_SIZE / sizeof(dir_ent_t)); j++) {
		if (block.entries[j].inum == -1) {
		    block.entries[j].inum = newInum;
		    strcpy(block.entries[j].name, name);
		    dataBlocksPtr->entries[j].inum = newInum;
		    if (debug) printf("entry:%d, inum:%d\n", j, dataBlocksPtr->entries[j].inum);
		    strcpy(dataBlocksPtr->entries[j].name, name);
		    flag = 1;
		    break;
		}
		else {
		    continue;
		}	   
	    }
	}
	if (flag) break;
    }

    //if (debug) printf("writing a newBlock changes to parent's data block\n");
    lseek(fd, newAddr, SEEK_SET);
    write(fd, (void *) &block, sizeof(dir_block_t));
    //if (flag) {


    inode_t newInode;
    //if (debug) printf("now writting a new data block\n");
    if (type == MFS_DIRECTORY) {
	dir_block_t newBlock;
	newInode.size = 64;
	newInode.type = type;
	for (int i = 0; i < DIRECT_PTRS; i++) {
	    if (i == 0) {
		newInode.direct[i] = superPtr->data_region_addr + freeDataBlock;
		//if (debug) printf("newInodeDirectPtrAddr: %d", newInode.direct[i] * UFS_BLOCK_SIZE);
		lseek(fd, (superPtr->data_region_addr + freeDataBlock) * UFS_BLOCK_SIZE, SEEK_SET);
		read(fd, &newBlock, sizeof(dir_block_t));

		newBlock.entries[0].inum = newInum;
		strcpy(newBlock.entries[0].name, ".");

		newBlock.entries[1].inum = pinum;
		strcpy(newBlock.entries[1].name, "..");

		for (int j = 2; j < UFS_BLOCK_SIZE / sizeof(dir_ent_t); j++) {
		    newBlock.entries[j].inum = -1;
		}
		//write(fd, (void *) &newBlock, sizeof(dir_block_t));
	    }
	    else { 
		newInode.direct[i] = -1;
	    }
	}
	lseek(fd, (superPtr->data_region_addr + freeDataBlock) * UFS_BLOCK_SIZE, SEEK_SET);
	write(fd, (void *) &newBlock, sizeof(dir_block_t));
	int newInodeAddr = (UFS_BLOCK_SIZE * superPtr->inode_region_addr) + (newInum * sizeof(inode_t));
	if (debug) printf("newInodeAddr: %d\n", newInodeAddr);
	lseek(fd, newInodeAddr, SEEK_SET);
	write(fd, (void *) &newInode, sizeof(inode_t));
    }
    else {
	newInode.size = 0;
	newInode.type = MFS_REGULAR_FILE;
	for (int i = 0; i < DIRECT_PTRS; i++) {
	    newInode.direct[i] = -1;
	}
	lseek(fd, (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (newInum * sizeof(inode_t)), SEEK_SET);
	write(fd, (void *) &newInode, sizeof(inode_t));
    }	
    reply.inum = newInum;
    // Want to check if the pinum is inuse
    fsync(fd);
    inodeBlockTable->inodes[newInum] = newInode;
    if (debug) {
	printf("printing pinode after changes\n\n");
	printInode(pinum);
    }
    printf("pinode after changes\n");
    printInode(pinum);


    printf("printing new inode\n", newInum);
    printInode(newInum);
    return 0;
}

int server_Unlink(int pinum, char *name) {
    if (pinum < 0 || pinum > 4095) {
	printf("server_Unlink error: pinum invalid\n");
	return -1;
    }
    if (strlen(name) > 28) {
	printf("server_Unlink error: name is too long\n");
	return -1;
    }
    int ret = 0;
    debug = true;

    bitmap_t inodeBitmap;
    bitmap_t dataBlockBitmap;

    lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    if ((ret = read(fd, &inodeBitmap, sizeof(bitmap_t))) < 0) {
	printf("server_Unlink() error: reading the inodeBitmap failed\n");
	return -1;
    }

    lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
    if ((ret = read(fd, &dataBlockBitmap, sizeof(bitmap_t))) < 0) {
	printf("server_Unlink() error: reading the inodeBitmap failed\n");
	return -1;
    }

    int parentInodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (pinum * sizeof(inode_t));
    inode_t parentInode;
    lseek(fd, parentInodeAddr, SEEK_SET);
    if ((ret = read(fd, &parentInode, sizeof(inode_t))) < 0) {
	printf("server_Creat: read() parentInode failed\n");
	return -1;
    }
    printf("parentInodeAddr: %d\n", parentInodeAddr);
    if (debug) printf("server_Unlink() debug: parentInodeAddr is %d || parentInode.type: %d || parentInode.size: %d\n", parentInodeAddr, parentInode.type, parentInode.size);
    if (parentInode.type == MFS_REGULAR_FILE) {
	printf("server_Unlink(): parentInode is a regular file\n");
	return -1;
    }


    int inum; 
    if ((inum = server_LookUp(pinum, name)) != -1) {
	if (debug) printf("server_Unlink(): server_LookUp found the file in the directory\n");
	//return -1; //name is already in pinum
    }
    else {
	printf("server_Unlink(): server_LookUp did not find the file in the parent directory");
    }

    inode_t inode;
    int inodeAddr = (superPtr->inode_region_addr * UFS_BLOCK_SIZE) + (inum * sizeof(inode_t));
    lseek(fd, inodeAddr, SEEK_SET);
    if ((ret = read(fd, &inode, sizeof(inode_t))) < 0) {
	printf("server_Unlink error: reading in inode failed\n");
	return -1;
    }

    int currDirAddr = 0;
    int currDataAddr = 0;
    dir_block_t currDirBlock;
    data_block_t currDataBlock;
    int numEntriesPerBlock = sizeof(dir_block_t) / sizeof(dir_ent_t);
        if (inode.type == MFS_DIRECTORY && inode.size != 64) {
	printf("server_Unlink: Cannot unlink. This file is a directory that is not empty.\n");
	if (debug) 
	    printf("inode.type: %d  inode.size: %d\n", inode.type, inode.size);
	return -1;
    }
    else if (inode.type == MFS_DIRECTORY && inode.size == 64) {
	if (debug) printf("server_Unlink(): file is a directory\n");
	inode.size = 0;
	inode.type = 0;
	for (int i = 0; i < DIRECT_PTRS; i++) {
	    if (inode.direct[i] != -1) {
		set_bit(dataBlockBitmap.bits, inode.direct[i]);
		lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
		write(fd, &dataBlockBitmap, sizeof(bitmap_t));

		currDirAddr = (inode.direct[i] * UFS_BLOCK_SIZE);
		lseek(fd, currDirAddr, SEEK_SET);
		read(fd, &currDirBlock, sizeof(dir_block_t));
		for (int j = 0; j < numEntriesPerBlock; j++) {
		    if (currDirBlock.entries[j].inum != -1) {
			currDirBlock.entries[j].inum = -1;
			bzero(currDirBlock.entries[j].name, MFS_NAME_LEN);
		    }
		}
		lseek(fd, currDirAddr, SEEK_SET);
		write(fd, (void *) &currDirBlock, sizeof(dir_block_t));
		inode.direct[i] = -1;
	    }
	}
	set_bit(inodeBitmap.bits, inum);
	lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
	write(fd, &inodeBitmap, sizeof(bitmap_t));

	lseek(fd, inodeAddr, SEEK_SET);
	write(fd, &inode, sizeof(inode_t));

	for (int i = 0; i < DIRECT_PTRS; i++) {
	    if (parentInode.direct[i] != 0) {
		currDirAddr = parentInode.direct[i] * UFS_BLOCK_SIZE;
		lseek(fd, currDirAddr, SEEK_SET);
		read(fd, &currDirBlock, sizeof(dir_block_t));
		for (int j = 0; j < numEntriesPerBlock; j++) {
		    if (currDirBlock.entries[j].inum == inum) {
			currDirBlock.entries[j].inum = -1;
			bzero(&currDirBlock.entries[j].name, MFS_NAME_LEN);
		    	lseek(fd, currDirAddr, SEEK_SET);
			write(fd, &currDirBlock, sizeof(dir_block_t));
		    
		    
		    }
		}
	    }
	}
	parentInode.size -= 32;
	lseek(fd, parentInodeAddr, SEEK_SET);
	write(fd, &parentInode, sizeof(inode_t));
    }
    else if (inode.type == MFS_REGULAR_FILE) {
	if (debug) printf("server_Unlink(): file is a regular file\n");
	inode.size = 0;
	inode.type = 0;
	for (int i = 0; i < DIRECT_PTRS; i++) {
	    if (inode.direct[i] != -1) {
		set_bit(dataBlockBitmap.bits, inode.direct[i]);
		lseek(fd, superPtr->data_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
		write(fd, &dataBlockBitmap, sizeof(bitmap_t));

		currDataAddr = (inode.direct[i] * UFS_BLOCK_SIZE);
		lseek(fd, currDataAddr, SEEK_SET);
		read(fd, &currDataBlock, sizeof(data_block_t));
		bzero(&currDataBlock, UFS_BLOCK_SIZE);

		lseek(fd, currDataAddr, SEEK_SET);
		write(fd, (void *) &currDataBlock, sizeof(data_block_t));
		inode.direct[i] = -1;
	    }
	}	   
	set_bit(inodeBitmap.bits, inum);
	lseek(fd, superPtr->inode_bitmap_addr * UFS_BLOCK_SIZE, SEEK_SET);
	write(fd, &inodeBitmap, sizeof(bitmap_t));	

	lseek(fd, inodeAddr, SEEK_SET);
	write(fd, &inode, sizeof(inode_t));    
	int flag = 0;
	dir_ent_t dirEnt;
	for (int i = 0; i < DIRECT_PTRS; i++) {
	    if (parentInode.direct[i] >= 0) {
		currDirAddr = parentInode.direct[i] * UFS_BLOCK_SIZE;
		printf("currDirAddr: %d\n", currDirAddr);
		lseek(fd, currDirAddr, SEEK_SET);
		read(fd, &currDirBlock, sizeof(dir_block_t));
		for (int j = 0; j < numEntriesPerBlock; j++) {
		    if (currDirBlock.entries[j].inum == inum) {
			if (debug)
			    printf("removing inum and name from parent. j: %d\n", j);
			currDirBlock.entries[j].inum = -1;
			bzero(&currDirBlock.entries[j].name, MFS_NAME_LEN);
			lseek(fd, currDirAddr, SEEK_SET);
			write(fd, &currDirBlock, sizeof(dir_block_t));
			
			parentInode.size -= 32;
			lseek(fd, parentInodeAddr, SEEK_SET);
			write(fd, &parentInode, sizeof(inode_t));
			flag = 1;
			break;
		    }
		}
	    }
	    if (flag == 1) {
		break;
	    }
	}
    }
    fsync(fd); 
    printInode(pinum);
    
    return 0;
}

int server_Shutdown() {
    /*int sync = fsync(fd);
      if (sync < 0) {
      return -1;
      }*/
    return 0;
}


// server code
int main(int argc, char *argv[]) {
    signal(SIGINT, intHandler);
    if (argc != 3) {
	printf("server.c error: argc != 3\n");
	exit(0);
    }
    debug = true;
    int serverPort = atoi(argv[1]);
    char *fileSystemImage = argv[2];
    struct stat blocks_stat;
    if (debug) printf("server.c main(): opening file\n");
    if ((fd = open(fileSystemImage, O_RDWR)) < 0) {
	printf("server.c error: open() failed\n");
	exit(0);
    }
    if (fstat(fd, &blocks_stat) != 0) {
	printf("server.c error: fstat() failed\n");
	exit(0);
    }


    fileSize = blocks_stat.st_size;
    if (fileSize <= 0) {
	printf("server.c error: szSize < 1\n");
	exit(0);
    }

    super_t s;
    int readTest;
    readTest = read(fd, &s, sizeof(super_t));
    if (readTest < 0) {
	printf("server.c error: read() failed\n");
	exit(0);
    }
    superPtr = &s;
    numBlocks = blocks_stat.st_size / UFS_BLOCK_SIZE;
    numInodes = (s.inode_bitmap_len * UFS_BLOCK_SIZE) / sizeof(inode_t);

    bitmap_t inodeBitmap;
    lseek(fd, UFS_BLOCK_SIZE * s.inode_bitmap_addr, SEEK_CUR); //Check if SEEK_CUR is correct.
    readTest = read(fd, &inodeBitmap, s.inode_bitmap_len * UFS_BLOCK_SIZE);
    if (readTest < 0) {
	printf("server.c error: read() failed\n");
	exit(0);
    }
    inodeBitmapPtr = &inodeBitmap;

    bitmap_t dataBitmap;
    lseek(fd, UFS_BLOCK_SIZE * s.data_bitmap_addr, SEEK_CUR); //Check if SEEK_CUR is correct.
    readTest = read(fd, &dataBitmap, s.data_bitmap_len * UFS_BLOCK_SIZE);
    if (readTest < 0) {
	printf("server.c error: read() failed\n");
	exit(0);
    }
    dataBitmapPtr = &dataBitmap;

    inode_t inodes[(UFS_BLOCK_SIZE * s.inode_region_len) / sizeof(inode_t)];
    inode_block inodeTableByBlock[s.inode_region_len];
    for (int i = 0; i < s.inode_region_len; i++) {
	lseek(fd, (UFS_BLOCK_SIZE * s.inode_region_addr) + (i * MFS_BLOCK_SIZE), SEEK_CUR);
	readTest = read(fd, &inodeTableByBlock[i], MFS_BLOCK_SIZE);
	if (readTest < 0) {
	    printf("server.c error: read inodes failed. i: %d\n", i);
	    exit(0);
	}
    }
    inodeBlockTable = inodeTableByBlock;

    lseek(fd, UFS_BLOCK_SIZE * s.inode_region_addr, SEEK_CUR); //Check if SEEK_CUR is correct.
    readTest = read(fd, &inodes, s.inode_region_len * UFS_BLOCK_SIZE);
    if (readTest < 0) {
	printf("server.c error: read() failed\n");
	exit(0);
    }
    printf("testing stack smashing\n");
    inodes[0].size = 0;

    inodesPtr = inodes;


    dir_ent_t dataEntries[(UFS_BLOCK_SIZE * s.data_region_len) / sizeof(dir_ent_t)];

    dir_block_t dataEntriesBlock[s.data_region_len];
    for (int i = 0; i < s.data_region_len; i++) {
	lseek(fd, UFS_BLOCK_SIZE * s.data_region_addr + (i * MFS_BLOCK_SIZE), SEEK_CUR);
	readTest = read(fd, &dataEntriesBlock[i], MFS_BLOCK_SIZE);
	if (readTest < 0) {
	    printf("server.c error: read data failed. i: %d\n", i);
	    exit(0);
	}
    }
    dataBlocksPtr = dataEntriesBlock;
    lseek(fd, UFS_BLOCK_SIZE * s.data_region_addr, SEEK_CUR); //Check if SEEK_CUR is correct.
    readTest = read(fd, &dataEntries, s.data_region_len * UFS_BLOCK_SIZE);
    if (readTest < 0) {
	printf("server.c error: read() failed\n");
	exit(0);
    }
    dataEntriesPtr = dataEntries;

    int sd = UDP_Open(serverPort);
    assert(sd > -1);
    lseek(fd, 0, SEEK_CUR); //Check if SEEK_CUR is correct.

    int ret;
    int nbytes;
    int t = 0;
    //int size;
    while (1) {
	//struct sockaddr_in addr;
	//char [BUFFER_SIZE];
	printf("server.c:: waiting...\n");
	char temp[sizeof(message)];

	int rc = UDP_Read(sd, &server_addr, (char *) &reply, sizeof(message));

	printf("server.c: server read message\n");
	//if (debug) printf("server.c debug: temp: %p   %s\n", temp, temp); 

	//reply = *(message *) temp;
	//if (debug) printf("server.c debug: server read second message\n");

	//if (debug) printf("server.c debug: reply.offset: %d\n", reply->size);
	//printf("reply->name: %s\n", reply->name);

	// if (debug) printf("pinum %d  type %d\n", reply->pinum, reply->type);
	//size = reply->size;
	/*printf("reply.inum: %d\n", reply.inum);
	  printf("reply.offset: %d\n", reply.offset);
	  printf("reply.nbytes: %d\n", reply.nbytes);
	  printf("reply.type: %d\n", reply.type);
	  printf("reply.pinum: %d\n", reply.pinum);
	  printf("reply.size: %d\n", reply.size);
	  */
	nbytes = reply.nbytes;
	char name[28];
	char buffer[nbytes];

	if (strcpy(name, reply.name) < 0) {
	    printf("server.c main(): strcpy() failed in name\n");
	}
	if (strlen(name) > 28) {
	    printf("server.c error: name is too long.\n");
	    rc = UDP_Write(sd, &server_addr, (void *) &reply, sizeof(message));
	    exit(0);
	}

	if (memcpy(buffer, reply.buffer, nbytes) < 0) {
	    printf("server.c main(): strcpy() failed in name\n");
	}


	switch (reply.oppNum) {
	    case OPP_INIT:
		printf("server.c: reply: OPP_INIT\n");
		break;
	    case OPP_LOOKUP:
		printf("server.c: reply: OPP_LOOKUP\n");
		//pinum = reply->pinum;
		//char name[28];
		
		if ((strcpy(name, reply.name)) < 0) {
		    printf("server.c error: main() OPP_LOOKUP: strcpy() failed\n");
		}
		//if (reply.h == 1) {

		//}
		if ((ret = server_LookUp(reply.pinum, reply.name)) < 0) {
		    reply.returnCode = -1;
		    if (t == 1) {
			reply.t = 1;
		        t = 0;
		    }
		    printf("server.c error: main() OPP_LOOKUP: server_LookUp() failed\n");
		}
		else {
		    reply.returnCode = 0;
		    reply.inum = ret;
		    printf("server.c success: main() OPP_LOOKUP: server_LookUp() worked!\n");
		}
		if (reply.h == 1) {
		    if (reply.type == MFS_DIRECTORY) {
			reply.h = 0;
		    }
		}
		
		//reply.returnCode = ret;
		ret = UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		break;
	    case OPP_STAT:
		printf("server.c: reply: OPP_STAT\n");
		//inum = reply->inum;
		//reply.returnCode = server_Stat(&reply);
		if ((ret = server_Stat(&reply)) < 0) {
		    reply.returnCode = -1;
		    printf("OPP_STAT UDP_Write() failed\n");
		} 
		else {
		    reply.returnCode = 0;
		}
		reply.s.type = reply.type;
		reply.s.size = reply.size;

		printf("reply.s.type %d  reply.s.size %d\n", reply.s.type, reply.s.size);
		printf("reply.type %d  reply.size %d\n", reply.type, reply.size);
		UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		break;
	    case OPP_WRITE:
		printf("server.c: reply: OPP_WRITE\n");
		//char replyBuffer[BUFFER_SIZE];
		//Putting in nbytes and reply->nbytes does not work. 
		//Have to put in BUFFER_SIZE
		/*if ((memcpy(replyBuffer, reply->buffer, nbytes)) < 0) {
		  printf("server.c error: OPP_Write memcpy() failed\n");
		  }*/
		if ((ret = server_Write(reply.inum, reply.buffer, reply.offset, reply.nbytes)) < 0) {
		    reply.returnCode = -1;
		    printf("server.c error: main() OPP_WRITE: server_Write() failed\n");
		}
		else {

		    reply.returnCode = 0;
		    printf("server.c success: main() OPP_WRITE: server_Write() worked!\n");
		}
		printf("test after return\n");
		UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		break;
	    case OPP_READ:
		printf("server.c: reply: OPP_READ\n");

		if ((ret = server_Read(reply.inum, reply.buffer, reply.offset, reply.nbytes)) < 0) {
		    reply.returnCode = -1;
		    printf("server.c error: main() OPP_READ: server_Read() failed\n");
		}
		else {

		    reply.returnCode = 0;
		    printf("server.c: reply->buffer: %s\n", reply.buffer);
		    printf("server.c success: main() OPP_READ: server_Read() worked!\n");
		}
		UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		break;
	    case OPP_CREAT:
		printf("server.c: reply: OPP_CREAT\n");
		if ((strcpy(name, reply.name)) < 0) {
		    printf("server.c error: main() OPP_CREAT: strcpy() failed\n");
		}
		if (server_Creat(reply.pinum, reply.type, reply.name) < 0) {
		    printf("server.c error: main() OPP_CREAT: server_Creat() Failed\n");
		    reply.returnCode = -1;
		}
		else {
		    reply.returnCode = 0;
		    printf("server.c success: main() OPP_CREAT: server_Creat() worked!\n");
		}

		UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		break;
	    case OPP_UNLINK:
		printf("server.c: reply: OPP_UNLINK\n");
		if ((strcpy(name, reply.name)) < 0) {
		    printf("server.c error: main() OPP_UNLINK: strcpy() failed\n");
		}

		if ((ret = server_Unlink(reply.pinum, reply.name)) < 0) {
		    reply.returnCode = -1;
		    printf("server.c error: main() OPP_UNLINK: server_Unlink() failed\n");
		}
		else {
		    reply.returnCode = 0;
		    t = 1;
		    printf("server.c success: main() OPP_UNLINK: server_Unlink() worked!\n");
		}
		UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		break;
	    case OPP_SHUTDOWN:
		printf("server.c: reply: OPP_SHUTDOWN\n");

		if ((reply.returnCode = server_Shutdown()) < 0) {
		    printf("server.c error: main() OPP_SHUTDOWN: server_Shutdown() failed\n");
		}
		else {
		    reply.returnCode = 1;
		    ret = UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
		    //printf("server.c success: main() OPP_SHUTDOWN: server_Shutdown() worked!\n");
		    exit(0);
		}
		break;
	}
	//exit(0);

	//if (debug)
	//printf("server.c:: read message [size:%d contents:(%s)]\n", rc, reply->name);
	if (rc > 0) {

	    //char reply2[BUFFER_SIZE];
	    //if (memcpy(reply2, reply, BUFFER_SIZE) < 0) {
	    //printf("server.c error: memcpy() failed\n");
	    //}

	    //char replyArr[28];
	    //sprintf(replyArr, "Sent ack to client!");
	    //sprintf(reply, "goodbye world");
	    //char *test;
	    //rc = UDP_Write(sd, &server_addr, (char *) &reply, sizeof(message));
	    if (rc < 0) {
		printf("server.c error: UDP_Write() (writing back to client) failed\n");
	    }
	    else { printf("server.c: Sending reply to client!\n\n"); }
	} 
    }
    close(fd);
    return 0; 
}
