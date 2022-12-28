
_stressfs:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	56                   	push   %esi
    100e:	53                   	push   %ebx
    100f:	51                   	push   %ecx
    1010:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
    1016:	c7 45 de 73 74 72 65 	movl   $0x65727473,-0x22(%ebp)
    101d:	c7 45 e2 73 73 66 73 	movl   $0x73667373,-0x1e(%ebp)
    1024:	66 c7 45 e6 30 00    	movw   $0x30,-0x1a(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
    102a:	68 d0 16 00 00       	push   $0x16d0
    102f:	6a 01                	push   $0x1
    1031:	e8 ea 03 00 00       	call   1420 <printf>
  memset(data, 'a', sizeof(data));
    1036:	83 c4 0c             	add    $0xc,%esp
    1039:	68 00 02 00 00       	push   $0x200
    103e:	6a 61                	push   $0x61
    1040:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
    1046:	50                   	push   %eax
    1047:	e8 34 01 00 00       	call   1180 <memset>

  for(i = 0; i < 4; i++)
    104c:	83 c4 10             	add    $0x10,%esp
    104f:	bb 00 00 00 00       	mov    $0x0,%ebx
    1054:	83 fb 03             	cmp    $0x3,%ebx
    1057:	7f 0e                	jg     1067 <main+0x67>
    if(fork() > 0)
    1059:	e8 55 02 00 00       	call   12b3 <fork>
    105e:	85 c0                	test   %eax,%eax
    1060:	7f 05                	jg     1067 <main+0x67>
  for(i = 0; i < 4; i++)
    1062:	83 c3 01             	add    $0x1,%ebx
    1065:	eb ed                	jmp    1054 <main+0x54>
      break;

  printf(1, "write %d\n", i);
    1067:	83 ec 04             	sub    $0x4,%esp
    106a:	53                   	push   %ebx
    106b:	68 e3 16 00 00       	push   $0x16e3
    1070:	6a 01                	push   $0x1
    1072:	e8 a9 03 00 00       	call   1420 <printf>

  path[8] += i;
    1077:	00 5d e6             	add    %bl,-0x1a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
    107a:	83 c4 08             	add    $0x8,%esp
    107d:	68 02 02 00 00       	push   $0x202
    1082:	8d 45 de             	lea    -0x22(%ebp),%eax
    1085:	50                   	push   %eax
    1086:	e8 70 02 00 00       	call   12fb <open>
    108b:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++)
    108d:	83 c4 10             	add    $0x10,%esp
    1090:	bb 00 00 00 00       	mov    $0x0,%ebx
    1095:	eb 1b                	jmp    10b2 <main+0xb2>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    1097:	83 ec 04             	sub    $0x4,%esp
    109a:	68 00 02 00 00       	push   $0x200
    109f:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
    10a5:	50                   	push   %eax
    10a6:	56                   	push   %esi
    10a7:	e8 2f 02 00 00       	call   12db <write>
  for(i = 0; i < 20; i++)
    10ac:	83 c3 01             	add    $0x1,%ebx
    10af:	83 c4 10             	add    $0x10,%esp
    10b2:	83 fb 13             	cmp    $0x13,%ebx
    10b5:	7e e0                	jle    1097 <main+0x97>
  close(fd);
    10b7:	83 ec 0c             	sub    $0xc,%esp
    10ba:	56                   	push   %esi
    10bb:	e8 23 02 00 00       	call   12e3 <close>

  printf(1, "read\n");
    10c0:	83 c4 08             	add    $0x8,%esp
    10c3:	68 ed 16 00 00       	push   $0x16ed
    10c8:	6a 01                	push   $0x1
    10ca:	e8 51 03 00 00       	call   1420 <printf>

  fd = open(path, O_RDONLY);
    10cf:	83 c4 08             	add    $0x8,%esp
    10d2:	6a 00                	push   $0x0
    10d4:	8d 45 de             	lea    -0x22(%ebp),%eax
    10d7:	50                   	push   %eax
    10d8:	e8 1e 02 00 00       	call   12fb <open>
    10dd:	89 c6                	mov    %eax,%esi
  for (i = 0; i < 20; i++)
    10df:	83 c4 10             	add    $0x10,%esp
    10e2:	bb 00 00 00 00       	mov    $0x0,%ebx
    10e7:	eb 1b                	jmp    1104 <main+0x104>
    read(fd, data, sizeof(data));
    10e9:	83 ec 04             	sub    $0x4,%esp
    10ec:	68 00 02 00 00       	push   $0x200
    10f1:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
    10f7:	50                   	push   %eax
    10f8:	56                   	push   %esi
    10f9:	e8 d5 01 00 00       	call   12d3 <read>
  for (i = 0; i < 20; i++)
    10fe:	83 c3 01             	add    $0x1,%ebx
    1101:	83 c4 10             	add    $0x10,%esp
    1104:	83 fb 13             	cmp    $0x13,%ebx
    1107:	7e e0                	jle    10e9 <main+0xe9>
  close(fd);
    1109:	83 ec 0c             	sub    $0xc,%esp
    110c:	56                   	push   %esi
    110d:	e8 d1 01 00 00       	call   12e3 <close>

  wait();
    1112:	e8 ac 01 00 00       	call   12c3 <wait>

  exit();
    1117:	e8 9f 01 00 00       	call   12bb <exit>

