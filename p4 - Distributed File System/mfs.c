#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/select.h>
#include <stdbool.h>

#include "mfs.h"
#include "udp.h"
#include "ufs.h"
#include "server.h"

#define BUFFER_SIZE (1000)

message msg;
struct sockaddr_in addrRcv;
struct sockaddr_in addrSnd;
char *host;
int serverPort;
int clientPort;
int sd;
int fd;
bool debug;
int ret;

// mfs.c

int sendMessage() {
    return UDP_Write(sd, &addrSnd, (char *) &msg, sizeof(message));
}

void printMessage(message m) {
    printf("Message info!\nsize: %d  inum: %d  pinum: %d  offset: %d  type: %d  nbytes: %d  returnCode: %d\n", m.size, m.inum, m.pinum, m.offset, m.type, m.nbytes, m.returnCode);
}

/*
 * Takes a host name and port number and uses those to find the server exporting the file system
 */
int MFS_Init(char *hostname, int port) {

    if (hostname == 0 || port == 0) {
	return -1;
    }
    printf("MFS_Init was called\n");
    clientPort = 5123;
    //struct sockaddr_in addrSnd;
    //struct sockaddr_in addrRcv;
    //opening up client port
    if ((sd = UDP_Open(clientPort)) < 0) {
	printf("UDP_Open failed\n");
	return -1;
    }

    host = hostname;

    //connect to the server port
    int rc;

    if ((rc = UDP_FillSockAddr(&addrSnd, hostname, port)) < 0) {
	printf("UDP_FillSockAddr failed\n");
	return -1;
    }
    return rc;
}

