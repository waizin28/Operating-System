
_test_11:     file format elf32-i386


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
    100d:	56                   	push   %esi
    100e:	53                   	push   %ebx
    100f:	51                   	push   %ecx
    1010:	83 ec 0c             	sub    $0xc,%esp
    1013:	8b 59 04             	mov    0x4(%ecx),%ebx
   int ppid = getpid();
    1016:	e8 7b 02 00 00       	call   1296 <getpid>
    101b:	89 c6                	mov    %eax,%esi

   if (fork() == 0) {     
    101d:	e8 ec 01 00 00       	call   120e <fork>
    1022:	85 c0                	test   %eax,%eax
    1024:	75 38                	jne    105e <main+0x5e>

      int *p = (int *)atoi(argv[1]);
    1026:	83 ec 0c             	sub    $0xc,%esp
    1029:	ff 73 04             	push   0x4(%ebx)
    102c:	e8 81 01 00 00       	call   11b2 <atoi>
      printf(1, "%d\n", *p);
    1031:	83 c4 0c             	add    $0xc,%esp
    1034:	ff 30                	push   (%eax)
    1036:	68 28 16 00 00       	push   $0x1628
    103b:	6a 01                	push   $0x1
    103d:	e8 39 03 00 00       	call   137b <printf>

      printf(1, "XV6_VM\t FAILED\n");
    1042:	83 c4 08             	add    $0x8,%esp
    1045:	68 2c 16 00 00       	push   $0x162c
    104a:	6a 01                	push   $0x1
    104c:	e8 2a 03 00 00       	call   137b <printf>
      
      kill(ppid);
    1051:	89 34 24             	mov    %esi,(%esp)
    1054:	e8 ed 01 00 00       	call   1246 <kill>
      
      exit();
    1059:	e8 b8 01 00 00       	call   1216 <exit>
   } else {
      wait();
    105e:	e8 bb 01 00 00       	call   121e <wait>
   }

   printf(1, "XV6_VM\t SUCCESS\n");
    1063:	83 ec 08             	sub    $0x8,%esp
    1066:	68 3c 16 00 00       	push   $0x163c
    106b:	6a 01                	push   $0x1
    106d:	e8 09 03 00 00       	call   137b <printf>
   exit();
    1072:	e8 9f 01 00 00       	call   1216 <exit>

00001077 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1077:	55                   	push   %ebp
    1078:	89 e5                	mov    %esp,%ebp
    107a:	56                   	push   %esi
    107b:	53                   	push   %ebx
    107c:	8b 75 08             	mov    0x8(%ebp),%esi
    107f:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1082:	89 f0                	mov    %esi,%eax
    1084:	89 d1                	mov    %edx,%ecx
    1086:	83 c2 01             	add    $0x1,%edx
    1089:	89 c3                	mov    %eax,%ebx
    108b:	83 c0 01             	add    $0x1,%eax
    108e:	0f b6 09             	movzbl (%ecx),%ecx
    1091:	88 0b                	mov    %cl,(%ebx)
    1093:	84 c9                	test   %cl,%cl
    1095:	75 ed                	jne    1084 <strcpy+0xd>
    ;
  return os;
}
    1097:	89 f0                	mov    %esi,%eax
    1099:	5b                   	pop    %ebx
    109a:	5e                   	pop    %esi
    109b:	5d                   	pop    %ebp
    109c:	c3                   	ret    

0000109d <strcmp>:

int
strcmp(const char *p, const char *q)
{
    109d:	55                   	push   %ebp
    109e:	89 e5                	mov    %esp,%ebp
    10a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10a6:	eb 06                	jmp    10ae <strcmp+0x11>
    p++, q++;
    10a8:	83 c1 01             	add    $0x1,%ecx
    10ab:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10ae:	0f b6 01             	movzbl (%ecx),%eax
    10b1:	84 c0                	test   %al,%al
    10b3:	74 04                	je     10b9 <strcmp+0x1c>
    10b5:	3a 02                	cmp    (%edx),%al
    10b7:	74 ef                	je     10a8 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    10b9:	0f b6 c0             	movzbl %al,%eax
    10bc:	0f b6 12             	movzbl (%edx),%edx
    10bf:	29 d0                	sub    %edx,%eax
}
    10c1:	5d                   	pop    %ebp
    10c2:	c3                   	ret    

