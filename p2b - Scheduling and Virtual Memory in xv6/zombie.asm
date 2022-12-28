
_zombie:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
    1011:	e8 af 01 00 00       	call   11c5 <fork>
    1016:	85 c0                	test   %eax,%eax
    1018:	7f 05                	jg     101f <main+0x1f>
    sleep(5);  // Let child exit before parent.
  exit();
    101a:	e8 ae 01 00 00       	call   11cd <exit>
    sleep(5);  // Let child exit before parent.
    101f:	83 ec 0c             	sub    $0xc,%esp
    1022:	6a 05                	push   $0x5
    1024:	e8 34 02 00 00       	call   125d <sleep>
    1029:	83 c4 10             	add    $0x10,%esp
    102c:	eb ec                	jmp    101a <main+0x1a>

0000102e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    102e:	55                   	push   %ebp
    102f:	89 e5                	mov    %esp,%ebp
    1031:	56                   	push   %esi
    1032:	53                   	push   %ebx
    1033:	8b 75 08             	mov    0x8(%ebp),%esi
    1036:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1039:	89 f0                	mov    %esi,%eax
    103b:	89 d1                	mov    %edx,%ecx
    103d:	83 c2 01             	add    $0x1,%edx
    1040:	89 c3                	mov    %eax,%ebx
    1042:	83 c0 01             	add    $0x1,%eax
    1045:	0f b6 09             	movzbl (%ecx),%ecx
    1048:	88 0b                	mov    %cl,(%ebx)
    104a:	84 c9                	test   %cl,%cl
    104c:	75 ed                	jne    103b <strcpy+0xd>
    ;
  return os;
}
    104e:	89 f0                	mov    %esi,%eax
    1050:	5b                   	pop    %ebx
    1051:	5e                   	pop    %esi
    1052:	5d                   	pop    %ebp
    1053:	c3                   	ret    

00001054 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1054:	55                   	push   %ebp
    1055:	89 e5                	mov    %esp,%ebp
    1057:	8b 4d 08             	mov    0x8(%ebp),%ecx
    105a:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    105d:	eb 06                	jmp    1065 <strcmp+0x11>
    p++, q++;
    105f:	83 c1 01             	add    $0x1,%ecx
    1062:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1065:	0f b6 01             	movzbl (%ecx),%eax
    1068:	84 c0                	test   %al,%al
    106a:	74 04                	je     1070 <strcmp+0x1c>
    106c:	3a 02                	cmp    (%edx),%al
    106e:	74 ef                	je     105f <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1070:	0f b6 c0             	movzbl %al,%eax
    1073:	0f b6 12             	movzbl (%edx),%edx
    1076:	29 d0                	sub    %edx,%eax
}
    1078:	5d                   	pop    %ebp
    1079:	c3                   	ret    

0000107a <strlen>:

uint
strlen(const char *s)
{
    107a:	55                   	push   %ebp
    107b:	89 e5                	mov    %esp,%ebp
    107d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1080:	b8 00 00 00 00       	mov    $0x0,%eax
    1085:	eb 03                	jmp    108a <strlen+0x10>
    1087:	83 c0 01             	add    $0x1,%eax
    108a:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    108e:	75 f7                	jne    1087 <strlen+0xd>
    ;
  return n;
}
    1090:	5d                   	pop    %ebp
    1091:	c3                   	ret    

00001092 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1092:	55                   	push   %ebp
    1093:	89 e5                	mov    %esp,%ebp
    1095:	57                   	push   %edi
    1096:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1099:	89 d7                	mov    %edx,%edi
    109b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    109e:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a1:	fc                   	cld    
    10a2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10a4:	89 d0                	mov    %edx,%eax
    10a6:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10a9:	c9                   	leave  
    10aa:	c3                   	ret    

000010ab <strchr>:

