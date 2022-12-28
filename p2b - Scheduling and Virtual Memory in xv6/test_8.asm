
_test_8:     file format elf32-i386


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

   if(getpinfo((struct pstat *)1000000) == -1)
    1011:	68 40 42 0f 00       	push   $0xf4240
    1016:	e8 7a 02 00 00       	call   1295 <getpinfo>
    101b:	83 c4 10             	add    $0x10,%esp
    101e:	83 f8 ff             	cmp    $0xffffffff,%eax
    1021:	74 17                	je     103a <main+0x3a>
   {
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    1023:	83 ec 08             	sub    $0x8,%esp
    1026:	68 18 16 00 00       	push   $0x1618
    102b:	6a 01                	push   $0x1
    102d:	e8 20 03 00 00       	call   1352 <printf>
    1032:	83 c4 10             	add    $0x10,%esp
   }
   
   exit();
    1035:	e8 b3 01 00 00       	call   11ed <exit>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    103a:	83 ec 08             	sub    $0x8,%esp
    103d:	68 00 16 00 00       	push   $0x1600
    1042:	6a 01                	push   $0x1
    1044:	e8 09 03 00 00       	call   1352 <printf>
    1049:	83 c4 10             	add    $0x10,%esp
    104c:	eb e7                	jmp    1035 <main+0x35>

0000104e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    104e:	55                   	push   %ebp
    104f:	89 e5                	mov    %esp,%ebp
    1051:	56                   	push   %esi
    1052:	53                   	push   %ebx
    1053:	8b 75 08             	mov    0x8(%ebp),%esi
    1056:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1059:	89 f0                	mov    %esi,%eax
    105b:	89 d1                	mov    %edx,%ecx
    105d:	83 c2 01             	add    $0x1,%edx
    1060:	89 c3                	mov    %eax,%ebx
    1062:	83 c0 01             	add    $0x1,%eax
    1065:	0f b6 09             	movzbl (%ecx),%ecx
    1068:	88 0b                	mov    %cl,(%ebx)
    106a:	84 c9                	test   %cl,%cl
    106c:	75 ed                	jne    105b <strcpy+0xd>
    ;
  return os;
}
    106e:	89 f0                	mov    %esi,%eax
    1070:	5b                   	pop    %ebx
    1071:	5e                   	pop    %esi
    1072:	5d                   	pop    %ebp
    1073:	c3                   	ret    

00001074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1074:	55                   	push   %ebp
    1075:	89 e5                	mov    %esp,%ebp
    1077:	8b 4d 08             	mov    0x8(%ebp),%ecx
    107a:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    107d:	eb 06                	jmp    1085 <strcmp+0x11>
    p++, q++;
    107f:	83 c1 01             	add    $0x1,%ecx
    1082:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1085:	0f b6 01             	movzbl (%ecx),%eax
    1088:	84 c0                	test   %al,%al
    108a:	74 04                	je     1090 <strcmp+0x1c>
    108c:	3a 02                	cmp    (%edx),%al
    108e:	74 ef                	je     107f <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1090:	0f b6 c0             	movzbl %al,%eax
    1093:	0f b6 12             	movzbl (%edx),%edx
    1096:	29 d0                	sub    %edx,%eax
}
    1098:	5d                   	pop    %ebp
    1099:	c3                   	ret    

0000109a <strlen>:

uint
strlen(const char *s)
{
    109a:	55                   	push   %ebp
    109b:	89 e5                	mov    %esp,%ebp
    109d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10a0:	b8 00 00 00 00       	mov    $0x0,%eax
    10a5:	eb 03                	jmp    10aa <strlen+0x10>
    10a7:	83 c0 01             	add    $0x1,%eax
    10aa:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10ae:	75 f7                	jne    10a7 <strlen+0xd>
    ;
  return n;
}
    10b0:	5d                   	pop    %ebp
    10b1:	c3                   	ret    

