
_test_17:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "user.h"
#define PGSIZE 4096


int 
main(void){
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
    const uint PAGES_NUM = 5;
    
    // Allocate 5 pages
    char *ptr = sbrk(PGSIZE * PAGES_NUM * sizeof(char));
    100f:	83 ec 0c             	sub    $0xc,%esp
    1012:	68 00 50 00 00       	push   $0x5000
    1017:	e8 5a 02 00 00       	call   1276 <sbrk>
    101c:	89 c3                	mov    %eax,%ebx
    mprotect(ptr, PAGES_NUM);
    101e:	83 c4 08             	add    $0x8,%esp
    1021:	6a 05                	push   $0x5
    1023:	50                   	push   %eax
    1024:	e8 75 02 00 00       	call   129e <mprotect>
    munprotect(ptr, PAGES_NUM);
    1029:	83 c4 08             	add    $0x8,%esp
    102c:	6a 05                	push   $0x5
    102e:	53                   	push   %ebx
    102f:	e8 72 02 00 00       	call   12a6 <munprotect>
    
    ptr[PGSIZE * 1] = 0xAA;
    1034:	c6 83 00 10 00 00 aa 	movb   $0xaa,0x1000(%ebx)
    printf(1, "XV6_TEST_OUTPUT TEST PASS\n");
    103b:	83 c4 08             	add    $0x8,%esp
    103e:	68 00 16 00 00       	push   $0x1600
    1043:	6a 01                	push   $0x1
    1045:	e8 09 03 00 00       	call   1353 <printf>

    exit();
    104a:	e8 9f 01 00 00       	call   11ee <exit>

0000104f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    104f:	55                   	push   %ebp
    1050:	89 e5                	mov    %esp,%ebp
    1052:	56                   	push   %esi
    1053:	53                   	push   %ebx
    1054:	8b 75 08             	mov    0x8(%ebp),%esi
    1057:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    105a:	89 f0                	mov    %esi,%eax
    105c:	89 d1                	mov    %edx,%ecx
    105e:	83 c2 01             	add    $0x1,%edx
    1061:	89 c3                	mov    %eax,%ebx
    1063:	83 c0 01             	add    $0x1,%eax
    1066:	0f b6 09             	movzbl (%ecx),%ecx
    1069:	88 0b                	mov    %cl,(%ebx)
    106b:	84 c9                	test   %cl,%cl
    106d:	75 ed                	jne    105c <strcpy+0xd>
    ;
  return os;
}
    106f:	89 f0                	mov    %esi,%eax
    1071:	5b                   	pop    %ebx
    1072:	5e                   	pop    %esi
    1073:	5d                   	pop    %ebp
    1074:	c3                   	ret    

00001075 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1075:	55                   	push   %ebp
    1076:	89 e5                	mov    %esp,%ebp
    1078:	8b 4d 08             	mov    0x8(%ebp),%ecx
    107b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    107e:	eb 06                	jmp    1086 <strcmp+0x11>
    p++, q++;
    1080:	83 c1 01             	add    $0x1,%ecx
    1083:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1086:	0f b6 01             	movzbl (%ecx),%eax
    1089:	84 c0                	test   %al,%al
    108b:	74 04                	je     1091 <strcmp+0x1c>
    108d:	3a 02                	cmp    (%edx),%al
    108f:	74 ef                	je     1080 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1091:	0f b6 c0             	movzbl %al,%eax
    1094:	0f b6 12             	movzbl (%edx),%edx
    1097:	29 d0                	sub    %edx,%eax
}
    1099:	5d                   	pop    %ebp
    109a:	c3                   	ret    

0000109b <strlen>:

uint
strlen(const char *s)
{
    109b:	55                   	push   %ebp
    109c:	89 e5                	mov    %esp,%ebp
    109e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10a1:	b8 00 00 00 00       	mov    $0x0,%eax
    10a6:	eb 03                	jmp    10ab <strlen+0x10>
    10a8:	83 c0 01             	add    $0x1,%eax
    10ab:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10af:	75 f7                	jne    10a8 <strlen+0xd>
    ;
  return n;
}
    10b1:	5d                   	pop    %ebp
    10b2:	c3                   	ret    

