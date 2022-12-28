
_test_18:     file format elf32-i386


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
    1017:	e8 70 02 00 00       	call   128c <sbrk>
    101c:	89 c3                	mov    %eax,%ebx
    mprotect(ptr, PAGES_NUM);
    101e:	83 c4 08             	add    $0x8,%esp
    1021:	6a 05                	push   $0x5
    1023:	50                   	push   %eax
    1024:	e8 8b 02 00 00       	call   12b4 <mprotect>

    if (fork() == 0) {
    1029:	e8 ce 01 00 00       	call   11fc <fork>
    102e:	83 c4 10             	add    $0x10,%esp
    1031:	85 c0                	test   %eax,%eax
    1033:	75 26                	jne    105b <main+0x5b>
        // Should NOT page fault 
        munprotect(ptr, PAGES_NUM);
    1035:	83 ec 08             	sub    $0x8,%esp
    1038:	6a 05                	push   $0x5
    103a:	53                   	push   %ebx
    103b:	e8 7c 02 00 00       	call   12bc <munprotect>
        ptr[4 * PGSIZE] = 0xAA;
    1040:	c6 83 00 40 00 00 aa 	movb   $0xaa,0x4000(%ebx)
        printf(1, "XV6_TEST_OUTPUT TEST PASS\n");
    1047:	83 c4 08             	add    $0x8,%esp
    104a:	68 18 16 00 00       	push   $0x1618
    104f:	6a 01                	push   $0x1
    1051:	e8 13 03 00 00       	call   1369 <printf>
        exit();
    1056:	e8 a9 01 00 00       	call   1204 <exit>
    } else {
        wait();
    105b:	e8 ac 01 00 00       	call   120c <wait>
    }
    exit();
    1060:	e8 9f 01 00 00       	call   1204 <exit>

00001065 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1065:	55                   	push   %ebp
    1066:	89 e5                	mov    %esp,%ebp
    1068:	56                   	push   %esi
    1069:	53                   	push   %ebx
    106a:	8b 75 08             	mov    0x8(%ebp),%esi
    106d:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1070:	89 f0                	mov    %esi,%eax
    1072:	89 d1                	mov    %edx,%ecx
    1074:	83 c2 01             	add    $0x1,%edx
    1077:	89 c3                	mov    %eax,%ebx
    1079:	83 c0 01             	add    $0x1,%eax
    107c:	0f b6 09             	movzbl (%ecx),%ecx
    107f:	88 0b                	mov    %cl,(%ebx)
    1081:	84 c9                	test   %cl,%cl
    1083:	75 ed                	jne    1072 <strcpy+0xd>
    ;
  return os;
}
    1085:	89 f0                	mov    %esi,%eax
    1087:	5b                   	pop    %ebx
    1088:	5e                   	pop    %esi
    1089:	5d                   	pop    %ebp
    108a:	c3                   	ret    

0000108b <strcmp>:

int
strcmp(const char *p, const char *q)
{
    108b:	55                   	push   %ebp
    108c:	89 e5                	mov    %esp,%ebp
    108e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1091:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1094:	eb 06                	jmp    109c <strcmp+0x11>
    p++, q++;
    1096:	83 c1 01             	add    $0x1,%ecx
    1099:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    109c:	0f b6 01             	movzbl (%ecx),%eax
    109f:	84 c0                	test   %al,%al
    10a1:	74 04                	je     10a7 <strcmp+0x1c>
    10a3:	3a 02                	cmp    (%edx),%al
    10a5:	74 ef                	je     1096 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    10a7:	0f b6 c0             	movzbl %al,%eax
    10aa:	0f b6 12             	movzbl (%edx),%edx
    10ad:	29 d0                	sub    %edx,%eax
}
    10af:	5d                   	pop    %ebp
    10b0:	c3                   	ret    

000010b1 <strlen>:

