
_test_10:     file format elf32-i386


Disassembly of section .text:

00001000 <spin>:
void spin()
{
	int i = 0;
  int j = 0;
  int k = 0;
	for(i = 0; i < 50; ++i)
    1000:	ba 00 00 00 00       	mov    $0x0,%edx
    1005:	eb 0d                	jmp    1014 <spin+0x14>
	{
		for(j = 0; j < 10000000; ++j)
    1007:	83 c0 01             	add    $0x1,%eax
    100a:	3d 7f 96 98 00       	cmp    $0x98967f,%eax
    100f:	7e f6                	jle    1007 <spin+0x7>
	for(i = 0; i < 50; ++i)
    1011:	83 c2 01             	add    $0x1,%edx
    1014:	83 fa 31             	cmp    $0x31,%edx
    1017:	7f 07                	jg     1020 <spin+0x20>
		for(j = 0; j < 10000000; ++j)
    1019:	b8 00 00 00 00       	mov    $0x0,%eax
    101e:	eb ea                	jmp    100a <spin+0xa>
		{
      k = j % 10;
      k = k + 1;
    }
	}
}
    1020:	c3                   	ret    

00001021 <main>:


int
main(int argc, char *argv[])
{
    1021:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1025:	83 e4 f0             	and    $0xfffffff0,%esp
    1028:	ff 71 fc             	push   -0x4(%ecx)
    102b:	55                   	push   %ebp
    102c:	89 e5                	mov    %esp,%ebp
    102e:	57                   	push   %edi
    102f:	56                   	push   %esi
    1030:	53                   	push   %ebx
    1031:	51                   	push   %ecx
    1032:	81 ec 10 05 00 00    	sub    $0x510,%esp
   struct pstat st;
   int count = 0;
   int i = 0;
   int pid[NPROC];
   printf(1,"Spinning...\n");
    1038:	68 10 17 00 00       	push   $0x1710
    103d:	6a 01                	push   $0x1
    103f:	e8 1f 04 00 00       	call   1463 <printf>
   while(i < PROC)
    1044:	83 c4 10             	add    $0x10,%esp
   int i = 0;
    1047:	bb 00 00 00 00       	mov    $0x0,%ebx
   while(i < PROC)
    104c:	83 fb 04             	cmp    $0x4,%ebx
    104f:	7f 1a                	jg     106b <main+0x4a>
   {
      pid[i] = fork();
    1051:	e8 a0 02 00 00       	call   12f6 <fork>
    1056:	89 84 9d e8 fa ff ff 	mov    %eax,-0x518(%ebp,%ebx,4)
	    if(pid[i] == 0)
    105d:	85 c0                	test   %eax,%eax
    105f:	74 05                	je     1066 <main+0x45>
     {
		    spin();
		    exit();
      }
	  i++;
    1061:	83 c3 01             	add    $0x1,%ebx
    1064:	eb e6                	jmp    104c <main+0x2b>
		    exit();
    1066:	e8 93 02 00 00       	call   12fe <exit>
   }
   sleep(500);
    106b:	83 ec 0c             	sub    $0xc,%esp
    106e:	68 f4 01 00 00       	push   $0x1f4
    1073:	e8 16 03 00 00       	call   138e <sleep>
   //spin();
   if(getpinfo(&st) == 0)
    1078:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    107e:	89 04 24             	mov    %eax,(%esp)
    1081:	e8 20 03 00 00       	call   13a6 <getpinfo>
    1086:	89 c7                	mov    %eax,%edi
    1088:	83 c4 10             	add    $0x10,%esp
    108b:	85 c0                	test   %eax,%eax
    108d:	74 14                	je     10a3 <main+0x82>
   {
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    108f:	83 ec 08             	sub    $0x8,%esp
    1092:	68 1d 17 00 00       	push   $0x171d
    1097:	6a 01                	push   $0x1
    1099:	e8 c5 03 00 00       	call   1463 <printf>
    exit();
    109e:	e8 5b 02 00 00       	call   12fe <exit>
   }

   printf(1, "\n**** PInfo ****\n");
    10a3:	83 ec 08             	sub    $0x8,%esp
    10a6:	68 34 17 00 00       	push   $0x1734
    10ab:	6a 01                	push   $0x1
    10ad:	e8 b1 03 00 00       	call   1463 <printf>
   for(i = 0; i < NPROC; i++) {
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	89 fb                	mov    %edi,%ebx
   int count = 0;
    10b7:	89 fe                	mov    %edi,%esi
   for(i = 0; i < NPROC; i++) {
    10b9:	eb 03                	jmp    10be <main+0x9d>
    10bb:	83 c3 01             	add    $0x1,%ebx
    10be:	83 fb 3f             	cmp    $0x3f,%ebx
    10c1:	7f 4b                	jg     110e <main+0xed>
      if (st.inuse[i]) {
    10c3:	83 bc 9d e8 fb ff ff 	cmpl   $0x0,-0x418(%ebp,%ebx,4)
    10ca:	00 
    10cb:	74 ee                	je     10bb <main+0x9a>
	       count++;
    10cd:	83 c6 01             	add    $0x1,%esi
         printf(1, "pid: %d tickets: %d ticks: %d\n", st.pid[i], st.tickets[i], st.ticks[i]);
    10d0:	83 ec 0c             	sub    $0xc,%esp
    10d3:	ff b4 9d e8 fe ff ff 	push   -0x118(%ebp,%ebx,4)
    10da:	ff b4 9d e8 fc ff ff 	push   -0x318(%ebp,%ebx,4)
    10e1:	ff b4 9d e8 fd ff ff 	push   -0x218(%ebp,%ebx,4)
    10e8:	68 60 17 00 00       	push   $0x1760
    10ed:	6a 01                	push   $0x1
    10ef:	e8 6f 03 00 00       	call   1463 <printf>
    10f4:	83 c4 20             	add    $0x20,%esp
    10f7:	eb c2                	jmp    10bb <main+0x9a>
      }
   }
   for(i = 0; i < PROC; i++)
   {
	    kill(pid[i]);
    10f9:	83 ec 0c             	sub    $0xc,%esp
    10fc:	ff b4 bd e8 fa ff ff 	push   -0x518(%ebp,%edi,4)
    1103:	e8 26 02 00 00       	call   132e <kill>
   for(i = 0; i < PROC; i++)
    1108:	83 c7 01             	add    $0x1,%edi
    110b:	83 c4 10             	add    $0x10,%esp
    110e:	83 ff 04             	cmp    $0x4,%edi
    1111:	7e e6                	jle    10f9 <main+0xd8>
   }
   while (wait() > 0);
    1113:	e8 ee 01 00 00       	call   1306 <wait>
    1118:	85 c0                	test   %eax,%eax
    111a:	7f f7                	jg     1113 <main+0xf2>
   printf(1,"Number of processes in use %d\n", count);
    111c:	83 ec 04             	sub    $0x4,%esp
    111f:	56                   	push   %esi
    1120:	68 80 17 00 00       	push   $0x1780
    1125:	6a 01                	push   $0x1
    1127:	e8 37 03 00 00       	call   1463 <printf>
   
   if(count == 8)
    112c:	83 c4 10             	add    $0x10,%esp
    112f:	83 fe 08             	cmp    $0x8,%esi
    1132:	74 17                	je     114b <main+0x12a>
   {
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
   }
   else
   {
    printf(1, "XV6_SCHEDULER\t FAILED\n");
    1134:	83 ec 08             	sub    $0x8,%esp
    1137:	68 1d 17 00 00       	push   $0x171d
    113c:	6a 01                	push   $0x1
    113e:	e8 20 03 00 00       	call   1463 <printf>
    1143:	83 c4 10             	add    $0x10,%esp
   }
    
   exit();
    1146:	e8 b3 01 00 00       	call   12fe <exit>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
    114b:	83 ec 08             	sub    $0x8,%esp
    114e:	68 46 17 00 00       	push   $0x1746
    1153:	6a 01                	push   $0x1
    1155:	e8 09 03 00 00       	call   1463 <printf>
    115a:	83 c4 10             	add    $0x10,%esp
    115d:	eb e7                	jmp    1146 <main+0x125>

0000115f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    115f:	55                   	push   %ebp
    1160:	89 e5                	mov    %esp,%ebp
    1162:	56                   	push   %esi
    1163:	53                   	push   %ebx
    1164:	8b 75 08             	mov    0x8(%ebp),%esi
    1167:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    116a:	89 f0                	mov    %esi,%eax
    116c:	89 d1                	mov    %edx,%ecx
    116e:	83 c2 01             	add    $0x1,%edx
    1171:	89 c3                	mov    %eax,%ebx
    1173:	83 c0 01             	add    $0x1,%eax
    1176:	0f b6 09             	movzbl (%ecx),%ecx
    1179:	88 0b                	mov    %cl,(%ebx)
    117b:	84 c9                	test   %cl,%cl
    117d:	75 ed                	jne    116c <strcpy+0xd>
    ;
  return os;
}
    117f:	89 f0                	mov    %esi,%eax
    1181:	5b                   	pop    %ebx
    1182:	5e                   	pop    %esi
    1183:	5d                   	pop    %ebp
    1184:	c3                   	ret    

00001185 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1185:	55                   	push   %ebp
    1186:	89 e5                	mov    %esp,%ebp
    1188:	8b 4d 08             	mov    0x8(%ebp),%ecx
    118b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    118e:	eb 06                	jmp    1196 <strcmp+0x11>
    p++, q++;
    1190:	83 c1 01             	add    $0x1,%ecx
    1193:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1196:	0f b6 01             	movzbl (%ecx),%eax
    1199:	84 c0                	test   %al,%al
    119b:	74 04                	je     11a1 <strcmp+0x1c>
    119d:	3a 02                	cmp    (%edx),%al
    119f:	74 ef                	je     1190 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    11a1:	0f b6 c0             	movzbl %al,%eax
    11a4:	0f b6 12             	movzbl (%edx),%edx
    11a7:	29 d0                	sub    %edx,%eax
}
    11a9:	5d                   	pop    %ebp
    11aa:	c3                   	ret    

