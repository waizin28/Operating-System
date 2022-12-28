
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    100f:	83 ec 08             	sub    $0x8,%esp
    1012:	6a 02                	push   $0x2
    1014:	68 90 16 00 00       	push   $0x1690
    1019:	e8 9e 02 00 00       	call   12bc <open>
    101e:	83 c4 10             	add    $0x10,%esp
    1021:	85 c0                	test   %eax,%eax
    1023:	78 1b                	js     1040 <main+0x40>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    1025:	83 ec 0c             	sub    $0xc,%esp
    1028:	6a 00                	push   $0x0
    102a:	e8 c5 02 00 00       	call   12f4 <dup>
  dup(0);  // stderr
    102f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1036:	e8 b9 02 00 00       	call   12f4 <dup>
    103b:	83 c4 10             	add    $0x10,%esp
    103e:	eb 58                	jmp    1098 <main+0x98>
    mknod("console", 1, 1);
    1040:	83 ec 04             	sub    $0x4,%esp
    1043:	6a 01                	push   $0x1
    1045:	6a 01                	push   $0x1
    1047:	68 90 16 00 00       	push   $0x1690
    104c:	e8 73 02 00 00       	call   12c4 <mknod>
    open("console", O_RDWR);
    1051:	83 c4 08             	add    $0x8,%esp
    1054:	6a 02                	push   $0x2
    1056:	68 90 16 00 00       	push   $0x1690
    105b:	e8 5c 02 00 00       	call   12bc <open>
    1060:	83 c4 10             	add    $0x10,%esp
    1063:	eb c0                	jmp    1025 <main+0x25>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
    1065:	83 ec 08             	sub    $0x8,%esp
    1068:	68 ab 16 00 00       	push   $0x16ab
    106d:	6a 01                	push   $0x1
    106f:	e8 6d 03 00 00       	call   13e1 <printf>
      exit();
    1074:	e8 03 02 00 00       	call   127c <exit>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
    1079:	83 ec 08             	sub    $0x8,%esp
    107c:	68 d7 16 00 00       	push   $0x16d7
    1081:	6a 01                	push   $0x1
    1083:	e8 59 03 00 00       	call   13e1 <printf>
    1088:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
    108b:	e8 f4 01 00 00       	call   1284 <wait>
    1090:	85 c0                	test   %eax,%eax
    1092:	78 04                	js     1098 <main+0x98>
    1094:	39 c3                	cmp    %eax,%ebx
    1096:	75 e1                	jne    1079 <main+0x79>
    printf(1, "init: starting sh\n");
    1098:	83 ec 08             	sub    $0x8,%esp
    109b:	68 98 16 00 00       	push   $0x1698
    10a0:	6a 01                	push   $0x1
    10a2:	e8 3a 03 00 00       	call   13e1 <printf>
    pid = fork();
    10a7:	e8 c8 01 00 00       	call   1274 <fork>
    10ac:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    10ae:	83 c4 10             	add    $0x10,%esp
    10b1:	85 c0                	test   %eax,%eax
    10b3:	78 b0                	js     1065 <main+0x65>
    if(pid == 0){
    10b5:	75 d4                	jne    108b <main+0x8b>
      exec("sh", argv);
    10b7:	83 ec 08             	sub    $0x8,%esp
    10ba:	68 e4 19 00 00       	push   $0x19e4
    10bf:	68 be 16 00 00       	push   $0x16be
    10c4:	e8 eb 01 00 00       	call   12b4 <exec>
      printf(1, "init: exec sh failed\n");
    10c9:	83 c4 08             	add    $0x8,%esp
    10cc:	68 c1 16 00 00       	push   $0x16c1
    10d1:	6a 01                	push   $0x1
    10d3:	e8 09 03 00 00       	call   13e1 <printf>
      exit();
    10d8:	e8 9f 01 00 00       	call   127c <exit>

000010dd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10dd:	55                   	push   %ebp
    10de:	89 e5                	mov    %esp,%ebp
    10e0:	56                   	push   %esi
    10e1:	53                   	push   %ebx
    10e2:	8b 75 08             	mov    0x8(%ebp),%esi
    10e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10e8:	89 f0                	mov    %esi,%eax
    10ea:	89 d1                	mov    %edx,%ecx
    10ec:	83 c2 01             	add    $0x1,%edx
    10ef:	89 c3                	mov    %eax,%ebx
    10f1:	83 c0 01             	add    $0x1,%eax
    10f4:	0f b6 09             	movzbl (%ecx),%ecx
    10f7:	88 0b                	mov    %cl,(%ebx)
    10f9:	84 c9                	test   %cl,%cl
    10fb:	75 ed                	jne    10ea <strcpy+0xd>
    ;
  return os;
}
    10fd:	89 f0                	mov    %esi,%eax
    10ff:	5b                   	pop    %ebx
    1100:	5e                   	pop    %esi
    1101:	5d                   	pop    %ebp
    1102:	c3                   	ret    

