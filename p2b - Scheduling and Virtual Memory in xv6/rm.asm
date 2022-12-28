
_rm:     file format elf32-i386


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
    1011:	83 ec 18             	sub    $0x18,%esp
    1014:	8b 39                	mov    (%ecx),%edi
    1016:	8b 41 04             	mov    0x4(%ecx),%eax
    1019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int i;

  if(argc < 2){
    101c:	83 ff 01             	cmp    $0x1,%edi
    101f:	7e 07                	jle    1028 <main+0x28>
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    1021:	bb 01 00 00 00       	mov    $0x1,%ebx
    1026:	eb 17                	jmp    103f <main+0x3f>
    printf(2, "Usage: rm files...\n");
    1028:	83 ec 08             	sub    $0x8,%esp
    102b:	68 24 16 00 00       	push   $0x1624
    1030:	6a 02                	push   $0x2
    1032:	e8 40 03 00 00       	call   1377 <printf>
    exit();
    1037:	e8 d6 01 00 00       	call   1212 <exit>
  for(i = 1; i < argc; i++){
    103c:	83 c3 01             	add    $0x1,%ebx
    103f:	39 fb                	cmp    %edi,%ebx
    1041:	7d 2b                	jge    106e <main+0x6e>
    if(unlink(argv[i]) < 0){
    1043:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1046:	8d 34 98             	lea    (%eax,%ebx,4),%esi
    1049:	83 ec 0c             	sub    $0xc,%esp
    104c:	ff 36                	push   (%esi)
    104e:	e8 0f 02 00 00       	call   1262 <unlink>
    1053:	83 c4 10             	add    $0x10,%esp
    1056:	85 c0                	test   %eax,%eax
    1058:	79 e2                	jns    103c <main+0x3c>
      printf(2, "rm: %s failed to delete\n", argv[i]);
    105a:	83 ec 04             	sub    $0x4,%esp
    105d:	ff 36                	push   (%esi)
    105f:	68 38 16 00 00       	push   $0x1638
    1064:	6a 02                	push   $0x2
    1066:	e8 0c 03 00 00       	call   1377 <printf>
      break;
    106b:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit();
    106e:	e8 9f 01 00 00       	call   1212 <exit>

00001073 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1073:	55                   	push   %ebp
    1074:	89 e5                	mov    %esp,%ebp
    1076:	56                   	push   %esi
    1077:	53                   	push   %ebx
    1078:	8b 75 08             	mov    0x8(%ebp),%esi
    107b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    107e:	89 f0                	mov    %esi,%eax
    1080:	89 d1                	mov    %edx,%ecx
    1082:	83 c2 01             	add    $0x1,%edx
    1085:	89 c3                	mov    %eax,%ebx
    1087:	83 c0 01             	add    $0x1,%eax
    108a:	0f b6 09             	movzbl (%ecx),%ecx
    108d:	88 0b                	mov    %cl,(%ebx)
    108f:	84 c9                	test   %cl,%cl
    1091:	75 ed                	jne    1080 <strcpy+0xd>
    ;
  return os;
}
    1093:	89 f0                	mov    %esi,%eax
    1095:	5b                   	pop    %ebx
    1096:	5e                   	pop    %esi
    1097:	5d                   	pop    %ebp
    1098:	c3                   	ret    

00001099 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1099:	55                   	push   %ebp
    109a:	89 e5                	mov    %esp,%ebp
    109c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    109f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10a2:	eb 06                	jmp    10aa <strcmp+0x11>
    p++, q++;
    10a4:	83 c1 01             	add    $0x1,%ecx
    10a7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10aa:	0f b6 01             	movzbl (%ecx),%eax
    10ad:	84 c0                	test   %al,%al
    10af:	74 04                	je     10b5 <strcmp+0x1c>
    10b1:	3a 02                	cmp    (%edx),%al
    10b3:	74 ef                	je     10a4 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    10b5:	0f b6 c0             	movzbl %al,%eax
    10b8:	0f b6 12             	movzbl (%edx),%edx
    10bb:	29 d0                	sub    %edx,%eax
}
    10bd:	5d                   	pop    %ebp
    10be:	c3                   	ret    

000010bf <strlen>:

uint
strlen(const char *s)
{
    10bf:	55                   	push   %ebp
    10c0:	89 e5                	mov    %esp,%ebp
    10c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10c5:	b8 00 00 00 00       	mov    $0x0,%eax
    10ca:	eb 03                	jmp    10cf <strlen+0x10>
    10cc:	83 c0 01             	add    $0x1,%eax
    10cf:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10d3:	75 f7                	jne    10cc <strlen+0xd>
    ;
  return n;
}
    10d5:	5d                   	pop    %ebp
    10d6:	c3                   	ret    

000010d7 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10d7:	55                   	push   %ebp
    10d8:	89 e5                	mov    %esp,%ebp
    10da:	57                   	push   %edi
    10db:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10de:	89 d7                	mov    %edx,%edi
    10e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e6:	fc                   	cld    
    10e7:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10e9:	89 d0                	mov    %edx,%eax
    10eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
    10ee:	c9                   	leave  
    10ef:	c3                   	ret    

000010f0 <strchr>:

char*
strchr(const char *s, char c)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10fa:	eb 03                	jmp    10ff <strchr+0xf>
    10fc:	83 c0 01             	add    $0x1,%eax
    10ff:	0f b6 10             	movzbl (%eax),%edx
    1102:	84 d2                	test   %dl,%dl
    1104:	74 06                	je     110c <strchr+0x1c>
    if(*s == c)
    1106:	38 ca                	cmp    %cl,%dl
    1108:	75 f2                	jne    10fc <strchr+0xc>
    110a:	eb 05                	jmp    1111 <strchr+0x21>
      return (char*)s;
  return 0;
    110c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1111:	5d                   	pop    %ebp
    1112:	c3                   	ret    

00001113 <gets>:

char*
gets(char *buf, int max)
{
    1113:	55                   	push   %ebp
    1114:	89 e5                	mov    %esp,%ebp
    1116:	57                   	push   %edi
    1117:	56                   	push   %esi
    1118:	53                   	push   %ebx
    1119:	83 ec 1c             	sub    $0x1c,%esp
    111c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    111f:	bb 00 00 00 00       	mov    $0x0,%ebx
    1124:	89 de                	mov    %ebx,%esi
    1126:	83 c3 01             	add    $0x1,%ebx
    1129:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    112c:	7d 2e                	jge    115c <gets+0x49>
    cc = read(0, &c, 1);
    112e:	83 ec 04             	sub    $0x4,%esp
    1131:	6a 01                	push   $0x1
    1133:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1136:	50                   	push   %eax
    1137:	6a 00                	push   $0x0
    1139:	e8 ec 00 00 00       	call   122a <read>
    if(cc < 1)
    113e:	83 c4 10             	add    $0x10,%esp
    1141:	85 c0                	test   %eax,%eax
    1143:	7e 17                	jle    115c <gets+0x49>
      break;
    buf[i++] = c;
    1145:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1149:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    114c:	3c 0a                	cmp    $0xa,%al
    114e:	0f 94 c2             	sete   %dl
    1151:	3c 0d                	cmp    $0xd,%al
    1153:	0f 94 c0             	sete   %al
    1156:	08 c2                	or     %al,%dl
    1158:	74 ca                	je     1124 <gets+0x11>
    buf[i++] = c;
    115a:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    115c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1160:	89 f8                	mov    %edi,%eax
    1162:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1165:	5b                   	pop    %ebx
    1166:	5e                   	pop    %esi
    1167:	5f                   	pop    %edi
    1168:	5d                   	pop    %ebp
    1169:	c3                   	ret    

0000116a <stat>:

int
stat(const char *n, struct stat *st)
{
    116a:	55                   	push   %ebp
    116b:	89 e5                	mov    %esp,%ebp
    116d:	56                   	push   %esi
    116e:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    116f:	83 ec 08             	sub    $0x8,%esp
    1172:	6a 00                	push   $0x0
    1174:	ff 75 08             	push   0x8(%ebp)
    1177:	e8 d6 00 00 00       	call   1252 <open>
  if(fd < 0)
    117c:	83 c4 10             	add    $0x10,%esp
    117f:	85 c0                	test   %eax,%eax
    1181:	78 24                	js     11a7 <stat+0x3d>
    1183:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1185:	83 ec 08             	sub    $0x8,%esp
    1188:	ff 75 0c             	push   0xc(%ebp)
    118b:	50                   	push   %eax
    118c:	e8 d9 00 00 00       	call   126a <fstat>
    1191:	89 c6                	mov    %eax,%esi
  close(fd);
    1193:	89 1c 24             	mov    %ebx,(%esp)
    1196:	e8 9f 00 00 00       	call   123a <close>
  return r;
    119b:	83 c4 10             	add    $0x10,%esp
}
    119e:	89 f0                	mov    %esi,%eax
    11a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11a3:	5b                   	pop    %ebx
    11a4:	5e                   	pop    %esi
    11a5:	5d                   	pop    %ebp
    11a6:	c3                   	ret    
    return -1;
    11a7:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11ac:	eb f0                	jmp    119e <stat+0x34>

000011ae <atoi>:

int
atoi(const char *s)
{
    11ae:	55                   	push   %ebp
    11af:	89 e5                	mov    %esp,%ebp
    11b1:	53                   	push   %ebx
    11b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    11b5:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11ba:	eb 10                	jmp    11cc <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11bc:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11bf:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11c2:	83 c1 01             	add    $0x1,%ecx
    11c5:	0f be c0             	movsbl %al,%eax
    11c8:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11cc:	0f b6 01             	movzbl (%ecx),%eax
    11cf:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11d2:	80 fb 09             	cmp    $0x9,%bl
    11d5:	76 e5                	jbe    11bc <atoi+0xe>
  return n;
}
    11d7:	89 d0                	mov    %edx,%eax
    11d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11dc:	c9                   	leave  
    11dd:	c3                   	ret    

000011de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    11de:	55                   	push   %ebp
    11df:	89 e5                	mov    %esp,%ebp
    11e1:	56                   	push   %esi
    11e2:	53                   	push   %ebx
    11e3:	8b 75 08             	mov    0x8(%ebp),%esi
    11e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    11e9:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    11ec:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    11ee:	eb 0d                	jmp    11fd <memmove+0x1f>
    *dst++ = *src++;
    11f0:	0f b6 01             	movzbl (%ecx),%eax
    11f3:	88 02                	mov    %al,(%edx)
    11f5:	8d 49 01             	lea    0x1(%ecx),%ecx
    11f8:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    11fb:	89 d8                	mov    %ebx,%eax
    11fd:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1200:	85 c0                	test   %eax,%eax
    1202:	7f ec                	jg     11f0 <memmove+0x12>
  return vdst;
}
    1204:	89 f0                	mov    %esi,%eax
    1206:	5b                   	pop    %ebx
    1207:	5e                   	pop    %esi
    1208:	5d                   	pop    %ebp
    1209:	c3                   	ret    

0000120a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    120a:	b8 01 00 00 00       	mov    $0x1,%eax
    120f:	cd 40                	int    $0x40
    1211:	c3                   	ret    

00001212 <exit>:
SYSCALL(exit)
    1212:	b8 02 00 00 00       	mov    $0x2,%eax
    1217:	cd 40                	int    $0x40
    1219:	c3                   	ret    

0000121a <wait>:
SYSCALL(wait)
    121a:	b8 03 00 00 00       	mov    $0x3,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <pipe>:
SYSCALL(pipe)
    1222:	b8 04 00 00 00       	mov    $0x4,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <read>:
SYSCALL(read)
    122a:	b8 05 00 00 00       	mov    $0x5,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <write>:
SYSCALL(write)
    1232:	b8 10 00 00 00       	mov    $0x10,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <close>:
SYSCALL(close)
    123a:	b8 15 00 00 00       	mov    $0x15,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    

00001242 <kill>:
SYSCALL(kill)
    1242:	b8 06 00 00 00       	mov    $0x6,%eax
    1247:	cd 40                	int    $0x40
    1249:	c3                   	ret    

0000124a <exec>:
SYSCALL(exec)
    124a:	b8 07 00 00 00       	mov    $0x7,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <open>:
SYSCALL(open)
    1252:	b8 0f 00 00 00       	mov    $0xf,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    

0000125a <mknod>:
SYSCALL(mknod)
    125a:	b8 11 00 00 00       	mov    $0x11,%eax
    125f:	cd 40                	int    $0x40
    1261:	c3                   	ret    

00001262 <unlink>:
SYSCALL(unlink)
    1262:	b8 12 00 00 00       	mov    $0x12,%eax
    1267:	cd 40                	int    $0x40
    1269:	c3                   	ret    

0000126a <fstat>:
SYSCALL(fstat)
    126a:	b8 08 00 00 00       	mov    $0x8,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <link>:
SYSCALL(link)
    1272:	b8 13 00 00 00       	mov    $0x13,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <mkdir>:
SYSCALL(mkdir)
    127a:	b8 14 00 00 00       	mov    $0x14,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <chdir>:
SYSCALL(chdir)
    1282:	b8 09 00 00 00       	mov    $0x9,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <dup>:
SYSCALL(dup)
    128a:	b8 0a 00 00 00       	mov    $0xa,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <getpid>:
SYSCALL(getpid)
    1292:	b8 0b 00 00 00       	mov    $0xb,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <sbrk>:
SYSCALL(sbrk)
    129a:	b8 0c 00 00 00       	mov    $0xc,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <sleep>:
SYSCALL(sleep)
    12a2:	b8 0d 00 00 00       	mov    $0xd,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <uptime>:
SYSCALL(uptime)
    12aa:	b8 0e 00 00 00       	mov    $0xe,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <settickets>:
SYSCALL(settickets)
    12b2:	b8 16 00 00 00       	mov    $0x16,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <getpinfo>:
SYSCALL(getpinfo)
    12ba:	b8 17 00 00 00       	mov    $0x17,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <mprotect>:
SYSCALL(mprotect)
    12c2:	b8 18 00 00 00       	mov    $0x18,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <munprotect>:
    12ca:	b8 19 00 00 00       	mov    $0x19,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12d2:	55                   	push   %ebp
    12d3:	89 e5                	mov    %esp,%ebp
    12d5:	83 ec 1c             	sub    $0x1c,%esp
    12d8:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    12db:	6a 01                	push   $0x1
    12dd:	8d 55 f4             	lea    -0xc(%ebp),%edx
    12e0:	52                   	push   %edx
    12e1:	50                   	push   %eax
    12e2:	e8 4b ff ff ff       	call   1232 <write>
}
    12e7:	83 c4 10             	add    $0x10,%esp
    12ea:	c9                   	leave  
    12eb:	c3                   	ret    

