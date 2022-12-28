
_test_9:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"
#include "pstat.h"

int
main(int argc, char *argv[]){
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	push   -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	81 ec 08 04 00 00    	sub    $0x408,%esp
	int pid_par = getpid();
    1017:	e8 01 03 00 00       	call   131d <getpid>
    101c:	89 c3                	mov    %eax,%ebx
	int tickets = 0;
	
	if(settickets(tickets) == 0)
    101e:	83 ec 0c             	sub    $0xc,%esp
    1021:	6a 00                	push   $0x0
    1023:	e8 15 03 00 00       	call   133d <settickets>
    1028:	83 c4 10             	add    $0x10,%esp
    102b:	85 c0                	test   %eax,%eax
    102d:	74 14                	je     1043 <main+0x43>
	{
	}
	else
	{
	 printf(1, "XV6_SCHEDULER\t FAILED\n");
    102f:	83 ec 08             	sub    $0x8,%esp
    1032:	68 b0 16 00 00       	push   $0x16b0
    1037:	6a 01                	push   $0x1
    1039:	e8 c4 03 00 00       	call   1402 <printf>
	 exit();
    103e:	e8 5a 02 00 00       	call   129d <exit>
	}
	
	if(fork() == 0){
    1043:	e8 4d 02 00 00       	call   1295 <fork>
    1048:	85 c0                	test   %eax,%eax
    104a:	74 0e                	je     105a <main+0x5a>
		 printf(1, "XV6_SCHEDULER\t FAILED\n");
		}

    exit();
	}
  	while(wait() > 0);
    104c:	e8 54 02 00 00       	call   12a5 <wait>
    1051:	85 c0                	test   %eax,%eax
    1053:	7f f7                	jg     104c <main+0x4c>
	exit();
    1055:	e8 43 02 00 00       	call   129d <exit>
		int pid_chd = getpid();
    105a:	e8 be 02 00 00       	call   131d <getpid>
    105f:	89 c6                	mov    %eax,%esi
		if(getpinfo(&st) == 0)
    1061:	83 ec 0c             	sub    $0xc,%esp
    1064:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    106a:	50                   	push   %eax
    106b:	e8 d5 02 00 00       	call   1345 <getpinfo>
    1070:	83 c4 10             	add    $0x10,%esp
    1073:	85 c0                	test   %eax,%eax
    1075:	75 0c                	jne    1083 <main+0x83>
		int tickets_par = -1,tickets_chd = -1;
    1077:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    107c:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    1081:	eb 1e                	jmp    10a1 <main+0xa1>
		 printf(1, "XV6_SCHEDULER\t FAILED\n");
    1083:	83 ec 08             	sub    $0x8,%esp
    1086:	68 b0 16 00 00       	push   $0x16b0
    108b:	6a 01                	push   $0x1
    108d:	e8 70 03 00 00       	call   1402 <printf>
		 exit();
    1092:	e8 06 02 00 00       	call   129d <exit>
				tickets_par = st.tickets[i];
    1097:	8b 8c 85 e8 fc ff ff 	mov    -0x318(%ebp,%eax,4),%ecx
		for(int i = 0; i < NPROC; i++){
    109e:	83 c0 01             	add    $0x1,%eax
    10a1:	83 f8 3f             	cmp    $0x3f,%eax
    10a4:	7f 18                	jg     10be <main+0xbe>
      			if (st.pid[i] == pid_par){
    10a6:	8b 94 85 e8 fd ff ff 	mov    -0x218(%ebp,%eax,4),%edx
    10ad:	39 da                	cmp    %ebx,%edx
    10af:	74 e6                	je     1097 <main+0x97>
			else if (st.pid[i] == pid_chd){
    10b1:	39 f2                	cmp    %esi,%edx
    10b3:	75 e9                	jne    109e <main+0x9e>
				tickets_chd = st.tickets[i];
    10b5:	8b bc 85 e8 fc ff ff 	mov    -0x318(%ebp,%eax,4),%edi
    10bc:	eb e0                	jmp    109e <main+0x9e>
		printf(1, "parent: %d, child: %d\n", tickets_par, tickets_chd);
    10be:	57                   	push   %edi
    10bf:	51                   	push   %ecx
    10c0:	68 c7 16 00 00       	push   $0x16c7
    10c5:	6a 01                	push   $0x1
    10c7:	e8 36 03 00 00       	call   1402 <printf>
		if(tickets_chd == tickets)
    10cc:	83 c4 10             	add    $0x10,%esp
    10cf:	85 ff                	test   %edi,%edi
    10d1:	75 17                	jne    10ea <main+0xea>
		 printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    10d3:	83 ec 08             	sub    $0x8,%esp
    10d6:	68 de 16 00 00       	push   $0x16de
    10db:	6a 01                	push   $0x1
    10dd:	e8 20 03 00 00       	call   1402 <printf>
    10e2:	83 c4 10             	add    $0x10,%esp
    exit();
    10e5:	e8 b3 01 00 00       	call   129d <exit>
		 printf(1, "XV6_SCHEDULER\t FAILED\n");
    10ea:	83 ec 08             	sub    $0x8,%esp
    10ed:	68 b0 16 00 00       	push   $0x16b0
    10f2:	6a 01                	push   $0x1
    10f4:	e8 09 03 00 00       	call   1402 <printf>
    10f9:	83 c4 10             	add    $0x10,%esp
    10fc:	eb e7                	jmp    10e5 <main+0xe5>

000010fe <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    10fe:	55                   	push   %ebp
    10ff:	89 e5                	mov    %esp,%ebp
    1101:	56                   	push   %esi
    1102:	53                   	push   %ebx
    1103:	8b 75 08             	mov    0x8(%ebp),%esi
    1106:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1109:	89 f0                	mov    %esi,%eax
    110b:	89 d1                	mov    %edx,%ecx
    110d:	83 c2 01             	add    $0x1,%edx
    1110:	89 c3                	mov    %eax,%ebx
    1112:	83 c0 01             	add    $0x1,%eax
    1115:	0f b6 09             	movzbl (%ecx),%ecx
    1118:	88 0b                	mov    %cl,(%ebx)
    111a:	84 c9                	test   %cl,%cl
    111c:	75 ed                	jne    110b <strcpy+0xd>
    ;
  return os;
}
    111e:	89 f0                	mov    %esi,%eax
    1120:	5b                   	pop    %ebx
    1121:	5e                   	pop    %esi
    1122:	5d                   	pop    %ebp
    1123:	c3                   	ret    

00001124 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1124:	55                   	push   %ebp
    1125:	89 e5                	mov    %esp,%ebp
    1127:	8b 4d 08             	mov    0x8(%ebp),%ecx
    112a:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    112d:	eb 06                	jmp    1135 <strcmp+0x11>
    p++, q++;
    112f:	83 c1 01             	add    $0x1,%ecx
    1132:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1135:	0f b6 01             	movzbl (%ecx),%eax
    1138:	84 c0                	test   %al,%al
    113a:	74 04                	je     1140 <strcmp+0x1c>
    113c:	3a 02                	cmp    (%edx),%al
    113e:	74 ef                	je     112f <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1140:	0f b6 c0             	movzbl %al,%eax
    1143:	0f b6 12             	movzbl (%edx),%edx
    1146:	29 d0                	sub    %edx,%eax
}
    1148:	5d                   	pop    %ebp
    1149:	c3                   	ret    

0000114a <strlen>:

uint
strlen(const char *s)
{
    114a:	55                   	push   %ebp
    114b:	89 e5                	mov    %esp,%ebp
    114d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1150:	b8 00 00 00 00       	mov    $0x0,%eax
    1155:	eb 03                	jmp    115a <strlen+0x10>
    1157:	83 c0 01             	add    $0x1,%eax
    115a:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    115e:	75 f7                	jne    1157 <strlen+0xd>
    ;
  return n;
}
    1160:	5d                   	pop    %ebp
    1161:	c3                   	ret    

00001162 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1162:	55                   	push   %ebp
    1163:	89 e5                	mov    %esp,%ebp
    1165:	57                   	push   %edi
    1166:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1169:	89 d7                	mov    %edx,%edi
    116b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    116e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1171:	fc                   	cld    
    1172:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1174:	89 d0                	mov    %edx,%eax
    1176:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1179:	c9                   	leave  
    117a:	c3                   	ret    

0000117b <strchr>:

char*
strchr(const char *s, char c)
{
    117b:	55                   	push   %ebp
    117c:	89 e5                	mov    %esp,%ebp
    117e:	8b 45 08             	mov    0x8(%ebp),%eax
    1181:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1185:	eb 03                	jmp    118a <strchr+0xf>
    1187:	83 c0 01             	add    $0x1,%eax
    118a:	0f b6 10             	movzbl (%eax),%edx
    118d:	84 d2                	test   %dl,%dl
    118f:	74 06                	je     1197 <strchr+0x1c>
    if(*s == c)
    1191:	38 ca                	cmp    %cl,%dl
    1193:	75 f2                	jne    1187 <strchr+0xc>
    1195:	eb 05                	jmp    119c <strchr+0x21>
      return (char*)s;
  return 0;
    1197:	b8 00 00 00 00       	mov    $0x0,%eax
}
    119c:	5d                   	pop    %ebp
    119d:	c3                   	ret    

0000119e <gets>:

char*
gets(char *buf, int max)
{
    119e:	55                   	push   %ebp
    119f:	89 e5                	mov    %esp,%ebp
    11a1:	57                   	push   %edi
    11a2:	56                   	push   %esi
    11a3:	53                   	push   %ebx
    11a4:	83 ec 1c             	sub    $0x1c,%esp
    11a7:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11aa:	bb 00 00 00 00       	mov    $0x0,%ebx
    11af:	89 de                	mov    %ebx,%esi
    11b1:	83 c3 01             	add    $0x1,%ebx
    11b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11b7:	7d 2e                	jge    11e7 <gets+0x49>
    cc = read(0, &c, 1);
    11b9:	83 ec 04             	sub    $0x4,%esp
    11bc:	6a 01                	push   $0x1
    11be:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11c1:	50                   	push   %eax
    11c2:	6a 00                	push   $0x0
    11c4:	e8 ec 00 00 00       	call   12b5 <read>
    if(cc < 1)
    11c9:	83 c4 10             	add    $0x10,%esp
    11cc:	85 c0                	test   %eax,%eax
    11ce:	7e 17                	jle    11e7 <gets+0x49>
      break;
    buf[i++] = c;
    11d0:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11d4:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    11d7:	3c 0a                	cmp    $0xa,%al
    11d9:	0f 94 c2             	sete   %dl
    11dc:	3c 0d                	cmp    $0xd,%al
    11de:	0f 94 c0             	sete   %al
    11e1:	08 c2                	or     %al,%dl
    11e3:	74 ca                	je     11af <gets+0x11>
    buf[i++] = c;
    11e5:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    11e7:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    11eb:	89 f8                	mov    %edi,%eax
    11ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11f0:	5b                   	pop    %ebx
    11f1:	5e                   	pop    %esi
    11f2:	5f                   	pop    %edi
    11f3:	5d                   	pop    %ebp
    11f4:	c3                   	ret    

000011f5 <stat>:

int
stat(const char *n, struct stat *st)
{
    11f5:	55                   	push   %ebp
    11f6:	89 e5                	mov    %esp,%ebp
    11f8:	56                   	push   %esi
    11f9:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11fa:	83 ec 08             	sub    $0x8,%esp
    11fd:	6a 00                	push   $0x0
    11ff:	ff 75 08             	push   0x8(%ebp)
    1202:	e8 d6 00 00 00       	call   12dd <open>
  if(fd < 0)
    1207:	83 c4 10             	add    $0x10,%esp
    120a:	85 c0                	test   %eax,%eax
    120c:	78 24                	js     1232 <stat+0x3d>
    120e:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1210:	83 ec 08             	sub    $0x8,%esp
    1213:	ff 75 0c             	push   0xc(%ebp)
    1216:	50                   	push   %eax
    1217:	e8 d9 00 00 00       	call   12f5 <fstat>
    121c:	89 c6                	mov    %eax,%esi
  close(fd);
    121e:	89 1c 24             	mov    %ebx,(%esp)
    1221:	e8 9f 00 00 00       	call   12c5 <close>
  return r;
    1226:	83 c4 10             	add    $0x10,%esp
}
    1229:	89 f0                	mov    %esi,%eax
    122b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    122e:	5b                   	pop    %ebx
    122f:	5e                   	pop    %esi
    1230:	5d                   	pop    %ebp
    1231:	c3                   	ret    
    return -1;
    1232:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1237:	eb f0                	jmp    1229 <stat+0x34>

00001239 <atoi>:

int
atoi(const char *s)
{
    1239:	55                   	push   %ebp
    123a:	89 e5                	mov    %esp,%ebp
    123c:	53                   	push   %ebx
    123d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1240:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1245:	eb 10                	jmp    1257 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1247:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    124a:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    124d:	83 c1 01             	add    $0x1,%ecx
    1250:	0f be c0             	movsbl %al,%eax
    1253:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1257:	0f b6 01             	movzbl (%ecx),%eax
    125a:	8d 58 d0             	lea    -0x30(%eax),%ebx
    125d:	80 fb 09             	cmp    $0x9,%bl
    1260:	76 e5                	jbe    1247 <atoi+0xe>
  return n;
}
    1262:	89 d0                	mov    %edx,%eax
    1264:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1267:	c9                   	leave  
    1268:	c3                   	ret    

00001269 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1269:	55                   	push   %ebp
    126a:	89 e5                	mov    %esp,%ebp
    126c:	56                   	push   %esi
    126d:	53                   	push   %ebx
    126e:	8b 75 08             	mov    0x8(%ebp),%esi
    1271:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1274:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1277:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1279:	eb 0d                	jmp    1288 <memmove+0x1f>
    *dst++ = *src++;
    127b:	0f b6 01             	movzbl (%ecx),%eax
    127e:	88 02                	mov    %al,(%edx)
    1280:	8d 49 01             	lea    0x1(%ecx),%ecx
    1283:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1286:	89 d8                	mov    %ebx,%eax
    1288:	8d 58 ff             	lea    -0x1(%eax),%ebx
    128b:	85 c0                	test   %eax,%eax
    128d:	7f ec                	jg     127b <memmove+0x12>
  return vdst;
}
    128f:	89 f0                	mov    %esi,%eax
    1291:	5b                   	pop    %ebx
    1292:	5e                   	pop    %esi
    1293:	5d                   	pop    %ebp
    1294:	c3                   	ret    

00001295 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1295:	b8 01 00 00 00       	mov    $0x1,%eax
    129a:	cd 40                	int    $0x40
    129c:	c3                   	ret    

0000129d <exit>:
SYSCALL(exit)
    129d:	b8 02 00 00 00       	mov    $0x2,%eax
    12a2:	cd 40                	int    $0x40
    12a4:	c3                   	ret    

000012a5 <wait>:
SYSCALL(wait)
    12a5:	b8 03 00 00 00       	mov    $0x3,%eax
    12aa:	cd 40                	int    $0x40
    12ac:	c3                   	ret    

000012ad <pipe>:
SYSCALL(pipe)
    12ad:	b8 04 00 00 00       	mov    $0x4,%eax
    12b2:	cd 40                	int    $0x40
    12b4:	c3                   	ret    

000012b5 <read>:
SYSCALL(read)
    12b5:	b8 05 00 00 00       	mov    $0x5,%eax
    12ba:	cd 40                	int    $0x40
    12bc:	c3                   	ret    

000012bd <write>:
SYSCALL(write)
    12bd:	b8 10 00 00 00       	mov    $0x10,%eax
    12c2:	cd 40                	int    $0x40
    12c4:	c3                   	ret    

000012c5 <close>:
SYSCALL(close)
    12c5:	b8 15 00 00 00       	mov    $0x15,%eax
    12ca:	cd 40                	int    $0x40
    12cc:	c3                   	ret    

000012cd <kill>:
SYSCALL(kill)
    12cd:	b8 06 00 00 00       	mov    $0x6,%eax
    12d2:	cd 40                	int    $0x40
    12d4:	c3                   	ret    

000012d5 <exec>:
SYSCALL(exec)
    12d5:	b8 07 00 00 00       	mov    $0x7,%eax
    12da:	cd 40                	int    $0x40
    12dc:	c3                   	ret    

000012dd <open>:
SYSCALL(open)
    12dd:	b8 0f 00 00 00       	mov    $0xf,%eax
    12e2:	cd 40                	int    $0x40
    12e4:	c3                   	ret    

000012e5 <mknod>:
SYSCALL(mknod)
    12e5:	b8 11 00 00 00       	mov    $0x11,%eax
    12ea:	cd 40                	int    $0x40
    12ec:	c3                   	ret    

000012ed <unlink>:
SYSCALL(unlink)
    12ed:	b8 12 00 00 00       	mov    $0x12,%eax
    12f2:	cd 40                	int    $0x40
    12f4:	c3                   	ret    

000012f5 <fstat>:
SYSCALL(fstat)
    12f5:	b8 08 00 00 00       	mov    $0x8,%eax
    12fa:	cd 40                	int    $0x40
    12fc:	c3                   	ret    

000012fd <link>:
SYSCALL(link)
    12fd:	b8 13 00 00 00       	mov    $0x13,%eax
    1302:	cd 40                	int    $0x40
    1304:	c3                   	ret    

00001305 <mkdir>:
SYSCALL(mkdir)
    1305:	b8 14 00 00 00       	mov    $0x14,%eax
    130a:	cd 40                	int    $0x40
    130c:	c3                   	ret    

0000130d <chdir>:
SYSCALL(chdir)
    130d:	b8 09 00 00 00       	mov    $0x9,%eax
    1312:	cd 40                	int    $0x40
    1314:	c3                   	ret    

00001315 <dup>:
SYSCALL(dup)
    1315:	b8 0a 00 00 00       	mov    $0xa,%eax
    131a:	cd 40                	int    $0x40
    131c:	c3                   	ret    

0000131d <getpid>:
SYSCALL(getpid)
    131d:	b8 0b 00 00 00       	mov    $0xb,%eax
    1322:	cd 40                	int    $0x40
    1324:	c3                   	ret    

00001325 <sbrk>:
SYSCALL(sbrk)
    1325:	b8 0c 00 00 00       	mov    $0xc,%eax
    132a:	cd 40                	int    $0x40
    132c:	c3                   	ret    

0000132d <sleep>:
SYSCALL(sleep)
    132d:	b8 0d 00 00 00       	mov    $0xd,%eax
    1332:	cd 40                	int    $0x40
    1334:	c3                   	ret    

00001335 <uptime>:
SYSCALL(uptime)
    1335:	b8 0e 00 00 00       	mov    $0xe,%eax
    133a:	cd 40                	int    $0x40
    133c:	c3                   	ret    

0000133d <settickets>:
SYSCALL(settickets)
    133d:	b8 16 00 00 00       	mov    $0x16,%eax
    1342:	cd 40                	int    $0x40
    1344:	c3                   	ret    

00001345 <getpinfo>:
SYSCALL(getpinfo)
    1345:	b8 17 00 00 00       	mov    $0x17,%eax
    134a:	cd 40                	int    $0x40
    134c:	c3                   	ret    

0000134d <mprotect>:
SYSCALL(mprotect)
    134d:	b8 18 00 00 00       	mov    $0x18,%eax
    1352:	cd 40                	int    $0x40
    1354:	c3                   	ret    

00001355 <munprotect>:
    1355:	b8 19 00 00 00       	mov    $0x19,%eax
    135a:	cd 40                	int    $0x40
    135c:	c3                   	ret    

0000135d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    135d:	55                   	push   %ebp
    135e:	89 e5                	mov    %esp,%ebp
    1360:	83 ec 1c             	sub    $0x1c,%esp
    1363:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1366:	6a 01                	push   $0x1
    1368:	8d 55 f4             	lea    -0xc(%ebp),%edx
    136b:	52                   	push   %edx
    136c:	50                   	push   %eax
    136d:	e8 4b ff ff ff       	call   12bd <write>
}
    1372:	83 c4 10             	add    $0x10,%esp
    1375:	c9                   	leave  
    1376:	c3                   	ret    

