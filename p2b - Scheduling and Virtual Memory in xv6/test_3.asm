
_test_3:     file format elf32-i386


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
  if(settickets(0) == 0)
    1011:	6a 00                	push   $0x0
    1013:	e8 71 02 00 00       	call   1289 <settickets>
    1018:	83 c4 10             	add    $0x10,%esp
    101b:	85 c0                	test   %eax,%eax
    101d:	75 17                	jne    1036 <main+0x36>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    101f:	83 ec 08             	sub    $0x8,%esp
    1022:	68 fc 15 00 00       	push   $0x15fc
    1027:	6a 01                	push   $0x1
    1029:	e8 20 03 00 00       	call   134e <printf>
    102e:	83 c4 10             	add    $0x10,%esp
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
  }
   exit();
    1031:	e8 b3 01 00 00       	call   11e9 <exit>
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    1036:	83 ec 08             	sub    $0x8,%esp
    1039:	68 14 16 00 00       	push   $0x1614
    103e:	6a 01                	push   $0x1
    1040:	e8 09 03 00 00       	call   134e <printf>
    1045:	83 c4 10             	add    $0x10,%esp
    1048:	eb e7                	jmp    1031 <main+0x31>

0000104a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    104a:	55                   	push   %ebp
    104b:	89 e5                	mov    %esp,%ebp
    104d:	56                   	push   %esi
    104e:	53                   	push   %ebx
    104f:	8b 75 08             	mov    0x8(%ebp),%esi
    1052:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1055:	89 f0                	mov    %esi,%eax
    1057:	89 d1                	mov    %edx,%ecx
    1059:	83 c2 01             	add    $0x1,%edx
    105c:	89 c3                	mov    %eax,%ebx
    105e:	83 c0 01             	add    $0x1,%eax
    1061:	0f b6 09             	movzbl (%ecx),%ecx
    1064:	88 0b                	mov    %cl,(%ebx)
    1066:	84 c9                	test   %cl,%cl
    1068:	75 ed                	jne    1057 <strcpy+0xd>
    ;
  return os;
}
    106a:	89 f0                	mov    %esi,%eax
    106c:	5b                   	pop    %ebx
    106d:	5e                   	pop    %esi
    106e:	5d                   	pop    %ebp
    106f:	c3                   	ret    

00001070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1076:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1079:	eb 06                	jmp    1081 <strcmp+0x11>
    p++, q++;
    107b:	83 c1 01             	add    $0x1,%ecx
    107e:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1081:	0f b6 01             	movzbl (%ecx),%eax
    1084:	84 c0                	test   %al,%al
    1086:	74 04                	je     108c <strcmp+0x1c>
    1088:	3a 02                	cmp    (%edx),%al
    108a:	74 ef                	je     107b <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    108c:	0f b6 c0             	movzbl %al,%eax
    108f:	0f b6 12             	movzbl (%edx),%edx
    1092:	29 d0                	sub    %edx,%eax
}
    1094:	5d                   	pop    %ebp
    1095:	c3                   	ret    

00001096 <strlen>:

uint
strlen(const char *s)
{
    1096:	55                   	push   %ebp
    1097:	89 e5                	mov    %esp,%ebp
    1099:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    109c:	b8 00 00 00 00       	mov    $0x0,%eax
    10a1:	eb 03                	jmp    10a6 <strlen+0x10>
    10a3:	83 c0 01             	add    $0x1,%eax
    10a6:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10aa:	75 f7                	jne    10a3 <strlen+0xd>
    ;
  return n;
}
    10ac:	5d                   	pop    %ebp
    10ad:	c3                   	ret    

000010ae <memset>:

void*
memset(void *dst, int c, uint n)
{
    10ae:	55                   	push   %ebp
    10af:	89 e5                	mov    %esp,%ebp
    10b1:	57                   	push   %edi
    10b2:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10b5:	89 d7                	mov    %edx,%edi
    10b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    10bd:	fc                   	cld    
    10be:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c0:	89 d0                	mov    %edx,%eax
    10c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10c5:	c9                   	leave  
    10c6:	c3                   	ret    

000010c7 <strchr>:

char*
strchr(const char *s, char c)
{
    10c7:	55                   	push   %ebp
    10c8:	89 e5                	mov    %esp,%ebp
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10d1:	eb 03                	jmp    10d6 <strchr+0xf>
    10d3:	83 c0 01             	add    $0x1,%eax
    10d6:	0f b6 10             	movzbl (%eax),%edx
    10d9:	84 d2                	test   %dl,%dl
    10db:	74 06                	je     10e3 <strchr+0x1c>
    if(*s == c)
    10dd:	38 ca                	cmp    %cl,%dl
    10df:	75 f2                	jne    10d3 <strchr+0xc>
    10e1:	eb 05                	jmp    10e8 <strchr+0x21>
      return (char*)s;
  return 0;
    10e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10e8:	5d                   	pop    %ebp
    10e9:	c3                   	ret    

000010ea <gets>:

char*
gets(char *buf, int max)
{
    10ea:	55                   	push   %ebp
    10eb:	89 e5                	mov    %esp,%ebp
    10ed:	57                   	push   %edi
    10ee:	56                   	push   %esi
    10ef:	53                   	push   %ebx
    10f0:	83 ec 1c             	sub    $0x1c,%esp
    10f3:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10f6:	bb 00 00 00 00       	mov    $0x0,%ebx
    10fb:	89 de                	mov    %ebx,%esi
    10fd:	83 c3 01             	add    $0x1,%ebx
    1100:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1103:	7d 2e                	jge    1133 <gets+0x49>
    cc = read(0, &c, 1);
    1105:	83 ec 04             	sub    $0x4,%esp
    1108:	6a 01                	push   $0x1
    110a:	8d 45 e7             	lea    -0x19(%ebp),%eax
    110d:	50                   	push   %eax
    110e:	6a 00                	push   $0x0
    1110:	e8 ec 00 00 00       	call   1201 <read>
    if(cc < 1)
    1115:	83 c4 10             	add    $0x10,%esp
    1118:	85 c0                	test   %eax,%eax
    111a:	7e 17                	jle    1133 <gets+0x49>
      break;
    buf[i++] = c;
    111c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1120:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1123:	3c 0a                	cmp    $0xa,%al
    1125:	0f 94 c2             	sete   %dl
    1128:	3c 0d                	cmp    $0xd,%al
    112a:	0f 94 c0             	sete   %al
    112d:	08 c2                	or     %al,%dl
    112f:	74 ca                	je     10fb <gets+0x11>
    buf[i++] = c;
    1131:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1133:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1137:	89 f8                	mov    %edi,%eax
    1139:	8d 65 f4             	lea    -0xc(%ebp),%esp
    113c:	5b                   	pop    %ebx
    113d:	5e                   	pop    %esi
    113e:	5f                   	pop    %edi
    113f:	5d                   	pop    %ebp
    1140:	c3                   	ret    

00001141 <stat>:

int
stat(const char *n, struct stat *st)
{
    1141:	55                   	push   %ebp
    1142:	89 e5                	mov    %esp,%ebp
    1144:	56                   	push   %esi
    1145:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1146:	83 ec 08             	sub    $0x8,%esp
    1149:	6a 00                	push   $0x0
    114b:	ff 75 08             	push   0x8(%ebp)
    114e:	e8 d6 00 00 00       	call   1229 <open>
  if(fd < 0)
    1153:	83 c4 10             	add    $0x10,%esp
    1156:	85 c0                	test   %eax,%eax
    1158:	78 24                	js     117e <stat+0x3d>
    115a:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    115c:	83 ec 08             	sub    $0x8,%esp
    115f:	ff 75 0c             	push   0xc(%ebp)
    1162:	50                   	push   %eax
    1163:	e8 d9 00 00 00       	call   1241 <fstat>
    1168:	89 c6                	mov    %eax,%esi
  close(fd);
    116a:	89 1c 24             	mov    %ebx,(%esp)
    116d:	e8 9f 00 00 00       	call   1211 <close>
  return r;
    1172:	83 c4 10             	add    $0x10,%esp
}
    1175:	89 f0                	mov    %esi,%eax
    1177:	8d 65 f8             	lea    -0x8(%ebp),%esp
    117a:	5b                   	pop    %ebx
    117b:	5e                   	pop    %esi
    117c:	5d                   	pop    %ebp
    117d:	c3                   	ret    
    return -1;
    117e:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1183:	eb f0                	jmp    1175 <stat+0x34>

00001185 <atoi>:

int
atoi(const char *s)
{
    1185:	55                   	push   %ebp
    1186:	89 e5                	mov    %esp,%ebp
    1188:	53                   	push   %ebx
    1189:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    118c:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1191:	eb 10                	jmp    11a3 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1193:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1196:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1199:	83 c1 01             	add    $0x1,%ecx
    119c:	0f be c0             	movsbl %al,%eax
    119f:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11a3:	0f b6 01             	movzbl (%ecx),%eax
    11a6:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11a9:	80 fb 09             	cmp    $0x9,%bl
    11ac:	76 e5                	jbe    1193 <atoi+0xe>
  return n;
}
    11ae:	89 d0                	mov    %edx,%eax
    11b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11b3:	c9                   	leave  
    11b4:	c3                   	ret    

000011b5 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11b5:	55                   	push   %ebp
    11b6:	89 e5                	mov    %esp,%ebp
    11b8:	56                   	push   %esi
    11b9:	53                   	push   %ebx
    11ba:	8b 75 08             	mov    0x8(%ebp),%esi
    11bd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11c0:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11c3:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11c5:	eb 0d                	jmp    11d4 <memmove+0x1f>
    *dst++ = *src++;
    11c7:	0f b6 01             	movzbl (%ecx),%eax
    11ca:	88 02                	mov    %al,(%edx)
    11cc:	8d 49 01             	lea    0x1(%ecx),%ecx
    11cf:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11d2:	89 d8                	mov    %ebx,%eax
    11d4:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11d7:	85 c0                	test   %eax,%eax
    11d9:	7f ec                	jg     11c7 <memmove+0x12>
  return vdst;
}
    11db:	89 f0                	mov    %esi,%eax
    11dd:	5b                   	pop    %ebx
    11de:	5e                   	pop    %esi
    11df:	5d                   	pop    %ebp
    11e0:	c3                   	ret    

000011e1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11e1:	b8 01 00 00 00       	mov    $0x1,%eax
    11e6:	cd 40                	int    $0x40
    11e8:	c3                   	ret    

000011e9 <exit>:
SYSCALL(exit)
    11e9:	b8 02 00 00 00       	mov    $0x2,%eax
    11ee:	cd 40                	int    $0x40
    11f0:	c3                   	ret    

000011f1 <wait>:
SYSCALL(wait)
    11f1:	b8 03 00 00 00       	mov    $0x3,%eax
    11f6:	cd 40                	int    $0x40
    11f8:	c3                   	ret    

000011f9 <pipe>:
SYSCALL(pipe)
    11f9:	b8 04 00 00 00       	mov    $0x4,%eax
    11fe:	cd 40                	int    $0x40
    1200:	c3                   	ret    

00001201 <read>:
SYSCALL(read)
    1201:	b8 05 00 00 00       	mov    $0x5,%eax
    1206:	cd 40                	int    $0x40
    1208:	c3                   	ret    

00001209 <write>:
SYSCALL(write)
    1209:	b8 10 00 00 00       	mov    $0x10,%eax
    120e:	cd 40                	int    $0x40
    1210:	c3                   	ret    

00001211 <close>:
SYSCALL(close)
    1211:	b8 15 00 00 00       	mov    $0x15,%eax
    1216:	cd 40                	int    $0x40
    1218:	c3                   	ret    

00001219 <kill>:
SYSCALL(kill)
    1219:	b8 06 00 00 00       	mov    $0x6,%eax
    121e:	cd 40                	int    $0x40
    1220:	c3                   	ret    

00001221 <exec>:
SYSCALL(exec)
    1221:	b8 07 00 00 00       	mov    $0x7,%eax
    1226:	cd 40                	int    $0x40
    1228:	c3                   	ret    

00001229 <open>:
SYSCALL(open)
    1229:	b8 0f 00 00 00       	mov    $0xf,%eax
    122e:	cd 40                	int    $0x40
    1230:	c3                   	ret    

00001231 <mknod>:
SYSCALL(mknod)
    1231:	b8 11 00 00 00       	mov    $0x11,%eax
    1236:	cd 40                	int    $0x40
    1238:	c3                   	ret    

00001239 <unlink>:
SYSCALL(unlink)
    1239:	b8 12 00 00 00       	mov    $0x12,%eax
    123e:	cd 40                	int    $0x40
    1240:	c3                   	ret    

00001241 <fstat>:
SYSCALL(fstat)
    1241:	b8 08 00 00 00       	mov    $0x8,%eax
    1246:	cd 40                	int    $0x40
    1248:	c3                   	ret    

00001249 <link>:
SYSCALL(link)
    1249:	b8 13 00 00 00       	mov    $0x13,%eax
    124e:	cd 40                	int    $0x40
    1250:	c3                   	ret    

00001251 <mkdir>:
SYSCALL(mkdir)
    1251:	b8 14 00 00 00       	mov    $0x14,%eax
    1256:	cd 40                	int    $0x40
    1258:	c3                   	ret    

00001259 <chdir>:
SYSCALL(chdir)
    1259:	b8 09 00 00 00       	mov    $0x9,%eax
    125e:	cd 40                	int    $0x40
    1260:	c3                   	ret    

00001261 <dup>:
SYSCALL(dup)
    1261:	b8 0a 00 00 00       	mov    $0xa,%eax
    1266:	cd 40                	int    $0x40
    1268:	c3                   	ret    

00001269 <getpid>:
SYSCALL(getpid)
    1269:	b8 0b 00 00 00       	mov    $0xb,%eax
    126e:	cd 40                	int    $0x40
    1270:	c3                   	ret    

00001271 <sbrk>:
SYSCALL(sbrk)
    1271:	b8 0c 00 00 00       	mov    $0xc,%eax
    1276:	cd 40                	int    $0x40
    1278:	c3                   	ret    

00001279 <sleep>:
SYSCALL(sleep)
    1279:	b8 0d 00 00 00       	mov    $0xd,%eax
    127e:	cd 40                	int    $0x40
    1280:	c3                   	ret    

00001281 <uptime>:
SYSCALL(uptime)
    1281:	b8 0e 00 00 00       	mov    $0xe,%eax
    1286:	cd 40                	int    $0x40
    1288:	c3                   	ret    

00001289 <settickets>:
SYSCALL(settickets)
    1289:	b8 16 00 00 00       	mov    $0x16,%eax
    128e:	cd 40                	int    $0x40
    1290:	c3                   	ret    

00001291 <getpinfo>:
SYSCALL(getpinfo)
    1291:	b8 17 00 00 00       	mov    $0x17,%eax
    1296:	cd 40                	int    $0x40
    1298:	c3                   	ret    

00001299 <mprotect>:
SYSCALL(mprotect)
    1299:	b8 18 00 00 00       	mov    $0x18,%eax
    129e:	cd 40                	int    $0x40
    12a0:	c3                   	ret    

000012a1 <munprotect>:
    12a1:	b8 19 00 00 00       	mov    $0x19,%eax
    12a6:	cd 40                	int    $0x40
    12a8:	c3                   	ret    

000012a9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12a9:	55                   	push   %ebp
    12aa:	89 e5                	mov    %esp,%ebp
    12ac:	83 ec 1c             	sub    $0x1c,%esp
    12af:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12b2:	6a 01                	push   $0x1
    12b4:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12b7:	52                   	push   %edx
    12b8:	50                   	push   %eax
    12b9:	e8 4b ff ff ff       	call   1209 <write>
}
    12be:	83 c4 10             	add    $0x10,%esp
    12c1:	c9                   	leave  
    12c2:	c3                   	ret    

000012c3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12c3:	55                   	push   %ebp
    12c4:	89 e5                	mov    %esp,%ebp
    12c6:	57                   	push   %edi
    12c7:	56                   	push   %esi
    12c8:	53                   	push   %ebx
    12c9:	83 ec 2c             	sub    $0x2c,%esp
    12cc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12cf:	89 d0                	mov    %edx,%eax
    12d1:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12d7:	0f 95 c1             	setne  %cl
    12da:	c1 ea 1f             	shr    $0x1f,%edx
    12dd:	84 d1                	test   %dl,%cl
    12df:	74 44                	je     1325 <printint+0x62>
    neg = 1;
    x = -xx;
    12e1:	f7 d8                	neg    %eax
    12e3:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12e5:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12ec:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12f1:	89 c8                	mov    %ecx,%eax
    12f3:	ba 00 00 00 00       	mov    $0x0,%edx
    12f8:	f7 f6                	div    %esi
    12fa:	89 df                	mov    %ebx,%edi
    12fc:	83 c3 01             	add    $0x1,%ebx
    12ff:	0f b6 92 8c 16 00 00 	movzbl 0x168c(%edx),%edx
    1306:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    130a:	89 ca                	mov    %ecx,%edx
    130c:	89 c1                	mov    %eax,%ecx
    130e:	39 d6                	cmp    %edx,%esi
    1310:	76 df                	jbe    12f1 <printint+0x2e>
  if(neg)
    1312:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1316:	74 31                	je     1349 <printint+0x86>
    buf[i++] = '-';
    1318:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    131d:	8d 5f 02             	lea    0x2(%edi),%ebx
    1320:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1323:	eb 17                	jmp    133c <printint+0x79>
    x = xx;
    1325:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1327:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    132e:	eb bc                	jmp    12ec <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1330:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1335:	89 f0                	mov    %esi,%eax
    1337:	e8 6d ff ff ff       	call   12a9 <putc>
  while(--i >= 0)
    133c:	83 eb 01             	sub    $0x1,%ebx
    133f:	79 ef                	jns    1330 <printint+0x6d>
}
    1341:	83 c4 2c             	add    $0x2c,%esp
    1344:	5b                   	pop    %ebx
    1345:	5e                   	pop    %esi
    1346:	5f                   	pop    %edi
    1347:	5d                   	pop    %ebp
    1348:	c3                   	ret    
    1349:	8b 75 d0             	mov    -0x30(%ebp),%esi
    134c:	eb ee                	jmp    133c <printint+0x79>

