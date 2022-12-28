
_test_14:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:


#define PGSIZE 4096


int main(void) {
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
    const uint PAGES_NUM = 1;
    
    char *ptr = sbrk(PAGES_NUM * PGSIZE);
    100f:	83 ec 0c             	sub    $0xc,%esp
    1012:	68 00 10 00 00       	push   $0x1000
    1017:	e8 64 02 00 00       	call   1280 <sbrk>
    101c:	89 c3                	mov    %eax,%ebx
    printf(1, "XV6_TEST_OUTPUT %d\n", mprotect(ptr, -10));
    101e:	83 c4 08             	add    $0x8,%esp
    1021:	6a f6                	push   $0xfffffff6
    1023:	50                   	push   %eax
    1024:	e8 7f 02 00 00       	call   12a8 <mprotect>
    1029:	83 c4 0c             	add    $0xc,%esp
    102c:	50                   	push   %eax
    102d:	68 0c 16 00 00       	push   $0x160c
    1032:	6a 01                	push   $0x1
    1034:	e8 24 03 00 00       	call   135d <printf>
    printf(1, "XV6_TEST_OUTPUT %d\n", mprotect(ptr, PAGES_NUM + 10));
    1039:	83 c4 08             	add    $0x8,%esp
    103c:	6a 0b                	push   $0xb
    103e:	53                   	push   %ebx
    103f:	e8 64 02 00 00       	call   12a8 <mprotect>
    1044:	83 c4 0c             	add    $0xc,%esp
    1047:	50                   	push   %eax
    1048:	68 0c 16 00 00       	push   $0x160c
    104d:	6a 01                	push   $0x1
    104f:	e8 09 03 00 00       	call   135d <printf>
    
    exit();
    1054:	e8 9f 01 00 00       	call   11f8 <exit>

00001059 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1059:	55                   	push   %ebp
    105a:	89 e5                	mov    %esp,%ebp
    105c:	56                   	push   %esi
    105d:	53                   	push   %ebx
    105e:	8b 75 08             	mov    0x8(%ebp),%esi
    1061:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1064:	89 f0                	mov    %esi,%eax
    1066:	89 d1                	mov    %edx,%ecx
    1068:	83 c2 01             	add    $0x1,%edx
    106b:	89 c3                	mov    %eax,%ebx
    106d:	83 c0 01             	add    $0x1,%eax
    1070:	0f b6 09             	movzbl (%ecx),%ecx
    1073:	88 0b                	mov    %cl,(%ebx)
    1075:	84 c9                	test   %cl,%cl
    1077:	75 ed                	jne    1066 <strcpy+0xd>
    ;
  return os;
}
    1079:	89 f0                	mov    %esi,%eax
    107b:	5b                   	pop    %ebx
    107c:	5e                   	pop    %esi
    107d:	5d                   	pop    %ebp
    107e:	c3                   	ret    

0000107f <strcmp>:

int
strcmp(const char *p, const char *q)
{
    107f:	55                   	push   %ebp
    1080:	89 e5                	mov    %esp,%ebp
    1082:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1085:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1088:	eb 06                	jmp    1090 <strcmp+0x11>
    p++, q++;
    108a:	83 c1 01             	add    $0x1,%ecx
    108d:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1090:	0f b6 01             	movzbl (%ecx),%eax
    1093:	84 c0                	test   %al,%al
    1095:	74 04                	je     109b <strcmp+0x1c>
    1097:	3a 02                	cmp    (%edx),%al
    1099:	74 ef                	je     108a <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    109b:	0f b6 c0             	movzbl %al,%eax
    109e:	0f b6 12             	movzbl (%edx),%edx
    10a1:	29 d0                	sub    %edx,%eax
}
    10a3:	5d                   	pop    %ebp
    10a4:	c3                   	ret    

000010a5 <strlen>:

uint
strlen(const char *s)
{
    10a5:	55                   	push   %ebp
    10a6:	89 e5                	mov    %esp,%ebp
    10a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10ab:	b8 00 00 00 00       	mov    $0x0,%eax
    10b0:	eb 03                	jmp    10b5 <strlen+0x10>
    10b2:	83 c0 01             	add    $0x1,%eax
    10b5:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10b9:	75 f7                	jne    10b2 <strlen+0xd>
    ;
  return n;
}
    10bb:	5d                   	pop    %ebp
    10bc:	c3                   	ret    

000010bd <memset>:

void*
memset(void *dst, int c, uint n)
{
    10bd:	55                   	push   %ebp
    10be:	89 e5                	mov    %esp,%ebp
    10c0:	57                   	push   %edi
    10c1:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10c4:	89 d7                	mov    %edx,%edi
    10c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cc:	fc                   	cld    
    10cd:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10cf:	89 d0                	mov    %edx,%eax
    10d1:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10d4:	c9                   	leave  
    10d5:	c3                   	ret    

000010d6 <strchr>:

char*
strchr(const char *s, char c)
{
    10d6:	55                   	push   %ebp
    10d7:	89 e5                	mov    %esp,%ebp
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
    10dc:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10e0:	eb 03                	jmp    10e5 <strchr+0xf>
    10e2:	83 c0 01             	add    $0x1,%eax
    10e5:	0f b6 10             	movzbl (%eax),%edx
    10e8:	84 d2                	test   %dl,%dl
    10ea:	74 06                	je     10f2 <strchr+0x1c>
    if(*s == c)
    10ec:	38 ca                	cmp    %cl,%dl
    10ee:	75 f2                	jne    10e2 <strchr+0xc>
    10f0:	eb 05                	jmp    10f7 <strchr+0x21>
      return (char*)s;
  return 0;
    10f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10f7:	5d                   	pop    %ebp
    10f8:	c3                   	ret    

000010f9 <gets>:

char*
gets(char *buf, int max)
{
    10f9:	55                   	push   %ebp
    10fa:	89 e5                	mov    %esp,%ebp
    10fc:	57                   	push   %edi
    10fd:	56                   	push   %esi
    10fe:	53                   	push   %ebx
    10ff:	83 ec 1c             	sub    $0x1c,%esp
    1102:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1105:	bb 00 00 00 00       	mov    $0x0,%ebx
    110a:	89 de                	mov    %ebx,%esi
    110c:	83 c3 01             	add    $0x1,%ebx
    110f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1112:	7d 2e                	jge    1142 <gets+0x49>
    cc = read(0, &c, 1);
    1114:	83 ec 04             	sub    $0x4,%esp
    1117:	6a 01                	push   $0x1
    1119:	8d 45 e7             	lea    -0x19(%ebp),%eax
    111c:	50                   	push   %eax
    111d:	6a 00                	push   $0x0
    111f:	e8 ec 00 00 00       	call   1210 <read>
    if(cc < 1)
    1124:	83 c4 10             	add    $0x10,%esp
    1127:	85 c0                	test   %eax,%eax
    1129:	7e 17                	jle    1142 <gets+0x49>
      break;
    buf[i++] = c;
    112b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    112f:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1132:	3c 0a                	cmp    $0xa,%al
    1134:	0f 94 c2             	sete   %dl
    1137:	3c 0d                	cmp    $0xd,%al
    1139:	0f 94 c0             	sete   %al
    113c:	08 c2                	or     %al,%dl
    113e:	74 ca                	je     110a <gets+0x11>
    buf[i++] = c;
    1140:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1142:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1146:	89 f8                	mov    %edi,%eax
    1148:	8d 65 f4             	lea    -0xc(%ebp),%esp
    114b:	5b                   	pop    %ebx
    114c:	5e                   	pop    %esi
    114d:	5f                   	pop    %edi
    114e:	5d                   	pop    %ebp
    114f:	c3                   	ret    

00001150 <stat>:

int
stat(const char *n, struct stat *st)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	56                   	push   %esi
    1154:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1155:	83 ec 08             	sub    $0x8,%esp
    1158:	6a 00                	push   $0x0
    115a:	ff 75 08             	push   0x8(%ebp)
    115d:	e8 d6 00 00 00       	call   1238 <open>
  if(fd < 0)
    1162:	83 c4 10             	add    $0x10,%esp
    1165:	85 c0                	test   %eax,%eax
    1167:	78 24                	js     118d <stat+0x3d>
    1169:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    116b:	83 ec 08             	sub    $0x8,%esp
    116e:	ff 75 0c             	push   0xc(%ebp)
    1171:	50                   	push   %eax
    1172:	e8 d9 00 00 00       	call   1250 <fstat>
    1177:	89 c6                	mov    %eax,%esi
  close(fd);
    1179:	89 1c 24             	mov    %ebx,(%esp)
    117c:	e8 9f 00 00 00       	call   1220 <close>
  return r;
    1181:	83 c4 10             	add    $0x10,%esp
}
    1184:	89 f0                	mov    %esi,%eax
    1186:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1189:	5b                   	pop    %ebx
    118a:	5e                   	pop    %esi
    118b:	5d                   	pop    %ebp
    118c:	c3                   	ret    
    return -1;
    118d:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1192:	eb f0                	jmp    1184 <stat+0x34>

00001194 <atoi>:

int
atoi(const char *s)
{
    1194:	55                   	push   %ebp
    1195:	89 e5                	mov    %esp,%ebp
    1197:	53                   	push   %ebx
    1198:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    119b:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11a0:	eb 10                	jmp    11b2 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11a2:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11a5:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11a8:	83 c1 01             	add    $0x1,%ecx
    11ab:	0f be c0             	movsbl %al,%eax
    11ae:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11b2:	0f b6 01             	movzbl (%ecx),%eax
    11b5:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11b8:	80 fb 09             	cmp    $0x9,%bl
    11bb:	76 e5                	jbe    11a2 <atoi+0xe>
  return n;
}
    11bd:	89 d0                	mov    %edx,%eax
    11bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11c2:	c9                   	leave  
    11c3:	c3                   	ret    

000011c4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11c4:	55                   	push   %ebp
    11c5:	89 e5                	mov    %esp,%ebp
    11c7:	56                   	push   %esi
    11c8:	53                   	push   %ebx
    11c9:	8b 75 08             	mov    0x8(%ebp),%esi
    11cc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11cf:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11d2:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11d4:	eb 0d                	jmp    11e3 <memmove+0x1f>
    *dst++ = *src++;
    11d6:	0f b6 01             	movzbl (%ecx),%eax
    11d9:	88 02                	mov    %al,(%edx)
    11db:	8d 49 01             	lea    0x1(%ecx),%ecx
    11de:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11e1:	89 d8                	mov    %ebx,%eax
    11e3:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11e6:	85 c0                	test   %eax,%eax
    11e8:	7f ec                	jg     11d6 <memmove+0x12>
  return vdst;
}
    11ea:	89 f0                	mov    %esi,%eax
    11ec:	5b                   	pop    %ebx
    11ed:	5e                   	pop    %esi
    11ee:	5d                   	pop    %ebp
    11ef:	c3                   	ret    

000011f0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11f0:	b8 01 00 00 00       	mov    $0x1,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <exit>:
SYSCALL(exit)
    11f8:	b8 02 00 00 00       	mov    $0x2,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <wait>:
SYSCALL(wait)
    1200:	b8 03 00 00 00       	mov    $0x3,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <pipe>:
SYSCALL(pipe)
    1208:	b8 04 00 00 00       	mov    $0x4,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <read>:
SYSCALL(read)
    1210:	b8 05 00 00 00       	mov    $0x5,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <write>:
SYSCALL(write)
    1218:	b8 10 00 00 00       	mov    $0x10,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <close>:
SYSCALL(close)
    1220:	b8 15 00 00 00       	mov    $0x15,%eax
    1225:	cd 40                	int    $0x40
    1227:	c3                   	ret    

00001228 <kill>:
SYSCALL(kill)
    1228:	b8 06 00 00 00       	mov    $0x6,%eax
    122d:	cd 40                	int    $0x40
    122f:	c3                   	ret    

00001230 <exec>:
SYSCALL(exec)
    1230:	b8 07 00 00 00       	mov    $0x7,%eax
    1235:	cd 40                	int    $0x40
    1237:	c3                   	ret    

00001238 <open>:
SYSCALL(open)
    1238:	b8 0f 00 00 00       	mov    $0xf,%eax
    123d:	cd 40                	int    $0x40
    123f:	c3                   	ret    

00001240 <mknod>:
SYSCALL(mknod)
    1240:	b8 11 00 00 00       	mov    $0x11,%eax
    1245:	cd 40                	int    $0x40
    1247:	c3                   	ret    

00001248 <unlink>:
SYSCALL(unlink)
    1248:	b8 12 00 00 00       	mov    $0x12,%eax
    124d:	cd 40                	int    $0x40
    124f:	c3                   	ret    

00001250 <fstat>:
SYSCALL(fstat)
    1250:	b8 08 00 00 00       	mov    $0x8,%eax
    1255:	cd 40                	int    $0x40
    1257:	c3                   	ret    

00001258 <link>:
SYSCALL(link)
    1258:	b8 13 00 00 00       	mov    $0x13,%eax
    125d:	cd 40                	int    $0x40
    125f:	c3                   	ret    

00001260 <mkdir>:
SYSCALL(mkdir)
    1260:	b8 14 00 00 00       	mov    $0x14,%eax
    1265:	cd 40                	int    $0x40
    1267:	c3                   	ret    

00001268 <chdir>:
SYSCALL(chdir)
    1268:	b8 09 00 00 00       	mov    $0x9,%eax
    126d:	cd 40                	int    $0x40
    126f:	c3                   	ret    

00001270 <dup>:
SYSCALL(dup)
    1270:	b8 0a 00 00 00       	mov    $0xa,%eax
    1275:	cd 40                	int    $0x40
    1277:	c3                   	ret    

00001278 <getpid>:
SYSCALL(getpid)
    1278:	b8 0b 00 00 00       	mov    $0xb,%eax
    127d:	cd 40                	int    $0x40
    127f:	c3                   	ret    

00001280 <sbrk>:
SYSCALL(sbrk)
    1280:	b8 0c 00 00 00       	mov    $0xc,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <sleep>:
SYSCALL(sleep)
    1288:	b8 0d 00 00 00       	mov    $0xd,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <uptime>:
SYSCALL(uptime)
    1290:	b8 0e 00 00 00       	mov    $0xe,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <settickets>:
SYSCALL(settickets)
    1298:	b8 16 00 00 00       	mov    $0x16,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <getpinfo>:
SYSCALL(getpinfo)
    12a0:	b8 17 00 00 00       	mov    $0x17,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <mprotect>:
SYSCALL(mprotect)
    12a8:	b8 18 00 00 00       	mov    $0x18,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <munprotect>:
    12b0:	b8 19 00 00 00       	mov    $0x19,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12b8:	55                   	push   %ebp
    12b9:	89 e5                	mov    %esp,%ebp
    12bb:	83 ec 1c             	sub    $0x1c,%esp
    12be:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12c1:	6a 01                	push   $0x1
    12c3:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12c6:	52                   	push   %edx
    12c7:	50                   	push   %eax
    12c8:	e8 4b ff ff ff       	call   1218 <write>
}
    12cd:	83 c4 10             	add    $0x10,%esp
    12d0:	c9                   	leave  
    12d1:	c3                   	ret    