000010b3 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10b3:	55                   	push   %ebp
    10b4:	89 e5                	mov    %esp,%ebp
    10b6:	57                   	push   %edi
    10b7:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10ba:	89 d7                	mov    %edx,%edi
    10bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c2:	fc                   	cld    
    10c3:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c5:	89 d0                	mov    %edx,%eax
    10c7:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10ca:	c9                   	leave  
    10cb:	c3                   	ret    

000010cc <strchr>:

char*
strchr(const char *s, char c)
{
    10cc:	55                   	push   %ebp
    10cd:	89 e5                	mov    %esp,%ebp
    10cf:	8b 45 08             	mov    0x8(%ebp),%eax
    10d2:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10d6:	eb 03                	jmp    10db <strchr+0xf>
    10d8:	83 c0 01             	add    $0x1,%eax
    10db:	0f b6 10             	movzbl (%eax),%edx
    10de:	84 d2                	test   %dl,%dl
    10e0:	74 06                	je     10e8 <strchr+0x1c>
    if(*s == c)
    10e2:	38 ca                	cmp    %cl,%dl
    10e4:	75 f2                	jne    10d8 <strchr+0xc>
    10e6:	eb 05                	jmp    10ed <strchr+0x21>
      return (char*)s;
  return 0;
    10e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10ed:	5d                   	pop    %ebp
    10ee:	c3                   	ret    

000010ef <gets>:

char*
gets(char *buf, int max)
{
    10ef:	55                   	push   %ebp
    10f0:	89 e5                	mov    %esp,%ebp
    10f2:	57                   	push   %edi
    10f3:	56                   	push   %esi
    10f4:	53                   	push   %ebx
    10f5:	83 ec 1c             	sub    $0x1c,%esp
    10f8:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10fb:	bb 00 00 00 00       	mov    $0x0,%ebx
    1100:	89 de                	mov    %ebx,%esi
    1102:	83 c3 01             	add    $0x1,%ebx
    1105:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1108:	7d 2e                	jge    1138 <gets+0x49>
    cc = read(0, &c, 1);
    110a:	83 ec 04             	sub    $0x4,%esp
    110d:	6a 01                	push   $0x1
    110f:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1112:	50                   	push   %eax
    1113:	6a 00                	push   $0x0
    1115:	e8 ec 00 00 00       	call   1206 <read>
    if(cc < 1)
    111a:	83 c4 10             	add    $0x10,%esp
    111d:	85 c0                	test   %eax,%eax
    111f:	7e 17                	jle    1138 <gets+0x49>
      break;
    buf[i++] = c;
    1121:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1125:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1128:	3c 0a                	cmp    $0xa,%al
    112a:	0f 94 c2             	sete   %dl
    112d:	3c 0d                	cmp    $0xd,%al
    112f:	0f 94 c0             	sete   %al
    1132:	08 c2                	or     %al,%dl
    1134:	74 ca                	je     1100 <gets+0x11>
    buf[i++] = c;
    1136:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1138:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    113c:	89 f8                	mov    %edi,%eax
    113e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1141:	5b                   	pop    %ebx
    1142:	5e                   	pop    %esi
    1143:	5f                   	pop    %edi
    1144:	5d                   	pop    %ebp
    1145:	c3                   	ret    

00001146 <stat>:

int
stat(const char *n, struct stat *st)
{
    1146:	55                   	push   %ebp
    1147:	89 e5                	mov    %esp,%ebp
    1149:	56                   	push   %esi
    114a:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    114b:	83 ec 08             	sub    $0x8,%esp
    114e:	6a 00                	push   $0x0
    1150:	ff 75 08             	push   0x8(%ebp)
    1153:	e8 d6 00 00 00       	call   122e <open>
  if(fd < 0)
    1158:	83 c4 10             	add    $0x10,%esp
    115b:	85 c0                	test   %eax,%eax
    115d:	78 24                	js     1183 <stat+0x3d>
    115f:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1161:	83 ec 08             	sub    $0x8,%esp
    1164:	ff 75 0c             	push   0xc(%ebp)
    1167:	50                   	push   %eax
    1168:	e8 d9 00 00 00       	call   1246 <fstat>
    116d:	89 c6                	mov    %eax,%esi
  close(fd);
    116f:	89 1c 24             	mov    %ebx,(%esp)
    1172:	e8 9f 00 00 00       	call   1216 <close>
  return r;
    1177:	83 c4 10             	add    $0x10,%esp
}
    117a:	89 f0                	mov    %esi,%eax
    117c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    117f:	5b                   	pop    %ebx
    1180:	5e                   	pop    %esi
    1181:	5d                   	pop    %ebp
    1182:	c3                   	ret    
    return -1;
    1183:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1188:	eb f0                	jmp    117a <stat+0x34>

0000118a <atoi>:

int
atoi(const char *s)
{
    118a:	55                   	push   %ebp
    118b:	89 e5                	mov    %esp,%ebp
    118d:	53                   	push   %ebx
    118e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1191:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1196:	eb 10                	jmp    11a8 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1198:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    119b:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    119e:	83 c1 01             	add    $0x1,%ecx
    11a1:	0f be c0             	movsbl %al,%eax
    11a4:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11a8:	0f b6 01             	movzbl (%ecx),%eax
    11ab:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11ae:	80 fb 09             	cmp    $0x9,%bl
    11b1:	76 e5                	jbe    1198 <atoi+0xe>
  return n;
}
    11b3:	89 d0                	mov    %edx,%eax
    11b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11b8:	c9                   	leave  
    11b9:	c3                   	ret    

000011ba <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11ba:	55                   	push   %ebp
    11bb:	89 e5                	mov    %esp,%ebp
    11bd:	56                   	push   %esi
    11be:	53                   	push   %ebx
    11bf:	8b 75 08             	mov    0x8(%ebp),%esi
    11c2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11c5:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11c8:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11ca:	eb 0d                	jmp    11d9 <memmove+0x1f>
    *dst++ = *src++;
    11cc:	0f b6 01             	movzbl (%ecx),%eax
    11cf:	88 02                	mov    %al,(%edx)
    11d1:	8d 49 01             	lea    0x1(%ecx),%ecx
    11d4:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11d7:	89 d8                	mov    %ebx,%eax
    11d9:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11dc:	85 c0                	test   %eax,%eax
    11de:	7f ec                	jg     11cc <memmove+0x12>
  return vdst;
}
    11e0:	89 f0                	mov    %esi,%eax
    11e2:	5b                   	pop    %ebx
    11e3:	5e                   	pop    %esi
    11e4:	5d                   	pop    %ebp
    11e5:	c3                   	ret    

000011e6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11e6:	b8 01 00 00 00       	mov    $0x1,%eax
    11eb:	cd 40                	int    $0x40
    11ed:	c3                   	ret    

000011ee <exit>:
SYSCALL(exit)
    11ee:	b8 02 00 00 00       	mov    $0x2,%eax
    11f3:	cd 40                	int    $0x40
    11f5:	c3                   	ret    

000011f6 <wait>:
SYSCALL(wait)
    11f6:	b8 03 00 00 00       	mov    $0x3,%eax
    11fb:	cd 40                	int    $0x40
    11fd:	c3                   	ret    

000011fe <pipe>:
SYSCALL(pipe)
    11fe:	b8 04 00 00 00       	mov    $0x4,%eax
    1203:	cd 40                	int    $0x40
    1205:	c3                   	ret    

00001206 <read>:
SYSCALL(read)
    1206:	b8 05 00 00 00       	mov    $0x5,%eax
    120b:	cd 40                	int    $0x40
    120d:	c3                   	ret    

0000120e <write>:
SYSCALL(write)
    120e:	b8 10 00 00 00       	mov    $0x10,%eax
    1213:	cd 40                	int    $0x40
    1215:	c3                   	ret    

00001216 <close>:
SYSCALL(close)
    1216:	b8 15 00 00 00       	mov    $0x15,%eax
    121b:	cd 40                	int    $0x40
    121d:	c3                   	ret    

0000121e <kill>:
SYSCALL(kill)
    121e:	b8 06 00 00 00       	mov    $0x6,%eax
    1223:	cd 40                	int    $0x40
    1225:	c3                   	ret    

00001226 <exec>:
SYSCALL(exec)
    1226:	b8 07 00 00 00       	mov    $0x7,%eax
    122b:	cd 40                	int    $0x40
    122d:	c3                   	ret    

0000122e <open>:
SYSCALL(open)
    122e:	b8 0f 00 00 00       	mov    $0xf,%eax
    1233:	cd 40                	int    $0x40
    1235:	c3                   	ret    

00001236 <mknod>:
SYSCALL(mknod)
    1236:	b8 11 00 00 00       	mov    $0x11,%eax
    123b:	cd 40                	int    $0x40
    123d:	c3                   	ret    

0000123e <unlink>:
SYSCALL(unlink)
    123e:	b8 12 00 00 00       	mov    $0x12,%eax
    1243:	cd 40                	int    $0x40
    1245:	c3                   	ret    

00001246 <fstat>:
SYSCALL(fstat)
    1246:	b8 08 00 00 00       	mov    $0x8,%eax
    124b:	cd 40                	int    $0x40
    124d:	c3                   	ret    

0000124e <link>:
SYSCALL(link)
    124e:	b8 13 00 00 00       	mov    $0x13,%eax
    1253:	cd 40                	int    $0x40
    1255:	c3                   	ret    

00001256 <mkdir>:
SYSCALL(mkdir)
    1256:	b8 14 00 00 00       	mov    $0x14,%eax
    125b:	cd 40                	int    $0x40
    125d:	c3                   	ret    

0000125e <chdir>:
SYSCALL(chdir)
    125e:	b8 09 00 00 00       	mov    $0x9,%eax
    1263:	cd 40                	int    $0x40
    1265:	c3                   	ret    

00001266 <dup>:
SYSCALL(dup)
    1266:	b8 0a 00 00 00       	mov    $0xa,%eax
    126b:	cd 40                	int    $0x40
    126d:	c3                   	ret    

0000126e <getpid>:
SYSCALL(getpid)
    126e:	b8 0b 00 00 00       	mov    $0xb,%eax
    1273:	cd 40                	int    $0x40
    1275:	c3                   	ret    

00001276 <sbrk>:
SYSCALL(sbrk)
    1276:	b8 0c 00 00 00       	mov    $0xc,%eax
    127b:	cd 40                	int    $0x40
    127d:	c3                   	ret    

0000127e <sleep>:
SYSCALL(sleep)
    127e:	b8 0d 00 00 00       	mov    $0xd,%eax
    1283:	cd 40                	int    $0x40
    1285:	c3                   	ret    

00001286 <uptime>:
SYSCALL(uptime)
    1286:	b8 0e 00 00 00       	mov    $0xe,%eax
    128b:	cd 40                	int    $0x40
    128d:	c3                   	ret    

0000128e <settickets>:
SYSCALL(settickets)
    128e:	b8 16 00 00 00       	mov    $0x16,%eax
    1293:	cd 40                	int    $0x40
    1295:	c3                   	ret    

00001296 <getpinfo>:
SYSCALL(getpinfo)
    1296:	b8 17 00 00 00       	mov    $0x17,%eax
    129b:	cd 40                	int    $0x40
    129d:	c3                   	ret    

0000129e <mprotect>:
SYSCALL(mprotect)
    129e:	b8 18 00 00 00       	mov    $0x18,%eax
    12a3:	cd 40                	int    $0x40
    12a5:	c3                   	ret    

000012a6 <munprotect>:
    12a6:	b8 19 00 00 00       	mov    $0x19,%eax
    12ab:	cd 40                	int    $0x40
    12ad:	c3                   	ret    

000012ae <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12ae:	55                   	push   %ebp
    12af:	89 e5                	mov    %esp,%ebp
    12b1:	83 ec 1c             	sub    $0x1c,%esp
    12b4:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12b7:	6a 01                	push   $0x1
    12b9:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12bc:	52                   	push   %edx
    12bd:	50                   	push   %eax
    12be:	e8 4b ff ff ff       	call   120e <write>
}
    12c3:	83 c4 10             	add    $0x10,%esp
    12c6:	c9                   	leave  
    12c7:	c3                   	ret    