00001103 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1109:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    110c:	eb 06                	jmp    1114 <strcmp+0x11>
    p++, q++;
    110e:	83 c1 01             	add    $0x1,%ecx
    1111:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1114:	0f b6 01             	movzbl (%ecx),%eax
    1117:	84 c0                	test   %al,%al
    1119:	74 04                	je     111f <strcmp+0x1c>
    111b:	3a 02                	cmp    (%edx),%al
    111d:	74 ef                	je     110e <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    111f:	0f b6 c0             	movzbl %al,%eax
    1122:	0f b6 12             	movzbl (%edx),%edx
    1125:	29 d0                	sub    %edx,%eax
}
    1127:	5d                   	pop    %ebp
    1128:	c3                   	ret    

00001129 <strlen>:

uint
strlen(const char *s)
{
    1129:	55                   	push   %ebp
    112a:	89 e5                	mov    %esp,%ebp
    112c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    112f:	b8 00 00 00 00       	mov    $0x0,%eax
    1134:	eb 03                	jmp    1139 <strlen+0x10>
    1136:	83 c0 01             	add    $0x1,%eax
    1139:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    113d:	75 f7                	jne    1136 <strlen+0xd>
    ;
  return n;
}
    113f:	5d                   	pop    %ebp
    1140:	c3                   	ret    

00001141 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1141:	55                   	push   %ebp
    1142:	89 e5                	mov    %esp,%ebp
    1144:	57                   	push   %edi
    1145:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1148:	89 d7                	mov    %edx,%edi
    114a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    114d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1150:	fc                   	cld    
    1151:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1153:	89 d0                	mov    %edx,%eax
    1155:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1158:	c9                   	leave  
    1159:	c3                   	ret    

0000115a <strchr>:

char*
strchr(const char *s, char c)
{
    115a:	55                   	push   %ebp
    115b:	89 e5                	mov    %esp,%ebp
    115d:	8b 45 08             	mov    0x8(%ebp),%eax
    1160:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1164:	eb 03                	jmp    1169 <strchr+0xf>
    1166:	83 c0 01             	add    $0x1,%eax
    1169:	0f b6 10             	movzbl (%eax),%edx
    116c:	84 d2                	test   %dl,%dl
    116e:	74 06                	je     1176 <strchr+0x1c>
    if(*s == c)
    1170:	38 ca                	cmp    %cl,%dl
    1172:	75 f2                	jne    1166 <strchr+0xc>
    1174:	eb 05                	jmp    117b <strchr+0x21>
      return (char*)s;
  return 0;
    1176:	b8 00 00 00 00       	mov    $0x0,%eax
}
    117b:	5d                   	pop    %ebp
    117c:	c3                   	ret    

0000117d <gets>:

char*
gets(char *buf, int max)
{
    117d:	55                   	push   %ebp
    117e:	89 e5                	mov    %esp,%ebp
    1180:	57                   	push   %edi
    1181:	56                   	push   %esi
    1182:	53                   	push   %ebx
    1183:	83 ec 1c             	sub    $0x1c,%esp
    1186:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1189:	bb 00 00 00 00       	mov    $0x0,%ebx
    118e:	89 de                	mov    %ebx,%esi
    1190:	83 c3 01             	add    $0x1,%ebx
    1193:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1196:	7d 2e                	jge    11c6 <gets+0x49>
    cc = read(0, &c, 1);
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	6a 01                	push   $0x1
    119d:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11a0:	50                   	push   %eax
    11a1:	6a 00                	push   $0x0
    11a3:	e8 ec 00 00 00       	call   1294 <read>
    if(cc < 1)
    11a8:	83 c4 10             	add    $0x10,%esp
    11ab:	85 c0                	test   %eax,%eax
    11ad:	7e 17                	jle    11c6 <gets+0x49>
      break;
    buf[i++] = c;
    11af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11b3:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    11b6:	3c 0a                	cmp    $0xa,%al
    11b8:	0f 94 c2             	sete   %dl
    11bb:	3c 0d                	cmp    $0xd,%al
    11bd:	0f 94 c0             	sete   %al
    11c0:	08 c2                	or     %al,%dl
    11c2:	74 ca                	je     118e <gets+0x11>
    buf[i++] = c;
    11c4:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    11c6:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    11ca:	89 f8                	mov    %edi,%eax
    11cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11cf:	5b                   	pop    %ebx
    11d0:	5e                   	pop    %esi
    11d1:	5f                   	pop    %edi
    11d2:	5d                   	pop    %ebp
    11d3:	c3                   	ret    

000011d4 <stat>:

int
stat(const char *n, struct stat *st)
{
    11d4:	55                   	push   %ebp
    11d5:	89 e5                	mov    %esp,%ebp
    11d7:	56                   	push   %esi
    11d8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11d9:	83 ec 08             	sub    $0x8,%esp
    11dc:	6a 00                	push   $0x0
    11de:	ff 75 08             	push   0x8(%ebp)
    11e1:	e8 d6 00 00 00       	call   12bc <open>
  if(fd < 0)
    11e6:	83 c4 10             	add    $0x10,%esp
    11e9:	85 c0                	test   %eax,%eax
    11eb:	78 24                	js     1211 <stat+0x3d>
    11ed:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    11ef:	83 ec 08             	sub    $0x8,%esp
    11f2:	ff 75 0c             	push   0xc(%ebp)
    11f5:	50                   	push   %eax
    11f6:	e8 d9 00 00 00       	call   12d4 <fstat>
    11fb:	89 c6                	mov    %eax,%esi
  close(fd);
    11fd:	89 1c 24             	mov    %ebx,(%esp)
    1200:	e8 9f 00 00 00       	call   12a4 <close>
  return r;
    1205:	83 c4 10             	add    $0x10,%esp
}
    1208:	89 f0                	mov    %esi,%eax
    120a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    120d:	5b                   	pop    %ebx
    120e:	5e                   	pop    %esi
    120f:	5d                   	pop    %ebp
    1210:	c3                   	ret    
    return -1;
    1211:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1216:	eb f0                	jmp    1208 <stat+0x34>

00001218 <atoi>:

int
atoi(const char *s)
{
    1218:	55                   	push   %ebp
    1219:	89 e5                	mov    %esp,%ebp
    121b:	53                   	push   %ebx
    121c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    121f:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1224:	eb 10                	jmp    1236 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1226:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1229:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    122c:	83 c1 01             	add    $0x1,%ecx
    122f:	0f be c0             	movsbl %al,%eax
    1232:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1236:	0f b6 01             	movzbl (%ecx),%eax
    1239:	8d 58 d0             	lea    -0x30(%eax),%ebx
    123c:	80 fb 09             	cmp    $0x9,%bl
    123f:	76 e5                	jbe    1226 <atoi+0xe>
  return n;
}
    1241:	89 d0                	mov    %edx,%eax
    1243:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1246:	c9                   	leave  
    1247:	c3                   	ret    

00001248 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1248:	55                   	push   %ebp
    1249:	89 e5                	mov    %esp,%ebp
    124b:	56                   	push   %esi
    124c:	53                   	push   %ebx
    124d:	8b 75 08             	mov    0x8(%ebp),%esi
    1250:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1253:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1256:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1258:	eb 0d                	jmp    1267 <memmove+0x1f>
    *dst++ = *src++;
    125a:	0f b6 01             	movzbl (%ecx),%eax
    125d:	88 02                	mov    %al,(%edx)
    125f:	8d 49 01             	lea    0x1(%ecx),%ecx
    1262:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1265:	89 d8                	mov    %ebx,%eax
    1267:	8d 58 ff             	lea    -0x1(%eax),%ebx
    126a:	85 c0                	test   %eax,%eax
    126c:	7f ec                	jg     125a <memmove+0x12>
  return vdst;
}
    126e:	89 f0                	mov    %esi,%eax
    1270:	5b                   	pop    %ebx
    1271:	5e                   	pop    %esi
    1272:	5d                   	pop    %ebp
    1273:	c3                   	ret    