000012d2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12d2:	55                   	push   %ebp
    12d3:	89 e5                	mov    %esp,%ebp
    12d5:	57                   	push   %edi
    12d6:	56                   	push   %esi
    12d7:	53                   	push   %ebx
    12d8:	83 ec 2c             	sub    $0x2c,%esp
    12db:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12de:	89 d0                	mov    %edx,%eax
    12e0:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12e6:	0f 95 c1             	setne  %cl
    12e9:	c1 ea 1f             	shr    $0x1f,%edx
    12ec:	84 d1                	test   %dl,%cl
    12ee:	74 44                	je     1334 <printint+0x62>
    neg = 1;
    x = -xx;
    12f0:	f7 d8                	neg    %eax
    12f2:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12f4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12fb:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1300:	89 c8                	mov    %ecx,%eax
    1302:	ba 00 00 00 00       	mov    $0x0,%edx
    1307:	f7 f6                	div    %esi
    1309:	89 df                	mov    %ebx,%edi
    130b:	83 c3 01             	add    $0x1,%ebx
    130e:	0f b6 92 80 16 00 00 	movzbl 0x1680(%edx),%edx
    1315:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1319:	89 ca                	mov    %ecx,%edx
    131b:	89 c1                	mov    %eax,%ecx
    131d:	39 d6                	cmp    %edx,%esi
    131f:	76 df                	jbe    1300 <printint+0x2e>
  if(neg)
    1321:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1325:	74 31                	je     1358 <printint+0x86>
    buf[i++] = '-';
    1327:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    132c:	8d 5f 02             	lea    0x2(%edi),%ebx
    132f:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1332:	eb 17                	jmp    134b <printint+0x79>
    x = xx;
    1334:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1336:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    133d:	eb bc                	jmp    12fb <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    133f:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1344:	89 f0                	mov    %esi,%eax
    1346:	e8 6d ff ff ff       	call   12b8 <putc>
  while(--i >= 0)
    134b:	83 eb 01             	sub    $0x1,%ebx
    134e:	79 ef                	jns    133f <printint+0x6d>
}
    1350:	83 c4 2c             	add    $0x2c,%esp
    1353:	5b                   	pop    %ebx
    1354:	5e                   	pop    %esi
    1355:	5f                   	pop    %edi
    1356:	5d                   	pop    %ebp
    1357:	c3                   	ret    
    1358:	8b 75 d0             	mov    -0x30(%ebp),%esi
    135b:	eb ee                	jmp    134b <printint+0x79>

