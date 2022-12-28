
_test_2:     file format elf32-i386


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
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
    100f:	81 ec 00 04 00 00    	sub    $0x400,%esp
   struct pstat st;
   int pid = getpid();
    1015:	e8 a3 02 00 00       	call   12bd <getpid>
    101a:	89 c3                	mov    %eax,%ebx
   int defaulttickets = 0;
   
   if(getpinfo(&st) == 0)
    101c:	83 ec 0c             	sub    $0xc,%esp
    101f:	8d 85 f8 fb ff ff    	lea    -0x408(%ebp),%eax
    1025:	50                   	push   %eax
    1026:	e8 ba 02 00 00       	call   12e5 <getpinfo>
    102b:	83 c4 10             	add    $0x10,%esp
    102e:	85 c0                	test   %eax,%eax
    1030:	75 28                	jne    105a <main+0x5a>
   {
    for(int i = 0; i < NPROC; i++) {
    1032:	89 c2                	mov    %eax,%edx
    1034:	eb 03                	jmp    1039 <main+0x39>
    1036:	83 c2 01             	add    $0x1,%edx
    1039:	83 fa 3f             	cmp    $0x3f,%edx
    103c:	7f 30                	jg     106e <main+0x6e>
      if (st.inuse[i]) {
    103e:	83 bc 95 f8 fb ff ff 	cmpl   $0x0,-0x408(%ebp,%edx,4)
    1045:	00 
    1046:	74 ee                	je     1036 <main+0x36>
        if(st.pid[i] == pid) {
    1048:	39 9c 95 f8 fd ff ff 	cmp    %ebx,-0x208(%ebp,%edx,4)
    104f:	75 e5                	jne    1036 <main+0x36>
          defaulttickets = st.tickets[i];
    1051:	8b 84 95 f8 fc ff ff 	mov    -0x308(%ebp,%edx,4),%eax
    1058:	eb dc                	jmp    1036 <main+0x36>
      }
   }
   }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    105a:	83 ec 08             	sub    $0x8,%esp
    105d:	68 50 16 00 00       	push   $0x1650
    1062:	6a 01                	push   $0x1
    1064:	e8 39 03 00 00       	call   13a2 <printf>
   exit();
    1069:	e8 cf 01 00 00       	call   123d <exit>
  }

  
  if(defaulttickets == 1)
    106e:	83 f8 01             	cmp    $0x1,%eax
    1071:	74 17                	je     108a <main+0x8a>
  {
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
  }
  else
  {
   printf(1, "XV6_SCHEDULER\t FAILED\n");
    1073:	83 ec 08             	sub    $0x8,%esp
    1076:	68 50 16 00 00       	push   $0x1650
    107b:	6a 01                	push   $0x1
    107d:	e8 20 03 00 00       	call   13a2 <printf>
    1082:	83 c4 10             	add    $0x10,%esp
  }
   exit();
    1085:	e8 b3 01 00 00       	call   123d <exit>
   printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    108a:	83 ec 08             	sub    $0x8,%esp
    108d:	68 67 16 00 00       	push   $0x1667
    1092:	6a 01                	push   $0x1
    1094:	e8 09 03 00 00       	call   13a2 <printf>
    1099:	83 c4 10             	add    $0x10,%esp
    109c:	eb e7                	jmp    1085 <main+0x85>

0000109e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    109e:	55                   	push   %ebp
    109f:	89 e5                	mov    %esp,%ebp
    10a1:	56                   	push   %esi
    10a2:	53                   	push   %ebx
    10a3:	8b 75 08             	mov    0x8(%ebp),%esi
    10a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10a9:	89 f0                	mov    %esi,%eax
    10ab:	89 d1                	mov    %edx,%ecx
    10ad:	83 c2 01             	add    $0x1,%edx
    10b0:	89 c3                	mov    %eax,%ebx
    10b2:	83 c0 01             	add    $0x1,%eax
    10b5:	0f b6 09             	movzbl (%ecx),%ecx
    10b8:	88 0b                	mov    %cl,(%ebx)
    10ba:	84 c9                	test   %cl,%cl
    10bc:	75 ed                	jne    10ab <strcpy+0xd>
    ;
  return os;
}
    10be:	89 f0                	mov    %esi,%eax
    10c0:	5b                   	pop    %ebx
    10c1:	5e                   	pop    %esi
    10c2:	5d                   	pop    %ebp
    10c3:	c3                   	ret    

