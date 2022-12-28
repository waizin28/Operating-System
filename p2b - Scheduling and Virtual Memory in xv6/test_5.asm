
_test_5:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "user.h"
#include "pstat.h"

int
main(int argc, char *argv[])
{  
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 10             	sub    $0x10,%esp
  if(settickets(10) == -1)
    1011:	6a 0a                	push   $0xa
    1013:	e8 72 02 00 00       	call   128a <settickets>
    1018:	83 c4 10             	add    $0x10,%esp
    101b:	83 f8 ff             	cmp    $0xffffffff,%eax
    101e:	74 17                	je     1037 <main+0x37>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    1020:	83 ec 08             	sub    $0x8,%esp
    1023:	68 14 16 00 00       	push   $0x1614
    1028:	6a 01                	push   $0x1
    102a:	e8 20 03 00 00       	call   134f <printf>
    102f:	83 c4 10             	add    $0x10,%esp
  }
   exit();
    1032:	e8 b3 01 00 00       	call   11ea <exit>
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    1037:	83 ec 08             	sub    $0x8,%esp
    103a:	68 fc 15 00 00       	push   $0x15fc
    103f:	6a 01                	push   $0x1
    1041:	e8 09 03 00 00       	call   134f <printf>
    1046:	83 c4 10             	add    $0x10,%esp
    1049:	eb e7                	jmp    1032 <main+0x32>

0000104b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    104b:	55                   	push   %ebp
    104c:	89 e5                	mov    %esp,%ebp
    104e:	56                   	push   %esi
    104f:	53                   	push   %ebx
    1050:	8b 75 08             	mov    0x8(%ebp),%esi
    1053:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1056:	89 f0                	mov    %esi,%eax
    1058:	89 d1                	mov    %edx,%ecx
    105a:	83 c2 01             	add    $0x1,%edx
    105d:	89 c3                	mov    %eax,%ebx
    105f:	83 c0 01             	add    $0x1,%eax
    1062:	0f b6 09             	movzbl (%ecx),%ecx
    1065:	88 0b                	mov    %cl,(%ebx)
    1067:	84 c9                	test   %cl,%cl
    1069:	75 ed                	jne    1058 <strcpy+0xd>
    ;
  return os;
}
    106b:	89 f0                	mov    %esi,%eax
    106d:	5b                   	pop    %ebx
    106e:	5e                   	pop    %esi
    106f:	5d                   	pop    %ebp
    1070:	c3                   	ret    

00001071 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1071:	55                   	push   %ebp
    1072:	89 e5                	mov    %esp,%ebp
    1074:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1077:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    107a:	eb 06                	jmp    1082 <strcmp+0x11>
    p++, q++;
    107c:	83 c1 01             	add    $0x1,%ecx
    107f:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1082:	0f b6 01             	movzbl (%ecx),%eax
    1085:	84 c0                	test   %al,%al
    1087:	74 04                	je     108d <strcmp+0x1c>
    1089:	3a 02                	cmp    (%edx),%al
    108b:	74 ef                	je     107c <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    108d:	0f b6 c0             	movzbl %al,%eax
    1090:	0f b6 12             	movzbl (%edx),%edx
    1093:	29 d0                	sub    %edx,%eax
}
    1095:	5d                   	pop    %ebp
    1096:	c3                   	ret    

00001097 <strlen>:

uint
strlen(const char *s)
{
    1097:	55                   	push   %ebp
    1098:	89 e5                	mov    %esp,%ebp
    109a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    109d:	b8 00 00 00 00       	mov    $0x0,%eax
    10a2:	eb 03                	jmp    10a7 <strlen+0x10>
    10a4:	83 c0 01             	add    $0x1,%eax
    10a7:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10ab:	75 f7                	jne    10a4 <strlen+0xd>
    ;
  return n;
}
    10ad:	5d                   	pop    %ebp
    10ae:	c3                   	ret    

000010af <memset>:

void*
memset(void *dst, int c, uint n)
{
    10af:	55                   	push   %ebp
    10b0:	89 e5                	mov    %esp,%ebp
    10b2:	57                   	push   %edi
    10b3:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10b6:	89 d7                	mov    %edx,%edi
    10b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10be:	fc                   	cld    
    10bf:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c1:	89 d0                	mov    %edx,%eax
    10c3:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10c6:	c9                   	leave  
    10c7:	c3                   	ret    

000010c8 <strchr>:

char*
strchr(const char *s, char c)
{
    10c8:	55                   	push   %ebp
    10c9:	89 e5                	mov    %esp,%ebp
    10cb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ce:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10d2:	eb 03                	jmp    10d7 <strchr+0xf>
    10d4:	83 c0 01             	add    $0x1,%eax
    10d7:	0f b6 10             	movzbl (%eax),%edx
    10da:	84 d2                	test   %dl,%dl
    10dc:	74 06                	je     10e4 <strchr+0x1c>
    if(*s == c)
    10de:	38 ca                	cmp    %cl,%dl
    10e0:	75 f2                	jne    10d4 <strchr+0xc>
    10e2:	eb 05                	jmp    10e9 <strchr+0x21>
      return (char*)s;
  return 0;
    10e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10e9:	5d                   	pop    %ebp
    10ea:	c3                   	ret    

000010eb <gets>:

char*
gets(char *buf, int max)
{
    10eb:	55                   	push   %ebp
    10ec:	89 e5                	mov    %esp,%ebp
    10ee:	57                   	push   %edi
    10ef:	56                   	push   %esi
    10f0:	53                   	push   %ebx
    10f1:	83 ec 1c             	sub    $0x1c,%esp
    10f4:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10f7:	bb 00 00 00 00       	mov    $0x0,%ebx
    10fc:	89 de                	mov    %ebx,%esi
    10fe:	83 c3 01             	add    $0x1,%ebx
    1101:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1104:	7d 2e                	jge    1134 <gets+0x49>
    cc = read(0, &c, 1);
    1106:	83 ec 04             	sub    $0x4,%esp
    1109:	6a 01                	push   $0x1
    110b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    110e:	50                   	push   %eax
    110f:	6a 00                	push   $0x0
    1111:	e8 ec 00 00 00       	call   1202 <read>
    if(cc < 1)
    1116:	83 c4 10             	add    $0x10,%esp
    1119:	85 c0                	test   %eax,%eax
    111b:	7e 17                	jle    1134 <gets+0x49>
      break;
    buf[i++] = c;
    111d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1121:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1124:	3c 0a                	cmp    $0xa,%al
    1126:	0f 94 c2             	sete   %dl
    1129:	3c 0d                	cmp    $0xd,%al
    112b:	0f 94 c0             	sete   %al
    112e:	08 c2                	or     %al,%dl
    1130:	74 ca                	je     10fc <gets+0x11>
    buf[i++] = c;
    1132:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1134:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1138:	89 f8                	mov    %edi,%eax
    113a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    113d:	5b                   	pop    %ebx
    113e:	5e                   	pop    %esi
    113f:	5f                   	pop    %edi
    1140:	5d                   	pop    %ebp
    1141:	c3                   	ret    

00001142 <stat>:

int
stat(const char *n, struct stat *st)
{
    1142:	55                   	push   %ebp
    1143:	89 e5                	mov    %esp,%ebp
    1145:	56                   	push   %esi
    1146:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1147:	83 ec 08             	sub    $0x8,%esp
    114a:	6a 00                	push   $0x0
    114c:	ff 75 08             	push   0x8(%ebp)
    114f:	e8 d6 00 00 00       	call   122a <open>
  if(fd < 0)
    1154:	83 c4 10             	add    $0x10,%esp
    1157:	85 c0                	test   %eax,%eax
    1159:	78 24                	js     117f <stat+0x3d>
    115b:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    115d:	83 ec 08             	sub    $0x8,%esp
    1160:	ff 75 0c             	push   0xc(%ebp)
    1163:	50                   	push   %eax
    1164:	e8 d9 00 00 00       	call   1242 <fstat>
    1169:	89 c6                	mov    %eax,%esi
  close(fd);
    116b:	89 1c 24             	mov    %ebx,(%esp)
    116e:	e8 9f 00 00 00       	call   1212 <close>
  return r;
    1173:	83 c4 10             	add    $0x10,%esp
}
    1176:	89 f0                	mov    %esi,%eax
    1178:	8d 65 f8             	lea    -0x8(%ebp),%esp
    117b:	5b                   	pop    %ebx
    117c:	5e                   	pop    %esi
    117d:	5d                   	pop    %ebp
    117e:	c3                   	ret    
    return -1;
    117f:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1184:	eb f0                	jmp    1176 <stat+0x34>

00001186 <atoi>:

int
atoi(const char *s)
{
    1186:	55                   	push   %ebp
    1187:	89 e5                	mov    %esp,%ebp
    1189:	53                   	push   %ebx
    118a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    118d:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1192:	eb 10                	jmp    11a4 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1194:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1197:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    119a:	83 c1 01             	add    $0x1,%ecx
    119d:	0f be c0             	movsbl %al,%eax
    11a0:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11a4:	0f b6 01             	movzbl (%ecx),%eax
    11a7:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11aa:	80 fb 09             	cmp    $0x9,%bl
    11ad:	76 e5                	jbe    1194 <atoi+0xe>
  return n;
}
    11af:	89 d0                	mov    %edx,%eax
    11b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11b4:	c9                   	leave  
    11b5:	c3                   	ret    

000011b6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11b6:	55                   	push   %ebp
    11b7:	89 e5                	mov    %esp,%ebp
    11b9:	56                   	push   %esi
    11ba:	53                   	push   %ebx
    11bb:	8b 75 08             	mov    0x8(%ebp),%esi
    11be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11c1:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11c4:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11c6:	eb 0d                	jmp    11d5 <memmove+0x1f>
    *dst++ = *src++;
    11c8:	0f b6 01             	movzbl (%ecx),%eax
    11cb:	88 02                	mov    %al,(%edx)
    11cd:	8d 49 01             	lea    0x1(%ecx),%ecx
    11d0:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11d3:	89 d8                	mov    %ebx,%eax
    11d5:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11d8:	85 c0                	test   %eax,%eax
    11da:	7f ec                	jg     11c8 <memmove+0x12>
  return vdst;
}
    11dc:	89 f0                	mov    %esi,%eax
    11de:	5b                   	pop    %ebx
    11df:	5e                   	pop    %esi
    11e0:	5d                   	pop    %ebp
    11e1:	c3                   	ret    

000011e2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11e2:	b8 01 00 00 00       	mov    $0x1,%eax
    11e7:	cd 40                	int    $0x40
    11e9:	c3                   	ret    

000011ea <exit>:
SYSCALL(exit)
    11ea:	b8 02 00 00 00       	mov    $0x2,%eax
    11ef:	cd 40                	int    $0x40
    11f1:	c3                   	ret    

000011f2 <wait>:
SYSCALL(wait)
    11f2:	b8 03 00 00 00       	mov    $0x3,%eax
    11f7:	cd 40                	int    $0x40
    11f9:	c3                   	ret    

000011fa <pipe>:
SYSCALL(pipe)
    11fa:	b8 04 00 00 00       	mov    $0x4,%eax
    11ff:	cd 40                	int    $0x40
    1201:	c3                   	ret    

00001202 <read>:
SYSCALL(read)
    1202:	b8 05 00 00 00       	mov    $0x5,%eax
    1207:	cd 40                	int    $0x40
    1209:	c3                   	ret    

0000120a <write>:
SYSCALL(write)
    120a:	b8 10 00 00 00       	mov    $0x10,%eax
    120f:	cd 40                	int    $0x40
    1211:	c3                   	ret    

00001212 <close>:
SYSCALL(close)
    1212:	b8 15 00 00 00       	mov    $0x15,%eax
    1217:	cd 40                	int    $0x40
    1219:	c3                   	ret    

0000121a <kill>:
SYSCALL(kill)
    121a:	b8 06 00 00 00       	mov    $0x6,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <exec>:
SYSCALL(exec)
    1222:	b8 07 00 00 00       	mov    $0x7,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <open>:
SYSCALL(open)
    122a:	b8 0f 00 00 00       	mov    $0xf,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <mknod>:
SYSCALL(mknod)
    1232:	b8 11 00 00 00       	mov    $0x11,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <unlink>:
SYSCALL(unlink)
    123a:	b8 12 00 00 00       	mov    $0x12,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    

00001242 <fstat>:
SYSCALL(fstat)
    1242:	b8 08 00 00 00       	mov    $0x8,%eax
    1247:	cd 40                	int    $0x40
    1249:	c3                   	ret    

0000124a <link>:
SYSCALL(link)
    124a:	b8 13 00 00 00       	mov    $0x13,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <mkdir>:
SYSCALL(mkdir)
    1252:	b8 14 00 00 00       	mov    $0x14,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    

0000125a <chdir>:
SYSCALL(chdir)
    125a:	b8 09 00 00 00       	mov    $0x9,%eax
    125f:	cd 40                	int    $0x40
    1261:	c3                   	ret    

00001262 <dup>:
SYSCALL(dup)
    1262:	b8 0a 00 00 00       	mov    $0xa,%eax
    1267:	cd 40                	int    $0x40
    1269:	c3                   	ret    

0000126a <getpid>:
SYSCALL(getpid)
    126a:	b8 0b 00 00 00       	mov    $0xb,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <sbrk>:
SYSCALL(sbrk)
    1272:	b8 0c 00 00 00       	mov    $0xc,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <sleep>:
SYSCALL(sleep)
    127a:	b8 0d 00 00 00       	mov    $0xd,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <uptime>:
SYSCALL(uptime)
    1282:	b8 0e 00 00 00       	mov    $0xe,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <settickets>:
SYSCALL(settickets)
    128a:	b8 16 00 00 00       	mov    $0x16,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <getpinfo>:
SYSCALL(getpinfo)
    1292:	b8 17 00 00 00       	mov    $0x17,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <mprotect>:
SYSCALL(mprotect)
    129a:	b8 18 00 00 00       	mov    $0x18,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <munprotect>:
    12a2:	b8 19 00 00 00       	mov    $0x19,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12aa:	55                   	push   %ebp
    12ab:	89 e5                	mov    %esp,%ebp
    12ad:	83 ec 1c             	sub    $0x1c,%esp
    12b0:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12b3:	6a 01                	push   $0x1
    12b5:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12b8:	52                   	push   %edx
    12b9:	50                   	push   %eax
    12ba:	e8 4b ff ff ff       	call   120a <write>
}
    12bf:	83 c4 10             	add    $0x10,%esp
    12c2:	c9                   	leave  
    12c3:	c3                   	ret    

000012c4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12c4:	55                   	push   %ebp
    12c5:	89 e5                	mov    %esp,%ebp
    12c7:	57                   	push   %edi
    12c8:	56                   	push   %esi
    12c9:	53                   	push   %ebx
    12ca:	83 ec 2c             	sub    $0x2c,%esp
    12cd:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12d0:	89 d0                	mov    %edx,%eax
    12d2:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12d8:	0f 95 c1             	setne  %cl
    12db:	c1 ea 1f             	shr    $0x1f,%edx
    12de:	84 d1                	test   %dl,%cl
    12e0:	74 44                	je     1326 <printint+0x62>
    neg = 1;
    x = -xx;
    12e2:	f7 d8                	neg    %eax
    12e4:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12e6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12ed:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12f2:	89 c8                	mov    %ecx,%eax
    12f4:	ba 00 00 00 00       	mov    $0x0,%edx
    12f9:	f7 f6                	div    %esi
    12fb:	89 df                	mov    %ebx,%edi
    12fd:	83 c3 01             	add    $0x1,%ebx
    1300:	0f b6 92 8c 16 00 00 	movzbl 0x168c(%edx),%edx
    1307:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    130b:	89 ca                	mov    %ecx,%edx
    130d:	89 c1                	mov    %eax,%ecx
    130f:	39 d6                	cmp    %edx,%esi
    1311:	76 df                	jbe    12f2 <printint+0x2e>
  if(neg)
    1313:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1317:	74 31                	je     134a <printint+0x86>
    buf[i++] = '-';
    1319:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    131e:	8d 5f 02             	lea    0x2(%edi),%ebx
    1321:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1324:	eb 17                	jmp    133d <printint+0x79>
    x = xx;
    1326:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1328:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    132f:	eb bc                	jmp    12ed <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1331:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1336:	89 f0                	mov    %esi,%eax
    1338:	e8 6d ff ff ff       	call   12aa <putc>
  while(--i >= 0)
    133d:	83 eb 01             	sub    $0x1,%ebx
    1340:	79 ef                	jns    1331 <printint+0x6d>
}
    1342:	83 c4 2c             	add    $0x2c,%esp
    1345:	5b                   	pop    %ebx
    1346:	5e                   	pop    %esi
    1347:	5f                   	pop    %edi
    1348:	5d                   	pop    %ebp
    1349:	c3                   	ret    
    134a:	8b 75 d0             	mov    -0x30(%ebp),%esi
    134d:	eb ee                	jmp    133d <printint+0x79>