0000135d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    135d:	55                   	push   %ebp
    135e:	89 e5                	mov    %esp,%ebp
    1360:	57                   	push   %edi
    1361:	56                   	push   %esi
    1362:	53                   	push   %ebx
    1363:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1366:	8d 45 10             	lea    0x10(%ebp),%eax
    1369:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    136c:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1371:	bb 00 00 00 00       	mov    $0x0,%ebx
    1376:	eb 14                	jmp    138c <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1378:	89 fa                	mov    %edi,%edx
    137a:	8b 45 08             	mov    0x8(%ebp),%eax
    137d:	e8 36 ff ff ff       	call   12b8 <putc>
    1382:	eb 05                	jmp    1389 <printf+0x2c>
      }
    } else if(state == '%'){
    1384:	83 fe 25             	cmp    $0x25,%esi
    1387:	74 25                	je     13ae <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1389:	83 c3 01             	add    $0x1,%ebx
    138c:	8b 45 0c             	mov    0xc(%ebp),%eax
    138f:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1393:	84 c0                	test   %al,%al
    1395:	0f 84 20 01 00 00    	je     14bb <printf+0x15e>
    c = fmt[i] & 0xff;
    139b:	0f be f8             	movsbl %al,%edi
    139e:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13a1:	85 f6                	test   %esi,%esi
    13a3:	75 df                	jne    1384 <printf+0x27>
      if(c == '%'){
    13a5:	83 f8 25             	cmp    $0x25,%eax
    13a8:	75 ce                	jne    1378 <printf+0x1b>
        state = '%';
    13aa:	89 c6                	mov    %eax,%esi
    13ac:	eb db                	jmp    1389 <printf+0x2c>
      if(c == 'd'){
    13ae:	83 f8 25             	cmp    $0x25,%eax
    13b1:	0f 84 cf 00 00 00    	je     1486 <printf+0x129>
    13b7:	0f 8c dd 00 00 00    	jl     149a <printf+0x13d>
    13bd:	83 f8 78             	cmp    $0x78,%eax
    13c0:	0f 8f d4 00 00 00    	jg     149a <printf+0x13d>
    13c6:	83 f8 63             	cmp    $0x63,%eax
    13c9:	0f 8c cb 00 00 00    	jl     149a <printf+0x13d>
    13cf:	83 e8 63             	sub    $0x63,%eax
    13d2:	83 f8 15             	cmp    $0x15,%eax
    13d5:	0f 87 bf 00 00 00    	ja     149a <printf+0x13d>
    13db:	ff 24 85 28 16 00 00 	jmp    *0x1628(,%eax,4)
        printint(fd, *ap, 10, 1);
    13e2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13e5:	8b 17                	mov    (%edi),%edx
    13e7:	83 ec 0c             	sub    $0xc,%esp
    13ea:	6a 01                	push   $0x1
    13ec:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13f1:	8b 45 08             	mov    0x8(%ebp),%eax
    13f4:	e8 d9 fe ff ff       	call   12d2 <printint>
        ap++;
    13f9:	83 c7 04             	add    $0x4,%edi
    13fc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13ff:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1402:	be 00 00 00 00       	mov    $0x0,%esi
    1407:	eb 80                	jmp    1389 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1409:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    140c:	8b 17                	mov    (%edi),%edx
    140e:	83 ec 0c             	sub    $0xc,%esp
    1411:	6a 00                	push   $0x0
    1413:	b9 10 00 00 00       	mov    $0x10,%ecx
    1418:	8b 45 08             	mov    0x8(%ebp),%eax
    141b:	e8 b2 fe ff ff       	call   12d2 <printint>
        ap++;
    1420:	83 c7 04             	add    $0x4,%edi
    1423:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1426:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1429:	be 00 00 00 00       	mov    $0x0,%esi
    142e:	e9 56 ff ff ff       	jmp    1389 <printf+0x2c>
        s = (char*)*ap;
    1433:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1436:	8b 30                	mov    (%eax),%esi
        ap++;
    1438:	83 c0 04             	add    $0x4,%eax
    143b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    143e:	85 f6                	test   %esi,%esi
    1440:	75 15                	jne    1457 <printf+0xfa>
          s = "(null)";
    1442:	be 20 16 00 00       	mov    $0x1620,%esi
    1447:	eb 0e                	jmp    1457 <printf+0xfa>
          putc(fd, *s);
    1449:	0f be d2             	movsbl %dl,%edx
    144c:	8b 45 08             	mov    0x8(%ebp),%eax
    144f:	e8 64 fe ff ff       	call   12b8 <putc>
          s++;
    1454:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1457:	0f b6 16             	movzbl (%esi),%edx
    145a:	84 d2                	test   %dl,%dl
    145c:	75 eb                	jne    1449 <printf+0xec>
      state = 0;
    145e:	be 00 00 00 00       	mov    $0x0,%esi
    1463:	e9 21 ff ff ff       	jmp    1389 <printf+0x2c>
        putc(fd, *ap);
    1468:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    146b:	0f be 17             	movsbl (%edi),%edx
    146e:	8b 45 08             	mov    0x8(%ebp),%eax
    1471:	e8 42 fe ff ff       	call   12b8 <putc>
        ap++;
    1476:	83 c7 04             	add    $0x4,%edi
    1479:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    147c:	be 00 00 00 00       	mov    $0x0,%esi
    1481:	e9 03 ff ff ff       	jmp    1389 <printf+0x2c>
        putc(fd, c);
    1486:	89 fa                	mov    %edi,%edx
    1488:	8b 45 08             	mov    0x8(%ebp),%eax
    148b:	e8 28 fe ff ff       	call   12b8 <putc>
      state = 0;
    1490:	be 00 00 00 00       	mov    $0x0,%esi
    1495:	e9 ef fe ff ff       	jmp    1389 <printf+0x2c>
        putc(fd, '%');
    149a:	ba 25 00 00 00       	mov    $0x25,%edx
    149f:	8b 45 08             	mov    0x8(%ebp),%eax
    14a2:	e8 11 fe ff ff       	call   12b8 <putc>
        putc(fd, c);
    14a7:	89 fa                	mov    %edi,%edx
    14a9:	8b 45 08             	mov    0x8(%ebp),%eax
    14ac:	e8 07 fe ff ff       	call   12b8 <putc>
      state = 0;
    14b1:	be 00 00 00 00       	mov    $0x0,%esi
    14b6:	e9 ce fe ff ff       	jmp    1389 <printf+0x2c>
    }
  }
}
    14bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14be:	5b                   	pop    %ebx
    14bf:	5e                   	pop    %esi
    14c0:	5f                   	pop    %edi
    14c1:	5d                   	pop    %ebp
    14c2:	c3                   	ret    