000011ab <strlen>:

uint
strlen(const char *s)
{
    11ab:	55                   	push   %ebp
    11ac:	89 e5                	mov    %esp,%ebp
    11ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11b1:	b8 00 00 00 00       	mov    $0x0,%eax
    11b6:	eb 03                	jmp    11bb <strlen+0x10>
    11b8:	83 c0 01             	add    $0x1,%eax
    11bb:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    11bf:	75 f7                	jne    11b8 <strlen+0xd>
    ;
  return n;
}
    11c1:	5d                   	pop    %ebp
    11c2:	c3                   	ret    

000011c3 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11c3:	55                   	push   %ebp
    11c4:	89 e5                	mov    %esp,%ebp
    11c6:	57                   	push   %edi
    11c7:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11ca:	89 d7                	mov    %edx,%edi
    11cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d2:	fc                   	cld    
    11d3:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11d5:	89 d0                	mov    %edx,%eax
    11d7:	8b 7d fc             	mov    -0x4(%ebp),%edi
    11da:	c9                   	leave  
    11db:	c3                   	ret    

000011dc <strchr>:

char*
strchr(const char *s, char c)
{
    11dc:	55                   	push   %ebp
    11dd:	89 e5                	mov    %esp,%ebp
    11df:	8b 45 08             	mov    0x8(%ebp),%eax
    11e2:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11e6:	eb 03                	jmp    11eb <strchr+0xf>
    11e8:	83 c0 01             	add    $0x1,%eax
    11eb:	0f b6 10             	movzbl (%eax),%edx
    11ee:	84 d2                	test   %dl,%dl
    11f0:	74 06                	je     11f8 <strchr+0x1c>
    if(*s == c)
    11f2:	38 ca                	cmp    %cl,%dl
    11f4:	75 f2                	jne    11e8 <strchr+0xc>
    11f6:	eb 05                	jmp    11fd <strchr+0x21>
      return (char*)s;
  return 0;
    11f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11fd:	5d                   	pop    %ebp
    11fe:	c3                   	ret    

000011ff <gets>:

char*
gets(char *buf, int max)
{
    11ff:	55                   	push   %ebp
    1200:	89 e5                	mov    %esp,%ebp
    1202:	57                   	push   %edi
    1203:	56                   	push   %esi
    1204:	53                   	push   %ebx
    1205:	83 ec 1c             	sub    $0x1c,%esp
    1208:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    120b:	bb 00 00 00 00       	mov    $0x0,%ebx
    1210:	89 de                	mov    %ebx,%esi
    1212:	83 c3 01             	add    $0x1,%ebx
    1215:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1218:	7d 2e                	jge    1248 <gets+0x49>
    cc = read(0, &c, 1);
    121a:	83 ec 04             	sub    $0x4,%esp
    121d:	6a 01                	push   $0x1
    121f:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1222:	50                   	push   %eax
    1223:	6a 00                	push   $0x0
    1225:	e8 ec 00 00 00       	call   1316 <read>
    if(cc < 1)
    122a:	83 c4 10             	add    $0x10,%esp
    122d:	85 c0                	test   %eax,%eax
    122f:	7e 17                	jle    1248 <gets+0x49>
      break;
    buf[i++] = c;
    1231:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1235:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1238:	3c 0a                	cmp    $0xa,%al
    123a:	0f 94 c2             	sete   %dl
    123d:	3c 0d                	cmp    $0xd,%al
    123f:	0f 94 c0             	sete   %al
    1242:	08 c2                	or     %al,%dl
    1244:	74 ca                	je     1210 <gets+0x11>
    buf[i++] = c;
    1246:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1248:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    124c:	89 f8                	mov    %edi,%eax
    124e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1251:	5b                   	pop    %ebx
    1252:	5e                   	pop    %esi
    1253:	5f                   	pop    %edi
    1254:	5d                   	pop    %ebp
    1255:	c3                   	ret    

00001256 <stat>:

int
stat(const char *n, struct stat *st)
{
    1256:	55                   	push   %ebp
    1257:	89 e5                	mov    %esp,%ebp
    1259:	56                   	push   %esi
    125a:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    125b:	83 ec 08             	sub    $0x8,%esp
    125e:	6a 00                	push   $0x0
    1260:	ff 75 08             	push   0x8(%ebp)
    1263:	e8 d6 00 00 00       	call   133e <open>
  if(fd < 0)
    1268:	83 c4 10             	add    $0x10,%esp
    126b:	85 c0                	test   %eax,%eax
    126d:	78 24                	js     1293 <stat+0x3d>
    126f:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1271:	83 ec 08             	sub    $0x8,%esp
    1274:	ff 75 0c             	push   0xc(%ebp)
    1277:	50                   	push   %eax
    1278:	e8 d9 00 00 00       	call   1356 <fstat>
    127d:	89 c6                	mov    %eax,%esi
  close(fd);
    127f:	89 1c 24             	mov    %ebx,(%esp)
    1282:	e8 9f 00 00 00       	call   1326 <close>
  return r;
    1287:	83 c4 10             	add    $0x10,%esp
}
    128a:	89 f0                	mov    %esi,%eax
    128c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    128f:	5b                   	pop    %ebx
    1290:	5e                   	pop    %esi
    1291:	5d                   	pop    %ebp
    1292:	c3                   	ret    
    return -1;
    1293:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1298:	eb f0                	jmp    128a <stat+0x34>

0000129a <atoi>:

int
atoi(const char *s)
{
    129a:	55                   	push   %ebp
    129b:	89 e5                	mov    %esp,%ebp
    129d:	53                   	push   %ebx
    129e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    12a1:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    12a6:	eb 10                	jmp    12b8 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    12a8:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    12ab:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    12ae:	83 c1 01             	add    $0x1,%ecx
    12b1:	0f be c0             	movsbl %al,%eax
    12b4:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    12b8:	0f b6 01             	movzbl (%ecx),%eax
    12bb:	8d 58 d0             	lea    -0x30(%eax),%ebx
    12be:	80 fb 09             	cmp    $0x9,%bl
    12c1:	76 e5                	jbe    12a8 <atoi+0xe>
  return n;
}
    12c3:	89 d0                	mov    %edx,%eax
    12c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c8:	c9                   	leave  
    12c9:	c3                   	ret    

000012ca <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    12ca:	55                   	push   %ebp
    12cb:	89 e5                	mov    %esp,%ebp
    12cd:	56                   	push   %esi
    12ce:	53                   	push   %ebx
    12cf:	8b 75 08             	mov    0x8(%ebp),%esi
    12d2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    12d5:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    12d8:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    12da:	eb 0d                	jmp    12e9 <memmove+0x1f>
    *dst++ = *src++;
    12dc:	0f b6 01             	movzbl (%ecx),%eax
    12df:	88 02                	mov    %al,(%edx)
    12e1:	8d 49 01             	lea    0x1(%ecx),%ecx
    12e4:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    12e7:	89 d8                	mov    %ebx,%eax
    12e9:	8d 58 ff             	lea    -0x1(%eax),%ebx
    12ec:	85 c0                	test   %eax,%eax
    12ee:	7f ec                	jg     12dc <memmove+0x12>
  return vdst;
}
    12f0:	89 f0                	mov    %esi,%eax
    12f2:	5b                   	pop    %ebx
    12f3:	5e                   	pop    %esi
    12f4:	5d                   	pop    %ebp
    12f5:	c3                   	ret    

000012f6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12f6:	b8 01 00 00 00       	mov    $0x1,%eax
    12fb:	cd 40                	int    $0x40
    12fd:	c3                   	ret    

000012fe <exit>:
SYSCALL(exit)
    12fe:	b8 02 00 00 00       	mov    $0x2,%eax
    1303:	cd 40                	int    $0x40
    1305:	c3                   	ret    

00001306 <wait>:
SYSCALL(wait)
    1306:	b8 03 00 00 00       	mov    $0x3,%eax
    130b:	cd 40                	int    $0x40
    130d:	c3                   	ret    

0000130e <pipe>:
SYSCALL(pipe)
    130e:	b8 04 00 00 00       	mov    $0x4,%eax
    1313:	cd 40                	int    $0x40
    1315:	c3                   	ret    

00001316 <read>:
SYSCALL(read)
    1316:	b8 05 00 00 00       	mov    $0x5,%eax
    131b:	cd 40                	int    $0x40
    131d:	c3                   	ret    

0000131e <write>:
SYSCALL(write)
    131e:	b8 10 00 00 00       	mov    $0x10,%eax
    1323:	cd 40                	int    $0x40
    1325:	c3                   	ret    

00001326 <close>:
SYSCALL(close)
    1326:	b8 15 00 00 00       	mov    $0x15,%eax
    132b:	cd 40                	int    $0x40
    132d:	c3                   	ret    

0000132e <kill>:
SYSCALL(kill)
    132e:	b8 06 00 00 00       	mov    $0x6,%eax
    1333:	cd 40                	int    $0x40
    1335:	c3                   	ret    

00001336 <exec>:
SYSCALL(exec)
    1336:	b8 07 00 00 00       	mov    $0x7,%eax
    133b:	cd 40                	int    $0x40
    133d:	c3                   	ret    

0000133e <open>:
SYSCALL(open)
    133e:	b8 0f 00 00 00       	mov    $0xf,%eax
    1343:	cd 40                	int    $0x40
    1345:	c3                   	ret    

00001346 <mknod>:
SYSCALL(mknod)
    1346:	b8 11 00 00 00       	mov    $0x11,%eax
    134b:	cd 40                	int    $0x40
    134d:	c3                   	ret    

0000134e <unlink>:
SYSCALL(unlink)
    134e:	b8 12 00 00 00       	mov    $0x12,%eax
    1353:	cd 40                	int    $0x40
    1355:	c3                   	ret    

00001356 <fstat>:
SYSCALL(fstat)
    1356:	b8 08 00 00 00       	mov    $0x8,%eax
    135b:	cd 40                	int    $0x40
    135d:	c3                   	ret    

0000135e <link>:
SYSCALL(link)
    135e:	b8 13 00 00 00       	mov    $0x13,%eax
    1363:	cd 40                	int    $0x40
    1365:	c3                   	ret    

00001366 <mkdir>:
SYSCALL(mkdir)
    1366:	b8 14 00 00 00       	mov    $0x14,%eax
    136b:	cd 40                	int    $0x40
    136d:	c3                   	ret    

0000136e <chdir>:
SYSCALL(chdir)
    136e:	b8 09 00 00 00       	mov    $0x9,%eax
    1373:	cd 40                	int    $0x40
    1375:	c3                   	ret    

00001376 <dup>:
SYSCALL(dup)
    1376:	b8 0a 00 00 00       	mov    $0xa,%eax
    137b:	cd 40                	int    $0x40
    137d:	c3                   	ret    

0000137e <getpid>:
SYSCALL(getpid)
    137e:	b8 0b 00 00 00       	mov    $0xb,%eax
    1383:	cd 40                	int    $0x40
    1385:	c3                   	ret    

00001386 <sbrk>:
SYSCALL(sbrk)
    1386:	b8 0c 00 00 00       	mov    $0xc,%eax
    138b:	cd 40                	int    $0x40
    138d:	c3                   	ret    

0000138e <sleep>:
SYSCALL(sleep)
    138e:	b8 0d 00 00 00       	mov    $0xd,%eax
    1393:	cd 40                	int    $0x40
    1395:	c3                   	ret    

00001396 <uptime>:
SYSCALL(uptime)
    1396:	b8 0e 00 00 00       	mov    $0xe,%eax
    139b:	cd 40                	int    $0x40
    139d:	c3                   	ret    

0000139e <settickets>:
SYSCALL(settickets)
    139e:	b8 16 00 00 00       	mov    $0x16,%eax
    13a3:	cd 40                	int    $0x40
    13a5:	c3                   	ret    

000013a6 <getpinfo>:
SYSCALL(getpinfo)
    13a6:	b8 17 00 00 00       	mov    $0x17,%eax
    13ab:	cd 40                	int    $0x40
    13ad:	c3                   	ret    

000013ae <mprotect>:
SYSCALL(mprotect)
    13ae:	b8 18 00 00 00       	mov    $0x18,%eax
    13b3:	cd 40                	int    $0x40
    13b5:	c3                   	ret    

000013b6 <munprotect>:
    13b6:	b8 19 00 00 00       	mov    $0x19,%eax
    13bb:	cd 40                	int    $0x40
    13bd:	c3                   	ret    

000013be <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    13be:	55                   	push   %ebp
    13bf:	89 e5                	mov    %esp,%ebp
    13c1:	83 ec 1c             	sub    $0x1c,%esp
    13c4:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    13c7:	6a 01                	push   $0x1
    13c9:	8d 55 f4             	lea    -0xc(%ebp),%edx
    13cc:	52                   	push   %edx
    13cd:	50                   	push   %eax
    13ce:	e8 4b ff ff ff       	call   131e <write>
}
    13d3:	83 c4 10             	add    $0x10,%esp
    13d6:	c9                   	leave  
    13d7:	c3                   	ret    