000010b2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10b2:	55                   	push   %ebp
    10b3:	89 e5                	mov    %esp,%ebp
    10b5:	57                   	push   %edi
    10b6:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10b9:	89 d7                	mov    %edx,%edi
    10bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10be:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c1:	fc                   	cld    
    10c2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c4:	89 d0                	mov    %edx,%eax
    10c6:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10c9:	c9                   	leave  
    10ca:	c3                   	ret    

000010cb <strchr>:

char*
strchr(const char *s, char c)
{
    10cb:	55                   	push   %ebp
    10cc:	89 e5                	mov    %esp,%ebp
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10d5:	eb 03                	jmp    10da <strchr+0xf>
    10d7:	83 c0 01             	add    $0x1,%eax
    10da:	0f b6 10             	movzbl (%eax),%edx
    10dd:	84 d2                	test   %dl,%dl
    10df:	74 06                	je     10e7 <strchr+0x1c>
    if(*s == c)
    10e1:	38 ca                	cmp    %cl,%dl
    10e3:	75 f2                	jne    10d7 <strchr+0xc>
    10e5:	eb 05                	jmp    10ec <strchr+0x21>
      return (char*)s;
  return 0;
    10e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10ec:	5d                   	pop    %ebp
    10ed:	c3                   	ret    

000010ee <gets>:

char*
gets(char *buf, int max)
{
    10ee:	55                   	push   %ebp
    10ef:	89 e5                	mov    %esp,%ebp
    10f1:	57                   	push   %edi
    10f2:	56                   	push   %esi
    10f3:	53                   	push   %ebx
    10f4:	83 ec 1c             	sub    $0x1c,%esp
    10f7:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10fa:	bb 00 00 00 00       	mov    $0x0,%ebx
    10ff:	89 de                	mov    %ebx,%esi
    1101:	83 c3 01             	add    $0x1,%ebx
    1104:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1107:	7d 2e                	jge    1137 <gets+0x49>
    cc = read(0, &c, 1);
    1109:	83 ec 04             	sub    $0x4,%esp
    110c:	6a 01                	push   $0x1
    110e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1111:	50                   	push   %eax
    1112:	6a 00                	push   $0x0
    1114:	e8 ec 00 00 00       	call   1205 <read>
    if(cc < 1)
    1119:	83 c4 10             	add    $0x10,%esp
    111c:	85 c0                	test   %eax,%eax
    111e:	7e 17                	jle    1137 <gets+0x49>
      break;
    buf[i++] = c;
    1120:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1124:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1127:	3c 0a                	cmp    $0xa,%al
    1129:	0f 94 c2             	sete   %dl
    112c:	3c 0d                	cmp    $0xd,%al
    112e:	0f 94 c0             	sete   %al
    1131:	08 c2                	or     %al,%dl
    1133:	74 ca                	je     10ff <gets+0x11>
    buf[i++] = c;
    1135:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1137:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    113b:	89 f8                	mov    %edi,%eax
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    

00001145 <stat>:

int
stat(const char *n, struct stat *st)
{
    1145:	55                   	push   %ebp
    1146:	89 e5                	mov    %esp,%ebp
    1148:	56                   	push   %esi
    1149:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    114a:	83 ec 08             	sub    $0x8,%esp
    114d:	6a 00                	push   $0x0
    114f:	ff 75 08             	push   0x8(%ebp)
    1152:	e8 d6 00 00 00       	call   122d <open>
  if(fd < 0)
    1157:	83 c4 10             	add    $0x10,%esp
    115a:	85 c0                	test   %eax,%eax
    115c:	78 24                	js     1182 <stat+0x3d>
    115e:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1160:	83 ec 08             	sub    $0x8,%esp
    1163:	ff 75 0c             	push   0xc(%ebp)
    1166:	50                   	push   %eax
    1167:	e8 d9 00 00 00       	call   1245 <fstat>
    116c:	89 c6                	mov    %eax,%esi
  close(fd);
    116e:	89 1c 24             	mov    %ebx,(%esp)
    1171:	e8 9f 00 00 00       	call   1215 <close>
  return r;
    1176:	83 c4 10             	add    $0x10,%esp
}
    1179:	89 f0                	mov    %esi,%eax
    117b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    117e:	5b                   	pop    %ebx
    117f:	5e                   	pop    %esi
    1180:	5d                   	pop    %ebp
    1181:	c3                   	ret    
    return -1;
    1182:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1187:	eb f0                	jmp    1179 <stat+0x34>

00001189 <atoi>:

int
atoi(const char *s)
{
    1189:	55                   	push   %ebp
    118a:	89 e5                	mov    %esp,%ebp
    118c:	53                   	push   %ebx
    118d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1190:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1195:	eb 10                	jmp    11a7 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1197:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    119a:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    119d:	83 c1 01             	add    $0x1,%ecx
    11a0:	0f be c0             	movsbl %al,%eax
    11a3:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11a7:	0f b6 01             	movzbl (%ecx),%eax
    11aa:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11ad:	80 fb 09             	cmp    $0x9,%bl
    11b0:	76 e5                	jbe    1197 <atoi+0xe>
  return n;
}
    11b2:	89 d0                	mov    %edx,%eax
    11b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11b7:	c9                   	leave  
    11b8:	c3                   	ret    

000011b9 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11b9:	55                   	push   %ebp
    11ba:	89 e5                	mov    %esp,%ebp
    11bc:	56                   	push   %esi
    11bd:	53                   	push   %ebx
    11be:	8b 75 08             	mov    0x8(%ebp),%esi
    11c1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11c4:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11c7:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11c9:	eb 0d                	jmp    11d8 <memmove+0x1f>
    *dst++ = *src++;
    11cb:	0f b6 01             	movzbl (%ecx),%eax
    11ce:	88 02                	mov    %al,(%edx)
    11d0:	8d 49 01             	lea    0x1(%ecx),%ecx
    11d3:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11d6:	89 d8                	mov    %ebx,%eax
    11d8:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11db:	85 c0                	test   %eax,%eax
    11dd:	7f ec                	jg     11cb <memmove+0x12>
  return vdst;
}
    11df:	89 f0                	mov    %esi,%eax
    11e1:	5b                   	pop    %ebx
    11e2:	5e                   	pop    %esi
    11e3:	5d                   	pop    %ebp
    11e4:	c3                   	ret    

000011e5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11e5:	b8 01 00 00 00       	mov    $0x1,%eax
    11ea:	cd 40                	int    $0x40
    11ec:	c3                   	ret    

000011ed <exit>:
SYSCALL(exit)
    11ed:	b8 02 00 00 00       	mov    $0x2,%eax
    11f2:	cd 40                	int    $0x40
    11f4:	c3                   	ret    

000011f5 <wait>:
SYSCALL(wait)
    11f5:	b8 03 00 00 00       	mov    $0x3,%eax
    11fa:	cd 40                	int    $0x40
    11fc:	c3                   	ret    

000011fd <pipe>:
SYSCALL(pipe)
    11fd:	b8 04 00 00 00       	mov    $0x4,%eax
    1202:	cd 40                	int    $0x40
    1204:	c3                   	ret    

00001205 <read>:
SYSCALL(read)
    1205:	b8 05 00 00 00       	mov    $0x5,%eax
    120a:	cd 40                	int    $0x40
    120c:	c3                   	ret    

0000120d <write>:
SYSCALL(write)
    120d:	b8 10 00 00 00       	mov    $0x10,%eax
    1212:	cd 40                	int    $0x40
    1214:	c3                   	ret    

00001215 <close>:
SYSCALL(close)
    1215:	b8 15 00 00 00       	mov    $0x15,%eax
    121a:	cd 40                	int    $0x40
    121c:	c3                   	ret    

0000121d <kill>:
SYSCALL(kill)
    121d:	b8 06 00 00 00       	mov    $0x6,%eax
    1222:	cd 40                	int    $0x40
    1224:	c3                   	ret    

00001225 <exec>:
SYSCALL(exec)
    1225:	b8 07 00 00 00       	mov    $0x7,%eax
    122a:	cd 40                	int    $0x40
    122c:	c3                   	ret    

0000122d <open>:
SYSCALL(open)
    122d:	b8 0f 00 00 00       	mov    $0xf,%eax
    1232:	cd 40                	int    $0x40
    1234:	c3                   	ret    

00001235 <mknod>:
SYSCALL(mknod)
    1235:	b8 11 00 00 00       	mov    $0x11,%eax
    123a:	cd 40                	int    $0x40
    123c:	c3                   	ret    

0000123d <unlink>:
SYSCALL(unlink)
    123d:	b8 12 00 00 00       	mov    $0x12,%eax
    1242:	cd 40                	int    $0x40
    1244:	c3                   	ret    

00001245 <fstat>:
SYSCALL(fstat)
    1245:	b8 08 00 00 00       	mov    $0x8,%eax
    124a:	cd 40                	int    $0x40
    124c:	c3                   	ret    

0000124d <link>:
SYSCALL(link)
    124d:	b8 13 00 00 00       	mov    $0x13,%eax
    1252:	cd 40                	int    $0x40
    1254:	c3                   	ret    

00001255 <mkdir>:
SYSCALL(mkdir)
    1255:	b8 14 00 00 00       	mov    $0x14,%eax
    125a:	cd 40                	int    $0x40
    125c:	c3                   	ret    

0000125d <chdir>:
SYSCALL(chdir)
    125d:	b8 09 00 00 00       	mov    $0x9,%eax
    1262:	cd 40                	int    $0x40
    1264:	c3                   	ret    

00001265 <dup>:
SYSCALL(dup)
    1265:	b8 0a 00 00 00       	mov    $0xa,%eax
    126a:	cd 40                	int    $0x40
    126c:	c3                   	ret    

0000126d <getpid>:
SYSCALL(getpid)
    126d:	b8 0b 00 00 00       	mov    $0xb,%eax
    1272:	cd 40                	int    $0x40
    1274:	c3                   	ret    

00001275 <sbrk>:
SYSCALL(sbrk)
    1275:	b8 0c 00 00 00       	mov    $0xc,%eax
    127a:	cd 40                	int    $0x40
    127c:	c3                   	ret    

0000127d <sleep>:
SYSCALL(sleep)
    127d:	b8 0d 00 00 00       	mov    $0xd,%eax
    1282:	cd 40                	int    $0x40
    1284:	c3                   	ret    

00001285 <uptime>:
SYSCALL(uptime)
    1285:	b8 0e 00 00 00       	mov    $0xe,%eax
    128a:	cd 40                	int    $0x40
    128c:	c3                   	ret    

0000128d <settickets>:
SYSCALL(settickets)
    128d:	b8 16 00 00 00       	mov    $0x16,%eax
    1292:	cd 40                	int    $0x40
    1294:	c3                   	ret    

00001295 <getpinfo>:
SYSCALL(getpinfo)
    1295:	b8 17 00 00 00       	mov    $0x17,%eax
    129a:	cd 40                	int    $0x40
    129c:	c3                   	ret    

0000129d <mprotect>:
SYSCALL(mprotect)
    129d:	b8 18 00 00 00       	mov    $0x18,%eax
    12a2:	cd 40                	int    $0x40
    12a4:	c3                   	ret    

000012a5 <munprotect>:
    12a5:	b8 19 00 00 00       	mov    $0x19,%eax
    12aa:	cd 40                	int    $0x40
    12ac:	c3                   	ret    

000012ad <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12ad:	55                   	push   %ebp
    12ae:	89 e5                	mov    %esp,%ebp
    12b0:	83 ec 1c             	sub    $0x1c,%esp
    12b3:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12b6:	6a 01                	push   $0x1
    12b8:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12bb:	52                   	push   %edx
    12bc:	50                   	push   %eax
    12bd:	e8 4b ff ff ff       	call   120d <write>
}
    12c2:	83 c4 10             	add    $0x10,%esp
    12c5:	c9                   	leave  
    12c6:	c3                   	ret    

