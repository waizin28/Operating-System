
_ln:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
    100f:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
    1012:	83 39 03             	cmpl   $0x3,(%ecx)
    1015:	74 14                	je     102b <main+0x2b>
    printf(2, "Usage: ln old new\n");
    1017:	83 ec 08             	sub    $0x8,%esp
    101a:	68 10 16 00 00       	push   $0x1610
    101f:	6a 02                	push   $0x2
    1021:	e8 3a 03 00 00       	call   1360 <printf>
    exit();
    1026:	e8 d0 01 00 00       	call   11fb <exit>
  }
  if(link(argv[1], argv[2]) < 0)
    102b:	83 ec 08             	sub    $0x8,%esp
    102e:	ff 73 08             	push   0x8(%ebx)
    1031:	ff 73 04             	push   0x4(%ebx)
    1034:	e8 22 02 00 00       	call   125b <link>
    1039:	83 c4 10             	add    $0x10,%esp
    103c:	85 c0                	test   %eax,%eax
    103e:	78 05                	js     1045 <main+0x45>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
    1040:	e8 b6 01 00 00       	call   11fb <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    1045:	ff 73 08             	push   0x8(%ebx)
    1048:	ff 73 04             	push   0x4(%ebx)
    104b:	68 23 16 00 00       	push   $0x1623
    1050:	6a 02                	push   $0x2
    1052:	e8 09 03 00 00       	call   1360 <printf>
    1057:	83 c4 10             	add    $0x10,%esp
    105a:	eb e4                	jmp    1040 <main+0x40>

0000105c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    105c:	55                   	push   %ebp
    105d:	89 e5                	mov    %esp,%ebp
    105f:	56                   	push   %esi
    1060:	53                   	push   %ebx
    1061:	8b 75 08             	mov    0x8(%ebp),%esi
    1064:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1067:	89 f0                	mov    %esi,%eax
    1069:	89 d1                	mov    %edx,%ecx
    106b:	83 c2 01             	add    $0x1,%edx
    106e:	89 c3                	mov    %eax,%ebx
    1070:	83 c0 01             	add    $0x1,%eax
    1073:	0f b6 09             	movzbl (%ecx),%ecx
    1076:	88 0b                	mov    %cl,(%ebx)
    1078:	84 c9                	test   %cl,%cl
    107a:	75 ed                	jne    1069 <strcpy+0xd>
    ;
  return os;
}
    107c:	89 f0                	mov    %esi,%eax
    107e:	5b                   	pop    %ebx
    107f:	5e                   	pop    %esi
    1080:	5d                   	pop    %ebp
    1081:	c3                   	ret    

00001082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1082:	55                   	push   %ebp
    1083:	89 e5                	mov    %esp,%ebp
    1085:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1088:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    108b:	eb 06                	jmp    1093 <strcmp+0x11>
    p++, q++;
    108d:	83 c1 01             	add    $0x1,%ecx
    1090:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1093:	0f b6 01             	movzbl (%ecx),%eax
    1096:	84 c0                	test   %al,%al
    1098:	74 04                	je     109e <strcmp+0x1c>
    109a:	3a 02                	cmp    (%edx),%al
    109c:	74 ef                	je     108d <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    109e:	0f b6 c0             	movzbl %al,%eax
    10a1:	0f b6 12             	movzbl (%edx),%edx
    10a4:	29 d0                	sub    %edx,%eax
}
    10a6:	5d                   	pop    %ebp
    10a7:	c3                   	ret    

000010a8 <strlen>:

uint
strlen(const char *s)
{
    10a8:	55                   	push   %ebp
    10a9:	89 e5                	mov    %esp,%ebp
    10ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10ae:	b8 00 00 00 00       	mov    $0x0,%eax
    10b3:	eb 03                	jmp    10b8 <strlen+0x10>
    10b5:	83 c0 01             	add    $0x1,%eax
    10b8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10bc:	75 f7                	jne    10b5 <strlen+0xd>
    ;
  return n;
}
    10be:	5d                   	pop    %ebp
    10bf:	c3                   	ret    