char*
strchr(const char *s, char c)
{
    10ab:	55                   	push   %ebp
    10ac:	89 e5                	mov    %esp,%ebp
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10b5:	eb 03                	jmp    10ba <strchr+0xf>
    10b7:	83 c0 01             	add    $0x1,%eax
    10ba:	0f b6 10             	movzbl (%eax),%edx
    10bd:	84 d2                	test   %dl,%dl
    10bf:	74 06                	je     10c7 <strchr+0x1c>
    if(*s == c)
    10c1:	38 ca                	cmp    %cl,%dl
    10c3:	75 f2                	jne    10b7 <strchr+0xc>
    10c5:	eb 05                	jmp    10cc <strchr+0x21>
      return (char*)s;
  return 0;
    10c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10cc:	5d                   	pop    %ebp
    10cd:	c3                   	ret    

000010ce <gets>:

char*
gets(char *buf, int max)
{
    10ce:	55                   	push   %ebp
    10cf:	89 e5                	mov    %esp,%ebp
    10d1:	57                   	push   %edi
    10d2:	56                   	push   %esi
    10d3:	53                   	push   %ebx
    10d4:	83 ec 1c             	sub    $0x1c,%esp
    10d7:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10da:	bb 00 00 00 00       	mov    $0x0,%ebx
    10df:	89 de                	mov    %ebx,%esi
    10e1:	83 c3 01             	add    $0x1,%ebx
    10e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    10e7:	7d 2e                	jge    1117 <gets+0x49>
    cc = read(0, &c, 1);
    10e9:	83 ec 04             	sub    $0x4,%esp
    10ec:	6a 01                	push   $0x1
    10ee:	8d 45 e7             	lea    -0x19(%ebp),%eax
    10f1:	50                   	push   %eax
    10f2:	6a 00                	push   $0x0
    10f4:	e8 ec 00 00 00       	call   11e5 <read>
    if(cc < 1)
    10f9:	83 c4 10             	add    $0x10,%esp
    10fc:	85 c0                	test   %eax,%eax
    10fe:	7e 17                	jle    1117 <gets+0x49>
      break;
    buf[i++] = c;
    1100:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1104:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1107:	3c 0a                	cmp    $0xa,%al
    1109:	0f 94 c2             	sete   %dl
    110c:	3c 0d                	cmp    $0xd,%al
    110e:	0f 94 c0             	sete   %al
    1111:	08 c2                	or     %al,%dl
    1113:	74 ca                	je     10df <gets+0x11>
    buf[i++] = c;
    1115:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1117:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    111b:	89 f8                	mov    %edi,%eax
    111d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1120:	5b                   	pop    %ebx
    1121:	5e                   	pop    %esi
    1122:	5f                   	pop    %edi
    1123:	5d                   	pop    %ebp
    1124:	c3                   	ret    

00001125 <stat>:

int
stat(const char *n, struct stat *st)
{
    1125:	55                   	push   %ebp
    1126:	89 e5                	mov    %esp,%ebp
    1128:	56                   	push   %esi
    1129:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    112a:	83 ec 08             	sub    $0x8,%esp
    112d:	6a 00                	push   $0x0
    112f:	ff 75 08             	push   0x8(%ebp)
    1132:	e8 d6 00 00 00       	call   120d <open>
  if(fd < 0)
    1137:	83 c4 10             	add    $0x10,%esp
    113a:	85 c0                	test   %eax,%eax
    113c:	78 24                	js     1162 <stat+0x3d>
    113e:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1140:	83 ec 08             	sub    $0x8,%esp
    1143:	ff 75 0c             	push   0xc(%ebp)
    1146:	50                   	push   %eax
    1147:	e8 d9 00 00 00       	call   1225 <fstat>
    114c:	89 c6                	mov    %eax,%esi
  close(fd);
    114e:	89 1c 24             	mov    %ebx,(%esp)
    1151:	e8 9f 00 00 00       	call   11f5 <close>
  return r;
    1156:	83 c4 10             	add    $0x10,%esp
}
    1159:	89 f0                	mov    %esi,%eax
    115b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    115e:	5b                   	pop    %ebx
    115f:	5e                   	pop    %esi
    1160:	5d                   	pop    %ebp
    1161:	c3                   	ret    
    return -1;
    1162:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1167:	eb f0                	jmp    1159 <stat+0x34>

00001169 <atoi>:

int
atoi(const char *s)
{
    1169:	55                   	push   %ebp
    116a:	89 e5                	mov    %esp,%ebp
    116c:	53                   	push   %ebx
    116d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1170:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1175:	eb 10                	jmp    1187 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1177:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    117a:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    117d:	83 c1 01             	add    $0x1,%ecx
    1180:	0f be c0             	movsbl %al,%eax
    1183:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1187:	0f b6 01             	movzbl (%ecx),%eax
    118a:	8d 58 d0             	lea    -0x30(%eax),%ebx
    118d:	80 fb 09             	cmp    $0x9,%bl
    1190:	76 e5                	jbe    1177 <atoi+0xe>
  return n;
}
    1192:	89 d0                	mov    %edx,%eax
    1194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1197:	c9                   	leave  
    1198:	c3                   	ret    

00001199 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1199:	55                   	push   %ebp
    119a:	89 e5                	mov    %esp,%ebp
    119c:	56                   	push   %esi
    119d:	53                   	push   %ebx
    119e:	8b 75 08             	mov    0x8(%ebp),%esi
    11a1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11a4:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11a7:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11a9:	eb 0d                	jmp    11b8 <memmove+0x1f>
    *dst++ = *src++;
    11ab:	0f b6 01             	movzbl (%ecx),%eax
    11ae:	88 02                	mov    %al,(%edx)
    11b0:	8d 49 01             	lea    0x1(%ecx),%ecx
    11b3:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11b6:	89 d8                	mov    %ebx,%eax
    11b8:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11bb:	85 c0                	test   %eax,%eax
    11bd:	7f ec                	jg     11ab <memmove+0x12>
  return vdst;
}
    11bf:	89 f0                	mov    %esi,%eax
    11c1:	5b                   	pop    %ebx
    11c2:	5e                   	pop    %esi
    11c3:	5d                   	pop    %ebp
    11c4:	c3                   	ret    

000011c5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11c5:	b8 01 00 00 00       	mov    $0x1,%eax
    11ca:	cd 40                	int    $0x40
    11cc:	c3                   	ret    

000011cd <exit>:
SYSCALL(exit)
    11cd:	b8 02 00 00 00       	mov    $0x2,%eax
    11d2:	cd 40                	int    $0x40
    11d4:	c3                   	ret    

000011d5 <wait>:
SYSCALL(wait)
    11d5:	b8 03 00 00 00       	mov    $0x3,%eax
    11da:	cd 40                	int    $0x40
    11dc:	c3                   	ret    

000011dd <pipe>:
SYSCALL(pipe)
    11dd:	b8 04 00 00 00       	mov    $0x4,%eax
    11e2:	cd 40                	int    $0x40
    11e4:	c3                   	ret    

000011e5 <read>:
SYSCALL(read)
    11e5:	b8 05 00 00 00       	mov    $0x5,%eax
    11ea:	cd 40                	int    $0x40
    11ec:	c3                   	ret    

000011ed <write>:
SYSCALL(write)
    11ed:	b8 10 00 00 00       	mov    $0x10,%eax
    11f2:	cd 40                	int    $0x40
    11f4:	c3                   	ret    

000011f5 <close>:
SYSCALL(close)
    11f5:	b8 15 00 00 00       	mov    $0x15,%eax
    11fa:	cd 40                	int    $0x40
    11fc:	c3                   	ret    

000011fd <kill>:
SYSCALL(kill)
    11fd:	b8 06 00 00 00       	mov    $0x6,%eax
    1202:	cd 40                	int    $0x40
    1204:	c3                   	ret    

00001205 <exec>:
SYSCALL(exec)
    1205:	b8 07 00 00 00       	mov    $0x7,%eax
    120a:	cd 40                	int    $0x40
    120c:	c3                   	ret    

0000120d <open>:
SYSCALL(open)
    120d:	b8 0f 00 00 00       	mov    $0xf,%eax
    1212:	cd 40                	int    $0x40
    1214:	c3                   	ret    

00001215 <mknod>:
SYSCALL(mknod)
    1215:	b8 11 00 00 00       	mov    $0x11,%eax
    121a:	cd 40                	int    $0x40
    121c:	c3                   	ret    

0000121d <unlink>:
SYSCALL(unlink)
    121d:	b8 12 00 00 00       	mov    $0x12,%eax
    1222:	cd 40                	int    $0x40
    1224:	c3                   	ret    

00001225 <fstat>:
SYSCALL(fstat)
    1225:	b8 08 00 00 00       	mov    $0x8,%eax
    122a:	cd 40                	int    $0x40
    122c:	c3                   	ret    

0000122d <link>:
SYSCALL(link)
    122d:	b8 13 00 00 00       	mov    $0x13,%eax
    1232:	cd 40                	int    $0x40
    1234:	c3                   	ret    

00001235 <mkdir>:
SYSCALL(mkdir)
    1235:	b8 14 00 00 00       	mov    $0x14,%eax
    123a:	cd 40                	int    $0x40
    123c:	c3                   	ret    

0000123d <chdir>:
SYSCALL(chdir)
    123d:	b8 09 00 00 00       	mov    $0x9,%eax
    1242:	cd 40                	int    $0x40
    1244:	c3                   	ret    

00001245 <dup>:
SYSCALL(dup)
    1245:	b8 0a 00 00 00       	mov    $0xa,%eax
    124a:	cd 40                	int    $0x40
    124c:	c3                   	ret    

0000124d <getpid>:
SYSCALL(getpid)
    124d:	b8 0b 00 00 00       	mov    $0xb,%eax
    1252:	cd 40                	int    $0x40
    1254:	c3                   	ret    

00001255 <sbrk>:
SYSCALL(sbrk)
    1255:	b8 0c 00 00 00       	mov    $0xc,%eax
    125a:	cd 40                	int    $0x40
    125c:	c3                   	ret    

0000125d <sleep>:
SYSCALL(sleep)
    125d:	b8 0d 00 00 00       	mov    $0xd,%eax
    1262:	cd 40                	int    $0x40
    1264:	c3                   	ret    

00001265 <uptime>:
SYSCALL(uptime)
    1265:	b8 0e 00 00 00       	mov    $0xe,%eax
    126a:	cd 40                	int    $0x40
    126c:	c3                   	ret    

0000126d <settickets>:
SYSCALL(settickets)
    126d:	b8 16 00 00 00       	mov    $0x16,%eax
    1272:	cd 40                	int    $0x40
    1274:	c3                   	ret    

00001275 <getpinfo>:
SYSCALL(getpinfo)
    1275:	b8 17 00 00 00       	mov    $0x17,%eax
    127a:	cd 40                	int    $0x40
    127c:	c3                   	ret    

0000127d <mprotect>:
SYSCALL(mprotect)
    127d:	b8 18 00 00 00       	mov    $0x18,%eax
    1282:	cd 40                	int    $0x40
    1284:	c3                   	ret    

00001285 <munprotect>:
    1285:	b8 19 00 00 00       	mov    $0x19,%eax
    128a:	cd 40                	int    $0x40
    128c:	c3                   	ret    

0000128d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    128d:	55                   	push   %ebp
    128e:	89 e5                	mov    %esp,%ebp
    1290:	83 ec 1c             	sub    $0x1c,%esp
    1293:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1296:	6a 01                	push   $0x1
    1298:	8d 55 f4             	lea    -0xc(%ebp),%edx
    129b:	52                   	push   %edx
    129c:	50                   	push   %eax
    129d:	e8 4b ff ff ff       	call   11ed <write>
}
    12a2:	83 c4 10             	add    $0x10,%esp
    12a5:	c9                   	leave  
    12a6:	c3                   	ret    