000014c3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c3:	55                   	push   %ebp
    14c4:	89 e5                	mov    %esp,%ebp
    14c6:	57                   	push   %edi
    14c7:	56                   	push   %esi
    14c8:	53                   	push   %ebx
    14c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14cc:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14cf:	a1 24 19 00 00       	mov    0x1924,%eax
    14d4:	eb 02                	jmp    14d8 <free+0x15>
    14d6:	89 d0                	mov    %edx,%eax
    14d8:	39 c8                	cmp    %ecx,%eax
    14da:	73 04                	jae    14e0 <free+0x1d>
    14dc:	39 08                	cmp    %ecx,(%eax)
    14de:	77 12                	ja     14f2 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14e0:	8b 10                	mov    (%eax),%edx
    14e2:	39 c2                	cmp    %eax,%edx
    14e4:	77 f0                	ja     14d6 <free+0x13>
    14e6:	39 c8                	cmp    %ecx,%eax
    14e8:	72 08                	jb     14f2 <free+0x2f>
    14ea:	39 ca                	cmp    %ecx,%edx
    14ec:	77 04                	ja     14f2 <free+0x2f>
    14ee:	89 d0                	mov    %edx,%eax
    14f0:	eb e6                	jmp    14d8 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14f2:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14f5:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14f8:	8b 10                	mov    (%eax),%edx
    14fa:	39 d7                	cmp    %edx,%edi
    14fc:	74 19                	je     1517 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14fe:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1501:	8b 50 04             	mov    0x4(%eax),%edx
    1504:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1507:	39 ce                	cmp    %ecx,%esi
    1509:	74 1b                	je     1526 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    150b:	89 08                	mov    %ecx,(%eax)
  freep = p;
    150d:	a3 24 19 00 00       	mov    %eax,0x1924
}
    1512:	5b                   	pop    %ebx
    1513:	5e                   	pop    %esi
    1514:	5f                   	pop    %edi
    1515:	5d                   	pop    %ebp
    1516:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1517:	03 72 04             	add    0x4(%edx),%esi
    151a:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    151d:	8b 10                	mov    (%eax),%edx
    151f:	8b 12                	mov    (%edx),%edx
    1521:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1524:	eb db                	jmp    1501 <free+0x3e>
    p->s.size += bp->s.size;
    1526:	03 53 fc             	add    -0x4(%ebx),%edx
    1529:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    152c:	8b 53 f8             	mov    -0x8(%ebx),%edx
    152f:	89 10                	mov    %edx,(%eax)
    1531:	eb da                	jmp    150d <free+0x4a>

