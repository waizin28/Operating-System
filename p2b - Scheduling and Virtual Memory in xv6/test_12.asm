
_test_12:     file format elf32-i386


Disassembly of section .text:

00001000 <spin>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

int spin() {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
  int i = 0;
  int j = 0;
  int k = 0;
    1004:	b8 00 00 00 00       	mov    $0x0,%eax
  for (i = 0; i < 5000; ++i) {
    1009:	bb 00 00 00 00       	mov    $0x0,%ebx
    100e:	eb 2f                	jmp    103f <spin+0x3f>
    for (j = 0; j < 200000; ++j) {
      k = j % 10;
    1010:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1015:	89 c8                	mov    %ecx,%eax
    1017:	f7 ea                	imul   %edx
    1019:	c1 fa 02             	sar    $0x2,%edx
    101c:	89 c8                	mov    %ecx,%eax
    101e:	c1 f8 1f             	sar    $0x1f,%eax
    1021:	29 c2                	sub    %eax,%edx
    1023:	8d 14 92             	lea    (%edx,%edx,4),%edx
    1026:	8d 04 12             	lea    (%edx,%edx,1),%eax
    1029:	89 ca                	mov    %ecx,%edx
    102b:	29 c2                	sub    %eax,%edx
      k += i + 1;
    102d:	8d 44 13 01          	lea    0x1(%ebx,%edx,1),%eax
    for (j = 0; j < 200000; ++j) {
    1031:	83 c1 01             	add    $0x1,%ecx
    1034:	81 f9 3f 0d 03 00    	cmp    $0x30d3f,%ecx
    103a:	7e d4                	jle    1010 <spin+0x10>
  for (i = 0; i < 5000; ++i) {
    103c:	83 c3 01             	add    $0x1,%ebx
    103f:	81 fb 87 13 00 00    	cmp    $0x1387,%ebx
    1045:	7f 07                	jg     104e <spin+0x4e>
    for (j = 0; j < 200000; ++j) {
    1047:	b9 00 00 00 00       	mov    $0x0,%ecx
    104c:	eb e6                	jmp    1034 <spin+0x34>
    }
  }
  return k;
}
    104e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1051:	c9                   	leave  
    1052:	c3                   	ret    

00001053 <print>:

void print(struct pstat *st) {
    1053:	55                   	push   %ebp
    1054:	89 e5                	mov    %esp,%ebp
    1056:	56                   	push   %esi
    1057:	53                   	push   %ebx
    1058:	8b 75 08             	mov    0x8(%ebp),%esi
   int i;
   for(i = 0; i < NPROC; i++) {
    105b:	bb 00 00 00 00       	mov    $0x0,%ebx
    1060:	eb 03                	jmp    1065 <print+0x12>
    1062:	83 c3 01             	add    $0x1,%ebx
    1065:	83 fb 3f             	cmp    $0x3f,%ebx
    1068:	7f 2f                	jg     1099 <print+0x46>
     if (st->inuse[i]) {
    106a:	83 3c 9e 00          	cmpl   $0x0,(%esi,%ebx,4)
    106e:	74 f2                	je     1062 <print+0xf>
       printf(1, "pid: %d tickets: %d ticks: %d\n", st->pid[i], st->tickets[i], st->ticks[i]);
    1070:	83 ec 0c             	sub    $0xc,%esp
    1073:	ff b4 9e 00 03 00 00 	push   0x300(%esi,%ebx,4)
    107a:	ff b4 9e 00 01 00 00 	push   0x100(%esi,%ebx,4)
    1081:	ff b4 9e 00 02 00 00 	push   0x200(%esi,%ebx,4)
    1088:	68 94 18 00 00       	push   $0x1894
    108d:	6a 01                	push   $0x1
    108f:	e8 53 05 00 00       	call   15e7 <printf>
    1094:	83 c4 20             	add    $0x20,%esp
    1097:	eb c9                	jmp    1062 <print+0xf>
     }
   }
}
    1099:	8d 65 f8             	lea    -0x8(%ebp),%esp
    109c:	5b                   	pop    %ebx
    109d:	5e                   	pop    %esi
    109e:	5d                   	pop    %ebp
    109f:	c3                   	ret    

000010a0 <compare>:

void compare(int pid_low, int pid_high, struct pstat *before, struct pstat *after) {
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	57                   	push   %edi
    10a4:	56                   	push   %esi
    10a5:	53                   	push   %ebx
    10a6:	83 ec 1c             	sub    $0x1c,%esp
    10a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    10ac:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    10af:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i, ticks_low_before=-1, ticks_low_after=-1, ticks_high_before=-1, ticks_high_after=-1;
    10b2:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
    10b9:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
    10c0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    10c7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  for(i = 0; i < NPROC; i++) {
    10ce:	b8 00 00 00 00       	mov    $0x0,%eax
    10d3:	eb 27                	jmp    10fc <compare+0x5c>
    if (before->pid[i] == pid_low) 
        ticks_low_before = before->ticks[i];
    10d5:	8b b4 87 00 03 00 00 	mov    0x300(%edi,%eax,4),%esi
    10dc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    10df:	eb 2b                	jmp    110c <compare+0x6c>
    if (before->pid[i] == pid_high)
        ticks_high_before = before->ticks[i];
    10e1:	8b b4 87 00 03 00 00 	mov    0x300(%edi,%eax,4),%esi
    10e8:	89 75 dc             	mov    %esi,-0x24(%ebp)
    10eb:	eb 23                	jmp    1110 <compare+0x70>
    if (after->pid[i] == pid_low)
        ticks_low_after = after->ticks[i];
    10ed:	8b b4 86 00 03 00 00 	mov    0x300(%esi,%eax,4),%esi
    10f4:	89 75 e0             	mov    %esi,-0x20(%ebp)
    10f7:	eb 25                	jmp    111e <compare+0x7e>
  for(i = 0; i < NPROC; i++) {
    10f9:	83 c0 01             	add    $0x1,%eax
    10fc:	83 f8 3f             	cmp    $0x3f,%eax
    10ff:	7f 30                	jg     1131 <compare+0x91>
    if (before->pid[i] == pid_low) 
    1101:	8b 94 87 00 02 00 00 	mov    0x200(%edi,%eax,4),%edx
    1108:	39 da                	cmp    %ebx,%edx
    110a:	74 c9                	je     10d5 <compare+0x35>
    if (before->pid[i] == pid_high)
    110c:	39 ca                	cmp    %ecx,%edx
    110e:	74 d1                	je     10e1 <compare+0x41>
    if (after->pid[i] == pid_low)
    1110:	8b 75 14             	mov    0x14(%ebp),%esi
    1113:	8b 94 86 00 02 00 00 	mov    0x200(%esi,%eax,4),%edx
    111a:	39 da                	cmp    %ebx,%edx
    111c:	74 cf                	je     10ed <compare+0x4d>
    if (after->pid[i] == pid_high)
    111e:	39 ca                	cmp    %ecx,%edx
    1120:	75 d7                	jne    10f9 <compare+0x59>
        ticks_high_after = after->ticks[i];
    1122:	8b 75 14             	mov    0x14(%ebp),%esi
    1125:	8b b4 86 00 03 00 00 	mov    0x300(%esi,%eax,4),%esi
    112c:	89 75 d8             	mov    %esi,-0x28(%ebp)
    112f:	eb c8                	jmp    10f9 <compare+0x59>
  }
  printf(1, "high before: %d high after: %d, low before: %d low after: %d\n", 
    1131:	83 ec 08             	sub    $0x8,%esp
    1134:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    1137:	53                   	push   %ebx
    1138:	ff 75 e4             	push   -0x1c(%ebp)
    113b:	8b 7d d8             	mov    -0x28(%ebp),%edi
    113e:	57                   	push   %edi
    113f:	8b 75 dc             	mov    -0x24(%ebp),%esi
    1142:	56                   	push   %esi
    1143:	68 b4 18 00 00       	push   $0x18b4
    1148:	6a 01                	push   $0x1
    114a:	e8 98 04 00 00       	call   15e7 <printf>
                     ticks_high_before, ticks_high_after, ticks_low_before, ticks_low_after);
  
  if ( (ticks_high_after-ticks_high_before) > (ticks_low_after - ticks_low_before)) {
    114f:	29 f7                	sub    %esi,%edi
    1151:	89 d8                	mov    %ebx,%eax
    1153:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    1156:	83 c4 20             	add    $0x20,%esp
    1159:	39 c7                	cmp    %eax,%edi
    115b:	7e 17                	jle    1174 <compare+0xd4>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n"); 
    115d:	83 ec 08             	sub    $0x8,%esp
    1160:	68 f2 18 00 00       	push   $0x18f2
    1165:	6a 01                	push   $0x1
    1167:	e8 7b 04 00 00       	call   15e7 <printf>
  } else {
    printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    exit();
  }
}
    116c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    116f:	5b                   	pop    %ebx
    1170:	5e                   	pop    %esi
    1171:	5f                   	pop    %edi
    1172:	5d                   	pop    %ebp
    1173:	c3                   	ret    
    printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    1174:	83 ec 08             	sub    $0x8,%esp
    1177:	68 0a 19 00 00       	push   $0x190a
    117c:	6a 01                	push   $0x1
    117e:	e8 64 04 00 00       	call   15e7 <printf>
    exit();
    1183:	e8 fa 02 00 00       	call   1482 <exit>

00001188 <main>:

int
main(int argc, char *argv[])
{
    1188:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    118c:	83 e4 f0             	and    $0xfffffff0,%esp
    118f:	ff 71 fc             	push   -0x4(%ecx)
    1192:	55                   	push   %ebp
    1193:	89 e5                	mov    %esp,%ebp
    1195:	57                   	push   %edi
    1196:	56                   	push   %esi
    1197:	53                   	push   %ebx
    1198:	51                   	push   %ecx
    1199:	81 ec 08 08 00 00    	sub    $0x808,%esp
  int pid_low = getpid();
    119f:	e8 5e 03 00 00       	call   1502 <getpid>
    11a4:	89 c3                	mov    %eax,%ebx
  int lowtickets = 0, hightickets = 1;

  if (settickets(lowtickets) != 0) {
    11a6:	83 ec 0c             	sub    $0xc,%esp
    11a9:	6a 00                	push   $0x0
    11ab:	e8 72 03 00 00       	call   1522 <settickets>
    11b0:	83 c4 10             	add    $0x10,%esp
    11b3:	85 c0                	test   %eax,%eax
    11b5:	74 14                	je     11cb <main+0x43>
    printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    11b7:	83 ec 08             	sub    $0x8,%esp
    11ba:	68 0a 19 00 00       	push   $0x190a
    11bf:	6a 01                	push   $0x1
    11c1:	e8 21 04 00 00       	call   15e7 <printf>
    exit();
    11c6:	e8 b7 02 00 00       	call   1482 <exit>
  }

  if (fork() == 0) {  	
    11cb:	e8 aa 02 00 00       	call   147a <fork>
    11d0:	85 c0                	test   %eax,%eax
    11d2:	0f 85 e5 00 00 00    	jne    12bd <main+0x135>
    if (settickets(hightickets) != 0) {
    11d8:	83 ec 0c             	sub    $0xc,%esp
    11db:	6a 01                	push   $0x1
    11dd:	e8 40 03 00 00       	call   1522 <settickets>
    11e2:	83 c4 10             	add    $0x10,%esp
    11e5:	85 c0                	test   %eax,%eax
    11e7:	74 14                	je     11fd <main+0x75>
      printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    11e9:	83 ec 08             	sub    $0x8,%esp
    11ec:	68 0a 19 00 00       	push   $0x190a
    11f1:	6a 01                	push   $0x1
    11f3:	e8 ef 03 00 00       	call   15e7 <printf>
      exit();
    11f8:	e8 85 02 00 00       	call   1482 <exit>
    }
    
    int pid_high = getpid();
    11fd:	e8 00 03 00 00       	call   1502 <getpid>
    1202:	89 c6                	mov    %eax,%esi
    struct pstat st_before, st_after;
        
    if (getpinfo(&st_before) != 0) {
    1204:	83 ec 0c             	sub    $0xc,%esp
    1207:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
    120d:	50                   	push   %eax
    120e:	e8 17 03 00 00       	call   152a <getpinfo>
    1213:	83 c4 10             	add    $0x10,%esp
    1216:	85 c0                	test   %eax,%eax
    1218:	74 14                	je     122e <main+0xa6>
      printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    121a:	83 ec 08             	sub    $0x8,%esp
    121d:	68 0a 19 00 00       	push   $0x190a
    1222:	6a 01                	push   $0x1
    1224:	e8 be 03 00 00       	call   15e7 <printf>
      exit();
    1229:	e8 54 02 00 00       	call   1482 <exit>
    }
        
    printf(1, "\n ****PInfo before**** \n");
    122e:	83 ec 08             	sub    $0x8,%esp
    1231:	68 21 19 00 00       	push   $0x1921
    1236:	6a 01                	push   $0x1
    1238:	e8 aa 03 00 00       	call   15e7 <printf>
    print(&st_before);
    123d:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
    1243:	89 04 24             	mov    %eax,(%esp)
    1246:	e8 08 fe ff ff       	call   1053 <print>
    printf(1,"Spinning...%d\n", spin());
    124b:	e8 b0 fd ff ff       	call   1000 <spin>
    1250:	83 c4 0c             	add    $0xc,%esp
    1253:	50                   	push   %eax
    1254:	68 3a 19 00 00       	push   $0x193a
    1259:	6a 01                	push   $0x1
    125b:	e8 87 03 00 00       	call   15e7 <printf>

        
    if (getpinfo(&st_after) != 0) {
    1260:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    1266:	89 04 24             	mov    %eax,(%esp)
    1269:	e8 bc 02 00 00       	call   152a <getpinfo>
    126e:	83 c4 10             	add    $0x10,%esp
    1271:	85 c0                	test   %eax,%eax
    1273:	74 14                	je     1289 <main+0x101>
      printf(1, "XV6_SCHEDULER\t FAILED\n"); 
    1275:	83 ec 08             	sub    $0x8,%esp
    1278:	68 0a 19 00 00       	push   $0x190a
    127d:	6a 01                	push   $0x1
    127f:	e8 63 03 00 00       	call   15e7 <printf>
      exit();
    1284:	e8 f9 01 00 00       	call   1482 <exit>
    }
        
    printf(1, "\n ****PInfo after**** \n");
    1289:	83 ec 08             	sub    $0x8,%esp
    128c:	68 49 19 00 00       	push   $0x1949
    1291:	6a 01                	push   $0x1
    1293:	e8 4f 03 00 00       	call   15e7 <printf>
    print(&st_after);
    1298:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
    129e:	89 3c 24             	mov    %edi,(%esp)
    12a1:	e8 ad fd ff ff       	call   1053 <print>
	
    compare(pid_low, pid_high, &st_before, &st_after);
    12a6:	57                   	push   %edi
    12a7:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
    12ad:	50                   	push   %eax
    12ae:	56                   	push   %esi
    12af:	53                   	push   %ebx
    12b0:	e8 eb fd ff ff       	call   10a0 <compare>
         
    exit();
    12b5:	83 c4 20             	add    $0x20,%esp
    12b8:	e8 c5 01 00 00       	call   1482 <exit>
  }
  printf(1,"Spinning...%d\n", spin());
    12bd:	e8 3e fd ff ff       	call   1000 <spin>
    12c2:	83 ec 04             	sub    $0x4,%esp
    12c5:	50                   	push   %eax
    12c6:	68 3a 19 00 00       	push   $0x193a
    12cb:	6a 01                	push   $0x1
    12cd:	e8 15 03 00 00       	call   15e7 <printf>

  while (wait() > -1);
    12d2:	83 c4 10             	add    $0x10,%esp
    12d5:	e8 b0 01 00 00       	call   148a <wait>
    12da:	85 c0                	test   %eax,%eax
    12dc:	79 f7                	jns    12d5 <main+0x14d>
  exit();
    12de:	e8 9f 01 00 00       	call   1482 <exit>

000012e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    12e3:	55                   	push   %ebp
    12e4:	89 e5                	mov    %esp,%ebp
    12e6:	56                   	push   %esi
    12e7:	53                   	push   %ebx
    12e8:	8b 75 08             	mov    0x8(%ebp),%esi
    12eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    12ee:	89 f0                	mov    %esi,%eax
    12f0:	89 d1                	mov    %edx,%ecx
    12f2:	83 c2 01             	add    $0x1,%edx
    12f5:	89 c3                	mov    %eax,%ebx
    12f7:	83 c0 01             	add    $0x1,%eax
    12fa:	0f b6 09             	movzbl (%ecx),%ecx
    12fd:	88 0b                	mov    %cl,(%ebx)
    12ff:	84 c9                	test   %cl,%cl
    1301:	75 ed                	jne    12f0 <strcpy+0xd>
    ;
  return os;
}
    1303:	89 f0                	mov    %esi,%eax
    1305:	5b                   	pop    %ebx
    1306:	5e                   	pop    %esi
    1307:	5d                   	pop    %ebp
    1308:	c3                   	ret    

00001309 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1309:	55                   	push   %ebp
    130a:	89 e5                	mov    %esp,%ebp
    130c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    130f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1312:	eb 06                	jmp    131a <strcmp+0x11>
    p++, q++;
    1314:	83 c1 01             	add    $0x1,%ecx
    1317:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    131a:	0f b6 01             	movzbl (%ecx),%eax
    131d:	84 c0                	test   %al,%al
    131f:	74 04                	je     1325 <strcmp+0x1c>
    1321:	3a 02                	cmp    (%edx),%al
    1323:	74 ef                	je     1314 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1325:	0f b6 c0             	movzbl %al,%eax
    1328:	0f b6 12             	movzbl (%edx),%edx
    132b:	29 d0                	sub    %edx,%eax
}
    132d:	5d                   	pop    %ebp
    132e:	c3                   	ret    

0000132f <strlen>:

uint
strlen(const char *s)
{
    132f:	55                   	push   %ebp
    1330:	89 e5                	mov    %esp,%ebp
    1332:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1335:	b8 00 00 00 00       	mov    $0x0,%eax
    133a:	eb 03                	jmp    133f <strlen+0x10>
    133c:	83 c0 01             	add    $0x1,%eax
    133f:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    1343:	75 f7                	jne    133c <strlen+0xd>
    ;
  return n;
}
    1345:	5d                   	pop    %ebp
    1346:	c3                   	ret    

00001347 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1347:	55                   	push   %ebp
    1348:	89 e5                	mov    %esp,%ebp
    134a:	57                   	push   %edi
    134b:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    134e:	89 d7                	mov    %edx,%edi
    1350:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1353:	8b 45 0c             	mov    0xc(%ebp),%eax
    1356:	fc                   	cld    
    1357:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1359:	89 d0                	mov    %edx,%eax
    135b:	8b 7d fc             	mov    -0x4(%ebp),%edi
    135e:	c9                   	leave  
    135f:	c3                   	ret    

00001360 <strchr>:

char*
strchr(const char *s, char c)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	8b 45 08             	mov    0x8(%ebp),%eax
    1366:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    136a:	eb 03                	jmp    136f <strchr+0xf>
    136c:	83 c0 01             	add    $0x1,%eax
    136f:	0f b6 10             	movzbl (%eax),%edx
    1372:	84 d2                	test   %dl,%dl
    1374:	74 06                	je     137c <strchr+0x1c>
    if(*s == c)
    1376:	38 ca                	cmp    %cl,%dl
    1378:	75 f2                	jne    136c <strchr+0xc>
    137a:	eb 05                	jmp    1381 <strchr+0x21>
      return (char*)s;
  return 0;
    137c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1381:	5d                   	pop    %ebp
    1382:	c3                   	ret    

00001383 <gets>:

char*
gets(char *buf, int max)
{
    1383:	55                   	push   %ebp
    1384:	89 e5                	mov    %esp,%ebp
    1386:	57                   	push   %edi
    1387:	56                   	push   %esi
    1388:	53                   	push   %ebx
    1389:	83 ec 1c             	sub    $0x1c,%esp
    138c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    138f:	bb 00 00 00 00       	mov    $0x0,%ebx
    1394:	89 de                	mov    %ebx,%esi
    1396:	83 c3 01             	add    $0x1,%ebx
    1399:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    139c:	7d 2e                	jge    13cc <gets+0x49>
    cc = read(0, &c, 1);
    139e:	83 ec 04             	sub    $0x4,%esp
    13a1:	6a 01                	push   $0x1
    13a3:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13a6:	50                   	push   %eax
    13a7:	6a 00                	push   $0x0
    13a9:	e8 ec 00 00 00       	call   149a <read>
    if(cc < 1)
    13ae:	83 c4 10             	add    $0x10,%esp
    13b1:	85 c0                	test   %eax,%eax
    13b3:	7e 17                	jle    13cc <gets+0x49>
      break;
    buf[i++] = c;
    13b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13b9:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    13bc:	3c 0a                	cmp    $0xa,%al
    13be:	0f 94 c2             	sete   %dl
    13c1:	3c 0d                	cmp    $0xd,%al
    13c3:	0f 94 c0             	sete   %al
    13c6:	08 c2                	or     %al,%dl
    13c8:	74 ca                	je     1394 <gets+0x11>
    buf[i++] = c;
    13ca:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    13cc:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    13d0:	89 f8                	mov    %edi,%eax
    13d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13d5:	5b                   	pop    %ebx
    13d6:	5e                   	pop    %esi
    13d7:	5f                   	pop    %edi
    13d8:	5d                   	pop    %ebp
    13d9:	c3                   	ret    

000013da <stat>:

int
stat(const char *n, struct stat *st)
{
    13da:	55                   	push   %ebp
    13db:	89 e5                	mov    %esp,%ebp
    13dd:	56                   	push   %esi
    13de:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13df:	83 ec 08             	sub    $0x8,%esp
    13e2:	6a 00                	push   $0x0
    13e4:	ff 75 08             	push   0x8(%ebp)
    13e7:	e8 d6 00 00 00       	call   14c2 <open>
  if(fd < 0)
    13ec:	83 c4 10             	add    $0x10,%esp
    13ef:	85 c0                	test   %eax,%eax
    13f1:	78 24                	js     1417 <stat+0x3d>
    13f3:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    13f5:	83 ec 08             	sub    $0x8,%esp
    13f8:	ff 75 0c             	push   0xc(%ebp)
    13fb:	50                   	push   %eax
    13fc:	e8 d9 00 00 00       	call   14da <fstat>
    1401:	89 c6                	mov    %eax,%esi
  close(fd);
    1403:	89 1c 24             	mov    %ebx,(%esp)
    1406:	e8 9f 00 00 00       	call   14aa <close>
  return r;
    140b:	83 c4 10             	add    $0x10,%esp
}
    140e:	89 f0                	mov    %esi,%eax
    1410:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1413:	5b                   	pop    %ebx
    1414:	5e                   	pop    %esi
    1415:	5d                   	pop    %ebp
    1416:	c3                   	ret    
    return -1;
    1417:	be ff ff ff ff       	mov    $0xffffffff,%esi
    141c:	eb f0                	jmp    140e <stat+0x34>

0000141e <atoi>:

int
atoi(const char *s)
{
    141e:	55                   	push   %ebp
    141f:	89 e5                	mov    %esp,%ebp
    1421:	53                   	push   %ebx
    1422:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1425:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    142a:	eb 10                	jmp    143c <atoi+0x1e>
    n = n*10 + *s++ - '0';
    142c:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    142f:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1432:	83 c1 01             	add    $0x1,%ecx
    1435:	0f be c0             	movsbl %al,%eax
    1438:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    143c:	0f b6 01             	movzbl (%ecx),%eax
    143f:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1442:	80 fb 09             	cmp    $0x9,%bl
    1445:	76 e5                	jbe    142c <atoi+0xe>
  return n;
}
    1447:	89 d0                	mov    %edx,%eax
    1449:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    144c:	c9                   	leave  
    144d:	c3                   	ret    

0000144e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    144e:	55                   	push   %ebp
    144f:	89 e5                	mov    %esp,%ebp
    1451:	56                   	push   %esi
    1452:	53                   	push   %ebx
    1453:	8b 75 08             	mov    0x8(%ebp),%esi
    1456:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1459:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    145c:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    145e:	eb 0d                	jmp    146d <memmove+0x1f>
    *dst++ = *src++;
    1460:	0f b6 01             	movzbl (%ecx),%eax
    1463:	88 02                	mov    %al,(%edx)
    1465:	8d 49 01             	lea    0x1(%ecx),%ecx
    1468:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    146b:	89 d8                	mov    %ebx,%eax
    146d:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1470:	85 c0                	test   %eax,%eax
    1472:	7f ec                	jg     1460 <memmove+0x12>
  return vdst;
}
    1474:	89 f0                	mov    %esi,%eax
    1476:	5b                   	pop    %ebx
    1477:	5e                   	pop    %esi
    1478:	5d                   	pop    %ebp
    1479:	c3                   	ret    

0000147a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    147a:	b8 01 00 00 00       	mov    $0x1,%eax
    147f:	cd 40                	int    $0x40
    1481:	c3                   	ret    

00001482 <exit>:
SYSCALL(exit)
    1482:	b8 02 00 00 00       	mov    $0x2,%eax
    1487:	cd 40                	int    $0x40
    1489:	c3                   	ret    

0000148a <wait>:
SYSCALL(wait)
    148a:	b8 03 00 00 00       	mov    $0x3,%eax
    148f:	cd 40                	int    $0x40
    1491:	c3                   	ret    

00001492 <pipe>:
SYSCALL(pipe)
    1492:	b8 04 00 00 00       	mov    $0x4,%eax
    1497:	cd 40                	int    $0x40
    1499:	c3                   	ret    

0000149a <read>:
SYSCALL(read)
    149a:	b8 05 00 00 00       	mov    $0x5,%eax
    149f:	cd 40                	int    $0x40
    14a1:	c3                   	ret    

000014a2 <write>:
SYSCALL(write)
    14a2:	b8 10 00 00 00       	mov    $0x10,%eax
    14a7:	cd 40                	int    $0x40
    14a9:	c3                   	ret    

000014aa <close>:
SYSCALL(close)
    14aa:	b8 15 00 00 00       	mov    $0x15,%eax
    14af:	cd 40                	int    $0x40
    14b1:	c3                   	ret    

000014b2 <kill>:
SYSCALL(kill)
    14b2:	b8 06 00 00 00       	mov    $0x6,%eax
    14b7:	cd 40                	int    $0x40
    14b9:	c3                   	ret    

000014ba <exec>:
SYSCALL(exec)
    14ba:	b8 07 00 00 00       	mov    $0x7,%eax
    14bf:	cd 40                	int    $0x40
    14c1:	c3                   	ret    

000014c2 <open>:
SYSCALL(open)
    14c2:	b8 0f 00 00 00       	mov    $0xf,%eax
    14c7:	cd 40                	int    $0x40
    14c9:	c3                   	ret    

000014ca <mknod>:
SYSCALL(mknod)
    14ca:	b8 11 00 00 00       	mov    $0x11,%eax
    14cf:	cd 40                	int    $0x40
    14d1:	c3                   	ret    

000014d2 <unlink>:
SYSCALL(unlink)
    14d2:	b8 12 00 00 00       	mov    $0x12,%eax
    14d7:	cd 40                	int    $0x40
    14d9:	c3                   	ret    

000014da <fstat>:
SYSCALL(fstat)
    14da:	b8 08 00 00 00       	mov    $0x8,%eax
    14df:	cd 40                	int    $0x40
    14e1:	c3                   	ret    

000014e2 <link>:
SYSCALL(link)
    14e2:	b8 13 00 00 00       	mov    $0x13,%eax
    14e7:	cd 40                	int    $0x40
    14e9:	c3                   	ret    

000014ea <mkdir>:
SYSCALL(mkdir)
    14ea:	b8 14 00 00 00       	mov    $0x14,%eax
    14ef:	cd 40                	int    $0x40
    14f1:	c3                   	ret    

000014f2 <chdir>:
SYSCALL(chdir)
    14f2:	b8 09 00 00 00       	mov    $0x9,%eax
    14f7:	cd 40                	int    $0x40
    14f9:	c3                   	ret    

000014fa <dup>:
SYSCALL(dup)
    14fa:	b8 0a 00 00 00       	mov    $0xa,%eax
    14ff:	cd 40                	int    $0x40
    1501:	c3                   	ret    

00001502 <getpid>:
SYSCALL(getpid)
    1502:	b8 0b 00 00 00       	mov    $0xb,%eax
    1507:	cd 40                	int    $0x40
    1509:	c3                   	ret    

0000150a <sbrk>:
SYSCALL(sbrk)
    150a:	b8 0c 00 00 00       	mov    $0xc,%eax
    150f:	cd 40                	int    $0x40
    1511:	c3                   	ret    

00001512 <sleep>:
SYSCALL(sleep)
    1512:	b8 0d 00 00 00       	mov    $0xd,%eax
    1517:	cd 40                	int    $0x40
    1519:	c3                   	ret    

0000151a <uptime>:
SYSCALL(uptime)
    151a:	b8 0e 00 00 00       	mov    $0xe,%eax
    151f:	cd 40                	int    $0x40
    1521:	c3                   	ret    

00001522 <settickets>:
SYSCALL(settickets)
    1522:	b8 16 00 00 00       	mov    $0x16,%eax
    1527:	cd 40                	int    $0x40
    1529:	c3                   	ret    

0000152a <getpinfo>:
SYSCALL(getpinfo)
    152a:	b8 17 00 00 00       	mov    $0x17,%eax
    152f:	cd 40                	int    $0x40
    1531:	c3                   	ret    

00001532 <mprotect>:
SYSCALL(mprotect)
    1532:	b8 18 00 00 00       	mov    $0x18,%eax
    1537:	cd 40                	int    $0x40
    1539:	c3                   	ret    

0000153a <munprotect>:
    153a:	b8 19 00 00 00       	mov    $0x19,%eax
    153f:	cd 40                	int    $0x40
    1541:	c3                   	ret    

00001542 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1542:	55                   	push   %ebp
    1543:	89 e5                	mov    %esp,%ebp
    1545:	83 ec 1c             	sub    $0x1c,%esp
    1548:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    154b:	6a 01                	push   $0x1
    154d:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1550:	52                   	push   %edx
    1551:	50                   	push   %eax
    1552:	e8 4b ff ff ff       	call   14a2 <write>
}
    1557:	83 c4 10             	add    $0x10,%esp
    155a:	c9                   	leave  
    155b:	c3                   	ret    

0000155c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    155c:	55                   	push   %ebp
    155d:	89 e5                	mov    %esp,%ebp
    155f:	57                   	push   %edi
    1560:	56                   	push   %esi
    1561:	53                   	push   %ebx
    1562:	83 ec 2c             	sub    $0x2c,%esp
    1565:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1568:	89 d0                	mov    %edx,%eax
    156a:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    156c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1570:	0f 95 c1             	setne  %cl
    1573:	c1 ea 1f             	shr    $0x1f,%edx
    1576:	84 d1                	test   %dl,%cl
    1578:	74 44                	je     15be <printint+0x62>
    neg = 1;
    x = -xx;
    157a:	f7 d8                	neg    %eax
    157c:	89 c1                	mov    %eax,%ecx
    neg = 1;
    157e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1585:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    158a:	89 c8                	mov    %ecx,%eax
    158c:	ba 00 00 00 00       	mov    $0x0,%edx
    1591:	f7 f6                	div    %esi
    1593:	89 df                	mov    %ebx,%edi
    1595:	83 c3 01             	add    $0x1,%ebx
    1598:	0f b6 92 c0 19 00 00 	movzbl 0x19c0(%edx),%edx
    159f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    15a3:	89 ca                	mov    %ecx,%edx
    15a5:	89 c1                	mov    %eax,%ecx
    15a7:	39 d6                	cmp    %edx,%esi
    15a9:	76 df                	jbe    158a <printint+0x2e>
  if(neg)
    15ab:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    15af:	74 31                	je     15e2 <printint+0x86>
    buf[i++] = '-';
    15b1:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    15b6:	8d 5f 02             	lea    0x2(%edi),%ebx
    15b9:	8b 75 d0             	mov    -0x30(%ebp),%esi
    15bc:	eb 17                	jmp    15d5 <printint+0x79>
    x = xx;
    15be:	89 c1                	mov    %eax,%ecx
  neg = 0;
    15c0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    15c7:	eb bc                	jmp    1585 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    15c9:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    15ce:	89 f0                	mov    %esi,%eax
    15d0:	e8 6d ff ff ff       	call   1542 <putc>
  while(--i >= 0)
    15d5:	83 eb 01             	sub    $0x1,%ebx
    15d8:	79 ef                	jns    15c9 <printint+0x6d>
}
    15da:	83 c4 2c             	add    $0x2c,%esp
    15dd:	5b                   	pop    %ebx
    15de:	5e                   	pop    %esi
    15df:	5f                   	pop    %edi
    15e0:	5d                   	pop    %ebp
    15e1:	c3                   	ret    
    15e2:	8b 75 d0             	mov    -0x30(%ebp),%esi
    15e5:	eb ee                	jmp    15d5 <printint+0x79>

000015e7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15e7:	55                   	push   %ebp
    15e8:	89 e5                	mov    %esp,%ebp
    15ea:	57                   	push   %edi
    15eb:	56                   	push   %esi
    15ec:	53                   	push   %ebx
    15ed:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    15f0:	8d 45 10             	lea    0x10(%ebp),%eax
    15f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    15f6:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    15fb:	bb 00 00 00 00       	mov    $0x0,%ebx
    1600:	eb 14                	jmp    1616 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1602:	89 fa                	mov    %edi,%edx
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
    1607:	e8 36 ff ff ff       	call   1542 <putc>
    160c:	eb 05                	jmp    1613 <printf+0x2c>
      }
    } else if(state == '%'){
    160e:	83 fe 25             	cmp    $0x25,%esi
    1611:	74 25                	je     1638 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1613:	83 c3 01             	add    $0x1,%ebx
    1616:	8b 45 0c             	mov    0xc(%ebp),%eax
    1619:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    161d:	84 c0                	test   %al,%al
    161f:	0f 84 20 01 00 00    	je     1745 <printf+0x15e>
    c = fmt[i] & 0xff;
    1625:	0f be f8             	movsbl %al,%edi
    1628:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    162b:	85 f6                	test   %esi,%esi
    162d:	75 df                	jne    160e <printf+0x27>
      if(c == '%'){
    162f:	83 f8 25             	cmp    $0x25,%eax
    1632:	75 ce                	jne    1602 <printf+0x1b>
        state = '%';
    1634:	89 c6                	mov    %eax,%esi
    1636:	eb db                	jmp    1613 <printf+0x2c>
      if(c == 'd'){
    1638:	83 f8 25             	cmp    $0x25,%eax
    163b:	0f 84 cf 00 00 00    	je     1710 <printf+0x129>
    1641:	0f 8c dd 00 00 00    	jl     1724 <printf+0x13d>
    1647:	83 f8 78             	cmp    $0x78,%eax
    164a:	0f 8f d4 00 00 00    	jg     1724 <printf+0x13d>
    1650:	83 f8 63             	cmp    $0x63,%eax
    1653:	0f 8c cb 00 00 00    	jl     1724 <printf+0x13d>
    1659:	83 e8 63             	sub    $0x63,%eax
    165c:	83 f8 15             	cmp    $0x15,%eax
    165f:	0f 87 bf 00 00 00    	ja     1724 <printf+0x13d>
    1665:	ff 24 85 68 19 00 00 	jmp    *0x1968(,%eax,4)
        printint(fd, *ap, 10, 1);
    166c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    166f:	8b 17                	mov    (%edi),%edx
    1671:	83 ec 0c             	sub    $0xc,%esp
    1674:	6a 01                	push   $0x1
    1676:	b9 0a 00 00 00       	mov    $0xa,%ecx
    167b:	8b 45 08             	mov    0x8(%ebp),%eax
    167e:	e8 d9 fe ff ff       	call   155c <printint>
        ap++;
    1683:	83 c7 04             	add    $0x4,%edi
    1686:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1689:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    168c:	be 00 00 00 00       	mov    $0x0,%esi
    1691:	eb 80                	jmp    1613 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1693:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1696:	8b 17                	mov    (%edi),%edx
    1698:	83 ec 0c             	sub    $0xc,%esp
    169b:	6a 00                	push   $0x0
    169d:	b9 10 00 00 00       	mov    $0x10,%ecx
    16a2:	8b 45 08             	mov    0x8(%ebp),%eax
    16a5:	e8 b2 fe ff ff       	call   155c <printint>
        ap++;
    16aa:	83 c7 04             	add    $0x4,%edi
    16ad:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    16b0:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16b3:	be 00 00 00 00       	mov    $0x0,%esi
    16b8:	e9 56 ff ff ff       	jmp    1613 <printf+0x2c>
        s = (char*)*ap;
    16bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16c0:	8b 30                	mov    (%eax),%esi
        ap++;
    16c2:	83 c0 04             	add    $0x4,%eax
    16c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    16c8:	85 f6                	test   %esi,%esi
    16ca:	75 15                	jne    16e1 <printf+0xfa>
          s = "(null)";
    16cc:	be 61 19 00 00       	mov    $0x1961,%esi
    16d1:	eb 0e                	jmp    16e1 <printf+0xfa>
          putc(fd, *s);
    16d3:	0f be d2             	movsbl %dl,%edx
    16d6:	8b 45 08             	mov    0x8(%ebp),%eax
    16d9:	e8 64 fe ff ff       	call   1542 <putc>
          s++;
    16de:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    16e1:	0f b6 16             	movzbl (%esi),%edx
    16e4:	84 d2                	test   %dl,%dl
    16e6:	75 eb                	jne    16d3 <printf+0xec>
      state = 0;
    16e8:	be 00 00 00 00       	mov    $0x0,%esi
    16ed:	e9 21 ff ff ff       	jmp    1613 <printf+0x2c>
        putc(fd, *ap);
    16f2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    16f5:	0f be 17             	movsbl (%edi),%edx
    16f8:	8b 45 08             	mov    0x8(%ebp),%eax
    16fb:	e8 42 fe ff ff       	call   1542 <putc>
        ap++;
    1700:	83 c7 04             	add    $0x4,%edi
    1703:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1706:	be 00 00 00 00       	mov    $0x0,%esi
    170b:	e9 03 ff ff ff       	jmp    1613 <printf+0x2c>
        putc(fd, c);
    1710:	89 fa                	mov    %edi,%edx
    1712:	8b 45 08             	mov    0x8(%ebp),%eax
    1715:	e8 28 fe ff ff       	call   1542 <putc>
      state = 0;
    171a:	be 00 00 00 00       	mov    $0x0,%esi
    171f:	e9 ef fe ff ff       	jmp    1613 <printf+0x2c>
        putc(fd, '%');
    1724:	ba 25 00 00 00       	mov    $0x25,%edx
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	e8 11 fe ff ff       	call   1542 <putc>
        putc(fd, c);
    1731:	89 fa                	mov    %edi,%edx
    1733:	8b 45 08             	mov    0x8(%ebp),%eax
    1736:	e8 07 fe ff ff       	call   1542 <putc>
      state = 0;
    173b:	be 00 00 00 00       	mov    $0x0,%esi
    1740:	e9 ce fe ff ff       	jmp    1613 <printf+0x2c>
    }
  }
}
    1745:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1748:	5b                   	pop    %ebx
    1749:	5e                   	pop    %esi
    174a:	5f                   	pop    %edi
    174b:	5d                   	pop    %ebp
    174c:	c3                   	ret    