000010c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10c7:	89 d7                	mov    %edx,%edi
    10c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cf:	fc                   	cld    
    10d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10d2:	89 d0                	mov    %edx,%eax
    10d4:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10d7:	c9                   	leave  
    10d8:	c3                   	ret    

000010d9 <strchr>:

char*
strchr(const char *s, char c)
{
    10d9:	55                   	push   %ebp
    10da:	89 e5                	mov    %esp,%ebp
    10dc:	8b 45 08             	mov    0x8(%ebp),%eax
    10df:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10e3:	eb 03                	jmp    10e8 <strchr+0xf>
    10e5:	83 c0 01             	add    $0x1,%eax
    10e8:	0f b6 10             	movzbl (%eax),%edx
    10eb:	84 d2                	test   %dl,%dl
    10ed:	74 06                	je     10f5 <strchr+0x1c>
    if(*s == c)
    10ef:	38 ca                	cmp    %cl,%dl
    10f1:	75 f2                	jne    10e5 <strchr+0xc>
    10f3:	eb 05                	jmp    10fa <strchr+0x21>
      return (char*)s;
  return 0;
    10f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10fa:	5d                   	pop    %ebp
    10fb:	c3                   	ret    

000010fc <gets>:

char*
gets(char *buf, int max)
{
    10fc:	55                   	push   %ebp
    10fd:	89 e5                	mov    %esp,%ebp
    10ff:	57                   	push   %edi
    1100:	56                   	push   %esi
    1101:	53                   	push   %ebx
    1102:	83 ec 1c             	sub    $0x1c,%esp
    1105:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1108:	bb 00 00 00 00       	mov    $0x0,%ebx
    110d:	89 de                	mov    %ebx,%esi
    110f:	83 c3 01             	add    $0x1,%ebx
    1112:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1115:	7d 2e                	jge    1145 <gets+0x49>
    cc = read(0, &c, 1);
    1117:	83 ec 04             	sub    $0x4,%esp
    111a:	6a 01                	push   $0x1
    111c:	8d 45 e7             	lea    -0x19(%ebp),%eax
    111f:	50                   	push   %eax
    1120:	6a 00                	push   $0x0
    1122:	e8 ec 00 00 00       	call   1213 <read>
    if(cc < 1)
    1127:	83 c4 10             	add    $0x10,%esp
    112a:	85 c0                	test   %eax,%eax
    112c:	7e 17                	jle    1145 <gets+0x49>
      break;
    buf[i++] = c;
    112e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1132:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1135:	3c 0a                	cmp    $0xa,%al
    1137:	0f 94 c2             	sete   %dl
    113a:	3c 0d                	cmp    $0xd,%al
    113c:	0f 94 c0             	sete   %al
    113f:	08 c2                	or     %al,%dl
    1141:	74 ca                	je     110d <gets+0x11>
    buf[i++] = c;
    1143:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1145:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1149:	89 f8                	mov    %edi,%eax
    114b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    114e:	5b                   	pop    %ebx
    114f:	5e                   	pop    %esi
    1150:	5f                   	pop    %edi
    1151:	5d                   	pop    %ebp
    1152:	c3                   	ret    

00001153 <stat>:

int
stat(const char *n, struct stat *st)
{
    1153:	55                   	push   %ebp
    1154:	89 e5                	mov    %esp,%ebp
    1156:	56                   	push   %esi
    1157:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1158:	83 ec 08             	sub    $0x8,%esp
    115b:	6a 00                	push   $0x0
    115d:	ff 75 08             	push   0x8(%ebp)
    1160:	e8 d6 00 00 00       	call   123b <open>
  if(fd < 0)
    1165:	83 c4 10             	add    $0x10,%esp
    1168:	85 c0                	test   %eax,%eax
    116a:	78 24                	js     1190 <stat+0x3d>
    116c:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    116e:	83 ec 08             	sub    $0x8,%esp
    1171:	ff 75 0c             	push   0xc(%ebp)
    1174:	50                   	push   %eax
    1175:	e8 d9 00 00 00       	call   1253 <fstat>
    117a:	89 c6                	mov    %eax,%esi
  close(fd);
    117c:	89 1c 24             	mov    %ebx,(%esp)
    117f:	e8 9f 00 00 00       	call   1223 <close>
  return r;
    1184:	83 c4 10             	add    $0x10,%esp
}
    1187:	89 f0                	mov    %esi,%eax
    1189:	8d 65 f8             	lea    -0x8(%ebp),%esp
    118c:	5b                   	pop    %ebx
    118d:	5e                   	pop    %esi
    118e:	5d                   	pop    %ebp
    118f:	c3                   	ret    
    return -1;
    1190:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1195:	eb f0                	jmp    1187 <stat+0x34>

00001197 <atoi>:

int
atoi(const char *s)
{
    1197:	55                   	push   %ebp
    1198:	89 e5                	mov    %esp,%ebp
    119a:	53                   	push   %ebx
    119b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    119e:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11a3:	eb 10                	jmp    11b5 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11a5:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11a8:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11ab:	83 c1 01             	add    $0x1,%ecx
    11ae:	0f be c0             	movsbl %al,%eax
    11b1:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11b5:	0f b6 01             	movzbl (%ecx),%eax
    11b8:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11bb:	80 fb 09             	cmp    $0x9,%bl
    11be:	76 e5                	jbe    11a5 <atoi+0xe>
  return n;
}
    11c0:	89 d0                	mov    %edx,%eax
    11c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11c5:	c9                   	leave  
    11c6:	c3                   	ret    

000011c7 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11c7:	55                   	push   %ebp
    11c8:	89 e5                	mov    %esp,%ebp
    11ca:	56                   	push   %esi
    11cb:	53                   	push   %ebx
    11cc:	8b 75 08             	mov    0x8(%ebp),%esi
    11cf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11d2:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11d5:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11d7:	eb 0d                	jmp    11e6 <memmove+0x1f>
    *dst++ = *src++;
    11d9:	0f b6 01             	movzbl (%ecx),%eax
    11dc:	88 02                	mov    %al,(%edx)
    11de:	8d 49 01             	lea    0x1(%ecx),%ecx
    11e1:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11e4:	89 d8                	mov    %ebx,%eax
    11e6:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11e9:	85 c0                	test   %eax,%eax
    11eb:	7f ec                	jg     11d9 <memmove+0x12>
  return vdst;
}
    11ed:	89 f0                	mov    %esi,%eax
    11ef:	5b                   	pop    %ebx
    11f0:	5e                   	pop    %esi
    11f1:	5d                   	pop    %ebp
    11f2:	c3                   	ret    

000011f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11f3:	b8 01 00 00 00       	mov    $0x1,%eax
    11f8:	cd 40                	int    $0x40
    11fa:	c3                   	ret    

000011fb <exit>:
SYSCALL(exit)
    11fb:	b8 02 00 00 00       	mov    $0x2,%eax
    1200:	cd 40                	int    $0x40
    1202:	c3                   	ret    

00001203 <wait>:
SYSCALL(wait)
    1203:	b8 03 00 00 00       	mov    $0x3,%eax
    1208:	cd 40                	int    $0x40
    120a:	c3                   	ret    

0000120b <pipe>:
SYSCALL(pipe)
    120b:	b8 04 00 00 00       	mov    $0x4,%eax
    1210:	cd 40                	int    $0x40
    1212:	c3                   	ret    

00001213 <read>:
SYSCALL(read)
    1213:	b8 05 00 00 00       	mov    $0x5,%eax
    1218:	cd 40                	int    $0x40
    121a:	c3                   	ret    

0000121b <write>:
SYSCALL(write)
    121b:	b8 10 00 00 00       	mov    $0x10,%eax
    1220:	cd 40                	int    $0x40
    1222:	c3                   	ret    

00001223 <close>:
SYSCALL(close)
    1223:	b8 15 00 00 00       	mov    $0x15,%eax
    1228:	cd 40                	int    $0x40
    122a:	c3                   	ret    

0000122b <kill>:
SYSCALL(kill)
    122b:	b8 06 00 00 00       	mov    $0x6,%eax
    1230:	cd 40                	int    $0x40
    1232:	c3                   	ret    

00001233 <exec>:
SYSCALL(exec)
    1233:	b8 07 00 00 00       	mov    $0x7,%eax
    1238:	cd 40                	int    $0x40
    123a:	c3                   	ret    

0000123b <open>:
SYSCALL(open)
    123b:	b8 0f 00 00 00       	mov    $0xf,%eax
    1240:	cd 40                	int    $0x40
    1242:	c3                   	ret    

00001243 <mknod>:
SYSCALL(mknod)
    1243:	b8 11 00 00 00       	mov    $0x11,%eax
    1248:	cd 40                	int    $0x40
    124a:	c3                   	ret    

0000124b <unlink>:
SYSCALL(unlink)
    124b:	b8 12 00 00 00       	mov    $0x12,%eax
    1250:	cd 40                	int    $0x40
    1252:	c3                   	ret    

00001253 <fstat>:
SYSCALL(fstat)
    1253:	b8 08 00 00 00       	mov    $0x8,%eax
    1258:	cd 40                	int    $0x40
    125a:	c3                   	ret    

0000125b <link>:
SYSCALL(link)
    125b:	b8 13 00 00 00       	mov    $0x13,%eax
    1260:	cd 40                	int    $0x40
    1262:	c3                   	ret    

00001263 <mkdir>:
SYSCALL(mkdir)
    1263:	b8 14 00 00 00       	mov    $0x14,%eax
    1268:	cd 40                	int    $0x40
    126a:	c3                   	ret    

0000126b <chdir>:
SYSCALL(chdir)
    126b:	b8 09 00 00 00       	mov    $0x9,%eax
    1270:	cd 40                	int    $0x40
    1272:	c3                   	ret    

00001273 <dup>:
SYSCALL(dup)
    1273:	b8 0a 00 00 00       	mov    $0xa,%eax
    1278:	cd 40                	int    $0x40
    127a:	c3                   	ret    

0000127b <getpid>:
SYSCALL(getpid)
    127b:	b8 0b 00 00 00       	mov    $0xb,%eax
    1280:	cd 40                	int    $0x40
    1282:	c3                   	ret    

00001283 <sbrk>:
SYSCALL(sbrk)
    1283:	b8 0c 00 00 00       	mov    $0xc,%eax
    1288:	cd 40                	int    $0x40
    128a:	c3                   	ret    

0000128b <sleep>:
SYSCALL(sleep)
    128b:	b8 0d 00 00 00       	mov    $0xd,%eax
    1290:	cd 40                	int    $0x40
    1292:	c3                   	ret    

00001293 <uptime>:
SYSCALL(uptime)
    1293:	b8 0e 00 00 00       	mov    $0xe,%eax
    1298:	cd 40                	int    $0x40
    129a:	c3                   	ret    

0000129b <settickets>:
SYSCALL(settickets)
    129b:	b8 16 00 00 00       	mov    $0x16,%eax
    12a0:	cd 40                	int    $0x40
    12a2:	c3                   	ret    

000012a3 <getpinfo>:
SYSCALL(getpinfo)
    12a3:	b8 17 00 00 00       	mov    $0x17,%eax
    12a8:	cd 40                	int    $0x40
    12aa:	c3                   	ret    

000012ab <mprotect>:
SYSCALL(mprotect)
    12ab:	b8 18 00 00 00       	mov    $0x18,%eax
    12b0:	cd 40                	int    $0x40
    12b2:	c3                   	ret    

000012b3 <munprotect>:
    12b3:	b8 19 00 00 00       	mov    $0x19,%eax
    12b8:	cd 40                	int    $0x40
    12ba:	c3                   	ret    

000012bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12bb:	55                   	push   %ebp
    12bc:	89 e5                	mov    %esp,%ebp
    12be:	83 ec 1c             	sub    $0x1c,%esp
    12c1:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12c4:	6a 01                	push   $0x1
    12c6:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12c9:	52                   	push   %edx
    12ca:	50                   	push   %eax
    12cb:	e8 4b ff ff ff       	call   121b <write>
}
    12d0:	83 c4 10             	add    $0x10,%esp
    12d3:	c9                   	leave  
    12d4:	c3                   	ret    

