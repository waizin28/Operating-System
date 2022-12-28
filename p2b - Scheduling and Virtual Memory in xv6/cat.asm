
_cat:     file format elf32-i386


Disassembly of section .text:

00001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
    1005:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1008:	83 ec 04             	sub    $0x4,%esp
    100b:	68 00 02 00 00       	push   $0x200
    1010:	68 20 1a 00 00       	push   $0x1a20
    1015:	56                   	push   %esi
    1016:	e8 94 02 00 00       	call   12af <read>
    101b:	89 c3                	mov    %eax,%ebx
    101d:	83 c4 10             	add    $0x10,%esp
    1020:	85 c0                	test   %eax,%eax
    1022:	7e 2b                	jle    104f <cat+0x4f>
    if (write(1, buf, n) != n) {
    1024:	83 ec 04             	sub    $0x4,%esp
    1027:	53                   	push   %ebx
    1028:	68 20 1a 00 00       	push   $0x1a20
    102d:	6a 01                	push   $0x1
    102f:	e8 83 02 00 00       	call   12b7 <write>
    1034:	83 c4 10             	add    $0x10,%esp
    1037:	39 d8                	cmp    %ebx,%eax
    1039:	74 cd                	je     1008 <cat+0x8>
      printf(1, "cat: write error\n");
    103b:	83 ec 08             	sub    $0x8,%esp
    103e:	68 ac 16 00 00       	push   $0x16ac
    1043:	6a 01                	push   $0x1
    1045:	e8 b2 03 00 00       	call   13fc <printf>
      exit();
    104a:	e8 48 02 00 00       	call   1297 <exit>
    }
  }
  if(n < 0){
    104f:	78 07                	js     1058 <cat+0x58>
    printf(1, "cat: read error\n");
    exit();
  }
}
    1051:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1054:	5b                   	pop    %ebx
    1055:	5e                   	pop    %esi
    1056:	5d                   	pop    %ebp
    1057:	c3                   	ret    
    printf(1, "cat: read error\n");
    1058:	83 ec 08             	sub    $0x8,%esp
    105b:	68 be 16 00 00       	push   $0x16be
    1060:	6a 01                	push   $0x1
    1062:	e8 95 03 00 00       	call   13fc <printf>
    exit();
    1067:	e8 2b 02 00 00       	call   1297 <exit>

0000106c <main>:

int
main(int argc, char *argv[])
{
    106c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1070:	83 e4 f0             	and    $0xfffffff0,%esp
    1073:	ff 71 fc             	push   -0x4(%ecx)
    1076:	55                   	push   %ebp
    1077:	89 e5                	mov    %esp,%ebp
    1079:	57                   	push   %edi
    107a:	56                   	push   %esi
    107b:	53                   	push   %ebx
    107c:	51                   	push   %ecx
    107d:	83 ec 18             	sub    $0x18,%esp
    1080:	8b 01                	mov    (%ecx),%eax
    1082:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1085:	8b 51 04             	mov    0x4(%ecx),%edx
    1088:	89 55 e0             	mov    %edx,-0x20(%ebp)
  int fd, i;

  if(argc <= 1){
    108b:	83 f8 01             	cmp    $0x1,%eax
    108e:	7e 07                	jle    1097 <main+0x2b>
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    1090:	be 01 00 00 00       	mov    $0x1,%esi
    1095:	eb 26                	jmp    10bd <main+0x51>
    cat(0);
    1097:	83 ec 0c             	sub    $0xc,%esp
    109a:	6a 00                	push   $0x0
    109c:	e8 5f ff ff ff       	call   1000 <cat>
    exit();
    10a1:	e8 f1 01 00 00       	call   1297 <exit>
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
    10a6:	83 ec 0c             	sub    $0xc,%esp
    10a9:	50                   	push   %eax
    10aa:	e8 51 ff ff ff       	call   1000 <cat>
    close(fd);
    10af:	89 1c 24             	mov    %ebx,(%esp)
    10b2:	e8 08 02 00 00       	call   12bf <close>
  for(i = 1; i < argc; i++){
    10b7:	83 c6 01             	add    $0x1,%esi
    10ba:	83 c4 10             	add    $0x10,%esp
    10bd:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
    10c0:	7d 31                	jge    10f3 <main+0x87>
    if((fd = open(argv[i], 0)) < 0){
    10c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10c5:	8d 3c b0             	lea    (%eax,%esi,4),%edi
    10c8:	83 ec 08             	sub    $0x8,%esp
    10cb:	6a 00                	push   $0x0
    10cd:	ff 37                	push   (%edi)
    10cf:	e8 03 02 00 00       	call   12d7 <open>
    10d4:	89 c3                	mov    %eax,%ebx
    10d6:	83 c4 10             	add    $0x10,%esp
    10d9:	85 c0                	test   %eax,%eax
    10db:	79 c9                	jns    10a6 <main+0x3a>
      printf(1, "cat: cannot open %s\n", argv[i]);
    10dd:	83 ec 04             	sub    $0x4,%esp
    10e0:	ff 37                	push   (%edi)
    10e2:	68 cf 16 00 00       	push   $0x16cf
    10e7:	6a 01                	push   $0x1
    10e9:	e8 0e 03 00 00       	call   13fc <printf>
      exit();
    10ee:	e8 a4 01 00 00       	call   1297 <exit>
  }
  exit();
    10f3:	e8 9f 01 00 00       	call   1297 <exit>

000010f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10f8:	55                   	push   %ebp
    10f9:	89 e5                	mov    %esp,%ebp
    10fb:	56                   	push   %esi
    10fc:	53                   	push   %ebx
    10fd:	8b 75 08             	mov    0x8(%ebp),%esi
    1100:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1103:	89 f0                	mov    %esi,%eax
    1105:	89 d1                	mov    %edx,%ecx
    1107:	83 c2 01             	add    $0x1,%edx
    110a:	89 c3                	mov    %eax,%ebx
    110c:	83 c0 01             	add    $0x1,%eax
    110f:	0f b6 09             	movzbl (%ecx),%ecx
    1112:	88 0b                	mov    %cl,(%ebx)
    1114:	84 c9                	test   %cl,%cl
    1116:	75 ed                	jne    1105 <strcpy+0xd>
    ;
  return os;
}
    1118:	89 f0                	mov    %esi,%eax
    111a:	5b                   	pop    %ebx
    111b:	5e                   	pop    %esi
    111c:	5d                   	pop    %ebp
    111d:	c3                   	ret    

0000111e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    111e:	55                   	push   %ebp
    111f:	89 e5                	mov    %esp,%ebp
    1121:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1124:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1127:	eb 06                	jmp    112f <strcmp+0x11>
    p++, q++;
    1129:	83 c1 01             	add    $0x1,%ecx
    112c:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    112f:	0f b6 01             	movzbl (%ecx),%eax
    1132:	84 c0                	test   %al,%al
    1134:	74 04                	je     113a <strcmp+0x1c>
    1136:	3a 02                	cmp    (%edx),%al
    1138:	74 ef                	je     1129 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    113a:	0f b6 c0             	movzbl %al,%eax
    113d:	0f b6 12             	movzbl (%edx),%edx
    1140:	29 d0                	sub    %edx,%eax
}
    1142:	5d                   	pop    %ebp
    1143:	c3                   	ret    

00001144 <strlen>:

uint
strlen(const char *s)
{
    1144:	55                   	push   %ebp
    1145:	89 e5                	mov    %esp,%ebp
    1147:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    114a:	b8 00 00 00 00       	mov    $0x0,%eax
    114f:	eb 03                	jmp    1154 <strlen+0x10>
    1151:	83 c0 01             	add    $0x1,%eax
    1154:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    1158:	75 f7                	jne    1151 <strlen+0xd>
    ;
  return n;
}
    115a:	5d                   	pop    %ebp
    115b:	c3                   	ret    

0000115c <memset>:

void*
memset(void *dst, int c, uint n)
{
    115c:	55                   	push   %ebp
    115d:	89 e5                	mov    %esp,%ebp
    115f:	57                   	push   %edi
    1160:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1163:	89 d7                	mov    %edx,%edi
    1165:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1168:	8b 45 0c             	mov    0xc(%ebp),%eax
    116b:	fc                   	cld    
    116c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    116e:	89 d0                	mov    %edx,%eax
    1170:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1173:	c9                   	leave  
    1174:	c3                   	ret    

00001175 <strchr>:

char*
strchr(const char *s, char c)
{
    1175:	55                   	push   %ebp
    1176:	89 e5                	mov    %esp,%ebp
    1178:	8b 45 08             	mov    0x8(%ebp),%eax
    117b:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    117f:	eb 03                	jmp    1184 <strchr+0xf>
    1181:	83 c0 01             	add    $0x1,%eax
    1184:	0f b6 10             	movzbl (%eax),%edx
    1187:	84 d2                	test   %dl,%dl
    1189:	74 06                	je     1191 <strchr+0x1c>
    if(*s == c)
    118b:	38 ca                	cmp    %cl,%dl
    118d:	75 f2                	jne    1181 <strchr+0xc>
    118f:	eb 05                	jmp    1196 <strchr+0x21>
      return (char*)s;
  return 0;
    1191:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1196:	5d                   	pop    %ebp
    1197:	c3                   	ret    

00001198 <gets>:

char*
gets(char *buf, int max)
{
    1198:	55                   	push   %ebp
    1199:	89 e5                	mov    %esp,%ebp
    119b:	57                   	push   %edi
    119c:	56                   	push   %esi
    119d:	53                   	push   %ebx
    119e:	83 ec 1c             	sub    $0x1c,%esp
    11a1:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11a4:	bb 00 00 00 00       	mov    $0x0,%ebx
    11a9:	89 de                	mov    %ebx,%esi
    11ab:	83 c3 01             	add    $0x1,%ebx
    11ae:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11b1:	7d 2e                	jge    11e1 <gets+0x49>
    cc = read(0, &c, 1);
    11b3:	83 ec 04             	sub    $0x4,%esp
    11b6:	6a 01                	push   $0x1
    11b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11bb:	50                   	push   %eax
    11bc:	6a 00                	push   $0x0
    11be:	e8 ec 00 00 00       	call   12af <read>
    if(cc < 1)
    11c3:	83 c4 10             	add    $0x10,%esp
    11c6:	85 c0                	test   %eax,%eax
    11c8:	7e 17                	jle    11e1 <gets+0x49>
      break;
    buf[i++] = c;
    11ca:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11ce:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    11d1:	3c 0a                	cmp    $0xa,%al
    11d3:	0f 94 c2             	sete   %dl
    11d6:	3c 0d                	cmp    $0xd,%al
    11d8:	0f 94 c0             	sete   %al
    11db:	08 c2                	or     %al,%dl
    11dd:	74 ca                	je     11a9 <gets+0x11>
    buf[i++] = c;
    11df:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    11e1:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    11e5:	89 f8                	mov    %edi,%eax
    11e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11ea:	5b                   	pop    %ebx
    11eb:	5e                   	pop    %esi
    11ec:	5f                   	pop    %edi
    11ed:	5d                   	pop    %ebp
    11ee:	c3                   	ret    

000011ef <stat>:

int
stat(const char *n, struct stat *st)
{
    11ef:	55                   	push   %ebp
    11f0:	89 e5                	mov    %esp,%ebp
    11f2:	56                   	push   %esi
    11f3:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11f4:	83 ec 08             	sub    $0x8,%esp
    11f7:	6a 00                	push   $0x0
    11f9:	ff 75 08             	push   0x8(%ebp)
    11fc:	e8 d6 00 00 00       	call   12d7 <open>
  if(fd < 0)
    1201:	83 c4 10             	add    $0x10,%esp
    1204:	85 c0                	test   %eax,%eax
    1206:	78 24                	js     122c <stat+0x3d>
    1208:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    120a:	83 ec 08             	sub    $0x8,%esp
    120d:	ff 75 0c             	push   0xc(%ebp)
    1210:	50                   	push   %eax
    1211:	e8 d9 00 00 00       	call   12ef <fstat>
    1216:	89 c6                	mov    %eax,%esi
  close(fd);
    1218:	89 1c 24             	mov    %ebx,(%esp)
    121b:	e8 9f 00 00 00       	call   12bf <close>
  return r;
    1220:	83 c4 10             	add    $0x10,%esp
}
    1223:	89 f0                	mov    %esi,%eax
    1225:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1228:	5b                   	pop    %ebx
    1229:	5e                   	pop    %esi
    122a:	5d                   	pop    %ebp
    122b:	c3                   	ret    
    return -1;
    122c:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1231:	eb f0                	jmp    1223 <stat+0x34>

00001233 <atoi>:

int
atoi(const char *s)
{
    1233:	55                   	push   %ebp
    1234:	89 e5                	mov    %esp,%ebp
    1236:	53                   	push   %ebx
    1237:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    123a:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    123f:	eb 10                	jmp    1251 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1241:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1244:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1247:	83 c1 01             	add    $0x1,%ecx
    124a:	0f be c0             	movsbl %al,%eax
    124d:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1251:	0f b6 01             	movzbl (%ecx),%eax
    1254:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1257:	80 fb 09             	cmp    $0x9,%bl
    125a:	76 e5                	jbe    1241 <atoi+0xe>
  return n;
}
    125c:	89 d0                	mov    %edx,%eax
    125e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1261:	c9                   	leave  
    1262:	c3                   	ret    

00001263 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1263:	55                   	push   %ebp
    1264:	89 e5                	mov    %esp,%ebp
    1266:	56                   	push   %esi
    1267:	53                   	push   %ebx
    1268:	8b 75 08             	mov    0x8(%ebp),%esi
    126b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    126e:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1271:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1273:	eb 0d                	jmp    1282 <memmove+0x1f>
    *dst++ = *src++;
    1275:	0f b6 01             	movzbl (%ecx),%eax
    1278:	88 02                	mov    %al,(%edx)
    127a:	8d 49 01             	lea    0x1(%ecx),%ecx
    127d:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1280:	89 d8                	mov    %ebx,%eax
    1282:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1285:	85 c0                	test   %eax,%eax
    1287:	7f ec                	jg     1275 <memmove+0x12>
  return vdst;
}
    1289:	89 f0                	mov    %esi,%eax
    128b:	5b                   	pop    %ebx
    128c:	5e                   	pop    %esi
    128d:	5d                   	pop    %ebp
    128e:	c3                   	ret    

0000128f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    128f:	b8 01 00 00 00       	mov    $0x1,%eax
    1294:	cd 40                	int    $0x40
    1296:	c3                   	ret    

00001297 <exit>:
SYSCALL(exit)
    1297:	b8 02 00 00 00       	mov    $0x2,%eax
    129c:	cd 40                	int    $0x40
    129e:	c3                   	ret    

0000129f <wait>:
SYSCALL(wait)
    129f:	b8 03 00 00 00       	mov    $0x3,%eax
    12a4:	cd 40                	int    $0x40
    12a6:	c3                   	ret    

000012a7 <pipe>:
SYSCALL(pipe)
    12a7:	b8 04 00 00 00       	mov    $0x4,%eax
    12ac:	cd 40                	int    $0x40
    12ae:	c3                   	ret    

000012af <read>:
SYSCALL(read)
    12af:	b8 05 00 00 00       	mov    $0x5,%eax
    12b4:	cd 40                	int    $0x40
    12b6:	c3                   	ret    

000012b7 <write>:
SYSCALL(write)
    12b7:	b8 10 00 00 00       	mov    $0x10,%eax
    12bc:	cd 40                	int    $0x40
    12be:	c3                   	ret    

000012bf <close>:
SYSCALL(close)
    12bf:	b8 15 00 00 00       	mov    $0x15,%eax
    12c4:	cd 40                	int    $0x40
    12c6:	c3                   	ret    

000012c7 <kill>:
SYSCALL(kill)
    12c7:	b8 06 00 00 00       	mov    $0x6,%eax
    12cc:	cd 40                	int    $0x40
    12ce:	c3                   	ret    

000012cf <exec>:
SYSCALL(exec)
    12cf:	b8 07 00 00 00       	mov    $0x7,%eax
    12d4:	cd 40                	int    $0x40
    12d6:	c3                   	ret    

000012d7 <open>:
SYSCALL(open)
    12d7:	b8 0f 00 00 00       	mov    $0xf,%eax
    12dc:	cd 40                	int    $0x40
    12de:	c3                   	ret    

000012df <mknod>:
SYSCALL(mknod)
    12df:	b8 11 00 00 00       	mov    $0x11,%eax
    12e4:	cd 40                	int    $0x40
    12e6:	c3                   	ret    

000012e7 <unlink>:
SYSCALL(unlink)
    12e7:	b8 12 00 00 00       	mov    $0x12,%eax
    12ec:	cd 40                	int    $0x40
    12ee:	c3                   	ret    

000012ef <fstat>:
SYSCALL(fstat)
    12ef:	b8 08 00 00 00       	mov    $0x8,%eax
    12f4:	cd 40                	int    $0x40
    12f6:	c3                   	ret    

000012f7 <link>:
SYSCALL(link)
    12f7:	b8 13 00 00 00       	mov    $0x13,%eax
    12fc:	cd 40                	int    $0x40
    12fe:	c3                   	ret    

000012ff <mkdir>:
SYSCALL(mkdir)
    12ff:	b8 14 00 00 00       	mov    $0x14,%eax
    1304:	cd 40                	int    $0x40
    1306:	c3                   	ret    

00001307 <chdir>:
SYSCALL(chdir)
    1307:	b8 09 00 00 00       	mov    $0x9,%eax
    130c:	cd 40                	int    $0x40
    130e:	c3                   	ret    

0000130f <dup>:
SYSCALL(dup)
    130f:	b8 0a 00 00 00       	mov    $0xa,%eax
    1314:	cd 40                	int    $0x40
    1316:	c3                   	ret    

00001317 <getpid>:
SYSCALL(getpid)
    1317:	b8 0b 00 00 00       	mov    $0xb,%eax
    131c:	cd 40                	int    $0x40
    131e:	c3                   	ret    

0000131f <sbrk>:
SYSCALL(sbrk)
    131f:	b8 0c 00 00 00       	mov    $0xc,%eax
    1324:	cd 40                	int    $0x40
    1326:	c3                   	ret    

00001327 <sleep>:
SYSCALL(sleep)
    1327:	b8 0d 00 00 00       	mov    $0xd,%eax
    132c:	cd 40                	int    $0x40
    132e:	c3                   	ret    

0000132f <uptime>:
SYSCALL(uptime)
    132f:	b8 0e 00 00 00       	mov    $0xe,%eax
    1334:	cd 40                	int    $0x40
    1336:	c3                   	ret    

00001337 <settickets>:
SYSCALL(settickets)
    1337:	b8 16 00 00 00       	mov    $0x16,%eax
    133c:	cd 40                	int    $0x40
    133e:	c3                   	ret    

0000133f <getpinfo>:
SYSCALL(getpinfo)
    133f:	b8 17 00 00 00       	mov    $0x17,%eax
    1344:	cd 40                	int    $0x40
    1346:	c3                   	ret    

00001347 <mprotect>:
SYSCALL(mprotect)
    1347:	b8 18 00 00 00       	mov    $0x18,%eax
    134c:	cd 40                	int    $0x40
    134e:	c3                   	ret    

0000134f <munprotect>:
    134f:	b8 19 00 00 00       	mov    $0x19,%eax
    1354:	cd 40                	int    $0x40
    1356:	c3                   	ret    

00001357 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1357:	55                   	push   %ebp
    1358:	89 e5                	mov    %esp,%ebp
    135a:	83 ec 1c             	sub    $0x1c,%esp
    135d:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1360:	6a 01                	push   $0x1
    1362:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1365:	52                   	push   %edx
    1366:	50                   	push   %eax
    1367:	e8 4b ff ff ff       	call   12b7 <write>
}
    136c:	83 c4 10             	add    $0x10,%esp
    136f:	c9                   	leave  
    1370:	c3                   	ret    

00001371 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1371:	55                   	push   %ebp
    1372:	89 e5                	mov    %esp,%ebp
    1374:	57                   	push   %edi
    1375:	56                   	push   %esi
    1376:	53                   	push   %ebx
    1377:	83 ec 2c             	sub    $0x2c,%esp
    137a:	89 45 d0             	mov    %eax,-0x30(%ebp)
    137d:	89 d0                	mov    %edx,%eax
    137f:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1381:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1385:	0f 95 c1             	setne  %cl
    1388:	c1 ea 1f             	shr    $0x1f,%edx
    138b:	84 d1                	test   %dl,%cl
    138d:	74 44                	je     13d3 <printint+0x62>
    neg = 1;
    x = -xx;
    138f:	f7 d8                	neg    %eax
    1391:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1393:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    139a:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    139f:	89 c8                	mov    %ecx,%eax
    13a1:	ba 00 00 00 00       	mov    $0x0,%edx
    13a6:	f7 f6                	div    %esi
    13a8:	89 df                	mov    %ebx,%edi
    13aa:	83 c3 01             	add    $0x1,%ebx
    13ad:	0f b6 92 44 17 00 00 	movzbl 0x1744(%edx),%edx
    13b4:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    13b8:	89 ca                	mov    %ecx,%edx
    13ba:	89 c1                	mov    %eax,%ecx
    13bc:	39 d6                	cmp    %edx,%esi
    13be:	76 df                	jbe    139f <printint+0x2e>
  if(neg)
    13c0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    13c4:	74 31                	je     13f7 <printint+0x86>
    buf[i++] = '-';
    13c6:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    13cb:	8d 5f 02             	lea    0x2(%edi),%ebx
    13ce:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13d1:	eb 17                	jmp    13ea <printint+0x79>
    x = xx;
    13d3:	89 c1                	mov    %eax,%ecx
  neg = 0;
    13d5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    13dc:	eb bc                	jmp    139a <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    13de:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    13e3:	89 f0                	mov    %esi,%eax
    13e5:	e8 6d ff ff ff       	call   1357 <putc>
  while(--i >= 0)
    13ea:	83 eb 01             	sub    $0x1,%ebx
    13ed:	79 ef                	jns    13de <printint+0x6d>
}
    13ef:	83 c4 2c             	add    $0x2c,%esp
    13f2:	5b                   	pop    %ebx
    13f3:	5e                   	pop    %esi
    13f4:	5f                   	pop    %edi
    13f5:	5d                   	pop    %ebp
    13f6:	c3                   	ret    
    13f7:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13fa:	eb ee                	jmp    13ea <printint+0x79>

000013fc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    13fc:	55                   	push   %ebp
    13fd:	89 e5                	mov    %esp,%ebp
    13ff:	57                   	push   %edi
    1400:	56                   	push   %esi
    1401:	53                   	push   %ebx
    1402:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1405:	8d 45 10             	lea    0x10(%ebp),%eax
    1408:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    140b:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1410:	bb 00 00 00 00       	mov    $0x0,%ebx
    1415:	eb 14                	jmp    142b <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1417:	89 fa                	mov    %edi,%edx
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
    141c:	e8 36 ff ff ff       	call   1357 <putc>
    1421:	eb 05                	jmp    1428 <printf+0x2c>
      }
    } else if(state == '%'){
    1423:	83 fe 25             	cmp    $0x25,%esi
    1426:	74 25                	je     144d <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1428:	83 c3 01             	add    $0x1,%ebx
    142b:	8b 45 0c             	mov    0xc(%ebp),%eax
    142e:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1432:	84 c0                	test   %al,%al
    1434:	0f 84 20 01 00 00    	je     155a <printf+0x15e>
    c = fmt[i] & 0xff;
    143a:	0f be f8             	movsbl %al,%edi
    143d:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1440:	85 f6                	test   %esi,%esi
    1442:	75 df                	jne    1423 <printf+0x27>
      if(c == '%'){
    1444:	83 f8 25             	cmp    $0x25,%eax
    1447:	75 ce                	jne    1417 <printf+0x1b>
        state = '%';
    1449:	89 c6                	mov    %eax,%esi
    144b:	eb db                	jmp    1428 <printf+0x2c>
      if(c == 'd'){
    144d:	83 f8 25             	cmp    $0x25,%eax
    1450:	0f 84 cf 00 00 00    	je     1525 <printf+0x129>
    1456:	0f 8c dd 00 00 00    	jl     1539 <printf+0x13d>
    145c:	83 f8 78             	cmp    $0x78,%eax
    145f:	0f 8f d4 00 00 00    	jg     1539 <printf+0x13d>
    1465:	83 f8 63             	cmp    $0x63,%eax
    1468:	0f 8c cb 00 00 00    	jl     1539 <printf+0x13d>
    146e:	83 e8 63             	sub    $0x63,%eax
    1471:	83 f8 15             	cmp    $0x15,%eax
    1474:	0f 87 bf 00 00 00    	ja     1539 <printf+0x13d>
    147a:	ff 24 85 ec 16 00 00 	jmp    *0x16ec(,%eax,4)
        printint(fd, *ap, 10, 1);
    1481:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1484:	8b 17                	mov    (%edi),%edx
    1486:	83 ec 0c             	sub    $0xc,%esp
    1489:	6a 01                	push   $0x1
    148b:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
    1493:	e8 d9 fe ff ff       	call   1371 <printint>
        ap++;
    1498:	83 c7 04             	add    $0x4,%edi
    149b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    149e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14a1:	be 00 00 00 00       	mov    $0x0,%esi
    14a6:	eb 80                	jmp    1428 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    14a8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14ab:	8b 17                	mov    (%edi),%edx
    14ad:	83 ec 0c             	sub    $0xc,%esp
    14b0:	6a 00                	push   $0x0
    14b2:	b9 10 00 00 00       	mov    $0x10,%ecx
    14b7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ba:	e8 b2 fe ff ff       	call   1371 <printint>
        ap++;
    14bf:	83 c7 04             	add    $0x4,%edi
    14c2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    14c5:	83 c4 10             	add    $0x10,%esp
      state = 0;
    14c8:	be 00 00 00 00       	mov    $0x0,%esi
    14cd:	e9 56 ff ff ff       	jmp    1428 <printf+0x2c>
        s = (char*)*ap;
    14d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14d5:	8b 30                	mov    (%eax),%esi
        ap++;
    14d7:	83 c0 04             	add    $0x4,%eax
    14da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    14dd:	85 f6                	test   %esi,%esi
    14df:	75 15                	jne    14f6 <printf+0xfa>
          s = "(null)";
    14e1:	be e4 16 00 00       	mov    $0x16e4,%esi
    14e6:	eb 0e                	jmp    14f6 <printf+0xfa>
          putc(fd, *s);
    14e8:	0f be d2             	movsbl %dl,%edx
    14eb:	8b 45 08             	mov    0x8(%ebp),%eax
    14ee:	e8 64 fe ff ff       	call   1357 <putc>
          s++;
    14f3:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    14f6:	0f b6 16             	movzbl (%esi),%edx
    14f9:	84 d2                	test   %dl,%dl
    14fb:	75 eb                	jne    14e8 <printf+0xec>
      state = 0;
    14fd:	be 00 00 00 00       	mov    $0x0,%esi
    1502:	e9 21 ff ff ff       	jmp    1428 <printf+0x2c>
        putc(fd, *ap);
    1507:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    150a:	0f be 17             	movsbl (%edi),%edx
    150d:	8b 45 08             	mov    0x8(%ebp),%eax
    1510:	e8 42 fe ff ff       	call   1357 <putc>
        ap++;
    1515:	83 c7 04             	add    $0x4,%edi
    1518:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    151b:	be 00 00 00 00       	mov    $0x0,%esi
    1520:	e9 03 ff ff ff       	jmp    1428 <printf+0x2c>
        putc(fd, c);
    1525:	89 fa                	mov    %edi,%edx
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	e8 28 fe ff ff       	call   1357 <putc>
      state = 0;
    152f:	be 00 00 00 00       	mov    $0x0,%esi
    1534:	e9 ef fe ff ff       	jmp    1428 <printf+0x2c>
        putc(fd, '%');
    1539:	ba 25 00 00 00       	mov    $0x25,%edx
    153e:	8b 45 08             	mov    0x8(%ebp),%eax
    1541:	e8 11 fe ff ff       	call   1357 <putc>
        putc(fd, c);
    1546:	89 fa                	mov    %edi,%edx
    1548:	8b 45 08             	mov    0x8(%ebp),%eax
    154b:	e8 07 fe ff ff       	call   1357 <putc>
      state = 0;
    1550:	be 00 00 00 00       	mov    $0x0,%esi
    1555:	e9 ce fe ff ff       	jmp    1428 <printf+0x2c>
    }
  }
}
    155a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    155d:	5b                   	pop    %ebx
    155e:	5e                   	pop    %esi
    155f:	5f                   	pop    %edi
    1560:	5d                   	pop    %ebp
    1561:	c3                   	ret    