0000134e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    134e:	55                   	push   %ebp
    134f:	89 e5                	mov    %esp,%ebp
    1351:	57                   	push   %edi
    1352:	56                   	push   %esi
    1353:	53                   	push   %ebx
    1354:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1357:	8d 45 10             	lea    0x10(%ebp),%eax
    135a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    135d:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1362:	bb 00 00 00 00       	mov    $0x0,%ebx
    1367:	eb 14                	jmp    137d <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1369:	89 fa                	mov    %edi,%edx
    136b:	8b 45 08             	mov    0x8(%ebp),%eax
    136e:	e8 36 ff ff ff       	call   12a9 <putc>
    1373:	eb 05                	jmp    137a <printf+0x2c>
      }
    } else if(state == '%'){
    1375:	83 fe 25             	cmp    $0x25,%esi
    1378:	74 25                	je     139f <printf+0x51>
  for(i = 0; fmt[i]; i++){
    137a:	83 c3 01             	add    $0x1,%ebx
    137d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1380:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1384:	84 c0                	test   %al,%al
    1386:	0f 84 20 01 00 00    	je     14ac <printf+0x15e>
    c = fmt[i] & 0xff;
    138c:	0f be f8             	movsbl %al,%edi
    138f:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1392:	85 f6                	test   %esi,%esi
    1394:	75 df                	jne    1375 <printf+0x27>
      if(c == '%'){
    1396:	83 f8 25             	cmp    $0x25,%eax
    1399:	75 ce                	jne    1369 <printf+0x1b>
        state = '%';
    139b:	89 c6                	mov    %eax,%esi
    139d:	eb db                	jmp    137a <printf+0x2c>
      if(c == 'd'){
    139f:	83 f8 25             	cmp    $0x25,%eax
    13a2:	0f 84 cf 00 00 00    	je     1477 <printf+0x129>
    13a8:	0f 8c dd 00 00 00    	jl     148b <printf+0x13d>
    13ae:	83 f8 78             	cmp    $0x78,%eax
    13b1:	0f 8f d4 00 00 00    	jg     148b <printf+0x13d>
    13b7:	83 f8 63             	cmp    $0x63,%eax
    13ba:	0f 8c cb 00 00 00    	jl     148b <printf+0x13d>
    13c0:	83 e8 63             	sub    $0x63,%eax
    13c3:	83 f8 15             	cmp    $0x15,%eax
    13c6:	0f 87 bf 00 00 00    	ja     148b <printf+0x13d>
    13cc:	ff 24 85 34 16 00 00 	jmp    *0x1634(,%eax,4)
        printint(fd, *ap, 10, 1);
    13d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13d6:	8b 17                	mov    (%edi),%edx
    13d8:	83 ec 0c             	sub    $0xc,%esp
    13db:	6a 01                	push   $0x1
    13dd:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13e2:	8b 45 08             	mov    0x8(%ebp),%eax
    13e5:	e8 d9 fe ff ff       	call   12c3 <printint>
        ap++;
    13ea:	83 c7 04             	add    $0x4,%edi
    13ed:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13f0:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13f3:	be 00 00 00 00       	mov    $0x0,%esi
    13f8:	eb 80                	jmp    137a <printf+0x2c>
        printint(fd, *ap, 16, 0);
    13fa:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13fd:	8b 17                	mov    (%edi),%edx
    13ff:	83 ec 0c             	sub    $0xc,%esp
    1402:	6a 00                	push   $0x0
    1404:	b9 10 00 00 00       	mov    $0x10,%ecx
    1409:	8b 45 08             	mov    0x8(%ebp),%eax
    140c:	e8 b2 fe ff ff       	call   12c3 <printint>
        ap++;
    1411:	83 c7 04             	add    $0x4,%edi
    1414:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1417:	83 c4 10             	add    $0x10,%esp
      state = 0;
    141a:	be 00 00 00 00       	mov    $0x0,%esi
    141f:	e9 56 ff ff ff       	jmp    137a <printf+0x2c>
        s = (char*)*ap;
    1424:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1427:	8b 30                	mov    (%eax),%esi
        ap++;
    1429:	83 c0 04             	add    $0x4,%eax
    142c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    142f:	85 f6                	test   %esi,%esi
    1431:	75 15                	jne    1448 <printf+0xfa>
          s = "(null)";
    1433:	be 2b 16 00 00       	mov    $0x162b,%esi
    1438:	eb 0e                	jmp    1448 <printf+0xfa>
          putc(fd, *s);
    143a:	0f be d2             	movsbl %dl,%edx
    143d:	8b 45 08             	mov    0x8(%ebp),%eax
    1440:	e8 64 fe ff ff       	call   12a9 <putc>
          s++;
    1445:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1448:	0f b6 16             	movzbl (%esi),%edx
    144b:	84 d2                	test   %dl,%dl
    144d:	75 eb                	jne    143a <printf+0xec>
      state = 0;
    144f:	be 00 00 00 00       	mov    $0x0,%esi
    1454:	e9 21 ff ff ff       	jmp    137a <printf+0x2c>
        putc(fd, *ap);
    1459:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    145c:	0f be 17             	movsbl (%edi),%edx
    145f:	8b 45 08             	mov    0x8(%ebp),%eax
    1462:	e8 42 fe ff ff       	call   12a9 <putc>
        ap++;
    1467:	83 c7 04             	add    $0x4,%edi
    146a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    146d:	be 00 00 00 00       	mov    $0x0,%esi
    1472:	e9 03 ff ff ff       	jmp    137a <printf+0x2c>
        putc(fd, c);
    1477:	89 fa                	mov    %edi,%edx
    1479:	8b 45 08             	mov    0x8(%ebp),%eax
    147c:	e8 28 fe ff ff       	call   12a9 <putc>
      state = 0;
    1481:	be 00 00 00 00       	mov    $0x0,%esi
    1486:	e9 ef fe ff ff       	jmp    137a <printf+0x2c>
        putc(fd, '%');
    148b:	ba 25 00 00 00       	mov    $0x25,%edx
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
    1493:	e8 11 fe ff ff       	call   12a9 <putc>
        putc(fd, c);
    1498:	89 fa                	mov    %edi,%edx
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	e8 07 fe ff ff       	call   12a9 <putc>
      state = 0;
    14a2:	be 00 00 00 00       	mov    $0x0,%esi
    14a7:	e9 ce fe ff ff       	jmp    137a <printf+0x2c>
    }
  }
}
    14ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14af:	5b                   	pop    %ebx
    14b0:	5e                   	pop    %esi
    14b1:	5f                   	pop    %edi
    14b2:	5d                   	pop    %ebp
    14b3:	c3                   	ret    

000014b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b4:	55                   	push   %ebp
    14b5:	89 e5                	mov    %esp,%ebp
    14b7:	57                   	push   %edi
    14b8:	56                   	push   %esi
    14b9:	53                   	push   %ebx
    14ba:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14bd:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c0:	a1 2c 19 00 00       	mov    0x192c,%eax
    14c5:	eb 02                	jmp    14c9 <free+0x15>
    14c7:	89 d0                	mov    %edx,%eax
    14c9:	39 c8                	cmp    %ecx,%eax
    14cb:	73 04                	jae    14d1 <free+0x1d>
    14cd:	39 08                	cmp    %ecx,(%eax)
    14cf:	77 12                	ja     14e3 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d1:	8b 10                	mov    (%eax),%edx
    14d3:	39 c2                	cmp    %eax,%edx
    14d5:	77 f0                	ja     14c7 <free+0x13>
    14d7:	39 c8                	cmp    %ecx,%eax
    14d9:	72 08                	jb     14e3 <free+0x2f>
    14db:	39 ca                	cmp    %ecx,%edx
    14dd:	77 04                	ja     14e3 <free+0x2f>
    14df:	89 d0                	mov    %edx,%eax
    14e1:	eb e6                	jmp    14c9 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14e3:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14e6:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14e9:	8b 10                	mov    (%eax),%edx
    14eb:	39 d7                	cmp    %edx,%edi
    14ed:	74 19                	je     1508 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14ef:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14f2:	8b 50 04             	mov    0x4(%eax),%edx
    14f5:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14f8:	39 ce                	cmp    %ecx,%esi
    14fa:	74 1b                	je     1517 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    14fc:	89 08                	mov    %ecx,(%eax)
  freep = p;
    14fe:	a3 2c 19 00 00       	mov    %eax,0x192c
}
    1503:	5b                   	pop    %ebx
    1504:	5e                   	pop    %esi
    1505:	5f                   	pop    %edi
    1506:	5d                   	pop    %ebp
    1507:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1508:	03 72 04             	add    0x4(%edx),%esi
    150b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    150e:	8b 10                	mov    (%eax),%edx
    1510:	8b 12                	mov    (%edx),%edx
    1512:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1515:	eb db                	jmp    14f2 <free+0x3e>
    p->s.size += bp->s.size;
    1517:	03 53 fc             	add    -0x4(%ebx),%edx
    151a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    151d:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1520:	89 10                	mov    %edx,(%eax)
    1522:	eb da                	jmp    14fe <free+0x4a>