000013d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13d8:	55                   	push   %ebp
    13d9:	89 e5                	mov    %esp,%ebp
    13db:	57                   	push   %edi
    13dc:	56                   	push   %esi
    13dd:	53                   	push   %ebx
    13de:	83 ec 2c             	sub    $0x2c,%esp
    13e1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    13e4:	89 d0                	mov    %edx,%eax
    13e6:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13e8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    13ec:	0f 95 c1             	setne  %cl
    13ef:	c1 ea 1f             	shr    $0x1f,%edx
    13f2:	84 d1                	test   %dl,%cl
    13f4:	74 44                	je     143a <printint+0x62>
    neg = 1;
    x = -xx;
    13f6:	f7 d8                	neg    %eax
    13f8:	89 c1                	mov    %eax,%ecx
    neg = 1;
    13fa:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1401:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1406:	89 c8                	mov    %ecx,%eax
    1408:	ba 00 00 00 00       	mov    $0x0,%edx
    140d:	f7 f6                	div    %esi
    140f:	89 df                	mov    %ebx,%edi
    1411:	83 c3 01             	add    $0x1,%ebx
    1414:	0f b6 92 00 18 00 00 	movzbl 0x1800(%edx),%edx
    141b:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    141f:	89 ca                	mov    %ecx,%edx
    1421:	89 c1                	mov    %eax,%ecx
    1423:	39 d6                	cmp    %edx,%esi
    1425:	76 df                	jbe    1406 <printint+0x2e>
  if(neg)
    1427:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    142b:	74 31                	je     145e <printint+0x86>
    buf[i++] = '-';
    142d:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1432:	8d 5f 02             	lea    0x2(%edi),%ebx
    1435:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1438:	eb 17                	jmp    1451 <printint+0x79>
    x = xx;
    143a:	89 c1                	mov    %eax,%ecx
  neg = 0;
    143c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1443:	eb bc                	jmp    1401 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1445:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    144a:	89 f0                	mov    %esi,%eax
    144c:	e8 6d ff ff ff       	call   13be <putc>
  while(--i >= 0)
    1451:	83 eb 01             	sub    $0x1,%ebx
    1454:	79 ef                	jns    1445 <printint+0x6d>
}
    1456:	83 c4 2c             	add    $0x2c,%esp
    1459:	5b                   	pop    %ebx
    145a:	5e                   	pop    %esi
    145b:	5f                   	pop    %edi
    145c:	5d                   	pop    %ebp
    145d:	c3                   	ret    
    145e:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1461:	eb ee                	jmp    1451 <printint+0x79>

