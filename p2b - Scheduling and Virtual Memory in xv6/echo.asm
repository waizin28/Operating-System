
_echo:     file format elf32-i386


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
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 08             	sub    $0x8,%esp
    1014:	8b 31                	mov    (%ecx),%esi
    1016:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
    1019:	b8 01 00 00 00       	mov    $0x1,%eax
    101e:	eb 1a                	jmp    103a <main+0x3a>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    1020:	ba 06 16 00 00       	mov    $0x1606,%edx
    1025:	52                   	push   %edx
    1026:	ff 34 87             	push   (%edi,%eax,4)
    1029:	68 08 16 00 00       	push   $0x1608
    102e:	6a 01                	push   $0x1
    1030:	e8 20 03 00 00       	call   1355 <printf>
    1035:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
    1038:	89 d8                	mov    %ebx,%eax
    103a:	39 f0                	cmp    %esi,%eax
    103c:	7d 0e                	jge    104c <main+0x4c>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    103e:	8d 58 01             	lea    0x1(%eax),%ebx
    1041:	39 f3                	cmp    %esi,%ebx
    1043:	7d db                	jge    1020 <main+0x20>
    1045:	ba 04 16 00 00       	mov    $0x1604,%edx
    104a:	eb d9                	jmp    1025 <main+0x25>
  exit();
    104c:	e8 9f 01 00 00       	call   11f0 <exit>

00001051 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	56                   	push   %esi
    1055:	53                   	push   %ebx
    1056:	8b 75 08             	mov    0x8(%ebp),%esi
    1059:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    105c:	89 f0                	mov    %esi,%eax
    105e:	89 d1                	mov    %edx,%ecx
    1060:	83 c2 01             	add    $0x1,%edx
    1063:	89 c3                	mov    %eax,%ebx
    1065:	83 c0 01             	add    $0x1,%eax
    1068:	0f b6 09             	movzbl (%ecx),%ecx
    106b:	88 0b                	mov    %cl,(%ebx)
    106d:	84 c9                	test   %cl,%cl
    106f:	75 ed                	jne    105e <strcpy+0xd>
    ;
  return os;
}
    1071:	89 f0                	mov    %esi,%eax
    1073:	5b                   	pop    %ebx
    1074:	5e                   	pop    %esi
    1075:	5d                   	pop    %ebp
    1076:	c3                   	ret    

00001077 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1077:	55                   	push   %ebp
    1078:	89 e5                	mov    %esp,%ebp
    107a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    107d:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1080:	eb 06                	jmp    1088 <strcmp+0x11>
    p++, q++;
    1082:	83 c1 01             	add    $0x1,%ecx
    1085:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1088:	0f b6 01             	movzbl (%ecx),%eax
    108b:	84 c0                	test   %al,%al
    108d:	74 04                	je     1093 <strcmp+0x1c>
    108f:	3a 02                	cmp    (%edx),%al
    1091:	74 ef                	je     1082 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1093:	0f b6 c0             	movzbl %al,%eax
    1096:	0f b6 12             	movzbl (%edx),%edx
    1099:	29 d0                	sub    %edx,%eax
}
    109b:	5d                   	pop    %ebp
    109c:	c3                   	ret    

0000109d <strlen>:

uint
strlen(const char *s)
{
    109d:	55                   	push   %ebp
    109e:	89 e5                	mov    %esp,%ebp
    10a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10a3:	b8 00 00 00 00       	mov    $0x0,%eax
    10a8:	eb 03                	jmp    10ad <strlen+0x10>
    10aa:	83 c0 01             	add    $0x1,%eax
    10ad:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10b1:	75 f7                	jne    10aa <strlen+0xd>
    ;
  return n;
}
    10b3:	5d                   	pop    %ebp
    10b4:	c3                   	ret    