000012ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12ec:	55                   	push   %ebp
    12ed:	89 e5                	mov    %esp,%ebp
    12ef:	57                   	push   %edi
    12f0:	56                   	push   %esi
    12f1:	53                   	push   %ebx
    12f2:	83 ec 2c             	sub    $0x2c,%esp
    12f5:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12f8:	89 d0                	mov    %edx,%eax
    12fa:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12fc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1300:	0f 95 c1             	setne  %cl
    1303:	c1 ea 1f             	shr    $0x1f,%edx
    1306:	84 d1                	test   %dl,%cl
    1308:	74 44                	je     134e <printint+0x62>
    neg = 1;
    x = -xx;
    130a:	f7 d8                	neg    %eax
    130c:	89 c1                	mov    %eax,%ecx
    neg = 1;
    130e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1315:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    131a:	89 c8                	mov    %ecx,%eax
    131c:	ba 00 00 00 00       	mov    $0x0,%edx
    1321:	f7 f6                	div    %esi
    1323:	89 df                	mov    %ebx,%edi
    1325:	83 c3 01             	add    $0x1,%ebx
    1328:	0f b6 92 b0 16 00 00 	movzbl 0x16b0(%edx),%edx
    132f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1333:	89 ca                	mov    %ecx,%edx
    1335:	89 c1                	mov    %eax,%ecx
    1337:	39 d6                	cmp    %edx,%esi
    1339:	76 df                	jbe    131a <printint+0x2e>
  if(neg)
    133b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    133f:	74 31                	je     1372 <printint+0x86>
    buf[i++] = '-';
    1341:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1346:	8d 5f 02             	lea    0x2(%edi),%ebx
    1349:	8b 75 d0             	mov    -0x30(%ebp),%esi
    134c:	eb 17                	jmp    1365 <printint+0x79>
    x = xx;
    134e:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1350:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1357:	eb bc                	jmp    1315 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1359:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    135e:	89 f0                	mov    %esi,%eax
    1360:	e8 6d ff ff ff       	call   12d2 <putc>
  while(--i >= 0)
    1365:	83 eb 01             	sub    $0x1,%ebx
    1368:	79 ef                	jns    1359 <printint+0x6d>
}
    136a:	83 c4 2c             	add    $0x2c,%esp
    136d:	5b                   	pop    %ebx
    136e:	5e                   	pop    %esi
    136f:	5f                   	pop    %edi
    1370:	5d                   	pop    %ebp
    1371:	c3                   	ret    
    1372:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1375:	eb ee                	jmp    1365 <printint+0x79>

