
_test_1:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
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
    100e:	81 ec 10 04 00 00    	sub    $0x410,%esp
   struct pstat st;
  
  if(getpinfo(&st) == 0)
    1014:	8d 85 f8 fb ff ff    	lea    -0x408(%ebp),%eax
    101a:	50                   	push   %eax
    101b:	e8 79 02 00 00       	call   1299 <getpinfo>
    1020:	83 c4 10             	add    $0x10,%esp
    1023:	85 c0                	test   %eax,%eax
    1025:	75 17                	jne    103e <main+0x3e>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    1027:	83 ec 08             	sub    $0x8,%esp
    102a:	68 04 16 00 00       	push   $0x1604
    102f:	6a 01                	push   $0x1
    1031:	e8 20 03 00 00       	call   1356 <printf>
    1036:	83 c4 10             	add    $0x10,%esp
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
  }
   exit();
    1039:	e8 b3 01 00 00       	call   11f1 <exit>
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    103e:	83 ec 08             	sub    $0x8,%esp
    1041:	68 1c 16 00 00       	push   $0x161c
    1046:	6a 01                	push   $0x1
    1048:	e8 09 03 00 00       	call   1356 <printf>
    104d:	83 c4 10             	add    $0x10,%esp
    1050:	eb e7                	jmp    1039 <main+0x39>

00001052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1052:	55                   	push   %ebp
    1053:	89 e5                	mov    %esp,%ebp
    1055:	56                   	push   %esi
    1056:	53                   	push   %ebx
    1057:	8b 75 08             	mov    0x8(%ebp),%esi
    105a:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    105d:	89 f0                	mov    %esi,%eax
    105f:	89 d1                	mov    %edx,%ecx
    1061:	83 c2 01             	add    $0x1,%edx
    1064:	89 c3                	mov    %eax,%ebx
    1066:	83 c0 01             	add    $0x1,%eax
    1069:	0f b6 09             	movzbl (%ecx),%ecx
    106c:	88 0b                	mov    %cl,(%ebx)
    106e:	84 c9                	test   %cl,%cl
    1070:	75 ed                	jne    105f <strcpy+0xd>
    ;
  return os;
}
    1072:	89 f0                	mov    %esi,%eax
    1074:	5b                   	pop    %ebx
    1075:	5e                   	pop    %esi
    1076:	5d                   	pop    %ebp
    1077:	c3                   	ret    

00001078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1078:	55                   	push   %ebp
    1079:	89 e5                	mov    %esp,%ebp
    107b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    107e:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1081:	eb 06                	jmp    1089 <strcmp+0x11>
    p++, q++;
    1083:	83 c1 01             	add    $0x1,%ecx
    1086:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1089:	0f b6 01             	movzbl (%ecx),%eax
    108c:	84 c0                	test   %al,%al
    108e:	74 04                	je     1094 <strcmp+0x1c>
    1090:	3a 02                	cmp    (%edx),%al
    1092:	74 ef                	je     1083 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1094:	0f b6 c0             	movzbl %al,%eax
    1097:	0f b6 12             	movzbl (%edx),%edx
    109a:	29 d0                	sub    %edx,%eax
}
    109c:	5d                   	pop    %ebp
    109d:	c3                   	ret    

0000109e <strlen>:

uint
strlen(const char *s)
{
    109e:	55                   	push   %ebp
    109f:	89 e5                	mov    %esp,%ebp
    10a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10a4:	b8 00 00 00 00       	mov    $0x0,%eax
    10a9:	eb 03                	jmp    10ae <strlen+0x10>
    10ab:	83 c0 01             	add    $0x1,%eax
    10ae:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10b2:	75 f7                	jne    10ab <strlen+0xd>
    ;
  return n;
}
    10b4:	5d                   	pop    %ebp
    10b5:	c3                   	ret    