000010b5 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10b5:	55                   	push   %ebp
    10b6:	89 e5                	mov    %esp,%ebp
    10b8:	57                   	push   %edi
    10b9:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10bc:	89 d7                	mov    %edx,%edi
    10be:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c4:	fc                   	cld    
    10c5:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c7:	89 d0                	mov    %edx,%eax
    10c9:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10cc:	c9                   	leave  
    10cd:	c3                   	ret    

000010ce <strchr>:

char*
strchr(const char *s, char c)
{
    10ce:	55                   	push   %ebp
    10cf:	89 e5                	mov    %esp,%ebp
    10d1:	8b 45 08             	mov    0x8(%ebp),%eax
    10d4:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10d8:	eb 03                	jmp    10dd <strchr+0xf>
    10da:	83 c0 01             	add    $0x1,%eax
    10dd:	0f b6 10             	movzbl (%eax),%edx
    10e0:	84 d2                	test   %dl,%dl
    10e2:	74 06                	je     10ea <strchr+0x1c>
    if(*s == c)
    10e4:	38 ca                	cmp    %cl,%dl
    10e6:	75 f2                	jne    10da <strchr+0xc>
    10e8:	eb 05                	jmp    10ef <strchr+0x21>
      return (char*)s;
  return 0;
    10ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10ef:	5d                   	pop    %ebp
    10f0:	c3                   	ret    

000010f1 <gets>:

char*
gets(char *buf, int max)
{
    10f1:	55                   	push   %ebp
    10f2:	89 e5                	mov    %esp,%ebp
    10f4:	57                   	push   %edi
    10f5:	56                   	push   %esi
    10f6:	53                   	push   %ebx
    10f7:	83 ec 1c             	sub    $0x1c,%esp
    10fa:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10fd:	bb 00 00 00 00       	mov    $0x0,%ebx
    1102:	89 de                	mov    %ebx,%esi
    1104:	83 c3 01             	add    $0x1,%ebx
    1107:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    110a:	7d 2e                	jge    113a <gets+0x49>
    cc = read(0, &c, 1);
    110c:	83 ec 04             	sub    $0x4,%esp
    110f:	6a 01                	push   $0x1
    1111:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1114:	50                   	push   %eax
    1115:	6a 00                	push   $0x0
    1117:	e8 ec 00 00 00       	call   1208 <read>
    if(cc < 1)
    111c:	83 c4 10             	add    $0x10,%esp
    111f:	85 c0                	test   %eax,%eax
    1121:	7e 17                	jle    113a <gets+0x49>
      break;
    buf[i++] = c;
    1123:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1127:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    112a:	3c 0a                	cmp    $0xa,%al
    112c:	0f 94 c2             	sete   %dl
    112f:	3c 0d                	cmp    $0xd,%al
    1131:	0f 94 c0             	sete   %al
    1134:	08 c2                	or     %al,%dl
    1136:	74 ca                	je     1102 <gets+0x11>
    buf[i++] = c;
    1138:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    113a:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    113e:	89 f8                	mov    %edi,%eax
    1140:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1143:	5b                   	pop    %ebx
    1144:	5e                   	pop    %esi
    1145:	5f                   	pop    %edi
    1146:	5d                   	pop    %ebp
    1147:	c3                   	ret    

00001148 <stat>:

int
stat(const char *n, struct stat *st)
{
    1148:	55                   	push   %ebp
    1149:	89 e5                	mov    %esp,%ebp
    114b:	56                   	push   %esi
    114c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    114d:	83 ec 08             	sub    $0x8,%esp
    1150:	6a 00                	push   $0x0
    1152:	ff 75 08             	push   0x8(%ebp)
    1155:	e8 d6 00 00 00       	call   1230 <open>
  if(fd < 0)
    115a:	83 c4 10             	add    $0x10,%esp
    115d:	85 c0                	test   %eax,%eax
    115f:	78 24                	js     1185 <stat+0x3d>
    1161:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1163:	83 ec 08             	sub    $0x8,%esp
    1166:	ff 75 0c             	push   0xc(%ebp)
    1169:	50                   	push   %eax
    116a:	e8 d9 00 00 00       	call   1248 <fstat>
    116f:	89 c6                	mov    %eax,%esi
  close(fd);
    1171:	89 1c 24             	mov    %ebx,(%esp)
    1174:	e8 9f 00 00 00       	call   1218 <close>
  return r;
    1179:	83 c4 10             	add    $0x10,%esp
}
    117c:	89 f0                	mov    %esi,%eax
    117e:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1181:	5b                   	pop    %ebx
    1182:	5e                   	pop    %esi
    1183:	5d                   	pop    %ebp
    1184:	c3                   	ret    
    return -1;
    1185:	be ff ff ff ff       	mov    $0xffffffff,%esi
    118a:	eb f0                	jmp    117c <stat+0x34>

0000118c <atoi>:

int
atoi(const char *s)
{
    118c:	55                   	push   %ebp
    118d:	89 e5                	mov    %esp,%ebp
    118f:	53                   	push   %ebx
    1190:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1193:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1198:	eb 10                	jmp    11aa <atoi+0x1e>
    n = n*10 + *s++ - '0';
    119a:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    119d:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11a0:	83 c1 01             	add    $0x1,%ecx
    11a3:	0f be c0             	movsbl %al,%eax
    11a6:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11aa:	0f b6 01             	movzbl (%ecx),%eax
    11ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11b0:	80 fb 09             	cmp    $0x9,%bl
    11b3:	76 e5                	jbe    119a <atoi+0xe>
  return n;
}
    11b5:	89 d0                	mov    %edx,%eax
    11b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ba:	c9                   	leave  
    11bb:	c3                   	ret    

000011bc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11bc:	55                   	push   %ebp
    11bd:	89 e5                	mov    %esp,%ebp
    11bf:	56                   	push   %esi
    11c0:	53                   	push   %ebx
    11c1:	8b 75 08             	mov    0x8(%ebp),%esi
    11c4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11c7:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11ca:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11cc:	eb 0d                	jmp    11db <memmove+0x1f>
    *dst++ = *src++;
    11ce:	0f b6 01             	movzbl (%ecx),%eax
    11d1:	88 02                	mov    %al,(%edx)
    11d3:	8d 49 01             	lea    0x1(%ecx),%ecx
    11d6:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11d9:	89 d8                	mov    %ebx,%eax
    11db:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11de:	85 c0                	test   %eax,%eax
    11e0:	7f ec                	jg     11ce <memmove+0x12>
  return vdst;
}
    11e2:	89 f0                	mov    %esi,%eax
    11e4:	5b                   	pop    %ebx
    11e5:	5e                   	pop    %esi
    11e6:	5d                   	pop    %ebp
    11e7:	c3                   	ret    

000011e8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11e8:	b8 01 00 00 00       	mov    $0x1,%eax
    11ed:	cd 40                	int    $0x40
    11ef:	c3                   	ret    

000011f0 <exit>:
SYSCALL(exit)
    11f0:	b8 02 00 00 00       	mov    $0x2,%eax
    11f5:	cd 40                	int    $0x40
    11f7:	c3                   	ret    

000011f8 <wait>:
SYSCALL(wait)
    11f8:	b8 03 00 00 00       	mov    $0x3,%eax
    11fd:	cd 40                	int    $0x40
    11ff:	c3                   	ret    

00001200 <pipe>:
SYSCALL(pipe)
    1200:	b8 04 00 00 00       	mov    $0x4,%eax
    1205:	cd 40                	int    $0x40
    1207:	c3                   	ret    

00001208 <read>:
SYSCALL(read)
    1208:	b8 05 00 00 00       	mov    $0x5,%eax
    120d:	cd 40                	int    $0x40
    120f:	c3                   	ret    

00001210 <write>:
SYSCALL(write)
    1210:	b8 10 00 00 00       	mov    $0x10,%eax
    1215:	cd 40                	int    $0x40
    1217:	c3                   	ret    

00001218 <close>:
SYSCALL(close)
    1218:	b8 15 00 00 00       	mov    $0x15,%eax
    121d:	cd 40                	int    $0x40
    121f:	c3                   	ret    

00001220 <kill>:
SYSCALL(kill)
    1220:	b8 06 00 00 00       	mov    $0x6,%eax
    1225:	cd 40                	int    $0x40
    1227:	c3                   	ret    

00001228 <exec>:
SYSCALL(exec)
    1228:	b8 07 00 00 00       	mov    $0x7,%eax
    122d:	cd 40                	int    $0x40
    122f:	c3                   	ret    

00001230 <open>:
SYSCALL(open)
    1230:	b8 0f 00 00 00       	mov    $0xf,%eax
    1235:	cd 40                	int    $0x40
    1237:	c3                   	ret    

00001238 <mknod>:
SYSCALL(mknod)
    1238:	b8 11 00 00 00       	mov    $0x11,%eax
    123d:	cd 40                	int    $0x40
    123f:	c3                   	ret    

00001240 <unlink>:
SYSCALL(unlink)
    1240:	b8 12 00 00 00       	mov    $0x12,%eax
    1245:	cd 40                	int    $0x40
    1247:	c3                   	ret    

00001248 <fstat>:
SYSCALL(fstat)
    1248:	b8 08 00 00 00       	mov    $0x8,%eax
    124d:	cd 40                	int    $0x40
    124f:	c3                   	ret    

00001250 <link>:
SYSCALL(link)
    1250:	b8 13 00 00 00       	mov    $0x13,%eax
    1255:	cd 40                	int    $0x40
    1257:	c3                   	ret    

00001258 <mkdir>:
SYSCALL(mkdir)
    1258:	b8 14 00 00 00       	mov    $0x14,%eax
    125d:	cd 40                	int    $0x40
    125f:	c3                   	ret    

00001260 <chdir>:
SYSCALL(chdir)
    1260:	b8 09 00 00 00       	mov    $0x9,%eax
    1265:	cd 40                	int    $0x40
    1267:	c3                   	ret    

00001268 <dup>:
SYSCALL(dup)
    1268:	b8 0a 00 00 00       	mov    $0xa,%eax
    126d:	cd 40                	int    $0x40
    126f:	c3                   	ret    

00001270 <getpid>:
SYSCALL(getpid)
    1270:	b8 0b 00 00 00       	mov    $0xb,%eax
    1275:	cd 40                	int    $0x40
    1277:	c3                   	ret    

00001278 <sbrk>:
SYSCALL(sbrk)
    1278:	b8 0c 00 00 00       	mov    $0xc,%eax
    127d:	cd 40                	int    $0x40
    127f:	c3                   	ret    

00001280 <sleep>:
SYSCALL(sleep)
    1280:	b8 0d 00 00 00       	mov    $0xd,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <uptime>:
SYSCALL(uptime)
    1288:	b8 0e 00 00 00       	mov    $0xe,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <settickets>:
SYSCALL(settickets)
    1290:	b8 16 00 00 00       	mov    $0x16,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <getpinfo>:
SYSCALL(getpinfo)
    1298:	b8 17 00 00 00       	mov    $0x17,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <mprotect>:
SYSCALL(mprotect)
    12a0:	b8 18 00 00 00       	mov    $0x18,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <munprotect>:
    12a8:	b8 19 00 00 00       	mov    $0x19,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	83 ec 1c             	sub    $0x1c,%esp
    12b6:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12b9:	6a 01                	push   $0x1
    12bb:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12be:	52                   	push   %edx
    12bf:	50                   	push   %eax
    12c0:	e8 4b ff ff ff       	call   1210 <write>
}
    12c5:	83 c4 10             	add    $0x10,%esp
    12c8:	c9                   	leave  
    12c9:	c3                   	ret    