00001562 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1562:	55                   	push   %ebp
    1563:	89 e5                	mov    %esp,%ebp
    1565:	57                   	push   %edi
    1566:	56                   	push   %esi
    1567:	53                   	push   %ebx
    1568:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    156b:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    156e:	a1 20 1c 00 00       	mov    0x1c20,%eax
    1573:	eb 02                	jmp    1577 <free+0x15>
    1575:	89 d0                	mov    %edx,%eax
    1577:	39 c8                	cmp    %ecx,%eax
    1579:	73 04                	jae    157f <free+0x1d>
    157b:	39 08                	cmp    %ecx,(%eax)
    157d:	77 12                	ja     1591 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    157f:	8b 10                	mov    (%eax),%edx
    1581:	39 c2                	cmp    %eax,%edx
    1583:	77 f0                	ja     1575 <free+0x13>
    1585:	39 c8                	cmp    %ecx,%eax
    1587:	72 08                	jb     1591 <free+0x2f>
    1589:	39 ca                	cmp    %ecx,%edx
    158b:	77 04                	ja     1591 <free+0x2f>
    158d:	89 d0                	mov    %edx,%eax
    158f:	eb e6                	jmp    1577 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1591:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1594:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1597:	8b 10                	mov    (%eax),%edx
    1599:	39 d7                	cmp    %edx,%edi
    159b:	74 19                	je     15b6 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    159d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15a0:	8b 50 04             	mov    0x4(%eax),%edx
    15a3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15a6:	39 ce                	cmp    %ecx,%esi
    15a8:	74 1b                	je     15c5 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    15aa:	89 08                	mov    %ecx,(%eax)
  freep = p;
    15ac:	a3 20 1c 00 00       	mov    %eax,0x1c20
}
    15b1:	5b                   	pop    %ebx
    15b2:	5e                   	pop    %esi
    15b3:	5f                   	pop    %edi
    15b4:	5d                   	pop    %ebp
    15b5:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    15b6:	03 72 04             	add    0x4(%edx),%esi
    15b9:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    15bc:	8b 10                	mov    (%eax),%edx
    15be:	8b 12                	mov    (%edx),%edx
    15c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
    15c3:	eb db                	jmp    15a0 <free+0x3e>
    p->s.size += bp->s.size;
    15c5:	03 53 fc             	add    -0x4(%ebx),%edx
    15c8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15cb:	8b 53 f8             	mov    -0x8(%ebx),%edx
    15ce:	89 10                	mov    %edx,(%eax)
    15d0:	eb da                	jmp    15ac <free+0x4a>

