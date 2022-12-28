
_test_16:     file format elf32-i386


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
    1017:	e8 4f 02 00 00       	call   126b <sbrk>
    101c:	89 c3                	mov    %eax,%ebx
    munprotect(ptr, PAGES_NUM);
    101e:	83 c4 08             	add    $0x8,%esp
    1021:	6a 05                	push   $0x5
    1023:	50                   	push   %eax
    1024:	e8 72 02 00 00       	call   129b <munprotect>
    ptr[PGSIZE * 3] = 0xAA;
    1029:	c6 83 00 30 00 00 aa 	movb   $0xaa,0x3000(%ebx)
    printf(1, "XV6_TEST_OUTPUT TEST PASS\n");
    1030:	83 c4 08             	add    $0x8,%esp
    1033:	68 f8 15 00 00       	push   $0x15f8
    1038:	6a 01                	push   $0x1
    103a:	e8 09 03 00 00       	call   1348 <printf>
    exit();
    103f:	e8 9f 01 00 00       	call   11e3 <exit>

00001044 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1044:	55                   	push   %ebp
    1045:	89 e5                	mov    %esp,%ebp
    1047:	56                   	push   %esi
    1048:	53                   	push   %ebx
    1049:	8b 75 08             	mov    0x8(%ebp),%esi
    104c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    104f:	89 f0                	mov    %esi,%eax
    1051:	89 d1                	mov    %edx,%ecx
    1053:	83 c2 01             	add    $0x1,%edx
    1056:	89 c3                	mov    %eax,%ebx
    1058:	83 c0 01             	add    $0x1,%eax
    105b:	0f b6 09             	movzbl (%ecx),%ecx
    105e:	88 0b                	mov    %cl,(%ebx)
    1060:	84 c9                	test   %cl,%cl
    1062:	75 ed                	jne    1051 <strcpy+0xd>
    ;
  return os;
}
    1064:	89 f0                	mov    %esi,%eax
    1066:	5b                   	pop    %ebx
    1067:	5e                   	pop    %esi
    1068:	5d                   	pop    %ebp
    1069:	c3                   	ret    

0000106a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    106a:	55                   	push   %ebp
    106b:	89 e5                	mov    %esp,%ebp
    106d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1070:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1073:	eb 06                	jmp    107b <strcmp+0x11>
    p++, q++;
    1075:	83 c1 01             	add    $0x1,%ecx
    1078:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    107b:	0f b6 01             	movzbl (%ecx),%eax
    107e:	84 c0                	test   %al,%al
    1080:	74 04                	je     1086 <strcmp+0x1c>
    1082:	3a 02                	cmp    (%edx),%al
    1084:	74 ef                	je     1075 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1086:	0f b6 c0             	movzbl %al,%eax
    1089:	0f b6 12             	movzbl (%edx),%edx
    108c:	29 d0                	sub    %edx,%eax
}
    108e:	5d                   	pop    %ebp
    108f:	c3                   	ret    

00001090 <strlen>:

uint
strlen(const char *s)
{
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1096:	b8 00 00 00 00       	mov    $0x0,%eax
    109b:	eb 03                	jmp    10a0 <strlen+0x10>
    109d:	83 c0 01             	add    $0x1,%eax
    10a0:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10a4:	75 f7                	jne    109d <strlen+0xd>
    ;
  return n;
}
    10a6:	5d                   	pop    %ebp
    10a7:	c3                   	ret    

000010a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10a8:	55                   	push   %ebp
    10a9:	89 e5                	mov    %esp,%ebp
    10ab:	57                   	push   %edi
    10ac:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10af:	89 d7                	mov    %edx,%edi
    10b1:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b7:	fc                   	cld    
    10b8:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10ba:	89 d0                	mov    %edx,%eax
    10bc:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10bf:	c9                   	leave  
    10c0:	c3                   	ret    

000010c1 <strchr>:

char*
strchr(const char *s, char c)
{
    10c1:	55                   	push   %ebp
    10c2:	89 e5                	mov    %esp,%ebp
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10cb:	eb 03                	jmp    10d0 <strchr+0xf>
    10cd:	83 c0 01             	add    $0x1,%eax
    10d0:	0f b6 10             	movzbl (%eax),%edx
    10d3:	84 d2                	test   %dl,%dl
    10d5:	74 06                	je     10dd <strchr+0x1c>
    if(*s == c)
    10d7:	38 ca                	cmp    %cl,%dl
    10d9:	75 f2                	jne    10cd <strchr+0xc>
    10db:	eb 05                	jmp    10e2 <strchr+0x21>
      return (char*)s;
  return 0;
    10dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10e2:	5d                   	pop    %ebp
    10e3:	c3                   	ret    

000010e4 <gets>:

char*
gets(char *buf, int max)
{
    10e4:	55                   	push   %ebp
    10e5:	89 e5                	mov    %esp,%ebp
    10e7:	57                   	push   %edi
    10e8:	56                   	push   %esi
    10e9:	53                   	push   %ebx
    10ea:	83 ec 1c             	sub    $0x1c,%esp
    10ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10f0:	bb 00 00 00 00       	mov    $0x0,%ebx
    10f5:	89 de                	mov    %ebx,%esi
    10f7:	83 c3 01             	add    $0x1,%ebx
    10fa:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    10fd:	7d 2e                	jge    112d <gets+0x49>
    cc = read(0, &c, 1);
    10ff:	83 ec 04             	sub    $0x4,%esp
    1102:	6a 01                	push   $0x1
    1104:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1107:	50                   	push   %eax
    1108:	6a 00                	push   $0x0
    110a:	e8 ec 00 00 00       	call   11fb <read>
    if(cc < 1)
    110f:	83 c4 10             	add    $0x10,%esp
    1112:	85 c0                	test   %eax,%eax
    1114:	7e 17                	jle    112d <gets+0x49>
      break;
    buf[i++] = c;
    1116:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    111a:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    111d:	3c 0a                	cmp    $0xa,%al
    111f:	0f 94 c2             	sete   %dl
    1122:	3c 0d                	cmp    $0xd,%al
    1124:	0f 94 c0             	sete   %al
    1127:	08 c2                	or     %al,%dl
    1129:	74 ca                	je     10f5 <gets+0x11>
    buf[i++] = c;
    112b:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    112d:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1131:	89 f8                	mov    %edi,%eax
    1133:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1136:	5b                   	pop    %ebx
    1137:	5e                   	pop    %esi
    1138:	5f                   	pop    %edi
    1139:	5d                   	pop    %ebp
    113a:	c3                   	ret    

0000113b <stat>:

int
stat(const char *n, struct stat *st)
{
    113b:	55                   	push   %ebp
    113c:	89 e5                	mov    %esp,%ebp
    113e:	56                   	push   %esi
    113f:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1140:	83 ec 08             	sub    $0x8,%esp
    1143:	6a 00                	push   $0x0
    1145:	ff 75 08             	push   0x8(%ebp)
    1148:	e8 d6 00 00 00       	call   1223 <open>
  if(fd < 0)
    114d:	83 c4 10             	add    $0x10,%esp
    1150:	85 c0                	test   %eax,%eax
    1152:	78 24                	js     1178 <stat+0x3d>
    1154:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1156:	83 ec 08             	sub    $0x8,%esp
    1159:	ff 75 0c             	push   0xc(%ebp)
    115c:	50                   	push   %eax
    115d:	e8 d9 00 00 00       	call   123b <fstat>
    1162:	89 c6                	mov    %eax,%esi
  close(fd);
    1164:	89 1c 24             	mov    %ebx,(%esp)
    1167:	e8 9f 00 00 00       	call   120b <close>
  return r;
    116c:	83 c4 10             	add    $0x10,%esp
}
    116f:	89 f0                	mov    %esi,%eax
    1171:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1174:	5b                   	pop    %ebx
    1175:	5e                   	pop    %esi
    1176:	5d                   	pop    %ebp
    1177:	c3                   	ret    
    return -1;
    1178:	be ff ff ff ff       	mov    $0xffffffff,%esi
    117d:	eb f0                	jmp    116f <stat+0x34>

0000117f <atoi>:

int
atoi(const char *s)
{
    117f:	55                   	push   %ebp
    1180:	89 e5                	mov    %esp,%ebp
    1182:	53                   	push   %ebx
    1183:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1186:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    118b:	eb 10                	jmp    119d <atoi+0x1e>
    n = n*10 + *s++ - '0';
    118d:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1190:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1193:	83 c1 01             	add    $0x1,%ecx
    1196:	0f be c0             	movsbl %al,%eax
    1199:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    119d:	0f b6 01             	movzbl (%ecx),%eax
    11a0:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11a3:	80 fb 09             	cmp    $0x9,%bl
    11a6:	76 e5                	jbe    118d <atoi+0xe>
  return n;
}
    11a8:	89 d0                	mov    %edx,%eax
    11aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ad:	c9                   	leave  
    11ae:	c3                   	ret    

000011af <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11af:	55                   	push   %ebp
    11b0:	89 e5                	mov    %esp,%ebp
    11b2:	56                   	push   %esi
    11b3:	53                   	push   %ebx
    11b4:	8b 75 08             	mov    0x8(%ebp),%esi
    11b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11ba:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11bd:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11bf:	eb 0d                	jmp    11ce <memmove+0x1f>
    *dst++ = *src++;
    11c1:	0f b6 01             	movzbl (%ecx),%eax
    11c4:	88 02                	mov    %al,(%edx)
    11c6:	8d 49 01             	lea    0x1(%ecx),%ecx
    11c9:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11cc:	89 d8                	mov    %ebx,%eax
    11ce:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11d1:	85 c0                	test   %eax,%eax
    11d3:	7f ec                	jg     11c1 <memmove+0x12>
  return vdst;
}
    11d5:	89 f0                	mov    %esi,%eax
    11d7:	5b                   	pop    %ebx
    11d8:	5e                   	pop    %esi
    11d9:	5d                   	pop    %ebp
    11da:	c3                   	ret    

000011db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11db:	b8 01 00 00 00       	mov    $0x1,%eax
    11e0:	cd 40                	int    $0x40
    11e2:	c3                   	ret    

000011e3 <exit>:
SYSCALL(exit)
    11e3:	b8 02 00 00 00       	mov    $0x2,%eax
    11e8:	cd 40                	int    $0x40
    11ea:	c3                   	ret    

000011eb <wait>:
SYSCALL(wait)
    11eb:	b8 03 00 00 00       	mov    $0x3,%eax
    11f0:	cd 40                	int    $0x40
    11f2:	c3                   	ret    

000011f3 <pipe>:
SYSCALL(pipe)
    11f3:	b8 04 00 00 00       	mov    $0x4,%eax
    11f8:	cd 40                	int    $0x40
    11fa:	c3                   	ret    

000011fb <read>:
SYSCALL(read)
    11fb:	b8 05 00 00 00       	mov    $0x5,%eax
    1200:	cd 40                	int    $0x40
    1202:	c3                   	ret    

00001203 <write>:
SYSCALL(write)
    1203:	b8 10 00 00 00       	mov    $0x10,%eax
    1208:	cd 40                	int    $0x40
    120a:	c3                   	ret    

0000120b <close>:
SYSCALL(close)
    120b:	b8 15 00 00 00       	mov    $0x15,%eax
    1210:	cd 40                	int    $0x40
    1212:	c3                   	ret    

00001213 <kill>:
SYSCALL(kill)
    1213:	b8 06 00 00 00       	mov    $0x6,%eax
    1218:	cd 40                	int    $0x40
    121a:	c3                   	ret    

0000121b <exec>:
SYSCALL(exec)
    121b:	b8 07 00 00 00       	mov    $0x7,%eax
    1220:	cd 40                	int    $0x40
    1222:	c3                   	ret    

00001223 <open>:
SYSCALL(open)
    1223:	b8 0f 00 00 00       	mov    $0xf,%eax
    1228:	cd 40                	int    $0x40
    122a:	c3                   	ret    

0000122b <mknod>:
SYSCALL(mknod)
    122b:	b8 11 00 00 00       	mov    $0x11,%eax
    1230:	cd 40                	int    $0x40
    1232:	c3                   	ret    

00001233 <unlink>:
SYSCALL(unlink)
    1233:	b8 12 00 00 00       	mov    $0x12,%eax
    1238:	cd 40                	int    $0x40
    123a:	c3                   	ret    

0000123b <fstat>:
SYSCALL(fstat)
    123b:	b8 08 00 00 00       	mov    $0x8,%eax
    1240:	cd 40                	int    $0x40
    1242:	c3                   	ret    

00001243 <link>:
SYSCALL(link)
    1243:	b8 13 00 00 00       	mov    $0x13,%eax
    1248:	cd 40                	int    $0x40
    124a:	c3                   	ret    

0000124b <mkdir>:
SYSCALL(mkdir)
    124b:	b8 14 00 00 00       	mov    $0x14,%eax
    1250:	cd 40                	int    $0x40
    1252:	c3                   	ret    

00001253 <chdir>:
SYSCALL(chdir)
    1253:	b8 09 00 00 00       	mov    $0x9,%eax
    1258:	cd 40                	int    $0x40
    125a:	c3                   	ret    

0000125b <dup>:
SYSCALL(dup)
    125b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1260:	cd 40                	int    $0x40
    1262:	c3                   	ret    

00001263 <getpid>:
SYSCALL(getpid)
    1263:	b8 0b 00 00 00       	mov    $0xb,%eax
    1268:	cd 40                	int    $0x40
    126a:	c3                   	ret    

0000126b <sbrk>:
SYSCALL(sbrk)
    126b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1270:	cd 40                	int    $0x40
    1272:	c3                   	ret    

00001273 <sleep>:
SYSCALL(sleep)
    1273:	b8 0d 00 00 00       	mov    $0xd,%eax
    1278:	cd 40                	int    $0x40
    127a:	c3                   	ret    

0000127b <uptime>:
SYSCALL(uptime)
    127b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1280:	cd 40                	int    $0x40
    1282:	c3                   	ret    

00001283 <settickets>:
SYSCALL(settickets)
    1283:	b8 16 00 00 00       	mov    $0x16,%eax
    1288:	cd 40                	int    $0x40
    128a:	c3                   	ret    

0000128b <getpinfo>:
SYSCALL(getpinfo)
    128b:	b8 17 00 00 00       	mov    $0x17,%eax
    1290:	cd 40                	int    $0x40
    1292:	c3                   	ret    

00001293 <mprotect>:
SYSCALL(mprotect)
    1293:	b8 18 00 00 00       	mov    $0x18,%eax
    1298:	cd 40                	int    $0x40
    129a:	c3                   	ret    

0000129b <munprotect>:
    129b:	b8 19 00 00 00       	mov    $0x19,%eax
    12a0:	cd 40                	int    $0x40
    12a2:	c3                   	ret    

000012a3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12a3:	55                   	push   %ebp
    12a4:	89 e5                	mov    %esp,%ebp
    12a6:	83 ec 1c             	sub    $0x1c,%esp
    12a9:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12ac:	6a 01                	push   $0x1
    12ae:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12b1:	52                   	push   %edx
    12b2:	50                   	push   %eax
    12b3:	e8 4b ff ff ff       	call   1203 <write>
}
    12b8:	83 c4 10             	add    $0x10,%esp
    12bb:	c9                   	leave  
    12bc:	c3                   	ret    