000012ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12ca:	55                   	push   %ebp
    12cb:	89 e5                	mov    %esp,%ebp
    12cd:	57                   	push   %edi
    12ce:	56                   	push   %esi
    12cf:	53                   	push   %ebx
    12d0:	83 ec 2c             	sub    $0x2c,%esp
    12d3:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12d6:	89 d0                	mov    %edx,%eax
    12d8:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12de:	0f 95 c1             	setne  %cl
    12e1:	c1 ea 1f             	shr    $0x1f,%edx
    12e4:	84 d1                	test   %dl,%cl
    12e6:	74 44                	je     132c <printint+0x62>
    neg = 1;
    x = -xx;
    12e8:	f7 d8                	neg    %eax
    12ea:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12ec:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12f3:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12f8:	89 c8                	mov    %ecx,%eax
    12fa:	ba 00 00 00 00       	mov    $0x0,%edx
    12ff:	f7 f6                	div    %esi
    1301:	89 df                	mov    %ebx,%edi
    1303:	83 c3 01             	add    $0x1,%ebx
    1306:	0f b6 92 6c 16 00 00 	movzbl 0x166c(%edx),%edx
    130d:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1311:	89 ca                	mov    %ecx,%edx
    1313:	89 c1                	mov    %eax,%ecx
    1315:	39 d6                	cmp    %edx,%esi
    1317:	76 df                	jbe    12f8 <printint+0x2e>
  if(neg)
    1319:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    131d:	74 31                	je     1350 <printint+0x86>
    buf[i++] = '-';
    131f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1324:	8d 5f 02             	lea    0x2(%edi),%ebx
    1327:	8b 75 d0             	mov    -0x30(%ebp),%esi
    132a:	eb 17                	jmp    1343 <printint+0x79>
    x = xx;
    132c:	89 c1                	mov    %eax,%ecx
  neg = 0;
    132e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1335:	eb bc                	jmp    12f3 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1337:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    133c:	89 f0                	mov    %esi,%eax
    133e:	e8 6d ff ff ff       	call   12b0 <putc>
  while(--i >= 0)
    1343:	83 eb 01             	sub    $0x1,%ebx
    1346:	79 ef                	jns    1337 <printint+0x6d>
}
    1348:	83 c4 2c             	add    $0x2c,%esp
    134b:	5b                   	pop    %ebx
    134c:	5e                   	pop    %esi
    134d:	5f                   	pop    %edi
    134e:	5d                   	pop    %ebp
    134f:	c3                   	ret    
    1350:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1353:	eb ee                	jmp    1343 <printint+0x79>