000012c7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12c7:	55                   	push   %ebp
    12c8:	89 e5                	mov    %esp,%ebp
    12ca:	57                   	push   %edi
    12cb:	56                   	push   %esi
    12cc:	53                   	push   %ebx
    12cd:	83 ec 2c             	sub    $0x2c,%esp
    12d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12d3:	89 d0                	mov    %edx,%eax
    12d5:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12db:	0f 95 c1             	setne  %cl
    12de:	c1 ea 1f             	shr    $0x1f,%edx
    12e1:	84 d1                	test   %dl,%cl
    12e3:	74 44                	je     1329 <printint+0x62>
    neg = 1;
    x = -xx;
    12e5:	f7 d8                	neg    %eax
    12e7:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12e9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12f0:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12f5:	89 c8                	mov    %ecx,%eax
    12f7:	ba 00 00 00 00       	mov    $0x0,%edx
    12fc:	f7 f6                	div    %esi
    12fe:	89 df                	mov    %ebx,%edi
    1300:	83 c3 01             	add    $0x1,%ebx
    1303:	0f b6 92 90 16 00 00 	movzbl 0x1690(%edx),%edx
    130a:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    130e:	89 ca                	mov    %ecx,%edx
    1310:	89 c1                	mov    %eax,%ecx
    1312:	39 d6                	cmp    %edx,%esi
    1314:	76 df                	jbe    12f5 <printint+0x2e>
  if(neg)
    1316:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    131a:	74 31                	je     134d <printint+0x86>
    buf[i++] = '-';
    131c:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1321:	8d 5f 02             	lea    0x2(%edi),%ebx
    1324:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1327:	eb 17                	jmp    1340 <printint+0x79>
    x = xx;
    1329:	89 c1                	mov    %eax,%ecx
  neg = 0;
    132b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1332:	eb bc                	jmp    12f0 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1334:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1339:	89 f0                	mov    %esi,%eax
    133b:	e8 6d ff ff ff       	call   12ad <putc>
  while(--i >= 0)
    1340:	83 eb 01             	sub    $0x1,%ebx
    1343:	79 ef                	jns    1334 <printint+0x6d>
}
    1345:	83 c4 2c             	add    $0x2c,%esp
    1348:	5b                   	pop    %ebx
    1349:	5e                   	pop    %esi
    134a:	5f                   	pop    %edi
    134b:	5d                   	pop    %ebp
    134c:	c3                   	ret    
    134d:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1350:	eb ee                	jmp    1340 <printint+0x79>

