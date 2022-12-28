
_test_15:     file format elf32-i386


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
    100d:	56                   	push   %esi
    100e:	53                   	push   %ebx
    100f:	51                   	push   %ecx
    1010:	83 ec 18             	sub    $0x18,%esp
    const uint PAGES_NUM = 5;
    
    // Allocate 5 pages
    char *ptr = sbrk(PGSIZE * PAGES_NUM * sizeof(char));
    1013:	68 00 50 00 00       	push   $0x5000
    1018:	e8 83 02 00 00       	call   12a0 <sbrk>
    101d:	89 c3                	mov    %eax,%ebx
    mprotect(ptr, PAGES_NUM);
    101f:	83 c4 08             	add    $0x8,%esp
    1022:	6a 05                	push   $0x5
    1024:	50                   	push   %eax
    1025:	e8 9e 02 00 00       	call   12c8 <mprotect>
    int ppid = getpid();
    102a:	e8 69 02 00 00       	call   1298 <getpid>
    102f:	89 c6                	mov    %eax,%esi

    if (fork() == 0) {
    1031:	e8 da 01 00 00       	call   1210 <fork>
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	85 c0                	test   %eax,%eax
    103b:	75 23                	jne    1060 <main+0x60>
        // Should page fault as normally here
        ptr[2 * PGSIZE] = 0xAA;
    103d:	c6 83 00 20 00 00 aa 	movb   $0xaa,0x2000(%ebx)
        printf(1, "XV6_TEST_OUTPUT Seg fault failed to trigger\n");
    1044:	83 ec 08             	sub    $0x8,%esp
    1047:	68 2c 16 00 00       	push   $0x162c
    104c:	6a 01                	push   $0x1
    104e:	e8 2a 03 00 00       	call   137d <printf>
        // Shouldn't reach here
        kill(ppid);
    1053:	89 34 24             	mov    %esi,(%esp)
    1056:	e8 ed 01 00 00       	call   1248 <kill>
        exit();
    105b:	e8 b8 01 00 00       	call   1218 <exit>
    } else {
        wait();
    1060:	e8 bb 01 00 00       	call   1220 <wait>
    }

    printf(1, "XV6_TEST_OUTPUT TEST PASS\n");
    1065:	83 ec 08             	sub    $0x8,%esp
    1068:	68 59 16 00 00       	push   $0x1659
    106d:	6a 01                	push   $0x1
    106f:	e8 09 03 00 00       	call   137d <printf>

    exit();
    1074:	e8 9f 01 00 00       	call   1218 <exit>

00001079 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1079:	55                   	push   %ebp
    107a:	89 e5                	mov    %esp,%ebp
    107c:	56                   	push   %esi
    107d:	53                   	push   %ebx
    107e:	8b 75 08             	mov    0x8(%ebp),%esi
    1081:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1084:	89 f0                	mov    %esi,%eax
    1086:	89 d1                	mov    %edx,%ecx
    1088:	83 c2 01             	add    $0x1,%edx
    108b:	89 c3                	mov    %eax,%ebx
    108d:	83 c0 01             	add    $0x1,%eax
    1090:	0f b6 09             	movzbl (%ecx),%ecx
    1093:	88 0b                	mov    %cl,(%ebx)
    1095:	84 c9                	test   %cl,%cl
    1097:	75 ed                	jne    1086 <strcpy+0xd>
    ;
  return os;
}
    1099:	89 f0                	mov    %esi,%eax
    109b:	5b                   	pop    %ebx
    109c:	5e                   	pop    %esi
    109d:	5d                   	pop    %ebp
    109e:	c3                   	ret    

0000109f <strcmp>:

int
strcmp(const char *p, const char *q)
{
    109f:	55                   	push   %ebp
    10a0:	89 e5                	mov    %esp,%ebp
    10a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10a8:	eb 06                	jmp    10b0 <strcmp+0x11>
    p++, q++;
    10aa:	83 c1 01             	add    $0x1,%ecx
    10ad:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10b0:	0f b6 01             	movzbl (%ecx),%eax
    10b3:	84 c0                	test   %al,%al
    10b5:	74 04                	je     10bb <strcmp+0x1c>
    10b7:	3a 02                	cmp    (%edx),%al
    10b9:	74 ef                	je     10aa <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    10bb:	0f b6 c0             	movzbl %al,%eax
    10be:	0f b6 12             	movzbl (%edx),%edx
    10c1:	29 d0                	sub    %edx,%eax
}
    10c3:	5d                   	pop    %ebp
    10c4:	c3                   	ret    

000010c5 <strlen>:

uint
strlen(const char *s)
{
    10c5:	55                   	push   %ebp
    10c6:	89 e5                	mov    %esp,%ebp
    10c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10cb:	b8 00 00 00 00       	mov    $0x0,%eax
    10d0:	eb 03                	jmp    10d5 <strlen+0x10>
    10d2:	83 c0 01             	add    $0x1,%eax
    10d5:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10d9:	75 f7                	jne    10d2 <strlen+0xd>
    ;
  return n;
}
    10db:	5d                   	pop    %ebp
    10dc:	c3                   	ret    

000010dd <memset>:

void*
memset(void *dst, int c, uint n)
{
    10dd:	55                   	push   %ebp
    10de:	89 e5                	mov    %esp,%ebp
    10e0:	57                   	push   %edi
    10e1:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10e4:	89 d7                	mov    %edx,%edi
    10e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ec:	fc                   	cld    
    10ed:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10ef:	89 d0                	mov    %edx,%eax
    10f1:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10f4:	c9                   	leave  
    10f5:	c3                   	ret    

000010f6 <strchr>:

char*
strchr(const char *s, char c)
{
    10f6:	55                   	push   %ebp
    10f7:	89 e5                	mov    %esp,%ebp
    10f9:	8b 45 08             	mov    0x8(%ebp),%eax
    10fc:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1100:	eb 03                	jmp    1105 <strchr+0xf>
    1102:	83 c0 01             	add    $0x1,%eax
    1105:	0f b6 10             	movzbl (%eax),%edx
    1108:	84 d2                	test   %dl,%dl
    110a:	74 06                	je     1112 <strchr+0x1c>
    if(*s == c)
    110c:	38 ca                	cmp    %cl,%dl
    110e:	75 f2                	jne    1102 <strchr+0xc>
    1110:	eb 05                	jmp    1117 <strchr+0x21>
      return (char*)s;
  return 0;
    1112:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1117:	5d                   	pop    %ebp
    1118:	c3                   	ret    

00001119 <gets>:

char*
gets(char *buf, int max)
{
    1119:	55                   	push   %ebp
    111a:	89 e5                	mov    %esp,%ebp
    111c:	57                   	push   %edi
    111d:	56                   	push   %esi
    111e:	53                   	push   %ebx
    111f:	83 ec 1c             	sub    $0x1c,%esp
    1122:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1125:	bb 00 00 00 00       	mov    $0x0,%ebx
    112a:	89 de                	mov    %ebx,%esi
    112c:	83 c3 01             	add    $0x1,%ebx
    112f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1132:	7d 2e                	jge    1162 <gets+0x49>
    cc = read(0, &c, 1);
    1134:	83 ec 04             	sub    $0x4,%esp
    1137:	6a 01                	push   $0x1
    1139:	8d 45 e7             	lea    -0x19(%ebp),%eax
    113c:	50                   	push   %eax
    113d:	6a 00                	push   $0x0
    113f:	e8 ec 00 00 00       	call   1230 <read>
    if(cc < 1)
    1144:	83 c4 10             	add    $0x10,%esp
    1147:	85 c0                	test   %eax,%eax
    1149:	7e 17                	jle    1162 <gets+0x49>
      break;
    buf[i++] = c;
    114b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    114f:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1152:	3c 0a                	cmp    $0xa,%al
    1154:	0f 94 c2             	sete   %dl
    1157:	3c 0d                	cmp    $0xd,%al
    1159:	0f 94 c0             	sete   %al
    115c:	08 c2                	or     %al,%dl
    115e:	74 ca                	je     112a <gets+0x11>
    buf[i++] = c;
    1160:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1162:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1166:	89 f8                	mov    %edi,%eax
    1168:	8d 65 f4             	lea    -0xc(%ebp),%esp
    116b:	5b                   	pop    %ebx
    116c:	5e                   	pop    %esi
    116d:	5f                   	pop    %edi
    116e:	5d                   	pop    %ebp
    116f:	c3                   	ret    

00001170 <stat>:

int
stat(const char *n, struct stat *st)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	56                   	push   %esi
    1174:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1175:	83 ec 08             	sub    $0x8,%esp
    1178:	6a 00                	push   $0x0
    117a:	ff 75 08             	push   0x8(%ebp)
    117d:	e8 d6 00 00 00       	call   1258 <open>
  if(fd < 0)
    1182:	83 c4 10             	add    $0x10,%esp
    1185:	85 c0                	test   %eax,%eax
    1187:	78 24                	js     11ad <stat+0x3d>
    1189:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    118b:	83 ec 08             	sub    $0x8,%esp
    118e:	ff 75 0c             	push   0xc(%ebp)
    1191:	50                   	push   %eax
    1192:	e8 d9 00 00 00       	call   1270 <fstat>
    1197:	89 c6                	mov    %eax,%esi
  close(fd);
    1199:	89 1c 24             	mov    %ebx,(%esp)
    119c:	e8 9f 00 00 00       	call   1240 <close>
  return r;
    11a1:	83 c4 10             	add    $0x10,%esp
}
    11a4:	89 f0                	mov    %esi,%eax
    11a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11a9:	5b                   	pop    %ebx
    11aa:	5e                   	pop    %esi
    11ab:	5d                   	pop    %ebp
    11ac:	c3                   	ret    
    return -1;
    11ad:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11b2:	eb f0                	jmp    11a4 <stat+0x34>

000011b4 <atoi>:

int
atoi(const char *s)
{
    11b4:	55                   	push   %ebp
    11b5:	89 e5                	mov    %esp,%ebp
    11b7:	53                   	push   %ebx
    11b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    11bb:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11c0:	eb 10                	jmp    11d2 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11c2:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11c5:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11c8:	83 c1 01             	add    $0x1,%ecx
    11cb:	0f be c0             	movsbl %al,%eax
    11ce:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11d2:	0f b6 01             	movzbl (%ecx),%eax
    11d5:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11d8:	80 fb 09             	cmp    $0x9,%bl
    11db:	76 e5                	jbe    11c2 <atoi+0xe>
  return n;
}
    11dd:	89 d0                	mov    %edx,%eax
    11df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e2:	c9                   	leave  
    11e3:	c3                   	ret    

000011e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11e4:	55                   	push   %ebp
    11e5:	89 e5                	mov    %esp,%ebp
    11e7:	56                   	push   %esi
    11e8:	53                   	push   %ebx
    11e9:	8b 75 08             	mov    0x8(%ebp),%esi
    11ec:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11ef:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11f2:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11f4:	eb 0d                	jmp    1203 <memmove+0x1f>
    *dst++ = *src++;
    11f6:	0f b6 01             	movzbl (%ecx),%eax
    11f9:	88 02                	mov    %al,(%edx)
    11fb:	8d 49 01             	lea    0x1(%ecx),%ecx
    11fe:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1201:	89 d8                	mov    %ebx,%eax
    1203:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1206:	85 c0                	test   %eax,%eax
    1208:	7f ec                	jg     11f6 <memmove+0x12>
  return vdst;
}
    120a:	89 f0                	mov    %esi,%eax
    120c:	5b                   	pop    %ebx
    120d:	5e                   	pop    %esi
    120e:	5d                   	pop    %ebp
    120f:	c3                   	ret    

00001210 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1210:	b8 01 00 00 00       	mov    $0x1,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <exit>:
SYSCALL(exit)
    1218:	b8 02 00 00 00       	mov    $0x2,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <wait>:
SYSCALL(wait)
    1220:	b8 03 00 00 00       	mov    $0x3,%eax
    1225:	cd 40                	int    $0x40
    1227:	c3                   	ret    

00001228 <pipe>:
SYSCALL(pipe)
    1228:	b8 04 00 00 00       	mov    $0x4,%eax
    122d:	cd 40                	int    $0x40
    122f:	c3                   	ret    

00001230 <read>:
SYSCALL(read)
    1230:	b8 05 00 00 00       	mov    $0x5,%eax
    1235:	cd 40                	int    $0x40
    1237:	c3                   	ret    

00001238 <write>:
SYSCALL(write)
    1238:	b8 10 00 00 00       	mov    $0x10,%eax
    123d:	cd 40                	int    $0x40
    123f:	c3                   	ret    

00001240 <close>:
SYSCALL(close)
    1240:	b8 15 00 00 00       	mov    $0x15,%eax
    1245:	cd 40                	int    $0x40
    1247:	c3                   	ret    

00001248 <kill>:
SYSCALL(kill)
    1248:	b8 06 00 00 00       	mov    $0x6,%eax
    124d:	cd 40                	int    $0x40
    124f:	c3                   	ret    

00001250 <exec>:
SYSCALL(exec)
    1250:	b8 07 00 00 00       	mov    $0x7,%eax
    1255:	cd 40                	int    $0x40
    1257:	c3                   	ret    

00001258 <open>:
SYSCALL(open)
    1258:	b8 0f 00 00 00       	mov    $0xf,%eax
    125d:	cd 40                	int    $0x40
    125f:	c3                   	ret    

00001260 <mknod>:
SYSCALL(mknod)
    1260:	b8 11 00 00 00       	mov    $0x11,%eax
    1265:	cd 40                	int    $0x40
    1267:	c3                   	ret    

00001268 <unlink>:
SYSCALL(unlink)
    1268:	b8 12 00 00 00       	mov    $0x12,%eax
    126d:	cd 40                	int    $0x40
    126f:	c3                   	ret    

00001270 <fstat>:
SYSCALL(fstat)
    1270:	b8 08 00 00 00       	mov    $0x8,%eax
    1275:	cd 40                	int    $0x40
    1277:	c3                   	ret    

00001278 <link>:
SYSCALL(link)
    1278:	b8 13 00 00 00       	mov    $0x13,%eax
    127d:	cd 40                	int    $0x40
    127f:	c3                   	ret    

00001280 <mkdir>:
SYSCALL(mkdir)
    1280:	b8 14 00 00 00       	mov    $0x14,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <chdir>:
SYSCALL(chdir)
    1288:	b8 09 00 00 00       	mov    $0x9,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <dup>:
SYSCALL(dup)
    1290:	b8 0a 00 00 00       	mov    $0xa,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <getpid>:
SYSCALL(getpid)
    1298:	b8 0b 00 00 00       	mov    $0xb,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <sbrk>:
SYSCALL(sbrk)
    12a0:	b8 0c 00 00 00       	mov    $0xc,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <sleep>:
SYSCALL(sleep)
    12a8:	b8 0d 00 00 00       	mov    $0xd,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <uptime>:
SYSCALL(uptime)
    12b0:	b8 0e 00 00 00       	mov    $0xe,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <settickets>:
SYSCALL(settickets)
    12b8:	b8 16 00 00 00       	mov    $0x16,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <getpinfo>:
SYSCALL(getpinfo)
    12c0:	b8 17 00 00 00       	mov    $0x17,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <mprotect>:
SYSCALL(mprotect)
    12c8:	b8 18 00 00 00       	mov    $0x18,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <munprotect>:
    12d0:	b8 19 00 00 00       	mov    $0x19,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12d8:	55                   	push   %ebp
    12d9:	89 e5                	mov    %esp,%ebp
    12db:	83 ec 1c             	sub    $0x1c,%esp
    12de:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12e1:	6a 01                	push   $0x1
    12e3:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12e6:	52                   	push   %edx
    12e7:	50                   	push   %eax
    12e8:	e8 4b ff ff ff       	call   1238 <write>
}
    12ed:	83 c4 10             	add    $0x10,%esp
    12f0:	c9                   	leave  
    12f1:	c3                   	ret    