0000111c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    111c:	55                   	push   %ebp
    111d:	89 e5                	mov    %esp,%ebp
    111f:	56                   	push   %esi
    1120:	53                   	push   %ebx
    1121:	8b 75 08             	mov    0x8(%ebp),%esi
    1124:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1127:	89 f0                	mov    %esi,%eax
    1129:	89 d1                	mov    %edx,%ecx
    112b:	83 c2 01             	add    $0x1,%edx
    112e:	89 c3                	mov    %eax,%ebx
    1130:	83 c0 01             	add    $0x1,%eax
    1133:	0f b6 09             	movzbl (%ecx),%ecx
    1136:	88 0b                	mov    %cl,(%ebx)
    1138:	84 c9                	test   %cl,%cl
    113a:	75 ed                	jne    1129 <strcpy+0xd>
    ;
  return os;
}
    113c:	89 f0                	mov    %esi,%eax
    113e:	5b                   	pop    %ebx
    113f:	5e                   	pop    %esi
    1140:	5d                   	pop    %ebp
    1141:	c3                   	ret    

00001142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1142:	55                   	push   %ebp
    1143:	89 e5                	mov    %esp,%ebp
    1145:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1148:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    114b:	eb 06                	jmp    1153 <strcmp+0x11>
    p++, q++;
    114d:	83 c1 01             	add    $0x1,%ecx
    1150:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1153:	0f b6 01             	movzbl (%ecx),%eax
    1156:	84 c0                	test   %al,%al
    1158:	74 04                	je     115e <strcmp+0x1c>
    115a:	3a 02                	cmp    (%edx),%al
    115c:	74 ef                	je     114d <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    115e:	0f b6 c0             	movzbl %al,%eax
    1161:	0f b6 12             	movzbl (%edx),%edx
    1164:	29 d0                	sub    %edx,%eax
}
    1166:	5d                   	pop    %ebp
    1167:	c3                   	ret    

00001168 <strlen>:

uint
strlen(const char *s)
{
    1168:	55                   	push   %ebp
    1169:	89 e5                	mov    %esp,%ebp
    116b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    116e:	b8 00 00 00 00       	mov    $0x0,%eax
    1173:	eb 03                	jmp    1178 <strlen+0x10>
    1175:	83 c0 01             	add    $0x1,%eax
    1178:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    117c:	75 f7                	jne    1175 <strlen+0xd>
    ;
  return n;
}
    117e:	5d                   	pop    %ebp
    117f:	c3                   	ret    

00001180 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	57                   	push   %edi
    1184:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1187:	89 d7                	mov    %edx,%edi
    1189:	8b 4d 10             	mov    0x10(%ebp),%ecx
    118c:	8b 45 0c             	mov    0xc(%ebp),%eax
    118f:	fc                   	cld    
    1190:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1192:	89 d0                	mov    %edx,%eax
    1194:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1197:	c9                   	leave  
    1198:	c3                   	ret    

00001199 <strchr>:

char*
strchr(const char *s, char c)
{
    1199:	55                   	push   %ebp
    119a:	89 e5                	mov    %esp,%ebp
    119c:	8b 45 08             	mov    0x8(%ebp),%eax
    119f:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11a3:	eb 03                	jmp    11a8 <strchr+0xf>
    11a5:	83 c0 01             	add    $0x1,%eax
    11a8:	0f b6 10             	movzbl (%eax),%edx
    11ab:	84 d2                	test   %dl,%dl
    11ad:	74 06                	je     11b5 <strchr+0x1c>
    if(*s == c)
    11af:	38 ca                	cmp    %cl,%dl
    11b1:	75 f2                	jne    11a5 <strchr+0xc>
    11b3:	eb 05                	jmp    11ba <strchr+0x21>
      return (char*)s;
  return 0;
    11b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11ba:	5d                   	pop    %ebp
    11bb:	c3                   	ret    

000011bc <gets>:

char*
gets(char *buf, int max)
{
    11bc:	55                   	push   %ebp
    11bd:	89 e5                	mov    %esp,%ebp
    11bf:	57                   	push   %edi
    11c0:	56                   	push   %esi
    11c1:	53                   	push   %ebx
    11c2:	83 ec 1c             	sub    $0x1c,%esp
    11c5:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11c8:	bb 00 00 00 00       	mov    $0x0,%ebx
    11cd:	89 de                	mov    %ebx,%esi
    11cf:	83 c3 01             	add    $0x1,%ebx
    11d2:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11d5:	7d 2e                	jge    1205 <gets+0x49>
    cc = read(0, &c, 1);
    11d7:	83 ec 04             	sub    $0x4,%esp
    11da:	6a 01                	push   $0x1
    11dc:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11df:	50                   	push   %eax
    11e0:	6a 00                	push   $0x0
    11e2:	e8 ec 00 00 00       	call   12d3 <read>
    if(cc < 1)
    11e7:	83 c4 10             	add    $0x10,%esp
    11ea:	85 c0                	test   %eax,%eax
    11ec:	7e 17                	jle    1205 <gets+0x49>
      break;
    buf[i++] = c;
    11ee:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11f2:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    11f5:	3c 0a                	cmp    $0xa,%al
    11f7:	0f 94 c2             	sete   %dl
    11fa:	3c 0d                	cmp    $0xd,%al
    11fc:	0f 94 c0             	sete   %al
    11ff:	08 c2                	or     %al,%dl
    1201:	74 ca                	je     11cd <gets+0x11>
    buf[i++] = c;
    1203:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1205:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1209:	89 f8                	mov    %edi,%eax
    120b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    120e:	5b                   	pop    %ebx
    120f:	5e                   	pop    %esi
    1210:	5f                   	pop    %edi
    1211:	5d                   	pop    %ebp
    1212:	c3                   	ret    

00001213 <stat>:

int
stat(const char *n, struct stat *st)
{
    1213:	55                   	push   %ebp
    1214:	89 e5                	mov    %esp,%ebp
    1216:	56                   	push   %esi
    1217:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1218:	83 ec 08             	sub    $0x8,%esp
    121b:	6a 00                	push   $0x0
    121d:	ff 75 08             	push   0x8(%ebp)
    1220:	e8 d6 00 00 00       	call   12fb <open>
  if(fd < 0)
    1225:	83 c4 10             	add    $0x10,%esp
    1228:	85 c0                	test   %eax,%eax
    122a:	78 24                	js     1250 <stat+0x3d>
    122c:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    122e:	83 ec 08             	sub    $0x8,%esp
    1231:	ff 75 0c             	push   0xc(%ebp)
    1234:	50                   	push   %eax
    1235:	e8 d9 00 00 00       	call   1313 <fstat>
    123a:	89 c6                	mov    %eax,%esi
  close(fd);
    123c:	89 1c 24             	mov    %ebx,(%esp)
    123f:	e8 9f 00 00 00       	call   12e3 <close>
  return r;
    1244:	83 c4 10             	add    $0x10,%esp
}
    1247:	89 f0                	mov    %esi,%eax
    1249:	8d 65 f8             	lea    -0x8(%ebp),%esp
    124c:	5b                   	pop    %ebx
    124d:	5e                   	pop    %esi
    124e:	5d                   	pop    %ebp
    124f:	c3                   	ret    
    return -1;
    1250:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1255:	eb f0                	jmp    1247 <stat+0x34>

00001257 <atoi>:

int
atoi(const char *s)
{
    1257:	55                   	push   %ebp
    1258:	89 e5                	mov    %esp,%ebp
    125a:	53                   	push   %ebx
    125b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    125e:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1263:	eb 10                	jmp    1275 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1265:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1268:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    126b:	83 c1 01             	add    $0x1,%ecx
    126e:	0f be c0             	movsbl %al,%eax
    1271:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1275:	0f b6 01             	movzbl (%ecx),%eax
    1278:	8d 58 d0             	lea    -0x30(%eax),%ebx
    127b:	80 fb 09             	cmp    $0x9,%bl
    127e:	76 e5                	jbe    1265 <atoi+0xe>
  return n;
}
    1280:	89 d0                	mov    %edx,%eax
    1282:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1285:	c9                   	leave  
    1286:	c3                   	ret    

00001287 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1287:	55                   	push   %ebp
    1288:	89 e5                	mov    %esp,%ebp
    128a:	56                   	push   %esi
    128b:	53                   	push   %ebx
    128c:	8b 75 08             	mov    0x8(%ebp),%esi
    128f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1292:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1295:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1297:	eb 0d                	jmp    12a6 <memmove+0x1f>
    *dst++ = *src++;
    1299:	0f b6 01             	movzbl (%ecx),%eax
    129c:	88 02                	mov    %al,(%edx)
    129e:	8d 49 01             	lea    0x1(%ecx),%ecx
    12a1:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    12a4:	89 d8                	mov    %ebx,%eax
    12a6:	8d 58 ff             	lea    -0x1(%eax),%ebx
    12a9:	85 c0                	test   %eax,%eax
    12ab:	7f ec                	jg     1299 <memmove+0x12>
  return vdst;
}
    12ad:	89 f0                	mov    %esi,%eax
    12af:	5b                   	pop    %ebx
    12b0:	5e                   	pop    %esi
    12b1:	5d                   	pop    %ebp
    12b2:	c3                   	ret    

000012b3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12b3:	b8 01 00 00 00       	mov    $0x1,%eax
    12b8:	cd 40                	int    $0x40
    12ba:	c3                   	ret    

000012bb <exit>:
SYSCALL(exit)
    12bb:	b8 02 00 00 00       	mov    $0x2,%eax
    12c0:	cd 40                	int    $0x40
    12c2:	c3                   	ret    

000012c3 <wait>:
SYSCALL(wait)
    12c3:	b8 03 00 00 00       	mov    $0x3,%eax
    12c8:	cd 40                	int    $0x40
    12ca:	c3                   	ret    

000012cb <pipe>:
SYSCALL(pipe)
    12cb:	b8 04 00 00 00       	mov    $0x4,%eax
    12d0:	cd 40                	int    $0x40
    12d2:	c3                   	ret    

000012d3 <read>:
SYSCALL(read)
    12d3:	b8 05 00 00 00       	mov    $0x5,%eax
    12d8:	cd 40                	int    $0x40
    12da:	c3                   	ret    

000012db <write>:
SYSCALL(write)
    12db:	b8 10 00 00 00       	mov    $0x10,%eax
    12e0:	cd 40                	int    $0x40
    12e2:	c3                   	ret    

000012e3 <close>:
SYSCALL(close)
    12e3:	b8 15 00 00 00       	mov    $0x15,%eax
    12e8:	cd 40                	int    $0x40
    12ea:	c3                   	ret    

000012eb <kill>:
SYSCALL(kill)
    12eb:	b8 06 00 00 00       	mov    $0x6,%eax
    12f0:	cd 40                	int    $0x40
    12f2:	c3                   	ret    

000012f3 <exec>:
SYSCALL(exec)
    12f3:	b8 07 00 00 00       	mov    $0x7,%eax
    12f8:	cd 40                	int    $0x40
    12fa:	c3                   	ret    

000012fb <open>:
SYSCALL(open)
    12fb:	b8 0f 00 00 00       	mov    $0xf,%eax
    1300:	cd 40                	int    $0x40
    1302:	c3                   	ret    

00001303 <mknod>:
SYSCALL(mknod)
    1303:	b8 11 00 00 00       	mov    $0x11,%eax
    1308:	cd 40                	int    $0x40
    130a:	c3                   	ret    

0000130b <unlink>:
SYSCALL(unlink)
    130b:	b8 12 00 00 00       	mov    $0x12,%eax
    1310:	cd 40                	int    $0x40
    1312:	c3                   	ret    

00001313 <fstat>:
SYSCALL(fstat)
    1313:	b8 08 00 00 00       	mov    $0x8,%eax
    1318:	cd 40                	int    $0x40
    131a:	c3                   	ret    

0000131b <link>:
SYSCALL(link)
    131b:	b8 13 00 00 00       	mov    $0x13,%eax
    1320:	cd 40                	int    $0x40
    1322:	c3                   	ret    

00001323 <mkdir>:
SYSCALL(mkdir)
    1323:	b8 14 00 00 00       	mov    $0x14,%eax
    1328:	cd 40                	int    $0x40
    132a:	c3                   	ret    

0000132b <chdir>:
SYSCALL(chdir)
    132b:	b8 09 00 00 00       	mov    $0x9,%eax
    1330:	cd 40                	int    $0x40
    1332:	c3                   	ret    

00001333 <dup>:
SYSCALL(dup)
    1333:	b8 0a 00 00 00       	mov    $0xa,%eax
    1338:	cd 40                	int    $0x40
    133a:	c3                   	ret    

0000133b <getpid>:
SYSCALL(getpid)
    133b:	b8 0b 00 00 00       	mov    $0xb,%eax
    1340:	cd 40                	int    $0x40
    1342:	c3                   	ret    

00001343 <sbrk>:
SYSCALL(sbrk)
    1343:	b8 0c 00 00 00       	mov    $0xc,%eax
    1348:	cd 40                	int    $0x40
    134a:	c3                   	ret    

0000134b <sleep>:
SYSCALL(sleep)
    134b:	b8 0d 00 00 00       	mov    $0xd,%eax
    1350:	cd 40                	int    $0x40
    1352:	c3                   	ret    

00001353 <uptime>:
SYSCALL(uptime)
    1353:	b8 0e 00 00 00       	mov    $0xe,%eax
    1358:	cd 40                	int    $0x40
    135a:	c3                   	ret    

0000135b <settickets>:
SYSCALL(settickets)
    135b:	b8 16 00 00 00       	mov    $0x16,%eax
    1360:	cd 40                	int    $0x40
    1362:	c3                   	ret    

00001363 <getpinfo>:
SYSCALL(getpinfo)
    1363:	b8 17 00 00 00       	mov    $0x17,%eax
    1368:	cd 40                	int    $0x40
    136a:	c3                   	ret    

0000136b <mprotect>:
SYSCALL(mprotect)
    136b:	b8 18 00 00 00       	mov    $0x18,%eax
    1370:	cd 40                	int    $0x40
    1372:	c3                   	ret    

00001373 <munprotect>:
    1373:	b8 19 00 00 00       	mov    $0x19,%eax
    1378:	cd 40                	int    $0x40
    137a:	c3                   	ret    

0000137b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    137b:	55                   	push   %ebp
    137c:	89 e5                	mov    %esp,%ebp
    137e:	83 ec 1c             	sub    $0x1c,%esp
    1381:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1384:	6a 01                	push   $0x1
    1386:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1389:	52                   	push   %edx
    138a:	50                   	push   %eax
    138b:	e8 4b ff ff ff       	call   12db <write>
}
    1390:	83 c4 10             	add    $0x10,%esp
    1393:	c9                   	leave  
    1394:	c3                   	ret    