00001377 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1377:	55                   	push   %ebp
    1378:	89 e5                	mov    %esp,%ebp
    137a:	57                   	push   %edi
    137b:	56                   	push   %esi
    137c:	53                   	push   %ebx
    137d:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1380:	8d 45 10             	lea    0x10(%ebp),%eax
    1383:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1386:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    138b:	bb 00 00 00 00       	mov    $0x0,%ebx
    1390:	eb 14                	jmp    13a6 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1392:	89 fa                	mov    %edi,%edx
    1394:	8b 45 08             	mov    0x8(%ebp),%eax
    1397:	e8 36 ff ff ff       	call   12d2 <putc>
    139c:	eb 05                	jmp    13a3 <printf+0x2c>
      }
    } else if(state == '%'){
    139e:	83 fe 25             	cmp    $0x25,%esi
    13a1:	74 25                	je     13c8 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    13a3:	83 c3 01             	add    $0x1,%ebx
    13a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a9:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    13ad:	84 c0                	test   %al,%al
    13af:	0f 84 20 01 00 00    	je     14d5 <printf+0x15e>
    c = fmt[i] & 0xff;
    13b5:	0f be f8             	movsbl %al,%edi
    13b8:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13bb:	85 f6                	test   %esi,%esi
    13bd:	75 df                	jne    139e <printf+0x27>
      if(c == '%'){
    13bf:	83 f8 25             	cmp    $0x25,%eax
    13c2:	75 ce                	jne    1392 <printf+0x1b>
        state = '%';
    13c4:	89 c6                	mov    %eax,%esi
    13c6:	eb db                	jmp    13a3 <printf+0x2c>
      if(c == 'd'){
    13c8:	83 f8 25             	cmp    $0x25,%eax
    13cb:	0f 84 cf 00 00 00    	je     14a0 <printf+0x129>
    13d1:	0f 8c dd 00 00 00    	jl     14b4 <printf+0x13d>
    13d7:	83 f8 78             	cmp    $0x78,%eax
    13da:	0f 8f d4 00 00 00    	jg     14b4 <printf+0x13d>
    13e0:	83 f8 63             	cmp    $0x63,%eax
    13e3:	0f 8c cb 00 00 00    	jl     14b4 <printf+0x13d>
    13e9:	83 e8 63             	sub    $0x63,%eax
    13ec:	83 f8 15             	cmp    $0x15,%eax
    13ef:	0f 87 bf 00 00 00    	ja     14b4 <printf+0x13d>
    13f5:	ff 24 85 58 16 00 00 	jmp    *0x1658(,%eax,4)
        printint(fd, *ap, 10, 1);
    13fc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    13ff:	8b 17                	mov    (%edi),%edx
    1401:	83 ec 0c             	sub    $0xc,%esp
    1404:	6a 01                	push   $0x1
    1406:	b9 0a 00 00 00       	mov    $0xa,%ecx
    140b:	8b 45 08             	mov    0x8(%ebp),%eax
    140e:	e8 d9 fe ff ff       	call   12ec <printint>
        ap++;
    1413:	83 c7 04             	add    $0x4,%edi
    1416:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1419:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    141c:	be 00 00 00 00       	mov    $0x0,%esi
    1421:	eb 80                	jmp    13a3 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1423:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1426:	8b 17                	mov    (%edi),%edx
    1428:	83 ec 0c             	sub    $0xc,%esp
    142b:	6a 00                	push   $0x0
    142d:	b9 10 00 00 00       	mov    $0x10,%ecx
    1432:	8b 45 08             	mov    0x8(%ebp),%eax
    1435:	e8 b2 fe ff ff       	call   12ec <printint>
        ap++;
    143a:	83 c7 04             	add    $0x4,%edi
    143d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1440:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1443:	be 00 00 00 00       	mov    $0x0,%esi
    1448:	e9 56 ff ff ff       	jmp    13a3 <printf+0x2c>
        s = (char*)*ap;
    144d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1450:	8b 30                	mov    (%eax),%esi
        ap++;
    1452:	83 c0 04             	add    $0x4,%eax
    1455:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1458:	85 f6                	test   %esi,%esi
    145a:	75 15                	jne    1471 <printf+0xfa>
          s = "(null)";
    145c:	be 51 16 00 00       	mov    $0x1651,%esi
    1461:	eb 0e                	jmp    1471 <printf+0xfa>
          putc(fd, *s);
    1463:	0f be d2             	movsbl %dl,%edx
    1466:	8b 45 08             	mov    0x8(%ebp),%eax
    1469:	e8 64 fe ff ff       	call   12d2 <putc>
          s++;
    146e:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1471:	0f b6 16             	movzbl (%esi),%edx
    1474:	84 d2                	test   %dl,%dl
    1476:	75 eb                	jne    1463 <printf+0xec>
      state = 0;
    1478:	be 00 00 00 00       	mov    $0x0,%esi
    147d:	e9 21 ff ff ff       	jmp    13a3 <printf+0x2c>
        putc(fd, *ap);
    1482:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1485:	0f be 17             	movsbl (%edi),%edx
    1488:	8b 45 08             	mov    0x8(%ebp),%eax
    148b:	e8 42 fe ff ff       	call   12d2 <putc>
        ap++;
    1490:	83 c7 04             	add    $0x4,%edi
    1493:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1496:	be 00 00 00 00       	mov    $0x0,%esi
    149b:	e9 03 ff ff ff       	jmp    13a3 <printf+0x2c>
        putc(fd, c);
    14a0:	89 fa                	mov    %edi,%edx
    14a2:	8b 45 08             	mov    0x8(%ebp),%eax
    14a5:	e8 28 fe ff ff       	call   12d2 <putc>
      state = 0;
    14aa:	be 00 00 00 00       	mov    $0x0,%esi
    14af:	e9 ef fe ff ff       	jmp    13a3 <printf+0x2c>
        putc(fd, '%');
    14b4:	ba 25 00 00 00       	mov    $0x25,%edx
    14b9:	8b 45 08             	mov    0x8(%ebp),%eax
    14bc:	e8 11 fe ff ff       	call   12d2 <putc>
        putc(fd, c);
    14c1:	89 fa                	mov    %edi,%edx
    14c3:	8b 45 08             	mov    0x8(%ebp),%eax
    14c6:	e8 07 fe ff ff       	call   12d2 <putc>
      state = 0;
    14cb:	be 00 00 00 00       	mov    $0x0,%esi
    14d0:	e9 ce fe ff ff       	jmp    13a3 <printf+0x2c>
    }
  }
}
    14d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14d8:	5b                   	pop    %ebx
    14d9:	5e                   	pop    %esi
    14da:	5f                   	pop    %edi
    14db:	5d                   	pop    %ebp
    14dc:	c3                   	ret    