000010b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10b6:	55                   	push   %ebp
    10b7:	89 e5                	mov    %esp,%ebp
    10b9:	57                   	push   %edi
    10ba:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10bd:	89 d7                	mov    %edx,%edi
    10bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c5:	fc                   	cld    
    10c6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10c8:	89 d0                	mov    %edx,%eax
    10ca:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10cd:	c9                   	leave  
    10ce:	c3                   	ret    

000010cf <strchr>:

char*
strchr(const char *s, char c)
{
    10cf:	55                   	push   %ebp
    10d0:	89 e5                	mov    %esp,%ebp
    10d2:	8b 45 08             	mov    0x8(%ebp),%eax
    10d5:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10d9:	eb 03                	jmp    10de <strchr+0xf>
    10db:	83 c0 01             	add    $0x1,%eax
    10de:	0f b6 10             	movzbl (%eax),%edx
    10e1:	84 d2                	test   %dl,%dl
    10e3:	74 06                	je     10eb <strchr+0x1c>
    if(*s == c)
    10e5:	38 ca                	cmp    %cl,%dl
    10e7:	75 f2                	jne    10db <strchr+0xc>
    10e9:	eb 05                	jmp    10f0 <strchr+0x21>
      return (char*)s;
  return 0;
    10eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10f0:	5d                   	pop    %ebp
    10f1:	c3                   	ret    

000010f2 <gets>:

char*
gets(char *buf, int max)
{
    10f2:	55                   	push   %ebp
    10f3:	89 e5                	mov    %esp,%ebp
    10f5:	57                   	push   %edi
    10f6:	56                   	push   %esi
    10f7:	53                   	push   %ebx
    10f8:	83 ec 1c             	sub    $0x1c,%esp
    10fb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10fe:	bb 00 00 00 00       	mov    $0x0,%ebx
    1103:	89 de                	mov    %ebx,%esi
    1105:	83 c3 01             	add    $0x1,%ebx
    1108:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    110b:	7d 2e                	jge    113b <gets+0x49>
    cc = read(0, &c, 1);
    110d:	83 ec 04             	sub    $0x4,%esp
    1110:	6a 01                	push   $0x1
    1112:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1115:	50                   	push   %eax
    1116:	6a 00                	push   $0x0
    1118:	e8 ec 00 00 00       	call   1209 <read>
    if(cc < 1)
    111d:	83 c4 10             	add    $0x10,%esp
    1120:	85 c0                	test   %eax,%eax
    1122:	7e 17                	jle    113b <gets+0x49>
      break;
    buf[i++] = c;
    1124:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1128:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    112b:	3c 0a                	cmp    $0xa,%al
    112d:	0f 94 c2             	sete   %dl
    1130:	3c 0d                	cmp    $0xd,%al
    1132:	0f 94 c0             	sete   %al
    1135:	08 c2                	or     %al,%dl
    1137:	74 ca                	je     1103 <gets+0x11>
    buf[i++] = c;
    1139:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    113b:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    113f:	89 f8                	mov    %edi,%eax
    1141:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1144:	5b                   	pop    %ebx
    1145:	5e                   	pop    %esi
    1146:	5f                   	pop    %edi
    1147:	5d                   	pop    %ebp
    1148:	c3                   	ret    

00001149 <stat>:

int
stat(const char *n, struct stat *st)
{
    1149:	55                   	push   %ebp
    114a:	89 e5                	mov    %esp,%ebp
    114c:	56                   	push   %esi
    114d:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    114e:	83 ec 08             	sub    $0x8,%esp
    1151:	6a 00                	push   $0x0
    1153:	ff 75 08             	push   0x8(%ebp)
    1156:	e8 d6 00 00 00       	call   1231 <open>
  if(fd < 0)
    115b:	83 c4 10             	add    $0x10,%esp
    115e:	85 c0                	test   %eax,%eax
    1160:	78 24                	js     1186 <stat+0x3d>
    1162:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1164:	83 ec 08             	sub    $0x8,%esp
    1167:	ff 75 0c             	push   0xc(%ebp)
    116a:	50                   	push   %eax
    116b:	e8 d9 00 00 00       	call   1249 <fstat>
    1170:	89 c6                	mov    %eax,%esi
  close(fd);
    1172:	89 1c 24             	mov    %ebx,(%esp)
    1175:	e8 9f 00 00 00       	call   1219 <close>
  return r;
    117a:	83 c4 10             	add    $0x10,%esp
}
    117d:	89 f0                	mov    %esi,%eax
    117f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1182:	5b                   	pop    %ebx
    1183:	5e                   	pop    %esi
    1184:	5d                   	pop    %ebp
    1185:	c3                   	ret    
    return -1;
    1186:	be ff ff ff ff       	mov    $0xffffffff,%esi
    118b:	eb f0                	jmp    117d <stat+0x34>

0000118d <atoi>:

int
atoi(const char *s)
{
    118d:	55                   	push   %ebp
    118e:	89 e5                	mov    %esp,%ebp
    1190:	53                   	push   %ebx
    1191:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1194:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1199:	eb 10                	jmp    11ab <atoi+0x1e>
    n = n*10 + *s++ - '0';
    119b:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    119e:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11a1:	83 c1 01             	add    $0x1,%ecx
    11a4:	0f be c0             	movsbl %al,%eax
    11a7:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11ab:	0f b6 01             	movzbl (%ecx),%eax
    11ae:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11b1:	80 fb 09             	cmp    $0x9,%bl
    11b4:	76 e5                	jbe    119b <atoi+0xe>
  return n;
}
    11b6:	89 d0                	mov    %edx,%eax
    11b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11bb:	c9                   	leave  
    11bc:	c3                   	ret    

000011bd <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11bd:	55                   	push   %ebp
    11be:	89 e5                	mov    %esp,%ebp
    11c0:	56                   	push   %esi
    11c1:	53                   	push   %ebx
    11c2:	8b 75 08             	mov    0x8(%ebp),%esi
    11c5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11c8:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11cb:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11cd:	eb 0d                	jmp    11dc <memmove+0x1f>
    *dst++ = *src++;
    11cf:	0f b6 01             	movzbl (%ecx),%eax
    11d2:	88 02                	mov    %al,(%edx)
    11d4:	8d 49 01             	lea    0x1(%ecx),%ecx
    11d7:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11da:	89 d8                	mov    %ebx,%eax
    11dc:	8d 58 ff             	lea    -0x1(%eax),%ebx
    11df:	85 c0                	test   %eax,%eax
    11e1:	7f ec                	jg     11cf <memmove+0x12>
  return vdst;
}
    11e3:	89 f0                	mov    %esi,%eax
    11e5:	5b                   	pop    %ebx
    11e6:	5e                   	pop    %esi
    11e7:	5d                   	pop    %ebp
    11e8:	c3                   	ret    

000011e9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11e9:	b8 01 00 00 00       	mov    $0x1,%eax
    11ee:	cd 40                	int    $0x40
    11f0:	c3                   	ret    

000011f1 <exit>:
SYSCALL(exit)
    11f1:	b8 02 00 00 00       	mov    $0x2,%eax
    11f6:	cd 40                	int    $0x40
    11f8:	c3                   	ret    

000011f9 <wait>:
SYSCALL(wait)
    11f9:	b8 03 00 00 00       	mov    $0x3,%eax
    11fe:	cd 40                	int    $0x40
    1200:	c3                   	ret    

00001201 <pipe>:
SYSCALL(pipe)
    1201:	b8 04 00 00 00       	mov    $0x4,%eax
    1206:	cd 40                	int    $0x40
    1208:	c3                   	ret    

00001209 <read>:
SYSCALL(read)
    1209:	b8 05 00 00 00       	mov    $0x5,%eax
    120e:	cd 40                	int    $0x40
    1210:	c3                   	ret    

00001211 <write>:
SYSCALL(write)
    1211:	b8 10 00 00 00       	mov    $0x10,%eax
    1216:	cd 40                	int    $0x40
    1218:	c3                   	ret    

00001219 <close>:
SYSCALL(close)
    1219:	b8 15 00 00 00       	mov    $0x15,%eax
    121e:	cd 40                	int    $0x40
    1220:	c3                   	ret    

00001221 <kill>:
SYSCALL(kill)
    1221:	b8 06 00 00 00       	mov    $0x6,%eax
    1226:	cd 40                	int    $0x40
    1228:	c3                   	ret    

00001229 <exec>:
SYSCALL(exec)
    1229:	b8 07 00 00 00       	mov    $0x7,%eax
    122e:	cd 40                	int    $0x40
    1230:	c3                   	ret    

00001231 <open>:
SYSCALL(open)
    1231:	b8 0f 00 00 00       	mov    $0xf,%eax
    1236:	cd 40                	int    $0x40
    1238:	c3                   	ret    

00001239 <mknod>:
SYSCALL(mknod)
    1239:	b8 11 00 00 00       	mov    $0x11,%eax
    123e:	cd 40                	int    $0x40
    1240:	c3                   	ret    

00001241 <unlink>:
SYSCALL(unlink)
    1241:	b8 12 00 00 00       	mov    $0x12,%eax
    1246:	cd 40                	int    $0x40
    1248:	c3                   	ret    

00001249 <fstat>:
SYSCALL(fstat)
    1249:	b8 08 00 00 00       	mov    $0x8,%eax
    124e:	cd 40                	int    $0x40
    1250:	c3                   	ret    

00001251 <link>:
SYSCALL(link)
    1251:	b8 13 00 00 00       	mov    $0x13,%eax
    1256:	cd 40                	int    $0x40
    1258:	c3                   	ret    

00001259 <mkdir>:
SYSCALL(mkdir)
    1259:	b8 14 00 00 00       	mov    $0x14,%eax
    125e:	cd 40                	int    $0x40
    1260:	c3                   	ret    

00001261 <chdir>:
SYSCALL(chdir)
    1261:	b8 09 00 00 00       	mov    $0x9,%eax
    1266:	cd 40                	int    $0x40
    1268:	c3                   	ret    

00001269 <dup>:
SYSCALL(dup)
    1269:	b8 0a 00 00 00       	mov    $0xa,%eax
    126e:	cd 40                	int    $0x40
    1270:	c3                   	ret    

00001271 <getpid>:
SYSCALL(getpid)
    1271:	b8 0b 00 00 00       	mov    $0xb,%eax
    1276:	cd 40                	int    $0x40
    1278:	c3                   	ret    

00001279 <sbrk>:
SYSCALL(sbrk)
    1279:	b8 0c 00 00 00       	mov    $0xc,%eax
    127e:	cd 40                	int    $0x40
    1280:	c3                   	ret    

00001281 <sleep>:
SYSCALL(sleep)
    1281:	b8 0d 00 00 00       	mov    $0xd,%eax
    1286:	cd 40                	int    $0x40
    1288:	c3                   	ret    

00001289 <uptime>:
SYSCALL(uptime)
    1289:	b8 0e 00 00 00       	mov    $0xe,%eax
    128e:	cd 40                	int    $0x40
    1290:	c3                   	ret    

00001291 <settickets>:
SYSCALL(settickets)
    1291:	b8 16 00 00 00       	mov    $0x16,%eax
    1296:	cd 40                	int    $0x40
    1298:	c3                   	ret    

00001299 <getpinfo>:
SYSCALL(getpinfo)
    1299:	b8 17 00 00 00       	mov    $0x17,%eax
    129e:	cd 40                	int    $0x40
    12a0:	c3                   	ret    

000012a1 <mprotect>:
SYSCALL(mprotect)
    12a1:	b8 18 00 00 00       	mov    $0x18,%eax
    12a6:	cd 40                	int    $0x40
    12a8:	c3                   	ret    

000012a9 <munprotect>:
    12a9:	b8 19 00 00 00       	mov    $0x19,%eax
    12ae:	cd 40                	int    $0x40
    12b0:	c3                   	ret    

000012b1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12b1:	55                   	push   %ebp
    12b2:	89 e5                	mov    %esp,%ebp
    12b4:	83 ec 1c             	sub    $0x1c,%esp
    12b7:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12ba:	6a 01                	push   $0x1
    12bc:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12bf:	52                   	push   %edx
    12c0:	50                   	push   %eax
    12c1:	e8 4b ff ff ff       	call   1211 <write>
}
    12c6:	83 c4 10             	add    $0x10,%esp
    12c9:	c9                   	leave  
    12ca:	c3                   	ret    