000010c4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10c4:	55                   	push   %ebp
    10c5:	89 e5                	mov    %esp,%ebp
    10c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10cd:	eb 06                	jmp    10d5 <strcmp+0x11>
    p++, q++;
    10cf:	83 c1 01             	add    $0x1,%ecx
    10d2:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10d5:	0f b6 01             	movzbl (%ecx),%eax
    10d8:	84 c0                	test   %al,%al
    10da:	74 04                	je     10e0 <strcmp+0x1c>
    10dc:	3a 02                	cmp    (%edx),%al
    10de:	74 ef                	je     10cf <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    10e0:	0f b6 c0             	movzbl %al,%eax
    10e3:	0f b6 12             	movzbl (%edx),%edx
    10e6:	29 d0                	sub    %edx,%eax
}
    10e8:	5d                   	pop    %ebp
    10e9:	c3                   	ret    

000010ea <strlen>:

uint
strlen(const char *s)
{
    10ea:	55                   	push   %ebp
    10eb:	89 e5                	mov    %esp,%ebp
    10ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10f0:	b8 00 00 00 00       	mov    $0x0,%eax
    10f5:	eb 03                	jmp    10fa <strlen+0x10>
    10f7:	83 c0 01             	add    $0x1,%eax
    10fa:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    10fe:	75 f7                	jne    10f7 <strlen+0xd>
    ;
  return n;
}
    1100:	5d                   	pop    %ebp
    1101:	c3                   	ret    

00001102 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1102:	55                   	push   %ebp
    1103:	89 e5                	mov    %esp,%ebp
    1105:	57                   	push   %edi
    1106:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1109:	89 d7                	mov    %edx,%edi
    110b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    110e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1111:	fc                   	cld    
    1112:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1114:	89 d0                	mov    %edx,%eax
    1116:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1119:	c9                   	leave  
    111a:	c3                   	ret    

0000111b <strchr>:

char*
strchr(const char *s, char c)
{
    111b:	55                   	push   %ebp
    111c:	89 e5                	mov    %esp,%ebp
    111e:	8b 45 08             	mov    0x8(%ebp),%eax
    1121:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1125:	eb 03                	jmp    112a <strchr+0xf>
    1127:	83 c0 01             	add    $0x1,%eax
    112a:	0f b6 10             	movzbl (%eax),%edx
    112d:	84 d2                	test   %dl,%dl
    112f:	74 06                	je     1137 <strchr+0x1c>
    if(*s == c)
    1131:	38 ca                	cmp    %cl,%dl
    1133:	75 f2                	jne    1127 <strchr+0xc>
    1135:	eb 05                	jmp    113c <strchr+0x21>
      return (char*)s;
  return 0;
    1137:	b8 00 00 00 00       	mov    $0x0,%eax
}
    113c:	5d                   	pop    %ebp
    113d:	c3                   	ret    

0000113e <gets>:

char*
gets(char *buf, int max)
{
    113e:	55                   	push   %ebp
    113f:	89 e5                	mov    %esp,%ebp
    1141:	57                   	push   %edi
    1142:	56                   	push   %esi
    1143:	53                   	push   %ebx
    1144:	83 ec 1c             	sub    $0x1c,%esp
    1147:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    114a:	bb 00 00 00 00       	mov    $0x0,%ebx
    114f:	89 de                	mov    %ebx,%esi
    1151:	83 c3 01             	add    $0x1,%ebx
    1154:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1157:	7d 2e                	jge    1187 <gets+0x49>
    cc = read(0, &c, 1);
    1159:	83 ec 04             	sub    $0x4,%esp
    115c:	6a 01                	push   $0x1
    115e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1161:	50                   	push   %eax
    1162:	6a 00                	push   $0x0
    1164:	e8 ec 00 00 00       	call   1255 <read>
    if(cc < 1)
    1169:	83 c4 10             	add    $0x10,%esp
    116c:	85 c0                	test   %eax,%eax
    116e:	7e 17                	jle    1187 <gets+0x49>
      break;
    buf[i++] = c;
    1170:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1174:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1177:	3c 0a                	cmp    $0xa,%al
    1179:	0f 94 c2             	sete   %dl
    117c:	3c 0d                	cmp    $0xd,%al
    117e:	0f 94 c0             	sete   %al
    1181:	08 c2                	or     %al,%dl
    1183:	74 ca                	je     114f <gets+0x11>
    buf[i++] = c;
    1185:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1187:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    118b:	89 f8                	mov    %edi,%eax
    118d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1190:	5b                   	pop    %ebx
    1191:	5e                   	pop    %esi
    1192:	5f                   	pop    %edi
    1193:	5d                   	pop    %ebp
    1194:	c3                   	ret    

00001195 <stat>:

int
stat(const char *n, struct stat *st)
{
    1195:	55                   	push   %ebp
    1196:	89 e5                	mov    %esp,%ebp
    1198:	56                   	push   %esi
    1199:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    119a:	83 ec 08             	sub    $0x8,%esp
    119d:	6a 00                	push   $0x0
    119f:	ff 75 08             	push   0x8(%ebp)
    11a2:	e8 d6 00 00 00       	call   127d <open>
  if(fd < 0)
    11a7:	83 c4 10             	add    $0x10,%esp
    11aa:	85 c0                	test   %eax,%eax
    11ac:	78 24                	js     11d2 <stat+0x3d>
    11ae:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    11b0:	83 ec 08             	sub    $0x8,%esp
    11b3:	ff 75 0c             	push   0xc(%ebp)
    11b6:	50                   	push   %eax
    11b7:	e8 d9 00 00 00       	call   1295 <fstat>
    11bc:	89 c6                	mov    %eax,%esi
  close(fd);
    11be:	89 1c 24             	mov    %ebx,(%esp)
    11c1:	e8 9f 00 00 00       	call   1265 <close>
  return r;
    11c6:	83 c4 10             	add    $0x10,%esp
}
    11c9:	89 f0                	mov    %esi,%eax
    11cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11ce:	5b                   	pop    %ebx
    11cf:	5e                   	pop    %esi
    11d0:	5d                   	pop    %ebp
    11d1:	c3                   	ret    
    return -1;
    11d2:	be ff ff ff ff       	mov    $0xffffffff,%esi
    11d7:	eb f0                	jmp    11c9 <stat+0x34>

000011d9 <atoi>:

int
atoi(const char *s)
{
    11d9:	55                   	push   %ebp
    11da:	89 e5                	mov    %esp,%ebp
    11dc:	53                   	push   %ebx
    11dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    11e0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    11e5:	eb 10                	jmp    11f7 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    11e7:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    11ea:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    11ed:	83 c1 01             	add    $0x1,%ecx
    11f0:	0f be c0             	movsbl %al,%eax
    11f3:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    11f7:	0f b6 01             	movzbl (%ecx),%eax
    11fa:	8d 58 d0             	lea    -0x30(%eax),%ebx
    11fd:	80 fb 09             	cmp    $0x9,%bl
    1200:	76 e5                	jbe    11e7 <atoi+0xe>
  return n;
}
    1202:	89 d0                	mov    %edx,%eax
    1204:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1207:	c9                   	leave  
    1208:	c3                   	ret    

00001209 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1209:	55                   	push   %ebp
    120a:	89 e5                	mov    %esp,%ebp
    120c:	56                   	push   %esi
    120d:	53                   	push   %ebx
    120e:	8b 75 08             	mov    0x8(%ebp),%esi
    1211:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1214:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1217:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1219:	eb 0d                	jmp    1228 <memmove+0x1f>
    *dst++ = *src++;
    121b:	0f b6 01             	movzbl (%ecx),%eax
    121e:	88 02                	mov    %al,(%edx)
    1220:	8d 49 01             	lea    0x1(%ecx),%ecx
    1223:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1226:	89 d8                	mov    %ebx,%eax
    1228:	8d 58 ff             	lea    -0x1(%eax),%ebx
    122b:	85 c0                	test   %eax,%eax
    122d:	7f ec                	jg     121b <memmove+0x12>
  return vdst;
}
    122f:	89 f0                	mov    %esi,%eax
    1231:	5b                   	pop    %ebx
    1232:	5e                   	pop    %esi
    1233:	5d                   	pop    %ebp
    1234:	c3                   	ret    