000012a7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12a7:	55                   	push   %ebp
    12a8:	89 e5                	mov    %esp,%ebp
    12aa:	57                   	push   %edi
    12ab:	56                   	push   %esi
    12ac:	53                   	push   %ebx
    12ad:	83 ec 2c             	sub    $0x2c,%esp
    12b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12b3:	89 d0                	mov    %edx,%eax
    12b5:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12bb:	0f 95 c1             	setne  %cl
    12be:	c1 ea 1f             	shr    $0x1f,%edx
    12c1:	84 d1                	test   %dl,%cl
    12c3:	74 44                	je     1309 <printint+0x62>
    neg = 1;
    x = -xx;
    12c5:	f7 d8                	neg    %eax
    12c7:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12c9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12d0:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12d5:	89 c8                	mov    %ecx,%eax
    12d7:	ba 00 00 00 00       	mov    $0x0,%edx
    12dc:	f7 f6                	div    %esi
    12de:	89 df                	mov    %ebx,%edi
    12e0:	83 c3 01             	add    $0x1,%ebx
    12e3:	0f b6 92 40 16 00 00 	movzbl 0x1640(%edx),%edx
    12ea:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    12ee:	89 ca                	mov    %ecx,%edx
    12f0:	89 c1                	mov    %eax,%ecx
    12f2:	39 d6                	cmp    %edx,%esi
    12f4:	76 df                	jbe    12d5 <printint+0x2e>
  if(neg)
    12f6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    12fa:	74 31                	je     132d <printint+0x86>
    buf[i++] = '-';
    12fc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1301:	8d 5f 02             	lea    0x2(%edi),%ebx
    1304:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1307:	eb 17                	jmp    1320 <printint+0x79>
    x = xx;
    1309:	89 c1                	mov    %eax,%ecx
  neg = 0;
    130b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1312:	eb bc                	jmp    12d0 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1314:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1319:	89 f0                	mov    %esi,%eax
    131b:	e8 6d ff ff ff       	call   128d <putc>
  while(--i >= 0)
    1320:	83 eb 01             	sub    $0x1,%ebx
    1323:	79 ef                	jns    1314 <printint+0x6d>
}
    1325:	83 c4 2c             	add    $0x2c,%esp
    1328:	5b                   	pop    %ebx
    1329:	5e                   	pop    %esi
    132a:	5f                   	pop    %edi
    132b:	5d                   	pop    %ebp
    132c:	c3                   	ret    
    132d:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1330:	eb ee                	jmp    1320 <printint+0x79>