00001524 <morecore>:

static Header*
morecore(uint nu)
{
    1524:	55                   	push   %ebp
    1525:	89 e5                	mov    %esp,%ebp
    1527:	53                   	push   %ebx
    1528:	83 ec 04             	sub    $0x4,%esp
    152b:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    152d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1532:	77 05                	ja     1539 <morecore+0x15>
    nu = 4096;
    1534:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1539:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1540:	83 ec 0c             	sub    $0xc,%esp
    1543:	50                   	push   %eax
    1544:	e8 28 fd ff ff       	call   1271 <sbrk>
  if(p == (char*)-1)
    1549:	83 c4 10             	add    $0x10,%esp
    154c:	83 f8 ff             	cmp    $0xffffffff,%eax
    154f:	74 1c                	je     156d <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1551:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1554:	83 c0 08             	add    $0x8,%eax
    1557:	83 ec 0c             	sub    $0xc,%esp
    155a:	50                   	push   %eax
    155b:	e8 54 ff ff ff       	call   14b4 <free>
  return freep;
    1560:	a1 2c 19 00 00       	mov    0x192c,%eax
    1565:	83 c4 10             	add    $0x10,%esp
}
    1568:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    156b:	c9                   	leave  
    156c:	c3                   	ret    
    return 0;
    156d:	b8 00 00 00 00       	mov    $0x0,%eax
    1572:	eb f4                	jmp    1568 <morecore+0x44>