000012d5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12d5:	55                   	push   %ebp
    12d6:	89 e5                	mov    %esp,%ebp
    12d8:	57                   	push   %edi
    12d9:	56                   	push   %esi
    12da:	53                   	push   %ebx
    12db:	83 ec 2c             	sub    $0x2c,%esp
    12de:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12e1:	89 d0                	mov    %edx,%eax
    12e3:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12e9:	0f 95 c1             	setne  %cl
    12ec:	c1 ea 1f             	shr    $0x1f,%edx
    12ef:	84 d1                	test   %dl,%cl
    12f1:	74 44                	je     1337 <printint+0x62>
    neg = 1;
    x = -xx;
    12f3:	f7 d8                	neg    %eax
    12f5:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12f7:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12fe:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1303:	89 c8                	mov    %ecx,%eax
    1305:	ba 00 00 00 00       	mov    $0x0,%edx
    130a:	f7 f6                	div    %esi
    130c:	89 df                	mov    %ebx,%edi
    130e:	83 c3 01             	add    $0x1,%ebx
    1311:	0f b6 92 98 16 00 00 	movzbl 0x1698(%edx),%edx
    1318:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    131c:	89 ca                	mov    %ecx,%edx
    131e:	89 c1                	mov    %eax,%ecx
    1320:	39 d6                	cmp    %edx,%esi
    1322:	76 df                	jbe    1303 <printint+0x2e>
  if(neg)
    1324:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1328:	74 31                	je     135b <printint+0x86>
    buf[i++] = '-';
    132a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    132f:	8d 5f 02             	lea    0x2(%edi),%ebx
    1332:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1335:	eb 17                	jmp    134e <printint+0x79>
    x = xx;
    1337:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1339:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1340:	eb bc                	jmp    12fe <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1342:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1347:	89 f0                	mov    %esi,%eax
    1349:	e8 6d ff ff ff       	call   12bb <putc>
  while(--i >= 0)
    134e:	83 eb 01             	sub    $0x1,%ebx
    1351:	79 ef                	jns    1342 <printint+0x6d>
}
    1353:	83 c4 2c             	add    $0x2c,%esp
    1356:	5b                   	pop    %ebx
    1357:	5e                   	pop    %esi
    1358:	5f                   	pop    %edi
    1359:	5d                   	pop    %ebp
    135a:	c3                   	ret    
    135b:	8b 75 d0             	mov    -0x30(%ebp),%esi
    135e:	eb ee                	jmp    134e <printint+0x79>