00001332 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1332:	55                   	push   %ebp
    1333:	89 e5                	mov    %esp,%ebp
    1335:	57                   	push   %edi
    1336:	56                   	push   %esi
    1337:	53                   	push   %ebx
    1338:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    133b:	8d 45 10             	lea    0x10(%ebp),%eax
    133e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1341:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1346:	bb 00 00 00 00       	mov    $0x0,%ebx
    134b:	eb 14                	jmp    1361 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    134d:	89 fa                	mov    %edi,%edx
    134f:	8b 45 08             	mov    0x8(%ebp),%eax
    1352:	e8 36 ff ff ff       	call   128d <putc>
    1357:	eb 05                	jmp    135e <printf+0x2c>
      }
    } else if(state == '%'){
    1359:	83 fe 25             	cmp    $0x25,%esi
    135c:	74 25                	je     1383 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    135e:	83 c3 01             	add    $0x1,%ebx
    1361:	8b 45 0c             	mov    0xc(%ebp),%eax
    1364:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1368:	84 c0                	test   %al,%al
    136a:	0f 84 20 01 00 00    	je     1490 <printf+0x15e>
    c = fmt[i] & 0xff;
    1370:	0f be f8             	movsbl %al,%edi
    1373:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1376:	85 f6                	test   %esi,%esi
    1378:	75 df                	jne    1359 <printf+0x27>
      if(c == '%'){
    137a:	83 f8 25             	cmp    $0x25,%eax
    137d:	75 ce                	jne    134d <printf+0x1b>
        state = '%';
    137f:	89 c6                	mov    %eax,%esi
    1381:	eb db                	jmp    135e <printf+0x2c>
      if(c == 'd'){
    1383:	83 f8 25             	cmp    $0x25,%eax
    1386:	0f 84 cf 00 00 00    	je     145b <printf+0x129>
    138c:	0f 8c dd 00 00 00    	jl     146f <printf+0x13d>
    1392:	83 f8 78             	cmp    $0x78,%eax
    1395:	0f 8f d4 00 00 00    	jg     146f <printf+0x13d>
    139b:	83 f8 63             	cmp    $0x63,%eax
    139e:	0f 8c cb 00 00 00    	jl     146f <printf+0x13d>
    13a4:	83 e8 63             	sub    $0x63,%eax
    13a7:	83 f8 15             	cmp    $0x15,%eax
    13aa:	0f 87 bf 00 00 00    	ja     146f <printf+0x13d>
    13b0:	ff 24 85 e8 15 00 00 	jmp    *0x15e8(,%eax,4)
        printint(fd, *ap, 10, 1);
    13b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13ba:	8b 17                	mov    (%edi),%edx
    13bc:	83 ec 0c             	sub    $0xc,%esp
    13bf:	6a 01                	push   $0x1
    13c1:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13c6:	8b 45 08             	mov    0x8(%ebp),%eax
    13c9:	e8 d9 fe ff ff       	call   12a7 <printint>
        ap++;
    13ce:	83 c7 04             	add    $0x4,%edi
    13d1:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13d4:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13d7:	be 00 00 00 00       	mov    $0x0,%esi
    13dc:	eb 80                	jmp    135e <printf+0x2c>
        printint(fd, *ap, 16, 0);
    13de:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13e1:	8b 17                	mov    (%edi),%edx
    13e3:	83 ec 0c             	sub    $0xc,%esp
    13e6:	6a 00                	push   $0x0
    13e8:	b9 10 00 00 00       	mov    $0x10,%ecx
    13ed:	8b 45 08             	mov    0x8(%ebp),%eax
    13f0:	e8 b2 fe ff ff       	call   12a7 <printint>
        ap++;
    13f5:	83 c7 04             	add    $0x4,%edi
    13f8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13fb:	83 c4 10             	add    $0x10,%esp
      state = 0;
    13fe:	be 00 00 00 00       	mov    $0x0,%esi
    1403:	e9 56 ff ff ff       	jmp    135e <printf+0x2c>
        s = (char*)*ap;
    1408:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    140b:	8b 30                	mov    (%eax),%esi
        ap++;
    140d:	83 c0 04             	add    $0x4,%eax
    1410:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1413:	85 f6                	test   %esi,%esi
    1415:	75 15                	jne    142c <printf+0xfa>
          s = "(null)";
    1417:	be e0 15 00 00       	mov    $0x15e0,%esi
    141c:	eb 0e                	jmp    142c <printf+0xfa>
          putc(fd, *s);
    141e:	0f be d2             	movsbl %dl,%edx
    1421:	8b 45 08             	mov    0x8(%ebp),%eax
    1424:	e8 64 fe ff ff       	call   128d <putc>
          s++;
    1429:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    142c:	0f b6 16             	movzbl (%esi),%edx
    142f:	84 d2                	test   %dl,%dl
    1431:	75 eb                	jne    141e <printf+0xec>
      state = 0;
    1433:	be 00 00 00 00       	mov    $0x0,%esi
    1438:	e9 21 ff ff ff       	jmp    135e <printf+0x2c>
        putc(fd, *ap);
    143d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1440:	0f be 17             	movsbl (%edi),%edx
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	e8 42 fe ff ff       	call   128d <putc>
        ap++;
    144b:	83 c7 04             	add    $0x4,%edi
    144e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1451:	be 00 00 00 00       	mov    $0x0,%esi
    1456:	e9 03 ff ff ff       	jmp    135e <printf+0x2c>
        putc(fd, c);
    145b:	89 fa                	mov    %edi,%edx
    145d:	8b 45 08             	mov    0x8(%ebp),%eax
    1460:	e8 28 fe ff ff       	call   128d <putc>
      state = 0;
    1465:	be 00 00 00 00       	mov    $0x0,%esi
    146a:	e9 ef fe ff ff       	jmp    135e <printf+0x2c>
        putc(fd, '%');
    146f:	ba 25 00 00 00       	mov    $0x25,%edx
    1474:	8b 45 08             	mov    0x8(%ebp),%eax
    1477:	e8 11 fe ff ff       	call   128d <putc>
        putc(fd, c);
    147c:	89 fa                	mov    %edi,%edx
    147e:	8b 45 08             	mov    0x8(%ebp),%eax
    1481:	e8 07 fe ff ff       	call   128d <putc>
      state = 0;
    1486:	be 00 00 00 00       	mov    $0x0,%esi
    148b:	e9 ce fe ff ff       	jmp    135e <printf+0x2c>
    }
  }
}
    1490:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1493:	5b                   	pop    %ebx
    1494:	5e                   	pop    %esi
    1495:	5f                   	pop    %edi
    1496:	5d                   	pop    %ebp
    1497:	c3                   	ret    