000012c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12c8:	55                   	push   %ebp
    12c9:	89 e5                	mov    %esp,%ebp
    12cb:	57                   	push   %edi
    12cc:	56                   	push   %esi
    12cd:	53                   	push   %ebx
    12ce:	83 ec 2c             	sub    $0x2c,%esp
    12d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12d4:	89 d0                	mov    %edx,%eax
    12d6:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12dc:	0f 95 c1             	setne  %cl
    12df:	c1 ea 1f             	shr    $0x1f,%edx
    12e2:	84 d1                	test   %dl,%cl
    12e4:	74 44                	je     132a <printint+0x62>
    neg = 1;
    x = -xx;
    12e6:	f7 d8                	neg    %eax
    12e8:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12ea:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12f1:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12f6:	89 c8                	mov    %ecx,%eax
    12f8:	ba 00 00 00 00       	mov    $0x0,%edx
    12fd:	f7 f6                	div    %esi
    12ff:	89 df                	mov    %ebx,%edi
    1301:	83 c3 01             	add    $0x1,%ebx
    1304:	0f b6 92 7c 16 00 00 	movzbl 0x167c(%edx),%edx
    130b:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    130f:	89 ca                	mov    %ecx,%edx
    1311:	89 c1                	mov    %eax,%ecx
    1313:	39 d6                	cmp    %edx,%esi
    1315:	76 df                	jbe    12f6 <printint+0x2e>
  if(neg)
    1317:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    131b:	74 31                	je     134e <printint+0x86>
    buf[i++] = '-';
    131d:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1322:	8d 5f 02             	lea    0x2(%edi),%ebx
    1325:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1328:	eb 17                	jmp    1341 <printint+0x79>
    x = xx;
    132a:	89 c1                	mov    %eax,%ecx
  neg = 0;
    132c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1333:	eb bc                	jmp    12f1 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1335:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    133a:	89 f0                	mov    %esi,%eax
    133c:	e8 6d ff ff ff       	call   12ae <putc>
  while(--i >= 0)
    1341:	83 eb 01             	sub    $0x1,%ebx
    1344:	79 ef                	jns    1335 <printint+0x6d>
}
    1346:	83 c4 2c             	add    $0x2c,%esp
    1349:	5b                   	pop    %ebx
    134a:	5e                   	pop    %esi
    134b:	5f                   	pop    %edi
    134c:	5d                   	pop    %ebp
    134d:	c3                   	ret    
    134e:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1351:	eb ee                	jmp    1341 <printint+0x79>

