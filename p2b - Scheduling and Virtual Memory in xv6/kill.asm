
_kill:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 08             	sub    $0x8,%esp
    1014:	8b 31                	mov    (%ecx),%esi
    1016:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
    1019:	83 fe 01             	cmp    $0x1,%esi
    101c:	7e 07                	jle    1025 <main+0x25>
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    101e:	bb 01 00 00 00       	mov    $0x1,%ebx
    1023:	eb 2d                	jmp    1052 <main+0x52>
    printf(2, "usage: kill pid...\n");
    1025:	83 ec 08             	sub    $0x8,%esp
    1028:	68 0c 16 00 00       	push   $0x160c
    102d:	6a 02                	push   $0x2
    102f:	e8 2b 03 00 00       	call   135f <printf>
    exit();
    1034:	e8 c1 01 00 00       	call   11fa <exit>
    kill(atoi(argv[i]));
    1039:	83 ec 0c             	sub    $0xc,%esp
    103c:	ff 34 9f             	push   (%edi,%ebx,4)
    103f:	e8 52 01 00 00       	call   1196 <atoi>
    1044:	89 04 24             	mov    %eax,(%esp)
    1047:	e8 de 01 00 00       	call   122a <kill>
  for(i=1; i<argc; i++)
    104c:	83 c3 01             	add    $0x1,%ebx
    104f:	83 c4 10             	add    $0x10,%esp
    1052:	39 f3                	cmp    %esi,%ebx
    1054:	7c e3                	jl     1039 <main+0x39>
  exit();
    1056:	e8 9f 01 00 00       	call   11fa <exit>

0000105b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    105b:	55                   	push   %ebp
    105c:	89 e5                	mov    %esp,%ebp
    105e:	56                   	push   %esi
    105f:	53                   	push   %ebx
    1060:	8b 75 08             	mov    0x8(%ebp),%esi
    1063:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1066:	89 f0                	mov    %esi,%eax
    1068:	89 d1                	mov    %edx,%ecx
    106a:	83 c2 01             	add    $0x1,%edx
    106d:	89 c3                	mov    %eax,%ebx
    106f:	83 c0 01             	add    $0x1,%eax
    1072:	0f b6 09             	movzbl (%ecx),%ecx
    1075:	88 0b                	mov    %cl,(%ebx)
    1077:	84 c9                	test   %cl,%cl
    1079:	75 ed                	jne    1068 <strcpy+0xd>
    ;
  return os;
}
    107b:	89 f0                	mov    %esi,%eax
    107d:	5b                   	pop    %ebx
    107e:	5e                   	pop    %esi
    107f:	5d                   	pop    %ebp
    1080:	c3                   	ret    

00001081 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1081:	55                   	push   %ebp
    1082:	89 e5                	mov    %esp,%ebp
    1084:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1087:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    108a:	eb 06                	jmp    1092 <strcmp+0x11>
    p++, q++;
    108c:	83 c1 01             	add    $0x1,%ecx
    108f:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1092:	0f b6 01             	movzbl (%ecx),%eax
    1095:	84 c0                	test   %al,%al
    1097:	74 04                	je     109d <strcmp+0x1c>
    1099:	3a 02                	cmp    (%edx),%al
    109b:	74 ef                	je     108c <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    109d:	0f b6 c0             	movzbl %al,%eax
    10a0:	0f b6 12             	movzbl (%edx),%edx
    10a3:	29 d0                	sub    %edx,%eax
}
    10a5:	5d                   	pop    %ebp
    10a6:	c3                   	ret    

000010a7 <strlen>:

uint
strlen(const char *s)
{
    10a7:	55                   	push   %ebp
    10a8:	89 e5                	mov    %esp,%ebp
    10aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10ad:	b8 00 00 00 00       	mov    $0x0,%eax
    10b2:	eb 03                	jmp    10b7 <strlen+0x10>
    10b4:	83 c0 01             	add    $0x1,%eax
    10b7:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10bb:	75 f7                	jne    10b4 <strlen+0xd>
    ;
  return n;
}
    10bd:	5d                   	pop    %ebp
    10be:	c3                   	ret    

000010bf <memset>:

void*
memset(void *dst, int c, uint n)
{
    10bf:	55                   	push   %ebp
    10c0:	89 e5                	mov    %esp,%ebp
    10c2:	57                   	push   %edi
    10c3:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10c6:	89 d7                	mov    %edx,%edi
    10c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ce:	fc                   	cld    
    10cf:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10d1:	89 d0                	mov    %edx,%eax
    10d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10d6:	c9                   	leave  
    10d7:	c3                   	ret    

000010d8 <strchr>:

char*
strchr(const char *s, char c)
{
    10d8:	55                   	push   %ebp
    10d9:	89 e5                	mov    %esp,%ebp
    10db:	8b 45 08             	mov    0x8(%ebp),%eax
    10de:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10e2:	eb 03                	jmp    10e7 <strchr+0xf>
    10e4:	83 c0 01             	add    $0x1,%eax
    10e7:	0f b6 10             	movzbl (%eax),%edx
    10ea:	84 d2                	test   %dl,%dl
    10ec:	74 06                	je     10f4 <strchr+0x1c>
    if(*s == c)
    10ee:	38 ca                	cmp    %cl,%dl
    10f0:	75 f2                	jne    10e4 <strchr+0xc>
    10f2:	eb 05                	jmp    10f9 <strchr+0x21>
      return (char*)s;
  return 0;
    10f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10f9:	5d                   	pop    %ebp
    10fa:	c3                   	ret    

000010fb <gets>:

char*
gets(char *buf, int max)
{
    10fb:	55                   	push   %ebp
    10fc:	89 e5                	mov    %esp,%ebp
    10fe:	57                   	push   %edi
    10ff:	56                   	push   %esi
    1100:	53                   	push   %ebx
    1101:	83 ec 1c             	sub    $0x1c,%esp
    1104:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1107:	bb 00 00 00 00       	mov    $0x0,%ebx
    110c:	89 de                	mov    %ebx,%esi
    110e:	83 c3 01             	add    $0x1,%ebx
    1111:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1114:	7d 2e                	jge    1144 <gets+0x49>
    cc = read(0, &c, 1);
    1116:	83 ec 04             	sub    $0x4,%esp
    1119:	6a 01                	push   $0x1
    111b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    111e:	50                   	push   %eax
    111f:	6a 00                	push   $0x0
    1121:	e8 ec 00 00 00       	call   1212 <read>
    if(cc < 1)
    1126:	83 c4 10             	add    $0x10,%esp
    1129:	85 c0                	test   %eax,%eax
    112b:	7e 17                	jle    1144 <gets+0x49>
      break;
    buf[i++] = c;
    112d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1131:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1134:	3c 0a                	cmp    $0xa,%al
    1136:	0f 94 c2             	sete   %dl
    1139:	3c 0d                	cmp    $0xd,%al
    113b:	0f 94 c0             	sete   %al
    113e:	08 c2                	or     %al,%dl
    1140:	74 ca                	je     110c <gets+0x11>
    buf[i++] = c;
    1142:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1144:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1148:	89 f8                	mov    %edi,%eax
    114a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    114d:	5b                   	pop    %ebx
    114e:	5e                   	pop    %esi
    114f:	5f                   	pop    %edi
    1150:	5d                   	pop    %ebp
    1151:	c3                   	ret    

00001152 <stat>:

int
stat(const char *n, struct stat *st)
{
    1152:	55                   	push   %ebp
    1153:	89 e5                	mov    %esp,%ebp
    1155:	56                   	push   %esi
    1156:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1157:	83 ec 08             	sub    $0x8,%esp
    115a:	6a 00                	push   $0x0
    115c:	ff 75 08             	push   0x8(%ebp)
    115f:	e8 d6 00 00 00       	call   123a <open>
  if(fd < 0)
    1164:	83 c4 10             	add    $0x10,%esp
    1167:	85 c0                	test   %eax,%eax
    1169:	78 24                	js     118f <stat+0x3d>
    116b:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    116d:	83 ec 08             	sub    $0x8,%esp
    1170:	ff 75 0c             	push   0xc(%ebp)
    1173:	50                   	push   %eax
    1174:	e8 d9 00 00 00       	call   1252 <fstat>
    1179:	89 c6                	mov    %eax,%esi
  close(fd);
    117b:	89 1c 24             	mov    %ebx,(%esp)
    117e:	e8 9f 00 00 00       	call   1222 <close>
  return r;
    1183:	83 c4 10             	add    $0x10,%esp
}
    1186:	89 f0                	mov    %esi,%eax
    1188:	8d 65 f8             	lea    -0x8(%ebp),%esp
    118b:	5b                   	pop    %ebx
    118c:	5e                   	pop    %esi
    118d:	5d                   	pop    %ebp
    118e:	c3                   	ret    
    return -1;
    118f:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1194:	eb f0                	jmp    1186 <stat+0x34>

00001196 <atoi>:

int
atoi(const char *s)
{
    1196:	55                   	push   %ebp
    1197:	89 e5                	mov    %esp,%ebp
    1199:	53                   	push   %ebx
    119a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    119d:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11a2:	eb 10                	jmp    11b4 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11a4:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11a7:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11aa:	83 c1 01             	add    $0x1,%ecx
    11ad:	0f be c0             	movsbl %al,%eax
    11b0:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11b4:	0f b6 01             	movzbl (%ecx),%eax
    11b7:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11ba:	80 fb 09             	cmp    $0x9,%bl
    11bd:	76 e5                	jbe    11a4 <atoi+0xe>
  return n;
}
    11bf:	89 d0                	mov    %edx,%eax
    11c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11c4:	c9                   	leave  
    11c5:	c3                   	ret    

000011c6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11c6:	55                   	push   %ebp
    11c7:	89 e5                	mov    %esp,%ebp
    11c9:	56                   	push   %esi
    11ca:	53                   	push   %ebx
    11cb:	8b 75 08             	mov    0x8(%ebp),%esi
    11ce:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11d1:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11d4:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11d6:	eb 0d                	jmp    11e5 <memmove+0x1f>
    *dst++ = *src++;
    11d8:	0f b6 01             	movzbl (%ecx),%eax
    11db:	88 02                	mov    %al,(%edx)
    11dd:	8d 49 01             	lea    0x1(%ecx),%ecx
    11e0:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11e3:	89 d8                	mov    %ebx,%eax
    11e5:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11e8:	85 c0                	test   %eax,%eax
    11ea:	7f ec                	jg     11d8 <memmove+0x12>
  return vdst;
}
    11ec:	89 f0                	mov    %esi,%eax
    11ee:	5b                   	pop    %ebx
    11ef:	5e                   	pop    %esi
    11f0:	5d                   	pop    %ebp
    11f1:	c3                   	ret    

000011f2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11f2:	b8 01 00 00 00       	mov    $0x1,%eax
    11f7:	cd 40                	int    $0x40
    11f9:	c3                   	ret    

000011fa <exit>:
SYSCALL(exit)
    11fa:	b8 02 00 00 00       	mov    $0x2,%eax
    11ff:	cd 40                	int    $0x40
    1201:	c3                   	ret    

00001202 <wait>:
SYSCALL(wait)
    1202:	b8 03 00 00 00       	mov    $0x3,%eax
    1207:	cd 40                	int    $0x40
    1209:	c3                   	ret    

0000120a <pipe>:
SYSCALL(pipe)
    120a:	b8 04 00 00 00       	mov    $0x4,%eax
    120f:	cd 40                	int    $0x40
    1211:	c3                   	ret    

00001212 <read>:
SYSCALL(read)
    1212:	b8 05 00 00 00       	mov    $0x5,%eax
    1217:	cd 40                	int    $0x40
    1219:	c3                   	ret    

0000121a <write>:
SYSCALL(write)
    121a:	b8 10 00 00 00       	mov    $0x10,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <close>:
SYSCALL(close)
    1222:	b8 15 00 00 00       	mov    $0x15,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <kill>:
SYSCALL(kill)
    122a:	b8 06 00 00 00       	mov    $0x6,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <exec>:
SYSCALL(exec)
    1232:	b8 07 00 00 00       	mov    $0x7,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <open>:
SYSCALL(open)
    123a:	b8 0f 00 00 00       	mov    $0xf,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    

00001242 <mknod>:
SYSCALL(mknod)
    1242:	b8 11 00 00 00       	mov    $0x11,%eax
    1247:	cd 40                	int    $0x40
    1249:	c3                   	ret    

0000124a <unlink>:
SYSCALL(unlink)
    124a:	b8 12 00 00 00       	mov    $0x12,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <fstat>:
SYSCALL(fstat)
    1252:	b8 08 00 00 00       	mov    $0x8,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    

0000125a <link>:
SYSCALL(link)
    125a:	b8 13 00 00 00       	mov    $0x13,%eax
    125f:	cd 40                	int    $0x40
    1261:	c3                   	ret    

00001262 <mkdir>:
SYSCALL(mkdir)
    1262:	b8 14 00 00 00       	mov    $0x14,%eax
    1267:	cd 40                	int    $0x40
    1269:	c3                   	ret    

0000126a <chdir>:
SYSCALL(chdir)
    126a:	b8 09 00 00 00       	mov    $0x9,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <dup>:
SYSCALL(dup)
    1272:	b8 0a 00 00 00       	mov    $0xa,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <getpid>:
SYSCALL(getpid)
    127a:	b8 0b 00 00 00       	mov    $0xb,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <sbrk>:
SYSCALL(sbrk)
    1282:	b8 0c 00 00 00       	mov    $0xc,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <sleep>:
SYSCALL(sleep)
    128a:	b8 0d 00 00 00       	mov    $0xd,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <uptime>:
SYSCALL(uptime)
    1292:	b8 0e 00 00 00       	mov    $0xe,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <settickets>:
SYSCALL(settickets)
    129a:	b8 16 00 00 00       	mov    $0x16,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <getpinfo>:
SYSCALL(getpinfo)
    12a2:	b8 17 00 00 00       	mov    $0x17,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <mprotect>:
SYSCALL(mprotect)
    12aa:	b8 18 00 00 00       	mov    $0x18,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <munprotect>:
    12b2:	b8 19 00 00 00       	mov    $0x19,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12ba:	55                   	push   %ebp
    12bb:	89 e5                	mov    %esp,%ebp
    12bd:	83 ec 1c             	sub    $0x1c,%esp
    12c0:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12c3:	6a 01                	push   $0x1
    12c5:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12c8:	52                   	push   %edx
    12c9:	50                   	push   %eax
    12ca:	e8 4b ff ff ff       	call   121a <write>
}
    12cf:	83 c4 10             	add    $0x10,%esp
    12d2:	c9                   	leave  
    12d3:	c3                   	ret    

000012d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12d4:	55                   	push   %ebp
    12d5:	89 e5                	mov    %esp,%ebp
    12d7:	57                   	push   %edi
    12d8:	56                   	push   %esi
    12d9:	53                   	push   %ebx
    12da:	83 ec 2c             	sub    $0x2c,%esp
    12dd:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12e0:	89 d0                	mov    %edx,%eax
    12e2:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12e8:	0f 95 c1             	setne  %cl
    12eb:	c1 ea 1f             	shr    $0x1f,%edx
    12ee:	84 d1                	test   %dl,%cl
    12f0:	74 44                	je     1336 <printint+0x62>
    neg = 1;
    x = -xx;
    12f2:	f7 d8                	neg    %eax
    12f4:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12f6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12fd:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1302:	89 c8                	mov    %ecx,%eax
    1304:	ba 00 00 00 00       	mov    $0x0,%edx
    1309:	f7 f6                	div    %esi
    130b:	89 df                	mov    %ebx,%edi
    130d:	83 c3 01             	add    $0x1,%ebx
    1310:	0f b6 92 80 16 00 00 	movzbl 0x1680(%edx),%edx
    1317:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    131b:	89 ca                	mov    %ecx,%edx
    131d:	89 c1                	mov    %eax,%ecx
    131f:	39 d6                	cmp    %edx,%esi
    1321:	76 df                	jbe    1302 <printint+0x2e>
  if(neg)
    1323:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1327:	74 31                	je     135a <printint+0x86>
    buf[i++] = '-';
    1329:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    132e:	8d 5f 02             	lea    0x2(%edi),%ebx
    1331:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1334:	eb 17                	jmp    134d <printint+0x79>
    x = xx;
    1336:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1338:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    133f:	eb bc                	jmp    12fd <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1341:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1346:	89 f0                	mov    %esi,%eax
    1348:	e8 6d ff ff ff       	call   12ba <putc>
  while(--i >= 0)
    134d:	83 eb 01             	sub    $0x1,%ebx
    1350:	79 ef                	jns    1341 <printint+0x6d>
}
    1352:	83 c4 2c             	add    $0x2c,%esp
    1355:	5b                   	pop    %ebx
    1356:	5e                   	pop    %esi
    1357:	5f                   	pop    %edi
    1358:	5d                   	pop    %ebp
    1359:	c3                   	ret    
    135a:	8b 75 d0             	mov    -0x30(%ebp),%esi
    135d:	eb ee                	jmp    134d <printint+0x79>