00001355 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1355:	55                   	push   %ebp
    1356:	89 e5                	mov    %esp,%ebp
    1358:	57                   	push   %edi
    1359:	56                   	push   %esi
    135a:	53                   	push   %ebx
    135b:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    135e:	8d 45 10             	lea    0x10(%ebp),%eax
    1361:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1364:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1369:	bb 00 00 00 00       	mov    $0x0,%ebx
    136e:	eb 14                	jmp    1384 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1370:	89 fa                	mov    %edi,%edx
    1372:	8b 45 08             	mov    0x8(%ebp),%eax
    1375:	e8 36 ff ff ff       	call   12b0 <putc>
    137a:	eb 05                	jmp    1381 <printf+0x2c>
      }
    } else if(state == '%'){
    137c:	83 fe 25             	cmp    $0x25,%esi
    137f:	74 25                	je     13a6 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1381:	83 c3 01             	add    $0x1,%ebx
    1384:	8b 45 0c             	mov    0xc(%ebp),%eax
    1387:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    138b:	84 c0                	test   %al,%al
    138d:	0f 84 20 01 00 00    	je     14b3 <printf+0x15e>
    c = fmt[i] & 0xff;
    1393:	0f be f8             	movsbl %al,%edi
    1396:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1399:	85 f6                	test   %esi,%esi
    139b:	75 df                	jne    137c <printf+0x27>
      if(c == '%'){
    139d:	83 f8 25             	cmp    $0x25,%eax
    13a0:	75 ce                	jne    1370 <printf+0x1b>
        state = '%';
    13a2:	89 c6                	mov    %eax,%esi
    13a4:	eb db                	jmp    1381 <printf+0x2c>
      if(c == 'd'){
    13a6:	83 f8 25             	cmp    $0x25,%eax
    13a9:	0f 84 cf 00 00 00    	je     147e <printf+0x129>
    13af:	0f 8c dd 00 00 00    	jl     1492 <printf+0x13d>
    13b5:	83 f8 78             	cmp    $0x78,%eax
    13b8:	0f 8f d4 00 00 00    	jg     1492 <printf+0x13d>
    13be:	83 f8 63             	cmp    $0x63,%eax
    13c1:	0f 8c cb 00 00 00    	jl     1492 <printf+0x13d>
    13c7:	83 e8 63             	sub    $0x63,%eax
    13ca:	83 f8 15             	cmp    $0x15,%eax
    13cd:	0f 87 bf 00 00 00    	ja     1492 <printf+0x13d>
    13d3:	ff 24 85 14 16 00 00 	jmp    *0x1614(,%eax,4)
        printint(fd, *ap, 10, 1);
    13da:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13dd:	8b 17                	mov    (%edi),%edx
    13df:	83 ec 0c             	sub    $0xc,%esp
    13e2:	6a 01                	push   $0x1
    13e4:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13e9:	8b 45 08             	mov    0x8(%ebp),%eax
    13ec:	e8 d9 fe ff ff       	call   12ca <printint>
        ap++;
    13f1:	83 c7 04             	add    $0x4,%edi
    13f4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13f7:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13fa:	be 00 00 00 00       	mov    $0x0,%esi
    13ff:	eb 80                	jmp    1381 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1401:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1404:	8b 17                	mov    (%edi),%edx
    1406:	83 ec 0c             	sub    $0xc,%esp
    1409:	6a 00                	push   $0x0
    140b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1410:	8b 45 08             	mov    0x8(%ebp),%eax
    1413:	e8 b2 fe ff ff       	call   12ca <printint>
        ap++;
    1418:	83 c7 04             	add    $0x4,%edi
    141b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    141e:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1421:	be 00 00 00 00       	mov    $0x0,%esi
    1426:	e9 56 ff ff ff       	jmp    1381 <printf+0x2c>
        s = (char*)*ap;
    142b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    142e:	8b 30                	mov    (%eax),%esi
        ap++;
    1430:	83 c0 04             	add    $0x4,%eax
    1433:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1436:	85 f6                	test   %esi,%esi
    1438:	75 15                	jne    144f <printf+0xfa>
          s = "(null)";
    143a:	be 0d 16 00 00       	mov    $0x160d,%esi
    143f:	eb 0e                	jmp    144f <printf+0xfa>
          putc(fd, *s);
    1441:	0f be d2             	movsbl %dl,%edx
    1444:	8b 45 08             	mov    0x8(%ebp),%eax
    1447:	e8 64 fe ff ff       	call   12b0 <putc>
          s++;
    144c:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    144f:	0f b6 16             	movzbl (%esi),%edx
    1452:	84 d2                	test   %dl,%dl
    1454:	75 eb                	jne    1441 <printf+0xec>
      state = 0;
    1456:	be 00 00 00 00       	mov    $0x0,%esi
    145b:	e9 21 ff ff ff       	jmp    1381 <printf+0x2c>
        putc(fd, *ap);
    1460:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1463:	0f be 17             	movsbl (%edi),%edx
    1466:	8b 45 08             	mov    0x8(%ebp),%eax
    1469:	e8 42 fe ff ff       	call   12b0 <putc>
        ap++;
    146e:	83 c7 04             	add    $0x4,%edi
    1471:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1474:	be 00 00 00 00       	mov    $0x0,%esi
    1479:	e9 03 ff ff ff       	jmp    1381 <printf+0x2c>
        putc(fd, c);
    147e:	89 fa                	mov    %edi,%edx
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
    1483:	e8 28 fe ff ff       	call   12b0 <putc>
      state = 0;
    1488:	be 00 00 00 00       	mov    $0x0,%esi
    148d:	e9 ef fe ff ff       	jmp    1381 <printf+0x2c>
        putc(fd, '%');
    1492:	ba 25 00 00 00       	mov    $0x25,%edx
    1497:	8b 45 08             	mov    0x8(%ebp),%eax
    149a:	e8 11 fe ff ff       	call   12b0 <putc>
        putc(fd, c);
    149f:	89 fa                	mov    %edi,%edx
    14a1:	8b 45 08             	mov    0x8(%ebp),%eax
    14a4:	e8 07 fe ff ff       	call   12b0 <putc>
      state = 0;
    14a9:	be 00 00 00 00       	mov    $0x0,%esi
    14ae:	e9 ce fe ff ff       	jmp    1381 <printf+0x2c>
    }
  }
}
    14b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b6:	5b                   	pop    %ebx
    14b7:	5e                   	pop    %esi
    14b8:	5f                   	pop    %edi
    14b9:	5d                   	pop    %ebp
    14ba:	c3                   	ret    