uint
strlen(const char *s)
{
    10b1:	55                   	push   %ebp
    10b2:	89 e5                	mov    %esp,%ebp
    10b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10b7:	b8 00 00 00 00       	mov    $0x0,%eax
    10bc:	eb 03                	jmp    10c1 <strlen+0x10>
    10be:	83 c0 01             	add    $0x1,%eax
    10c1:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10c5:	75 f7                	jne    10be <strlen+0xd>
    ;
  return n;
}
    10c7:	5d                   	pop    %ebp
    10c8:	c3                   	ret    

000010c9 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10c9:	55                   	push   %ebp
    10ca:	89 e5                	mov    %esp,%ebp
    10cc:	57                   	push   %edi
    10cd:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10d0:	89 d7                	mov    %edx,%edi
    10d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d8:	fc                   	cld    
    10d9:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10db:	89 d0                	mov    %edx,%eax
    10dd:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10e0:	c9                   	leave  
    10e1:	c3                   	ret    

000010e2 <strchr>:

char*
strchr(const char *s, char c)
{
    10e2:	55                   	push   %ebp
    10e3:	89 e5                	mov    %esp,%ebp
    10e5:	8b 45 08             	mov    0x8(%ebp),%eax
    10e8:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10ec:	eb 03                	jmp    10f1 <strchr+0xf>
    10ee:	83 c0 01             	add    $0x1,%eax
    10f1:	0f b6 10             	movzbl (%eax),%edx
    10f4:	84 d2                	test   %dl,%dl
    10f6:	74 06                	je     10fe <strchr+0x1c>
    if(*s == c)
    10f8:	38 ca                	cmp    %cl,%dl
    10fa:	75 f2                	jne    10ee <strchr+0xc>
    10fc:	eb 05                	jmp    1103 <strchr+0x21>
      return (char*)s;
  return 0;
    10fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1103:	5d                   	pop    %ebp
    1104:	c3                   	ret    

00001105 <gets>:

char*
gets(char *buf, int max)
{
    1105:	55                   	push   %ebp
    1106:	89 e5                	mov    %esp,%ebp
    1108:	57                   	push   %edi
    1109:	56                   	push   %esi
    110a:	53                   	push   %ebx
    110b:	83 ec 1c             	sub    $0x1c,%esp
    110e:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1111:	bb 00 00 00 00       	mov    $0x0,%ebx
    1116:	89 de                	mov    %ebx,%esi
    1118:	83 c3 01             	add    $0x1,%ebx
    111b:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    111e:	7d 2e                	jge    114e <gets+0x49>
    cc = read(0, &c, 1);
    1120:	83 ec 04             	sub    $0x4,%esp
    1123:	6a 01                	push   $0x1
    1125:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1128:	50                   	push   %eax
    1129:	6a 00                	push   $0x0
    112b:	e8 ec 00 00 00       	call   121c <read>
    if(cc < 1)
    1130:	83 c4 10             	add    $0x10,%esp
    1133:	85 c0                	test   %eax,%eax
    1135:	7e 17                	jle    114e <gets+0x49>
      break;
    buf[i++] = c;
    1137:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    113b:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    113e:	3c 0a                	cmp    $0xa,%al
    1140:	0f 94 c2             	sete   %dl
    1143:	3c 0d                	cmp    $0xd,%al
    1145:	0f 94 c0             	sete   %al
    1148:	08 c2                	or     %al,%dl
    114a:	74 ca                	je     1116 <gets+0x11>
    buf[i++] = c;
    114c:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    114e:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1152:	89 f8                	mov    %edi,%eax
    1154:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1157:	5b                   	pop    %ebx
    1158:	5e                   	pop    %esi
    1159:	5f                   	pop    %edi
    115a:	5d                   	pop    %ebp
    115b:	c3                   	ret    

0000115c <stat>:

int
stat(const char *n, struct stat *st)
{
    115c:	55                   	push   %ebp
    115d:	89 e5                	mov    %esp,%ebp
    115f:	56                   	push   %esi
    1160:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1161:	83 ec 08             	sub    $0x8,%esp
    1164:	6a 00                	push   $0x0
    1166:	ff 75 08             	push   0x8(%ebp)
    1169:	e8 d6 00 00 00       	call   1244 <open>
  if(fd < 0)
    116e:	83 c4 10             	add    $0x10,%esp
    1171:	85 c0                	test   %eax,%eax
    1173:	78 24                	js     1199 <stat+0x3d>
    1175:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1177:	83 ec 08             	sub    $0x8,%esp
    117a:	ff 75 0c             	push   0xc(%ebp)
    117d:	50                   	push   %eax
    117e:	e8 d9 00 00 00       	call   125c <fstat>
    1183:	89 c6                	mov    %eax,%esi
  close(fd);
    1185:	89 1c 24             	mov    %ebx,(%esp)
    1188:	e8 9f 00 00 00       	call   122c <close>
  return r;
    118d:	83 c4 10             	add    $0x10,%esp
}
    1190:	89 f0                	mov    %esi,%eax
    1192:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1195:	5b                   	pop    %ebx
    1196:	5e                   	pop    %esi
    1197:	5d                   	pop    %ebp
    1198:	c3                   	ret    
    return -1;
    1199:	be ff ff ff ff       	mov    $0xffffffff,%esi
    119e:	eb f0                	jmp    1190 <stat+0x34>

000011a0 <atoi>:

int
atoi(const char *s)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	53                   	push   %ebx
    11a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    11a7:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11ac:	eb 10                	jmp    11be <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11ae:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11b1:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11b4:	83 c1 01             	add    $0x1,%ecx
    11b7:	0f be c0             	movsbl %al,%eax
    11ba:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11be:	0f b6 01             	movzbl (%ecx),%eax
    11c1:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11c4:	80 fb 09             	cmp    $0x9,%bl
    11c7:	76 e5                	jbe    11ae <atoi+0xe>
  return n;
}
    11c9:	89 d0                	mov    %edx,%eax
    11cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ce:	c9                   	leave  
    11cf:	c3                   	ret    

000011d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	56                   	push   %esi
    11d4:	53                   	push   %ebx
    11d5:	8b 75 08             	mov    0x8(%ebp),%esi
    11d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11db:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11de:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11e0:	eb 0d                	jmp    11ef <memmove+0x1f>
    *dst++ = *src++;
    11e2:	0f b6 01             	movzbl (%ecx),%eax
    11e5:	88 02                	mov    %al,(%edx)
    11e7:	8d 49 01             	lea    0x1(%ecx),%ecx
    11ea:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11ed:	89 d8                	mov    %ebx,%eax
    11ef:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11f2:	85 c0                	test   %eax,%eax
    11f4:	7f ec                	jg     11e2 <memmove+0x12>
  return vdst;
}
    11f6:	89 f0                	mov    %esi,%eax
    11f8:	5b                   	pop    %ebx
    11f9:	5e                   	pop    %esi
    11fa:	5d                   	pop    %ebp
    11fb:	c3                   	ret    