00001353 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1353:	55                   	push   %ebp
    1354:	89 e5                	mov    %esp,%ebp
    1356:	57                   	push   %edi
    1357:	56                   	push   %esi
    1358:	53                   	push   %ebx
    1359:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    135c:	8d 45 10             	lea    0x10(%ebp),%eax
    135f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1362:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1367:	bb 00 00 00 00       	mov    $0x0,%ebx
    136c:	eb 14                	jmp    1382 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    136e:	89 fa                	mov    %edi,%edx
    1370:	8b 45 08             	mov    0x8(%ebp),%eax
    1373:	e8 36 ff ff ff       	call   12ae <putc>
    1378:	eb 05                	jmp    137f <printf+0x2c>
      }
    } else if(state == '%'){
    137a:	83 fe 25             	cmp    $0x25,%esi
    137d:	74 25                	je     13a4 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    137f:	83 c3 01             	add    $0x1,%ebx
    1382:	8b 45 0c             	mov    0xc(%ebp),%eax
    1385:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1389:	84 c0                	test   %al,%al
    138b:	0f 84 20 01 00 00    	je     14b1 <printf+0x15e>
    c = fmt[i] & 0xff;
    1391:	0f be f8             	movsbl %al,%edi
    1394:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1397:	85 f6                	test   %esi,%esi
    1399:	75 df                	jne    137a <printf+0x27>
      if(c == '%'){
    139b:	83 f8 25             	cmp    $0x25,%eax
    139e:	75 ce                	jne    136e <printf+0x1b>
        state = '%';
    13a0:	89 c6                	mov    %eax,%esi
    13a2:	eb db                	jmp    137f <printf+0x2c>
      if(c == 'd'){
    13a4:	83 f8 25             	cmp    $0x25,%eax
    13a7:	0f 84 cf 00 00 00    	je     147c <printf+0x129>
    13ad:	0f 8c dd 00 00 00    	jl     1490 <printf+0x13d>
    13b3:	83 f8 78             	cmp    $0x78,%eax
    13b6:	0f 8f d4 00 00 00    	jg     1490 <printf+0x13d>
    13bc:	83 f8 63             	cmp    $0x63,%eax
    13bf:	0f 8c cb 00 00 00    	jl     1490 <printf+0x13d>
    13c5:	83 e8 63             	sub    $0x63,%eax
    13c8:	83 f8 15             	cmp    $0x15,%eax
    13cb:	0f 87 bf 00 00 00    	ja     1490 <printf+0x13d>
    13d1:	ff 24 85 24 16 00 00 	jmp    *0x1624(,%eax,4)
        printint(fd, *ap, 10, 1);
    13d8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13db:	8b 17                	mov    (%edi),%edx
    13dd:	83 ec 0c             	sub    $0xc,%esp
    13e0:	6a 01                	push   $0x1
    13e2:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13e7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ea:	e8 d9 fe ff ff       	call   12c8 <printint>
        ap++;
    13ef:	83 c7 04             	add    $0x4,%edi
    13f2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13f5:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13f8:	be 00 00 00 00       	mov    $0x0,%esi
    13fd:	eb 80                	jmp    137f <printf+0x2c>
        printint(fd, *ap, 16, 0);
    13ff:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1402:	8b 17                	mov    (%edi),%edx
    1404:	83 ec 0c             	sub    $0xc,%esp
    1407:	6a 00                	push   $0x0
    1409:	b9 10 00 00 00       	mov    $0x10,%ecx
    140e:	8b 45 08             	mov    0x8(%ebp),%eax
    1411:	e8 b2 fe ff ff       	call   12c8 <printint>
        ap++;
    1416:	83 c7 04             	add    $0x4,%edi
    1419:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    141c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    141f:	be 00 00 00 00       	mov    $0x0,%esi
    1424:	e9 56 ff ff ff       	jmp    137f <printf+0x2c>
        s = (char*)*ap;
    1429:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    142c:	8b 30                	mov    (%eax),%esi
        ap++;
    142e:	83 c0 04             	add    $0x4,%eax
    1431:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1434:	85 f6                	test   %esi,%esi
    1436:	75 15                	jne    144d <printf+0xfa>
          s = "(null)";
    1438:	be 1b 16 00 00       	mov    $0x161b,%esi
    143d:	eb 0e                	jmp    144d <printf+0xfa>
          putc(fd, *s);
    143f:	0f be d2             	movsbl %dl,%edx
    1442:	8b 45 08             	mov    0x8(%ebp),%eax
    1445:	e8 64 fe ff ff       	call   12ae <putc>
          s++;
    144a:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    144d:	0f b6 16             	movzbl (%esi),%edx
    1450:	84 d2                	test   %dl,%dl
    1452:	75 eb                	jne    143f <printf+0xec>
      state = 0;
    1454:	be 00 00 00 00       	mov    $0x0,%esi
    1459:	e9 21 ff ff ff       	jmp    137f <printf+0x2c>
        putc(fd, *ap);
    145e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1461:	0f be 17             	movsbl (%edi),%edx
    1464:	8b 45 08             	mov    0x8(%ebp),%eax
    1467:	e8 42 fe ff ff       	call   12ae <putc>
        ap++;
    146c:	83 c7 04             	add    $0x4,%edi
    146f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1472:	be 00 00 00 00       	mov    $0x0,%esi
    1477:	e9 03 ff ff ff       	jmp    137f <printf+0x2c>
        putc(fd, c);
    147c:	89 fa                	mov    %edi,%edx
    147e:	8b 45 08             	mov    0x8(%ebp),%eax
    1481:	e8 28 fe ff ff       	call   12ae <putc>
      state = 0;
    1486:	be 00 00 00 00       	mov    $0x0,%esi
    148b:	e9 ef fe ff ff       	jmp    137f <printf+0x2c>
        putc(fd, '%');
    1490:	ba 25 00 00 00       	mov    $0x25,%edx
    1495:	8b 45 08             	mov    0x8(%ebp),%eax
    1498:	e8 11 fe ff ff       	call   12ae <putc>
        putc(fd, c);
    149d:	89 fa                	mov    %edi,%edx
    149f:	8b 45 08             	mov    0x8(%ebp),%eax
    14a2:	e8 07 fe ff ff       	call   12ae <putc>
      state = 0;
    14a7:	be 00 00 00 00       	mov    $0x0,%esi
    14ac:	e9 ce fe ff ff       	jmp    137f <printf+0x2c>
    }
  }
}
    14b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b4:	5b                   	pop    %ebx
    14b5:	5e                   	pop    %esi
    14b6:	5f                   	pop    %edi
    14b7:	5d                   	pop    %ebp
    14b8:	c3                   	ret    