00001463 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1463:	55                   	push   %ebp
    1464:	89 e5                	mov    %esp,%ebp
    1466:	57                   	push   %edi
    1467:	56                   	push   %esi
    1468:	53                   	push   %ebx
    1469:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    146c:	8d 45 10             	lea    0x10(%ebp),%eax
    146f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1472:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1477:	bb 00 00 00 00       	mov    $0x0,%ebx
    147c:	eb 14                	jmp    1492 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    147e:	89 fa                	mov    %edi,%edx
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
    1483:	e8 36 ff ff ff       	call   13be <putc>
    1488:	eb 05                	jmp    148f <printf+0x2c>
      }
    } else if(state == '%'){
    148a:	83 fe 25             	cmp    $0x25,%esi
    148d:	74 25                	je     14b4 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    148f:	83 c3 01             	add    $0x1,%ebx
    1492:	8b 45 0c             	mov    0xc(%ebp),%eax
    1495:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1499:	84 c0                	test   %al,%al
    149b:	0f 84 20 01 00 00    	je     15c1 <printf+0x15e>
    c = fmt[i] & 0xff;
    14a1:	0f be f8             	movsbl %al,%edi
    14a4:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    14a7:	85 f6                	test   %esi,%esi
    14a9:	75 df                	jne    148a <printf+0x27>
      if(c == '%'){
    14ab:	83 f8 25             	cmp    $0x25,%eax
    14ae:	75 ce                	jne    147e <printf+0x1b>
        state = '%';
    14b0:	89 c6                	mov    %eax,%esi
    14b2:	eb db                	jmp    148f <printf+0x2c>
      if(c == 'd'){
    14b4:	83 f8 25             	cmp    $0x25,%eax
    14b7:	0f 84 cf 00 00 00    	je     158c <printf+0x129>
    14bd:	0f 8c dd 00 00 00    	jl     15a0 <printf+0x13d>
    14c3:	83 f8 78             	cmp    $0x78,%eax
    14c6:	0f 8f d4 00 00 00    	jg     15a0 <printf+0x13d>
    14cc:	83 f8 63             	cmp    $0x63,%eax
    14cf:	0f 8c cb 00 00 00    	jl     15a0 <printf+0x13d>
    14d5:	83 e8 63             	sub    $0x63,%eax
    14d8:	83 f8 15             	cmp    $0x15,%eax
    14db:	0f 87 bf 00 00 00    	ja     15a0 <printf+0x13d>
    14e1:	ff 24 85 a8 17 00 00 	jmp    *0x17a8(,%eax,4)
        printint(fd, *ap, 10, 1);
    14e8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    14eb:	8b 17                	mov    (%edi),%edx
    14ed:	83 ec 0c             	sub    $0xc,%esp
    14f0:	6a 01                	push   $0x1
    14f2:	b9 0a 00 00 00       	mov    $0xa,%ecx
    14f7:	8b 45 08             	mov    0x8(%ebp),%eax
    14fa:	e8 d9 fe ff ff       	call   13d8 <printint>
        ap++;
    14ff:	83 c7 04             	add    $0x4,%edi
    1502:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1505:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1508:	be 00 00 00 00       	mov    $0x0,%esi
    150d:	eb 80                	jmp    148f <printf+0x2c>
        printint(fd, *ap, 16, 0);
    150f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1512:	8b 17                	mov    (%edi),%edx
    1514:	83 ec 0c             	sub    $0xc,%esp
    1517:	6a 00                	push   $0x0
    1519:	b9 10 00 00 00       	mov    $0x10,%ecx
    151e:	8b 45 08             	mov    0x8(%ebp),%eax
    1521:	e8 b2 fe ff ff       	call   13d8 <printint>
        ap++;
    1526:	83 c7 04             	add    $0x4,%edi
    1529:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    152c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    152f:	be 00 00 00 00       	mov    $0x0,%esi
    1534:	e9 56 ff ff ff       	jmp    148f <printf+0x2c>
        s = (char*)*ap;
    1539:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    153c:	8b 30                	mov    (%eax),%esi
        ap++;
    153e:	83 c0 04             	add    $0x4,%eax
    1541:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1544:	85 f6                	test   %esi,%esi
    1546:	75 15                	jne    155d <printf+0xfa>
          s = "(null)";
    1548:	be 9f 17 00 00       	mov    $0x179f,%esi
    154d:	eb 0e                	jmp    155d <printf+0xfa>
          putc(fd, *s);
    154f:	0f be d2             	movsbl %dl,%edx
    1552:	8b 45 08             	mov    0x8(%ebp),%eax
    1555:	e8 64 fe ff ff       	call   13be <putc>
          s++;
    155a:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    155d:	0f b6 16             	movzbl (%esi),%edx
    1560:	84 d2                	test   %dl,%dl
    1562:	75 eb                	jne    154f <printf+0xec>
      state = 0;
    1564:	be 00 00 00 00       	mov    $0x0,%esi
    1569:	e9 21 ff ff ff       	jmp    148f <printf+0x2c>
        putc(fd, *ap);
    156e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1571:	0f be 17             	movsbl (%edi),%edx
    1574:	8b 45 08             	mov    0x8(%ebp),%eax
    1577:	e8 42 fe ff ff       	call   13be <putc>
        ap++;
    157c:	83 c7 04             	add    $0x4,%edi
    157f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1582:	be 00 00 00 00       	mov    $0x0,%esi
    1587:	e9 03 ff ff ff       	jmp    148f <printf+0x2c>
        putc(fd, c);
    158c:	89 fa                	mov    %edi,%edx
    158e:	8b 45 08             	mov    0x8(%ebp),%eax
    1591:	e8 28 fe ff ff       	call   13be <putc>
      state = 0;
    1596:	be 00 00 00 00       	mov    $0x0,%esi
    159b:	e9 ef fe ff ff       	jmp    148f <printf+0x2c>
        putc(fd, '%');
    15a0:	ba 25 00 00 00       	mov    $0x25,%edx
    15a5:	8b 45 08             	mov    0x8(%ebp),%eax
    15a8:	e8 11 fe ff ff       	call   13be <putc>
        putc(fd, c);
    15ad:	89 fa                	mov    %edi,%edx
    15af:	8b 45 08             	mov    0x8(%ebp),%eax
    15b2:	e8 07 fe ff ff       	call   13be <putc>
      state = 0;
    15b7:	be 00 00 00 00       	mov    $0x0,%esi
    15bc:	e9 ce fe ff ff       	jmp    148f <printf+0x2c>
    }
  }
}
    15c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15c4:	5b                   	pop    %ebx
    15c5:	5e                   	pop    %esi
    15c6:	5f                   	pop    %edi
    15c7:	5d                   	pop    %ebp
    15c8:	c3                   	ret    