00001274 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1274:	b8 01 00 00 00       	mov    $0x1,%eax
    1279:	cd 40                	int    $0x40
    127b:	c3                   	ret    

0000127c <exit>:
SYSCALL(exit)
    127c:	b8 02 00 00 00       	mov    $0x2,%eax
    1281:	cd 40                	int    $0x40
    1283:	c3                   	ret    

00001284 <wait>:
SYSCALL(wait)
    1284:	b8 03 00 00 00       	mov    $0x3,%eax
    1289:	cd 40                	int    $0x40
    128b:	c3                   	ret    

0000128c <pipe>:
SYSCALL(pipe)
    128c:	b8 04 00 00 00       	mov    $0x4,%eax
    1291:	cd 40                	int    $0x40
    1293:	c3                   	ret    

00001294 <read>:
SYSCALL(read)
    1294:	b8 05 00 00 00       	mov    $0x5,%eax
    1299:	cd 40                	int    $0x40
    129b:	c3                   	ret    

0000129c <write>:
SYSCALL(write)
    129c:	b8 10 00 00 00       	mov    $0x10,%eax
    12a1:	cd 40                	int    $0x40
    12a3:	c3                   	ret    

000012a4 <close>:
SYSCALL(close)
    12a4:	b8 15 00 00 00       	mov    $0x15,%eax
    12a9:	cd 40                	int    $0x40
    12ab:	c3                   	ret    

000012ac <kill>:
SYSCALL(kill)
    12ac:	b8 06 00 00 00       	mov    $0x6,%eax
    12b1:	cd 40                	int    $0x40
    12b3:	c3                   	ret    

000012b4 <exec>:
SYSCALL(exec)
    12b4:	b8 07 00 00 00       	mov    $0x7,%eax
    12b9:	cd 40                	int    $0x40
    12bb:	c3                   	ret    

000012bc <open>:
SYSCALL(open)
    12bc:	b8 0f 00 00 00       	mov    $0xf,%eax
    12c1:	cd 40                	int    $0x40
    12c3:	c3                   	ret    

000012c4 <mknod>:
SYSCALL(mknod)
    12c4:	b8 11 00 00 00       	mov    $0x11,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <unlink>:
SYSCALL(unlink)
    12cc:	b8 12 00 00 00       	mov    $0x12,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <fstat>:
SYSCALL(fstat)
    12d4:	b8 08 00 00 00       	mov    $0x8,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <link>:
SYSCALL(link)
    12dc:	b8 13 00 00 00       	mov    $0x13,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <mkdir>:
SYSCALL(mkdir)
    12e4:	b8 14 00 00 00       	mov    $0x14,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <chdir>:
SYSCALL(chdir)
    12ec:	b8 09 00 00 00       	mov    $0x9,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <dup>:
SYSCALL(dup)
    12f4:	b8 0a 00 00 00       	mov    $0xa,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <getpid>:
SYSCALL(getpid)
    12fc:	b8 0b 00 00 00       	mov    $0xb,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <sbrk>:
SYSCALL(sbrk)
    1304:	b8 0c 00 00 00       	mov    $0xc,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <sleep>:
SYSCALL(sleep)
    130c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <uptime>:
SYSCALL(uptime)
    1314:	b8 0e 00 00 00       	mov    $0xe,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <settickets>:
SYSCALL(settickets)
    131c:	b8 16 00 00 00       	mov    $0x16,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <getpinfo>:
SYSCALL(getpinfo)
    1324:	b8 17 00 00 00       	mov    $0x17,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <mprotect>:
SYSCALL(mprotect)
    132c:	b8 18 00 00 00       	mov    $0x18,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <munprotect>:
    1334:	b8 19 00 00 00       	mov    $0x19,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    133c:	55                   	push   %ebp
    133d:	89 e5                	mov    %esp,%ebp
    133f:	83 ec 1c             	sub    $0x1c,%esp
    1342:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1345:	6a 01                	push   $0x1
    1347:	8d 55 f4             	lea    -0xc(%ebp),%edx
    134a:	52                   	push   %edx
    134b:	50                   	push   %eax
    134c:	e8 4b ff ff ff       	call   129c <write>
}
    1351:	83 c4 10             	add    $0x10,%esp
    1354:	c9                   	leave  
    1355:	c3                   	ret    

00001356 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1356:	55                   	push   %ebp
    1357:	89 e5                	mov    %esp,%ebp
    1359:	57                   	push   %edi
    135a:	56                   	push   %esi
    135b:	53                   	push   %ebx
    135c:	83 ec 2c             	sub    $0x2c,%esp
    135f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1362:	89 d0                	mov    %edx,%eax
    1364:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1366:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    136a:	0f 95 c1             	setne  %cl
    136d:	c1 ea 1f             	shr    $0x1f,%edx
    1370:	84 d1                	test   %dl,%cl
    1372:	74 44                	je     13b8 <printint+0x62>
    neg = 1;
    x = -xx;
    1374:	f7 d8                	neg    %eax
    1376:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1378:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    137f:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1384:	89 c8                	mov    %ecx,%eax
    1386:	ba 00 00 00 00       	mov    $0x0,%edx
    138b:	f7 f6                	div    %esi
    138d:	89 df                	mov    %ebx,%edi
    138f:	83 c3 01             	add    $0x1,%ebx
    1392:	0f b6 92 40 17 00 00 	movzbl 0x1740(%edx),%edx
    1399:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    139d:	89 ca                	mov    %ecx,%edx
    139f:	89 c1                	mov    %eax,%ecx
    13a1:	39 d6                	cmp    %edx,%esi
    13a3:	76 df                	jbe    1384 <printint+0x2e>
  if(neg)
    13a5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    13a9:	74 31                	je     13dc <printint+0x86>
    buf[i++] = '-';
    13ab:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    13b0:	8d 5f 02             	lea    0x2(%edi),%ebx
    13b3:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13b6:	eb 17                	jmp    13cf <printint+0x79>
    x = xx;
    13b8:	89 c1                	mov    %eax,%ecx
  neg = 0;
    13ba:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    13c1:	eb bc                	jmp    137f <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    13c3:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    13c8:	89 f0                	mov    %esi,%eax
    13ca:	e8 6d ff ff ff       	call   133c <putc>
  while(--i >= 0)
    13cf:	83 eb 01             	sub    $0x1,%ebx
    13d2:	79 ef                	jns    13c3 <printint+0x6d>
}
    13d4:	83 c4 2c             	add    $0x2c,%esp
    13d7:	5b                   	pop    %ebx
    13d8:	5e                   	pop    %esi
    13d9:	5f                   	pop    %edi
    13da:	5d                   	pop    %ebp
    13db:	c3                   	ret    
    13dc:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13df:	eb ee                	jmp    13cf <printint+0x79>