00001235 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1235:	b8 01 00 00 00       	mov    $0x1,%eax
    123a:	cd 40                	int    $0x40
    123c:	c3                   	ret    

0000123d <exit>:
SYSCALL(exit)
    123d:	b8 02 00 00 00       	mov    $0x2,%eax
    1242:	cd 40                	int    $0x40
    1244:	c3                   	ret    

00001245 <wait>:
SYSCALL(wait)
    1245:	b8 03 00 00 00       	mov    $0x3,%eax
    124a:	cd 40                	int    $0x40
    124c:	c3                   	ret    

0000124d <pipe>:
SYSCALL(pipe)
    124d:	b8 04 00 00 00       	mov    $0x4,%eax
    1252:	cd 40                	int    $0x40
    1254:	c3                   	ret    

00001255 <read>:
SYSCALL(read)
    1255:	b8 05 00 00 00       	mov    $0x5,%eax
    125a:	cd 40                	int    $0x40
    125c:	c3                   	ret    

0000125d <write>:
SYSCALL(write)
    125d:	b8 10 00 00 00       	mov    $0x10,%eax
    1262:	cd 40                	int    $0x40
    1264:	c3                   	ret    

00001265 <close>:
SYSCALL(close)
    1265:	b8 15 00 00 00       	mov    $0x15,%eax
    126a:	cd 40                	int    $0x40
    126c:	c3                   	ret    

0000126d <kill>:
SYSCALL(kill)
    126d:	b8 06 00 00 00       	mov    $0x6,%eax
    1272:	cd 40                	int    $0x40
    1274:	c3                   	ret    

00001275 <exec>:
SYSCALL(exec)
    1275:	b8 07 00 00 00       	mov    $0x7,%eax
    127a:	cd 40                	int    $0x40
    127c:	c3                   	ret    

0000127d <open>:
SYSCALL(open)
    127d:	b8 0f 00 00 00       	mov    $0xf,%eax
    1282:	cd 40                	int    $0x40
    1284:	c3                   	ret    

00001285 <mknod>:
SYSCALL(mknod)
    1285:	b8 11 00 00 00       	mov    $0x11,%eax
    128a:	cd 40                	int    $0x40
    128c:	c3                   	ret    

0000128d <unlink>:
SYSCALL(unlink)
    128d:	b8 12 00 00 00       	mov    $0x12,%eax
    1292:	cd 40                	int    $0x40
    1294:	c3                   	ret    

00001295 <fstat>:
SYSCALL(fstat)
    1295:	b8 08 00 00 00       	mov    $0x8,%eax
    129a:	cd 40                	int    $0x40
    129c:	c3                   	ret    

0000129d <link>:
SYSCALL(link)
    129d:	b8 13 00 00 00       	mov    $0x13,%eax
    12a2:	cd 40                	int    $0x40
    12a4:	c3                   	ret    

000012a5 <mkdir>:
SYSCALL(mkdir)
    12a5:	b8 14 00 00 00       	mov    $0x14,%eax
    12aa:	cd 40                	int    $0x40
    12ac:	c3                   	ret    

000012ad <chdir>:
SYSCALL(chdir)
    12ad:	b8 09 00 00 00       	mov    $0x9,%eax
    12b2:	cd 40                	int    $0x40
    12b4:	c3                   	ret    

000012b5 <dup>:
SYSCALL(dup)
    12b5:	b8 0a 00 00 00       	mov    $0xa,%eax
    12ba:	cd 40                	int    $0x40
    12bc:	c3                   	ret    

000012bd <getpid>:
SYSCALL(getpid)
    12bd:	b8 0b 00 00 00       	mov    $0xb,%eax
    12c2:	cd 40                	int    $0x40
    12c4:	c3                   	ret    

000012c5 <sbrk>:
SYSCALL(sbrk)
    12c5:	b8 0c 00 00 00       	mov    $0xc,%eax
    12ca:	cd 40                	int    $0x40
    12cc:	c3                   	ret    

000012cd <sleep>:
SYSCALL(sleep)
    12cd:	b8 0d 00 00 00       	mov    $0xd,%eax
    12d2:	cd 40                	int    $0x40
    12d4:	c3                   	ret    

000012d5 <uptime>:
SYSCALL(uptime)
    12d5:	b8 0e 00 00 00       	mov    $0xe,%eax
    12da:	cd 40                	int    $0x40
    12dc:	c3                   	ret    

