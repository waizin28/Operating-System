
_test_13:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "user.h"
#include "fcntl.h"
#include "pstat.h"

int
main(int argc, char *argv[]) {
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	81 ec 50 04 00 00    	sub    $0x450,%esp
  struct pstat pstat;

  int pid1, pid2;
  int fd1, fd2;

  fd1 = open(p1_file, O_CREATE | O_WRONLY);
    1017:	68 01 02 00 00       	push   $0x201
    101c:	68 6c 17 00 00       	push   $0x176c
    1021:	e8 73 03 00 00       	call   1399 <open>
  if (fd1 < 0) {
    1026:	83 c4 10             	add    $0x10,%esp
    1029:	85 c0                	test   %eax,%eax
    102b:	78 6e                	js     109b <main+0x9b>
    102d:	89 c3                	mov    %eax,%ebx
    printf(2, "Open %s failed\n", p1_file);
    exit();
  }
 
  fd2 = open(p2_file, O_CREATE | O_WRONLY);
    102f:	83 ec 08             	sub    $0x8,%esp
    1032:	68 01 02 00 00       	push   $0x201
    1037:	68 83 17 00 00       	push   $0x1783
    103c:	e8 58 03 00 00       	call   1399 <open>
    1041:	89 c6                	mov    %eax,%esi
  if (fd2 < 0) {
    1043:	83 c4 10             	add    $0x10,%esp
    1046:	85 c0                	test   %eax,%eax
    1048:	78 6a                	js     10b4 <main+0xb4>
    printf(2, "Open %s failed\n", p2_file);
    exit();
  }

  pid1 = fork();
    104a:	e8 02 03 00 00       	call   1351 <fork>
    104f:	89 c7                	mov    %eax,%edi
  if (pid1 < 0) {
    1051:	85 c0                	test   %eax,%eax
    1053:	78 78                	js     10cd <main+0xcd>
    printf(2, "Fork child process 1 failed\n");
  } else if (pid1 == 0) { // child process 1
    1055:	0f 84 89 00 00 00    	je     10e4 <main+0xe4>
    settickets(1);
    while(1)
      printf(fd1, "A");
  } 
  
  pid2 = fork();
    105b:	e8 f1 02 00 00       	call   1351 <fork>
    1060:	89 85 b4 fb ff ff    	mov    %eax,-0x44c(%ebp)
  if (pid2 < 0) {
    1066:	85 c0                	test   %eax,%eax
    1068:	0f 88 96 00 00 00    	js     1104 <main+0x104>
    printf(2, "Fork child process 2 failed\n");
    exit();
  } else if (pid2 == 0) { // child process 2
    106e:	83 bd b4 fb ff ff 00 	cmpl   $0x0,-0x44c(%ebp)
    1075:	0f 85 9d 00 00 00    	jne    1118 <main+0x118>
    settickets(0);
    107b:	83 ec 0c             	sub    $0xc,%esp
    107e:	6a 00                	push   $0x0
    1080:	e8 74 03 00 00       	call   13f9 <settickets>
    1085:	83 c4 10             	add    $0x10,%esp
    while (1)  
      printf(fd2, "A");
    1088:	83 ec 08             	sub    $0x8,%esp
    108b:	68 a7 17 00 00       	push   $0x17a7
    1090:	56                   	push   %esi
    1091:	e8 28 04 00 00       	call   14be <printf>
    1096:	83 c4 10             	add    $0x10,%esp
    1099:	eb ed                	jmp    1088 <main+0x88>
    printf(2, "Open %s failed\n", p1_file);
    109b:	83 ec 04             	sub    $0x4,%esp
    109e:	68 6c 17 00 00       	push   $0x176c
    10a3:	68 73 17 00 00       	push   $0x1773
    10a8:	6a 02                	push   $0x2
    10aa:	e8 0f 04 00 00       	call   14be <printf>
    exit();
    10af:	e8 a5 02 00 00       	call   1359 <exit>
    printf(2, "Open %s failed\n", p2_file);
    10b4:	83 ec 04             	sub    $0x4,%esp
    10b7:	68 83 17 00 00       	push   $0x1783
    10bc:	68 73 17 00 00       	push   $0x1773
    10c1:	6a 02                	push   $0x2
    10c3:	e8 f6 03 00 00       	call   14be <printf>
    exit();
    10c8:	e8 8c 02 00 00       	call   1359 <exit>
    printf(2, "Fork child process 1 failed\n");
    10cd:	83 ec 08             	sub    $0x8,%esp
    10d0:	68 8a 17 00 00       	push   $0x178a
    10d5:	6a 02                	push   $0x2
    10d7:	e8 e2 03 00 00       	call   14be <printf>
    10dc:	83 c4 10             	add    $0x10,%esp
    10df:	e9 77 ff ff ff       	jmp    105b <main+0x5b>
    settickets(1);
    10e4:	83 ec 0c             	sub    $0xc,%esp
    10e7:	6a 01                	push   $0x1
    10e9:	e8 0b 03 00 00       	call   13f9 <settickets>
    10ee:	83 c4 10             	add    $0x10,%esp
      printf(fd1, "A");
    10f1:	83 ec 08             	sub    $0x8,%esp
    10f4:	68 a7 17 00 00       	push   $0x17a7
    10f9:	53                   	push   %ebx
    10fa:	e8 bf 03 00 00       	call   14be <printf>
    10ff:	83 c4 10             	add    $0x10,%esp
    1102:	eb ed                	jmp    10f1 <main+0xf1>
    printf(2, "Fork child process 2 failed\n");
    1104:	83 ec 08             	sub    $0x8,%esp
    1107:	68 a9 17 00 00       	push   $0x17a9
    110c:	6a 02                	push   $0x2
    110e:	e8 ab 03 00 00       	call   14be <printf>
    exit();
    1113:	e8 41 02 00 00       	call   1359 <exit>
  }

  sleep(1000);
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	68 e8 03 00 00       	push   $0x3e8
    1120:	e8 c4 02 00 00       	call   13e9 <sleep>
  getpinfo(&pstat);
    1125:	8d 85 c0 fb ff ff    	lea    -0x440(%ebp),%eax
    112b:	89 04 24             	mov    %eax,(%esp)
    112e:	e8 ce 02 00 00       	call   1401 <getpinfo>
  kill(pid1);
    1133:	89 3c 24             	mov    %edi,(%esp)
    1136:	e8 4e 02 00 00       	call   1389 <kill>
  kill(pid2);
    113b:	83 c4 04             	add    $0x4,%esp
    113e:	ff b5 b4 fb ff ff    	push   -0x44c(%ebp)
    1144:	e8 40 02 00 00       	call   1389 <kill>

  wait();
    1149:	e8 13 02 00 00       	call   1361 <wait>
  wait();
    114e:	e8 0e 02 00 00       	call   1361 <wait>

  fstat(fd1, &f1);
    1153:	83 c4 08             	add    $0x8,%esp
    1156:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    1159:	50                   	push   %eax
    115a:	53                   	push   %ebx
    115b:	e8 51 02 00 00       	call   13b1 <fstat>
  fstat(fd2, &f2);
    1160:	83 c4 08             	add    $0x8,%esp
    1163:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1166:	50                   	push   %eax
    1167:	56                   	push   %esi
    1168:	e8 44 02 00 00       	call   13b1 <fstat>
  // compare file size made by child process
  if (f1.size > f2.size) {
    116d:	83 c4 10             	add    $0x10,%esp
    1170:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1173:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    1176:	77 2e                	ja     11a6 <main+0x1a6>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
  }

  close(fd1);
    1178:	83 ec 0c             	sub    $0xc,%esp
    117b:	53                   	push   %ebx
    117c:	e8 00 02 00 00       	call   1381 <close>
  close(fd2);
    1181:	89 34 24             	mov    %esi,(%esp)
    1184:	e8 f8 01 00 00       	call   1381 <close>
  
  unlink(p1_file);
    1189:	c7 04 24 6c 17 00 00 	movl   $0x176c,(%esp)
    1190:	e8 14 02 00 00       	call   13a9 <unlink>
  unlink(p2_file);
    1195:	c7 04 24 83 17 00 00 	movl   $0x1783,(%esp)
    119c:	e8 08 02 00 00       	call   13a9 <unlink>

  exit();
    11a1:	e8 b3 01 00 00       	call   1359 <exit>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    11a6:	83 ec 08             	sub    $0x8,%esp
    11a9:	68 c6 17 00 00       	push   $0x17c6
    11ae:	6a 01                	push   $0x1
    11b0:	e8 09 03 00 00       	call   14be <printf>
    11b5:	83 c4 10             	add    $0x10,%esp
    11b8:	eb be                	jmp    1178 <main+0x178>

000011ba <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    11ba:	55                   	push   %ebp
    11bb:	89 e5                	mov    %esp,%ebp
    11bd:	56                   	push   %esi
    11be:	53                   	push   %ebx
    11bf:	8b 75 08             	mov    0x8(%ebp),%esi
    11c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    11c5:	89 f0                	mov    %esi,%eax
    11c7:	89 d1                	mov    %edx,%ecx
    11c9:	83 c2 01             	add    $0x1,%edx
    11cc:	89 c3                	mov    %eax,%ebx
    11ce:	83 c0 01             	add    $0x1,%eax
    11d1:	0f b6 09             	movzbl (%ecx),%ecx
    11d4:	88 0b                	mov    %cl,(%ebx)
    11d6:	84 c9                	test   %cl,%cl
    11d8:	75 ed                	jne    11c7 <strcpy+0xd>
    ;
  return os;
}
    11da:	89 f0                	mov    %esi,%eax
    11dc:	5b                   	pop    %ebx
    11dd:	5e                   	pop    %esi
    11de:	5d                   	pop    %ebp
    11df:	c3                   	ret    