000012bd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12bd:	55                   	push   %ebp
    12be:	89 e5                	mov    %esp,%ebp
    12c0:	57                   	push   %edi
    12c1:	56                   	push   %esi
    12c2:	53                   	push   %ebx
    12c3:	83 ec 2c             	sub    $0x2c,%esp
    12c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12c9:	89 d0                	mov    %edx,%eax
    12cb:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12d1:	0f 95 c1             	setne  %cl
    12d4:	c1 ea 1f             	shr    $0x1f,%edx
    12d7:	84 d1                	test   %dl,%cl
    12d9:	74 44                	je     131f <printint+0x62>
    neg = 1;
    x = -xx;
    12db:	f7 d8                	neg    %eax
    12dd:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12df:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12e6:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12eb:	89 c8                	mov    %ecx,%eax
    12ed:	ba 00 00 00 00       	mov    $0x0,%edx
    12f2:	f7 f6                	div    %esi
    12f4:	89 df                	mov    %ebx,%edi
    12f6:	83 c3 01             	add    $0x1,%ebx
    12f9:	0f b6 92 74 16 00 00 	movzbl 0x1674(%edx),%edx
    1300:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1304:	89 ca                	mov    %ecx,%edx
    1306:	89 c1                	mov    %eax,%ecx
    1308:	39 d6                	cmp    %edx,%esi
    130a:	76 df                	jbe    12eb <printint+0x2e>
  if(neg)
    130c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1310:	74 31                	je     1343 <printint+0x86>
    buf[i++] = '-';
    1312:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1317:	8d 5f 02             	lea    0x2(%edi),%ebx
    131a:	8b 75 d0             	mov    -0x30(%ebp),%esi
    131d:	eb 17                	jmp    1336 <printint+0x79>
    x = xx;
    131f:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1321:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1328:	eb bc                	jmp    12e6 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    132a:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    132f:	89 f0                	mov    %esi,%eax
    1331:	e8 6d ff ff ff       	call   12a3 <putc>
  while(--i >= 0)
    1336:	83 eb 01             	sub    $0x1,%ebx
    1339:	79 ef                	jns    132a <printint+0x6d>
}
    133b:	83 c4 2c             	add    $0x2c,%esp
    133e:	5b                   	pop    %ebx
    133f:	5e                   	pop    %esi
    1340:	5f                   	pop    %edi
    1341:	5d                   	pop    %ebp
    1342:	c3                   	ret    
    1343:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1346:	eb ee                	jmp    1336 <printint+0x79>