000010c3 <strlen>:

uint
strlen(const char *s)
{
    10c3:	55                   	push   %ebp
    10c4:	89 e5                	mov    %esp,%ebp
    10c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10c9:	b8 00 00 00 00       	mov    $0x0,%eax
    10ce:	eb 03                	jmp    10d3 <strlen+0x10>
    10d0:	83 c0 01             	add    $0x1,%eax
    10d3:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10d7:	75 f7                	jne    10d0 <strlen+0xd>
    ;
  return n;
}
    10d9:	5d                   	pop    %ebp
    10da:	c3                   	ret    

000010db <memset>:

void*
memset(void *dst, int c, uint n)
{
    10db:	55                   	push   %ebp
    10dc:	89 e5                	mov    %esp,%ebp
    10de:	57                   	push   %edi
    10df:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10e2:	89 d7                	mov    %edx,%edi
    10e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ea:	fc                   	cld    
    10eb:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10ed:	89 d0                	mov    %edx,%eax
    10ef:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10f2:	c9                   	leave  
    10f3:	c3                   	ret    

000010f4 <strchr>:

char*
strchr(const char *s, char c)
{
    10f4:	55                   	push   %ebp
    10f5:	89 e5                	mov    %esp,%ebp
    10f7:	8b 45 08             	mov    0x8(%ebp),%eax
    10fa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10fe:	eb 03                	jmp    1103 <strchr+0xf>
    1100:	83 c0 01             	add    $0x1,%eax
    1103:	0f b6 10             	movzbl (%eax),%edx
    1106:	84 d2                	test   %dl,%dl
    1108:	74 06                	je     1110 <strchr+0x1c>
    if(*s == c)
    110a:	38 ca                	cmp    %cl,%dl
    110c:	75 f2                	jne    1100 <strchr+0xc>
    110e:	eb 05                	jmp    1115 <strchr+0x21>
      return (char*)s;
  return 0;
    1110:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1115:	5d                   	pop    %ebp
    1116:	c3                   	ret    

00001117 <gets>:

char*
gets(char *buf, int max)
{
    1117:	55                   	push   %ebp
    1118:	89 e5                	mov    %esp,%ebp
    111a:	57                   	push   %edi
    111b:	56                   	push   %esi
    111c:	53                   	push   %ebx
    111d:	83 ec 1c             	sub    $0x1c,%esp
    1120:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1123:	bb 00 00 00 00       	mov    $0x0,%ebx
    1128:	89 de                	mov    %ebx,%esi
    112a:	83 c3 01             	add    $0x1,%ebx
    112d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1130:	7d 2e                	jge    1160 <gets+0x49>
    cc = read(0, &c, 1);
    1132:	83 ec 04             	sub    $0x4,%esp
    1135:	6a 01                	push   $0x1
    1137:	8d 45 e7             	lea    -0x19(%ebp),%eax
    113a:	50                   	push   %eax
    113b:	6a 00                	push   $0x0
    113d:	e8 ec 00 00 00       	call   122e <read>
    if(cc < 1)
    1142:	83 c4 10             	add    $0x10,%esp
    1145:	85 c0                	test   %eax,%eax
    1147:	7e 17                	jle    1160 <gets+0x49>
      break;
    buf[i++] = c;
    1149:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    114d:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1150:	3c 0a                	cmp    $0xa,%al
    1152:	0f 94 c2             	sete   %dl
    1155:	3c 0d                	cmp    $0xd,%al
    1157:	0f 94 c0             	sete   %al
    115a:	08 c2                	or     %al,%dl
    115c:	74 ca                	je     1128 <gets+0x11>
    buf[i++] = c;
    115e:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1160:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1164:	89 f8                	mov    %edi,%eax
    1166:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1169:	5b                   	pop    %ebx
    116a:	5e                   	pop    %esi
    116b:	5f                   	pop    %edi
    116c:	5d                   	pop    %ebp
    116d:	c3                   	ret    

0000116e <stat>:

int
stat(const char *n, struct stat *st)
{
    116e:	55                   	push   %ebp
    116f:	89 e5                	mov    %esp,%ebp
    1171:	56                   	push   %esi
    1172:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1173:	83 ec 08             	sub    $0x8,%esp
    1176:	6a 00                	push   $0x0
    1178:	ff 75 08             	push   0x8(%ebp)
    117b:	e8 d6 00 00 00       	call   1256 <open>
  if(fd < 0)
    1180:	83 c4 10             	add    $0x10,%esp
    1183:	85 c0                	test   %eax,%eax
    1185:	78 24                	js     11ab <stat+0x3d>
    1187:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1189:	83 ec 08             	sub    $0x8,%esp
    118c:	ff 75 0c             	push   0xc(%ebp)
    118f:	50                   	push   %eax
    1190:	e8 d9 00 00 00       	call   126e <fstat>
    1195:	89 c6                	mov    %eax,%esi
  close(fd);
    1197:	89 1c 24             	mov    %ebx,(%esp)
    119a:	e8 9f 00 00 00       	call   123e <close>
  return r;
    119f:	83 c4 10             	add    $0x10,%esp
}
    11a2:	89 f0                	mov    %esi,%eax
    11a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11a7:	5b                   	pop    %ebx
    11a8:	5e                   	pop    %esi
    11a9:	5d                   	pop    %ebp
    11aa:	c3                   	ret    
    return -1;
    11ab:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11b0:	eb f0                	jmp    11a2 <stat+0x34>

000011b2 <atoi>:

int
atoi(const char *s)
{
    11b2:	55                   	push   %ebp
    11b3:	89 e5                	mov    %esp,%ebp
    11b5:	53                   	push   %ebx
    11b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    11b9:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11be:	eb 10                	jmp    11d0 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11c0:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11c3:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11c6:	83 c1 01             	add    $0x1,%ecx
    11c9:	0f be c0             	movsbl %al,%eax
    11cc:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11d0:	0f b6 01             	movzbl (%ecx),%eax
    11d3:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11d6:	80 fb 09             	cmp    $0x9,%bl
    11d9:	76 e5                	jbe    11c0 <atoi+0xe>
  return n;
}
    11db:	89 d0                	mov    %edx,%eax
    11dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e0:	c9                   	leave  
    11e1:	c3                   	ret    

000011e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11e2:	55                   	push   %ebp
    11e3:	89 e5                	mov    %esp,%ebp
    11e5:	56                   	push   %esi
    11e6:	53                   	push   %ebx
    11e7:	8b 75 08             	mov    0x8(%ebp),%esi
    11ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11ed:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11f0:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11f2:	eb 0d                	jmp    1201 <memmove+0x1f>
    *dst++ = *src++;
    11f4:	0f b6 01             	movzbl (%ecx),%eax
    11f7:	88 02                	mov    %al,(%edx)
    11f9:	8d 49 01             	lea    0x1(%ecx),%ecx
    11fc:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11ff:	89 d8                	mov    %ebx,%eax
    1201:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1204:	85 c0                	test   %eax,%eax
    1206:	7f ec                	jg     11f4 <memmove+0x12>
  return vdst;
}
    1208:	89 f0                	mov    %esi,%eax
    120a:	5b                   	pop    %ebx
    120b:	5e                   	pop    %esi
    120c:	5d                   	pop    %ebp
    120d:	c3                   	ret    

0000120e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    120e:	b8 01 00 00 00       	mov    $0x1,%eax
    1213:	cd 40                	int    $0x40
    1215:	c3                   	ret    

00001216 <exit>:
SYSCALL(exit)
    1216:	b8 02 00 00 00       	mov    $0x2,%eax
    121b:	cd 40                	int    $0x40
    121d:	c3                   	ret    

0000121e <wait>:
SYSCALL(wait)
    121e:	b8 03 00 00 00       	mov    $0x3,%eax
    1223:	cd 40                	int    $0x40
    1225:	c3                   	ret    

00001226 <pipe>:
SYSCALL(pipe)
    1226:	b8 04 00 00 00       	mov    $0x4,%eax
    122b:	cd 40                	int    $0x40
    122d:	c3                   	ret    

0000122e <read>:
SYSCALL(read)
    122e:	b8 05 00 00 00       	mov    $0x5,%eax
    1233:	cd 40                	int    $0x40
    1235:	c3                   	ret    

00001236 <write>:
SYSCALL(write)
    1236:	b8 10 00 00 00       	mov    $0x10,%eax
    123b:	cd 40                	int    $0x40
    123d:	c3                   	ret    

0000123e <close>:
SYSCALL(close)
    123e:	b8 15 00 00 00       	mov    $0x15,%eax
    1243:	cd 40                	int    $0x40
    1245:	c3                   	ret    

00001246 <kill>:
SYSCALL(kill)
    1246:	b8 06 00 00 00       	mov    $0x6,%eax
    124b:	cd 40                	int    $0x40
    124d:	c3                   	ret    

0000124e <exec>:
SYSCALL(exec)
    124e:	b8 07 00 00 00       	mov    $0x7,%eax
    1253:	cd 40                	int    $0x40
    1255:	c3                   	ret    

00001256 <open>:
SYSCALL(open)
    1256:	b8 0f 00 00 00       	mov    $0xf,%eax
    125b:	cd 40                	int    $0x40
    125d:	c3                   	ret    

0000125e <mknod>:
SYSCALL(mknod)
    125e:	b8 11 00 00 00       	mov    $0x11,%eax
    1263:	cd 40                	int    $0x40
    1265:	c3                   	ret    

00001266 <unlink>:
SYSCALL(unlink)
    1266:	b8 12 00 00 00       	mov    $0x12,%eax
    126b:	cd 40                	int    $0x40
    126d:	c3                   	ret    

0000126e <fstat>:
SYSCALL(fstat)
    126e:	b8 08 00 00 00       	mov    $0x8,%eax
    1273:	cd 40                	int    $0x40
    1275:	c3                   	ret    

00001276 <link>:
SYSCALL(link)
    1276:	b8 13 00 00 00       	mov    $0x13,%eax
    127b:	cd 40                	int    $0x40
    127d:	c3                   	ret    

0000127e <mkdir>:
SYSCALL(mkdir)
    127e:	b8 14 00 00 00       	mov    $0x14,%eax
    1283:	cd 40                	int    $0x40
    1285:	c3                   	ret    

00001286 <chdir>:
SYSCALL(chdir)
    1286:	b8 09 00 00 00       	mov    $0x9,%eax
    128b:	cd 40                	int    $0x40
    128d:	c3                   	ret    

0000128e <dup>:
SYSCALL(dup)
    128e:	b8 0a 00 00 00       	mov    $0xa,%eax
    1293:	cd 40                	int    $0x40
    1295:	c3                   	ret    

00001296 <getpid>:
SYSCALL(getpid)
    1296:	b8 0b 00 00 00       	mov    $0xb,%eax
    129b:	cd 40                	int    $0x40
    129d:	c3                   	ret    

0000129e <sbrk>:
SYSCALL(sbrk)
    129e:	b8 0c 00 00 00       	mov    $0xc,%eax
    12a3:	cd 40                	int    $0x40
    12a5:	c3                   	ret    

000012a6 <sleep>:
SYSCALL(sleep)
    12a6:	b8 0d 00 00 00       	mov    $0xd,%eax
    12ab:	cd 40                	int    $0x40
    12ad:	c3                   	ret    

000012ae <uptime>:
SYSCALL(uptime)
    12ae:	b8 0e 00 00 00       	mov    $0xe,%eax
    12b3:	cd 40                	int    $0x40
    12b5:	c3                   	ret    

000012b6 <settickets>:
SYSCALL(settickets)
    12b6:	b8 16 00 00 00       	mov    $0x16,%eax
    12bb:	cd 40                	int    $0x40
    12bd:	c3                   	ret    

000012be <getpinfo>:
SYSCALL(getpinfo)
    12be:	b8 17 00 00 00       	mov    $0x17,%eax
    12c3:	cd 40                	int    $0x40
    12c5:	c3                   	ret    

000012c6 <mprotect>:
SYSCALL(mprotect)
    12c6:	b8 18 00 00 00       	mov    $0x18,%eax
    12cb:	cd 40                	int    $0x40
    12cd:	c3                   	ret    

000012ce <munprotect>:
    12ce:	b8 19 00 00 00       	mov    $0x19,%eax
    12d3:	cd 40                	int    $0x40
    12d5:	c3                   	ret    

000012d6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12d6:	55                   	push   %ebp
    12d7:	89 e5                	mov    %esp,%ebp
    12d9:	83 ec 1c             	sub    $0x1c,%esp
    12dc:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12df:	6a 01                	push   $0x1
    12e1:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12e4:	52                   	push   %edx
    12e5:	50                   	push   %eax
    12e6:	e8 4b ff ff ff       	call   1236 <write>
}
    12eb:	83 c4 10             	add    $0x10,%esp
    12ee:	c9                   	leave  
    12ef:	c3                   	ret    

000012f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	57                   	push   %edi
    12f4:	56                   	push   %esi
    12f5:	53                   	push   %ebx
    12f6:	83 ec 2c             	sub    $0x2c,%esp
    12f9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12fc:	89 d0                	mov    %edx,%eax
    12fe:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1300:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1304:	0f 95 c1             	setne  %cl
    1307:	c1 ea 1f             	shr    $0x1f,%edx
    130a:	84 d1                	test   %dl,%cl
    130c:	74 44                	je     1352 <printint+0x62>
    neg = 1;
    x = -xx;
    130e:	f7 d8                	neg    %eax
    1310:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1312:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1319:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    131e:	89 c8                	mov    %ecx,%eax
    1320:	ba 00 00 00 00       	mov    $0x0,%edx
    1325:	f7 f6                	div    %esi
    1327:	89 df                	mov    %ebx,%edi
    1329:	83 c3 01             	add    $0x1,%ebx
    132c:	0f b6 92 ac 16 00 00 	movzbl 0x16ac(%edx),%edx
    1333:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1337:	89 ca                	mov    %ecx,%edx
    1339:	89 c1                	mov    %eax,%ecx
    133b:	39 d6                	cmp    %edx,%esi
    133d:	76 df                	jbe    131e <printint+0x2e>
  if(neg)
    133f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1343:	74 31                	je     1376 <printint+0x86>
    buf[i++] = '-';
    1345:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    134a:	8d 5f 02             	lea    0x2(%edi),%ebx
    134d:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1350:	eb 17                	jmp    1369 <printint+0x79>
    x = xx;
    1352:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1354:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    135b:	eb bc                	jmp    1319 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    135d:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1362:	89 f0                	mov    %esi,%eax
    1364:	e8 6d ff ff ff       	call   12d6 <putc>
  while(--i >= 0)
    1369:	83 eb 01             	sub    $0x1,%ebx
    136c:	79 ef                	jns    135d <printint+0x6d>
}
    136e:	83 c4 2c             	add    $0x2c,%esp
    1371:	5b                   	pop    %ebx
    1372:	5e                   	pop    %esi
    1373:	5f                   	pop    %edi
    1374:	5d                   	pop    %ebp
    1375:	c3                   	ret    
    1376:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1379:	eb ee                	jmp    1369 <printint+0x79>