0000135f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    135f:	55                   	push   %ebp
    1360:	89 e5                	mov    %esp,%ebp
    1362:	57                   	push   %edi
    1363:	56                   	push   %esi
    1364:	53                   	push   %ebx
    1365:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1368:	8d 45 10             	lea    0x10(%ebp),%eax
    136b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    136e:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1373:	bb 00 00 00 00       	mov    $0x0,%ebx
    1378:	eb 14                	jmp    138e <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    137a:	89 fa                	mov    %edi,%edx
    137c:	8b 45 08             	mov    0x8(%ebp),%eax
    137f:	e8 36 ff ff ff       	call   12ba <putc>
    1384:	eb 05                	jmp    138b <printf+0x2c>
      }
    } else if(state == '%'){
    1386:	83 fe 25             	cmp    $0x25,%esi
    1389:	74 25                	je     13b0 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    138b:	83 c3 01             	add    $0x1,%ebx
    138e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1391:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1395:	84 c0                	test   %al,%al
    1397:	0f 84 20 01 00 00    	je     14bd <printf+0x15e>
    c = fmt[i] & 0xff;
    139d:	0f be f8             	movsbl %al,%edi
    13a0:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13a3:	85 f6                	test   %esi,%esi
    13a5:	75 df                	jne    1386 <printf+0x27>
      if(c == '%'){
    13a7:	83 f8 25             	cmp    $0x25,%eax
    13aa:	75 ce                	jne    137a <printf+0x1b>
        state = '%';
    13ac:	89 c6                	mov    %eax,%esi
    13ae:	eb db                	jmp    138b <printf+0x2c>
      if(c == 'd'){
    13b0:	83 f8 25             	cmp    $0x25,%eax
    13b3:	0f 84 cf 00 00 00    	je     1488 <printf+0x129>
    13b9:	0f 8c dd 00 00 00    	jl     149c <printf+0x13d>
    13bf:	83 f8 78             	cmp    $0x78,%eax
    13c2:	0f 8f d4 00 00 00    	jg     149c <printf+0x13d>
    13c8:	83 f8 63             	cmp    $0x63,%eax
    13cb:	0f 8c cb 00 00 00    	jl     149c <printf+0x13d>
    13d1:	83 e8 63             	sub    $0x63,%eax
    13d4:	83 f8 15             	cmp    $0x15,%eax
    13d7:	0f 87 bf 00 00 00    	ja     149c <printf+0x13d>
    13dd:	ff 24 85 28 16 00 00 	jmp    *0x1628(,%eax,4)
        printint(fd, *ap, 10, 1);
    13e4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13e7:	8b 17                	mov    (%edi),%edx
    13e9:	83 ec 0c             	sub    $0xc,%esp
    13ec:	6a 01                	push   $0x1
    13ee:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13f3:	8b 45 08             	mov    0x8(%ebp),%eax
    13f6:	e8 d9 fe ff ff       	call   12d4 <printint>
        ap++;
    13fb:	83 c7 04             	add    $0x4,%edi
    13fe:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1401:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1404:	be 00 00 00 00       	mov    $0x0,%esi
    1409:	eb 80                	jmp    138b <printf+0x2c>
        printint(fd, *ap, 16, 0);
    140b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    140e:	8b 17                	mov    (%edi),%edx
    1410:	83 ec 0c             	sub    $0xc,%esp
    1413:	6a 00                	push   $0x0
    1415:	b9 10 00 00 00       	mov    $0x10,%ecx
    141a:	8b 45 08             	mov    0x8(%ebp),%eax
    141d:	e8 b2 fe ff ff       	call   12d4 <printint>
        ap++;
    1422:	83 c7 04             	add    $0x4,%edi
    1425:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1428:	83 c4 10             	add    $0x10,%esp
      state = 0;
    142b:	be 00 00 00 00       	mov    $0x0,%esi
    1430:	e9 56 ff ff ff       	jmp    138b <printf+0x2c>
        s = (char*)*ap;
    1435:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1438:	8b 30                	mov    (%eax),%esi
        ap++;
    143a:	83 c0 04             	add    $0x4,%eax
    143d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1440:	85 f6                	test   %esi,%esi
    1442:	75 15                	jne    1459 <printf+0xfa>
          s = "(null)";
    1444:	be 20 16 00 00       	mov    $0x1620,%esi
    1449:	eb 0e                	jmp    1459 <printf+0xfa>
          putc(fd, *s);
    144b:	0f be d2             	movsbl %dl,%edx
    144e:	8b 45 08             	mov    0x8(%ebp),%eax
    1451:	e8 64 fe ff ff       	call   12ba <putc>
          s++;
    1456:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1459:	0f b6 16             	movzbl (%esi),%edx
    145c:	84 d2                	test   %dl,%dl
    145e:	75 eb                	jne    144b <printf+0xec>
      state = 0;
    1460:	be 00 00 00 00       	mov    $0x0,%esi
    1465:	e9 21 ff ff ff       	jmp    138b <printf+0x2c>
        putc(fd, *ap);
    146a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    146d:	0f be 17             	movsbl (%edi),%edx
    1470:	8b 45 08             	mov    0x8(%ebp),%eax
    1473:	e8 42 fe ff ff       	call   12ba <putc>
        ap++;
    1478:	83 c7 04             	add    $0x4,%edi
    147b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    147e:	be 00 00 00 00       	mov    $0x0,%esi
    1483:	e9 03 ff ff ff       	jmp    138b <printf+0x2c>
        putc(fd, c);
    1488:	89 fa                	mov    %edi,%edx
    148a:	8b 45 08             	mov    0x8(%ebp),%eax
    148d:	e8 28 fe ff ff       	call   12ba <putc>
      state = 0;
    1492:	be 00 00 00 00       	mov    $0x0,%esi
    1497:	e9 ef fe ff ff       	jmp    138b <printf+0x2c>
        putc(fd, '%');
    149c:	ba 25 00 00 00       	mov    $0x25,%edx
    14a1:	8b 45 08             	mov    0x8(%ebp),%eax
    14a4:	e8 11 fe ff ff       	call   12ba <putc>
        putc(fd, c);
    14a9:	89 fa                	mov    %edi,%edx
    14ab:	8b 45 08             	mov    0x8(%ebp),%eax
    14ae:	e8 07 fe ff ff       	call   12ba <putc>
      state = 0;
    14b3:	be 00 00 00 00       	mov    $0x0,%esi
    14b8:	e9 ce fe ff ff       	jmp    138b <printf+0x2c>
    }
  }
}
    14bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14c0:	5b                   	pop    %ebx
    14c1:	5e                   	pop    %esi
    14c2:	5f                   	pop    %edi
    14c3:	5d                   	pop    %ebp
    14c4:	c3                   	ret    