00001348 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1348:	55                   	push   %ebp
    1349:	89 e5                	mov    %esp,%ebp
    134b:	57                   	push   %edi
    134c:	56                   	push   %esi
    134d:	53                   	push   %ebx
    134e:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1351:	8d 45 10             	lea    0x10(%ebp),%eax
    1354:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1357:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    135c:	bb 00 00 00 00       	mov    $0x0,%ebx
    1361:	eb 14                	jmp    1377 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1363:	89 fa                	mov    %edi,%edx
    1365:	8b 45 08             	mov    0x8(%ebp),%eax
    1368:	e8 36 ff ff ff       	call   12a3 <putc>
    136d:	eb 05                	jmp    1374 <printf+0x2c>
      }
    } else if(state == '%'){
    136f:	83 fe 25             	cmp    $0x25,%esi
    1372:	74 25                	je     1399 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1374:	83 c3 01             	add    $0x1,%ebx
    1377:	8b 45 0c             	mov    0xc(%ebp),%eax
    137a:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    137e:	84 c0                	test   %al,%al
    1380:	0f 84 20 01 00 00    	je     14a6 <printf+0x15e>
    c = fmt[i] & 0xff;
    1386:	0f be f8             	movsbl %al,%edi
    1389:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    138c:	85 f6                	test   %esi,%esi
    138e:	75 df                	jne    136f <printf+0x27>
      if(c == '%'){
    1390:	83 f8 25             	cmp    $0x25,%eax
    1393:	75 ce                	jne    1363 <printf+0x1b>
        state = '%';
    1395:	89 c6                	mov    %eax,%esi
    1397:	eb db                	jmp    1374 <printf+0x2c>
      if(c == 'd'){
    1399:	83 f8 25             	cmp    $0x25,%eax
    139c:	0f 84 cf 00 00 00    	je     1471 <printf+0x129>
    13a2:	0f 8c dd 00 00 00    	jl     1485 <printf+0x13d>
    13a8:	83 f8 78             	cmp    $0x78,%eax
    13ab:	0f 8f d4 00 00 00    	jg     1485 <printf+0x13d>
    13b1:	83 f8 63             	cmp    $0x63,%eax
    13b4:	0f 8c cb 00 00 00    	jl     1485 <printf+0x13d>
    13ba:	83 e8 63             	sub    $0x63,%eax
    13bd:	83 f8 15             	cmp    $0x15,%eax
    13c0:	0f 87 bf 00 00 00    	ja     1485 <printf+0x13d>
    13c6:	ff 24 85 1c 16 00 00 	jmp    *0x161c(,%eax,4)
        printint(fd, *ap, 10, 1);
    13cd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13d0:	8b 17                	mov    (%edi),%edx
    13d2:	83 ec 0c             	sub    $0xc,%esp
    13d5:	6a 01                	push   $0x1
    13d7:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	e8 d9 fe ff ff       	call   12bd <printint>
        ap++;
    13e4:	83 c7 04             	add    $0x4,%edi
    13e7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13ed:	be 00 00 00 00       	mov    $0x0,%esi
    13f2:	eb 80                	jmp    1374 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    13f4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13f7:	8b 17                	mov    (%edi),%edx
    13f9:	83 ec 0c             	sub    $0xc,%esp
    13fc:	6a 00                	push   $0x0
    13fe:	b9 10 00 00 00       	mov    $0x10,%ecx
    1403:	8b 45 08             	mov    0x8(%ebp),%eax
    1406:	e8 b2 fe ff ff       	call   12bd <printint>
        ap++;
    140b:	83 c7 04             	add    $0x4,%edi
    140e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1411:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1414:	be 00 00 00 00       	mov    $0x0,%esi
    1419:	e9 56 ff ff ff       	jmp    1374 <printf+0x2c>
        s = (char*)*ap;
    141e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1421:	8b 30                	mov    (%eax),%esi
        ap++;
    1423:	83 c0 04             	add    $0x4,%eax
    1426:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1429:	85 f6                	test   %esi,%esi
    142b:	75 15                	jne    1442 <printf+0xfa>
          s = "(null)";
    142d:	be 13 16 00 00       	mov    $0x1613,%esi
    1432:	eb 0e                	jmp    1442 <printf+0xfa>
          putc(fd, *s);
    1434:	0f be d2             	movsbl %dl,%edx
    1437:	8b 45 08             	mov    0x8(%ebp),%eax
    143a:	e8 64 fe ff ff       	call   12a3 <putc>
          s++;
    143f:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1442:	0f b6 16             	movzbl (%esi),%edx
    1445:	84 d2                	test   %dl,%dl
    1447:	75 eb                	jne    1434 <printf+0xec>
      state = 0;
    1449:	be 00 00 00 00       	mov    $0x0,%esi
    144e:	e9 21 ff ff ff       	jmp    1374 <printf+0x2c>
        putc(fd, *ap);
    1453:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1456:	0f be 17             	movsbl (%edi),%edx
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	e8 42 fe ff ff       	call   12a3 <putc>
        ap++;
    1461:	83 c7 04             	add    $0x4,%edi
    1464:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1467:	be 00 00 00 00       	mov    $0x0,%esi
    146c:	e9 03 ff ff ff       	jmp    1374 <printf+0x2c>
        putc(fd, c);
    1471:	89 fa                	mov    %edi,%edx
    1473:	8b 45 08             	mov    0x8(%ebp),%eax
    1476:	e8 28 fe ff ff       	call   12a3 <putc>
      state = 0;
    147b:	be 00 00 00 00       	mov    $0x0,%esi
    1480:	e9 ef fe ff ff       	jmp    1374 <printf+0x2c>
        putc(fd, '%');
    1485:	ba 25 00 00 00       	mov    $0x25,%edx
    148a:	8b 45 08             	mov    0x8(%ebp),%eax
    148d:	e8 11 fe ff ff       	call   12a3 <putc>
        putc(fd, c);
    1492:	89 fa                	mov    %edi,%edx
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
    1497:	e8 07 fe ff ff       	call   12a3 <putc>
      state = 0;
    149c:	be 00 00 00 00       	mov    $0x0,%esi
    14a1:	e9 ce fe ff ff       	jmp    1374 <printf+0x2c>
    }
  }
}
    14a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14a9:	5b                   	pop    %ebx
    14aa:	5e                   	pop    %esi
    14ab:	5f                   	pop    %edi
    14ac:	5d                   	pop    %ebp
    14ad:	c3                   	ret    