0000134f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    134f:	55                   	push   %ebp
    1350:	89 e5                	mov    %esp,%ebp
    1352:	57                   	push   %edi
    1353:	56                   	push   %esi
    1354:	53                   	push   %ebx
    1355:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1358:	8d 45 10             	lea    0x10(%ebp),%eax
    135b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    135e:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1363:	bb 00 00 00 00       	mov    $0x0,%ebx
    1368:	eb 14                	jmp    137e <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    136a:	89 fa                	mov    %edi,%edx
    136c:	8b 45 08             	mov    0x8(%ebp),%eax
    136f:	e8 36 ff ff ff       	call   12aa <putc>
    1374:	eb 05                	jmp    137b <printf+0x2c>
      }
    } else if(state == '%'){
    1376:	83 fe 25             	cmp    $0x25,%esi
    1379:	74 25                	je     13a0 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    137b:	83 c3 01             	add    $0x1,%ebx
    137e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1381:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1385:	84 c0                	test   %al,%al
    1387:	0f 84 20 01 00 00    	je     14ad <printf+0x15e>
    c = fmt[i] & 0xff;
    138d:	0f be f8             	movsbl %al,%edi
    1390:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1393:	85 f6                	test   %esi,%esi
    1395:	75 df                	jne    1376 <printf+0x27>
      if(c == '%'){
    1397:	83 f8 25             	cmp    $0x25,%eax
    139a:	75 ce                	jne    136a <printf+0x1b>
        state = '%';
    139c:	89 c6                	mov    %eax,%esi
    139e:	eb db                	jmp    137b <printf+0x2c>
      if(c == 'd'){
    13a0:	83 f8 25             	cmp    $0x25,%eax
    13a3:	0f 84 cf 00 00 00    	je     1478 <printf+0x129>
    13a9:	0f 8c dd 00 00 00    	jl     148c <printf+0x13d>
    13af:	83 f8 78             	cmp    $0x78,%eax
    13b2:	0f 8f d4 00 00 00    	jg     148c <printf+0x13d>
    13b8:	83 f8 63             	cmp    $0x63,%eax
    13bb:	0f 8c cb 00 00 00    	jl     148c <printf+0x13d>
    13c1:	83 e8 63             	sub    $0x63,%eax
    13c4:	83 f8 15             	cmp    $0x15,%eax
    13c7:	0f 87 bf 00 00 00    	ja     148c <printf+0x13d>
    13cd:	ff 24 85 34 16 00 00 	jmp    *0x1634(,%eax,4)
        printint(fd, *ap, 10, 1);
    13d4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13d7:	8b 17                	mov    (%edi),%edx
    13d9:	83 ec 0c             	sub    $0xc,%esp
    13dc:	6a 01                	push   $0x1
    13de:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13e3:	8b 45 08             	mov    0x8(%ebp),%eax
    13e6:	e8 d9 fe ff ff       	call   12c4 <printint>
        ap++;
    13eb:	83 c7 04             	add    $0x4,%edi
    13ee:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13f1:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13f4:	be 00 00 00 00       	mov    $0x0,%esi
    13f9:	eb 80                	jmp    137b <printf+0x2c>
        printint(fd, *ap, 16, 0);
    13fb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13fe:	8b 17                	mov    (%edi),%edx
    1400:	83 ec 0c             	sub    $0xc,%esp
    1403:	6a 00                	push   $0x0
    1405:	b9 10 00 00 00       	mov    $0x10,%ecx
    140a:	8b 45 08             	mov    0x8(%ebp),%eax
    140d:	e8 b2 fe ff ff       	call   12c4 <printint>
        ap++;
    1412:	83 c7 04             	add    $0x4,%edi
    1415:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1418:	83 c4 10             	add    $0x10,%esp
      state = 0;
    141b:	be 00 00 00 00       	mov    $0x0,%esi
    1420:	e9 56 ff ff ff       	jmp    137b <printf+0x2c>
        s = (char*)*ap;
    1425:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1428:	8b 30                	mov    (%eax),%esi
        ap++;
    142a:	83 c0 04             	add    $0x4,%eax
    142d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1430:	85 f6                	test   %esi,%esi
    1432:	75 15                	jne    1449 <printf+0xfa>
          s = "(null)";
    1434:	be 2b 16 00 00       	mov    $0x162b,%esi
    1439:	eb 0e                	jmp    1449 <printf+0xfa>
          putc(fd, *s);
    143b:	0f be d2             	movsbl %dl,%edx
    143e:	8b 45 08             	mov    0x8(%ebp),%eax
    1441:	e8 64 fe ff ff       	call   12aa <putc>
          s++;
    1446:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1449:	0f b6 16             	movzbl (%esi),%edx
    144c:	84 d2                	test   %dl,%dl
    144e:	75 eb                	jne    143b <printf+0xec>
      state = 0;
    1450:	be 00 00 00 00       	mov    $0x0,%esi
    1455:	e9 21 ff ff ff       	jmp    137b <printf+0x2c>
        putc(fd, *ap);
    145a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    145d:	0f be 17             	movsbl (%edi),%edx
    1460:	8b 45 08             	mov    0x8(%ebp),%eax
    1463:	e8 42 fe ff ff       	call   12aa <putc>
        ap++;
    1468:	83 c7 04             	add    $0x4,%edi
    146b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    146e:	be 00 00 00 00       	mov    $0x0,%esi
    1473:	e9 03 ff ff ff       	jmp    137b <printf+0x2c>
        putc(fd, c);
    1478:	89 fa                	mov    %edi,%edx
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
    147d:	e8 28 fe ff ff       	call   12aa <putc>
      state = 0;
    1482:	be 00 00 00 00       	mov    $0x0,%esi
    1487:	e9 ef fe ff ff       	jmp    137b <printf+0x2c>
        putc(fd, '%');
    148c:	ba 25 00 00 00       	mov    $0x25,%edx
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
    1494:	e8 11 fe ff ff       	call   12aa <putc>
        putc(fd, c);
    1499:	89 fa                	mov    %edi,%edx
    149b:	8b 45 08             	mov    0x8(%ebp),%eax
    149e:	e8 07 fe ff ff       	call   12aa <putc>
      state = 0;
    14a3:	be 00 00 00 00       	mov    $0x0,%esi
    14a8:	e9 ce fe ff ff       	jmp    137b <printf+0x2c>
    }
  }
}
    14ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b0:	5b                   	pop    %ebx
    14b1:	5e                   	pop    %esi
    14b2:	5f                   	pop    %edi
    14b3:	5d                   	pop    %ebp
    14b4:	c3                   	ret    