000014c5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c5:	55                   	push   %ebp
    14c6:	89 e5                	mov    %esp,%ebp
    14c8:	57                   	push   %edi
    14c9:	56                   	push   %esi
    14ca:	53                   	push   %ebx
    14cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d1:	a1 2c 19 00 00       	mov    0x192c,%eax
    14d6:	eb 02                	jmp    14da <free+0x15>
    14d8:	89 d0                	mov    %edx,%eax
    14da:	39 c8                	cmp    %ecx,%eax
    14dc:	73 04                	jae    14e2 <free+0x1d>
    14de:	39 08                	cmp    %ecx,(%eax)
    14e0:	77 12                	ja     14f4 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14e2:	8b 10                	mov    (%eax),%edx
    14e4:	39 c2                	cmp    %eax,%edx
    14e6:	77 f0                	ja     14d8 <free+0x13>
    14e8:	39 c8                	cmp    %ecx,%eax
    14ea:	72 08                	jb     14f4 <free+0x2f>
    14ec:	39 ca                	cmp    %ecx,%edx
    14ee:	77 04                	ja     14f4 <free+0x2f>
    14f0:	89 d0                	mov    %edx,%eax
    14f2:	eb e6                	jmp    14da <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14f4:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14f7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14fa:	8b 10                	mov    (%eax),%edx
    14fc:	39 d7                	cmp    %edx,%edi
    14fe:	74 19                	je     1519 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1500:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1503:	8b 50 04             	mov    0x4(%eax),%edx
    1506:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1509:	39 ce                	cmp    %ecx,%esi
    150b:	74 1b                	je     1528 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    150d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    150f:	a3 2c 19 00 00       	mov    %eax,0x192c
}
    1514:	5b                   	pop    %ebx
    1515:	5e                   	pop    %esi
    1516:	5f                   	pop    %edi
    1517:	5d                   	pop    %ebp
    1518:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1519:	03 72 04             	add    0x4(%edx),%esi
    151c:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    151f:	8b 10                	mov    (%eax),%edx
    1521:	8b 12                	mov    (%edx),%edx
    1523:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1526:	eb db                	jmp    1503 <free+0x3e>
    p->s.size += bp->s.size;
    1528:	03 53 fc             	add    -0x4(%ebx),%edx
    152b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    152e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1531:	89 10                	mov    %edx,(%eax)
    1533:	eb da                	jmp    150f <free+0x4a>