00001395 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1395:	55                   	push   %ebp
    1396:	89 e5                	mov    %esp,%ebp
    1398:	57                   	push   %edi
    1399:	56                   	push   %esi
    139a:	53                   	push   %ebx
    139b:	83 ec 2c             	sub    $0x2c,%esp
    139e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    13a1:	89 d0                	mov    %edx,%eax
    13a3:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13a5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    13a9:	0f 95 c1             	setne  %cl
    13ac:	c1 ea 1f             	shr    $0x1f,%edx
    13af:	84 d1                	test   %dl,%cl
    13b1:	74 44                	je     13f7 <printint+0x62>
    neg = 1;
    x = -xx;
    13b3:	f7 d8                	neg    %eax
    13b5:	89 c1                	mov    %eax,%ecx
    neg = 1;
    13b7:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    13be:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    13c3:	89 c8                	mov    %ecx,%eax
    13c5:	ba 00 00 00 00       	mov    $0x0,%edx
    13ca:	f7 f6                	div    %esi
    13cc:	89 df                	mov    %ebx,%edi
    13ce:	83 c3 01             	add    $0x1,%ebx
    13d1:	0f b6 92 54 17 00 00 	movzbl 0x1754(%edx),%edx
    13d8:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    13dc:	89 ca                	mov    %ecx,%edx
    13de:	89 c1                	mov    %eax,%ecx
    13e0:	39 d6                	cmp    %edx,%esi
    13e2:	76 df                	jbe    13c3 <printint+0x2e>
  if(neg)
    13e4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    13e8:	74 31                	je     141b <printint+0x86>
    buf[i++] = '-';
    13ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    13ef:	8d 5f 02             	lea    0x2(%edi),%ebx
    13f2:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13f5:	eb 17                	jmp    140e <printint+0x79>
    x = xx;
    13f7:	89 c1                	mov    %eax,%ecx
  neg = 0;
    13f9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1400:	eb bc                	jmp    13be <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1402:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1407:	89 f0                	mov    %esi,%eax
    1409:	e8 6d ff ff ff       	call   137b <putc>
  while(--i >= 0)
    140e:	83 eb 01             	sub    $0x1,%ebx
    1411:	79 ef                	jns    1402 <printint+0x6d>
}
    1413:	83 c4 2c             	add    $0x2c,%esp
    1416:	5b                   	pop    %ebx
    1417:	5e                   	pop    %esi
    1418:	5f                   	pop    %edi
    1419:	5d                   	pop    %ebp
    141a:	c3                   	ret    
    141b:	8b 75 d0             	mov    -0x30(%ebp),%esi
    141e:	eb ee                	jmp    140e <printint+0x79>