00001533 <morecore>:

static Header*
morecore(uint nu)
{
    1533:	55                   	push   %ebp
    1534:	89 e5                	mov    %esp,%ebp
    1536:	53                   	push   %ebx
    1537:	83 ec 04             	sub    $0x4,%esp
    153a:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    153c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1541:	77 05                	ja     1548 <morecore+0x15>
    nu = 4096;
    1543:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1548:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    154f:	83 ec 0c             	sub    $0xc,%esp
    1552:	50                   	push   %eax
    1553:	e8 28 fd ff ff       	call   1280 <sbrk>
  if(p == (char*)-1)
    1558:	83 c4 10             	add    $0x10,%esp
    155b:	83 f8 ff             	cmp    $0xffffffff,%eax
    155e:	74 1c                	je     157c <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1560:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1563:	83 c0 08             	add    $0x8,%eax
    1566:	83 ec 0c             	sub    $0xc,%esp
    1569:	50                   	push   %eax
    156a:	e8 54 ff ff ff       	call   14c3 <free>
  return freep;
    156f:	a1 24 19 00 00       	mov    0x1924,%eax
    1574:	83 c4 10             	add    $0x10,%esp
}
    1577:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    157a:	c9                   	leave  
    157b:	c3                   	ret    
    return 0;
    157c:	b8 00 00 00 00       	mov    $0x0,%eax
    1581:	eb f4                	jmp    1577 <morecore+0x44>