000011e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    11e9:	eb 06                	jmp    11f1 <strcmp+0x11>
    p++, q++;
    11eb:	83 c1 01             	add    $0x1,%ecx
    11ee:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    11f1:	0f b6 01             	movzbl (%ecx),%eax
    11f4:	84 c0                	test   %al,%al
    11f6:	74 04                	je     11fc <strcmp+0x1c>
    11f8:	3a 02                	cmp    (%edx),%al
    11fa:	74 ef                	je     11eb <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    11fc:	0f b6 c0             	movzbl %al,%eax
    11ff:	0f b6 12             	movzbl (%edx),%edx
    1202:	29 d0                	sub    %edx,%eax
}
    1204:	5d                   	pop    %ebp
    1205:	c3                   	ret    

00001206 <strlen>:

uint
strlen(const char *s)
{
    1206:	55                   	push   %ebp
    1207:	89 e5                	mov    %esp,%ebp
    1209:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    120c:	b8 00 00 00 00       	mov    $0x0,%eax
    1211:	eb 03                	jmp    1216 <strlen+0x10>
    1213:	83 c0 01             	add    $0x1,%eax
    1216:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    121a:	75 f7                	jne    1213 <strlen+0xd>
    ;
  return n;
}
    121c:	5d                   	pop    %ebp
    121d:	c3                   	ret    