000014ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14ae:	55                   	push   %ebp
    14af:	89 e5                	mov    %esp,%ebp
    14b1:	57                   	push   %edi
    14b2:	56                   	push   %esi
    14b3:	53                   	push   %ebx
    14b4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14b7:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14ba:	a1 18 19 00 00       	mov    0x1918,%eax
    14bf:	eb 02                	jmp    14c3 <free+0x15>
    14c1:	89 d0                	mov    %edx,%eax
    14c3:	39 c8                	cmp    %ecx,%eax
    14c5:	73 04                	jae    14cb <free+0x1d>
    14c7:	39 08                	cmp    %ecx,(%eax)
    14c9:	77 12                	ja     14dd <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14cb:	8b 10                	mov    (%eax),%edx
    14cd:	39 c2                	cmp    %eax,%edx
    14cf:	77 f0                	ja     14c1 <free+0x13>
    14d1:	39 c8                	cmp    %ecx,%eax
    14d3:	72 08                	jb     14dd <free+0x2f>
    14d5:	39 ca                	cmp    %ecx,%edx
    14d7:	77 04                	ja     14dd <free+0x2f>
    14d9:	89 d0                	mov    %edx,%eax
    14db:	eb e6                	jmp    14c3 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14dd:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14e0:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14e3:	8b 10                	mov    (%eax),%edx
    14e5:	39 d7                	cmp    %edx,%edi
    14e7:	74 19                	je     1502 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14e9:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14ec:	8b 50 04             	mov    0x4(%eax),%edx
    14ef:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14f2:	39 ce                	cmp    %ecx,%esi
    14f4:	74 1b                	je     1511 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14f6:	89 08                	mov    %ecx,(%eax)
  freep = p;
    14f8:	a3 18 19 00 00       	mov    %eax,0x1918
}
    14fd:	5b                   	pop    %ebx
    14fe:	5e                   	pop    %esi
    14ff:	5f                   	pop    %edi
    1500:	5d                   	pop    %ebp
    1501:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1502:	03 72 04             	add    0x4(%edx),%esi
    1505:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1508:	8b 10                	mov    (%eax),%edx
    150a:	8b 12                	mov    (%edx),%edx
    150c:	89 53 f8             	mov    %edx,-0x8(%ebx)
    150f:	eb db                	jmp    14ec <free+0x3e>
    p->s.size += bp->s.size;
    1511:	03 53 fc             	add    -0x4(%ebx),%edx
    1514:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1517:	8b 53 f8             	mov    -0x8(%ebx),%edx
    151a:	89 10                	mov    %edx,(%eax)
    151c:	eb da                	jmp    14f8 <free+0x4a>