00001420 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
    1426:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1429:	8d 45 10             	lea    0x10(%ebp),%eax
    142c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    142f:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1434:	bb 00 00 00 00       	mov    $0x0,%ebx
    1439:	eb 14                	jmp    144f <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    143b:	89 fa                	mov    %edi,%edx
    143d:	8b 45 08             	mov    0x8(%ebp),%eax
    1440:	e8 36 ff ff ff       	call   137b <putc>
    1445:	eb 05                	jmp    144c <printf+0x2c>
      }
    } else if(state == '%'){
    1447:	83 fe 25             	cmp    $0x25,%esi
    144a:	74 25                	je     1471 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    144c:	83 c3 01             	add    $0x1,%ebx
    144f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1452:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1456:	84 c0                	test   %al,%al
    1458:	0f 84 20 01 00 00    	je     157e <printf+0x15e>
    c = fmt[i] & 0xff;
    145e:	0f be f8             	movsbl %al,%edi
    1461:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1464:	85 f6                	test   %esi,%esi
    1466:	75 df                	jne    1447 <printf+0x27>
      if(c == '%'){
    1468:	83 f8 25             	cmp    $0x25,%eax
    146b:	75 ce                	jne    143b <printf+0x1b>
        state = '%';
    146d:	89 c6                	mov    %eax,%esi
    146f:	eb db                	jmp    144c <printf+0x2c>
      if(c == 'd'){
    1471:	83 f8 25             	cmp    $0x25,%eax
    1474:	0f 84 cf 00 00 00    	je     1549 <printf+0x129>
    147a:	0f 8c dd 00 00 00    	jl     155d <printf+0x13d>
    1480:	83 f8 78             	cmp    $0x78,%eax
    1483:	0f 8f d4 00 00 00    	jg     155d <printf+0x13d>
    1489:	83 f8 63             	cmp    $0x63,%eax
    148c:	0f 8c cb 00 00 00    	jl     155d <printf+0x13d>
    1492:	83 e8 63             	sub    $0x63,%eax
    1495:	83 f8 15             	cmp    $0x15,%eax
    1498:	0f 87 bf 00 00 00    	ja     155d <printf+0x13d>
    149e:	ff 24 85 fc 16 00 00 	jmp    *0x16fc(,%eax,4)
        printint(fd, *ap, 10, 1);
    14a5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14a8:	8b 17                	mov    (%edi),%edx
    14aa:	83 ec 0c             	sub    $0xc,%esp
    14ad:	6a 01                	push   $0x1
    14af:	b9 0a 00 00 00       	mov    $0xa,%ecx
    14b4:	8b 45 08             	mov    0x8(%ebp),%eax
    14b7:	e8 d9 fe ff ff       	call   1395 <printint>
        ap++;
    14bc:	83 c7 04             	add    $0x4,%edi
    14bf:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    14c2:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14c5:	be 00 00 00 00       	mov    $0x0,%esi
    14ca:	eb 80                	jmp    144c <printf+0x2c>
        printint(fd, *ap, 16, 0);
    14cc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14cf:	8b 17                	mov    (%edi),%edx
    14d1:	83 ec 0c             	sub    $0xc,%esp
    14d4:	6a 00                	push   $0x0
    14d6:	b9 10 00 00 00       	mov    $0x10,%ecx
    14db:	8b 45 08             	mov    0x8(%ebp),%eax
    14de:	e8 b2 fe ff ff       	call   1395 <printint>
        ap++;
    14e3:	83 c7 04             	add    $0x4,%edi
    14e6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    14e9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    14ec:	be 00 00 00 00       	mov    $0x0,%esi
    14f1:	e9 56 ff ff ff       	jmp    144c <printf+0x2c>
        s = (char*)*ap;
    14f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14f9:	8b 30                	mov    (%eax),%esi
        ap++;
    14fb:	83 c0 04             	add    $0x4,%eax
    14fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1501:	85 f6                	test   %esi,%esi
    1503:	75 15                	jne    151a <printf+0xfa>
          s = "(null)";
    1505:	be f3 16 00 00       	mov    $0x16f3,%esi
    150a:	eb 0e                	jmp    151a <printf+0xfa>
          putc(fd, *s);
    150c:	0f be d2             	movsbl %dl,%edx
    150f:	8b 45 08             	mov    0x8(%ebp),%eax
    1512:	e8 64 fe ff ff       	call   137b <putc>
          s++;
    1517:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    151a:	0f b6 16             	movzbl (%esi),%edx
    151d:	84 d2                	test   %dl,%dl
    151f:	75 eb                	jne    150c <printf+0xec>
      state = 0;
    1521:	be 00 00 00 00       	mov    $0x0,%esi
    1526:	e9 21 ff ff ff       	jmp    144c <printf+0x2c>
        putc(fd, *ap);
    152b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    152e:	0f be 17             	movsbl (%edi),%edx
    1531:	8b 45 08             	mov    0x8(%ebp),%eax
    1534:	e8 42 fe ff ff       	call   137b <putc>
        ap++;
    1539:	83 c7 04             	add    $0x4,%edi
    153c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    153f:	be 00 00 00 00       	mov    $0x0,%esi
    1544:	e9 03 ff ff ff       	jmp    144c <printf+0x2c>
        putc(fd, c);
    1549:	89 fa                	mov    %edi,%edx
    154b:	8b 45 08             	mov    0x8(%ebp),%eax
    154e:	e8 28 fe ff ff       	call   137b <putc>
      state = 0;
    1553:	be 00 00 00 00       	mov    $0x0,%esi
    1558:	e9 ef fe ff ff       	jmp    144c <printf+0x2c>
        putc(fd, '%');
    155d:	ba 25 00 00 00       	mov    $0x25,%edx
    1562:	8b 45 08             	mov    0x8(%ebp),%eax
    1565:	e8 11 fe ff ff       	call   137b <putc>
        putc(fd, c);
    156a:	89 fa                	mov    %edi,%edx
    156c:	8b 45 08             	mov    0x8(%ebp),%eax
    156f:	e8 07 fe ff ff       	call   137b <putc>
      state = 0;
    1574:	be 00 00 00 00       	mov    $0x0,%esi
    1579:	e9 ce fe ff ff       	jmp    144c <printf+0x2c>
    }
  }
}
    157e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1581:	5b                   	pop    %ebx
    1582:	5e                   	pop    %esi
    1583:	5f                   	pop    %edi
    1584:	5d                   	pop    %ebp
    1585:	c3                   	ret    