0000121e <memset>:

void*
memset(void *dst, int c, uint n)
{
    121e:	55                   	push   %ebp
    121f:	89 e5                	mov    %esp,%ebp
    1221:	57                   	push   %edi
    1222:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1225:	89 d7                	mov    %edx,%edi
    1227:	8b 4d 10             	mov    0x10(%ebp),%ecx
    122a:	8b 45 0c             	mov    0xc(%ebp),%eax
    122d:	fc                   	cld    
    122e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1230:	89 d0                	mov    %edx,%eax
    1232:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1235:	c9                   	leave  
    1236:	c3                   	ret    

00001237 <strchr>:

char*
strchr(const char *s, char c)
{
    1237:	55                   	push   %ebp
    1238:	89 e5                	mov    %esp,%ebp
    123a:	8b 45 08             	mov    0x8(%ebp),%eax
    123d:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1241:	eb 03                	jmp    1246 <strchr+0xf>
    1243:	83 c0 01             	add    $0x1,%eax
    1246:	0f b6 10             	movzbl (%eax),%edx
    1249:	84 d2                	test   %dl,%dl
    124b:	74 06                	je     1253 <strchr+0x1c>
    if(*s == c)
    124d:	38 ca                	cmp    %cl,%dl
    124f:	75 f2                	jne    1243 <strchr+0xc>
    1251:	eb 05                	jmp    1258 <strchr+0x21>
      return (char*)s;
  return 0;
    1253:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1258:	5d                   	pop    %ebp
    1259:	c3                   	ret    

0000125a <gets>:

char*
gets(char *buf, int max)
{
    125a:	55                   	push   %ebp
    125b:	89 e5                	mov    %esp,%ebp
    125d:	57                   	push   %edi
    125e:	56                   	push   %esi
    125f:	53                   	push   %ebx
    1260:	83 ec 1c             	sub    $0x1c,%esp
    1263:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1266:	bb 00 00 00 00       	mov    $0x0,%ebx
    126b:	89 de                	mov    %ebx,%esi
    126d:	83 c3 01             	add    $0x1,%ebx
    1270:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1273:	7d 2e                	jge    12a3 <gets+0x49>
    cc = read(0, &c, 1);
    1275:	83 ec 04             	sub    $0x4,%esp
    1278:	6a 01                	push   $0x1
    127a:	8d 45 e7             	lea    -0x19(%ebp),%eax
    127d:	50                   	push   %eax
    127e:	6a 00                	push   $0x0
    1280:	e8 ec 00 00 00       	call   1371 <read>
    if(cc < 1)
    1285:	83 c4 10             	add    $0x10,%esp
    1288:	85 c0                	test   %eax,%eax
    128a:	7e 17                	jle    12a3 <gets+0x49>
      break;
    buf[i++] = c;
    128c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1290:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1293:	3c 0a                	cmp    $0xa,%al
    1295:	0f 94 c2             	sete   %dl
    1298:	3c 0d                	cmp    $0xd,%al
    129a:	0f 94 c0             	sete   %al
    129d:	08 c2                	or     %al,%dl
    129f:	74 ca                	je     126b <gets+0x11>
    buf[i++] = c;
    12a1:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    12a3:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    12a7:	89 f8                	mov    %edi,%eax
    12a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12ac:	5b                   	pop    %ebx
    12ad:	5e                   	pop    %esi
    12ae:	5f                   	pop    %edi
    12af:	5d                   	pop    %ebp
    12b0:	c3                   	ret    

000012b1 <stat>:

int
stat(const char *n, struct stat *st)
{
    12b1:	55                   	push   %ebp
    12b2:	89 e5                	mov    %esp,%ebp
    12b4:	56                   	push   %esi
    12b5:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12b6:	83 ec 08             	sub    $0x8,%esp
    12b9:	6a 00                	push   $0x0
    12bb:	ff 75 08             	push   0x8(%ebp)
    12be:	e8 d6 00 00 00       	call   1399 <open>
  if(fd < 0)
    12c3:	83 c4 10             	add    $0x10,%esp
    12c6:	85 c0                	test   %eax,%eax
    12c8:	78 24                	js     12ee <stat+0x3d>
    12ca:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    12cc:	83 ec 08             	sub    $0x8,%esp
    12cf:	ff 75 0c             	push   0xc(%ebp)
    12d2:	50                   	push   %eax
    12d3:	e8 d9 00 00 00       	call   13b1 <fstat>
    12d8:	89 c6                	mov    %eax,%esi
  close(fd);
    12da:	89 1c 24             	mov    %ebx,(%esp)
    12dd:	e8 9f 00 00 00       	call   1381 <close>
  return r;
    12e2:	83 c4 10             	add    $0x10,%esp
}
    12e5:	89 f0                	mov    %esi,%eax
    12e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12ea:	5b                   	pop    %ebx
    12eb:	5e                   	pop    %esi
    12ec:	5d                   	pop    %ebp
    12ed:	c3                   	ret    
    return -1;
    12ee:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12f3:	eb f0                	jmp    12e5 <stat+0x34>

000012f5 <atoi>:

int
atoi(const char *s)
{
    12f5:	55                   	push   %ebp
    12f6:	89 e5                	mov    %esp,%ebp
    12f8:	53                   	push   %ebx
    12f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    12fc:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1301:	eb 10                	jmp    1313 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1303:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1306:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1309:	83 c1 01             	add    $0x1,%ecx
    130c:	0f be c0             	movsbl %al,%eax
    130f:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1313:	0f b6 01             	movzbl (%ecx),%eax
    1316:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1319:	80 fb 09             	cmp    $0x9,%bl
    131c:	76 e5                	jbe    1303 <atoi+0xe>
  return n;
}
    131e:	89 d0                	mov    %edx,%eax
    1320:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1323:	c9                   	leave  
    1324:	c3                   	ret    

00001325 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1325:	55                   	push   %ebp
    1326:	89 e5                	mov    %esp,%ebp
    1328:	56                   	push   %esi
    1329:	53                   	push   %ebx
    132a:	8b 75 08             	mov    0x8(%ebp),%esi
    132d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1330:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1333:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1335:	eb 0d                	jmp    1344 <memmove+0x1f>
    *dst++ = *src++;
    1337:	0f b6 01             	movzbl (%ecx),%eax
    133a:	88 02                	mov    %al,(%edx)
    133c:	8d 49 01             	lea    0x1(%ecx),%ecx
    133f:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1342:	89 d8                	mov    %ebx,%eax
    1344:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1347:	85 c0                	test   %eax,%eax
    1349:	7f ec                	jg     1337 <memmove+0x12>
  return vdst;
}
    134b:	89 f0                	mov    %esi,%eax
    134d:	5b                   	pop    %ebx
    134e:	5e                   	pop    %esi
    134f:	5d                   	pop    %ebp
    1350:	c3                   	ret    

00001351 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1351:	b8 01 00 00 00       	mov    $0x1,%eax
    1356:	cd 40                	int    $0x40
    1358:	c3                   	ret    

00001359 <exit>:
SYSCALL(exit)
    1359:	b8 02 00 00 00       	mov    $0x2,%eax
    135e:	cd 40                	int    $0x40
    1360:	c3                   	ret    

00001361 <wait>:
SYSCALL(wait)
    1361:	b8 03 00 00 00       	mov    $0x3,%eax
    1366:	cd 40                	int    $0x40
    1368:	c3                   	ret    

00001369 <pipe>:
SYSCALL(pipe)
    1369:	b8 04 00 00 00       	mov    $0x4,%eax
    136e:	cd 40                	int    $0x40
    1370:	c3                   	ret    

00001371 <read>:
SYSCALL(read)
    1371:	b8 05 00 00 00       	mov    $0x5,%eax
    1376:	cd 40                	int    $0x40
    1378:	c3                   	ret    

00001379 <write>:
SYSCALL(write)
    1379:	b8 10 00 00 00       	mov    $0x10,%eax
    137e:	cd 40                	int    $0x40
    1380:	c3                   	ret    

00001381 <close>:
SYSCALL(close)
    1381:	b8 15 00 00 00       	mov    $0x15,%eax
    1386:	cd 40                	int    $0x40
    1388:	c3                   	ret    

00001389 <kill>:
SYSCALL(kill)
    1389:	b8 06 00 00 00       	mov    $0x6,%eax
    138e:	cd 40                	int    $0x40
    1390:	c3                   	ret    

00001391 <exec>:
SYSCALL(exec)
    1391:	b8 07 00 00 00       	mov    $0x7,%eax
    1396:	cd 40                	int    $0x40
    1398:	c3                   	ret    

00001399 <open>:
SYSCALL(open)
    1399:	b8 0f 00 00 00       	mov    $0xf,%eax
    139e:	cd 40                	int    $0x40
    13a0:	c3                   	ret    

000013a1 <mknod>:
SYSCALL(mknod)
    13a1:	b8 11 00 00 00       	mov    $0x11,%eax
    13a6:	cd 40                	int    $0x40
    13a8:	c3                   	ret    

000013a9 <unlink>:
SYSCALL(unlink)
    13a9:	b8 12 00 00 00       	mov    $0x12,%eax
    13ae:	cd 40                	int    $0x40
    13b0:	c3                   	ret    

000013b1 <fstat>:
SYSCALL(fstat)
    13b1:	b8 08 00 00 00       	mov    $0x8,%eax
    13b6:	cd 40                	int    $0x40
    13b8:	c3                   	ret    

000013b9 <link>:
SYSCALL(link)
    13b9:	b8 13 00 00 00       	mov    $0x13,%eax
    13be:	cd 40                	int    $0x40
    13c0:	c3                   	ret    

000013c1 <mkdir>:
SYSCALL(mkdir)
    13c1:	b8 14 00 00 00       	mov    $0x14,%eax
    13c6:	cd 40                	int    $0x40
    13c8:	c3                   	ret    

000013c9 <chdir>:
SYSCALL(chdir)
    13c9:	b8 09 00 00 00       	mov    $0x9,%eax
    13ce:	cd 40                	int    $0x40
    13d0:	c3                   	ret    

000013d1 <dup>:
SYSCALL(dup)
    13d1:	b8 0a 00 00 00       	mov    $0xa,%eax
    13d6:	cd 40                	int    $0x40
    13d8:	c3                   	ret    

000013d9 <getpid>:
SYSCALL(getpid)
    13d9:	b8 0b 00 00 00       	mov    $0xb,%eax
    13de:	cd 40                	int    $0x40
    13e0:	c3                   	ret    

000013e1 <sbrk>:
SYSCALL(sbrk)
    13e1:	b8 0c 00 00 00       	mov    $0xc,%eax
    13e6:	cd 40                	int    $0x40
    13e8:	c3                   	ret    

000013e9 <sleep>:
SYSCALL(sleep)
    13e9:	b8 0d 00 00 00       	mov    $0xd,%eax
    13ee:	cd 40                	int    $0x40
    13f0:	c3                   	ret    

000013f1 <uptime>:
SYSCALL(uptime)
    13f1:	b8 0e 00 00 00       	mov    $0xe,%eax
    13f6:	cd 40                	int    $0x40
    13f8:	c3                   	ret    

000013f9 <settickets>:
SYSCALL(settickets)
    13f9:	b8 16 00 00 00       	mov    $0x16,%eax
    13fe:	cd 40                	int    $0x40
    1400:	c3                   	ret    

00001401 <getpinfo>:
SYSCALL(getpinfo)
    1401:	b8 17 00 00 00       	mov    $0x17,%eax
    1406:	cd 40                	int    $0x40
    1408:	c3                   	ret    

00001409 <mprotect>:
SYSCALL(mprotect)
    1409:	b8 18 00 00 00       	mov    $0x18,%eax
    140e:	cd 40                	int    $0x40
    1410:	c3                   	ret    

00001411 <munprotect>:
    1411:	b8 19 00 00 00       	mov    $0x19,%eax
    1416:	cd 40                	int    $0x40
    1418:	c3                   	ret    

00001419 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1419:	55                   	push   %ebp
    141a:	89 e5                	mov    %esp,%ebp
    141c:	83 ec 1c             	sub    $0x1c,%esp
    141f:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1422:	6a 01                	push   $0x1
    1424:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1427:	52                   	push   %edx
    1428:	50                   	push   %eax
    1429:	e8 4b ff ff ff       	call   1379 <write>
}
    142e:	83 c4 10             	add    $0x10,%esp
    1431:	c9                   	leave  
    1432:	c3                   	ret    

00001433 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1433:	55                   	push   %ebp
    1434:	89 e5                	mov    %esp,%ebp
    1436:	57                   	push   %edi
    1437:	56                   	push   %esi
    1438:	53                   	push   %ebx
    1439:	83 ec 2c             	sub    $0x2c,%esp
    143c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    143f:	89 d0                	mov    %edx,%eax
    1441:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1443:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1447:	0f 95 c1             	setne  %cl
    144a:	c1 ea 1f             	shr    $0x1f,%edx
    144d:	84 d1                	test   %dl,%cl
    144f:	74 44                	je     1495 <printint+0x62>
    neg = 1;
    x = -xx;
    1451:	f7 d8                	neg    %eax
    1453:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1455:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    145c:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1461:	89 c8                	mov    %ecx,%eax
    1463:	ba 00 00 00 00       	mov    $0x0,%edx
    1468:	f7 f6                	div    %esi
    146a:	89 df                	mov    %ebx,%edi
    146c:	83 c3 01             	add    $0x1,%ebx
    146f:	0f b6 92 40 18 00 00 	movzbl 0x1840(%edx),%edx
    1476:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    147a:	89 ca                	mov    %ecx,%edx
    147c:	89 c1                	mov    %eax,%ecx
    147e:	39 d6                	cmp    %edx,%esi
    1480:	76 df                	jbe    1461 <printint+0x2e>
  if(neg)
    1482:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1486:	74 31                	je     14b9 <printint+0x86>
    buf[i++] = '-';
    1488:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    148d:	8d 5f 02             	lea    0x2(%edi),%ebx
    1490:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1493:	eb 17                	jmp    14ac <printint+0x79>
    x = xx;
    1495:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1497:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    149e:	eb bc                	jmp    145c <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    14a0:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    14a5:	89 f0                	mov    %esi,%eax
    14a7:	e8 6d ff ff ff       	call   1419 <putc>
  while(--i >= 0)
    14ac:	83 eb 01             	sub    $0x1,%ebx
    14af:	79 ef                	jns    14a0 <printint+0x6d>
}
    14b1:	83 c4 2c             	add    $0x2c,%esp
    14b4:	5b                   	pop    %ebx
    14b5:	5e                   	pop    %esi
    14b6:	5f                   	pop    %edi
    14b7:	5d                   	pop    %ebp
    14b8:	c3                   	ret    
    14b9:	8b 75 d0             	mov    -0x30(%ebp),%esi
    14bc:	eb ee                	jmp    14ac <printint+0x79>