000012dd <settickets>:
SYSCALL(settickets)
    12dd:	b8 16 00 00 00       	mov    $0x16,%eax
    12e2:	cd 40                	int    $0x40
    12e4:	c3                   	ret    

000012e5 <getpinfo>:
SYSCALL(getpinfo)
    12e5:	b8 17 00 00 00       	mov    $0x17,%eax
    12ea:	cd 40                	int    $0x40
    12ec:	c3                   	ret    

000012ed <mprotect>:
SYSCALL(mprotect)
    12ed:	b8 18 00 00 00       	mov    $0x18,%eax
    12f2:	cd 40                	int    $0x40
    12f4:	c3                   	ret    

000012f5 <munprotect>:
    12f5:	b8 19 00 00 00       	mov    $0x19,%eax
    12fa:	cd 40                	int    $0x40
    12fc:	c3                   	ret    

000012fd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    12fd:	55                   	push   %ebp
    12fe:	89 e5                	mov    %esp,%ebp
    1300:	83 ec 1c             	sub    $0x1c,%esp
    1303:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1306:	6a 01                	push   $0x1
    1308:	8d 55 f4             	lea    -0xc(%ebp),%edx
    130b:	52                   	push   %edx
    130c:	50                   	push   %eax
    130d:	e8 4b ff ff ff       	call   125d <write>
}
    1312:	83 c4 10             	add    $0x10,%esp
    1315:	c9                   	leave  
    1316:	c3                   	ret    

00001317 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1317:	55                   	push   %ebp
    1318:	89 e5                	mov    %esp,%ebp
    131a:	57                   	push   %edi
    131b:	56                   	push   %esi
    131c:	53                   	push   %ebx
    131d:	83 ec 2c             	sub    $0x2c,%esp
    1320:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1323:	89 d0                	mov    %edx,%eax
    1325:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1327:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    132b:	0f 95 c1             	setne  %cl
    132e:	c1 ea 1f             	shr    $0x1f,%edx
    1331:	84 d1                	test   %dl,%cl
    1333:	74 44                	je     1379 <printint+0x62>
    neg = 1;
    x = -xx;
    1335:	f7 d8                	neg    %eax
    1337:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1339:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1340:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1345:	89 c8                	mov    %ecx,%eax
    1347:	ba 00 00 00 00       	mov    $0x0,%edx
    134c:	f7 f6                	div    %esi
    134e:	89 df                	mov    %ebx,%edi
    1350:	83 c3 01             	add    $0x1,%ebx
    1353:	0f b6 92 e0 16 00 00 	movzbl 0x16e0(%edx),%edx
    135a:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    135e:	89 ca                	mov    %ecx,%edx
    1360:	89 c1                	mov    %eax,%ecx
    1362:	39 d6                	cmp    %edx,%esi
    1364:	76 df                	jbe    1345 <printint+0x2e>
  if(neg)
    1366:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    136a:	74 31                	je     139d <printint+0x86>
    buf[i++] = '-';
    136c:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1371:	8d 5f 02             	lea    0x2(%edi),%ebx
    1374:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1377:	eb 17                	jmp    1390 <printint+0x79>
    x = xx;
    1379:	89 c1                	mov    %eax,%ecx
  neg = 0;
    137b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1382:	eb bc                	jmp    1340 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1384:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1389:	89 f0                	mov    %esi,%eax
    138b:	e8 6d ff ff ff       	call   12fd <putc>
  while(--i >= 0)
    1390:	83 eb 01             	sub    $0x1,%ebx
    1393:	79 ef                	jns    1384 <printint+0x6d>
}
    1395:	83 c4 2c             	add    $0x2c,%esp
    1398:	5b                   	pop    %ebx
    1399:	5e                   	pop    %esi
    139a:	5f                   	pop    %edi
    139b:	5d                   	pop    %ebp
    139c:	c3                   	ret    
    139d:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13a0:	eb ee                	jmp    1390 <printint+0x79>