0000137b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    137b:	55                   	push   %ebp
    137c:	89 e5                	mov    %esp,%ebp
    137e:	57                   	push   %edi
    137f:	56                   	push   %esi
    1380:	53                   	push   %ebx
    1381:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1384:	8d 45 10             	lea    0x10(%ebp),%eax
    1387:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    138a:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    138f:	bb 00 00 00 00       	mov    $0x0,%ebx
    1394:	eb 14                	jmp    13aa <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1396:	89 fa                	mov    %edi,%edx
    1398:	8b 45 08             	mov    0x8(%ebp),%eax
    139b:	e8 36 ff ff ff       	call   12d6 <putc>
    13a0:	eb 05                	jmp    13a7 <printf+0x2c>
      }
    } else if(state == '%'){
    13a2:	83 fe 25             	cmp    $0x25,%esi
    13a5:	74 25                	je     13cc <printf+0x51>
  for(i = 0; fmt[i]; i++){
    13a7:	83 c3 01             	add    $0x1,%ebx
    13aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ad:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    13b1:	84 c0                	test   %al,%al
    13b3:	0f 84 20 01 00 00    	je     14d9 <printf+0x15e>
    c = fmt[i] & 0xff;
    13b9:	0f be f8             	movsbl %al,%edi
    13bc:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13bf:	85 f6                	test   %esi,%esi
    13c1:	75 df                	jne    13a2 <printf+0x27>
      if(c == '%'){
    13c3:	83 f8 25             	cmp    $0x25,%eax
    13c6:	75 ce                	jne    1396 <printf+0x1b>
        state = '%';
    13c8:	89 c6                	mov    %eax,%esi
    13ca:	eb db                	jmp    13a7 <printf+0x2c>
      if(c == 'd'){
    13cc:	83 f8 25             	cmp    $0x25,%eax
    13cf:	0f 84 cf 00 00 00    	je     14a4 <printf+0x129>
    13d5:	0f 8c dd 00 00 00    	jl     14b8 <printf+0x13d>
    13db:	83 f8 78             	cmp    $0x78,%eax
    13de:	0f 8f d4 00 00 00    	jg     14b8 <printf+0x13d>
    13e4:	83 f8 63             	cmp    $0x63,%eax
    13e7:	0f 8c cb 00 00 00    	jl     14b8 <printf+0x13d>
    13ed:	83 e8 63             	sub    $0x63,%eax
    13f0:	83 f8 15             	cmp    $0x15,%eax
    13f3:	0f 87 bf 00 00 00    	ja     14b8 <printf+0x13d>
    13f9:	ff 24 85 54 16 00 00 	jmp    *0x1654(,%eax,4)
        printint(fd, *ap, 10, 1);
    1400:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1403:	8b 17                	mov    (%edi),%edx
    1405:	83 ec 0c             	sub    $0xc,%esp
    1408:	6a 01                	push   $0x1
    140a:	b9 0a 00 00 00       	mov    $0xa,%ecx
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
    1412:	e8 d9 fe ff ff       	call   12f0 <printint>
        ap++;
    1417:	83 c7 04             	add    $0x4,%edi
    141a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    141d:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1420:	be 00 00 00 00       	mov    $0x0,%esi
    1425:	eb 80                	jmp    13a7 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1427:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    142a:	8b 17                	mov    (%edi),%edx
    142c:	83 ec 0c             	sub    $0xc,%esp
    142f:	6a 00                	push   $0x0
    1431:	b9 10 00 00 00       	mov    $0x10,%ecx
    1436:	8b 45 08             	mov    0x8(%ebp),%eax
    1439:	e8 b2 fe ff ff       	call   12f0 <printint>
        ap++;
    143e:	83 c7 04             	add    $0x4,%edi
    1441:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1444:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1447:	be 00 00 00 00       	mov    $0x0,%esi
    144c:	e9 56 ff ff ff       	jmp    13a7 <printf+0x2c>
        s = (char*)*ap;
    1451:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1454:	8b 30                	mov    (%eax),%esi
        ap++;
    1456:	83 c0 04             	add    $0x4,%eax
    1459:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    145c:	85 f6                	test   %esi,%esi
    145e:	75 15                	jne    1475 <printf+0xfa>
          s = "(null)";
    1460:	be 4d 16 00 00       	mov    $0x164d,%esi
    1465:	eb 0e                	jmp    1475 <printf+0xfa>
          putc(fd, *s);
    1467:	0f be d2             	movsbl %dl,%edx
    146a:	8b 45 08             	mov    0x8(%ebp),%eax
    146d:	e8 64 fe ff ff       	call   12d6 <putc>
          s++;
    1472:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1475:	0f b6 16             	movzbl (%esi),%edx
    1478:	84 d2                	test   %dl,%dl
    147a:	75 eb                	jne    1467 <printf+0xec>
      state = 0;
    147c:	be 00 00 00 00       	mov    $0x0,%esi
    1481:	e9 21 ff ff ff       	jmp    13a7 <printf+0x2c>
        putc(fd, *ap);
    1486:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1489:	0f be 17             	movsbl (%edi),%edx
    148c:	8b 45 08             	mov    0x8(%ebp),%eax
    148f:	e8 42 fe ff ff       	call   12d6 <putc>
        ap++;
    1494:	83 c7 04             	add    $0x4,%edi
    1497:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    149a:	be 00 00 00 00       	mov    $0x0,%esi
    149f:	e9 03 ff ff ff       	jmp    13a7 <printf+0x2c>
        putc(fd, c);
    14a4:	89 fa                	mov    %edi,%edx
    14a6:	8b 45 08             	mov    0x8(%ebp),%eax
    14a9:	e8 28 fe ff ff       	call   12d6 <putc>
      state = 0;
    14ae:	be 00 00 00 00       	mov    $0x0,%esi
    14b3:	e9 ef fe ff ff       	jmp    13a7 <printf+0x2c>
        putc(fd, '%');
    14b8:	ba 25 00 00 00       	mov    $0x25,%edx
    14bd:	8b 45 08             	mov    0x8(%ebp),%eax
    14c0:	e8 11 fe ff ff       	call   12d6 <putc>
        putc(fd, c);
    14c5:	89 fa                	mov    %edi,%edx
    14c7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ca:	e8 07 fe ff ff       	call   12d6 <putc>
      state = 0;
    14cf:	be 00 00 00 00       	mov    $0x0,%esi
    14d4:	e9 ce fe ff ff       	jmp    13a7 <printf+0x2c>
    }
  }
}
    14d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14dc:	5b                   	pop    %ebx
    14dd:	5e                   	pop    %esi
    14de:	5f                   	pop    %edi
    14df:	5d                   	pop    %ebp
    14e0:	c3                   	ret    

000014e1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14e1:	55                   	push   %ebp
    14e2:	89 e5                	mov    %esp,%ebp
    14e4:	57                   	push   %edi
    14e5:	56                   	push   %esi
    14e6:	53                   	push   %ebx
    14e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14ea:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14ed:	a1 54 19 00 00       	mov    0x1954,%eax
    14f2:	eb 02                	jmp    14f6 <free+0x15>
    14f4:	89 d0                	mov    %edx,%eax
    14f6:	39 c8                	cmp    %ecx,%eax
    14f8:	73 04                	jae    14fe <free+0x1d>
    14fa:	39 08                	cmp    %ecx,(%eax)
    14fc:	77 12                	ja     1510 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14fe:	8b 10                	mov    (%eax),%edx
    1500:	39 c2                	cmp    %eax,%edx
    1502:	77 f0                	ja     14f4 <free+0x13>
    1504:	39 c8                	cmp    %ecx,%eax
    1506:	72 08                	jb     1510 <free+0x2f>
    1508:	39 ca                	cmp    %ecx,%edx
    150a:	77 04                	ja     1510 <free+0x2f>
    150c:	89 d0                	mov    %edx,%eax
    150e:	eb e6                	jmp    14f6 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1510:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1513:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1516:	8b 10                	mov    (%eax),%edx
    1518:	39 d7                	cmp    %edx,%edi
    151a:	74 19                	je     1535 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    151c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    151f:	8b 50 04             	mov    0x4(%eax),%edx
    1522:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1525:	39 ce                	cmp    %ecx,%esi
    1527:	74 1b                	je     1544 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1529:	89 08                	mov    %ecx,(%eax)
  freep = p;
    152b:	a3 54 19 00 00       	mov    %eax,0x1954
}
    1530:	5b                   	pop    %ebx
    1531:	5e                   	pop    %esi
    1532:	5f                   	pop    %edi
    1533:	5d                   	pop    %ebp
    1534:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1535:	03 72 04             	add    0x4(%edx),%esi
    1538:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    153b:	8b 10                	mov    (%eax),%edx
    153d:	8b 12                	mov    (%edx),%edx
    153f:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1542:	eb db                	jmp    151f <free+0x3e>
    p->s.size += bp->s.size;
    1544:	03 53 fc             	add    -0x4(%ebx),%edx
    1547:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    154a:	8b 53 f8             	mov    -0x8(%ebx),%edx
    154d:	89 10                	mov    %edx,(%eax)
    154f:	eb da                	jmp    152b <free+0x4a>