000014be <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    14be:	55                   	push   %ebp
    14bf:	89 e5                	mov    %esp,%ebp
    14c1:	57                   	push   %edi
    14c2:	56                   	push   %esi
    14c3:	53                   	push   %ebx
    14c4:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    14c7:	8d 45 10             	lea    0x10(%ebp),%eax
    14ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    14cd:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    14d2:	bb 00 00 00 00       	mov    $0x0,%ebx
    14d7:	eb 14                	jmp    14ed <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    14d9:	89 fa                	mov    %edi,%edx
    14db:	8b 45 08             	mov    0x8(%ebp),%eax
    14de:	e8 36 ff ff ff       	call   1419 <putc>
    14e3:	eb 05                	jmp    14ea <printf+0x2c>
      }
    } else if(state == '%'){
    14e5:	83 fe 25             	cmp    $0x25,%esi
    14e8:	74 25                	je     150f <printf+0x51>
  for(i = 0; fmt[i]; i++){
    14ea:	83 c3 01             	add    $0x1,%ebx
    14ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f0:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    14f4:	84 c0                	test   %al,%al
    14f6:	0f 84 20 01 00 00    	je     161c <printf+0x15e>
    c = fmt[i] & 0xff;
    14fc:	0f be f8             	movsbl %al,%edi
    14ff:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1502:	85 f6                	test   %esi,%esi
    1504:	75 df                	jne    14e5 <printf+0x27>
      if(c == '%'){
    1506:	83 f8 25             	cmp    $0x25,%eax
    1509:	75 ce                	jne    14d9 <printf+0x1b>
        state = '%';
    150b:	89 c6                	mov    %eax,%esi
    150d:	eb db                	jmp    14ea <printf+0x2c>
      if(c == 'd'){
    150f:	83 f8 25             	cmp    $0x25,%eax
    1512:	0f 84 cf 00 00 00    	je     15e7 <printf+0x129>
    1518:	0f 8c dd 00 00 00    	jl     15fb <printf+0x13d>
    151e:	83 f8 78             	cmp    $0x78,%eax
    1521:	0f 8f d4 00 00 00    	jg     15fb <printf+0x13d>
    1527:	83 f8 63             	cmp    $0x63,%eax
    152a:	0f 8c cb 00 00 00    	jl     15fb <printf+0x13d>
    1530:	83 e8 63             	sub    $0x63,%eax
    1533:	83 f8 15             	cmp    $0x15,%eax
    1536:	0f 87 bf 00 00 00    	ja     15fb <printf+0x13d>
    153c:	ff 24 85 e8 17 00 00 	jmp    *0x17e8(,%eax,4)
        printint(fd, *ap, 10, 1);
    1543:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1546:	8b 17                	mov    (%edi),%edx
    1548:	83 ec 0c             	sub    $0xc,%esp
    154b:	6a 01                	push   $0x1
    154d:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1552:	8b 45 08             	mov    0x8(%ebp),%eax
    1555:	e8 d9 fe ff ff       	call   1433 <printint>
        ap++;
    155a:	83 c7 04             	add    $0x4,%edi
    155d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1560:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1563:	be 00 00 00 00       	mov    $0x0,%esi
    1568:	eb 80                	jmp    14ea <printf+0x2c>
        printint(fd, *ap, 16, 0);
    156a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    156d:	8b 17                	mov    (%edi),%edx
    156f:	83 ec 0c             	sub    $0xc,%esp
    1572:	6a 00                	push   $0x0
    1574:	b9 10 00 00 00       	mov    $0x10,%ecx
    1579:	8b 45 08             	mov    0x8(%ebp),%eax
    157c:	e8 b2 fe ff ff       	call   1433 <printint>
        ap++;
    1581:	83 c7 04             	add    $0x4,%edi
    1584:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1587:	83 c4 10             	add    $0x10,%esp
      state = 0;
    158a:	be 00 00 00 00       	mov    $0x0,%esi
    158f:	e9 56 ff ff ff       	jmp    14ea <printf+0x2c>
        s = (char*)*ap;
    1594:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1597:	8b 30                	mov    (%eax),%esi
        ap++;
    1599:	83 c0 04             	add    $0x4,%eax
    159c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    159f:	85 f6                	test   %esi,%esi
    15a1:	75 15                	jne    15b8 <printf+0xfa>
          s = "(null)";
    15a3:	be de 17 00 00       	mov    $0x17de,%esi
    15a8:	eb 0e                	jmp    15b8 <printf+0xfa>
          putc(fd, *s);
    15aa:	0f be d2             	movsbl %dl,%edx
    15ad:	8b 45 08             	mov    0x8(%ebp),%eax
    15b0:	e8 64 fe ff ff       	call   1419 <putc>
          s++;
    15b5:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    15b8:	0f b6 16             	movzbl (%esi),%edx
    15bb:	84 d2                	test   %dl,%dl
    15bd:	75 eb                	jne    15aa <printf+0xec>
      state = 0;
    15bf:	be 00 00 00 00       	mov    $0x0,%esi
    15c4:	e9 21 ff ff ff       	jmp    14ea <printf+0x2c>
        putc(fd, *ap);
    15c9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    15cc:	0f be 17             	movsbl (%edi),%edx
    15cf:	8b 45 08             	mov    0x8(%ebp),%eax
    15d2:	e8 42 fe ff ff       	call   1419 <putc>
        ap++;
    15d7:	83 c7 04             	add    $0x4,%edi
    15da:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    15dd:	be 00 00 00 00       	mov    $0x0,%esi
    15e2:	e9 03 ff ff ff       	jmp    14ea <printf+0x2c>
        putc(fd, c);
    15e7:	89 fa                	mov    %edi,%edx
    15e9:	8b 45 08             	mov    0x8(%ebp),%eax
    15ec:	e8 28 fe ff ff       	call   1419 <putc>
      state = 0;
    15f1:	be 00 00 00 00       	mov    $0x0,%esi
    15f6:	e9 ef fe ff ff       	jmp    14ea <printf+0x2c>
        putc(fd, '%');
    15fb:	ba 25 00 00 00       	mov    $0x25,%edx
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
    1603:	e8 11 fe ff ff       	call   1419 <putc>
        putc(fd, c);
    1608:	89 fa                	mov    %edi,%edx
    160a:	8b 45 08             	mov    0x8(%ebp),%eax
    160d:	e8 07 fe ff ff       	call   1419 <putc>
      state = 0;
    1612:	be 00 00 00 00       	mov    $0x0,%esi
    1617:	e9 ce fe ff ff       	jmp    14ea <printf+0x2c>
    }
  }
}
    161c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    161f:	5b                   	pop    %ebx
    1620:	5e                   	pop    %esi
    1621:	5f                   	pop    %edi
    1622:	5d                   	pop    %ebp
    1623:	c3                   	ret    

00001624 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1624:	55                   	push   %ebp
    1625:	89 e5                	mov    %esp,%ebp
    1627:	57                   	push   %edi
    1628:	56                   	push   %esi
    1629:	53                   	push   %ebx
    162a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    162d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1630:	a1 ec 1a 00 00       	mov    0x1aec,%eax
    1635:	eb 02                	jmp    1639 <free+0x15>
    1637:	89 d0                	mov    %edx,%eax
    1639:	39 c8                	cmp    %ecx,%eax
    163b:	73 04                	jae    1641 <free+0x1d>
    163d:	39 08                	cmp    %ecx,(%eax)
    163f:	77 12                	ja     1653 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1641:	8b 10                	mov    (%eax),%edx
    1643:	39 c2                	cmp    %eax,%edx
    1645:	77 f0                	ja     1637 <free+0x13>
    1647:	39 c8                	cmp    %ecx,%eax
    1649:	72 08                	jb     1653 <free+0x2f>
    164b:	39 ca                	cmp    %ecx,%edx
    164d:	77 04                	ja     1653 <free+0x2f>
    164f:	89 d0                	mov    %edx,%eax
    1651:	eb e6                	jmp    1639 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1653:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1656:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1659:	8b 10                	mov    (%eax),%edx
    165b:	39 d7                	cmp    %edx,%edi
    165d:	74 19                	je     1678 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    165f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1662:	8b 50 04             	mov    0x4(%eax),%edx
    1665:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1668:	39 ce                	cmp    %ecx,%esi
    166a:	74 1b                	je     1687 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    166c:	89 08                	mov    %ecx,(%eax)
  freep = p;
    166e:	a3 ec 1a 00 00       	mov    %eax,0x1aec
}
    1673:	5b                   	pop    %ebx
    1674:	5e                   	pop    %esi
    1675:	5f                   	pop    %edi
    1676:	5d                   	pop    %ebp
    1677:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1678:	03 72 04             	add    0x4(%edx),%esi
    167b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    167e:	8b 10                	mov    (%eax),%edx
    1680:	8b 12                	mov    (%edx),%edx
    1682:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1685:	eb db                	jmp    1662 <free+0x3e>
    p->s.size += bp->s.size;
    1687:	03 53 fc             	add    -0x4(%ebx),%edx
    168a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    168d:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1690:	89 10                	mov    %edx,(%eax)
    1692:	eb da                	jmp    166e <free+0x4a>