000014bb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14bb:	55                   	push   %ebp
    14bc:	89 e5                	mov    %esp,%ebp
    14be:	57                   	push   %edi
    14bf:	56                   	push   %esi
    14c0:	53                   	push   %ebx
    14c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14c4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c7:	a1 18 19 00 00       	mov    0x1918,%eax
    14cc:	eb 02                	jmp    14d0 <free+0x15>
    14ce:	89 d0                	mov    %edx,%eax
    14d0:	39 c8                	cmp    %ecx,%eax
    14d2:	73 04                	jae    14d8 <free+0x1d>
    14d4:	39 08                	cmp    %ecx,(%eax)
    14d6:	77 12                	ja     14ea <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d8:	8b 10                	mov    (%eax),%edx
    14da:	39 c2                	cmp    %eax,%edx
    14dc:	77 f0                	ja     14ce <free+0x13>
    14de:	39 c8                	cmp    %ecx,%eax
    14e0:	72 08                	jb     14ea <free+0x2f>
    14e2:	39 ca                	cmp    %ecx,%edx
    14e4:	77 04                	ja     14ea <free+0x2f>
    14e6:	89 d0                	mov    %edx,%eax
    14e8:	eb e6                	jmp    14d0 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14ea:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14ed:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14f0:	8b 10                	mov    (%eax),%edx
    14f2:	39 d7                	cmp    %edx,%edi
    14f4:	74 19                	je     150f <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14f9:	8b 50 04             	mov    0x4(%eax),%edx
    14fc:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14ff:	39 ce                	cmp    %ecx,%esi
    1501:	74 1b                	je     151e <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1503:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1505:	a3 18 19 00 00       	mov    %eax,0x1918
}
    150a:	5b                   	pop    %ebx
    150b:	5e                   	pop    %esi
    150c:	5f                   	pop    %edi
    150d:	5d                   	pop    %ebp
    150e:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    150f:	03 72 04             	add    0x4(%edx),%esi
    1512:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1515:	8b 10                	mov    (%eax),%edx
    1517:	8b 12                	mov    (%edx),%edx
    1519:	89 53 f8             	mov    %edx,-0x8(%ebx)
    151c:	eb db                	jmp    14f9 <free+0x3e>
    p->s.size += bp->s.size;
    151e:	03 53 fc             	add    -0x4(%ebx),%edx
    1521:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1524:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1527:	89 10                	mov    %edx,(%eax)
    1529:	eb da                	jmp    1505 <free+0x4a>