000013a2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    13a2:	55                   	push   %ebp
    13a3:	89 e5                	mov    %esp,%ebp
    13a5:	57                   	push   %edi
    13a6:	56                   	push   %esi
    13a7:	53                   	push   %ebx
    13a8:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    13ab:	8d 45 10             	lea    0x10(%ebp),%eax
    13ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    13b1:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    13b6:	bb 00 00 00 00       	mov    $0x0,%ebx
    13bb:	eb 14                	jmp    13d1 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    13bd:	89 fa                	mov    %edi,%edx
    13bf:	8b 45 08             	mov    0x8(%ebp),%eax
    13c2:	e8 36 ff ff ff       	call   12fd <putc>
    13c7:	eb 05                	jmp    13ce <printf+0x2c>
      }
    } else if(state == '%'){
    13c9:	83 fe 25             	cmp    $0x25,%esi
    13cc:	74 25                	je     13f3 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    13ce:	83 c3 01             	add    $0x1,%ebx
    13d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d4:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    13d8:	84 c0                	test   %al,%al
    13da:	0f 84 20 01 00 00    	je     1500 <printf+0x15e>
    c = fmt[i] & 0xff;
    13e0:	0f be f8             	movsbl %al,%edi
    13e3:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    13e6:	85 f6                	test   %esi,%esi
    13e8:	75 df                	jne    13c9 <printf+0x27>
      if(c == '%'){
    13ea:	83 f8 25             	cmp    $0x25,%eax
    13ed:	75 ce                	jne    13bd <printf+0x1b>
        state = '%';
    13ef:	89 c6                	mov    %eax,%esi
    13f1:	eb db                	jmp    13ce <printf+0x2c>
      if(c == 'd'){
    13f3:	83 f8 25             	cmp    $0x25,%eax
    13f6:	0f 84 cf 00 00 00    	je     14cb <printf+0x129>
    13fc:	0f 8c dd 00 00 00    	jl     14df <printf+0x13d>
    1402:	83 f8 78             	cmp    $0x78,%eax
    1405:	0f 8f d4 00 00 00    	jg     14df <printf+0x13d>
    140b:	83 f8 63             	cmp    $0x63,%eax
    140e:	0f 8c cb 00 00 00    	jl     14df <printf+0x13d>
    1414:	83 e8 63             	sub    $0x63,%eax
    1417:	83 f8 15             	cmp    $0x15,%eax
    141a:	0f 87 bf 00 00 00    	ja     14df <printf+0x13d>
    1420:	ff 24 85 88 16 00 00 	jmp    *0x1688(,%eax,4)
        printint(fd, *ap, 10, 1);
    1427:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    142a:	8b 17                	mov    (%edi),%edx
    142c:	83 ec 0c             	sub    $0xc,%esp
    142f:	6a 01                	push   $0x1
    1431:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1436:	8b 45 08             	mov    0x8(%ebp),%eax
    1439:	e8 d9 fe ff ff       	call   1317 <printint>
        ap++;
    143e:	83 c7 04             	add    $0x4,%edi
    1441:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1444:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1447:	be 00 00 00 00       	mov    $0x0,%esi
    144c:	eb 80                	jmp    13ce <printf+0x2c>
        printint(fd, *ap, 16, 0);
    144e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1451:	8b 17                	mov    (%edi),%edx
    1453:	83 ec 0c             	sub    $0xc,%esp
    1456:	6a 00                	push   $0x0
    1458:	b9 10 00 00 00       	mov    $0x10,%ecx
    145d:	8b 45 08             	mov    0x8(%ebp),%eax
    1460:	e8 b2 fe ff ff       	call   1317 <printint>
        ap++;
    1465:	83 c7 04             	add    $0x4,%edi
    1468:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    146b:	83 c4 10             	add    $0x10,%esp
      state = 0;
    146e:	be 00 00 00 00       	mov    $0x0,%esi
    1473:	e9 56 ff ff ff       	jmp    13ce <printf+0x2c>
        s = (char*)*ap;
    1478:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    147b:	8b 30                	mov    (%eax),%esi
        ap++;
    147d:	83 c0 04             	add    $0x4,%eax
    1480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1483:	85 f6                	test   %esi,%esi
    1485:	75 15                	jne    149c <printf+0xfa>
          s = "(null)";
    1487:	be 7f 16 00 00       	mov    $0x167f,%esi
    148c:	eb 0e                	jmp    149c <printf+0xfa>
          putc(fd, *s);
    148e:	0f be d2             	movsbl %dl,%edx
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
    1494:	e8 64 fe ff ff       	call   12fd <putc>
          s++;
    1499:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    149c:	0f b6 16             	movzbl (%esi),%edx
    149f:	84 d2                	test   %dl,%dl
    14a1:	75 eb                	jne    148e <printf+0xec>
      state = 0;
    14a3:	be 00 00 00 00       	mov    $0x0,%esi
    14a8:	e9 21 ff ff ff       	jmp    13ce <printf+0x2c>
        putc(fd, *ap);
    14ad:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14b0:	0f be 17             	movsbl (%edi),%edx
    14b3:	8b 45 08             	mov    0x8(%ebp),%eax
    14b6:	e8 42 fe ff ff       	call   12fd <putc>
        ap++;
    14bb:	83 c7 04             	add    $0x4,%edi
    14be:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    14c1:	be 00 00 00 00       	mov    $0x0,%esi
    14c6:	e9 03 ff ff ff       	jmp    13ce <printf+0x2c>
        putc(fd, c);
    14cb:	89 fa                	mov    %edi,%edx
    14cd:	8b 45 08             	mov    0x8(%ebp),%eax
    14d0:	e8 28 fe ff ff       	call   12fd <putc>
      state = 0;
    14d5:	be 00 00 00 00       	mov    $0x0,%esi
    14da:	e9 ef fe ff ff       	jmp    13ce <printf+0x2c>
        putc(fd, '%');
    14df:	ba 25 00 00 00       	mov    $0x25,%edx
    14e4:	8b 45 08             	mov    0x8(%ebp),%eax
    14e7:	e8 11 fe ff ff       	call   12fd <putc>
        putc(fd, c);
    14ec:	89 fa                	mov    %edi,%edx
    14ee:	8b 45 08             	mov    0x8(%ebp),%eax
    14f1:	e8 07 fe ff ff       	call   12fd <putc>
      state = 0;
    14f6:	be 00 00 00 00       	mov    $0x0,%esi
    14fb:	e9 ce fe ff ff       	jmp    13ce <printf+0x2c>
    }
  }
}
    1500:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1503:	5b                   	pop    %ebx
    1504:	5e                   	pop    %esi
    1505:	5f                   	pop    %edi
    1506:	5d                   	pop    %ebp
    1507:	c3                   	ret    