000011fc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11fc:	b8 01 00 00 00       	mov    $0x1,%eax
    1201:	cd 40                	int    $0x40
    1203:	c3                   	ret    

00001204 <exit>:
SYSCALL(exit)
    1204:	b8 02 00 00 00       	mov    $0x2,%eax
    1209:	cd 40                	int    $0x40
    120b:	c3                   	ret    

0000120c <wait>:
SYSCALL(wait)
    120c:	b8 03 00 00 00       	mov    $0x3,%eax
    1211:	cd 40                	int    $0x40
    1213:	c3                   	ret    

00001214 <pipe>:
SYSCALL(pipe)
    1214:	b8 04 00 00 00       	mov    $0x4,%eax
    1219:	cd 40                	int    $0x40
    121b:	c3                   	ret    

0000121c <read>:
SYSCALL(read)
    121c:	b8 05 00 00 00       	mov    $0x5,%eax
    1221:	cd 40                	int    $0x40
    1223:	c3                   	ret    

00001224 <write>:
SYSCALL(write)
    1224:	b8 10 00 00 00       	mov    $0x10,%eax
    1229:	cd 40                	int    $0x40
    122b:	c3                   	ret    

0000122c <close>:
SYSCALL(close)
    122c:	b8 15 00 00 00       	mov    $0x15,%eax
    1231:	cd 40                	int    $0x40
    1233:	c3                   	ret    