00001352 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1352:	55                   	push   %ebp
    1353:	89 e5                	mov    %esp,%ebp
    1355:	57                   	push   %edi
    1356:	56                   	push   %esi
    1357:	53                   	push   %ebx
    1358:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    135b:	8d 45 10             	lea    0x10(%ebp),%eax
    135e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1361:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1366:	bb 00 00 00 00       	mov    $0x0,%ebx
    136b:	eb 14                	jmp    1381 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    136d:	89 fa                	mov    %edi,%edx
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	e8 36 ff ff ff       	call   12ad <putc>
    1377:	eb 05                	jmp    137e <printf+0x2c>
      }
    } else if(state == '%'){
    1379:	83 fe 25             	cmp    $0x25,%esi
    137c:	74 25                	je     13a3 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    137e:	83 c3 01             	add    $0x1,%ebx
    1381:	8b 45 0c             	mov    0xc(%ebp),%eax
    1384:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1388:	84 c0                	test   %al,%al
    138a:	0f 84 20 01 00 00    	je     14b0 <printf+0x15e>
    c = fmt[i] & 0xff;
    1390:	0f be f8             	movsbl %al,%edi
    1393:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1396:	85 f6                	test   %esi,%esi
    1398:	75 df                	jne    1379 <printf+0x27>
      if(c == '%'){
    139a:	83 f8 25             	cmp    $0x25,%eax
    139d:	75 ce                	jne    136d <printf+0x1b>
        state = '%';
    139f:	89 c6                	mov    %eax,%esi
    13a1:	eb db                	jmp    137e <printf+0x2c>
      if(c == 'd'){
    13a3:	83 f8 25             	cmp    $0x25,%eax
    13a6:	0f 84 cf 00 00 00    	je     147b <printf+0x129>
    13ac:	0f 8c dd 00 00 00    	jl     148f <printf+0x13d>
    13b2:	83 f8 78             	cmp    $0x78,%eax
    13b5:	0f 8f d4 00 00 00    	jg     148f <printf+0x13d>
    13bb:	83 f8 63             	cmp    $0x63,%eax
    13be:	0f 8c cb 00 00 00    	jl     148f <printf+0x13d>
    13c4:	83 e8 63             	sub    $0x63,%eax
    13c7:	83 f8 15             	cmp    $0x15,%eax
    13ca:	0f 87 bf 00 00 00    	ja     148f <printf+0x13d>
    13d0:	ff 24 85 38 16 00 00 	jmp    *0x1638(,%eax,4)
        printint(fd, *ap, 10, 1);
    13d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13da:	8b 17                	mov    (%edi),%edx
    13dc:	83 ec 0c             	sub    $0xc,%esp
    13df:	6a 01                	push   $0x1
    13e1:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13e6:	8b 45 08             	mov    0x8(%ebp),%eax
    13e9:	e8 d9 fe ff ff       	call   12c7 <printint>
        ap++;
    13ee:	83 c7 04             	add    $0x4,%edi
    13f1:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13f4:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13f7:	be 00 00 00 00       	mov    $0x0,%esi
    13fc:	eb 80                	jmp    137e <printf+0x2c>
        printint(fd, *ap, 16, 0);
    13fe:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1401:	8b 17                	mov    (%edi),%edx
    1403:	83 ec 0c             	sub    $0xc,%esp
    1406:	6a 00                	push   $0x0
    1408:	b9 10 00 00 00       	mov    $0x10,%ecx
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
    1410:	e8 b2 fe ff ff       	call   12c7 <printint>
        ap++;
    1415:	83 c7 04             	add    $0x4,%edi
    1418:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    141b:	83 c4 10             	add    $0x10,%esp
      state = 0;
    141e:	be 00 00 00 00       	mov    $0x0,%esi
    1423:	e9 56 ff ff ff       	jmp    137e <printf+0x2c>
        s = (char*)*ap;
    1428:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    142b:	8b 30                	mov    (%eax),%esi
        ap++;
    142d:	83 c0 04             	add    $0x4,%eax
    1430:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1433:	85 f6                	test   %esi,%esi
    1435:	75 15                	jne    144c <printf+0xfa>
          s = "(null)";
    1437:	be 2f 16 00 00       	mov    $0x162f,%esi
    143c:	eb 0e                	jmp    144c <printf+0xfa>
          putc(fd, *s);
    143e:	0f be d2             	movsbl %dl,%edx
    1441:	8b 45 08             	mov    0x8(%ebp),%eax
    1444:	e8 64 fe ff ff       	call   12ad <putc>
          s++;
    1449:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    144c:	0f b6 16             	movzbl (%esi),%edx
    144f:	84 d2                	test   %dl,%dl
    1451:	75 eb                	jne    143e <printf+0xec>
      state = 0;
    1453:	be 00 00 00 00       	mov    $0x0,%esi
    1458:	e9 21 ff ff ff       	jmp    137e <printf+0x2c>
        putc(fd, *ap);
    145d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1460:	0f be 17             	movsbl (%edi),%edx
    1463:	8b 45 08             	mov    0x8(%ebp),%eax
    1466:	e8 42 fe ff ff       	call   12ad <putc>
        ap++;
    146b:	83 c7 04             	add    $0x4,%edi
    146e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1471:	be 00 00 00 00       	mov    $0x0,%esi
    1476:	e9 03 ff ff ff       	jmp    137e <printf+0x2c>
        putc(fd, c);
    147b:	89 fa                	mov    %edi,%edx
    147d:	8b 45 08             	mov    0x8(%ebp),%eax
    1480:	e8 28 fe ff ff       	call   12ad <putc>
      state = 0;
    1485:	be 00 00 00 00       	mov    $0x0,%esi
    148a:	e9 ef fe ff ff       	jmp    137e <printf+0x2c>
        putc(fd, '%');
    148f:	ba 25 00 00 00       	mov    $0x25,%edx
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
    1497:	e8 11 fe ff ff       	call   12ad <putc>
        putc(fd, c);
    149c:	89 fa                	mov    %edi,%edx
    149e:	8b 45 08             	mov    0x8(%ebp),%eax
    14a1:	e8 07 fe ff ff       	call   12ad <putc>
      state = 0;
    14a6:	be 00 00 00 00       	mov    $0x0,%esi
    14ab:	e9 ce fe ff ff       	jmp    137e <printf+0x2c>
    }
  }
}
    14b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b3:	5b                   	pop    %ebx
    14b4:	5e                   	pop    %esi
    14b5:	5f                   	pop    %edi
    14b6:	5d                   	pop    %ebp
    14b7:	c3                   	ret    