0000174d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    174d:	55                   	push   %ebp
    174e:	89 e5                	mov    %esp,%ebp
    1750:	57                   	push   %edi
    1751:	56                   	push   %esi
    1752:	53                   	push   %ebx
    1753:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1756:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1759:	a1 e8 1c 00 00       	mov    0x1ce8,%eax
    175e:	eb 02                	jmp    1762 <free+0x15>
    1760:	89 d0                	mov    %edx,%eax
    1762:	39 c8                	cmp    %ecx,%eax
    1764:	73 04                	jae    176a <free+0x1d>
    1766:	39 08                	cmp    %ecx,(%eax)
    1768:	77 12                	ja     177c <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    176a:	8b 10                	mov    (%eax),%edx
    176c:	39 c2                	cmp    %eax,%edx
    176e:	77 f0                	ja     1760 <free+0x13>
    1770:	39 c8                	cmp    %ecx,%eax
    1772:	72 08                	jb     177c <free+0x2f>
    1774:	39 ca                	cmp    %ecx,%edx
    1776:	77 04                	ja     177c <free+0x2f>
    1778:	89 d0                	mov    %edx,%eax
    177a:	eb e6                	jmp    1762 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    177c:	8b 73 fc             	mov    -0x4(%ebx),%esi
    177f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1782:	8b 10                	mov    (%eax),%edx
    1784:	39 d7                	cmp    %edx,%edi
    1786:	74 19                	je     17a1 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1788:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    178b:	8b 50 04             	mov    0x4(%eax),%edx
    178e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1791:	39 ce                	cmp    %ecx,%esi
    1793:	74 1b                	je     17b0 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1795:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1797:	a3 e8 1c 00 00       	mov    %eax,0x1ce8
}
    179c:	5b                   	pop    %ebx
    179d:	5e                   	pop    %esi
    179e:	5f                   	pop    %edi
    179f:	5d                   	pop    %ebp
    17a0:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    17a1:	03 72 04             	add    0x4(%edx),%esi
    17a4:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    17a7:	8b 10                	mov    (%eax),%edx
    17a9:	8b 12                	mov    (%edx),%edx
    17ab:	89 53 f8             	mov    %edx,-0x8(%ebx)
    17ae:	eb db                	jmp    178b <free+0x3e>
    p->s.size += bp->s.size;
    17b0:	03 53 fc             	add    -0x4(%ebx),%edx
    17b3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17b6:	8b 53 f8             	mov    -0x8(%ebx),%edx
    17b9:	89 10                	mov    %edx,(%eax)
    17bb:	eb da                	jmp    1797 <free+0x4a>