000014dd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14dd:	55                   	push   %ebp
    14de:	89 e5                	mov    %esp,%ebp
    14e0:	57                   	push   %edi
    14e1:	56                   	push   %esi
    14e2:	53                   	push   %ebx
    14e3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14e6:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14e9:	a1 5c 19 00 00       	mov    0x195c,%eax
    14ee:	eb 02                	jmp    14f2 <free+0x15>
    14f0:	89 d0                	mov    %edx,%eax
    14f2:	39 c8                	cmp    %ecx,%eax
    14f4:	73 04                	jae    14fa <free+0x1d>
    14f6:	39 08                	cmp    %ecx,(%eax)
    14f8:	77 12                	ja     150c <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14fa:	8b 10                	mov    (%eax),%edx
    14fc:	39 c2                	cmp    %eax,%edx
    14fe:	77 f0                	ja     14f0 <free+0x13>
    1500:	39 c8                	cmp    %ecx,%eax
    1502:	72 08                	jb     150c <free+0x2f>
    1504:	39 ca                	cmp    %ecx,%edx
    1506:	77 04                	ja     150c <free+0x2f>
    1508:	89 d0                	mov    %edx,%eax
    150a:	eb e6                	jmp    14f2 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    150c:	8b 73 fc             	mov    -0x4(%ebx),%esi
    150f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1512:	8b 10                	mov    (%eax),%edx
    1514:	39 d7                	cmp    %edx,%edi
    1516:	74 19                	je     1531 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1518:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    151b:	8b 50 04             	mov    0x4(%eax),%edx
    151e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1521:	39 ce                	cmp    %ecx,%esi
    1523:	74 1b                	je     1540 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1525:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1527:	a3 5c 19 00 00       	mov    %eax,0x195c
}
    152c:	5b                   	pop    %ebx
    152d:	5e                   	pop    %esi
    152e:	5f                   	pop    %edi
    152f:	5d                   	pop    %ebp
    1530:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1531:	03 72 04             	add    0x4(%edx),%esi
    1534:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1537:	8b 10                	mov    (%eax),%edx
    1539:	8b 12                	mov    (%edx),%edx
    153b:	89 53 f8             	mov    %edx,-0x8(%ebx)
    153e:	eb db                	jmp    151b <free+0x3e>
    p->s.size += bp->s.size;
    1540:	03 53 fc             	add    -0x4(%ebx),%edx
    1543:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1546:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1549:	89 10                	mov    %edx,(%eax)
    154b:	eb da                	jmp    1527 <free+0x4a>