000012f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12f2:	55                   	push   %ebp
    12f3:	89 e5                	mov    %esp,%ebp
    12f5:	57                   	push   %edi
    12f6:	56                   	push   %esi
    12f7:	53                   	push   %ebx
    12f8:	83 ec 2c             	sub    $0x2c,%esp
    12fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12fe:	89 d0                	mov    %edx,%eax
    1300:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1302:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1306:	0f 95 c1             	setne  %cl
    1309:	c1 ea 1f             	shr    $0x1f,%edx
    130c:	84 d1                	test   %dl,%cl
    130e:	74 44                	je     1354 <printint+0x62>
    neg = 1;
    x = -xx;
    1310:	f7 d8                	neg    %eax
    1312:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1314:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    131b:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1320:	89 c8                	mov    %ecx,%eax
    1322:	ba 00 00 00 00       	mov    $0x0,%edx
    1327:	f7 f6                	div    %esi
    1329:	89 df                	mov    %ebx,%edi
    132b:	83 c3 01             	add    $0x1,%ebx
    132e:	0f b6 92 d4 16 00 00 	movzbl 0x16d4(%edx),%edx
    1335:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1339:	89 ca                	mov    %ecx,%edx
    133b:	89 c1                	mov    %eax,%ecx
    133d:	39 d6                	cmp    %edx,%esi
    133f:	76 df                	jbe    1320 <printint+0x2e>
  if(neg)
    1341:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1345:	74 31                	je     1378 <printint+0x86>
    buf[i++] = '-';
    1347:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    134c:	8d 5f 02             	lea    0x2(%edi),%ebx
    134f:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1352:	eb 17                	jmp    136b <printint+0x79>
    x = xx;
    1354:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1356:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    135d:	eb bc                	jmp    131b <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    135f:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1364:	89 f0                	mov    %esi,%eax
    1366:	e8 6d ff ff ff       	call   12d8 <putc>
  while(--i >= 0)
    136b:	83 eb 01             	sub    $0x1,%ebx
    136e:	79 ef                	jns    135f <printint+0x6d>
}
    1370:	83 c4 2c             	add    $0x2c,%esp
    1373:	5b                   	pop    %ebx
    1374:	5e                   	pop    %esi
    1375:	5f                   	pop    %edi
    1376:	5d                   	pop    %ebp
    1377:	c3                   	ret    
    1378:	8b 75 d0             	mov    -0x30(%ebp),%esi
    137b:	eb ee                	jmp    136b <printint+0x79>