000012cb <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12cb:	55                   	push   %ebp
    12cc:	89 e5                	mov    %esp,%ebp
    12ce:	57                   	push   %edi
    12cf:	56                   	push   %esi
    12d0:	53                   	push   %ebx
    12d1:	83 ec 2c             	sub    $0x2c,%esp
    12d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12d7:	89 d0                	mov    %edx,%eax
    12d9:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    12df:	0f 95 c1             	setne  %cl
    12e2:	c1 ea 1f             	shr    $0x1f,%edx
    12e5:	84 d1                	test   %dl,%cl
    12e7:	74 44                	je     132d <printint+0x62>
    neg = 1;
    x = -xx;
    12e9:	f7 d8                	neg    %eax
    12eb:	89 c1                	mov    %eax,%ecx
    neg = 1;
    12ed:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12f4:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    12f9:	89 c8                	mov    %ecx,%eax
    12fb:	ba 00 00 00 00       	mov    $0x0,%edx
    1300:	f7 f6                	div    %esi
    1302:	89 df                	mov    %ebx,%edi
    1304:	83 c3 01             	add    $0x1,%ebx
    1307:	0f b6 92 94 16 00 00 	movzbl 0x1694(%edx),%edx
    130e:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1312:	89 ca                	mov    %ecx,%edx
    1314:	89 c1                	mov    %eax,%ecx
    1316:	39 d6                	cmp    %edx,%esi
    1318:	76 df                	jbe    12f9 <printint+0x2e>
  if(neg)
    131a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    131e:	74 31                	je     1351 <printint+0x86>
    buf[i++] = '-';
    1320:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1325:	8d 5f 02             	lea    0x2(%edi),%ebx
    1328:	8b 75 d0             	mov    -0x30(%ebp),%esi
    132b:	eb 17                	jmp    1344 <printint+0x79>
    x = xx;
    132d:	89 c1                	mov    %eax,%ecx
  neg = 0;
    132f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1336:	eb bc                	jmp    12f4 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1338:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    133d:	89 f0                	mov    %esi,%eax
    133f:	e8 6d ff ff ff       	call   12b1 <putc>
  while(--i >= 0)
    1344:	83 eb 01             	sub    $0x1,%ebx
    1347:	79 ef                	jns    1338 <printint+0x6d>
}
    1349:	83 c4 2c             	add    $0x2c,%esp
    134c:	5b                   	pop    %ebx
    134d:	5e                   	pop    %esi
    134e:	5f                   	pop    %edi
    134f:	5d                   	pop    %ebp
    1350:	c3                   	ret    
    1351:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1354:	eb ee                	jmp    1344 <printint+0x79>