000017bd <morecore>:

static Header*
morecore(uint nu)
{
    17bd:	55                   	push   %ebp
    17be:	89 e5                	mov    %esp,%ebp
    17c0:	53                   	push   %ebx
    17c1:	83 ec 04             	sub    $0x4,%esp
    17c4:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    17c6:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    17cb:	77 05                	ja     17d2 <morecore+0x15>
    nu = 4096;
    17cd:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    17d2:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    17d9:	83 ec 0c             	sub    $0xc,%esp
    17dc:	50                   	push   %eax
    17dd:	e8 28 fd ff ff       	call   150a <sbrk>
  if(p == (char*)-1)
    17e2:	83 c4 10             	add    $0x10,%esp
    17e5:	83 f8 ff             	cmp    $0xffffffff,%eax
    17e8:	74 1c                	je     1806 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    17ea:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17ed:	83 c0 08             	add    $0x8,%eax
    17f0:	83 ec 0c             	sub    $0xc,%esp
    17f3:	50                   	push   %eax
    17f4:	e8 54 ff ff ff       	call   174d <free>
  return freep;
    17f9:	a1 e8 1c 00 00       	mov    0x1ce8,%eax
    17fe:	83 c4 10             	add    $0x10,%esp
}
    1801:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1804:	c9                   	leave  
    1805:	c3                   	ret    
    return 0;
    1806:	b8 00 00 00 00       	mov    $0x0,%eax
    180b:	eb f4                	jmp    1801 <morecore+0x44>