000014b9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b9:	55                   	push   %ebp
    14ba:	89 e5                	mov    %esp,%ebp
    14bc:	57                   	push   %edi
    14bd:	56                   	push   %esi
    14be:	53                   	push   %ebx
    14bf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14c2:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c5:	a1 20 19 00 00       	mov    0x1920,%eax
    14ca:	eb 02                	jmp    14ce <free+0x15>
    14cc:	89 d0                	mov    %edx,%eax
    14ce:	39 c8                	cmp    %ecx,%eax
    14d0:	73 04                	jae    14d6 <free+0x1d>
    14d2:	39 08                	cmp    %ecx,(%eax)
    14d4:	77 12                	ja     14e8 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d6:	8b 10                	mov    (%eax),%edx
    14d8:	39 c2                	cmp    %eax,%edx
    14da:	77 f0                	ja     14cc <free+0x13>
    14dc:	39 c8                	cmp    %ecx,%eax
    14de:	72 08                	jb     14e8 <free+0x2f>
    14e0:	39 ca                	cmp    %ecx,%edx
    14e2:	77 04                	ja     14e8 <free+0x2f>
    14e4:	89 d0                	mov    %edx,%eax
    14e6:	eb e6                	jmp    14ce <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14ee:	8b 10                	mov    (%eax),%edx
    14f0:	39 d7                	cmp    %edx,%edi
    14f2:	74 19                	je     150d <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14f7:	8b 50 04             	mov    0x4(%eax),%edx
    14fa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14fd:	39 ce                	cmp    %ecx,%esi
    14ff:	74 1b                	je     151c <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1501:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1503:	a3 20 19 00 00       	mov    %eax,0x1920
}
    1508:	5b                   	pop    %ebx
    1509:	5e                   	pop    %esi
    150a:	5f                   	pop    %edi
    150b:	5d                   	pop    %ebp
    150c:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    150d:	03 72 04             	add    0x4(%edx),%esi
    1510:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1513:	8b 10                	mov    (%eax),%edx
    1515:	8b 12                	mov    (%edx),%edx
    1517:	89 53 f8             	mov    %edx,-0x8(%ebx)
    151a:	eb db                	jmp    14f7 <free+0x3e>
    p->s.size += bp->s.size;
    151c:	03 53 fc             	add    -0x4(%ebx),%edx
    151f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1522:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1525:	89 10                	mov    %edx,(%eax)
    1527:	eb da                	jmp    1503 <free+0x4a>