00001377 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1377:	55                   	push   %ebp
    1378:	89 e5                	mov    %esp,%ebp
    137a:	57                   	push   %edi
    137b:	56                   	push   %esi
    137c:	53                   	push   %ebx
    137d:	83 ec 2c             	sub    $0x2c,%esp
    1380:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1383:	89 d0                	mov    %edx,%eax
    1385:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1387:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    138b:	0f 95 c1             	setne  %cl
    138e:	c1 ea 1f             	shr    $0x1f,%edx
    1391:	84 d1                	test   %dl,%cl
    1393:	74 44                	je     13d9 <printint+0x62>
    neg = 1;
    x = -xx;
    1395:	f7 d8                	neg    %eax
    1397:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1399:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    13a0:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    13a5:	89 c8                	mov    %ecx,%eax
    13a7:	ba 00 00 00 00       	mov    $0x0,%edx
    13ac:	f7 f6                	div    %esi
    13ae:	89 df                	mov    %ebx,%edi
    13b0:	83 c3 01             	add    $0x1,%ebx
    13b3:	0f b6 92 58 17 00 00 	movzbl 0x1758(%edx),%edx
    13ba:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    13be:	89 ca                	mov    %ecx,%edx
    13c0:	89 c1                	mov    %eax,%ecx
    13c2:	39 d6                	cmp    %edx,%esi
    13c4:	76 df                	jbe    13a5 <printint+0x2e>
  if(neg)
    13c6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    13ca:	74 31                	je     13fd <printint+0x86>
    buf[i++] = '-';
    13cc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    13d1:	8d 5f 02             	lea    0x2(%edi),%ebx
    13d4:	8b 75 d0             	mov    -0x30(%ebp),%esi
    13d7:	eb 17                	jmp    13f0 <printint+0x79>
    x = xx;
    13d9:	89 c1                	mov    %eax,%ecx
  neg = 0;
    13db:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    13e2:	eb bc                	jmp    13a0 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    13e4:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    13e9:	89 f0                	mov    %esi,%eax
    13eb:	e8 6d ff ff ff       	call   135d <putc>
  while(--i >= 0)
    13f0:	83 eb 01             	sub    $0x1,%ebx
    13f3:	79 ef                	jns    13e4 <printint+0x6d>
}
    13f5:	83 c4 2c             	add    $0x2c,%esp
    13f8:	5b                   	pop    %ebx
    13f9:	5e                   	pop    %esi
    13fa:	5f                   	pop    %edi
    13fb:	5d                   	pop    %ebp
    13fc:	c3                   	ret    
    13fd:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1400:	eb ee                	jmp    13f0 <printint+0x79>

