#include <stdio.h>
#include "mfs.h"
#include "udp.h"
#include "ufs.h"
#include "server.h"
#include "client.h"
#include <stdbool.h>
#define BUFFER_SIZE (1000)

// client.c

bool debug;

int main(int argc, char *argv[]) {
    int port = atoi(argv[1]);
    //char *fileName = argv[2];
    debug = false;
    //struct sockaddr_in addrRcv;
    //struct sockaddr_in addrSnd;//Unsure if this is needed
    if (debug)
	printf("client.c debug: port: %d   fileName: %s\n", port, argv[2]);


    char *localHost = "127.0.0.1";
    
    
    int sd;
    if ((sd = MFS_Init(localHost, port) < 0)) {
	printf("client.c error: MFS_Init() failed\n");
	exit(0);
    }//DONT COMMENT
     
    char name[28] = "testdir";
    int pinum = 0;
    int type = MFS_REGULAR_FILE;
    if (MFS_Creat(pinum, type, name) < 0) {
	printf("client.c: MFS_Creat() failed\n");
    }
    else {
	printf("client.c: MFS_Creat() worked!\n");
    }
	

    int inum = MFS_Lookup(pinum, name);
    


    if (MFS_Lookup(pinum, "testfile") < 0) {
	printf("client.c: MFS_Lookup() failed\n");
    }
    else {
	printf("client.c: MFS_Lookup() worked!\n");
    }


	
    /*
    int pinum = 0;
    char name[28] = "testdir";
    int type = MFS_REGULAR_FILE;
    if (MFS_Creat(pinum, type, name) < 0) {
	printf("client.c: MFS_Creat() failed\n");
    }
    else {
	printf("client.c: MFS_Creat() worked!\n");
    }


    char name2[28] = "testfile";
    int inum = MFS_Lookup(pinum, name);

    if (MFS_Lookup(inum, name2) < 0) {
	printf("client.c: MFS_Lookup() failed\n");
    }
    else {
	printf("client.c: MFS_Lookup() worked!\n");
    }*/

    /*
    int creatRet = 0;
    char name[28] = "test";
    int pinum = 0;
    int type = MFS_REGULAR_FILE;
    if ((creatRet = MFS_Creat(pinum, type, name) < 0)) {
	printf("client.c error: MFS_Creat() failed\n");
    }
    else {
	printf("client.c: MFS_Creat() worked!\n");
    }

    int inum = MFS_Lookup(pinum, name);

    char name2[28] = "testfile";
    char buffer[4096];
    for(int i = 0; i < 6; i++) {
      buffer[i] = 's';
    }
    for(int i = 4092; i < 4096; i++) {
      buffer[i] = 'e';
    }	
    char read[4096];
    int offset = 0;

    for (int i = 0; i < DIRECT_PTRS; i++) {
	if ((MFS_Write(inum, buffer, i * UFS_BLOCK_SIZE, UFS_BLOCK_SIZE) < 0)) {
	    printf("client.c error: MFS_Write() failed. i: %d\n", i);
	}
	else {
	    printf("client.c: MFS_Write() worked!\n");
	}


	char buffer2[4096];

    }
    for (int i = 0; i < 30; i++) {
      	if ((MFS_Read(inum, read, i * UFS_BLOCK_SIZE, UFS_BLOCK_SIZE) < 0)) {
	    printf("client.c error: MFS_Read() failed. i: %d\n", i);
	}
	else {
	    printf("client.c: MFS_Read() worked!\n");
	}
        if (strncmp(read, buffer, 4096) != 0) {
	    printf("read != buffer\n");
	} 
	else {
	    printf("were good\n");
	}

    }*/




    /*  int pinum = 0;
	int type = MFS_REGULAR_FILE;
	int creatRet = 0;
	char dirName[28] = "test";
    //char readMessage[BUFFER_SIZE];
    if ((creatRet = MFS_Creat(pinum, type, dirName) < 0)) {
    printf("client.c error: MFS_Creat() failed\n");
    }
    else {
    printf("client.c: MFS_Creat() worked!\n");
    }

    int inum = MFS_Lookup(pinum, dirName);
    printf("dir test is in inum:%d\n", inum);
    //int inum = 3;
    char buffer[4096] = "You are reading the contents of my new file!";
    int nbytes = 4096;
    int offset = 0;
    if (MFS_Write(inum, buffer, offset, nbytes) < 0) {
    printf("client.c error: MFS_Write() failed\n");
    }
    else {
    printf("client.c: MFS_Write() worked!\n");
    }	


    char reply[4096];
    if (MFS_Read(inum, reply, offset, nbytes) < 0) {
    printf("client.c error: MFS_Read() failed\n");
    }
    else {
    printf("client.c: MFS_Read() worked!\n");
    }

    printf("reply: %s\n", reply);

    MFS_Stat_t stat;
    inum = 0;
    stat.size = 0;
    stat.type = MFS_REGULAR_FILE;
    if (MFS_Stat(inum, &stat) < 0) {
    printf("client.c error: MFS_Stat() failed\n");
    }
    else {
    printf("client.c: MFS_Stat worked!\n");
    }
    printf("stat->size: %d   stat->type: %d\n", stat.size, stat.type);
    */
    /*
       pinum = 2;
       if (MFS_Unlink(pinum, dirname4) < 0) {
       printf("client.c: MFS_Unlink() failed\n");
       }
       else {
       printf("client.c: MFS_Unlink() worked!\n");
       }*/








    /*
       printf("\n");

       type = MFS_REGULAR_FILE;
       int inum = 1;
    //char fileName[28] = "NEWFILE";
    char buffer[44] = "You are reading the contents of my new file!";
    printf("%ld\n", strlen(buffer));
    int nbytes = 44;
    int offset = 0;
    if (MFS_Write(inum, buffer, offset, nbytes) < 0) {
    printf("client.c error: MFS_Write() failed\n");
    }	 
    */    
    /*
       int unlinkRet = 0;
       if ((unlinkRet = MFS_Unlink(pinum, dirName)) < 0) {
       printf("client.c error: MFS_Unlink() failed\n");
       }
       */





    /*char newDirname[28] = "Hello World!";
      if ((creatRet = MFS_Creat(1, MFS_DIRECTORY, newDirname) < 0)) {
      printf("client.c error: MFS_Creat() failed\n");
      }*/


    /* 
       pinum = 0;
       type = MFS_REGULAR_FILE;
       char file[28] = "New File";
    //char readMessage[BUFFER_SIZE];
    if ((creatRet = MFS_Creat(pinum, type, file) < 0)) {
    printf("client.c error: MFS_Creat() failed\n");
    }

    char myMessage[100] = "HELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLOHELLODONE";
    printf("%ld\n", strlen(myMessage));
    int numBytes = 100;
    //char *hello;
    printf("client.c: Sending Message!\n");
    int inum = 1;
    int offset = 0; 
    //int nbytes = sizeof(message);
    int mfsWRet = 0;
    if ((mfsWRet = MFS_Write(inum, myMessage, offset, numBytes)) < 0) {
    printf("client.c error: MFS_Write() failed\n");
    //exit(0);
    }

    int lookupRet = 0;
    pinum = 0;
    if ((lookupRet = MFS_Lookup(pinum, fileName)) < 0) {
    printf("client.c error: MFS_Lookup() failed\n");
    //exit(0);
    }
    */


    /*int shutdownRet = 0;
      if ((shutdownRet = MFS_Shutdown() < 0)) {
      printf("client.c error: MFS_Shutdown() failed\n");
      }*/

    /*

       pinum = 0;
       type = MFS_REGULAR_FILE;
       char newFileName[28] = "New File";
       if ((creatRet = MFS_Creat(pinum, type, newFileName) < 0)) {
       printf("client.c error: MFS_Creat() failed\n");
       }
       */


    /*
       char myMessage[BUFFER_SIZE];
    //char *hello;
    printf("client.c: Sending Message!\n");
    int inum = 1;
    int offset = 0; 
    //int nbytes = sizeof(message);
    int mfsWRet = 0;
    if ((mfsWRet = MFS_Write(inum, myMessage, offset, BUFFER_SIZE)) < 0) {
    printf("client.c error: MFS_Write() failed\n");
    //exit(0);
    }

    int lookupRet = 0;
    int pinum = 0;
    if ((lookupRet = MFS_Lookup(pinum, fileName)) < 0) {
    printf("client.c error: MFS_Lookup() failed\n");
    //exit(0);
    }

    int type = MFS_DIRECTORY;
    int size = BUFFER_SIZE;
    MFS_Stat_t stat;
    stat.size = size;
    stat.type = type;
    int statRet = 0;
    if ((statRet = MFS_Stat(inum, &stat)) < 0) {
    printf("client.c error: MFS_Stat() failed\n");
    }

    int readRet = 0;
    char readMessage[BUFFER_SIZE];
    if ((readRet = MFS_Read(inum, readMessage, offset, BUFFER_SIZE) < 0)) {
    printf("client.c error: MFS_Read() failed\n");
    }



    int unlinkRet = 0;
    //char readMessage[BUFFER_SIZE];
    if ((unlinkRet = MFS_Unlink(pinum, name) < 0)) {
    printf("client.c error: MFS_Unlink() failed\n");
    }

    int shutdownRet = 0;
    if ((shutdownRet = MFS_Shutdown(pinum, name) < 0)) {
    printf("client.c error: MFS_Unlink() failed\n");
    }
    */

    printf("client.c: Done sending requests!\n");
    //printf("client.c: calling UDP_Read()\n");
    /*if ((ret = UDP_Read(sd, &addrRcv, myMessage, nbytes)) < 0) {
      printf("client.c error: UDP_Read() failed. ret: %d\n", ret);
      exit(0);
      }*/
    //printf("client.c: Got reply: (size %d contents: %s)\n", ret, myMessage);

    /*int mfsCreatRet = 0;
      if ((mfsCreatRet = MFS_Creat(100, MFS_REGULAR_FILE, "newFile") < 0)) {
      printf("client.c error: MFS_Creat() failed\n");
      exit(0);
      }

      ret = 0;
      if ((ret = UDP_Read(sd, &addrRcv, myMessage, BUFFER_SIZE)) < 0) {
      printf("client.c error: UDP_Read() failed\n");
      exit(0);
      }*/


    //printf("client.c: Got reply: (size %d contents: %s)\n", ret, myMessage);

    return 0;
}