00001694 <morecore>:

static Header*
morecore(uint nu)
{
    1694:	55                   	push   %ebp
    1695:	89 e5                	mov    %esp,%ebp
    1697:	53                   	push   %ebx
    1698:	83 ec 04             	sub    $0x4,%esp
    169b:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    169d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    16a2:	77 05                	ja     16a9 <morecore+0x15>
    nu = 4096;
    16a4:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    16a9:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    16b0:	83 ec 0c             	sub    $0xc,%esp
    16b3:	50                   	push   %eax
    16b4:	e8 28 fd ff ff       	call   13e1 <sbrk>
  if(p == (char*)-1)
    16b9:	83 c4 10             	add    $0x10,%esp
    16bc:	83 f8 ff             	cmp    $0xffffffff,%eax
    16bf:	74 1c                	je     16dd <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    16c1:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    16c4:	83 c0 08             	add    $0x8,%eax
    16c7:	83 ec 0c             	sub    $0xc,%esp
    16ca:	50                   	push   %eax
    16cb:	e8 54 ff ff ff       	call   1624 <free>
  return freep;
    16d0:	a1 ec 1a 00 00       	mov    0x1aec,%eax
    16d5:	83 c4 10             	add    $0x10,%esp
}
    16d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16db:	c9                   	leave  
    16dc:	c3                   	ret    
    return 0;
    16dd:	b8 00 00 00 00       	mov    $0x0,%eax
    16e2:	eb f4                	jmp    16d8 <morecore+0x44>