00001402 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1402:	55                   	push   %ebp
    1403:	89 e5                	mov    %esp,%ebp
    1405:	57                   	push   %edi
    1406:	56                   	push   %esi
    1407:	53                   	push   %ebx
    1408:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    140b:	8d 45 10             	lea    0x10(%ebp),%eax
    140e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1411:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1416:	bb 00 00 00 00       	mov    $0x0,%ebx
    141b:	eb 14                	jmp    1431 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    141d:	89 fa                	mov    %edi,%edx
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
    1422:	e8 36 ff ff ff       	call   135d <putc>
    1427:	eb 05                	jmp    142e <printf+0x2c>
      }
    } else if(state == '%'){
    1429:	83 fe 25             	cmp    $0x25,%esi
    142c:	74 25                	je     1453 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    142e:	83 c3 01             	add    $0x1,%ebx
    1431:	8b 45 0c             	mov    0xc(%ebp),%eax
    1434:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1438:	84 c0                	test   %al,%al
    143a:	0f 84 20 01 00 00    	je     1560 <printf+0x15e>
    c = fmt[i] & 0xff;
    1440:	0f be f8             	movsbl %al,%edi
    1443:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1446:	85 f6                	test   %esi,%esi
    1448:	75 df                	jne    1429 <printf+0x27>
      if(c == '%'){
    144a:	83 f8 25             	cmp    $0x25,%eax
    144d:	75 ce                	jne    141d <printf+0x1b>
        state = '%';
    144f:	89 c6                	mov    %eax,%esi
    1451:	eb db                	jmp    142e <printf+0x2c>
      if(c == 'd'){
    1453:	83 f8 25             	cmp    $0x25,%eax
    1456:	0f 84 cf 00 00 00    	je     152b <printf+0x129>
    145c:	0f 8c dd 00 00 00    	jl     153f <printf+0x13d>
    1462:	83 f8 78             	cmp    $0x78,%eax
    1465:	0f 8f d4 00 00 00    	jg     153f <printf+0x13d>
    146b:	83 f8 63             	cmp    $0x63,%eax
    146e:	0f 8c cb 00 00 00    	jl     153f <printf+0x13d>
    1474:	83 e8 63             	sub    $0x63,%eax
    1477:	83 f8 15             	cmp    $0x15,%eax
    147a:	0f 87 bf 00 00 00    	ja     153f <printf+0x13d>
    1480:	ff 24 85 00 17 00 00 	jmp    *0x1700(,%eax,4)
        printint(fd, *ap, 10, 1);
    1487:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    148a:	8b 17                	mov    (%edi),%edx
    148c:	83 ec 0c             	sub    $0xc,%esp
    148f:	6a 01                	push   $0x1
    1491:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1496:	8b 45 08             	mov    0x8(%ebp),%eax
    1499:	e8 d9 fe ff ff       	call   1377 <printint>
        ap++;
    149e:	83 c7 04             	add    $0x4,%edi
    14a1:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    14a4:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14a7:	be 00 00 00 00       	mov    $0x0,%esi
    14ac:	eb 80                	jmp    142e <printf+0x2c>
        printint(fd, *ap, 16, 0);
    14ae:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14b1:	8b 17                	mov    (%edi),%edx
    14b3:	83 ec 0c             	sub    $0xc,%esp
    14b6:	6a 00                	push   $0x0
    14b8:	b9 10 00 00 00       	mov    $0x10,%ecx
    14bd:	8b 45 08             	mov    0x8(%ebp),%eax
    14c0:	e8 b2 fe ff ff       	call   1377 <printint>
        ap++;
    14c5:	83 c7 04             	add    $0x4,%edi
    14c8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    14cb:	83 c4 10             	add    $0x10,%esp
      state = 0;
    14ce:	be 00 00 00 00       	mov    $0x0,%esi
    14d3:	e9 56 ff ff ff       	jmp    142e <printf+0x2c>
        s = (char*)*ap;
    14d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14db:	8b 30                	mov    (%eax),%esi
        ap++;
    14dd:	83 c0 04             	add    $0x4,%eax
    14e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    14e3:	85 f6                	test   %esi,%esi
    14e5:	75 15                	jne    14fc <printf+0xfa>
          s = "(null)";
    14e7:	be f6 16 00 00       	mov    $0x16f6,%esi
    14ec:	eb 0e                	jmp    14fc <printf+0xfa>
          putc(fd, *s);
    14ee:	0f be d2             	movsbl %dl,%edx
    14f1:	8b 45 08             	mov    0x8(%ebp),%eax
    14f4:	e8 64 fe ff ff       	call   135d <putc>
          s++;
    14f9:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    14fc:	0f b6 16             	movzbl (%esi),%edx
    14ff:	84 d2                	test   %dl,%dl
    1501:	75 eb                	jne    14ee <printf+0xec>
      state = 0;
    1503:	be 00 00 00 00       	mov    $0x0,%esi
    1508:	e9 21 ff ff ff       	jmp    142e <printf+0x2c>
        putc(fd, *ap);
    150d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1510:	0f be 17             	movsbl (%edi),%edx
    1513:	8b 45 08             	mov    0x8(%ebp),%eax
    1516:	e8 42 fe ff ff       	call   135d <putc>
        ap++;
    151b:	83 c7 04             	add    $0x4,%edi
    151e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1521:	be 00 00 00 00       	mov    $0x0,%esi
    1526:	e9 03 ff ff ff       	jmp    142e <printf+0x2c>
        putc(fd, c);
    152b:	89 fa                	mov    %edi,%edx
    152d:	8b 45 08             	mov    0x8(%ebp),%eax
    1530:	e8 28 fe ff ff       	call   135d <putc>
      state = 0;
    1535:	be 00 00 00 00       	mov    $0x0,%esi
    153a:	e9 ef fe ff ff       	jmp    142e <printf+0x2c>
        putc(fd, '%');
    153f:	ba 25 00 00 00       	mov    $0x25,%edx
    1544:	8b 45 08             	mov    0x8(%ebp),%eax
    1547:	e8 11 fe ff ff       	call   135d <putc>
        putc(fd, c);
    154c:	89 fa                	mov    %edi,%edx
    154e:	8b 45 08             	mov    0x8(%ebp),%eax
    1551:	e8 07 fe ff ff       	call   135d <putc>
      state = 0;
    1556:	be 00 00 00 00       	mov    $0x0,%esi
    155b:	e9 ce fe ff ff       	jmp    142e <printf+0x2c>
    }
  }
}
    1560:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1563:	5b                   	pop    %ebx
    1564:	5e                   	pop    %esi
    1565:	5f                   	pop    %edi
    1566:	5d                   	pop    %ebp
    1567:	c3                   	ret    

