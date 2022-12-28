#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

//newely added include
#include "ufs.h"
#include "sys/stat.h"
#include <getopt.h>

void usage() {
    fprintf(stderr, "usage: mkfs -f <image_file> [-d <num_data_blocks] [-i <num_inodes>]\n");
    exit(1);
}

unsigned int get_bit(unsigned int *bitmap, int position) {
    int index = position / 32;
    int offset = 32 - (position % 32);
    return (bitmap[index] >> offset) & 0x01;
}

void set_bit(unsigned int *bitmap, int position) {
    int index = position / 32;
    int offset = 31 - (position % 32);
    bitmap[index] |= 0x01 << offset;
}

int main(int argc, char *argv[]) {
    int debug = 0;
    int ch;


    char *image_file = NULL;
    int num_inodes = 32;
    int num_data = 32;
    int visual = 1;

    while ((ch = getopt(argc, argv, "i:d:f:v")) != -1) {
	switch (ch) {
	    case 'i':
		num_inodes = atoi(optarg);
		break;
	    case 'd':
		num_data = atoi(optarg);
		break;
	    case 'f':
		image_file = optarg;
		break;
	    case 'v':
		visual = 1;
	}
    }
    argc -= optind;
    argv += optind;

    if (image_file == NULL)
	usage();

    unsigned char *empty_buffer;
    empty_buffer = calloc(UFS_BLOCK_SIZE, 1);
    if (empty_buffer == NULL) {
	perror("calloc");
	exit(1);
    }

    int fd = open(image_file, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
    if (fd < 0) {
	perror("open");
	exit(1);
    }

    assert(num_inodes >= 32);
    assert(num_data >= 32);

    // presumed: block 0 is the super block
    super_t s;

    // inode bitmap
    s.inode_bitmap_addr = 1;
    s.inode_bitmap_len = num_inodes / UFS_BLOCK_SIZE;
    if (num_inodes % UFS_BLOCK_SIZE != 0)
	s.inode_bitmap_len++;

    // data bitmap
    s.data_bitmap_addr = s.inode_bitmap_addr + s.inode_bitmap_len;
    s.data_bitmap_len = num_data / UFS_BLOCK_SIZE;
    if (num_data % UFS_BLOCK_SIZE != 0)
	s.data_bitmap_len++;

    // inode table
    s.inode_region_addr = s.data_bitmap_addr + s.data_bitmap_len;
    int total_inode_bytes = num_inodes * sizeof(inode_t);
    s.inode_region_len = total_inode_bytes / UFS_BLOCK_SIZE;
    if (total_inode_bytes % UFS_BLOCK_SIZE != 0)
	s.inode_region_len++;

    // data blocks
    s.data_region_addr = s.inode_region_addr + s.inode_region_len;
    s.data_region_len = num_data;

    int total_blocks = 1 + s.inode_bitmap_len + s.data_bitmap_len + s.inode_region_len + s.data_region_len;
    if (debug) {
	printf("s.inode_bitmap_addr: %d\n", s.inode_bitmap_addr);
	printf("s.inode_bitmap_len: %d\n", s.inode_bitmap_len);
	printf("s.data_bitmap_addr: %d\n", s.data_bitmap_addr);
	printf("s.data_bitmap_len: %d\n", s.data_bitmap_len);
	printf("s.inode_region_addr: %d\n", s.inode_region_addr);
	printf("s.inode_region_len: %d\n", s.inode_region_len);
	printf("s.data_region_addr: %d\n", s.data_region_addr);
	printf("s.data_bitmap_len: %d\n", s.data_region_len);
	printf("total_inode_bytes: %d\n", total_inode_bytes);
	printf("total_blocks: %d\n", total_blocks);
	printf("sizeof(super_t): %ld\n", sizeof(super_t));
    }

    //Size of super_t == 32
    //Number of inodes per block = 32 b/c 4096 / 128 (sizeof(block) / sizeof(inode))

    // super block is the first block
    //
    // pwrite(int fd, const void *buffer, size_t count, off_t offset)
    // pwrite() writes up to count # of bytes from buffer to fd, starting at offset.
    int rc = pwrite(fd, &s, sizeof(super_t), 0);
    if (rc != sizeof(super_t)) {
	perror("write");
	exit(1);
    }

    printf("total blocks        %d\n", total_blocks);
    printf("  inodes            %d [size of each: %lu]\n", num_inodes, sizeof(inode_t));
    printf("  data blocks       %d\n", num_data);
    printf("layout details\n");
    printf("  inode bitmap address/len %d [%d]\n", s.inode_bitmap_addr, s.inode_bitmap_len);
    printf("  data bitmap address/len  %d [%d]\n", s.data_bitmap_addr, s.data_bitmap_len);

    // first, zero out all the blocks
    int i;
    for (i = 1; i < total_blocks; i++) {
	//We are writing zero into the blocks 4KB at a time.
	rc = pwrite(fd, empty_buffer, UFS_BLOCK_SIZE, i * UFS_BLOCK_SIZE);
	if (rc != UFS_BLOCK_SIZE) {
	    perror("write");
	    exit(1);
	}
    }
    printf("empty_buffer: %s\n", empty_buffer);

    //
    // need to allocate first inode in inode bitmap
    //
    typedef struct {
	unsigned int bits[UFS_BLOCK_SIZE / sizeof(unsigned int)];//4096 / 4 = 1024
    } bitmap_t;
    assert(sizeof(bitmap_t) == UFS_BLOCK_SIZE);

    bitmap_t b;
    for (i = 0; i < 1024; i++)
	b.bits[i] = 0;
    b.bits[0] = 0x80000000; // first entry is allocated
			    //Why is this 0x80000000? 10000000... in binary
    //Bits are written at 4096 or block 1.
    rc = pwrite(fd, &b, UFS_BLOCK_SIZE, s.inode_bitmap_addr * UFS_BLOCK_SIZE);
    assert(rc == UFS_BLOCK_SIZE);

    //
    // need to allocate first data block in data bitmap
    // (can just reuse this to write out data bitmap too)
    // Not sure why the same address for bits is passed into pwrite() here
    // Is the inode and data bitmaps shared? 
    // s.data_bitmap_addr = 2. So this will be stored at 8192 or block 2.
    rc = pwrite(fd, &b, UFS_BLOCK_SIZE, s.data_bitmap_addr * UFS_BLOCK_SIZE);
    assert(rc == UFS_BLOCK_SIZE);

    //
    // need to write out inode
    //
    typedef struct {
	inode_t inodes[UFS_BLOCK_SIZE / sizeof(inode_t)];
	//sizeof(inode_t) = 128. 4096 / 128 = 32
	//Size of this struct should be 4096 b/c 32 * 128
    } inode_block;

    inode_block itable;
    itable.inodes[0].type = UFS_DIRECTORY;
    itable.inodes[0].size = sizeof(dir_ent_t); // in bytes
    itable.inodes[0].direct[0] = s.data_region_addr;
    for (i = 1; i < DIRECT_PTRS; i++)//initializing the pointers to -1.
	itable.inodes[0].direct[i] = -1;

    // s.inode_region_addr = 3. The inode table is written at 12,288, or block 3.
    rc = pwrite(fd, &itable, UFS_BLOCK_SIZE, s.inode_region_addr * UFS_BLOCK_SIZE);
    assert(rc == UFS_BLOCK_SIZE);

    // 
    // need to write out root directory contents to first data block
    // create a root directory, with nothing in it
    // 
    typedef struct {
	dir_ent_t entries[128];
	//sizeof(dir_ent_t) == 32. 32 * 128 = 4096
    } dir_block_t;
    // xxx assumes 4096 block, 32 byte entries
    assert(sizeof(dir_ent_t) * 128 == UFS_BLOCK_SIZE);

    dir_block_t parent;
    strcpy(parent.entries[0].name, ".");
    parent.entries[0].inum = 0;
    //Refers to this new inode number

    strcpy(parent.entries[1].name, "..");
    parent.entries[1].inum = 0;
    //Refers tp the inodes parent directory's inode number

    for (i = 2; i < 128; i++)
	parent.entries[i].inum = -1;

    // Whats interesting (potentially I screwed up the #inode and #datablock inputs) 
    // is that s.data_region_addr is 8. So this will be starting at 32,768, or block 8.
    // No idea what block 4 - 7 are being used for.
    rc = pwrite(fd, &parent, UFS_BLOCK_SIZE, s.data_region_addr * UFS_BLOCK_SIZE);
    assert(rc == UFS_BLOCK_SIZE);

    if (visual) {
	int i;
	printf("\nVisualization of layout\n\n");
	printf("S");
	for (i = 0; i < s.inode_bitmap_len; i++)
	    printf("i");
	for (i = 0; i < s.data_bitmap_len; i++)
	    printf("d");
	for (i = 0; i < s.inode_region_len; i++)
	    printf("I");
	for (i = 0; i < s.data_region_len; i++)
	    printf("D");
	printf("\n\n");
    }

    (void) fsync(fd);
    (void) close(fd);

    return 0;
}