00001529 <morecore>:

static Header*
morecore(uint nu)
{
    1529:	55                   	push   %ebp
    152a:	89 e5                	mov    %esp,%ebp
    152c:	53                   	push   %ebx
    152d:	83 ec 04             	sub    $0x4,%esp
    1530:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1532:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1537:	77 05                	ja     153e <morecore+0x15>
    nu = 4096;
    1539:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    153e:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1545:	83 ec 0c             	sub    $0xc,%esp
    1548:	50                   	push   %eax
    1549:	e8 28 fd ff ff       	call   1276 <sbrk>
  if(p == (char*)-1)
    154e:	83 c4 10             	add    $0x10,%esp
    1551:	83 f8 ff             	cmp    $0xffffffff,%eax
    1554:	74 1c                	je     1572 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1556:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1559:	83 c0 08             	add    $0x8,%eax
    155c:	83 ec 0c             	sub    $0xc,%esp
    155f:	50                   	push   %eax
    1560:	e8 54 ff ff ff       	call   14b9 <free>
  return freep;
    1565:	a1 20 19 00 00       	mov    0x1920,%eax
    156a:	83 c4 10             	add    $0x10,%esp
}
    156d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1570:	c9                   	leave  
    1571:	c3                   	ret    
    return 0;
    1572:	b8 00 00 00 00       	mov    $0x0,%eax
    1577:	eb f4                	jmp    156d <morecore+0x44>

