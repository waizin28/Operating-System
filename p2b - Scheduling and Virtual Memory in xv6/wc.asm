
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
    1009:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
    1010:	be 00 00 00 00       	mov    $0x0,%esi
    1015:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    101c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1023:	83 ec 04             	sub    $0x4,%esp
    1026:	68 00 02 00 00       	push   $0x200
    102b:	68 a0 1a 00 00       	push   $0x1aa0
    1030:	ff 75 08             	push   0x8(%ebp)
    1033:	e8 e1 02 00 00       	call   1319 <read>
    1038:	89 c7                	mov    %eax,%edi
    103a:	83 c4 10             	add    $0x10,%esp
    103d:	85 c0                	test   %eax,%eax
    103f:	7e 54                	jle    1095 <wc+0x95>
    for(i=0; i<n; i++){
    1041:	bb 00 00 00 00       	mov    $0x0,%ebx
    1046:	eb 22                	jmp    106a <wc+0x6a>
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
    1048:	83 ec 08             	sub    $0x8,%esp
    104b:	0f be c0             	movsbl %al,%eax
    104e:	50                   	push   %eax
    104f:	68 14 17 00 00       	push   $0x1714
    1054:	e8 86 01 00 00       	call   11df <strchr>
    1059:	83 c4 10             	add    $0x10,%esp
    105c:	85 c0                	test   %eax,%eax
    105e:	74 22                	je     1082 <wc+0x82>
        inword = 0;
    1060:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
    1067:	83 c3 01             	add    $0x1,%ebx
    106a:	39 fb                	cmp    %edi,%ebx
    106c:	7d b5                	jge    1023 <wc+0x23>
      c++;
    106e:	83 c6 01             	add    $0x1,%esi
      if(buf[i] == '\n')
    1071:	0f b6 83 a0 1a 00 00 	movzbl 0x1aa0(%ebx),%eax
    1078:	3c 0a                	cmp    $0xa,%al
    107a:	75 cc                	jne    1048 <wc+0x48>
        l++;
    107c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1080:	eb c6                	jmp    1048 <wc+0x48>
      else if(!inword){
    1082:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1086:	75 df                	jne    1067 <wc+0x67>
        w++;
    1088:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
        inword = 1;
    108c:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    1093:	eb d2                	jmp    1067 <wc+0x67>
      }
    }
  }
  if(n < 0){
    1095:	78 24                	js     10bb <wc+0xbb>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    1097:	83 ec 08             	sub    $0x8,%esp
    109a:	ff 75 0c             	push   0xc(%ebp)
    109d:	56                   	push   %esi
    109e:	ff 75 dc             	push   -0x24(%ebp)
    10a1:	ff 75 e0             	push   -0x20(%ebp)
    10a4:	68 2a 17 00 00       	push   $0x172a
    10a9:	6a 01                	push   $0x1
    10ab:	e8 b6 03 00 00       	call   1466 <printf>
}
    10b0:	83 c4 20             	add    $0x20,%esp
    10b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10b6:	5b                   	pop    %ebx
    10b7:	5e                   	pop    %esi
    10b8:	5f                   	pop    %edi
    10b9:	5d                   	pop    %ebp
    10ba:	c3                   	ret    
    printf(1, "wc: read error\n");
    10bb:	83 ec 08             	sub    $0x8,%esp
    10be:	68 1a 17 00 00       	push   $0x171a
    10c3:	6a 01                	push   $0x1
    10c5:	e8 9c 03 00 00       	call   1466 <printf>
    exit();
    10ca:	e8 32 02 00 00       	call   1301 <exit>

000010cf <main>:

int
main(int argc, char *argv[])
{
    10cf:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    10d3:	83 e4 f0             	and    $0xfffffff0,%esp
    10d6:	ff 71 fc             	push   -0x4(%ecx)
    10d9:	55                   	push   %ebp
    10da:	89 e5                	mov    %esp,%ebp
    10dc:	57                   	push   %edi
    10dd:	56                   	push   %esi
    10de:	53                   	push   %ebx
    10df:	51                   	push   %ecx
    10e0:	83 ec 18             	sub    $0x18,%esp
    10e3:	8b 01                	mov    (%ecx),%eax
    10e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10e8:	8b 51 04             	mov    0x4(%ecx),%edx
    10eb:	89 55 e0             	mov    %edx,-0x20(%ebp)
  int fd, i;

  if(argc <= 1){
    10ee:	83 f8 01             	cmp    $0x1,%eax
    10f1:	7e 07                	jle    10fa <main+0x2b>
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    10f3:	be 01 00 00 00       	mov    $0x1,%esi
    10f8:	eb 2d                	jmp    1127 <main+0x58>
    wc(0, "");
    10fa:	83 ec 08             	sub    $0x8,%esp
    10fd:	68 29 17 00 00       	push   $0x1729
    1102:	6a 00                	push   $0x0
    1104:	e8 f7 fe ff ff       	call   1000 <wc>
    exit();
    1109:	e8 f3 01 00 00       	call   1301 <exit>
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
    110e:	83 ec 08             	sub    $0x8,%esp
    1111:	ff 37                	push   (%edi)
    1113:	50                   	push   %eax
    1114:	e8 e7 fe ff ff       	call   1000 <wc>
    close(fd);
    1119:	89 1c 24             	mov    %ebx,(%esp)
    111c:	e8 08 02 00 00       	call   1329 <close>
  for(i = 1; i < argc; i++){
    1121:	83 c6 01             	add    $0x1,%esi
    1124:	83 c4 10             	add    $0x10,%esp
    1127:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
    112a:	7d 31                	jge    115d <main+0x8e>
    if((fd = open(argv[i], 0)) < 0){
    112c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    112f:	8d 3c b0             	lea    (%eax,%esi,4),%edi
    1132:	83 ec 08             	sub    $0x8,%esp
    1135:	6a 00                	push   $0x0
    1137:	ff 37                	push   (%edi)
    1139:	e8 03 02 00 00       	call   1341 <open>
    113e:	89 c3                	mov    %eax,%ebx
    1140:	83 c4 10             	add    $0x10,%esp
    1143:	85 c0                	test   %eax,%eax
    1145:	79 c7                	jns    110e <main+0x3f>
      printf(1, "wc: cannot open %s\n", argv[i]);
    1147:	83 ec 04             	sub    $0x4,%esp
    114a:	ff 37                	push   (%edi)
    114c:	68 37 17 00 00       	push   $0x1737
    1151:	6a 01                	push   $0x1
    1153:	e8 0e 03 00 00       	call   1466 <printf>
      exit();
    1158:	e8 a4 01 00 00       	call   1301 <exit>
  }
  exit();
    115d:	e8 9f 01 00 00       	call   1301 <exit>

00001162 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1162:	55                   	push   %ebp
    1163:	89 e5                	mov    %esp,%ebp
    1165:	56                   	push   %esi
    1166:	53                   	push   %ebx
    1167:	8b 75 08             	mov    0x8(%ebp),%esi
    116a:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    116d:	89 f0                	mov    %esi,%eax
    116f:	89 d1                	mov    %edx,%ecx
    1171:	83 c2 01             	add    $0x1,%edx
    1174:	89 c3                	mov    %eax,%ebx
    1176:	83 c0 01             	add    $0x1,%eax
    1179:	0f b6 09             	movzbl (%ecx),%ecx
    117c:	88 0b                	mov    %cl,(%ebx)
    117e:	84 c9                	test   %cl,%cl
    1180:	75 ed                	jne    116f <strcpy+0xd>
    ;
  return os;
}
    1182:	89 f0                	mov    %esi,%eax
    1184:	5b                   	pop    %ebx
    1185:	5e                   	pop    %esi
    1186:	5d                   	pop    %ebp
    1187:	c3                   	ret    

00001188 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1188:	55                   	push   %ebp
    1189:	89 e5                	mov    %esp,%ebp
    118b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    118e:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1191:	eb 06                	jmp    1199 <strcmp+0x11>
    p++, q++;
    1193:	83 c1 01             	add    $0x1,%ecx
    1196:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1199:	0f b6 01             	movzbl (%ecx),%eax
    119c:	84 c0                	test   %al,%al
    119e:	74 04                	je     11a4 <strcmp+0x1c>
    11a0:	3a 02                	cmp    (%edx),%al
    11a2:	74 ef                	je     1193 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    11a4:	0f b6 c0             	movzbl %al,%eax
    11a7:	0f b6 12             	movzbl (%edx),%edx
    11aa:	29 d0                	sub    %edx,%eax
}
    11ac:	5d                   	pop    %ebp
    11ad:	c3                   	ret    

000011ae <strlen>:

uint
strlen(const char *s)
{
    11ae:	55                   	push   %ebp
    11af:	89 e5                	mov    %esp,%ebp
    11b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11b4:	b8 00 00 00 00       	mov    $0x0,%eax
    11b9:	eb 03                	jmp    11be <strlen+0x10>
    11bb:	83 c0 01             	add    $0x1,%eax
    11be:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    11c2:	75 f7                	jne    11bb <strlen+0xd>
    ;
  return n;
}
    11c4:	5d                   	pop    %ebp
    11c5:	c3                   	ret    

000011c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11c6:	55                   	push   %ebp
    11c7:	89 e5                	mov    %esp,%ebp
    11c9:	57                   	push   %edi
    11ca:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11cd:	89 d7                	mov    %edx,%edi
    11cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d5:	fc                   	cld    
    11d6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11d8:	89 d0                	mov    %edx,%eax
    11da:	8b 7d fc             	mov    -0x4(%ebp),%edi
    11dd:	c9                   	leave  
    11de:	c3                   	ret    

000011df <strchr>:

char*
strchr(const char *s, char c)
{
    11df:	55                   	push   %ebp
    11e0:	89 e5                	mov    %esp,%ebp
    11e2:	8b 45 08             	mov    0x8(%ebp),%eax
    11e5:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11e9:	eb 03                	jmp    11ee <strchr+0xf>
    11eb:	83 c0 01             	add    $0x1,%eax
    11ee:	0f b6 10             	movzbl (%eax),%edx
    11f1:	84 d2                	test   %dl,%dl
    11f3:	74 06                	je     11fb <strchr+0x1c>
    if(*s == c)
    11f5:	38 ca                	cmp    %cl,%dl
    11f7:	75 f2                	jne    11eb <strchr+0xc>
    11f9:	eb 05                	jmp    1200 <strchr+0x21>
      return (char*)s;
  return 0;
    11fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1200:	5d                   	pop    %ebp
    1201:	c3                   	ret    

00001202 <gets>:

char*
gets(char *buf, int max)
{
    1202:	55                   	push   %ebp
    1203:	89 e5                	mov    %esp,%ebp
    1205:	57                   	push   %edi
    1206:	56                   	push   %esi
    1207:	53                   	push   %ebx
    1208:	83 ec 1c             	sub    $0x1c,%esp
    120b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    120e:	bb 00 00 00 00       	mov    $0x0,%ebx
    1213:	89 de                	mov    %ebx,%esi
    1215:	83 c3 01             	add    $0x1,%ebx
    1218:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    121b:	7d 2e                	jge    124b <gets+0x49>
    cc = read(0, &c, 1);
    121d:	83 ec 04             	sub    $0x4,%esp
    1220:	6a 01                	push   $0x1
    1222:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1225:	50                   	push   %eax
    1226:	6a 00                	push   $0x0
    1228:	e8 ec 00 00 00       	call   1319 <read>
    if(cc < 1)
    122d:	83 c4 10             	add    $0x10,%esp
    1230:	85 c0                	test   %eax,%eax
    1232:	7e 17                	jle    124b <gets+0x49>
      break;
    buf[i++] = c;
    1234:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1238:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    123b:	3c 0a                	cmp    $0xa,%al
    123d:	0f 94 c2             	sete   %dl
    1240:	3c 0d                	cmp    $0xd,%al
    1242:	0f 94 c0             	sete   %al
    1245:	08 c2                	or     %al,%dl
    1247:	74 ca                	je     1213 <gets+0x11>
    buf[i++] = c;
    1249:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    124b:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    124f:	89 f8                	mov    %edi,%eax
    1251:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1254:	5b                   	pop    %ebx
    1255:	5e                   	pop    %esi
    1256:	5f                   	pop    %edi
    1257:	5d                   	pop    %ebp
    1258:	c3                   	ret    

00001259 <stat>:

int
stat(const char *n, struct stat *st)
{
    1259:	55                   	push   %ebp
    125a:	89 e5                	mov    %esp,%ebp
    125c:	56                   	push   %esi
    125d:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    125e:	83 ec 08             	sub    $0x8,%esp
    1261:	6a 00                	push   $0x0
    1263:	ff 75 08             	push   0x8(%ebp)
    1266:	e8 d6 00 00 00       	call   1341 <open>
  if(fd < 0)
    126b:	83 c4 10             	add    $0x10,%esp
    126e:	85 c0                	test   %eax,%eax
    1270:	78 24                	js     1296 <stat+0x3d>
    1272:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1274:	83 ec 08             	sub    $0x8,%esp
    1277:	ff 75 0c             	push   0xc(%ebp)
    127a:	50                   	push   %eax
    127b:	e8 d9 00 00 00       	call   1359 <fstat>
    1280:	89 c6                	mov    %eax,%esi
  close(fd);
    1282:	89 1c 24             	mov    %ebx,(%esp)
    1285:	e8 9f 00 00 00       	call   1329 <close>
  return r;
    128a:	83 c4 10             	add    $0x10,%esp
}
    128d:	89 f0                	mov    %esi,%eax
    128f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1292:	5b                   	pop    %ebx
    1293:	5e                   	pop    %esi
    1294:	5d                   	pop    %ebp
    1295:	c3                   	ret    
    return -1;
    1296:	be ff ff ff ff       	mov    $0xffffffff,%esi
    129b:	eb f0                	jmp    128d <stat+0x34>

0000129d <atoi>:

int
atoi(const char *s)
{
    129d:	55                   	push   %ebp
    129e:	89 e5                	mov    %esp,%ebp
    12a0:	53                   	push   %ebx
    12a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    12a4:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    12a9:	eb 10                	jmp    12bb <atoi+0x1e>
    n = n*10 + *s++ - '0';
    12ab:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    12ae:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    12b1:	83 c1 01             	add    $0x1,%ecx
    12b4:	0f be c0             	movsbl %al,%eax
    12b7:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    12bb:	0f b6 01             	movzbl (%ecx),%eax
    12be:	8d 58 d0             	lea    -0x30(%eax),%ebx
    12c1:	80 fb 09             	cmp    $0x9,%bl
    12c4:	76 e5                	jbe    12ab <atoi+0xe>
  return n;
}
    12c6:	89 d0                	mov    %edx,%eax
    12c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12cb:	c9                   	leave  
    12cc:	c3                   	ret    

000012cd <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12cd:	55                   	push   %ebp
    12ce:	89 e5                	mov    %esp,%ebp
    12d0:	56                   	push   %esi
    12d1:	53                   	push   %ebx
    12d2:	8b 75 08             	mov    0x8(%ebp),%esi
    12d5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    12d8:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    12db:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    12dd:	eb 0d                	jmp    12ec <memmove+0x1f>
    *dst++ = *src++;
    12df:	0f b6 01             	movzbl (%ecx),%eax
    12e2:	88 02                	mov    %al,(%edx)
    12e4:	8d 49 01             	lea    0x1(%ecx),%ecx
    12e7:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    12ea:	89 d8                	mov    %ebx,%eax
    12ec:	8d 58 ff             	lea    -0x1(%eax),%ebx
    12ef:	85 c0                	test   %eax,%eax
    12f1:	7f ec                	jg     12df <memmove+0x12>
  return vdst;
}
    12f3:	89 f0                	mov    %esi,%eax
    12f5:	5b                   	pop    %ebx
    12f6:	5e                   	pop    %esi
    12f7:	5d                   	pop    %ebp
    12f8:	c3                   	ret    

000012f9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12f9:	b8 01 00 00 00       	mov    $0x1,%eax
    12fe:	cd 40                	int    $0x40
    1300:	c3                   	ret    

00001301 <exit>:
SYSCALL(exit)
    1301:	b8 02 00 00 00       	mov    $0x2,%eax
    1306:	cd 40                	int    $0x40
    1308:	c3                   	ret    

00001309 <wait>:
SYSCALL(wait)
    1309:	b8 03 00 00 00       	mov    $0x3,%eax
    130e:	cd 40                	int    $0x40
    1310:	c3                   	ret    

00001311 <pipe>:
SYSCALL(pipe)
    1311:	b8 04 00 00 00       	mov    $0x4,%eax
    1316:	cd 40                	int    $0x40
    1318:	c3                   	ret    

00001319 <read>:
SYSCALL(read)
    1319:	b8 05 00 00 00       	mov    $0x5,%eax
    131e:	cd 40                	int    $0x40
    1320:	c3                   	ret    

00001321 <write>:
SYSCALL(write)
    1321:	b8 10 00 00 00       	mov    $0x10,%eax
    1326:	cd 40                	int    $0x40
    1328:	c3                   	ret    

00001329 <close>:
SYSCALL(close)
    1329:	b8 15 00 00 00       	mov    $0x15,%eax
    132e:	cd 40                	int    $0x40
    1330:	c3                   	ret    

00001331 <kill>:
SYSCALL(kill)
    1331:	b8 06 00 00 00       	mov    $0x6,%eax
    1336:	cd 40                	int    $0x40
    1338:	c3                   	ret    

00001339 <exec>:
SYSCALL(exec)
    1339:	b8 07 00 00 00       	mov    $0x7,%eax
    133e:	cd 40                	int    $0x40
    1340:	c3                   	ret    

00001341 <open>:
SYSCALL(open)
    1341:	b8 0f 00 00 00       	mov    $0xf,%eax
    1346:	cd 40                	int    $0x40
    1348:	c3                   	ret    

00001349 <mknod>:
SYSCALL(mknod)
    1349:	b8 11 00 00 00       	mov    $0x11,%eax
    134e:	cd 40                	int    $0x40
    1350:	c3                   	ret    

00001351 <unlink>:
SYSCALL(unlink)
    1351:	b8 12 00 00 00       	mov    $0x12,%eax
    1356:	cd 40                	int    $0x40
    1358:	c3                   	ret    

00001359 <fstat>:
SYSCALL(fstat)
    1359:	b8 08 00 00 00       	mov    $0x8,%eax
    135e:	cd 40                	int    $0x40
    1360:	c3                   	ret    

00001361 <link>:
SYSCALL(link)
    1361:	b8 13 00 00 00       	mov    $0x13,%eax
    1366:	cd 40                	int    $0x40
    1368:	c3                   	ret    

00001369 <mkdir>:
SYSCALL(mkdir)
    1369:	b8 14 00 00 00       	mov    $0x14,%eax
    136e:	cd 40                	int    $0x40
    1370:	c3                   	ret    

00001371 <chdir>:
SYSCALL(chdir)
    1371:	b8 09 00 00 00       	mov    $0x9,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <dup>:
SYSCALL(dup)
    1379:	b8 0a 00 00 00       	mov    $0xa,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <getpid>:
SYSCALL(getpid)
    1381:	b8 0b 00 00 00       	mov    $0xb,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <sbrk>:
SYSCALL(sbrk)
    1389:	b8 0c 00 00 00       	mov    $0xc,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <sleep>:
SYSCALL(sleep)
    1391:	b8 0d 00 00 00       	mov    $0xd,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <uptime>:
SYSCALL(uptime)
    1399:	b8 0e 00 00 00       	mov    $0xe,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <settickets>:
SYSCALL(settickets)
    13a1:	b8 16 00 00 00       	mov    $0x16,%eax
    13a6:	cd 40                	int    $0x40
    13a8:	c3                   	ret    

000013a9 <getpinfo>:
SYSCALL(getpinfo)
    13a9:	b8 17 00 00 00       	mov    $0x17,%eax
    13ae:	cd 40                	int    $0x40
    13b0:	c3                   	ret    

000013b1 <mprotect>:
SYSCALL(mprotect)
    13b1:	b8 18 00 00 00       	mov    $0x18,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    

000013b9 <munprotect>:
    13b9:	b8 19 00 00 00       	mov    $0x19,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13c1:	55                   	push   %ebp
    13c2:	89 e5                	mov    %esp,%ebp
    13c4:	83 ec 1c             	sub    $0x1c,%esp
    13c7:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    13ca:	6a 01                	push   $0x1
    13cc:	8d 55 f4             	lea    -0xc(%ebp),%edx
    13cf:	52                   	push   %edx
    13d0:	50                   	push   %eax
    13d1:	e8 4b ff ff ff       	call   1321 <write>
}
    13d6:	83 c4 10             	add    $0x10,%esp
    13d9:	c9                   	leave  
    13da:	c3                   	ret    

000013db <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13db:	55                   	push   %ebp
    13dc:	89 e5                	mov    %esp,%ebp
    13de:	57                   	push   %edi
    13df:	56                   	push   %esi
    13e0:	53                   	push   %ebx
    13e1:	83 ec 2c             	sub    $0x2c,%esp
    13e4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    13e7:	89 d0                	mov    %edx,%eax
    13e9:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    13ef:	0f 95 c1             	setne  %cl
    13f2:	c1 ea 1f             	shr    $0x1f,%edx
    13f5:	84 d1                	test   %dl,%cl
    13f7:	74 44                	je     143d <printint+0x62>
    neg = 1;
    x = -xx;
    13f9:	f7 d8                	neg    %eax
    13fb:	89 c1                	mov    %eax,%ecx
    neg = 1;
    13fd:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1404:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1409:	89 c8                	mov    %ecx,%eax
    140b:	ba 00 00 00 00       	mov    $0x0,%edx
    1410:	f7 f6                	div    %esi
    1412:	89 df                	mov    %ebx,%edi
    1414:	83 c3 01             	add    $0x1,%ebx
    1417:	0f b6 92 ac 17 00 00 	movzbl 0x17ac(%edx),%edx
    141e:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1422:	89 ca                	mov    %ecx,%edx
    1424:	89 c1                	mov    %eax,%ecx
    1426:	39 d6                	cmp    %edx,%esi
    1428:	76 df                	jbe    1409 <printint+0x2e>
  if(neg)
    142a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    142e:	74 31                	je     1461 <printint+0x86>
    buf[i++] = '-';
    1430:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1435:	8d 5f 02             	lea    0x2(%edi),%ebx
    1438:	8b 75 d0             	mov    -0x30(%ebp),%esi
    143b:	eb 17                	jmp    1454 <printint+0x79>
    x = xx;
    143d:	89 c1                	mov    %eax,%ecx
  neg = 0;
    143f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1446:	eb bc                	jmp    1404 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1448:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    144d:	89 f0                	mov    %esi,%eax
    144f:	e8 6d ff ff ff       	call   13c1 <putc>
  while(--i >= 0)
    1454:	83 eb 01             	sub    $0x1,%ebx
    1457:	79 ef                	jns    1448 <printint+0x6d>
}
    1459:	83 c4 2c             	add    $0x2c,%esp
    145c:	5b                   	pop    %ebx
    145d:	5e                   	pop    %esi
    145e:	5f                   	pop    %edi
    145f:	5d                   	pop    %ebp
    1460:	c3                   	ret    
    1461:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1464:	eb ee                	jmp    1454 <printint+0x79>