00001360 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	56                   	push   %esi
    1365:	53                   	push   %ebx
    1366:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1369:	8d 45 10             	lea    0x10(%ebp),%eax
    136c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    136f:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1374:	bb 00 00 00 00       	mov    $0x0,%ebx
    1379:	eb 14                	jmp    138f <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    137b:	89 fa                	mov    %edi,%edx
    137d:	8b 45 08             	mov    0x8(%ebp),%eax
    1380:	e8 36 ff ff ff       	call   12bb <putc>
    1385:	eb 05                	jmp    138c <printf+0x2c>
      }
    } else if(state == '%'){
    1387:	83 fe 25             	cmp    $0x25,%esi
    138a:	74 25                	je     13b1 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    138c:	83 c3 01             	add    $0x1,%ebx
    138f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1392:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1396:	84 c0                	test   %al,%al
    1398:	0f 84 20 01 00 00    	je     14be <printf+0x15e>
    c = fmt[i] & 0xff;
    139e:	0f be f8             	movsbl %al,%edi
    13a1:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13a4:	85 f6                	test   %esi,%esi
    13a6:	75 df                	jne    1387 <printf+0x27>
      if(c == '%'){
    13a8:	83 f8 25             	cmp    $0x25,%eax
    13ab:	75 ce                	jne    137b <printf+0x1b>
        state = '%';
    13ad:	89 c6                	mov    %eax,%esi
    13af:	eb db                	jmp    138c <printf+0x2c>
      if(c == 'd'){
    13b1:	83 f8 25             	cmp    $0x25,%eax
    13b4:	0f 84 cf 00 00 00    	je     1489 <printf+0x129>
    13ba:	0f 8c dd 00 00 00    	jl     149d <printf+0x13d>
    13c0:	83 f8 78             	cmp    $0x78,%eax
    13c3:	0f 8f d4 00 00 00    	jg     149d <printf+0x13d>
    13c9:	83 f8 63             	cmp    $0x63,%eax
    13cc:	0f 8c cb 00 00 00    	jl     149d <printf+0x13d>
    13d2:	83 e8 63             	sub    $0x63,%eax
    13d5:	83 f8 15             	cmp    $0x15,%eax
    13d8:	0f 87 bf 00 00 00    	ja     149d <printf+0x13d>
    13de:	ff 24 85 40 16 00 00 	jmp    *0x1640(,%eax,4)
        printint(fd, *ap, 10, 1);
    13e5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13e8:	8b 17                	mov    (%edi),%edx
    13ea:	83 ec 0c             	sub    $0xc,%esp
    13ed:	6a 01                	push   $0x1
    13ef:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13f4:	8b 45 08             	mov    0x8(%ebp),%eax
    13f7:	e8 d9 fe ff ff       	call   12d5 <printint>
        ap++;
    13fc:	83 c7 04             	add    $0x4,%edi
    13ff:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1402:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1405:	be 00 00 00 00       	mov    $0x0,%esi
    140a:	eb 80                	jmp    138c <printf+0x2c>
        printint(fd, *ap, 16, 0);
    140c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    140f:	8b 17                	mov    (%edi),%edx
    1411:	83 ec 0c             	sub    $0xc,%esp
    1414:	6a 00                	push   $0x0
    1416:	b9 10 00 00 00       	mov    $0x10,%ecx
    141b:	8b 45 08             	mov    0x8(%ebp),%eax
    141e:	e8 b2 fe ff ff       	call   12d5 <printint>
        ap++;
    1423:	83 c7 04             	add    $0x4,%edi
    1426:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1429:	83 c4 10             	add    $0x10,%esp
      state = 0;
    142c:	be 00 00 00 00       	mov    $0x0,%esi
    1431:	e9 56 ff ff ff       	jmp    138c <printf+0x2c>
        s = (char*)*ap;
    1436:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1439:	8b 30                	mov    (%eax),%esi
        ap++;
    143b:	83 c0 04             	add    $0x4,%eax
    143e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1441:	85 f6                	test   %esi,%esi
    1443:	75 15                	jne    145a <printf+0xfa>
          s = "(null)";
    1445:	be 37 16 00 00       	mov    $0x1637,%esi
    144a:	eb 0e                	jmp    145a <printf+0xfa>
          putc(fd, *s);
    144c:	0f be d2             	movsbl %dl,%edx
    144f:	8b 45 08             	mov    0x8(%ebp),%eax
    1452:	e8 64 fe ff ff       	call   12bb <putc>
          s++;
    1457:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    145a:	0f b6 16             	movzbl (%esi),%edx
    145d:	84 d2                	test   %dl,%dl
    145f:	75 eb                	jne    144c <printf+0xec>
      state = 0;
    1461:	be 00 00 00 00       	mov    $0x0,%esi
    1466:	e9 21 ff ff ff       	jmp    138c <printf+0x2c>
        putc(fd, *ap);
    146b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    146e:	0f be 17             	movsbl (%edi),%edx
    1471:	8b 45 08             	mov    0x8(%ebp),%eax
    1474:	e8 42 fe ff ff       	call   12bb <putc>
        ap++;
    1479:	83 c7 04             	add    $0x4,%edi
    147c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    147f:	be 00 00 00 00       	mov    $0x0,%esi
    1484:	e9 03 ff ff ff       	jmp    138c <printf+0x2c>
        putc(fd, c);
    1489:	89 fa                	mov    %edi,%edx
    148b:	8b 45 08             	mov    0x8(%ebp),%eax
    148e:	e8 28 fe ff ff       	call   12bb <putc>
      state = 0;
    1493:	be 00 00 00 00       	mov    $0x0,%esi
    1498:	e9 ef fe ff ff       	jmp    138c <printf+0x2c>
        putc(fd, '%');
    149d:	ba 25 00 00 00       	mov    $0x25,%edx
    14a2:	8b 45 08             	mov    0x8(%ebp),%eax
    14a5:	e8 11 fe ff ff       	call   12bb <putc>
        putc(fd, c);
    14aa:	89 fa                	mov    %edi,%edx
    14ac:	8b 45 08             	mov    0x8(%ebp),%eax
    14af:	e8 07 fe ff ff       	call   12bb <putc>
      state = 0;
    14b4:	be 00 00 00 00       	mov    $0x0,%esi
    14b9:	e9 ce fe ff ff       	jmp    138c <printf+0x2c>
    }
  }
}
    14be:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14c1:	5b                   	pop    %ebx
    14c2:	5e                   	pop    %esi
    14c3:	5f                   	pop    %edi
    14c4:	5d                   	pop    %ebp
    14c5:	c3                   	ret    