00001579 <malloc>:

void*
malloc(uint nbytes)
{
    1579:	55                   	push   %ebp
    157a:	89 e5                	mov    %esp,%ebp
    157c:	53                   	push   %ebx
    157d:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1580:	8b 45 08             	mov    0x8(%ebp),%eax
    1583:	8d 58 07             	lea    0x7(%eax),%ebx
    1586:	c1 eb 03             	shr    $0x3,%ebx
    1589:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    158c:	8b 0d 20 19 00 00    	mov    0x1920,%ecx
    1592:	85 c9                	test   %ecx,%ecx
    1594:	74 04                	je     159a <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1596:	8b 01                	mov    (%ecx),%eax
    1598:	eb 4a                	jmp    15e4 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    159a:	c7 05 20 19 00 00 24 	movl   $0x1924,0x1920
    15a1:	19 00 00 
    15a4:	c7 05 24 19 00 00 24 	movl   $0x1924,0x1924
    15ab:	19 00 00 
    base.s.size = 0;
    15ae:	c7 05 28 19 00 00 00 	movl   $0x0,0x1928
    15b5:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15b8:	b9 24 19 00 00       	mov    $0x1924,%ecx
    15bd:	eb d7                	jmp    1596 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15bf:	74 19                	je     15da <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15c1:	29 da                	sub    %ebx,%edx
    15c3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15c6:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15c9:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15cc:	89 0d 20 19 00 00    	mov    %ecx,0x1920
      return (void*)(p + 1);
    15d2:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15d8:	c9                   	leave  
    15d9:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15da:	8b 10                	mov    (%eax),%edx
    15dc:	89 11                	mov    %edx,(%ecx)
    15de:	eb ec                	jmp    15cc <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15e0:	89 c1                	mov    %eax,%ecx
    15e2:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15e4:	8b 50 04             	mov    0x4(%eax),%edx
    15e7:	39 da                	cmp    %ebx,%edx
    15e9:	73 d4                	jae    15bf <malloc+0x46>
    if(p == freep)
    15eb:	39 05 20 19 00 00    	cmp    %eax,0x1920
    15f1:	75 ed                	jne    15e0 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15f3:	89 d8                	mov    %ebx,%eax
    15f5:	e8 2f ff ff ff       	call   1529 <morecore>
    15fa:	85 c0                	test   %eax,%eax
    15fc:	75 e2                	jne    15e0 <malloc+0x67>
    15fe:	eb d5                	jmp    15d5 <malloc+0x5c>