00001498 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1498:	55                   	push   %ebp
    1499:	89 e5                	mov    %esp,%ebp
    149b:	57                   	push   %edi
    149c:	56                   	push   %esi
    149d:	53                   	push   %ebx
    149e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14a1:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14a4:	a1 e0 18 00 00       	mov    0x18e0,%eax
    14a9:	eb 02                	jmp    14ad <free+0x15>
    14ab:	89 d0                	mov    %edx,%eax
    14ad:	39 c8                	cmp    %ecx,%eax
    14af:	73 04                	jae    14b5 <free+0x1d>
    14b1:	39 08                	cmp    %ecx,(%eax)
    14b3:	77 12                	ja     14c7 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14b5:	8b 10                	mov    (%eax),%edx
    14b7:	39 c2                	cmp    %eax,%edx
    14b9:	77 f0                	ja     14ab <free+0x13>
    14bb:	39 c8                	cmp    %ecx,%eax
    14bd:	72 08                	jb     14c7 <free+0x2f>
    14bf:	39 ca                	cmp    %ecx,%edx
    14c1:	77 04                	ja     14c7 <free+0x2f>
    14c3:	89 d0                	mov    %edx,%eax
    14c5:	eb e6                	jmp    14ad <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14c7:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14ca:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14cd:	8b 10                	mov    (%eax),%edx
    14cf:	39 d7                	cmp    %edx,%edi
    14d1:	74 19                	je     14ec <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14d3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14d6:	8b 50 04             	mov    0x4(%eax),%edx
    14d9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14dc:	39 ce                	cmp    %ecx,%esi
    14de:	74 1b                	je     14fb <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14e0:	89 08                	mov    %ecx,(%eax)
  freep = p;
    14e2:	a3 e0 18 00 00       	mov    %eax,0x18e0
}
    14e7:	5b                   	pop    %ebx
    14e8:	5e                   	pop    %esi
    14e9:	5f                   	pop    %edi
    14ea:	5d                   	pop    %ebp
    14eb:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    14ec:	03 72 04             	add    0x4(%edx),%esi
    14ef:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    14f2:	8b 10                	mov    (%eax),%edx
    14f4:	8b 12                	mov    (%edx),%edx
    14f6:	89 53 f8             	mov    %edx,-0x8(%ebx)
    14f9:	eb db                	jmp    14d6 <free+0x3e>
    p->s.size += bp->s.size;
    14fb:	03 53 fc             	add    -0x4(%ebx),%edx
    14fe:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1501:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1504:	89 10                	mov    %edx,(%eax)
    1506:	eb da                	jmp    14e2 <free+0x4a>