000014c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c6:	55                   	push   %ebp
    14c7:	89 e5                	mov    %esp,%ebp
    14c9:	57                   	push   %edi
    14ca:	56                   	push   %esi
    14cb:	53                   	push   %ebx
    14cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14cf:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d2:	a1 3c 19 00 00       	mov    0x193c,%eax
    14d7:	eb 02                	jmp    14db <free+0x15>
    14d9:	89 d0                	mov    %edx,%eax
    14db:	39 c8                	cmp    %ecx,%eax
    14dd:	73 04                	jae    14e3 <free+0x1d>
    14df:	39 08                	cmp    %ecx,(%eax)
    14e1:	77 12                	ja     14f5 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14e3:	8b 10                	mov    (%eax),%edx
    14e5:	39 c2                	cmp    %eax,%edx
    14e7:	77 f0                	ja     14d9 <free+0x13>
    14e9:	39 c8                	cmp    %ecx,%eax
    14eb:	72 08                	jb     14f5 <free+0x2f>
    14ed:	39 ca                	cmp    %ecx,%edx
    14ef:	77 04                	ja     14f5 <free+0x2f>
    14f1:	89 d0                	mov    %edx,%eax
    14f3:	eb e6                	jmp    14db <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14f5:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14f8:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14fb:	8b 10                	mov    (%eax),%edx
    14fd:	39 d7                	cmp    %edx,%edi
    14ff:	74 19                	je     151a <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1501:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1504:	8b 50 04             	mov    0x4(%eax),%edx
    1507:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    150a:	39 ce                	cmp    %ecx,%esi
    150c:	74 1b                	je     1529 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    150e:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1510:	a3 3c 19 00 00       	mov    %eax,0x193c
}
    1515:	5b                   	pop    %ebx
    1516:	5e                   	pop    %esi
    1517:	5f                   	pop    %edi
    1518:	5d                   	pop    %ebp
    1519:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    151a:	03 72 04             	add    0x4(%edx),%esi
    151d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1520:	8b 10                	mov    (%eax),%edx
    1522:	8b 12                	mov    (%edx),%edx
    1524:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1527:	eb db                	jmp    1504 <free+0x3e>
    p->s.size += bp->s.size;
    1529:	03 53 fc             	add    -0x4(%ebx),%edx
    152c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    152f:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1532:	89 10                	mov    %edx,(%eax)
    1534:	eb da                	jmp    1510 <free+0x4a>