00001356 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1356:	55                   	push   %ebp
    1357:	89 e5                	mov    %esp,%ebp
    1359:	57                   	push   %edi
    135a:	56                   	push   %esi
    135b:	53                   	push   %ebx
    135c:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    135f:	8d 45 10             	lea    0x10(%ebp),%eax
    1362:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1365:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    136a:	bb 00 00 00 00       	mov    $0x0,%ebx
    136f:	eb 14                	jmp    1385 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1371:	89 fa                	mov    %edi,%edx
    1373:	8b 45 08             	mov    0x8(%ebp),%eax
    1376:	e8 36 ff ff ff       	call   12b1 <putc>
    137b:	eb 05                	jmp    1382 <printf+0x2c>
      }
    } else if(state == '%'){
    137d:	83 fe 25             	cmp    $0x25,%esi
    1380:	74 25                	je     13a7 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1382:	83 c3 01             	add    $0x1,%ebx
    1385:	8b 45 0c             	mov    0xc(%ebp),%eax
    1388:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    138c:	84 c0                	test   %al,%al
    138e:	0f 84 20 01 00 00    	je     14b4 <printf+0x15e>
    c = fmt[i] & 0xff;
    1394:	0f be f8             	movsbl %al,%edi
    1397:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    139a:	85 f6                	test   %esi,%esi
    139c:	75 df                	jne    137d <printf+0x27>
      if(c == '%'){
    139e:	83 f8 25             	cmp    $0x25,%eax
    13a1:	75 ce                	jne    1371 <printf+0x1b>
        state = '%';
    13a3:	89 c6                	mov    %eax,%esi
    13a5:	eb db                	jmp    1382 <printf+0x2c>
      if(c == 'd'){
    13a7:	83 f8 25             	cmp    $0x25,%eax
    13aa:	0f 84 cf 00 00 00    	je     147f <printf+0x129>
    13b0:	0f 8c dd 00 00 00    	jl     1493 <printf+0x13d>
    13b6:	83 f8 78             	cmp    $0x78,%eax
    13b9:	0f 8f d4 00 00 00    	jg     1493 <printf+0x13d>
    13bf:	83 f8 63             	cmp    $0x63,%eax
    13c2:	0f 8c cb 00 00 00    	jl     1493 <printf+0x13d>
    13c8:	83 e8 63             	sub    $0x63,%eax
    13cb:	83 f8 15             	cmp    $0x15,%eax
    13ce:	0f 87 bf 00 00 00    	ja     1493 <printf+0x13d>
    13d4:	ff 24 85 3c 16 00 00 	jmp    *0x163c(,%eax,4)
        printint(fd, *ap, 10, 1);
    13db:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13de:	8b 17                	mov    (%edi),%edx
    13e0:	83 ec 0c             	sub    $0xc,%esp
    13e3:	6a 01                	push   $0x1
    13e5:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13ea:	8b 45 08             	mov    0x8(%ebp),%eax
    13ed:	e8 d9 fe ff ff       	call   12cb <printint>
        ap++;
    13f2:	83 c7 04             	add    $0x4,%edi
    13f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    13f8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    13fb:	be 00 00 00 00       	mov    $0x0,%esi
    1400:	eb 80                	jmp    1382 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1402:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1405:	8b 17                	mov    (%edi),%edx
    1407:	83 ec 0c             	sub    $0xc,%esp
    140a:	6a 00                	push   $0x0
    140c:	b9 10 00 00 00       	mov    $0x10,%ecx
    1411:	8b 45 08             	mov    0x8(%ebp),%eax
    1414:	e8 b2 fe ff ff       	call   12cb <printint>
        ap++;
    1419:	83 c7 04             	add    $0x4,%edi
    141c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    141f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1422:	be 00 00 00 00       	mov    $0x0,%esi
    1427:	e9 56 ff ff ff       	jmp    1382 <printf+0x2c>
        s = (char*)*ap;
    142c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    142f:	8b 30                	mov    (%eax),%esi
        ap++;
    1431:	83 c0 04             	add    $0x4,%eax
    1434:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1437:	85 f6                	test   %esi,%esi
    1439:	75 15                	jne    1450 <printf+0xfa>
          s = "(null)";
    143b:	be 33 16 00 00       	mov    $0x1633,%esi
    1440:	eb 0e                	jmp    1450 <printf+0xfa>
          putc(fd, *s);
    1442:	0f be d2             	movsbl %dl,%edx
    1445:	8b 45 08             	mov    0x8(%ebp),%eax
    1448:	e8 64 fe ff ff       	call   12b1 <putc>
          s++;
    144d:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1450:	0f b6 16             	movzbl (%esi),%edx
    1453:	84 d2                	test   %dl,%dl
    1455:	75 eb                	jne    1442 <printf+0xec>
      state = 0;
    1457:	be 00 00 00 00       	mov    $0x0,%esi
    145c:	e9 21 ff ff ff       	jmp    1382 <printf+0x2c>
        putc(fd, *ap);
    1461:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1464:	0f be 17             	movsbl (%edi),%edx
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	e8 42 fe ff ff       	call   12b1 <putc>
        ap++;
    146f:	83 c7 04             	add    $0x4,%edi
    1472:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1475:	be 00 00 00 00       	mov    $0x0,%esi
    147a:	e9 03 ff ff ff       	jmp    1382 <printf+0x2c>
        putc(fd, c);
    147f:	89 fa                	mov    %edi,%edx
    1481:	8b 45 08             	mov    0x8(%ebp),%eax
    1484:	e8 28 fe ff ff       	call   12b1 <putc>
      state = 0;
    1489:	be 00 00 00 00       	mov    $0x0,%esi
    148e:	e9 ef fe ff ff       	jmp    1382 <printf+0x2c>
        putc(fd, '%');
    1493:	ba 25 00 00 00       	mov    $0x25,%edx
    1498:	8b 45 08             	mov    0x8(%ebp),%eax
    149b:	e8 11 fe ff ff       	call   12b1 <putc>
        putc(fd, c);
    14a0:	89 fa                	mov    %edi,%edx
    14a2:	8b 45 08             	mov    0x8(%ebp),%eax
    14a5:	e8 07 fe ff ff       	call   12b1 <putc>
      state = 0;
    14aa:	be 00 00 00 00       	mov    $0x0,%esi
    14af:	e9 ce fe ff ff       	jmp    1382 <printf+0x2c>
    }
  }
}
    14b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b7:	5b                   	pop    %ebx
    14b8:	5e                   	pop    %esi
    14b9:	5f                   	pop    %edi
    14ba:	5d                   	pop    %ebp
    14bb:	c3                   	ret    