000013e1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    13e1:	55                   	push   %ebp
    13e2:	89 e5                	mov    %esp,%ebp
    13e4:	57                   	push   %edi
    13e5:	56                   	push   %esi
    13e6:	53                   	push   %ebx
    13e7:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    13ea:	8d 45 10             	lea    0x10(%ebp),%eax
    13ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    13f0:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    13f5:	bb 00 00 00 00       	mov    $0x0,%ebx
    13fa:	eb 14                	jmp    1410 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    13fc:	89 fa                	mov    %edi,%edx
    13fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1401:	e8 36 ff ff ff       	call   133c <putc>
    1406:	eb 05                	jmp    140d <printf+0x2c>
      }
    } else if(state == '%'){
    1408:	83 fe 25             	cmp    $0x25,%esi
    140b:	74 25                	je     1432 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    140d:	83 c3 01             	add    $0x1,%ebx
    1410:	8b 45 0c             	mov    0xc(%ebp),%eax
    1413:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1417:	84 c0                	test   %al,%al
    1419:	0f 84 20 01 00 00    	je     153f <printf+0x15e>
    c = fmt[i] & 0xff;
    141f:	0f be f8             	movsbl %al,%edi
    1422:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1425:	85 f6                	test   %esi,%esi
    1427:	75 df                	jne    1408 <printf+0x27>
      if(c == '%'){
    1429:	83 f8 25             	cmp    $0x25,%eax
    142c:	75 ce                	jne    13fc <printf+0x1b>
        state = '%';
    142e:	89 c6                	mov    %eax,%esi
    1430:	eb db                	jmp    140d <printf+0x2c>
      if(c == 'd'){
    1432:	83 f8 25             	cmp    $0x25,%eax
    1435:	0f 84 cf 00 00 00    	je     150a <printf+0x129>
    143b:	0f 8c dd 00 00 00    	jl     151e <printf+0x13d>
    1441:	83 f8 78             	cmp    $0x78,%eax
    1444:	0f 8f d4 00 00 00    	jg     151e <printf+0x13d>
    144a:	83 f8 63             	cmp    $0x63,%eax
    144d:	0f 8c cb 00 00 00    	jl     151e <printf+0x13d>
    1453:	83 e8 63             	sub    $0x63,%eax
    1456:	83 f8 15             	cmp    $0x15,%eax
    1459:	0f 87 bf 00 00 00    	ja     151e <printf+0x13d>
    145f:	ff 24 85 e8 16 00 00 	jmp    *0x16e8(,%eax,4)
        printint(fd, *ap, 10, 1);
    1466:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1469:	8b 17                	mov    (%edi),%edx
    146b:	83 ec 0c             	sub    $0xc,%esp
    146e:	6a 01                	push   $0x1
    1470:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1475:	8b 45 08             	mov    0x8(%ebp),%eax
    1478:	e8 d9 fe ff ff       	call   1356 <printint>
        ap++;
    147d:	83 c7 04             	add    $0x4,%edi
    1480:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1483:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1486:	be 00 00 00 00       	mov    $0x0,%esi
    148b:	eb 80                	jmp    140d <printf+0x2c>
        printint(fd, *ap, 16, 0);
    148d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1490:	8b 17                	mov    (%edi),%edx
    1492:	83 ec 0c             	sub    $0xc,%esp
    1495:	6a 00                	push   $0x0
    1497:	b9 10 00 00 00       	mov    $0x10,%ecx
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	e8 b2 fe ff ff       	call   1356 <printint>
        ap++;
    14a4:	83 c7 04             	add    $0x4,%edi
    14a7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    14aa:	83 c4 10             	add    $0x10,%esp
      state = 0;
    14ad:	be 00 00 00 00       	mov    $0x0,%esi
    14b2:	e9 56 ff ff ff       	jmp    140d <printf+0x2c>
        s = (char*)*ap;
    14b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14ba:	8b 30                	mov    (%eax),%esi
        ap++;
    14bc:	83 c0 04             	add    $0x4,%eax
    14bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    14c2:	85 f6                	test   %esi,%esi
    14c4:	75 15                	jne    14db <printf+0xfa>
          s = "(null)";
    14c6:	be e0 16 00 00       	mov    $0x16e0,%esi
    14cb:	eb 0e                	jmp    14db <printf+0xfa>
          putc(fd, *s);
    14cd:	0f be d2             	movsbl %dl,%edx
    14d0:	8b 45 08             	mov    0x8(%ebp),%eax
    14d3:	e8 64 fe ff ff       	call   133c <putc>
          s++;
    14d8:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    14db:	0f b6 16             	movzbl (%esi),%edx
    14de:	84 d2                	test   %dl,%dl
    14e0:	75 eb                	jne    14cd <printf+0xec>
      state = 0;
    14e2:	be 00 00 00 00       	mov    $0x0,%esi
    14e7:	e9 21 ff ff ff       	jmp    140d <printf+0x2c>
        putc(fd, *ap);
    14ec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14ef:	0f be 17             	movsbl (%edi),%edx
    14f2:	8b 45 08             	mov    0x8(%ebp),%eax
    14f5:	e8 42 fe ff ff       	call   133c <putc>
        ap++;
    14fa:	83 c7 04             	add    $0x4,%edi
    14fd:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1500:	be 00 00 00 00       	mov    $0x0,%esi
    1505:	e9 03 ff ff ff       	jmp    140d <printf+0x2c>
        putc(fd, c);
    150a:	89 fa                	mov    %edi,%edx
    150c:	8b 45 08             	mov    0x8(%ebp),%eax
    150f:	e8 28 fe ff ff       	call   133c <putc>
      state = 0;
    1514:	be 00 00 00 00       	mov    $0x0,%esi
    1519:	e9 ef fe ff ff       	jmp    140d <printf+0x2c>
        putc(fd, '%');
    151e:	ba 25 00 00 00       	mov    $0x25,%edx
    1523:	8b 45 08             	mov    0x8(%ebp),%eax
    1526:	e8 11 fe ff ff       	call   133c <putc>
        putc(fd, c);
    152b:	89 fa                	mov    %edi,%edx
    152d:	8b 45 08             	mov    0x8(%ebp),%eax
    1530:	e8 07 fe ff ff       	call   133c <putc>
      state = 0;
    1535:	be 00 00 00 00       	mov    $0x0,%esi
    153a:	e9 ce fe ff ff       	jmp    140d <printf+0x2c>
    }
  }
}
    153f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5f                   	pop    %edi
    1545:	5d                   	pop    %ebp
    1546:	c3                   	ret    