00001536 <morecore>:

static Header*
morecore(uint nu)
{
    1536:	55                   	push   %ebp
    1537:	89 e5                	mov    %esp,%ebp
    1539:	53                   	push   %ebx
    153a:	83 ec 04             	sub    $0x4,%esp
    153d:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    153f:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1544:	77 05                	ja     154b <morecore+0x15>
    nu = 4096;
    1546:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    154b:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1552:	83 ec 0c             	sub    $0xc,%esp
    1555:	50                   	push   %eax
    1556:	e8 28 fd ff ff       	call   1283 <sbrk>
  if(p == (char*)-1)
    155b:	83 c4 10             	add    $0x10,%esp
    155e:	83 f8 ff             	cmp    $0xffffffff,%eax
    1561:	74 1c                	je     157f <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1563:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1566:	83 c0 08             	add    $0x8,%eax
    1569:	83 ec 0c             	sub    $0xc,%esp
    156c:	50                   	push   %eax
    156d:	e8 54 ff ff ff       	call   14c6 <free>
  return freep;
    1572:	a1 3c 19 00 00       	mov    0x193c,%eax
    1577:	83 c4 10             	add    $0x10,%esp
}
    157a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    157d:	c9                   	leave  
    157e:	c3                   	ret    
    return 0;
    157f:	b8 00 00 00 00       	mov    $0x0,%eax
    1584:	eb f4                	jmp    157a <morecore+0x44>