000014bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14bc:	55                   	push   %ebp
    14bd:	89 e5                	mov    %esp,%ebp
    14bf:	57                   	push   %edi
    14c0:	56                   	push   %esi
    14c1:	53                   	push   %ebx
    14c2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14c5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c8:	a1 34 19 00 00       	mov    0x1934,%eax
    14cd:	eb 02                	jmp    14d1 <free+0x15>
    14cf:	89 d0                	mov    %edx,%eax
    14d1:	39 c8                	cmp    %ecx,%eax
    14d3:	73 04                	jae    14d9 <free+0x1d>
    14d5:	39 08                	cmp    %ecx,(%eax)
    14d7:	77 12                	ja     14eb <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d9:	8b 10                	mov    (%eax),%edx
    14db:	39 c2                	cmp    %eax,%edx
    14dd:	77 f0                	ja     14cf <free+0x13>
    14df:	39 c8                	cmp    %ecx,%eax
    14e1:	72 08                	jb     14eb <free+0x2f>
    14e3:	39 ca                	cmp    %ecx,%edx
    14e5:	77 04                	ja     14eb <free+0x2f>
    14e7:	89 d0                	mov    %edx,%eax
    14e9:	eb e6                	jmp    14d1 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14eb:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14ee:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14f1:	8b 10                	mov    (%eax),%edx
    14f3:	39 d7                	cmp    %edx,%edi
    14f5:	74 19                	je     1510 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    14f7:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    14fa:	8b 50 04             	mov    0x4(%eax),%edx
    14fd:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1500:	39 ce                	cmp    %ecx,%esi
    1502:	74 1b                	je     151f <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1504:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1506:	a3 34 19 00 00       	mov    %eax,0x1934
}
    150b:	5b                   	pop    %ebx
    150c:	5e                   	pop    %esi
    150d:	5f                   	pop    %edi
    150e:	5d                   	pop    %ebp
    150f:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1510:	03 72 04             	add    0x4(%edx),%esi
    1513:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1516:	8b 10                	mov    (%eax),%edx
    1518:	8b 12                	mov    (%edx),%edx
    151a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    151d:	eb db                	jmp    14fa <free+0x3e>
    p->s.size += bp->s.size;
    151f:	03 53 fc             	add    -0x4(%ebx),%edx
    1522:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1525:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1528:	89 10                	mov    %edx,(%eax)
    152a:	eb da                	jmp    1506 <free+0x4a>