00001508 <morecore>:

static Header*
morecore(uint nu)
{
    1508:	55                   	push   %ebp
    1509:	89 e5                	mov    %esp,%ebp
    150b:	53                   	push   %ebx
    150c:	83 ec 04             	sub    $0x4,%esp
    150f:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1511:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1516:	77 05                	ja     151d <morecore+0x15>
    nu = 4096;
    1518:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    151d:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1524:	83 ec 0c             	sub    $0xc,%esp
    1527:	50                   	push   %eax
    1528:	e8 28 fd ff ff       	call   1255 <sbrk>
  if(p == (char*)-1)
    152d:	83 c4 10             	add    $0x10,%esp
    1530:	83 f8 ff             	cmp    $0xffffffff,%eax
    1533:	74 1c                	je     1551 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1535:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1538:	83 c0 08             	add    $0x8,%eax
    153b:	83 ec 0c             	sub    $0xc,%esp
    153e:	50                   	push   %eax
    153f:	e8 54 ff ff ff       	call   1498 <free>
  return freep;
    1544:	a1 e0 18 00 00       	mov    0x18e0,%eax
    1549:	83 c4 10             	add    $0x10,%esp
}
    154c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    154f:	c9                   	leave  
    1550:	c3                   	ret    
    return 0;
    1551:	b8 00 00 00 00       	mov    $0x0,%eax
    1556:	eb f4                	jmp    154c <morecore+0x44>