000015d2 <morecore>:

static Header*
morecore(uint nu)
{
    15d2:	55                   	push   %ebp
    15d3:	89 e5                	mov    %esp,%ebp
    15d5:	53                   	push   %ebx
    15d6:	83 ec 04             	sub    $0x4,%esp
    15d9:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    15db:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    15e0:	77 05                	ja     15e7 <morecore+0x15>
    nu = 4096;
    15e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    15e7:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    15ee:	83 ec 0c             	sub    $0xc,%esp
    15f1:	50                   	push   %eax
    15f2:	e8 28 fd ff ff       	call   131f <sbrk>
  if(p == (char*)-1)
    15f7:	83 c4 10             	add    $0x10,%esp
    15fa:	83 f8 ff             	cmp    $0xffffffff,%eax
    15fd:	74 1c                	je     161b <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    15ff:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1602:	83 c0 08             	add    $0x8,%eax
    1605:	83 ec 0c             	sub    $0xc,%esp
    1608:	50                   	push   %eax
    1609:	e8 54 ff ff ff       	call   1562 <free>
  return freep;
    160e:	a1 20 1c 00 00       	mov    0x1c20,%eax
    1613:	83 c4 10             	add    $0x10,%esp
}
    1616:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1619:	c9                   	leave  
    161a:	c3                   	ret    
    return 0;
    161b:	b8 00 00 00 00       	mov    $0x0,%eax
    1620:	eb f4                	jmp    1616 <morecore+0x44>