00001583 <malloc>:

void*
malloc(uint nbytes)
{
    1583:	55                   	push   %ebp
    1584:	89 e5                	mov    %esp,%ebp
    1586:	53                   	push   %ebx
    1587:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    158a:	8b 45 08             	mov    0x8(%ebp),%eax
    158d:	8d 58 07             	lea    0x7(%eax),%ebx
    1590:	c1 eb 03             	shr    $0x3,%ebx
    1593:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1596:	8b 0d 24 19 00 00    	mov    0x1924,%ecx
    159c:	85 c9                	test   %ecx,%ecx
    159e:	74 04                	je     15a4 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a0:	8b 01                	mov    (%ecx),%eax
    15a2:	eb 4a                	jmp    15ee <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15a4:	c7 05 24 19 00 00 28 	movl   $0x1928,0x1924
    15ab:	19 00 00 
    15ae:	c7 05 28 19 00 00 28 	movl   $0x1928,0x1928
    15b5:	19 00 00 
    base.s.size = 0;
    15b8:	c7 05 2c 19 00 00 00 	movl   $0x0,0x192c
    15bf:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15c2:	b9 28 19 00 00       	mov    $0x1928,%ecx
    15c7:	eb d7                	jmp    15a0 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15c9:	74 19                	je     15e4 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15cb:	29 da                	sub    %ebx,%edx
    15cd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15d0:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15d3:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15d6:	89 0d 24 19 00 00    	mov    %ecx,0x1924
      return (void*)(p + 1);
    15dc:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15e2:	c9                   	leave  
    15e3:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15e4:	8b 10                	mov    (%eax),%edx
    15e6:	89 11                	mov    %edx,(%ecx)
    15e8:	eb ec                	jmp    15d6 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15ea:	89 c1                	mov    %eax,%ecx
    15ec:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15ee:	8b 50 04             	mov    0x4(%eax),%edx
    15f1:	39 da                	cmp    %ebx,%edx
    15f3:	73 d4                	jae    15c9 <malloc+0x46>
    if(p == freep)
    15f5:	39 05 24 19 00 00    	cmp    %eax,0x1924
    15fb:	75 ed                	jne    15ea <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15fd:	89 d8                	mov    %ebx,%eax
    15ff:	e8 2f ff ff ff       	call   1533 <morecore>
    1604:	85 c0                	test   %eax,%eax
    1606:	75 e2                	jne    15ea <malloc+0x67>
    1608:	eb d5                	jmp    15df <malloc+0x5c>