00001234 <kill>:
SYSCALL(kill)
    1234:	b8 06 00 00 00       	mov    $0x6,%eax
    1239:	cd 40                	int    $0x40
    123b:	c3                   	ret    

0000123c <exec>:
SYSCALL(exec)
    123c:	b8 07 00 00 00       	mov    $0x7,%eax
    1241:	cd 40                	int    $0x40
    1243:	c3                   	ret    

00001244 <open>:
SYSCALL(open)
    1244:	b8 0f 00 00 00       	mov    $0xf,%eax
    1249:	cd 40                	int    $0x40
    124b:	c3                   	ret    

0000124c <mknod>:
SYSCALL(mknod)
    124c:	b8 11 00 00 00       	mov    $0x11,%eax
    1251:	cd 40                	int    $0x40
    1253:	c3                   	ret    

00001254 <unlink>:
SYSCALL(unlink)
    1254:	b8 12 00 00 00       	mov    $0x12,%eax
    1259:	cd 40                	int    $0x40
    125b:	c3                   	ret    

0000125c <fstat>:
SYSCALL(fstat)
    125c:	b8 08 00 00 00       	mov    $0x8,%eax
    1261:	cd 40                	int    $0x40
    1263:	c3                   	ret    

00001264 <link>:
SYSCALL(link)
    1264:	b8 13 00 00 00       	mov    $0x13,%eax
    1269:	cd 40                	int    $0x40
    126b:	c3                   	ret    

0000126c <mkdir>:
SYSCALL(mkdir)
    126c:	b8 14 00 00 00       	mov    $0x14,%eax
    1271:	cd 40                	int    $0x40
    1273:	c3                   	ret    

00001274 <chdir>:
SYSCALL(chdir)
    1274:	b8 09 00 00 00       	mov    $0x9,%eax
    1279:	cd 40                	int    $0x40
    127b:	c3                   	ret    

0000127c <dup>:
SYSCALL(dup)
    127c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1281:	cd 40                	int    $0x40
    1283:	c3                   	ret    

00001284 <getpid>:
SYSCALL(getpid)
    1284:	b8 0b 00 00 00       	mov    $0xb,%eax
    1289:	cd 40                	int    $0x40
    128b:	c3                   	ret    

0000128c <sbrk>:
SYSCALL(sbrk)
    128c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1291:	cd 40                	int    $0x40
    1293:	c3                   	ret    

00001294 <sleep>:
SYSCALL(sleep)
    1294:	b8 0d 00 00 00       	mov    $0xd,%eax
    1299:	cd 40                	int    $0x40
    129b:	c3                   	ret    

0000129c <uptime>:
SYSCALL(uptime)
    129c:	b8 0e 00 00 00       	mov    $0xe,%eax
    12a1:	cd 40                	int    $0x40
    12a3:	c3                   	ret    

000012a4 <settickets>:
SYSCALL(settickets)
    12a4:	b8 16 00 00 00       	mov    $0x16,%eax
    12a9:	cd 40                	int    $0x40
    12ab:	c3                   	ret    

000012ac <getpinfo>:
SYSCALL(getpinfo)
    12ac:	b8 17 00 00 00       	mov    $0x17,%eax
    12b1:	cd 40                	int    $0x40
    12b3:	c3                   	ret    

000012b4 <mprotect>:
SYSCALL(mprotect)
    12b4:	b8 18 00 00 00       	mov    $0x18,%eax
    12b9:	cd 40                	int    $0x40
    12bb:	c3                   	ret    

000012bc <munprotect>:
    12bc:	b8 19 00 00 00       	mov    $0x19,%eax
    12c1:	cd 40                	int    $0x40
    12c3:	c3                   	ret    

