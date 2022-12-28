#ifndef __MFS_h__
#define __MFS_h__

#define MFS_DIRECTORY    (0)
#define MFS_REGULAR_FILE (1)

#define MFS_BLOCK_SIZE   (4096)
#define MFS_NAME_LEN     (28)
#define MFS_STAT_SIZE    (8)

#define BUFFER_SIZE      (1000)

typedef struct __MFS_Stat_t {
    int type;   // MFS_DIRECTORY or MFS_REGULAR
    int size;   // bytes
    // note: no permissions, access times, etc.
} MFS_Stat_t;

typedef struct __MFS_DirEnt_t {
    char name[28];  // up to 28 bytes of name in directory (including \0)
    int  inum;      // inode number of entry (-1 means entry not used)
} MFS_DirEnt_t;

typedef struct {
    unsigned int bits[MFS_BLOCK_SIZE / sizeof(unsigned int)];
} bitmap_t;

typedef enum {
    OPP_INIT,
    OPP_LOOKUP,
    OPP_STAT,
    OPP_WRITE,
    OPP_READ,
    OPP_CREAT,
    OPP_UNLINK,
    OPP_SHUTDOWN,
} MFS_OPP;

typedef struct {
    MFS_OPP oppNum;
    int size;
    int inum;
    int pinum;
    int port;
    int offset;
    int type;
    int nbytes;
    int reply;
    int returnCode;
    int t;
    int h;
    MFS_Stat_t s;
    char name[28];
    char buffer[MFS_BLOCK_SIZE];
} message;


int MFS_Init(char *hostname, int port);
int MFS_Lookup(int pinum, char *name);
int MFS_Stat(int inum, MFS_Stat_t *m);
int MFS_Write(int inum, char *buffer, int offset, int nbytes);
int MFS_Read(int inum, char *buffer, int offset, int nbytes);
int MFS_Creat(int pinum, int type, char *name);
int MFS_Unlink(int pinum, char *name);
int MFS_Shutdown();

#endif // __MFS_h__