00001466 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1466:	55                   	push   %ebp
    1467:	89 e5                	mov    %esp,%ebp
    1469:	57                   	push   %edi
    146a:	56                   	push   %esi
    146b:	53                   	push   %ebx
    146c:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    146f:	8d 45 10             	lea    0x10(%ebp),%eax
    1472:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1475:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    147a:	bb 00 00 00 00       	mov    $0x0,%ebx
    147f:	eb 14                	jmp    1495 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1481:	89 fa                	mov    %edi,%edx
    1483:	8b 45 08             	mov    0x8(%ebp),%eax
    1486:	e8 36 ff ff ff       	call   13c1 <putc>
    148b:	eb 05                	jmp    1492 <printf+0x2c>
      }
    } else if(state == '%'){
    148d:	83 fe 25             	cmp    $0x25,%esi
    1490:	74 25                	je     14b7 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1492:	83 c3 01             	add    $0x1,%ebx
    1495:	8b 45 0c             	mov    0xc(%ebp),%eax
    1498:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    149c:	84 c0                	test   %al,%al
    149e:	0f 84 20 01 00 00    	je     15c4 <printf+0x15e>
    c = fmt[i] & 0xff;
    14a4:	0f be f8             	movsbl %al,%edi
    14a7:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    14aa:	85 f6                	test   %esi,%esi
    14ac:	75 df                	jne    148d <printf+0x27>
      if(c == '%'){
    14ae:	83 f8 25             	cmp    $0x25,%eax
    14b1:	75 ce                	jne    1481 <printf+0x1b>
        state = '%';
    14b3:	89 c6                	mov    %eax,%esi
    14b5:	eb db                	jmp    1492 <printf+0x2c>
      if(c == 'd'){
    14b7:	83 f8 25             	cmp    $0x25,%eax
    14ba:	0f 84 cf 00 00 00    	je     158f <printf+0x129>
    14c0:	0f 8c dd 00 00 00    	jl     15a3 <printf+0x13d>
    14c6:	83 f8 78             	cmp    $0x78,%eax
    14c9:	0f 8f d4 00 00 00    	jg     15a3 <printf+0x13d>
    14cf:	83 f8 63             	cmp    $0x63,%eax
    14d2:	0f 8c cb 00 00 00    	jl     15a3 <printf+0x13d>
    14d8:	83 e8 63             	sub    $0x63,%eax
    14db:	83 f8 15             	cmp    $0x15,%eax
    14de:	0f 87 bf 00 00 00    	ja     15a3 <printf+0x13d>
    14e4:	ff 24 85 54 17 00 00 	jmp    *0x1754(,%eax,4)
        printint(fd, *ap, 10, 1);
    14eb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14ee:	8b 17                	mov    (%edi),%edx
    14f0:	83 ec 0c             	sub    $0xc,%esp
    14f3:	6a 01                	push   $0x1
    14f5:	b9 0a 00 00 00       	mov    $0xa,%ecx
    14fa:	8b 45 08             	mov    0x8(%ebp),%eax
    14fd:	e8 d9 fe ff ff       	call   13db <printint>
        ap++;
    1502:	83 c7 04             	add    $0x4,%edi
    1505:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1508:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    150b:	be 00 00 00 00       	mov    $0x0,%esi
    1510:	eb 80                	jmp    1492 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1512:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1515:	8b 17                	mov    (%edi),%edx
    1517:	83 ec 0c             	sub    $0xc,%esp
    151a:	6a 00                	push   $0x0
    151c:	b9 10 00 00 00       	mov    $0x10,%ecx
    1521:	8b 45 08             	mov    0x8(%ebp),%eax
    1524:	e8 b2 fe ff ff       	call   13db <printint>
        ap++;
    1529:	83 c7 04             	add    $0x4,%edi
    152c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    152f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1532:	be 00 00 00 00       	mov    $0x0,%esi
    1537:	e9 56 ff ff ff       	jmp    1492 <printf+0x2c>
        s = (char*)*ap;
    153c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    153f:	8b 30                	mov    (%eax),%esi
        ap++;
    1541:	83 c0 04             	add    $0x4,%eax
    1544:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1547:	85 f6                	test   %esi,%esi
    1549:	75 15                	jne    1560 <printf+0xfa>
          s = "(null)";
    154b:	be 4b 17 00 00       	mov    $0x174b,%esi
    1550:	eb 0e                	jmp    1560 <printf+0xfa>
          putc(fd, *s);
    1552:	0f be d2             	movsbl %dl,%edx
    1555:	8b 45 08             	mov    0x8(%ebp),%eax
    1558:	e8 64 fe ff ff       	call   13c1 <putc>
          s++;
    155d:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1560:	0f b6 16             	movzbl (%esi),%edx
    1563:	84 d2                	test   %dl,%dl
    1565:	75 eb                	jne    1552 <printf+0xec>
      state = 0;
    1567:	be 00 00 00 00       	mov    $0x0,%esi
    156c:	e9 21 ff ff ff       	jmp    1492 <printf+0x2c>
        putc(fd, *ap);
    1571:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1574:	0f be 17             	movsbl (%edi),%edx
    1577:	8b 45 08             	mov    0x8(%ebp),%eax
    157a:	e8 42 fe ff ff       	call   13c1 <putc>
        ap++;
    157f:	83 c7 04             	add    $0x4,%edi
    1582:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1585:	be 00 00 00 00       	mov    $0x0,%esi
    158a:	e9 03 ff ff ff       	jmp    1492 <printf+0x2c>
        putc(fd, c);
    158f:	89 fa                	mov    %edi,%edx
    1591:	8b 45 08             	mov    0x8(%ebp),%eax
    1594:	e8 28 fe ff ff       	call   13c1 <putc>
      state = 0;
    1599:	be 00 00 00 00       	mov    $0x0,%esi
    159e:	e9 ef fe ff ff       	jmp    1492 <printf+0x2c>
        putc(fd, '%');
    15a3:	ba 25 00 00 00       	mov    $0x25,%edx
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	e8 11 fe ff ff       	call   13c1 <putc>
        putc(fd, c);
    15b0:	89 fa                	mov    %edi,%edx
    15b2:	8b 45 08             	mov    0x8(%ebp),%eax
    15b5:	e8 07 fe ff ff       	call   13c1 <putc>
      state = 0;
    15ba:	be 00 00 00 00       	mov    $0x0,%esi
    15bf:	e9 ce fe ff ff       	jmp    1492 <printf+0x2c>
    }
  }
}
    15c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15c7:	5b                   	pop    %ebx
    15c8:	5e                   	pop    %esi
    15c9:	5f                   	pop    %edi
    15ca:	5d                   	pop    %ebp
    15cb:	c3                   	ret    