00001558 <malloc>:

void*
malloc(uint nbytes)
{
    1558:	55                   	push   %ebp
    1559:	89 e5                	mov    %esp,%ebp
    155b:	53                   	push   %ebx
    155c:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    155f:	8b 45 08             	mov    0x8(%ebp),%eax
    1562:	8d 58 07             	lea    0x7(%eax),%ebx
    1565:	c1 eb 03             	shr    $0x3,%ebx
    1568:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    156b:	8b 0d e0 18 00 00    	mov    0x18e0,%ecx
    1571:	85 c9                	test   %ecx,%ecx
    1573:	74 04                	je     1579 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1575:	8b 01                	mov    (%ecx),%eax
    1577:	eb 4a                	jmp    15c3 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1579:	c7 05 e0 18 00 00 e4 	movl   $0x18e4,0x18e0
    1580:	18 00 00 
    1583:	c7 05 e4 18 00 00 e4 	movl   $0x18e4,0x18e4
    158a:	18 00 00 
    base.s.size = 0;
    158d:	c7 05 e8 18 00 00 00 	movl   $0x0,0x18e8
    1594:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1597:	b9 e4 18 00 00       	mov    $0x18e4,%ecx
    159c:	eb d7                	jmp    1575 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    159e:	74 19                	je     15b9 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15a0:	29 da                	sub    %ebx,%edx
    15a2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15a5:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15a8:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15ab:	89 0d e0 18 00 00    	mov    %ecx,0x18e0
      return (void*)(p + 1);
    15b1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15b7:	c9                   	leave  
    15b8:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15b9:	8b 10                	mov    (%eax),%edx
    15bb:	89 11                	mov    %edx,(%ecx)
    15bd:	eb ec                	jmp    15ab <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15bf:	89 c1                	mov    %eax,%ecx
    15c1:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15c3:	8b 50 04             	mov    0x4(%eax),%edx
    15c6:	39 da                	cmp    %ebx,%edx
    15c8:	73 d4                	jae    159e <malloc+0x46>
    if(p == freep)
    15ca:	39 05 e0 18 00 00    	cmp    %eax,0x18e0
    15d0:	75 ed                	jne    15bf <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15d2:	89 d8                	mov    %ebx,%eax
    15d4:	e8 2f ff ff ff       	call   1508 <morecore>
    15d9:	85 c0                	test   %eax,%eax
    15db:	75 e2                	jne    15bf <malloc+0x67>
    15dd:	eb d5                	jmp    15b4 <malloc+0x5c>