00001508 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1508:	55                   	push   %ebp
    1509:	89 e5                	mov    %esp,%ebp
    150b:	57                   	push   %edi
    150c:	56                   	push   %esi
    150d:	53                   	push   %ebx
    150e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1511:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1514:	a1 84 19 00 00       	mov    0x1984,%eax
    1519:	eb 02                	jmp    151d <free+0x15>
    151b:	89 d0                	mov    %edx,%eax
    151d:	39 c8                	cmp    %ecx,%eax
    151f:	73 04                	jae    1525 <free+0x1d>
    1521:	39 08                	cmp    %ecx,(%eax)
    1523:	77 12                	ja     1537 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1525:	8b 10                	mov    (%eax),%edx
    1527:	39 c2                	cmp    %eax,%edx
    1529:	77 f0                	ja     151b <free+0x13>
    152b:	39 c8                	cmp    %ecx,%eax
    152d:	72 08                	jb     1537 <free+0x2f>
    152f:	39 ca                	cmp    %ecx,%edx
    1531:	77 04                	ja     1537 <free+0x2f>
    1533:	89 d0                	mov    %edx,%eax
    1535:	eb e6                	jmp    151d <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1537:	8b 73 fc             	mov    -0x4(%ebx),%esi
    153a:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    153d:	8b 10                	mov    (%eax),%edx
    153f:	39 d7                	cmp    %edx,%edi
    1541:	74 19                	je     155c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1543:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1546:	8b 50 04             	mov    0x4(%eax),%edx
    1549:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    154c:	39 ce                	cmp    %ecx,%esi
    154e:	74 1b                	je     156b <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1550:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1552:	a3 84 19 00 00       	mov    %eax,0x1984
}
    1557:	5b                   	pop    %ebx
    1558:	5e                   	pop    %esi
    1559:	5f                   	pop    %edi
    155a:	5d                   	pop    %ebp
    155b:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    155c:	03 72 04             	add    0x4(%edx),%esi
    155f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1562:	8b 10                	mov    (%eax),%edx
    1564:	8b 12                	mov    (%edx),%edx
    1566:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1569:	eb db                	jmp    1546 <free+0x3e>
    p->s.size += bp->s.size;
    156b:	03 53 fc             	add    -0x4(%ebx),%edx
    156e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1571:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1574:	89 10                	mov    %edx,(%eax)
    1576:	eb da                	jmp    1552 <free+0x4a>