/*
   Takes the parent inode number (which should be the inode number of a directory) and 
   looks up the entry name in it. The inode number of name is returned. 
Success: return inode number of name; failure: return -1. 
Failure modes: invalid pinum, name does not exist in pinum.
*/
int MFS_Lookup(int pinum, char *name) {
    if (pinum < 0) {
	printf("mfs.c error: MFS_Lookup(): invalid pinum\n");
	return -1;
    }
    if (strlen(name) > 28) {
	return -1;
    }	
    debug = true;
    bzero(msg.name, 28);
    if (debug)
	printf("mfs.c MFS_Lookup() called\n");
    msg.oppNum = OPP_LOOKUP;
    msg.pinum = pinum;
    if ((memcpy(msg.name, name, strlen(name)) < 0)) {
	printf("mfs.c MFS_Lookup() error: memcpy() failed\n");
    }

    char sendmsg[sizeof(message)];
    message recMessage;
    if ((memcpy(sendmsg, (char *)&msg, sizeof(message)) < 0)) {
	printf("mfs.c error: memcpy() failed\n");
    }

    if ((ret = UDP_Write(sd, &addrSnd, (char *)&sendmsg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Lookup failed\n");
    }

    if ((memcpy(&recMessage, (message *)&sendmsg, sizeof(message)) < 0)) {
	printf("mfs.c error: MFS_Lookup(): memcpy() failed\n");
    }

    ret = UDP_Read(sd, &addrRcv, (char *) &recMessage, sizeof(message));

    if (recMessage.returnCode == -1) {
	return -1;
    }



    printf("recMessage.inum: %d  recMessage.returnCode: %d\n", recMessage.inum, recMessage.returnCode);
    return recMessage.inum; 
}

/*
   Returns some information about the file specified by inum. 
   Upon success, return 0, otherwise -1. The exact info returned is defined by MFS_Stat_t. 
   Failure modes: inum does not exist.
   */
int MFS_Stat(int inum, MFS_Stat_t *m) {
    msg.oppNum = OPP_STAT;
    msg.inum = inum;
    msg.s = *m;
    //msg.size = m->size;
    //msg.type = m->type;
    //msg.size = m->size;

    debug = true;

    if (debug)
	printf("mfs.c MFS_Stat() called\n");

    message sendmsg;
    message recMessage;
    //message ack[sizeof(message)];

    if ((memcpy((void *) &sendmsg, (void *)&msg, sizeof(message)) < 0)) {
	printf("mfs.c error: MFS_Stat(): memcpy() failed\n");
    }

    if ((ret = UDP_Write(sd, &addrSnd, (char *)&sendmsg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Stat() failed\n");
    }




    if (debug) 
	printf("mfs.c debug: Got reply: (size %d)\n", recMessage.offset);
    //ret = UDP_Read(sd, &addrRcv, (char*)&sendmsg, nbytes);
    ret = UDP_Read(sd, &addrRcv, (char *) &recMessage, sizeof(message));

    if (debug) 
	printf("print statement after udp_read in MFS_Stat()\n");
    m->size = recMessage.size;
    m->type = recMessage.type;
    if (debug) 
	printf("m->type: %d   m->size: %d recMessage.s.type: %d   recMessage.s.size: %d  sendmsg.type %d  sendmsg.size %d\n", m->type, m->size, recMessage.s.type, recMessage.s.size, sendmsg.type, sendmsg.size);

    return recMessage.returnCode; //Temporary
}

/*
   Writes a buffer of size nbytes (max size: 4096 bytes) at the byte offset specified by offset. 
   Returns 0 on success, -1 on failure. 
   Failure modes: invalid inum, invalid nbytes, invalid offset, 
   not a regular file (because you can't write to directories).
   */
int MFS_Write(int inum, char *buffer, int offset, int nbytes) {
    if (inum < 0) {
	printf("MFS_Write(): invalid inum\n");
	return -1;
    }
    if (strlen(buffer) > 4096) {
	printf("MFS_Write(): invalid buffer\n");
	return -1;
    }
    if (offset < 0) {
	printf("MFS_Write(): invalid offset\n");
	return -1;
    }

    debug = false;
    if (debug)
	printf("mfs.c debug: MFS_Write() called\n");
    if (debug)
	printf("MFS_Write debug info!\ninum: %d  offset: %d  nbytes: %d  buffer: %s\n", inum, offset, nbytes, buffer);
    msg.oppNum = OPP_WRITE;
    msg.offset = offset;
    msg.inum = inum;
    msg.nbytes = nbytes;
    
    if ((memcpy(msg.buffer, buffer, nbytes)) < 0) {
	printf("MFS_Write() error: memcpy() buffer failed\n");
	return -1;
    }

    int mfsWRet = 0;
    message recMessage;

    if (debug) printf("calling UDP_Write()\n");
    if ((mfsWRet = UDP_Write(sd, &addrSnd, (char *)&msg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Write() failed\n");
    }

    ret = UDP_Read(sd, &addrRcv, (char *) &recMessage, sizeof(message));
    return recMessage.returnCode;
}

/*
   Reads nbytes of data (max size 4096 bytes) specified by the byte offset offset into the buffer 
   from file specified by inum. The routine should work for either a file or directory; 
   directories should return data in the format specified by MFS_DirEnt_t. 
Success: 0, failure: -1. Failure modes: invalid inum, invalid offset, invalid nbytes.
*/
int MFS_Read(int inum, char *buffer, int offset, int nbytes) {
    msg.oppNum = OPP_READ;
    msg.inum = inum;
    msg.offset = offset;
    msg.nbytes = nbytes;

    debug = false;

    //char sendMsg[BUFFER_SIZE] = msg;

    int mfsWRet = 0;
    message recMessage;
    if ((mfsWRet = UDP_Write(sd, &addrSnd, (char *)&msg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Read() failed\n");
    }
    /*if ((memcpy((void *) &recMessage, (void *) &sendmsg, sizeof(message)) < 0)) {
	printf("mfs.c error: memcpy() failed\n");
    }*/

    ret = UDP_Read(sd, &addrRcv, (char *) &recMessage, sizeof(message));
    memcpy(buffer, recMessage.buffer, nbytes);
    if (debug) 
	printf("buffer: %s\n", buffer);
    return recMessage.returnCode;
}

/*
   Makes a file (type == MFS_REGULAR_FILE) or directory (type == MFSmyMessage_DIRECTORY) in the parent 
   directory specified by pinum of name name. Returns 0 on success, -1 on failure. 
   Failure modes: pinum does not exist, or name is too long. If name already exists, return success.
   */
int MFS_Creat(int pinum, int type, char *name) {
    if (strlen(name) > 28) {
	return -1;
    }	
    debug = false;
    if (debug) printf("mfs.c: MFS_Creat() called\n");
    msg.oppNum = OPP_CREAT;
    msg.size = 0;
    msg.inum = 0;
    msg.port = 0;
    msg.offset = 0;
    msg.nbytes = 0;
    msg.pinum = pinum;
    msg.type = type;
    if ((strcpy(msg.name, name) < 0)) {
	printf("mfs.c MFS_Creat() error: strcpy() failed\n");
    }

    //printMessage(msg);
    //printf("mfs.c debug: oppNum: %d   pinum: %d   type: %d   name: %s\n", msg.oppNum, msg.pinum, msg. type, msg.name);
    message recMessage;

  
    if ((ret = UDP_Write(sd, &addrSnd, (char *)&msg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Creat() failed\n");
    }

 

    if (debug) 
	printf("mfs.c debug: Got reply: (size %d)\n", recMessage.offset);

    
    //ret = UDP_Read(sd, &addrRcv, (char*)&sendmsg, nbytes);
    ret = UDP_Read(sd, &addrRcv, (void *) &recMessage, sizeof(message));
    printMessage(msg);
    return recMessage.returnCode;//TEMP
}

int MFS_Unlink(int pinum, char *name) {
    printf("mfs.c: MFS_Unlink() called!\n");
    msg.oppNum = OPP_UNLINK;
    msg.pinum = pinum;
    if ((strcpy(msg.name, name) < 0)) {
	printf("mfs.c MFS_Unlink() error: memcpy() failed\n");
    }

    message recMessage;

    if ((ret = UDP_Write(sd, &addrSnd, (char *)&msg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Unlink() failed\n");
    }

    
    ret = UDP_Read(sd, &addrRcv, (char *) &recMessage, sizeof(message));

    return recMessage.returnCode;
}

/*
   Tells the server to force all of its data structures to disk and shutdown by calling exit(0). 
   This interface will mostly be used for testing purposes.
   */
int MFS_Shutdown() {
    msg.oppNum = OPP_SHUTDOWN;
    char sendmsg[sizeof(message)];
    message recMessage;

    if ((memcpy(sendmsg, (char *)&msg, sizeof(message)) < 0)) {
	printf("mfs.c error: memcpy() failed\n");
    }

    if ((ret = UDP_Write(sd, &addrSnd, (char *)&sendmsg, sizeof(message))) < 0) {
	printf("mfs.c error: MFS_Unlink() failed\n");
    }

    if ((memcpy(&recMessage, (message *)&sendmsg, sizeof(message)) < 0)) {
	printf("mfs.c error: MFS_Unlink(): memcpy() failed\n");
    }

    ret = UDP_Read(sd, &addrRcv, (char *) &recMessage, sizeof(message));
    return 0;
    if (recMessage.reply == 1) {
	return 0;
    }
    else {
	return -1;
    }

}