000014b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b8:	55                   	push   %ebp
    14b9:	89 e5                	mov    %esp,%ebp
    14bb:	57                   	push   %edi
    14bc:	56                   	push   %esi
    14bd:	53                   	push   %ebx
    14be:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14c1:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c4:	a1 30 19 00 00       	mov    0x1930,%eax
    14c9:	eb 02                	jmp    14cd <free+0x15>
    14cb:	89 d0                	mov    %edx,%eax
    14cd:	39 c8                	cmp    %ecx,%eax
    14cf:	73 04                	jae    14d5 <free+0x1d>
    14d1:	39 08                	cmp    %ecx,(%eax)
    14d3:	77 12                	ja     14e7 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d5:	8b 10                	mov    (%eax),%edx
    14d7:	39 c2                	cmp    %eax,%edx
    14d9:	77 f0                	ja     14cb <free+0x13>
    14db:	39 c8                	cmp    %ecx,%eax
    14dd:	72 08                	jb     14e7 <free+0x2f>
    14df:	39 ca                	cmp    %ecx,%edx
    14e1:	77 04                	ja     14e7 <free+0x2f>
    14e3:	89 d0                	mov    %edx,%eax
    14e5:	eb e6                	jmp    14cd <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14e7:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14ea:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14ed:	8b 10                	mov    (%eax),%edx
    14ef:	39 d7                	cmp    %edx,%edi
    14f1:	74 19                	je     150c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14f6:	8b 50 04             	mov    0x4(%eax),%edx
    14f9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14fc:	39 ce                	cmp    %ecx,%esi
    14fe:	74 1b                	je     151b <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1500:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1502:	a3 30 19 00 00       	mov    %eax,0x1930
}
    1507:	5b                   	pop    %ebx
    1508:	5e                   	pop    %esi
    1509:	5f                   	pop    %edi
    150a:	5d                   	pop    %ebp
    150b:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    150c:	03 72 04             	add    0x4(%edx),%esi
    150f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1512:	8b 10                	mov    (%eax),%edx
    1514:	8b 12                	mov    (%edx),%edx
    1516:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1519:	eb db                	jmp    14f6 <free+0x3e>
    p->s.size += bp->s.size;
    151b:	03 53 fc             	add    -0x4(%ebx),%edx
    151e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1521:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1524:	89 10                	mov    %edx,(%eax)
    1526:	eb da                	jmp    1502 <free+0x4a>