00001568 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1568:	55                   	push   %ebp
    1569:	89 e5                	mov    %esp,%ebp
    156b:	57                   	push   %edi
    156c:	56                   	push   %esi
    156d:	53                   	push   %ebx
    156e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1571:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1574:	a1 04 1a 00 00       	mov    0x1a04,%eax
    1579:	eb 02                	jmp    157d <free+0x15>
    157b:	89 d0                	mov    %edx,%eax
    157d:	39 c8                	cmp    %ecx,%eax
    157f:	73 04                	jae    1585 <free+0x1d>
    1581:	39 08                	cmp    %ecx,(%eax)
    1583:	77 12                	ja     1597 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1585:	8b 10                	mov    (%eax),%edx
    1587:	39 c2                	cmp    %eax,%edx
    1589:	77 f0                	ja     157b <free+0x13>
    158b:	39 c8                	cmp    %ecx,%eax
    158d:	72 08                	jb     1597 <free+0x2f>
    158f:	39 ca                	cmp    %ecx,%edx
    1591:	77 04                	ja     1597 <free+0x2f>
    1593:	89 d0                	mov    %edx,%eax
    1595:	eb e6                	jmp    157d <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1597:	8b 73 fc             	mov    -0x4(%ebx),%esi
    159a:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    159d:	8b 10                	mov    (%eax),%edx
    159f:	39 d7                	cmp    %edx,%edi
    15a1:	74 19                	je     15bc <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    15a3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15a6:	8b 50 04             	mov    0x4(%eax),%edx
    15a9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15ac:	39 ce                	cmp    %ecx,%esi
    15ae:	74 1b                	je     15cb <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    15b0:	89 08                	mov    %ecx,(%eax)
  freep = p;
    15b2:	a3 04 1a 00 00       	mov    %eax,0x1a04
}
    15b7:	5b                   	pop    %ebx
    15b8:	5e                   	pop    %esi
    15b9:	5f                   	pop    %edi
    15ba:	5d                   	pop    %ebp
    15bb:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    15bc:	03 72 04             	add    0x4(%edx),%esi
    15bf:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    15c2:	8b 10                	mov    (%eax),%edx
    15c4:	8b 12                	mov    (%edx),%edx
    15c6:	89 53 f8             	mov    %edx,-0x8(%ebx)
    15c9:	eb db                	jmp    15a6 <free+0x3e>
    p->s.size += bp->s.size;
    15cb:	03 53 fc             	add    -0x4(%ebx),%edx
    15ce:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15d1:	8b 53 f8             	mov    -0x8(%ebx),%edx
    15d4:	89 10                	mov    %edx,(%eax)
    15d6:	eb da                	jmp    15b2 <free+0x4a>