00001551 <morecore>:

static Header*
morecore(uint nu)
{
    1551:	55                   	push   %ebp
    1552:	89 e5                	mov    %esp,%ebp
    1554:	53                   	push   %ebx
    1555:	83 ec 04             	sub    $0x4,%esp
    1558:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    155a:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    155f:	77 05                	ja     1566 <morecore+0x15>
    nu = 4096;
    1561:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1566:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    156d:	83 ec 0c             	sub    $0xc,%esp
    1570:	50                   	push   %eax
    1571:	e8 28 fd ff ff       	call   129e <sbrk>
  if(p == (char*)-1)
    1576:	83 c4 10             	add    $0x10,%esp
    1579:	83 f8 ff             	cmp    $0xffffffff,%eax
    157c:	74 1c                	je     159a <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    157e:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1581:	83 c0 08             	add    $0x8,%eax
    1584:	83 ec 0c             	sub    $0xc,%esp
    1587:	50                   	push   %eax
    1588:	e8 54 ff ff ff       	call   14e1 <free>
  return freep;
    158d:	a1 54 19 00 00       	mov    0x1954,%eax
    1592:	83 c4 10             	add    $0x10,%esp
}
    1595:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1598:	c9                   	leave  
    1599:	c3                   	ret    
    return 0;
    159a:	b8 00 00 00 00       	mov    $0x0,%eax
    159f:	eb f4                	jmp    1595 <morecore+0x44>