0000154d <morecore>:

static Header*
morecore(uint nu)
{
    154d:	55                   	push   %ebp
    154e:	89 e5                	mov    %esp,%ebp
    1550:	53                   	push   %ebx
    1551:	83 ec 04             	sub    $0x4,%esp
    1554:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1556:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    155b:	77 05                	ja     1562 <morecore+0x15>
    nu = 4096;
    155d:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1562:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1569:	83 ec 0c             	sub    $0xc,%esp
    156c:	50                   	push   %eax
    156d:	e8 28 fd ff ff       	call   129a <sbrk>
  if(p == (char*)-1)
    1572:	83 c4 10             	add    $0x10,%esp
    1575:	83 f8 ff             	cmp    $0xffffffff,%eax
    1578:	74 1c                	je     1596 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    157a:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    157d:	83 c0 08             	add    $0x8,%eax
    1580:	83 ec 0c             	sub    $0xc,%esp
    1583:	50                   	push   %eax
    1584:	e8 54 ff ff ff       	call   14dd <free>
  return freep;
    1589:	a1 5c 19 00 00       	mov    0x195c,%eax
    158e:	83 c4 10             	add    $0x10,%esp
}
    1591:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1594:	c9                   	leave  
    1595:	c3                   	ret    
    return 0;
    1596:	b8 00 00 00 00       	mov    $0x0,%eax
    159b:	eb f4                	jmp    1591 <morecore+0x44>