00001535 <morecore>:

static Header*
morecore(uint nu)
{
    1535:	55                   	push   %ebp
    1536:	89 e5                	mov    %esp,%ebp
    1538:	53                   	push   %ebx
    1539:	83 ec 04             	sub    $0x4,%esp
    153c:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    153e:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1543:	77 05                	ja     154a <morecore+0x15>
    nu = 4096;
    1545:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    154a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1551:	83 ec 0c             	sub    $0xc,%esp
    1554:	50                   	push   %eax
    1555:	e8 28 fd ff ff       	call   1282 <sbrk>
  if(p == (char*)-1)
    155a:	83 c4 10             	add    $0x10,%esp
    155d:	83 f8 ff             	cmp    $0xffffffff,%eax
    1560:	74 1c                	je     157e <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1562:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1565:	83 c0 08             	add    $0x8,%eax
    1568:	83 ec 0c             	sub    $0xc,%esp
    156b:	50                   	push   %eax
    156c:	e8 54 ff ff ff       	call   14c5 <free>
  return freep;
    1571:	a1 2c 19 00 00       	mov    0x192c,%eax
    1576:	83 c4 10             	add    $0x10,%esp
}
    1579:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    157c:	c9                   	leave  
    157d:	c3                   	ret    
    return 0;
    157e:	b8 00 00 00 00       	mov    $0x0,%eax
    1583:	eb f4                	jmp    1579 <morecore+0x44>