0000151e <morecore>:

static Header*
morecore(uint nu)
{
    151e:	55                   	push   %ebp
    151f:	89 e5                	mov    %esp,%ebp
    1521:	53                   	push   %ebx
    1522:	83 ec 04             	sub    $0x4,%esp
    1525:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1527:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    152c:	77 05                	ja     1533 <morecore+0x15>
    nu = 4096;
    152e:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1533:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    153a:	83 ec 0c             	sub    $0xc,%esp
    153d:	50                   	push   %eax
    153e:	e8 28 fd ff ff       	call   126b <sbrk>
  if(p == (char*)-1)
    1543:	83 c4 10             	add    $0x10,%esp
    1546:	83 f8 ff             	cmp    $0xffffffff,%eax
    1549:	74 1c                	je     1567 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    154b:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    154e:	83 c0 08             	add    $0x8,%eax
    1551:	83 ec 0c             	sub    $0xc,%esp
    1554:	50                   	push   %eax
    1555:	e8 54 ff ff ff       	call   14ae <free>
  return freep;
    155a:	a1 18 19 00 00       	mov    0x1918,%eax
    155f:	83 c4 10             	add    $0x10,%esp
}
    1562:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1565:	c9                   	leave  
    1566:	c3                   	ret    
    return 0;
    1567:	b8 00 00 00 00       	mov    $0x0,%eax
    156c:	eb f4                	jmp    1562 <morecore+0x44>