0000159d <malloc>:

void*
malloc(uint nbytes)
{
    159d:	55                   	push   %ebp
    159e:	89 e5                	mov    %esp,%ebp
    15a0:	53                   	push   %ebx
    15a1:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15a4:	8b 45 08             	mov    0x8(%ebp),%eax
    15a7:	8d 58 07             	lea    0x7(%eax),%ebx
    15aa:	c1 eb 03             	shr    $0x3,%ebx
    15ad:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    15b0:	8b 0d 5c 19 00 00    	mov    0x195c,%ecx
    15b6:	85 c9                	test   %ecx,%ecx
    15b8:	74 04                	je     15be <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15ba:	8b 01                	mov    (%ecx),%eax
    15bc:	eb 4a                	jmp    1608 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15be:	c7 05 5c 19 00 00 60 	movl   $0x1960,0x195c
    15c5:	19 00 00 
    15c8:	c7 05 60 19 00 00 60 	movl   $0x1960,0x1960
    15cf:	19 00 00 
    base.s.size = 0;
    15d2:	c7 05 64 19 00 00 00 	movl   $0x0,0x1964
    15d9:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    15dc:	b9 60 19 00 00       	mov    $0x1960,%ecx
    15e1:	eb d7                	jmp    15ba <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    15e3:	74 19                	je     15fe <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    15e5:	29 da                	sub    %ebx,%edx
    15e7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15ea:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    15ed:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    15f0:	89 0d 5c 19 00 00    	mov    %ecx,0x195c
      return (void*)(p + 1);
    15f6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    15f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15fc:	c9                   	leave  
    15fd:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    15fe:	8b 10                	mov    (%eax),%edx
    1600:	89 11                	mov    %edx,(%ecx)
    1602:	eb ec                	jmp    15f0 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1604:	89 c1                	mov    %eax,%ecx
    1606:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1608:	8b 50 04             	mov    0x4(%eax),%edx
    160b:	39 da                	cmp    %ebx,%edx
    160d:	73 d4                	jae    15e3 <malloc+0x46>
    if(p == freep)
    160f:	39 05 5c 19 00 00    	cmp    %eax,0x195c
    1615:	75 ed                	jne    1604 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1617:	89 d8                	mov    %ebx,%eax
    1619:	e8 2f ff ff ff       	call   154d <morecore>
    161e:	85 c0                	test   %eax,%eax
    1620:	75 e2                	jne    1604 <malloc+0x67>
    1622:	eb d5                	jmp    15f9 <malloc+0x5c>