0000152b <morecore>:

static Header*
morecore(uint nu)
{
    152b:	55                   	push   %ebp
    152c:	89 e5                	mov    %esp,%ebp
    152e:	53                   	push   %ebx
    152f:	83 ec 04             	sub    $0x4,%esp
    1532:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1534:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1539:	77 05                	ja     1540 <morecore+0x15>
    nu = 4096;
    153b:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1540:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1547:	83 ec 0c             	sub    $0xc,%esp
    154a:	50                   	push   %eax
    154b:	e8 28 fd ff ff       	call   1278 <sbrk>
  if(p == (char*)-1)
    1550:	83 c4 10             	add    $0x10,%esp
    1553:	83 f8 ff             	cmp    $0xffffffff,%eax
    1556:	74 1c                	je     1574 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1558:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    155b:	83 c0 08             	add    $0x8,%eax
    155e:	83 ec 0c             	sub    $0xc,%esp
    1561:	50                   	push   %eax
    1562:	e8 54 ff ff ff       	call   14bb <free>
  return freep;
    1567:	a1 18 19 00 00       	mov    0x1918,%eax
    156c:	83 c4 10             	add    $0x10,%esp
}
    156f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1572:	c9                   	leave  
    1573:	c3                   	ret    
    return 0;
    1574:	b8 00 00 00 00       	mov    $0x0,%eax
    1579:	eb f4                	jmp    156f <morecore+0x44>