000015cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15cc:	55                   	push   %ebp
    15cd:	89 e5                	mov    %esp,%ebp
    15cf:	57                   	push   %edi
    15d0:	56                   	push   %esi
    15d1:	53                   	push   %ebx
    15d2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15d5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d8:	a1 a0 1c 00 00       	mov    0x1ca0,%eax
    15dd:	eb 02                	jmp    15e1 <free+0x15>
    15df:	89 d0                	mov    %edx,%eax
    15e1:	39 c8                	cmp    %ecx,%eax
    15e3:	73 04                	jae    15e9 <free+0x1d>
    15e5:	39 08                	cmp    %ecx,(%eax)
    15e7:	77 12                	ja     15fb <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15e9:	8b 10                	mov    (%eax),%edx
    15eb:	39 c2                	cmp    %eax,%edx
    15ed:	77 f0                	ja     15df <free+0x13>
    15ef:	39 c8                	cmp    %ecx,%eax
    15f1:	72 08                	jb     15fb <free+0x2f>
    15f3:	39 ca                	cmp    %ecx,%edx
    15f5:	77 04                	ja     15fb <free+0x2f>
    15f7:	89 d0                	mov    %edx,%eax
    15f9:	eb e6                	jmp    15e1 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    15fb:	8b 73 fc             	mov    -0x4(%ebx),%esi
    15fe:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1601:	8b 10                	mov    (%eax),%edx
    1603:	39 d7                	cmp    %edx,%edi
    1605:	74 19                	je     1620 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1607:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    160a:	8b 50 04             	mov    0x4(%eax),%edx
    160d:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1610:	39 ce                	cmp    %ecx,%esi
    1612:	74 1b                	je     162f <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1614:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1616:	a3 a0 1c 00 00       	mov    %eax,0x1ca0
}
    161b:	5b                   	pop    %ebx
    161c:	5e                   	pop    %esi
    161d:	5f                   	pop    %edi
    161e:	5d                   	pop    %ebp
    161f:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1620:	03 72 04             	add    0x4(%edx),%esi
    1623:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1626:	8b 10                	mov    (%eax),%edx
    1628:	8b 12                	mov    (%edx),%edx
    162a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    162d:	eb db                	jmp    160a <free+0x3e>
    p->s.size += bp->s.size;
    162f:	03 53 fc             	add    -0x4(%ebx),%edx
    1632:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1635:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1638:	89 10                	mov    %edx,(%eax)
    163a:	eb da                	jmp    1616 <free+0x4a>