00001574 <malloc>:

void*
malloc(uint nbytes)
{
    1574:	55                   	push   %ebp
    1575:	89 e5                	mov    %esp,%ebp
    1577:	53                   	push   %ebx
    1578:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    157b:	8b 45 08             	mov    0x8(%ebp),%eax
    157e:	8d 58 07             	lea    0x7(%eax),%ebx
    1581:	c1 eb 03             	shr    $0x3,%ebx
    1584:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1587:	8b 0d 2c 19 00 00    	mov    0x192c,%ecx
    158d:	85 c9                	test   %ecx,%ecx
    158f:	74 04                	je     1595 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1591:	8b 01                	mov    (%ecx),%eax
    1593:	eb 4a                	jmp    15df <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1595:	c7 05 2c 19 00 00 30 	movl   $0x1930,0x192c
    159c:	19 00 00 
    159f:	c7 05 30 19 00 00 30 	movl   $0x1930,0x1930
    15a6:	19 00 00 
    base.s.size = 0;
    15a9:	c7 05 34 19 00 00 00 	movl   $0x0,0x1934
    15b0:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15b3:	b9 30 19 00 00       	mov    $0x1930,%ecx
    15b8:	eb d7                	jmp    1591 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15ba:	74 19                	je     15d5 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15bc:	29 da                	sub    %ebx,%edx
    15be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15c1:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15c4:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15c7:	89 0d 2c 19 00 00    	mov    %ecx,0x192c
      return (void*)(p + 1);
    15cd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15d3:	c9                   	leave  
    15d4:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15d5:	8b 10                	mov    (%eax),%edx
    15d7:	89 11                	mov    %edx,(%ecx)
    15d9:	eb ec                	jmp    15c7 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15db:	89 c1                	mov    %eax,%ecx
    15dd:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15df:	8b 50 04             	mov    0x4(%eax),%edx
    15e2:	39 da                	cmp    %ebx,%edx
    15e4:	73 d4                	jae    15ba <malloc+0x46>
    if(p == freep)
    15e6:	39 05 2c 19 00 00    	cmp    %eax,0x192c
    15ec:	75 ed                	jne    15db <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15ee:	89 d8                	mov    %ebx,%eax
    15f0:	e8 2f ff ff ff       	call   1524 <morecore>
    15f5:	85 c0                	test   %eax,%eax
    15f7:	75 e2                	jne    15db <malloc+0x67>
    15f9:	eb d5                	jmp    15d0 <malloc+0x5c>