000015c9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15c9:	55                   	push   %ebp
    15ca:	89 e5                	mov    %esp,%ebp
    15cc:	57                   	push   %edi
    15cd:	56                   	push   %esi
    15ce:	53                   	push   %ebx
    15cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15d2:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d5:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
    15da:	eb 02                	jmp    15de <free+0x15>
    15dc:	89 d0                	mov    %edx,%eax
    15de:	39 c8                	cmp    %ecx,%eax
    15e0:	73 04                	jae    15e6 <free+0x1d>
    15e2:	39 08                	cmp    %ecx,(%eax)
    15e4:	77 12                	ja     15f8 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15e6:	8b 10                	mov    (%eax),%edx
    15e8:	39 c2                	cmp    %eax,%edx
    15ea:	77 f0                	ja     15dc <free+0x13>
    15ec:	39 c8                	cmp    %ecx,%eax
    15ee:	72 08                	jb     15f8 <free+0x2f>
    15f0:	39 ca                	cmp    %ecx,%edx
    15f2:	77 04                	ja     15f8 <free+0x2f>
    15f4:	89 d0                	mov    %edx,%eax
    15f6:	eb e6                	jmp    15de <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    15f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    15fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15fe:	8b 10                	mov    (%eax),%edx
    1600:	39 d7                	cmp    %edx,%edi
    1602:	74 19                	je     161d <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1604:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1607:	8b 50 04             	mov    0x4(%eax),%edx
    160a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    160d:	39 ce                	cmp    %ecx,%esi
    160f:	74 1b                	je     162c <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1611:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1613:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
}
    1618:	5b                   	pop    %ebx
    1619:	5e                   	pop    %esi
    161a:	5f                   	pop    %edi
    161b:	5d                   	pop    %ebp
    161c:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    161d:	03 72 04             	add    0x4(%edx),%esi
    1620:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1623:	8b 10                	mov    (%eax),%edx
    1625:	8b 12                	mov    (%edx),%edx
    1627:	89 53 f8             	mov    %edx,-0x8(%ebx)
    162a:	eb db                	jmp    1607 <free+0x3e>
    p->s.size += bp->s.size;
    162c:	03 53 fc             	add    -0x4(%ebx),%edx
    162f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1632:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1635:	89 10                	mov    %edx,(%eax)
    1637:	eb da                	jmp    1613 <free+0x4a>