00001547 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1547:	55                   	push   %ebp
    1548:	89 e5                	mov    %esp,%ebp
    154a:	57                   	push   %edi
    154b:	56                   	push   %esi
    154c:	53                   	push   %ebx
    154d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1550:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1553:	a1 ec 19 00 00       	mov    0x19ec,%eax
    1558:	eb 02                	jmp    155c <free+0x15>
    155a:	89 d0                	mov    %edx,%eax
    155c:	39 c8                	cmp    %ecx,%eax
    155e:	73 04                	jae    1564 <free+0x1d>
    1560:	39 08                	cmp    %ecx,(%eax)
    1562:	77 12                	ja     1576 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1564:	8b 10                	mov    (%eax),%edx
    1566:	39 c2                	cmp    %eax,%edx
    1568:	77 f0                	ja     155a <free+0x13>
    156a:	39 c8                	cmp    %ecx,%eax
    156c:	72 08                	jb     1576 <free+0x2f>
    156e:	39 ca                	cmp    %ecx,%edx
    1570:	77 04                	ja     1576 <free+0x2f>
    1572:	89 d0                	mov    %edx,%eax
    1574:	eb e6                	jmp    155c <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1576:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1579:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    157c:	8b 10                	mov    (%eax),%edx
    157e:	39 d7                	cmp    %edx,%edi
    1580:	74 19                	je     159b <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1582:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1585:	8b 50 04             	mov    0x4(%eax),%edx
    1588:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    158b:	39 ce                	cmp    %ecx,%esi
    158d:	74 1b                	je     15aa <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    158f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1591:	a3 ec 19 00 00       	mov    %eax,0x19ec
}
    1596:	5b                   	pop    %ebx
    1597:	5e                   	pop    %esi
    1598:	5f                   	pop    %edi
    1599:	5d                   	pop    %ebp
    159a:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    159b:	03 72 04             	add    0x4(%edx),%esi
    159e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    15a1:	8b 10                	mov    (%eax),%edx
    15a3:	8b 12                	mov    (%edx),%edx
    15a5:	89 53 f8             	mov    %edx,-0x8(%ebx)
    15a8:	eb db                	jmp    1585 <free+0x3e>
    p->s.size += bp->s.size;
    15aa:	03 53 fc             	add    -0x4(%ebx),%edx
    15ad:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15b0:	8b 53 f8             	mov    -0x8(%ebx),%edx
    15b3:	89 10                	mov    %edx,(%eax)
    15b5:	eb da                	jmp    1591 <free+0x4a>