000015d8 <morecore>:

static Header*
morecore(uint nu)
{
    15d8:	55                   	push   %ebp
    15d9:	89 e5                	mov    %esp,%ebp
    15db:	53                   	push   %ebx
    15dc:	83 ec 04             	sub    $0x4,%esp
    15df:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    15e1:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    15e6:	77 05                	ja     15ed <morecore+0x15>
    nu = 4096;
    15e8:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    15ed:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    15f4:	83 ec 0c             	sub    $0xc,%esp
    15f7:	50                   	push   %eax
    15f8:	e8 28 fd ff ff       	call   1325 <sbrk>
  if(p == (char*)-1)
    15fd:	83 c4 10             	add    $0x10,%esp
    1600:	83 f8 ff             	cmp    $0xffffffff,%eax
    1603:	74 1c                	je     1621 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1605:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1608:	83 c0 08             	add    $0x8,%eax
    160b:	83 ec 0c             	sub    $0xc,%esp
    160e:	50                   	push   %eax
    160f:	e8 54 ff ff ff       	call   1568 <free>
  return freep;
    1614:	a1 04 1a 00 00       	mov    0x1a04,%eax
    1619:	83 c4 10             	add    $0x10,%esp
}
    161c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    161f:	c9                   	leave  
    1620:	c3                   	ret    
    return 0;
    1621:	b8 00 00 00 00       	mov    $0x0,%eax
    1626:	eb f4                	jmp    161c <morecore+0x44>