0000152c <morecore>:

static Header*
morecore(uint nu)
{
    152c:	55                   	push   %ebp
    152d:	89 e5                	mov    %esp,%ebp
    152f:	53                   	push   %ebx
    1530:	83 ec 04             	sub    $0x4,%esp
    1533:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1535:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    153a:	77 05                	ja     1541 <morecore+0x15>
    nu = 4096;
    153c:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1541:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1548:	83 ec 0c             	sub    $0xc,%esp
    154b:	50                   	push   %eax
    154c:	e8 28 fd ff ff       	call   1279 <sbrk>
  if(p == (char*)-1)
    1551:	83 c4 10             	add    $0x10,%esp
    1554:	83 f8 ff             	cmp    $0xffffffff,%eax
    1557:	74 1c                	je     1575 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1559:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    155c:	83 c0 08             	add    $0x8,%eax
    155f:	83 ec 0c             	sub    $0xc,%esp
    1562:	50                   	push   %eax
    1563:	e8 54 ff ff ff       	call   14bc <free>
  return freep;
    1568:	a1 34 19 00 00       	mov    0x1934,%eax
    156d:	83 c4 10             	add    $0x10,%esp
}
    1570:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1573:	c9                   	leave  
    1574:	c3                   	ret    
    return 0;
    1575:	b8 00 00 00 00       	mov    $0x0,%eax
    157a:	eb f4                	jmp    1570 <morecore+0x44>