00001528 <morecore>:

static Header*
morecore(uint nu)
{
    1528:	55                   	push   %ebp
    1529:	89 e5                	mov    %esp,%ebp
    152b:	53                   	push   %ebx
    152c:	83 ec 04             	sub    $0x4,%esp
    152f:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1531:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1536:	77 05                	ja     153d <morecore+0x15>
    nu = 4096;
    1538:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    153d:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1544:	83 ec 0c             	sub    $0xc,%esp
    1547:	50                   	push   %eax
    1548:	e8 28 fd ff ff       	call   1275 <sbrk>
  if(p == (char*)-1)
    154d:	83 c4 10             	add    $0x10,%esp
    1550:	83 f8 ff             	cmp    $0xffffffff,%eax
    1553:	74 1c                	je     1571 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1555:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1558:	83 c0 08             	add    $0x8,%eax
    155b:	83 ec 0c             	sub    $0xc,%esp
    155e:	50                   	push   %eax
    155f:	e8 54 ff ff ff       	call   14b8 <free>
  return freep;
    1564:	a1 30 19 00 00       	mov    0x1930,%eax
    1569:	83 c4 10             	add    $0x10,%esp
}
    156c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    156f:	c9                   	leave  
    1570:	c3                   	ret    
    return 0;
    1571:	b8 00 00 00 00       	mov    $0x0,%eax
    1576:	eb f4                	jmp    156c <morecore+0x44>