00001628 <malloc>:

void*
malloc(uint nbytes)
{
    1628:	55                   	push   %ebp
    1629:	89 e5                	mov    %esp,%ebp
    162b:	53                   	push   %ebx
    162c:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    162f:	8b 45 08             	mov    0x8(%ebp),%eax
    1632:	8d 58 07             	lea    0x7(%eax),%ebx
    1635:	c1 eb 03             	shr    $0x3,%ebx
    1638:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    163b:	8b 0d 04 1a 00 00    	mov    0x1a04,%ecx
    1641:	85 c9                	test   %ecx,%ecx
    1643:	74 04                	je     1649 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1645:	8b 01                	mov    (%ecx),%eax
    1647:	eb 4a                	jmp    1693 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1649:	c7 05 04 1a 00 00 08 	movl   $0x1a08,0x1a04
    1650:	1a 00 00 
    1653:	c7 05 08 1a 00 00 08 	movl   $0x1a08,0x1a08
    165a:	1a 00 00 
    base.s.size = 0;
    165d:	c7 05 0c 1a 00 00 00 	movl   $0x0,0x1a0c
    1664:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1667:	b9 08 1a 00 00       	mov    $0x1a08,%ecx
    166c:	eb d7                	jmp    1645 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    166e:	74 19                	je     1689 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1670:	29 da                	sub    %ebx,%edx
    1672:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1675:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1678:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    167b:	89 0d 04 1a 00 00    	mov    %ecx,0x1a04
      return (void*)(p + 1);
    1681:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1684:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1687:	c9                   	leave  
    1688:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1689:	8b 10                	mov    (%eax),%edx
    168b:	89 11                	mov    %edx,(%ecx)
    168d:	eb ec                	jmp    167b <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    168f:	89 c1                	mov    %eax,%ecx
    1691:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1693:	8b 50 04             	mov    0x4(%eax),%edx
    1696:	39 da                	cmp    %ebx,%edx
    1698:	73 d4                	jae    166e <malloc+0x46>
    if(p == freep)
    169a:	39 05 04 1a 00 00    	cmp    %eax,0x1a04
    16a0:	75 ed                	jne    168f <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    16a2:	89 d8                	mov    %ebx,%eax
    16a4:	e8 2f ff ff ff       	call   15d8 <morecore>
    16a9:	85 c0                	test   %eax,%eax
    16ab:	75 e2                	jne    168f <malloc+0x67>
    16ad:	eb d5                	jmp    1684 <malloc+0x5c>