00001585 <malloc>:

void*
malloc(uint nbytes)
{
    1585:	55                   	push   %ebp
    1586:	89 e5                	mov    %esp,%ebp
    1588:	53                   	push   %ebx
    1589:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    158c:	8b 45 08             	mov    0x8(%ebp),%eax
    158f:	8d 58 07             	lea    0x7(%eax),%ebx
    1592:	c1 eb 03             	shr    $0x3,%ebx
    1595:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1598:	8b 0d 2c 19 00 00    	mov    0x192c,%ecx
    159e:	85 c9                	test   %ecx,%ecx
    15a0:	74 04                	je     15a6 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a2:	8b 01                	mov    (%ecx),%eax
    15a4:	eb 4a                	jmp    15f0 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15a6:	c7 05 2c 19 00 00 30 	movl   $0x1930,0x192c
    15ad:	19 00 00 
    15b0:	c7 05 30 19 00 00 30 	movl   $0x1930,0x1930
    15b7:	19 00 00 
    base.s.size = 0;
    15ba:	c7 05 34 19 00 00 00 	movl   $0x0,0x1934
    15c1:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15c4:	b9 30 19 00 00       	mov    $0x1930,%ecx
    15c9:	eb d7                	jmp    15a2 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15cb:	74 19                	je     15e6 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15cd:	29 da                	sub    %ebx,%edx
    15cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15d2:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15d5:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15d8:	89 0d 2c 19 00 00    	mov    %ecx,0x192c
      return (void*)(p + 1);
    15de:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15e4:	c9                   	leave  
    15e5:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15e6:	8b 10                	mov    (%eax),%edx
    15e8:	89 11                	mov    %edx,(%ecx)
    15ea:	eb ec                	jmp    15d8 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15ec:	89 c1                	mov    %eax,%ecx
    15ee:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15f0:	8b 50 04             	mov    0x4(%eax),%edx
    15f3:	39 da                	cmp    %ebx,%edx
    15f5:	73 d4                	jae    15cb <malloc+0x46>
    if(p == freep)
    15f7:	39 05 2c 19 00 00    	cmp    %eax,0x192c
    15fd:	75 ed                	jne    15ec <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15ff:	89 d8                	mov    %ebx,%eax
    1601:	e8 2f ff ff ff       	call   1535 <morecore>
    1606:	85 c0                	test   %eax,%eax
    1608:	75 e2                	jne    15ec <malloc+0x67>
    160a:	eb d5                	jmp    15e1 <malloc+0x5c>