0000137d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    137d:	55                   	push   %ebp
    137e:	89 e5                	mov    %esp,%ebp
    1380:	57                   	push   %edi
    1381:	56                   	push   %esi
    1382:	53                   	push   %ebx
    1383:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1386:	8d 45 10             	lea    0x10(%ebp),%eax
    1389:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    138c:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1391:	bb 00 00 00 00       	mov    $0x0,%ebx
    1396:	eb 14                	jmp    13ac <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1398:	89 fa                	mov    %edi,%edx
    139a:	8b 45 08             	mov    0x8(%ebp),%eax
    139d:	e8 36 ff ff ff       	call   12d8 <putc>
    13a2:	eb 05                	jmp    13a9 <printf+0x2c>
      }
    } else if(state == '%'){
    13a4:	83 fe 25             	cmp    $0x25,%esi
    13a7:	74 25                	je     13ce <printf+0x51>
  for(i = 0; fmt[i]; i++){
    13a9:	83 c3 01             	add    $0x1,%ebx
    13ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    13af:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    13b3:	84 c0                	test   %al,%al
    13b5:	0f 84 20 01 00 00    	je     14db <printf+0x15e>
    c = fmt[i] & 0xff;
    13bb:	0f be f8             	movsbl %al,%edi
    13be:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13c1:	85 f6                	test   %esi,%esi
    13c3:	75 df                	jne    13a4 <printf+0x27>
      if(c == '%'){
    13c5:	83 f8 25             	cmp    $0x25,%eax
    13c8:	75 ce                	jne    1398 <printf+0x1b>
        state = '%';
    13ca:	89 c6                	mov    %eax,%esi
    13cc:	eb db                	jmp    13a9 <printf+0x2c>
      if(c == 'd'){
    13ce:	83 f8 25             	cmp    $0x25,%eax
    13d1:	0f 84 cf 00 00 00    	je     14a6 <printf+0x129>
    13d7:	0f 8c dd 00 00 00    	jl     14ba <printf+0x13d>
    13dd:	83 f8 78             	cmp    $0x78,%eax
    13e0:	0f 8f d4 00 00 00    	jg     14ba <printf+0x13d>
    13e6:	83 f8 63             	cmp    $0x63,%eax
    13e9:	0f 8c cb 00 00 00    	jl     14ba <printf+0x13d>
    13ef:	83 e8 63             	sub    $0x63,%eax
    13f2:	83 f8 15             	cmp    $0x15,%eax
    13f5:	0f 87 bf 00 00 00    	ja     14ba <printf+0x13d>
    13fb:	ff 24 85 7c 16 00 00 	jmp    *0x167c(,%eax,4)
        printint(fd, *ap, 10, 1);
    1402:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1405:	8b 17                	mov    (%edi),%edx
    1407:	83 ec 0c             	sub    $0xc,%esp
    140a:	6a 01                	push   $0x1
    140c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1411:	8b 45 08             	mov    0x8(%ebp),%eax
    1414:	e8 d9 fe ff ff       	call   12f2 <printint>
        ap++;
    1419:	83 c7 04             	add    $0x4,%edi
    141c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    141f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1422:	be 00 00 00 00       	mov    $0x0,%esi
    1427:	eb 80                	jmp    13a9 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1429:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    142c:	8b 17                	mov    (%edi),%edx
    142e:	83 ec 0c             	sub    $0xc,%esp
    1431:	6a 00                	push   $0x0
    1433:	b9 10 00 00 00       	mov    $0x10,%ecx
    1438:	8b 45 08             	mov    0x8(%ebp),%eax
    143b:	e8 b2 fe ff ff       	call   12f2 <printint>
        ap++;
    1440:	83 c7 04             	add    $0x4,%edi
    1443:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1446:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1449:	be 00 00 00 00       	mov    $0x0,%esi
    144e:	e9 56 ff ff ff       	jmp    13a9 <printf+0x2c>
        s = (char*)*ap;
    1453:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1456:	8b 30                	mov    (%eax),%esi
        ap++;
    1458:	83 c0 04             	add    $0x4,%eax
    145b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    145e:	85 f6                	test   %esi,%esi
    1460:	75 15                	jne    1477 <printf+0xfa>
          s = "(null)";
    1462:	be 74 16 00 00       	mov    $0x1674,%esi
    1467:	eb 0e                	jmp    1477 <printf+0xfa>
          putc(fd, *s);
    1469:	0f be d2             	movsbl %dl,%edx
    146c:	8b 45 08             	mov    0x8(%ebp),%eax
    146f:	e8 64 fe ff ff       	call   12d8 <putc>
          s++;
    1474:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1477:	0f b6 16             	movzbl (%esi),%edx
    147a:	84 d2                	test   %dl,%dl
    147c:	75 eb                	jne    1469 <printf+0xec>
      state = 0;
    147e:	be 00 00 00 00       	mov    $0x0,%esi
    1483:	e9 21 ff ff ff       	jmp    13a9 <printf+0x2c>
        putc(fd, *ap);
    1488:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    148b:	0f be 17             	movsbl (%edi),%edx
    148e:	8b 45 08             	mov    0x8(%ebp),%eax
    1491:	e8 42 fe ff ff       	call   12d8 <putc>
        ap++;
    1496:	83 c7 04             	add    $0x4,%edi
    1499:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    149c:	be 00 00 00 00       	mov    $0x0,%esi
    14a1:	e9 03 ff ff ff       	jmp    13a9 <printf+0x2c>
        putc(fd, c);
    14a6:	89 fa                	mov    %edi,%edx
    14a8:	8b 45 08             	mov    0x8(%ebp),%eax
    14ab:	e8 28 fe ff ff       	call   12d8 <putc>
      state = 0;
    14b0:	be 00 00 00 00       	mov    $0x0,%esi
    14b5:	e9 ef fe ff ff       	jmp    13a9 <printf+0x2c>
        putc(fd, '%');
    14ba:	ba 25 00 00 00       	mov    $0x25,%edx
    14bf:	8b 45 08             	mov    0x8(%ebp),%eax
    14c2:	e8 11 fe ff ff       	call   12d8 <putc>
        putc(fd, c);
    14c7:	89 fa                	mov    %edi,%edx
    14c9:	8b 45 08             	mov    0x8(%ebp),%eax
    14cc:	e8 07 fe ff ff       	call   12d8 <putc>
      state = 0;
    14d1:	be 00 00 00 00       	mov    $0x0,%esi
    14d6:	e9 ce fe ff ff       	jmp    13a9 <printf+0x2c>
    }
  }
}
    14db:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14de:	5b                   	pop    %ebx
    14df:	5e                   	pop    %esi
    14e0:	5f                   	pop    %edi
    14e1:	5d                   	pop    %ebp
    14e2:	c3                   	ret    

000014e3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14e3:	55                   	push   %ebp
    14e4:	89 e5                	mov    %esp,%ebp
    14e6:	57                   	push   %edi
    14e7:	56                   	push   %esi
    14e8:	53                   	push   %ebx
    14e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14ec:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14ef:	a1 7c 19 00 00       	mov    0x197c,%eax
    14f4:	eb 02                	jmp    14f8 <free+0x15>
    14f6:	89 d0                	mov    %edx,%eax
    14f8:	39 c8                	cmp    %ecx,%eax
    14fa:	73 04                	jae    1500 <free+0x1d>
    14fc:	39 08                	cmp    %ecx,(%eax)
    14fe:	77 12                	ja     1512 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1500:	8b 10                	mov    (%eax),%edx
    1502:	39 c2                	cmp    %eax,%edx
    1504:	77 f0                	ja     14f6 <free+0x13>
    1506:	39 c8                	cmp    %ecx,%eax
    1508:	72 08                	jb     1512 <free+0x2f>
    150a:	39 ca                	cmp    %ecx,%edx
    150c:	77 04                	ja     1512 <free+0x2f>
    150e:	89 d0                	mov    %edx,%eax
    1510:	eb e6                	jmp    14f8 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1512:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1515:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1518:	8b 10                	mov    (%eax),%edx
    151a:	39 d7                	cmp    %edx,%edi
    151c:	74 19                	je     1537 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    151e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1521:	8b 50 04             	mov    0x4(%eax),%edx
    1524:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1527:	39 ce                	cmp    %ecx,%esi
    1529:	74 1b                	je     1546 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    152b:	89 08                	mov    %ecx,(%eax)
  freep = p;
    152d:	a3 7c 19 00 00       	mov    %eax,0x197c
}
    1532:	5b                   	pop    %ebx
    1533:	5e                   	pop    %esi
    1534:	5f                   	pop    %edi
    1535:	5d                   	pop    %ebp
    1536:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1537:	03 72 04             	add    0x4(%edx),%esi
    153a:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    153d:	8b 10                	mov    (%eax),%edx
    153f:	8b 12                	mov    (%edx),%edx
    1541:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1544:	eb db                	jmp    1521 <free+0x3e>
    p->s.size += bp->s.size;
    1546:	03 53 fc             	add    -0x4(%ebx),%edx
    1549:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    154c:	8b 53 f8             	mov    -0x8(%ebx),%edx
    154f:	89 10                	mov    %edx,(%eax)
    1551:	eb da                	jmp    152d <free+0x4a>