000015b7 <morecore>:

static Header*
morecore(uint nu)
{
    15b7:	55                   	push   %ebp
    15b8:	89 e5                	mov    %esp,%ebp
    15ba:	53                   	push   %ebx
    15bb:	83 ec 04             	sub    $0x4,%esp
    15be:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    15c0:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    15c5:	77 05                	ja     15cc <morecore+0x15>
    nu = 4096;
    15c7:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    15cc:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    15d3:	83 ec 0c             	sub    $0xc,%esp
    15d6:	50                   	push   %eax
    15d7:	e8 28 fd ff ff       	call   1304 <sbrk>
  if(p == (char*)-1)
    15dc:	83 c4 10             	add    $0x10,%esp
    15df:	83 f8 ff             	cmp    $0xffffffff,%eax
    15e2:	74 1c                	je     1600 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    15e4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15e7:	83 c0 08             	add    $0x8,%eax
    15ea:	83 ec 0c             	sub    $0xc,%esp
    15ed:	50                   	push   %eax
    15ee:	e8 54 ff ff ff       	call   1547 <free>
  return freep;
    15f3:	a1 ec 19 00 00       	mov    0x19ec,%eax
    15f8:	83 c4 10             	add    $0x10,%esp
}
    15fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15fe:	c9                   	leave  
    15ff:	c3                   	ret    
    return 0;
    1600:	b8 00 00 00 00       	mov    $0x0,%eax
    1605:	eb f4                	jmp    15fb <morecore+0x44>

00001607 <malloc>:

void*
malloc(uint nbytes)
{
    1607:	55                   	push   %ebp
    1608:	89 e5                	mov    %esp,%ebp
    160a:	53                   	push   %ebx
    160b:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    160e:	8b 45 08             	mov    0x8(%ebp),%eax
    1611:	8d 58 07             	lea    0x7(%eax),%ebx
    1614:	c1 eb 03             	shr    $0x3,%ebx
    1617:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    161a:	8b 0d ec 19 00 00    	mov    0x19ec,%ecx
    1620:	85 c9                	test   %ecx,%ecx
    1622:	74 04                	je     1628 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1624:	8b 01                	mov    (%ecx),%eax
    1626:	eb 4a                	jmp    1672 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1628:	c7 05 ec 19 00 00 f0 	movl   $0x19f0,0x19ec
    162f:	19 00 00 
    1632:	c7 05 f0 19 00 00 f0 	movl   $0x19f0,0x19f0
    1639:	19 00 00 
    base.s.size = 0;
    163c:	c7 05 f4 19 00 00 00 	movl   $0x0,0x19f4
    1643:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1646:	b9 f0 19 00 00       	mov    $0x19f0,%ecx
    164b:	eb d7                	jmp    1624 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    164d:	74 19                	je     1668 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    164f:	29 da                	sub    %ebx,%edx
    1651:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1654:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1657:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    165a:	89 0d ec 19 00 00    	mov    %ecx,0x19ec
      return (void*)(p + 1);
    1660:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1663:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1666:	c9                   	leave  
    1667:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1668:	8b 10                	mov    (%eax),%edx
    166a:	89 11                	mov    %edx,(%ecx)
    166c:	eb ec                	jmp    165a <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    166e:	89 c1                	mov    %eax,%ecx
    1670:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1672:	8b 50 04             	mov    0x4(%eax),%edx
    1675:	39 da                	cmp    %ebx,%edx
    1677:	73 d4                	jae    164d <malloc+0x46>
    if(p == freep)
    1679:	39 05 ec 19 00 00    	cmp    %eax,0x19ec
    167f:	75 ed                	jne    166e <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1681:	89 d8                	mov    %ebx,%eax
    1683:	e8 2f ff ff ff       	call   15b7 <morecore>
    1688:	85 c0                	test   %eax,%eax
    168a:	75 e2                	jne    166e <malloc+0x67>
    168c:	eb d5                	jmp    1663 <malloc+0x5c>