000014b5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b5:	55                   	push   %ebp
    14b6:	89 e5                	mov    %esp,%ebp
    14b8:	57                   	push   %edi
    14b9:	56                   	push   %esi
    14ba:	53                   	push   %ebx
    14bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c1:	a1 2c 19 00 00       	mov    0x192c,%eax
    14c6:	eb 02                	jmp    14ca <free+0x15>
    14c8:	89 d0                	mov    %edx,%eax
    14ca:	39 c8                	cmp    %ecx,%eax
    14cc:	73 04                	jae    14d2 <free+0x1d>
    14ce:	39 08                	cmp    %ecx,(%eax)
    14d0:	77 12                	ja     14e4 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d2:	8b 10                	mov    (%eax),%edx
    14d4:	39 c2                	cmp    %eax,%edx
    14d6:	77 f0                	ja     14c8 <free+0x13>
    14d8:	39 c8                	cmp    %ecx,%eax
    14da:	72 08                	jb     14e4 <free+0x2f>
    14dc:	39 ca                	cmp    %ecx,%edx
    14de:	77 04                	ja     14e4 <free+0x2f>
    14e0:	89 d0                	mov    %edx,%eax
    14e2:	eb e6                	jmp    14ca <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14e4:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14e7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14ea:	8b 10                	mov    (%eax),%edx
    14ec:	39 d7                	cmp    %edx,%edi
    14ee:	74 19                	je     1509 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14f3:	8b 50 04             	mov    0x4(%eax),%edx
    14f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14f9:	39 ce                	cmp    %ecx,%esi
    14fb:	74 1b                	je     1518 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    14ff:	a3 2c 19 00 00       	mov    %eax,0x192c
}
    1504:	5b                   	pop    %ebx
    1505:	5e                   	pop    %esi
    1506:	5f                   	pop    %edi
    1507:	5d                   	pop    %ebp
    1508:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1509:	03 72 04             	add    0x4(%edx),%esi
    150c:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    150f:	8b 10                	mov    (%eax),%edx
    1511:	8b 12                	mov    (%edx),%edx
    1513:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1516:	eb db                	jmp    14f3 <free+0x3e>
    p->s.size += bp->s.size;
    1518:	03 53 fc             	add    -0x4(%ebx),%edx
    151b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    151e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1521:	89 10                	mov    %edx,(%eax)
    1523:	eb da                	jmp    14ff <free+0x4a>