0000157c <malloc>:

void*
malloc(uint nbytes)
{
    157c:	55                   	push   %ebp
    157d:	89 e5                	mov    %esp,%ebp
    157f:	53                   	push   %ebx
    1580:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1583:	8b 45 08             	mov    0x8(%ebp),%eax
    1586:	8d 58 07             	lea    0x7(%eax),%ebx
    1589:	c1 eb 03             	shr    $0x3,%ebx
    158c:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    158f:	8b 0d 34 19 00 00    	mov    0x1934,%ecx
    1595:	85 c9                	test   %ecx,%ecx
    1597:	74 04                	je     159d <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1599:	8b 01                	mov    (%ecx),%eax
    159b:	eb 4a                	jmp    15e7 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    159d:	c7 05 34 19 00 00 38 	movl   $0x1938,0x1934
    15a4:	19 00 00 
    15a7:	c7 05 38 19 00 00 38 	movl   $0x1938,0x1938
    15ae:	19 00 00 
    base.s.size = 0;
    15b1:	c7 05 3c 19 00 00 00 	movl   $0x0,0x193c
    15b8:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15bb:	b9 38 19 00 00       	mov    $0x1938,%ecx
    15c0:	eb d7                	jmp    1599 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15c2:	74 19                	je     15dd <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15c4:	29 da                	sub    %ebx,%edx
    15c6:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15c9:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15cc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15cf:	89 0d 34 19 00 00    	mov    %ecx,0x1934
      return (void*)(p + 1);
    15d5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15db:	c9                   	leave  
    15dc:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15dd:	8b 10                	mov    (%eax),%edx
    15df:	89 11                	mov    %edx,(%ecx)
    15e1:	eb ec                	jmp    15cf <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15e3:	89 c1                	mov    %eax,%ecx
    15e5:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    15e7:	8b 50 04             	mov    0x4(%eax),%edx
    15ea:	39 da                	cmp    %ebx,%edx
    15ec:	73 d4                	jae    15c2 <malloc+0x46>
    if(p == freep)
    15ee:	39 05 34 19 00 00    	cmp    %eax,0x1934
    15f4:	75 ed                	jne    15e3 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    15f6:	89 d8                	mov    %ebx,%eax
    15f8:	e8 2f ff ff ff       	call   152c <morecore>
    15fd:	85 c0                	test   %eax,%eax
    15ff:	75 e2                	jne    15e3 <malloc+0x67>
    1601:	eb d5                	jmp    15d8 <malloc+0x5c>