000012c4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12c4:	55                   	push   %ebp
    12c5:	89 e5                	mov    %esp,%ebp
    12c7:	83 ec 1c             	sub    $0x1c,%esp
    12ca:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12cd:	6a 01                	push   $0x1
    12cf:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12d2:	52                   	push   %edx
    12d3:	50                   	push   %eax
    12d4:	e8 4b ff ff ff       	call   1224 <write>
}
    12d9:	83 c4 10             	add    $0x10,%esp
    12dc:	c9                   	leave  
    12dd:	c3                   	ret    

000012de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12de:	55                   	push   %ebp
    12df:	89 e5                	mov    %esp,%ebp
    12e1:	57                   	push   %edi
    12e2:	56                   	push   %esi
    12e3:	53                   	push   %ebx
    12e4:	83 ec 2c             	sub    $0x2c,%esp
    12e7:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12ea:	89 d0                	mov    %edx,%eax
    12ec:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12f2:	0f 95 c1             	setne  %cl
    12f5:	c1 ea 1f             	shr    $0x1f,%edx
    12f8:	84 d1                	test   %dl,%cl
    12fa:	74 44                	je     1340 <printint+0x62>
    neg = 1;
    x = -xx;
    12fc:	f7 d8                	neg    %eax
    12fe:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1300:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1307:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    130c:	89 c8                	mov    %ecx,%eax
    130e:	ba 00 00 00 00       	mov    $0x0,%edx
    1313:	f7 f6                	div    %esi
    1315:	89 df                	mov    %ebx,%edi
    1317:	83 c3 01             	add    $0x1,%ebx
    131a:	0f b6 92 94 16 00 00 	movzbl 0x1694(%edx),%edx
    1321:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1325:	89 ca                	mov    %ecx,%edx
    1327:	89 c1                	mov    %eax,%ecx
    1329:	39 d6                	cmp    %edx,%esi
    132b:	76 df                	jbe    130c <printint+0x2e>
  if(neg)
    132d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1331:	74 31                	je     1364 <printint+0x86>
    buf[i++] = '-';
    1333:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1338:	8d 5f 02             	lea    0x2(%edi),%ebx
    133b:	8b 75 d0             	mov    -0x30(%ebp),%esi
    133e:	eb 17                	jmp    1357 <printint+0x79>
    x = xx;
    1340:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1342:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1349:	eb bc                	jmp    1307 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    134b:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1350:	89 f0                	mov    %esi,%eax
    1352:	e8 6d ff ff ff       	call   12c4 <putc>
  while(--i >= 0)
    1357:	83 eb 01             	sub    $0x1,%ebx
    135a:	79 ef                	jns    134b <printint+0x6d>
}
    135c:	83 c4 2c             	add    $0x2c,%esp
    135f:	5b                   	pop    %ebx
    1360:	5e                   	pop    %esi
    1361:	5f                   	pop    %edi
    1362:	5d                   	pop    %ebp
    1363:	c3                   	ret    
    1364:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1367:	eb ee                	jmp    1357 <printint+0x79>