000016e4 <malloc>:

void*
malloc(uint nbytes)
{
    16e4:	55                   	push   %ebp
    16e5:	89 e5                	mov    %esp,%ebp
    16e7:	53                   	push   %ebx
    16e8:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16eb:	8b 45 08             	mov    0x8(%ebp),%eax
    16ee:	8d 58 07             	lea    0x7(%eax),%ebx
    16f1:	c1 eb 03             	shr    $0x3,%ebx
    16f4:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    16f7:	8b 0d ec 1a 00 00    	mov    0x1aec,%ecx
    16fd:	85 c9                	test   %ecx,%ecx
    16ff:	74 04                	je     1705 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1701:	8b 01                	mov    (%ecx),%eax
    1703:	eb 4a                	jmp    174f <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1705:	c7 05 ec 1a 00 00 f0 	movl   $0x1af0,0x1aec
    170c:	1a 00 00 
    170f:	c7 05 f0 1a 00 00 f0 	movl   $0x1af0,0x1af0
    1716:	1a 00 00 
    base.s.size = 0;
    1719:	c7 05 f4 1a 00 00 00 	movl   $0x0,0x1af4
    1720:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1723:	b9 f0 1a 00 00       	mov    $0x1af0,%ecx
    1728:	eb d7                	jmp    1701 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    172a:	74 19                	je     1745 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    172c:	29 da                	sub    %ebx,%edx
    172e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1731:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1734:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1737:	89 0d ec 1a 00 00    	mov    %ecx,0x1aec
      return (void*)(p + 1);
    173d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1740:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1743:	c9                   	leave  
    1744:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1745:	8b 10                	mov    (%eax),%edx
    1747:	89 11                	mov    %edx,(%ecx)
    1749:	eb ec                	jmp    1737 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    174b:	89 c1                	mov    %eax,%ecx
    174d:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    174f:	8b 50 04             	mov    0x4(%eax),%edx
    1752:	39 da                	cmp    %ebx,%edx
    1754:	73 d4                	jae    172a <malloc+0x46>
    if(p == freep)
    1756:	39 05 ec 1a 00 00    	cmp    %eax,0x1aec
    175c:	75 ed                	jne    174b <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    175e:	89 d8                	mov    %ebx,%eax
    1760:	e8 2f ff ff ff       	call   1694 <morecore>
    1765:	85 c0                	test   %eax,%eax
    1767:	75 e2                	jne    174b <malloc+0x67>
    1769:	eb d5                	jmp    1740 <malloc+0x5c>