00001639 <morecore>:

static Header*
morecore(uint nu)
{
    1639:	55                   	push   %ebp
    163a:	89 e5                	mov    %esp,%ebp
    163c:	53                   	push   %ebx
    163d:	83 ec 04             	sub    $0x4,%esp
    1640:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1642:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1647:	77 05                	ja     164e <morecore+0x15>
    nu = 4096;
    1649:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    164e:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1655:	83 ec 0c             	sub    $0xc,%esp
    1658:	50                   	push   %eax
    1659:	e8 28 fd ff ff       	call   1386 <sbrk>
  if(p == (char*)-1)
    165e:	83 c4 10             	add    $0x10,%esp
    1661:	83 f8 ff             	cmp    $0xffffffff,%eax
    1664:	74 1c                	je     1682 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1666:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1669:	83 c0 08             	add    $0x8,%eax
    166c:	83 ec 0c             	sub    $0xc,%esp
    166f:	50                   	push   %eax
    1670:	e8 54 ff ff ff       	call   15c9 <free>
  return freep;
    1675:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
    167a:	83 c4 10             	add    $0x10,%esp
}
    167d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1680:	c9                   	leave  
    1681:	c3                   	ret    
    return 0;
    1682:	b8 00 00 00 00       	mov    $0x0,%eax
    1687:	eb f4                	jmp    167d <morecore+0x44>