0000156e <malloc>:

void*
malloc(uint nbytes)
{
    156e:	55                   	push   %ebp
    156f:	89 e5                	mov    %esp,%ebp
    1571:	53                   	push   %ebx
    1572:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1575:	8b 45 08             	mov    0x8(%ebp),%eax
    1578:	8d 58 07             	lea    0x7(%eax),%ebx
    157b:	c1 eb 03             	shr    $0x3,%ebx
    157e:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1581:	8b 0d 18 19 00 00    	mov    0x1918,%ecx
    1587:	85 c9                	test   %ecx,%ecx
    1589:	74 04                	je     158f <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    158b:	8b 01                	mov    (%ecx),%eax
    158d:	eb 4a                	jmp    15d9 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    158f:	c7 05 18 19 00 00 1c 	movl   $0x191c,0x1918
    1596:	19 00 00 
    1599:	c7 05 1c 19 00 00 1c 	movl   $0x191c,0x191c
    15a0:	19 00 00 
    base.s.size = 0;
    15a3:	c7 05 20 19 00 00 00 	movl   $0x0,0x1920
    15aa:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15ad:	b9 1c 19 00 00       	mov    $0x191c,%ecx
    15b2:	eb d7                	jmp    158b <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15b4:	74 19                	je     15cf <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15b6:	29 da                	sub    %ebx,%edx
    15b8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15bb:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15be:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15c1:	89 0d 18 19 00 00    	mov    %ecx,0x1918
      return (void*)(p + 1);
    15c7:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15cd:	c9                   	leave  
    15ce:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15cf:	8b 10                	mov    (%eax),%edx
    15d1:	89 11                	mov    %edx,(%ecx)
    15d3:	eb ec                	jmp    15c1 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15d5:	89 c1                	mov    %eax,%ecx
    15d7:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15d9:	8b 50 04             	mov    0x4(%eax),%edx
    15dc:	39 da                	cmp    %ebx,%edx
    15de:	73 d4                	jae    15b4 <malloc+0x46>
    if(p == freep)
    15e0:	39 05 18 19 00 00    	cmp    %eax,0x1918
    15e6:	75 ed                	jne    15d5 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15e8:	89 d8                	mov    %ebx,%eax
    15ea:	e8 2f ff ff ff       	call   151e <morecore>
    15ef:	85 c0                	test   %eax,%eax
    15f1:	75 e2                	jne    15d5 <malloc+0x67>
    15f3:	eb d5                	jmp    15ca <malloc+0x5c>