00001525 <morecore>:

static Header*
morecore(uint nu)
{
    1525:	55                   	push   %ebp
    1526:	89 e5                	mov    %esp,%ebp
    1528:	53                   	push   %ebx
    1529:	83 ec 04             	sub    $0x4,%esp
    152c:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    152e:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1533:	77 05                	ja     153a <morecore+0x15>
    nu = 4096;
    1535:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    153a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1541:	83 ec 0c             	sub    $0xc,%esp
    1544:	50                   	push   %eax
    1545:	e8 28 fd ff ff       	call   1272 <sbrk>
  if(p == (char*)-1)
    154a:	83 c4 10             	add    $0x10,%esp
    154d:	83 f8 ff             	cmp    $0xffffffff,%eax
    1550:	74 1c                	je     156e <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1552:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1555:	83 c0 08             	add    $0x8,%eax
    1558:	83 ec 0c             	sub    $0xc,%esp
    155b:	50                   	push   %eax
    155c:	e8 54 ff ff ff       	call   14b5 <free>
  return freep;
    1561:	a1 2c 19 00 00       	mov    0x192c,%eax
    1566:	83 c4 10             	add    $0x10,%esp
}
    1569:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    156c:	c9                   	leave  
    156d:	c3                   	ret    
    return 0;
    156e:	b8 00 00 00 00       	mov    $0x0,%eax
    1573:	eb f4                	jmp    1569 <morecore+0x44>