00001689 <malloc>:

void*
malloc(uint nbytes)
{
    1689:	55                   	push   %ebp
    168a:	89 e5                	mov    %esp,%ebp
    168c:	53                   	push   %ebx
    168d:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1690:	8b 45 08             	mov    0x8(%ebp),%eax
    1693:	8d 58 07             	lea    0x7(%eax),%ebx
    1696:	c1 eb 03             	shr    $0x3,%ebx
    1699:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    169c:	8b 0d c0 1a 00 00    	mov    0x1ac0,%ecx
    16a2:	85 c9                	test   %ecx,%ecx
    16a4:	74 04                	je     16aa <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16a6:	8b 01                	mov    (%ecx),%eax
    16a8:	eb 4a                	jmp    16f4 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    16aa:	c7 05 c0 1a 00 00 c4 	movl   $0x1ac4,0x1ac0
    16b1:	1a 00 00 
    16b4:	c7 05 c4 1a 00 00 c4 	movl   $0x1ac4,0x1ac4
    16bb:	1a 00 00 
    base.s.size = 0;
    16be:	c7 05 c8 1a 00 00 00 	movl   $0x0,0x1ac8
    16c5:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    16c8:	b9 c4 1a 00 00       	mov    $0x1ac4,%ecx
    16cd:	eb d7                	jmp    16a6 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    16cf:	74 19                	je     16ea <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    16d1:	29 da                	sub    %ebx,%edx
    16d3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    16d6:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    16d9:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    16dc:	89 0d c0 1a 00 00    	mov    %ecx,0x1ac0
      return (void*)(p + 1);
    16e2:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    16e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16e8:	c9                   	leave  
    16e9:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    16ea:	8b 10                	mov    (%eax),%edx
    16ec:	89 11                	mov    %edx,(%ecx)
    16ee:	eb ec                	jmp    16dc <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16f0:	89 c1                	mov    %eax,%ecx
    16f2:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    16f4:	8b 50 04             	mov    0x4(%eax),%edx
    16f7:	39 da                	cmp    %ebx,%edx
    16f9:	73 d4                	jae    16cf <malloc+0x46>
    if(p == freep)
    16fb:	39 05 c0 1a 00 00    	cmp    %eax,0x1ac0
    1701:	75 ed                	jne    16f0 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1703:	89 d8                	mov    %ebx,%eax
    1705:	e8 2f ff ff ff       	call   1639 <morecore>
    170a:	85 c0                	test   %eax,%eax
    170c:	75 e2                	jne    16f0 <malloc+0x67>
    170e:	eb d5                	jmp    16e5 <malloc+0x5c>