00001553 <morecore>:

static Header*
morecore(uint nu)
{
    1553:	55                   	push   %ebp
    1554:	89 e5                	mov    %esp,%ebp
    1556:	53                   	push   %ebx
    1557:	83 ec 04             	sub    $0x4,%esp
    155a:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    155c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1561:	77 05                	ja     1568 <morecore+0x15>
    nu = 4096;
    1563:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1568:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    156f:	83 ec 0c             	sub    $0xc,%esp
    1572:	50                   	push   %eax
    1573:	e8 28 fd ff ff       	call   12a0 <sbrk>
  if(p == (char*)-1)
    1578:	83 c4 10             	add    $0x10,%esp
    157b:	83 f8 ff             	cmp    $0xffffffff,%eax
    157e:	74 1c                	je     159c <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1580:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1583:	83 c0 08             	add    $0x8,%eax
    1586:	83 ec 0c             	sub    $0xc,%esp
    1589:	50                   	push   %eax
    158a:	e8 54 ff ff ff       	call   14e3 <free>
  return freep;
    158f:	a1 7c 19 00 00       	mov    0x197c,%eax
    1594:	83 c4 10             	add    $0x10,%esp
}
    1597:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    159a:	c9                   	leave  
    159b:	c3                   	ret    
    return 0;
    159c:	b8 00 00 00 00       	mov    $0x0,%eax
    15a1:	eb f4                	jmp    1597 <morecore+0x44>

