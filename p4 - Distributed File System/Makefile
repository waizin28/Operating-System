CFLAGS := -g
IMGFGS := -f -i -d 
SRCS   := server.c \
#	  mfs.c \
#	  mkfs.c \
#	  client.c

LD_LIBRARY_PATH:=/home/cari/private/CS537/Projects/p4
export LD_LIBRARY_PATH

OBJS   := ${SRCS:c=o}
PROGS  := ${SRCS:.c=}
LIBPTH := LD_LIBRARY_PATH

INODES := 32
DATA   := 32
IMAGE  := test.img
PORT   := 11011
CLIENTPORT := 11011

.PHONY: all
all: ${PROGS} obj lib exe mkfs mfscli mkfsrun

${PROGS} : % : %.o Makefile
	${CC} $(CFLAGS) $< -o $@ udp.c
run:
	server ${PORT} ${IMAGE}
clean:
	rm -f ${PROGS} ${OBJS}
	rm udp.o
	rm mfs.o
	rm *.so
	rm client
	rm mkfs
conn:
	./client ${PORT} ${IMAGE}
%.o: %.c Makefile
	${CC} $(CFLAGS) -c $<
mkfsrun: 
	./mkfs -f ${IMAGE} -i ${INODES} -d ${DATA} 
mfscli: mfscli.c libmfs.so
	$(CC) $(CFLAGS) -L. -o mfscli mfscli.c -Wall libmfs.so 
mkfs: mkfs.c
	$(CC) $(CFLAGS) -o mkfs mkfs.c 
exe: libmfs.so
	$(CC) $(CFLAGS) -L. -o client client.c -Wall libmfs.so 
lib: mfs.o udp.o
	$(CC) $(CFLAGS) -shared -o libmfs.so mfs.o udp.o 

obj: mfs.c udp.c server.c
	$(CC) $(CFLAGS) -c -fpic mfs.c -Wall
	$(CC) $(CFLAGS) -c -fpic udp.c -Wall
	$(CC) $(CFLAGS) -c -fpic server.c -Wall

test:
	sh ~cs537-1/tests/p4/p4-test/runtests.sh -t 1
test4:
	sh ~cs537-1/tests/p4/p4-test/runtests.sh -t 15
testall:
	sh ~cs537-1/tests/p4/p4-test/runtests.sh -c