00001586 <malloc>:

void*
malloc(uint nbytes)
{
    1586:	55                   	push   %ebp
    1587:	89 e5                	mov    %esp,%ebp
    1589:	53                   	push   %ebx
    158a:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    158d:	8b 45 08             	mov    0x8(%ebp),%eax
    1590:	8d 58 07             	lea    0x7(%eax),%ebx
    1593:	c1 eb 03             	shr    $0x3,%ebx
    1596:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1599:	8b 0d 3c 19 00 00    	mov    0x193c,%ecx
    159f:	85 c9                	test   %ecx,%ecx
    15a1:	74 04                	je     15a7 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a3:	8b 01                	mov    (%ecx),%eax
    15a5:	eb 4a                	jmp    15f1 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15a7:	c7 05 3c 19 00 00 40 	movl   $0x1940,0x193c
    15ae:	19 00 00 
    15b1:	c7 05 40 19 00 00 40 	movl   $0x1940,0x1940
    15b8:	19 00 00 
    base.s.size = 0;
    15bb:	c7 05 44 19 00 00 00 	movl   $0x0,0x1944
    15c2:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15c5:	b9 40 19 00 00       	mov    $0x1940,%ecx
    15ca:	eb d7                	jmp    15a3 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15cc:	74 19                	je     15e7 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15ce:	29 da                	sub    %ebx,%edx
    15d0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15d3:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15d6:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15d9:	89 0d 3c 19 00 00    	mov    %ecx,0x193c
      return (void*)(p + 1);
    15df:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15e5:	c9                   	leave  
    15e6:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15e7:	8b 10                	mov    (%eax),%edx
    15e9:	89 11                	mov    %edx,(%ecx)
    15eb:	eb ec                	jmp    15d9 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15ed:	89 c1                	mov    %eax,%ecx
    15ef:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15f1:	8b 50 04             	mov    0x4(%eax),%edx
    15f4:	39 da                	cmp    %ebx,%edx
    15f6:	73 d4                	jae    15cc <malloc+0x46>
    if(p == freep)
    15f8:	39 05 3c 19 00 00    	cmp    %eax,0x193c
    15fe:	75 ed                	jne    15ed <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1600:	89 d8                	mov    %ebx,%eax
    1602:	e8 2f ff ff ff       	call   1536 <morecore>
    1607:	85 c0                	test   %eax,%eax
    1609:	75 e2                	jne    15ed <malloc+0x67>
    160b:	eb d5                	jmp    15e2 <malloc+0x5c>