0000163c <morecore>:

static Header*
morecore(uint nu)
{
    163c:	55                   	push   %ebp
    163d:	89 e5                	mov    %esp,%ebp
    163f:	53                   	push   %ebx
    1640:	83 ec 04             	sub    $0x4,%esp
    1643:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1645:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    164a:	77 05                	ja     1651 <morecore+0x15>
    nu = 4096;
    164c:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1651:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1658:	83 ec 0c             	sub    $0xc,%esp
    165b:	50                   	push   %eax
    165c:	e8 28 fd ff ff       	call   1389 <sbrk>
  if(p == (char*)-1)
    1661:	83 c4 10             	add    $0x10,%esp
    1664:	83 f8 ff             	cmp    $0xffffffff,%eax
    1667:	74 1c                	je     1685 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1669:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    166c:	83 c0 08             	add    $0x8,%eax
    166f:	83 ec 0c             	sub    $0xc,%esp
    1672:	50                   	push   %eax
    1673:	e8 54 ff ff ff       	call   15cc <free>
  return freep;
    1678:	a1 a0 1c 00 00       	mov    0x1ca0,%eax
    167d:	83 c4 10             	add    $0x10,%esp
}
    1680:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1683:	c9                   	leave  
    1684:	c3                   	ret    
    return 0;
    1685:	b8 00 00 00 00       	mov    $0x0,%eax
    168a:	eb f4                	jmp    1680 <morecore+0x44>