00001586 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1586:	55                   	push   %ebp
    1587:	89 e5                	mov    %esp,%ebp
    1589:	57                   	push   %edi
    158a:	56                   	push   %esi
    158b:	53                   	push   %ebx
    158c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    158f:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1592:	a1 fc 19 00 00       	mov    0x19fc,%eax
    1597:	eb 02                	jmp    159b <free+0x15>
    1599:	89 d0                	mov    %edx,%eax
    159b:	39 c8                	cmp    %ecx,%eax
    159d:	73 04                	jae    15a3 <free+0x1d>
    159f:	39 08                	cmp    %ecx,(%eax)
    15a1:	77 12                	ja     15b5 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15a3:	8b 10                	mov    (%eax),%edx
    15a5:	39 c2                	cmp    %eax,%edx
    15a7:	77 f0                	ja     1599 <free+0x13>
    15a9:	39 c8                	cmp    %ecx,%eax
    15ab:	72 08                	jb     15b5 <free+0x2f>
    15ad:	39 ca                	cmp    %ecx,%edx
    15af:	77 04                	ja     15b5 <free+0x2f>
    15b1:	89 d0                	mov    %edx,%eax
    15b3:	eb e6                	jmp    159b <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    15b5:	8b 73 fc             	mov    -0x4(%ebx),%esi
    15b8:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15bb:	8b 10                	mov    (%eax),%edx
    15bd:	39 d7                	cmp    %edx,%edi
    15bf:	74 19                	je     15da <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    15c1:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15c4:	8b 50 04             	mov    0x4(%eax),%edx
    15c7:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15ca:	39 ce                	cmp    %ecx,%esi
    15cc:	74 1b                	je     15e9 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    15ce:	89 08                	mov    %ecx,(%eax)
  freep = p;
    15d0:	a3 fc 19 00 00       	mov    %eax,0x19fc
}
    15d5:	5b                   	pop    %ebx
    15d6:	5e                   	pop    %esi
    15d7:	5f                   	pop    %edi
    15d8:	5d                   	pop    %ebp
    15d9:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    15da:	03 72 04             	add    0x4(%edx),%esi
    15dd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    15e0:	8b 10                	mov    (%eax),%edx
    15e2:	8b 12                	mov    (%edx),%edx
    15e4:	89 53 f8             	mov    %edx,-0x8(%ebx)
    15e7:	eb db                	jmp    15c4 <free+0x3e>
    p->s.size += bp->s.size;
    15e9:	03 53 fc             	add    -0x4(%ebx),%edx
    15ec:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15ef:	8b 53 f8             	mov    -0x8(%ebx),%edx
    15f2:	89 10                	mov    %edx,(%eax)
    15f4:	eb da                	jmp    15d0 <free+0x4a>

