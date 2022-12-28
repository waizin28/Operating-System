#ifndef __SERVER_h__
#define __SERVER_h__

extern int fd;
extern int serverPort;
extern struct sockaddr_in server_addr;
//helper functions
void intHandler(int dummy);
unsigned int get_bit(unsigned int *bitmap, int position);
void set_bit(unsigned int *bitmap, int position);

int server_Init(char *imgFile);
int server_LookUp(int pinum, char *name);
int server_Stat(message *m);
int server_Write(int inum, char *buffer, int offset, int nbytes);
int server_Read(int inum, char *buffer, int offset, int nbytes);
int server_Creat(int pinum, int type, char *name);
int server_Unlink(int pinum, char *name);
int server_Shutdown();

#endif // __SERVER_h__