0000168c <malloc>:

void*
malloc(uint nbytes)
{
    168c:	55                   	push   %ebp
    168d:	89 e5                	mov    %esp,%ebp
    168f:	53                   	push   %ebx
    1690:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1693:	8b 45 08             	mov    0x8(%ebp),%eax
    1696:	8d 58 07             	lea    0x7(%eax),%ebx
    1699:	c1 eb 03             	shr    $0x3,%ebx
    169c:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    169f:	8b 0d a0 1c 00 00    	mov    0x1ca0,%ecx
    16a5:	85 c9                	test   %ecx,%ecx
    16a7:	74 04                	je     16ad <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16a9:	8b 01                	mov    (%ecx),%eax
    16ab:	eb 4a                	jmp    16f7 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    16ad:	c7 05 a0 1c 00 00 a4 	movl   $0x1ca4,0x1ca0
    16b4:	1c 00 00 
    16b7:	c7 05 a4 1c 00 00 a4 	movl   $0x1ca4,0x1ca4
    16be:	1c 00 00 
    base.s.size = 0;
    16c1:	c7 05 a8 1c 00 00 00 	movl   $0x0,0x1ca8
    16c8:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    16cb:	b9 a4 1c 00 00       	mov    $0x1ca4,%ecx
    16d0:	eb d7                	jmp    16a9 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    16d2:	74 19                	je     16ed <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    16d4:	29 da                	sub    %ebx,%edx
    16d6:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    16d9:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    16dc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    16df:	89 0d a0 1c 00 00    	mov    %ecx,0x1ca0
      return (void*)(p + 1);
    16e5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    16e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16eb:	c9                   	leave  
    16ec:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    16ed:	8b 10                	mov    (%eax),%edx
    16ef:	89 11                	mov    %edx,(%ecx)
    16f1:	eb ec                	jmp    16df <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16f3:	89 c1                	mov    %eax,%ecx
    16f5:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    16f7:	8b 50 04             	mov    0x4(%eax),%edx
    16fa:	39 da                	cmp    %ebx,%edx
    16fc:	73 d4                	jae    16d2 <malloc+0x46>
    if(p == freep)
    16fe:	39 05 a0 1c 00 00    	cmp    %eax,0x1ca0
    1704:	75 ed                	jne    16f3 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1706:	89 d8                	mov    %ebx,%eax
    1708:	e8 2f ff ff ff       	call   163c <morecore>
    170d:	85 c0                	test   %eax,%eax
    170f:	75 e2                	jne    16f3 <malloc+0x67>
    1711:	eb d5                	jmp    16e8 <malloc+0x5c>