0000180d <malloc>:

void*
malloc(uint nbytes)
{
    180d:	55                   	push   %ebp
    180e:	89 e5                	mov    %esp,%ebp
    1810:	53                   	push   %ebx
    1811:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1814:	8b 45 08             	mov    0x8(%ebp),%eax
    1817:	8d 58 07             	lea    0x7(%eax),%ebx
    181a:	c1 eb 03             	shr    $0x3,%ebx
    181d:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1820:	8b 0d e8 1c 00 00    	mov    0x1ce8,%ecx
    1826:	85 c9                	test   %ecx,%ecx
    1828:	74 04                	je     182e <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    182a:	8b 01                	mov    (%ecx),%eax
    182c:	eb 4a                	jmp    1878 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    182e:	c7 05 e8 1c 00 00 ec 	movl   $0x1cec,0x1ce8
    1835:	1c 00 00 
    1838:	c7 05 ec 1c 00 00 ec 	movl   $0x1cec,0x1cec
    183f:	1c 00 00 
    base.s.size = 0;
    1842:	c7 05 f0 1c 00 00 00 	movl   $0x0,0x1cf0
    1849:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    184c:	b9 ec 1c 00 00       	mov    $0x1cec,%ecx
    1851:	eb d7                	jmp    182a <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1853:	74 19                	je     186e <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1855:	29 da                	sub    %ebx,%edx
    1857:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    185a:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    185d:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1860:	89 0d e8 1c 00 00    	mov    %ecx,0x1ce8
      return (void*)(p + 1);
    1866:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1869:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    186c:	c9                   	leave  
    186d:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    186e:	8b 10                	mov    (%eax),%edx
    1870:	89 11                	mov    %edx,(%ecx)
    1872:	eb ec                	jmp    1860 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1874:	89 c1                	mov    %eax,%ecx
    1876:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1878:	8b 50 04             	mov    0x4(%eax),%edx
    187b:	39 da                	cmp    %ebx,%edx
    187d:	73 d4                	jae    1853 <malloc+0x46>
    if(p == freep)
    187f:	39 05 e8 1c 00 00    	cmp    %eax,0x1ce8
    1885:	75 ed                	jne    1874 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1887:	89 d8                	mov    %ebx,%eax
    1889:	e8 2f ff ff ff       	call   17bd <morecore>
    188e:	85 c0                	test   %eax,%eax
    1890:	75 e2                	jne    1874 <malloc+0x67>
    1892:	eb d5                	jmp    1869 <malloc+0x5c>