000015f6 <morecore>:

static Header*
morecore(uint nu)
{
    15f6:	55                   	push   %ebp
    15f7:	89 e5                	mov    %esp,%ebp
    15f9:	53                   	push   %ebx
    15fa:	83 ec 04             	sub    $0x4,%esp
    15fd:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    15ff:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1604:	77 05                	ja     160b <morecore+0x15>
    nu = 4096;
    1606:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    160b:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1612:	83 ec 0c             	sub    $0xc,%esp
    1615:	50                   	push   %eax
    1616:	e8 28 fd ff ff       	call   1343 <sbrk>
  if(p == (char*)-1)
    161b:	83 c4 10             	add    $0x10,%esp
    161e:	83 f8 ff             	cmp    $0xffffffff,%eax
    1621:	74 1c                	je     163f <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1623:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1626:	83 c0 08             	add    $0x8,%eax
    1629:	83 ec 0c             	sub    $0xc,%esp
    162c:	50                   	push   %eax
    162d:	e8 54 ff ff ff       	call   1586 <free>
  return freep;
    1632:	a1 fc 19 00 00       	mov    0x19fc,%eax
    1637:	83 c4 10             	add    $0x10,%esp
}
    163a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    163d:	c9                   	leave  
    163e:	c3                   	ret    
    return 0;
    163f:	b8 00 00 00 00       	mov    $0x0,%eax
    1644:	eb f4                	jmp    163a <morecore+0x44>