00001369 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1369:	55                   	push   %ebp
    136a:	89 e5                	mov    %esp,%ebp
    136c:	57                   	push   %edi
    136d:	56                   	push   %esi
    136e:	53                   	push   %ebx
    136f:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1372:	8d 45 10             	lea    0x10(%ebp),%eax
    1375:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1378:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    137d:	bb 00 00 00 00       	mov    $0x0,%ebx
    1382:	eb 14                	jmp    1398 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1384:	89 fa                	mov    %edi,%edx
    1386:	8b 45 08             	mov    0x8(%ebp),%eax
    1389:	e8 36 ff ff ff       	call   12c4 <putc>
    138e:	eb 05                	jmp    1395 <printf+0x2c>
      }
    } else if(state == '%'){
    1390:	83 fe 25             	cmp    $0x25,%esi
    1393:	74 25                	je     13ba <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1395:	83 c3 01             	add    $0x1,%ebx
    1398:	8b 45 0c             	mov    0xc(%ebp),%eax
    139b:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    139f:	84 c0                	test   %al,%al
    13a1:	0f 84 20 01 00 00    	je     14c7 <printf+0x15e>
    c = fmt[i] & 0xff;
    13a7:	0f be f8             	movsbl %al,%edi
    13aa:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13ad:	85 f6                	test   %esi,%esi
    13af:	75 df                	jne    1390 <printf+0x27>
      if(c == '%'){
    13b1:	83 f8 25             	cmp    $0x25,%eax
    13b4:	75 ce                	jne    1384 <printf+0x1b>
        state = '%';
    13b6:	89 c6                	mov    %eax,%esi
    13b8:	eb db                	jmp    1395 <printf+0x2c>
      if(c == 'd'){
    13ba:	83 f8 25             	cmp    $0x25,%eax
    13bd:	0f 84 cf 00 00 00    	je     1492 <printf+0x129>
    13c3:	0f 8c dd 00 00 00    	jl     14a6 <printf+0x13d>
    13c9:	83 f8 78             	cmp    $0x78,%eax
    13cc:	0f 8f d4 00 00 00    	jg     14a6 <printf+0x13d>
    13d2:	83 f8 63             	cmp    $0x63,%eax
    13d5:	0f 8c cb 00 00 00    	jl     14a6 <printf+0x13d>
    13db:	83 e8 63             	sub    $0x63,%eax
    13de:	83 f8 15             	cmp    $0x15,%eax
    13e1:	0f 87 bf 00 00 00    	ja     14a6 <printf+0x13d>
    13e7:	ff 24 85 3c 16 00 00 	jmp    *0x163c(,%eax,4)
        printint(fd, *ap, 10, 1);
    13ee:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13f1:	8b 17                	mov    (%edi),%edx
    13f3:	83 ec 0c             	sub    $0xc,%esp
    13f6:	6a 01                	push   $0x1
    13f8:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1400:	e8 d9 fe ff ff       	call   12de <printint>
        ap++;
    1405:	83 c7 04             	add    $0x4,%edi
    1408:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    140b:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    140e:	be 00 00 00 00       	mov    $0x0,%esi
    1413:	eb 80                	jmp    1395 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1415:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1418:	8b 17                	mov    (%edi),%edx
    141a:	83 ec 0c             	sub    $0xc,%esp
    141d:	6a 00                	push   $0x0
    141f:	b9 10 00 00 00       	mov    $0x10,%ecx
    1424:	8b 45 08             	mov    0x8(%ebp),%eax
    1427:	e8 b2 fe ff ff       	call   12de <printint>
        ap++;
    142c:	83 c7 04             	add    $0x4,%edi
    142f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1432:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1435:	be 00 00 00 00       	mov    $0x0,%esi
    143a:	e9 56 ff ff ff       	jmp    1395 <printf+0x2c>
        s = (char*)*ap;
    143f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1442:	8b 30                	mov    (%eax),%esi
        ap++;
    1444:	83 c0 04             	add    $0x4,%eax
    1447:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    144a:	85 f6                	test   %esi,%esi
    144c:	75 15                	jne    1463 <printf+0xfa>
          s = "(null)";
    144e:	be 33 16 00 00       	mov    $0x1633,%esi
    1453:	eb 0e                	jmp    1463 <printf+0xfa>
          putc(fd, *s);
    1455:	0f be d2             	movsbl %dl,%edx
    1458:	8b 45 08             	mov    0x8(%ebp),%eax
    145b:	e8 64 fe ff ff       	call   12c4 <putc>
          s++;
    1460:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1463:	0f b6 16             	movzbl (%esi),%edx
    1466:	84 d2                	test   %dl,%dl
    1468:	75 eb                	jne    1455 <printf+0xec>
      state = 0;
    146a:	be 00 00 00 00       	mov    $0x0,%esi
    146f:	e9 21 ff ff ff       	jmp    1395 <printf+0x2c>
        putc(fd, *ap);
    1474:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1477:	0f be 17             	movsbl (%edi),%edx
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
    147d:	e8 42 fe ff ff       	call   12c4 <putc>
        ap++;
    1482:	83 c7 04             	add    $0x4,%edi
    1485:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1488:	be 00 00 00 00       	mov    $0x0,%esi
    148d:	e9 03 ff ff ff       	jmp    1395 <printf+0x2c>
        putc(fd, c);
    1492:	89 fa                	mov    %edi,%edx
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
    1497:	e8 28 fe ff ff       	call   12c4 <putc>
      state = 0;
    149c:	be 00 00 00 00       	mov    $0x0,%esi
    14a1:	e9 ef fe ff ff       	jmp    1395 <printf+0x2c>
        putc(fd, '%');
    14a6:	ba 25 00 00 00       	mov    $0x25,%edx
    14ab:	8b 45 08             	mov    0x8(%ebp),%eax
    14ae:	e8 11 fe ff ff       	call   12c4 <putc>
        putc(fd, c);
    14b3:	89 fa                	mov    %edi,%edx
    14b5:	8b 45 08             	mov    0x8(%ebp),%eax
    14b8:	e8 07 fe ff ff       	call   12c4 <putc>
      state = 0;
    14bd:	be 00 00 00 00       	mov    $0x0,%esi
    14c2:	e9 ce fe ff ff       	jmp    1395 <printf+0x2c>
    }
  }
}
    14c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14ca:	5b                   	pop    %ebx
    14cb:	5e                   	pop    %esi
    14cc:	5f                   	pop    %edi
    14cd:	5d                   	pop    %ebp
    14ce:	c3                   	ret    