000015a3 <malloc>:

void*
malloc(uint nbytes)
{
    15a3:	55                   	push   %ebp
    15a4:	89 e5                	mov    %esp,%ebp
    15a6:	53                   	push   %ebx
    15a7:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15aa:	8b 45 08             	mov    0x8(%ebp),%eax
    15ad:	8d 58 07             	lea    0x7(%eax),%ebx
    15b0:	c1 eb 03             	shr    $0x3,%ebx
    15b3:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    15b6:	8b 0d 7c 19 00 00    	mov    0x197c,%ecx
    15bc:	85 c9                	test   %ecx,%ecx
    15be:	74 04                	je     15c4 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15c0:	8b 01                	mov    (%ecx),%eax
    15c2:	eb 4a                	jmp    160e <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15c4:	c7 05 7c 19 00 00 80 	movl   $0x1980,0x197c
    15cb:	19 00 00 
    15ce:	c7 05 80 19 00 00 80 	movl   $0x1980,0x1980
    15d5:	19 00 00 
    base.s.size = 0;
    15d8:	c7 05 84 19 00 00 00 	movl   $0x0,0x1984
    15df:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15e2:	b9 80 19 00 00       	mov    $0x1980,%ecx
    15e7:	eb d7                	jmp    15c0 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15e9:	74 19                	je     1604 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15eb:	29 da                	sub    %ebx,%edx
    15ed:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15f0:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15f3:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15f6:	89 0d 7c 19 00 00    	mov    %ecx,0x197c
      return (void*)(p + 1);
    15fc:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1602:	c9                   	leave  
    1603:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1604:	8b 10                	mov    (%eax),%edx
    1606:	89 11                	mov    %edx,(%ecx)
    1608:	eb ec                	jmp    15f6 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    160a:	89 c1                	mov    %eax,%ecx
    160c:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    160e:	8b 50 04             	mov    0x4(%eax),%edx
    1611:	39 da                	cmp    %ebx,%edx
    1613:	73 d4                	jae    15e9 <malloc+0x46>
    if(p == freep)
    1615:	39 05 7c 19 00 00    	cmp    %eax,0x197c
    161b:	75 ed                	jne    160a <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    161d:	89 d8                	mov    %ebx,%eax
    161f:	e8 2f ff ff ff       	call   1553 <morecore>
    1624:	85 c0                	test   %eax,%eax
    1626:	75 e2                	jne    160a <malloc+0x67>
    1628:	eb d5                	jmp    15ff <malloc+0x5c>