00001646 <malloc>:

void*
malloc(uint nbytes)
{
    1646:	55                   	push   %ebp
    1647:	89 e5                	mov    %esp,%ebp
    1649:	53                   	push   %ebx
    164a:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    164d:	8b 45 08             	mov    0x8(%ebp),%eax
    1650:	8d 58 07             	lea    0x7(%eax),%ebx
    1653:	c1 eb 03             	shr    $0x3,%ebx
    1656:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1659:	8b 0d fc 19 00 00    	mov    0x19fc,%ecx
    165f:	85 c9                	test   %ecx,%ecx
    1661:	74 04                	je     1667 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1663:	8b 01                	mov    (%ecx),%eax
    1665:	eb 4a                	jmp    16b1 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1667:	c7 05 fc 19 00 00 00 	movl   $0x1a00,0x19fc
    166e:	1a 00 00 
    1671:	c7 05 00 1a 00 00 00 	movl   $0x1a00,0x1a00
    1678:	1a 00 00 
    base.s.size = 0;
    167b:	c7 05 04 1a 00 00 00 	movl   $0x0,0x1a04
    1682:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1685:	b9 00 1a 00 00       	mov    $0x1a00,%ecx
    168a:	eb d7                	jmp    1663 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    168c:	74 19                	je     16a7 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    168e:	29 da                	sub    %ebx,%edx
    1690:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1693:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1696:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1699:	89 0d fc 19 00 00    	mov    %ecx,0x19fc
      return (void*)(p + 1);
    169f:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    16a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16a5:	c9                   	leave  
    16a6:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    16a7:	8b 10                	mov    (%eax),%edx
    16a9:	89 11                	mov    %edx,(%ecx)
    16ab:	eb ec                	jmp    1699 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16ad:	89 c1                	mov    %eax,%ecx
    16af:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    16b1:	8b 50 04             	mov    0x4(%eax),%edx
    16b4:	39 da                	cmp    %ebx,%edx
    16b6:	73 d4                	jae    168c <malloc+0x46>
    if(p == freep)
    16b8:	39 05 fc 19 00 00    	cmp    %eax,0x19fc
    16be:	75 ed                	jne    16ad <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    16c0:	89 d8                	mov    %ebx,%eax
    16c2:	e8 2f ff ff ff       	call   15f6 <morecore>
    16c7:	85 c0                	test   %eax,%eax
    16c9:	75 e2                	jne    16ad <malloc+0x67>
    16cb:	eb d5                	jmp    16a2 <malloc+0x5c>