000014cf <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14cf:	55                   	push   %ebp
    14d0:	89 e5                	mov    %esp,%ebp
    14d2:	57                   	push   %edi
    14d3:	56                   	push   %esi
    14d4:	53                   	push   %ebx
    14d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14d8:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14db:	a1 38 19 00 00       	mov    0x1938,%eax
    14e0:	eb 02                	jmp    14e4 <free+0x15>
    14e2:	89 d0                	mov    %edx,%eax
    14e4:	39 c8                	cmp    %ecx,%eax
    14e6:	73 04                	jae    14ec <free+0x1d>
    14e8:	39 08                	cmp    %ecx,(%eax)
    14ea:	77 12                	ja     14fe <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14ec:	8b 10                	mov    (%eax),%edx
    14ee:	39 c2                	cmp    %eax,%edx
    14f0:	77 f0                	ja     14e2 <free+0x13>
    14f2:	39 c8                	cmp    %ecx,%eax
    14f4:	72 08                	jb     14fe <free+0x2f>
    14f6:	39 ca                	cmp    %ecx,%edx
    14f8:	77 04                	ja     14fe <free+0x2f>
    14fa:	89 d0                	mov    %edx,%eax
    14fc:	eb e6                	jmp    14e4 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14fe:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1501:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1504:	8b 10                	mov    (%eax),%edx
    1506:	39 d7                	cmp    %edx,%edi
    1508:	74 19                	je     1523 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    150a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    150d:	8b 50 04             	mov    0x4(%eax),%edx
    1510:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1513:	39 ce                	cmp    %ecx,%esi
    1515:	74 1b                	je     1532 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1517:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1519:	a3 38 19 00 00       	mov    %eax,0x1938
}
    151e:	5b                   	pop    %ebx
    151f:	5e                   	pop    %esi
    1520:	5f                   	pop    %edi
    1521:	5d                   	pop    %ebp
    1522:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1523:	03 72 04             	add    0x4(%edx),%esi
    1526:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1529:	8b 10                	mov    (%eax),%edx
    152b:	8b 12                	mov    (%edx),%edx
    152d:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1530:	eb db                	jmp    150d <free+0x3e>
    p->s.size += bp->s.size;
    1532:	03 53 fc             	add    -0x4(%ebx),%edx
    1535:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1538:	8b 53 f8             	mov    -0x8(%ebx),%edx
    153b:	89 10                	mov    %edx,(%eax)
    153d:	eb da                	jmp    1519 <free+0x4a>