000015a1 <malloc>:

void*
malloc(uint nbytes)
{
    15a1:	55                   	push   %ebp
    15a2:	89 e5                	mov    %esp,%ebp
    15a4:	53                   	push   %ebx
    15a5:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	8d 58 07             	lea    0x7(%eax),%ebx
    15ae:	c1 eb 03             	shr    $0x3,%ebx
    15b1:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    15b4:	8b 0d 54 19 00 00    	mov    0x1954,%ecx
    15ba:	85 c9                	test   %ecx,%ecx
    15bc:	74 04                	je     15c2 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15be:	8b 01                	mov    (%ecx),%eax
    15c0:	eb 4a                	jmp    160c <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15c2:	c7 05 54 19 00 00 58 	movl   $0x1958,0x1954
    15c9:	19 00 00 
    15cc:	c7 05 58 19 00 00 58 	movl   $0x1958,0x1958
    15d3:	19 00 00 
    base.s.size = 0;
    15d6:	c7 05 5c 19 00 00 00 	movl   $0x0,0x195c
    15dd:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15e0:	b9 58 19 00 00       	mov    $0x1958,%ecx
    15e5:	eb d7                	jmp    15be <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15e7:	74 19                	je     1602 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15e9:	29 da                	sub    %ebx,%edx
    15eb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15ee:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15f1:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15f4:	89 0d 54 19 00 00    	mov    %ecx,0x1954
      return (void*)(p + 1);
    15fa:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1600:	c9                   	leave  
    1601:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1602:	8b 10                	mov    (%eax),%edx
    1604:	89 11                	mov    %edx,(%ecx)
    1606:	eb ec                	jmp    15f4 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1608:	89 c1                	mov    %eax,%ecx
    160a:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    160c:	8b 50 04             	mov    0x4(%eax),%edx
    160f:	39 da                	cmp    %ebx,%edx
    1611:	73 d4                	jae    15e7 <malloc+0x46>
    if(p == freep)
    1613:	39 05 54 19 00 00    	cmp    %eax,0x1954
    1619:	75 ed                	jne    1608 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    161b:	89 d8                	mov    %ebx,%eax
    161d:	e8 2f ff ff ff       	call   1551 <morecore>
    1622:	85 c0                	test   %eax,%eax
    1624:	75 e2                	jne    1608 <malloc+0x67>
    1626:	eb d5                	jmp    15fd <malloc+0x5c>