00001578 <morecore>:

static Header*
morecore(uint nu)
{
    1578:	55                   	push   %ebp
    1579:	89 e5                	mov    %esp,%ebp
    157b:	53                   	push   %ebx
    157c:	83 ec 04             	sub    $0x4,%esp
    157f:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1581:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1586:	77 05                	ja     158d <morecore+0x15>
    nu = 4096;
    1588:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    158d:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1594:	83 ec 0c             	sub    $0xc,%esp
    1597:	50                   	push   %eax
    1598:	e8 28 fd ff ff       	call   12c5 <sbrk>
  if(p == (char*)-1)
    159d:	83 c4 10             	add    $0x10,%esp
    15a0:	83 f8 ff             	cmp    $0xffffffff,%eax
    15a3:	74 1c                	je     15c1 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    15a5:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15a8:	83 c0 08             	add    $0x8,%eax
    15ab:	83 ec 0c             	sub    $0xc,%esp
    15ae:	50                   	push   %eax
    15af:	e8 54 ff ff ff       	call   1508 <free>
  return freep;
    15b4:	a1 84 19 00 00       	mov    0x1984,%eax
    15b9:	83 c4 10             	add    $0x10,%esp
}
    15bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15bf:	c9                   	leave  
    15c0:	c3                   	ret    
    return 0;
    15c1:	b8 00 00 00 00       	mov    $0x0,%eax
    15c6:	eb f4                	jmp    15bc <morecore+0x44>

000015c8 <malloc>:

void*
malloc(uint nbytes)
{
    15c8:	55                   	push   %ebp
    15c9:	89 e5                	mov    %esp,%ebp
    15cb:	53                   	push   %ebx
    15cc:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15cf:	8b 45 08             	mov    0x8(%ebp),%eax
    15d2:	8d 58 07             	lea    0x7(%eax),%ebx
    15d5:	c1 eb 03             	shr    $0x3,%ebx
    15d8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    15db:	8b 0d 84 19 00 00    	mov    0x1984,%ecx
    15e1:	85 c9                	test   %ecx,%ecx
    15e3:	74 04                	je     15e9 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15e5:	8b 01                	mov    (%ecx),%eax
    15e7:	eb 4a                	jmp    1633 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    15e9:	c7 05 84 19 00 00 88 	movl   $0x1988,0x1984
    15f0:	19 00 00 
    15f3:	c7 05 88 19 00 00 88 	movl   $0x1988,0x1988
    15fa:	19 00 00 
    base.s.size = 0;
    15fd:	c7 05 8c 19 00 00 00 	movl   $0x0,0x198c
    1604:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1607:	b9 88 19 00 00       	mov    $0x1988,%ecx
    160c:	eb d7                	jmp    15e5 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    160e:	74 19                	je     1629 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1610:	29 da                	sub    %ebx,%edx
    1612:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1615:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1618:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    161b:	89 0d 84 19 00 00    	mov    %ecx,0x1984
      return (void*)(p + 1);
    1621:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1624:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1627:	c9                   	leave  
    1628:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1629:	8b 10                	mov    (%eax),%edx
    162b:	89 11                	mov    %edx,(%ecx)
    162d:	eb ec                	jmp    161b <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    162f:	89 c1                	mov    %eax,%ecx
    1631:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1633:	8b 50 04             	mov    0x4(%eax),%edx
    1636:	39 da                	cmp    %ebx,%edx
    1638:	73 d4                	jae    160e <malloc+0x46>
    if(p == freep)
    163a:	39 05 84 19 00 00    	cmp    %eax,0x1984
    1640:	75 ed                	jne    162f <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1642:	89 d8                	mov    %ebx,%eax
    1644:	e8 2f ff ff ff       	call   1578 <morecore>
    1649:	85 c0                	test   %eax,%eax
    164b:	75 e2                	jne    162f <malloc+0x67>
    164d:	eb d5                	jmp    1624 <malloc+0x5c>