0000153f <morecore>:

static Header*
morecore(uint nu)
{
    153f:	55                   	push   %ebp
    1540:	89 e5                	mov    %esp,%ebp
    1542:	53                   	push   %ebx
    1543:	83 ec 04             	sub    $0x4,%esp
    1546:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1548:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    154d:	77 05                	ja     1554 <morecore+0x15>
    nu = 4096;
    154f:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1554:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    155b:	83 ec 0c             	sub    $0xc,%esp
    155e:	50                   	push   %eax
    155f:	e8 28 fd ff ff       	call   128c <sbrk>
  if(p == (char*)-1)
    1564:	83 c4 10             	add    $0x10,%esp
    1567:	83 f8 ff             	cmp    $0xffffffff,%eax
    156a:	74 1c                	je     1588 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    156c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    156f:	83 c0 08             	add    $0x8,%eax
    1572:	83 ec 0c             	sub    $0xc,%esp
    1575:	50                   	push   %eax
    1576:	e8 54 ff ff ff       	call   14cf <free>
  return freep;
    157b:	a1 38 19 00 00       	mov    0x1938,%eax
    1580:	83 c4 10             	add    $0x10,%esp
}
    1583:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1586:	c9                   	leave  
    1587:	c3                   	ret    
    return 0;
    1588:	b8 00 00 00 00       	mov    $0x0,%eax
    158d:	eb f4                	jmp    1583 <morecore+0x44>

0000158f <malloc>:

void*
malloc(uint nbytes)
{
    158f:	55                   	push   %ebp
    1590:	89 e5                	mov    %esp,%ebp
    1592:	53                   	push   %ebx
    1593:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1596:	8b 45 08             	mov    0x8(%ebp),%eax
    1599:	8d 58 07             	lea    0x7(%eax),%ebx
    159c:	c1 eb 03             	shr    $0x3,%ebx
    159f:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    15a2:	8b 0d 38 19 00 00    	mov    0x1938,%ecx
    15a8:	85 c9                	test   %ecx,%ecx
    15aa:	74 04                	je     15b0 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15ac:	8b 01                	mov    (%ecx),%eax
    15ae:	eb 4a                	jmp    15fa <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15b0:	c7 05 38 19 00 00 3c 	movl   $0x193c,0x1938
    15b7:	19 00 00 
    15ba:	c7 05 3c 19 00 00 3c 	movl   $0x193c,0x193c
    15c1:	19 00 00 
    base.s.size = 0;
    15c4:	c7 05 40 19 00 00 00 	movl   $0x0,0x1940
    15cb:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15ce:	b9 3c 19 00 00       	mov    $0x193c,%ecx
    15d3:	eb d7                	jmp    15ac <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15d5:	74 19                	je     15f0 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15d7:	29 da                	sub    %ebx,%edx
    15d9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15dc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15df:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15e2:	89 0d 38 19 00 00    	mov    %ecx,0x1938
      return (void*)(p + 1);
    15e8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15ee:	c9                   	leave  
    15ef:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15f0:	8b 10                	mov    (%eax),%edx
    15f2:	89 11                	mov    %edx,(%ecx)
    15f4:	eb ec                	jmp    15e2 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15f6:	89 c1                	mov    %eax,%ecx
    15f8:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15fa:	8b 50 04             	mov    0x4(%eax),%edx
    15fd:	39 da                	cmp    %ebx,%edx
    15ff:	73 d4                	jae    15d5 <malloc+0x46>
    if(p == freep)
    1601:	39 05 38 19 00 00    	cmp    %eax,0x1938
    1607:	75 ed                	jne    15f6 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1609:	89 d8                	mov    %ebx,%eax
    160b:	e8 2f ff ff ff       	call   153f <morecore>
    1610:	85 c0                	test   %eax,%eax
    1612:	75 e2                	jne    15f6 <malloc+0x67>
    1614:	eb d5                	jmp    15eb <malloc+0x5c>