0000157b <malloc>:

void*
malloc(uint nbytes)
{
    157b:	55                   	push   %ebp
    157c:	89 e5                	mov    %esp,%ebp
    157e:	53                   	push   %ebx
    157f:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1582:	8b 45 08             	mov    0x8(%ebp),%eax
    1585:	8d 58 07             	lea    0x7(%eax),%ebx
    1588:	c1 eb 03             	shr    $0x3,%ebx
    158b:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    158e:	8b 0d 18 19 00 00    	mov    0x1918,%ecx
    1594:	85 c9                	test   %ecx,%ecx
    1596:	74 04                	je     159c <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1598:	8b 01                	mov    (%ecx),%eax
    159a:	eb 4a                	jmp    15e6 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    159c:	c7 05 18 19 00 00 1c 	movl   $0x191c,0x1918
    15a3:	19 00 00 
    15a6:	c7 05 1c 19 00 00 1c 	movl   $0x191c,0x191c
    15ad:	19 00 00 
    base.s.size = 0;
    15b0:	c7 05 20 19 00 00 00 	movl   $0x0,0x1920
    15b7:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15ba:	b9 1c 19 00 00       	mov    $0x191c,%ecx
    15bf:	eb d7                	jmp    1598 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15c1:	74 19                	je     15dc <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15c3:	29 da                	sub    %ebx,%edx
    15c5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15c8:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15cb:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15ce:	89 0d 18 19 00 00    	mov    %ecx,0x1918
      return (void*)(p + 1);
    15d4:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15da:	c9                   	leave  
    15db:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15dc:	8b 10                	mov    (%eax),%edx
    15de:	89 11                	mov    %edx,(%ecx)
    15e0:	eb ec                	jmp    15ce <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15e2:	89 c1                	mov    %eax,%ecx
    15e4:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15e6:	8b 50 04             	mov    0x4(%eax),%edx
    15e9:	39 da                	cmp    %ebx,%edx
    15eb:	73 d4                	jae    15c1 <malloc+0x46>
    if(p == freep)
    15ed:	39 05 18 19 00 00    	cmp    %eax,0x1918
    15f3:	75 ed                	jne    15e2 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15f5:	89 d8                	mov    %ebx,%eax
    15f7:	e8 2f ff ff ff       	call   152b <morecore>
    15fc:	85 c0                	test   %eax,%eax
    15fe:	75 e2                	jne    15e2 <malloc+0x67>
    1600:	eb d5                	jmp    15d7 <malloc+0x5c>