00001622 <malloc>:

void*
malloc(uint nbytes)
{
    1622:	55                   	push   %ebp
    1623:	89 e5                	mov    %esp,%ebp
    1625:	53                   	push   %ebx
    1626:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1629:	8b 45 08             	mov    0x8(%ebp),%eax
    162c:	8d 58 07             	lea    0x7(%eax),%ebx
    162f:	c1 eb 03             	shr    $0x3,%ebx
    1632:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1635:	8b 0d 20 1c 00 00    	mov    0x1c20,%ecx
    163b:	85 c9                	test   %ecx,%ecx
    163d:	74 04                	je     1643 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    163f:	8b 01                	mov    (%ecx),%eax
    1641:	eb 4a                	jmp    168d <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1643:	c7 05 20 1c 00 00 24 	movl   $0x1c24,0x1c20
    164a:	1c 00 00 
    164d:	c7 05 24 1c 00 00 24 	movl   $0x1c24,0x1c24
    1654:	1c 00 00 
    base.s.size = 0;
    1657:	c7 05 28 1c 00 00 00 	movl   $0x0,0x1c28
    165e:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1661:	b9 24 1c 00 00       	mov    $0x1c24,%ecx
    1666:	eb d7                	jmp    163f <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1668:	74 19                	je     1683 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    166a:	29 da                	sub    %ebx,%edx
    166c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    166f:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1672:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1675:	89 0d 20 1c 00 00    	mov    %ecx,0x1c20
      return (void*)(p + 1);
    167b:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    167e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1681:	c9                   	leave  
    1682:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1683:	8b 10                	mov    (%eax),%edx
    1685:	89 11                	mov    %edx,(%ecx)
    1687:	eb ec                	jmp    1675 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1689:	89 c1                	mov    %eax,%ecx
    168b:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    168d:	8b 50 04             	mov    0x4(%eax),%edx
    1690:	39 da                	cmp    %ebx,%edx
    1692:	73 d4                	jae    1668 <malloc+0x46>
    if(p == freep)
    1694:	39 05 20 1c 00 00    	cmp    %eax,0x1c20
    169a:	75 ed                	jne    1689 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    169c:	89 d8                	mov    %ebx,%eax
    169e:	e8 2f ff ff ff       	call   15d2 <morecore>
    16a3:	85 c0                	test   %eax,%eax
    16a5:	75 e2                	jne    1689 <malloc+0x67>
    16a7:	eb d5                	jmp    167e <malloc+0x5c>