00001578 <malloc>:

void*
malloc(uint nbytes)
{
    1578:	55                   	push   %ebp
    1579:	89 e5                	mov    %esp,%ebp
    157b:	53                   	push   %ebx
    157c:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    157f:	8b 45 08             	mov    0x8(%ebp),%eax
    1582:	8d 58 07             	lea    0x7(%eax),%ebx
    1585:	c1 eb 03             	shr    $0x3,%ebx
    1588:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    158b:	8b 0d 30 19 00 00    	mov    0x1930,%ecx
    1591:	85 c9                	test   %ecx,%ecx
    1593:	74 04                	je     1599 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1595:	8b 01                	mov    (%ecx),%eax
    1597:	eb 4a                	jmp    15e3 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1599:	c7 05 30 19 00 00 34 	movl   $0x1934,0x1930
    15a0:	19 00 00 
    15a3:	c7 05 34 19 00 00 34 	movl   $0x1934,0x1934
    15aa:	19 00 00 
    base.s.size = 0;
    15ad:	c7 05 38 19 00 00 00 	movl   $0x0,0x1938
    15b4:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15b7:	b9 34 19 00 00       	mov    $0x1934,%ecx
    15bc:	eb d7                	jmp    1595 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15be:	74 19                	je     15d9 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15c0:	29 da                	sub    %ebx,%edx
    15c2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15c5:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15c8:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15cb:	89 0d 30 19 00 00    	mov    %ecx,0x1930
      return (void*)(p + 1);
    15d1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15d7:	c9                   	leave  
    15d8:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15d9:	8b 10                	mov    (%eax),%edx
    15db:	89 11                	mov    %edx,(%ecx)
    15dd:	eb ec                	jmp    15cb <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15df:	89 c1                	mov    %eax,%ecx
    15e1:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15e3:	8b 50 04             	mov    0x4(%eax),%edx
    15e6:	39 da                	cmp    %ebx,%edx
    15e8:	73 d4                	jae    15be <malloc+0x46>
    if(p == freep)
    15ea:	39 05 30 19 00 00    	cmp    %eax,0x1930
    15f0:	75 ed                	jne    15df <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15f2:	89 d8                	mov    %ebx,%eax
    15f4:	e8 2f ff ff ff       	call   1528 <morecore>
    15f9:	85 c0                	test   %eax,%eax
    15fb:	75 e2                	jne    15df <malloc+0x67>
    15fd:	eb d5                	jmp    15d4 <malloc+0x5c>