00001575 <malloc>:

void*
malloc(uint nbytes)
{
    1575:	55                   	push   %ebp
    1576:	89 e5                	mov    %esp,%ebp
    1578:	53                   	push   %ebx
    1579:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    157c:	8b 45 08             	mov    0x8(%ebp),%eax
    157f:	8d 58 07             	lea    0x7(%eax),%ebx
    1582:	c1 eb 03             	shr    $0x3,%ebx
    1585:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1588:	8b 0d 2c 19 00 00    	mov    0x192c,%ecx
    158e:	85 c9                	test   %ecx,%ecx
    1590:	74 04                	je     1596 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1592:	8b 01                	mov    (%ecx),%eax
    1594:	eb 4a                	jmp    15e0 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1596:	c7 05 2c 19 00 00 30 	movl   $0x1930,0x192c
    159d:	19 00 00 
    15a0:	c7 05 30 19 00 00 30 	movl   $0x1930,0x1930
    15a7:	19 00 00 
    base.s.size = 0;
    15aa:	c7 05 34 19 00 00 00 	movl   $0x0,0x1934
    15b1:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15b4:	b9 30 19 00 00       	mov    $0x1930,%ecx
    15b9:	eb d7                	jmp    1592 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15bb:	74 19                	je     15d6 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15bd:	29 da                	sub    %ebx,%edx
    15bf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15c2:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15c5:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15c8:	89 0d 2c 19 00 00    	mov    %ecx,0x192c
      return (void*)(p + 1);
    15ce:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15d4:	c9                   	leave  
    15d5:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15d6:	8b 10                	mov    (%eax),%edx
    15d8:	89 11                	mov    %edx,(%ecx)
    15da:	eb ec                	jmp    15c8 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15dc:	89 c1                	mov    %eax,%ecx
    15de:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15e0:	8b 50 04             	mov    0x4(%eax),%edx
    15e3:	39 da                	cmp    %ebx,%edx
    15e5:	73 d4                	jae    15bb <malloc+0x46>
    if(p == freep)
    15e7:	39 05 2c 19 00 00    	cmp    %eax,0x192c
    15ed:	75 ed                	jne    15dc <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15ef:	89 d8                	mov    %ebx,%eax
    15f1:	e8 2f ff ff ff       	call   1525 <morecore>
    15f6:	85 c0                	test   %eax,%eax
    15f8:	75 e2                	jne    15dc <malloc+0x67>
    15fa:	eb d5                	jmp    15d1 <malloc+0x5c>
