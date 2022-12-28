
_grep:     file format elf32-i386


Disassembly of section .text:

00001000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	83 ec 0c             	sub    $0xc,%esp
    1009:	8b 75 08             	mov    0x8(%ebp),%esi
    100c:	8b 7d 0c             	mov    0xc(%ebp),%edi
    100f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    1012:	83 ec 08             	sub    $0x8,%esp
    1015:	53                   	push   %ebx
    1016:	57                   	push   %edi
    1017:	e8 2c 00 00 00       	call   1048 <matchhere>
    101c:	83 c4 10             	add    $0x10,%esp
    101f:	85 c0                	test   %eax,%eax
    1021:	75 18                	jne    103b <matchstar+0x3b>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
    1023:	0f b6 13             	movzbl (%ebx),%edx
    1026:	84 d2                	test   %dl,%dl
    1028:	74 16                	je     1040 <matchstar+0x40>
    102a:	83 c3 01             	add    $0x1,%ebx
    102d:	0f be d2             	movsbl %dl,%edx
    1030:	39 f2                	cmp    %esi,%edx
    1032:	74 de                	je     1012 <matchstar+0x12>
    1034:	83 fe 2e             	cmp    $0x2e,%esi
    1037:	74 d9                	je     1012 <matchstar+0x12>
    1039:	eb 05                	jmp    1040 <matchstar+0x40>
      return 1;
    103b:	b8 01 00 00 00       	mov    $0x1,%eax
  return 0;
}
    1040:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1043:	5b                   	pop    %ebx
    1044:	5e                   	pop    %esi
    1045:	5f                   	pop    %edi
    1046:	5d                   	pop    %ebp
    1047:	c3                   	ret    

00001048 <matchhere>:
{
    1048:	55                   	push   %ebp
    1049:	89 e5                	mov    %esp,%ebp
    104b:	83 ec 08             	sub    $0x8,%esp
    104e:	8b 55 08             	mov    0x8(%ebp),%edx
  if(re[0] == '\0')
    1051:	0f b6 02             	movzbl (%edx),%eax
    1054:	84 c0                	test   %al,%al
    1056:	74 68                	je     10c0 <matchhere+0x78>
  if(re[1] == '*')
    1058:	0f b6 4a 01          	movzbl 0x1(%edx),%ecx
    105c:	80 f9 2a             	cmp    $0x2a,%cl
    105f:	74 1d                	je     107e <matchhere+0x36>
  if(re[0] == '$' && re[1] == '\0')
    1061:	3c 24                	cmp    $0x24,%al
    1063:	74 31                	je     1096 <matchhere+0x4e>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    1065:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1068:	0f b6 09             	movzbl (%ecx),%ecx
    106b:	84 c9                	test   %cl,%cl
    106d:	74 58                	je     10c7 <matchhere+0x7f>
    106f:	3c 2e                	cmp    $0x2e,%al
    1071:	74 35                	je     10a8 <matchhere+0x60>
    1073:	38 c8                	cmp    %cl,%al
    1075:	74 31                	je     10a8 <matchhere+0x60>
  return 0;
    1077:	b8 00 00 00 00       	mov    $0x0,%eax
    107c:	eb 47                	jmp    10c5 <matchhere+0x7d>
    return matchstar(re[0], re+2, text);
    107e:	83 ec 04             	sub    $0x4,%esp
    1081:	ff 75 0c             	push   0xc(%ebp)
    1084:	83 c2 02             	add    $0x2,%edx
    1087:	52                   	push   %edx
    1088:	0f be c0             	movsbl %al,%eax
    108b:	50                   	push   %eax
    108c:	e8 6f ff ff ff       	call   1000 <matchstar>
    1091:	83 c4 10             	add    $0x10,%esp
    1094:	eb 2f                	jmp    10c5 <matchhere+0x7d>
  if(re[0] == '$' && re[1] == '\0')
    1096:	84 c9                	test   %cl,%cl
    1098:	75 cb                	jne    1065 <matchhere+0x1d>
    return *text == '\0';
    109a:	8b 45 0c             	mov    0xc(%ebp),%eax
    109d:	80 38 00             	cmpb   $0x0,(%eax)
    10a0:	0f 94 c0             	sete   %al
    10a3:	0f b6 c0             	movzbl %al,%eax
    10a6:	eb 1d                	jmp    10c5 <matchhere+0x7d>
    return matchhere(re+1, text+1);
    10a8:	83 ec 08             	sub    $0x8,%esp
    10ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ae:	83 c0 01             	add    $0x1,%eax
    10b1:	50                   	push   %eax
    10b2:	83 c2 01             	add    $0x1,%edx
    10b5:	52                   	push   %edx
    10b6:	e8 8d ff ff ff       	call   1048 <matchhere>
    10bb:	83 c4 10             	add    $0x10,%esp
    10be:	eb 05                	jmp    10c5 <matchhere+0x7d>
    return 1;
    10c0:	b8 01 00 00 00       	mov    $0x1,%eax
}
    10c5:	c9                   	leave  
    10c6:	c3                   	ret    
  return 0;
    10c7:	b8 00 00 00 00       	mov    $0x0,%eax
    10cc:	eb f7                	jmp    10c5 <matchhere+0x7d>

000010ce <match>:
{
    10ce:	55                   	push   %ebp
    10cf:	89 e5                	mov    %esp,%ebp
    10d1:	56                   	push   %esi
    10d2:	53                   	push   %ebx
    10d3:	8b 75 08             	mov    0x8(%ebp),%esi
    10d6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
    10d9:	80 3e 5e             	cmpb   $0x5e,(%esi)
    10dc:	75 14                	jne    10f2 <match+0x24>
    return matchhere(re+1, text);
    10de:	83 ec 08             	sub    $0x8,%esp
    10e1:	53                   	push   %ebx
    10e2:	83 c6 01             	add    $0x1,%esi
    10e5:	56                   	push   %esi
    10e6:	e8 5d ff ff ff       	call   1048 <matchhere>
    10eb:	83 c4 10             	add    $0x10,%esp
    10ee:	eb 22                	jmp    1112 <match+0x44>
  }while(*text++ != '\0');
    10f0:	89 d3                	mov    %edx,%ebx
    if(matchhere(re, text))
    10f2:	83 ec 08             	sub    $0x8,%esp
    10f5:	53                   	push   %ebx
    10f6:	56                   	push   %esi
    10f7:	e8 4c ff ff ff       	call   1048 <matchhere>
    10fc:	83 c4 10             	add    $0x10,%esp
    10ff:	85 c0                	test   %eax,%eax
    1101:	75 0a                	jne    110d <match+0x3f>
  }while(*text++ != '\0');
    1103:	8d 53 01             	lea    0x1(%ebx),%edx
    1106:	80 3b 00             	cmpb   $0x0,(%ebx)
    1109:	75 e5                	jne    10f0 <match+0x22>
    110b:	eb 05                	jmp    1112 <match+0x44>
      return 1;
    110d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1112:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1115:	5b                   	pop    %ebx
    1116:	5e                   	pop    %esi
    1117:	5d                   	pop    %ebp
    1118:	c3                   	ret    

00001119 <grep>:
{
    1119:	55                   	push   %ebp
    111a:	89 e5                	mov    %esp,%ebp
    111c:	57                   	push   %edi
    111d:	56                   	push   %esi
    111e:	53                   	push   %ebx
    111f:	83 ec 1c             	sub    $0x1c,%esp
    1122:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
    1125:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    112c:	eb 53                	jmp    1181 <grep+0x68>
      p = q+1;
    112e:	8d 73 01             	lea    0x1(%ebx),%esi
    while((q = strchr(p, '\n')) != 0){
    1131:	83 ec 08             	sub    $0x8,%esp
    1134:	6a 0a                	push   $0xa
    1136:	56                   	push   %esi
    1137:	e8 e1 01 00 00       	call   131d <strchr>
    113c:	89 c3                	mov    %eax,%ebx
    113e:	83 c4 10             	add    $0x10,%esp
    1141:	85 c0                	test   %eax,%eax
    1143:	74 2d                	je     1172 <grep+0x59>
      *q = 0;
    1145:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
    1148:	83 ec 08             	sub    $0x8,%esp
    114b:	56                   	push   %esi
    114c:	57                   	push   %edi
    114d:	e8 7c ff ff ff       	call   10ce <match>
    1152:	83 c4 10             	add    $0x10,%esp
    1155:	85 c0                	test   %eax,%eax
    1157:	74 d5                	je     112e <grep+0x15>
        *q = '\n';
    1159:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
    115c:	8d 43 01             	lea    0x1(%ebx),%eax
    115f:	83 ec 04             	sub    $0x4,%esp
    1162:	29 f0                	sub    %esi,%eax
    1164:	50                   	push   %eax
    1165:	56                   	push   %esi
    1166:	6a 01                	push   $0x1
    1168:	e8 f2 02 00 00       	call   145f <write>
    116d:	83 c4 10             	add    $0x10,%esp
    1170:	eb bc                	jmp    112e <grep+0x15>
    if(p == buf)
    1172:	81 fe 40 1c 00 00    	cmp    $0x1c40,%esi
    1178:	74 62                	je     11dc <grep+0xc3>
    if(m > 0){
    117a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    117d:	85 c9                	test   %ecx,%ecx
    117f:	7f 3b                	jg     11bc <grep+0xa3>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1181:	b8 ff 03 00 00       	mov    $0x3ff,%eax
    1186:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1189:	29 c8                	sub    %ecx,%eax
    118b:	83 ec 04             	sub    $0x4,%esp
    118e:	50                   	push   %eax
    118f:	8d 81 40 1c 00 00    	lea    0x1c40(%ecx),%eax
    1195:	50                   	push   %eax
    1196:	ff 75 0c             	push   0xc(%ebp)
    1199:	e8 b9 02 00 00       	call   1457 <read>
    119e:	83 c4 10             	add    $0x10,%esp
    11a1:	85 c0                	test   %eax,%eax
    11a3:	7e 40                	jle    11e5 <grep+0xcc>
    m += n;
    11a5:	01 45 e4             	add    %eax,-0x1c(%ebp)
    11a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
    11ab:	c6 82 40 1c 00 00 00 	movb   $0x0,0x1c40(%edx)
    p = buf;
    11b2:	be 40 1c 00 00       	mov    $0x1c40,%esi
    while((q = strchr(p, '\n')) != 0){
    11b7:	e9 75 ff ff ff       	jmp    1131 <grep+0x18>
      m -= p - buf;
    11bc:	89 f0                	mov    %esi,%eax
    11be:	2d 40 1c 00 00       	sub    $0x1c40,%eax
    11c3:	29 c1                	sub    %eax,%ecx
    11c5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      memmove(buf, p, m);
    11c8:	83 ec 04             	sub    $0x4,%esp
    11cb:	51                   	push   %ecx
    11cc:	56                   	push   %esi
    11cd:	68 40 1c 00 00       	push   $0x1c40
    11d2:	e8 34 02 00 00       	call   140b <memmove>
    11d7:	83 c4 10             	add    $0x10,%esp
    11da:	eb a5                	jmp    1181 <grep+0x68>
      m = 0;
    11dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    11e3:	eb 9c                	jmp    1181 <grep+0x68>
}
    11e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11e8:	5b                   	pop    %ebx
    11e9:	5e                   	pop    %esi
    11ea:	5f                   	pop    %edi
    11eb:	5d                   	pop    %ebp
    11ec:	c3                   	ret    

000011ed <main>:
{
    11ed:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    11f1:	83 e4 f0             	and    $0xfffffff0,%esp
    11f4:	ff 71 fc             	push   -0x4(%ecx)
    11f7:	55                   	push   %ebp
    11f8:	89 e5                	mov    %esp,%ebp
    11fa:	57                   	push   %edi
    11fb:	56                   	push   %esi
    11fc:	53                   	push   %ebx
    11fd:	51                   	push   %ecx
    11fe:	83 ec 18             	sub    $0x18,%esp
    1201:	8b 01                	mov    (%ecx),%eax
    1203:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1206:	8b 51 04             	mov    0x4(%ecx),%edx
    1209:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(argc <= 1){
    120c:	83 f8 01             	cmp    $0x1,%eax
    120f:	7e 50                	jle    1261 <main+0x74>
  pattern = argv[1];
    1211:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1214:	8b 40 04             	mov    0x4(%eax),%eax
    1217:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(argc <= 2){
    121a:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    121e:	7e 55                	jle    1275 <main+0x88>
  for(i = 2; i < argc; i++){
    1220:	be 02 00 00 00       	mov    $0x2,%esi
    1225:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
    1228:	7d 71                	jge    129b <main+0xae>
    if((fd = open(argv[i], 0)) < 0){
    122a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    122d:	8d 3c b0             	lea    (%eax,%esi,4),%edi
    1230:	83 ec 08             	sub    $0x8,%esp
    1233:	6a 00                	push   $0x0
    1235:	ff 37                	push   (%edi)
    1237:	e8 43 02 00 00       	call   147f <open>
    123c:	89 c3                	mov    %eax,%ebx
    123e:	83 c4 10             	add    $0x10,%esp
    1241:	85 c0                	test   %eax,%eax
    1243:	78 40                	js     1285 <main+0x98>
    grep(pattern, fd);
    1245:	83 ec 08             	sub    $0x8,%esp
    1248:	50                   	push   %eax
    1249:	ff 75 dc             	push   -0x24(%ebp)
    124c:	e8 c8 fe ff ff       	call   1119 <grep>
    close(fd);
    1251:	89 1c 24             	mov    %ebx,(%esp)
    1254:	e8 0e 02 00 00       	call   1467 <close>
  for(i = 2; i < argc; i++){
    1259:	83 c6 01             	add    $0x1,%esi
    125c:	83 c4 10             	add    $0x10,%esp
    125f:	eb c4                	jmp    1225 <main+0x38>
    printf(2, "usage: grep pattern [file ...]\n");
    1261:	83 ec 08             	sub    $0x8,%esp
    1264:	68 54 18 00 00       	push   $0x1854
    1269:	6a 02                	push   $0x2
    126b:	e8 34 03 00 00       	call   15a4 <printf>
    exit();
    1270:	e8 ca 01 00 00       	call   143f <exit>
    grep(pattern, 0);
    1275:	83 ec 08             	sub    $0x8,%esp
    1278:	6a 00                	push   $0x0
    127a:	50                   	push   %eax
    127b:	e8 99 fe ff ff       	call   1119 <grep>
    exit();
    1280:	e8 ba 01 00 00       	call   143f <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
    1285:	83 ec 04             	sub    $0x4,%esp
    1288:	ff 37                	push   (%edi)
    128a:	68 74 18 00 00       	push   $0x1874
    128f:	6a 01                	push   $0x1
    1291:	e8 0e 03 00 00       	call   15a4 <printf>
      exit();
    1296:	e8 a4 01 00 00       	call   143f <exit>
  exit();
    129b:	e8 9f 01 00 00       	call   143f <exit>

000012a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	56                   	push   %esi
    12a4:	53                   	push   %ebx
    12a5:	8b 75 08             	mov    0x8(%ebp),%esi
    12a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    12ab:	89 f0                	mov    %esi,%eax
    12ad:	89 d1                	mov    %edx,%ecx
    12af:	83 c2 01             	add    $0x1,%edx
    12b2:	89 c3                	mov    %eax,%ebx
    12b4:	83 c0 01             	add    $0x1,%eax
    12b7:	0f b6 09             	movzbl (%ecx),%ecx
    12ba:	88 0b                	mov    %cl,(%ebx)
    12bc:	84 c9                	test   %cl,%cl
    12be:	75 ed                	jne    12ad <strcpy+0xd>
    ;
  return os;
}
    12c0:	89 f0                	mov    %esi,%eax
    12c2:	5b                   	pop    %ebx
    12c3:	5e                   	pop    %esi
    12c4:	5d                   	pop    %ebp
    12c5:	c3                   	ret    

000012c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12c6:	55                   	push   %ebp
    12c7:	89 e5                	mov    %esp,%ebp
    12c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    12cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    12cf:	eb 06                	jmp    12d7 <strcmp+0x11>
    p++, q++;
    12d1:	83 c1 01             	add    $0x1,%ecx
    12d4:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    12d7:	0f b6 01             	movzbl (%ecx),%eax
    12da:	84 c0                	test   %al,%al
    12dc:	74 04                	je     12e2 <strcmp+0x1c>
    12de:	3a 02                	cmp    (%edx),%al
    12e0:	74 ef                	je     12d1 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    12e2:	0f b6 c0             	movzbl %al,%eax
    12e5:	0f b6 12             	movzbl (%edx),%edx
    12e8:	29 d0                	sub    %edx,%eax
}
    12ea:	5d                   	pop    %ebp
    12eb:	c3                   	ret    

000012ec <strlen>:

uint
strlen(const char *s)
{
    12ec:	55                   	push   %ebp
    12ed:	89 e5                	mov    %esp,%ebp
    12ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    12f2:	b8 00 00 00 00       	mov    $0x0,%eax
    12f7:	eb 03                	jmp    12fc <strlen+0x10>
    12f9:	83 c0 01             	add    $0x1,%eax
    12fc:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    1300:	75 f7                	jne    12f9 <strlen+0xd>
    ;
  return n;
}
    1302:	5d                   	pop    %ebp
    1303:	c3                   	ret    

00001304 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1304:	55                   	push   %ebp
    1305:	89 e5                	mov    %esp,%ebp
    1307:	57                   	push   %edi
    1308:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    130b:	89 d7                	mov    %edx,%edi
    130d:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1310:	8b 45 0c             	mov    0xc(%ebp),%eax
    1313:	fc                   	cld    
    1314:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1316:	89 d0                	mov    %edx,%eax
    1318:	8b 7d fc             	mov    -0x4(%ebp),%edi
    131b:	c9                   	leave  
    131c:	c3                   	ret    

0000131d <strchr>:

char*
strchr(const char *s, char c)
{
    131d:	55                   	push   %ebp
    131e:	89 e5                	mov    %esp,%ebp
    1320:	8b 45 08             	mov    0x8(%ebp),%eax
    1323:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1327:	eb 03                	jmp    132c <strchr+0xf>
    1329:	83 c0 01             	add    $0x1,%eax
    132c:	0f b6 10             	movzbl (%eax),%edx
    132f:	84 d2                	test   %dl,%dl
    1331:	74 06                	je     1339 <strchr+0x1c>
    if(*s == c)
    1333:	38 ca                	cmp    %cl,%dl
    1335:	75 f2                	jne    1329 <strchr+0xc>
    1337:	eb 05                	jmp    133e <strchr+0x21>
      return (char*)s;
  return 0;
    1339:	b8 00 00 00 00       	mov    $0x0,%eax
}
    133e:	5d                   	pop    %ebp
    133f:	c3                   	ret    

00001340 <gets>:

char*
gets(char *buf, int max)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	57                   	push   %edi
    1344:	56                   	push   %esi
    1345:	53                   	push   %ebx
    1346:	83 ec 1c             	sub    $0x1c,%esp
    1349:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    134c:	bb 00 00 00 00       	mov    $0x0,%ebx
    1351:	89 de                	mov    %ebx,%esi
    1353:	83 c3 01             	add    $0x1,%ebx
    1356:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1359:	7d 2e                	jge    1389 <gets+0x49>
    cc = read(0, &c, 1);
    135b:	83 ec 04             	sub    $0x4,%esp
    135e:	6a 01                	push   $0x1
    1360:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1363:	50                   	push   %eax
    1364:	6a 00                	push   $0x0
    1366:	e8 ec 00 00 00       	call   1457 <read>
    if(cc < 1)
    136b:	83 c4 10             	add    $0x10,%esp
    136e:	85 c0                	test   %eax,%eax
    1370:	7e 17                	jle    1389 <gets+0x49>
      break;
    buf[i++] = c;
    1372:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1376:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1379:	3c 0a                	cmp    $0xa,%al
    137b:	0f 94 c2             	sete   %dl
    137e:	3c 0d                	cmp    $0xd,%al
    1380:	0f 94 c0             	sete   %al
    1383:	08 c2                	or     %al,%dl
    1385:	74 ca                	je     1351 <gets+0x11>
    buf[i++] = c;
    1387:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1389:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    138d:	89 f8                	mov    %edi,%eax
    138f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1392:	5b                   	pop    %ebx
    1393:	5e                   	pop    %esi
    1394:	5f                   	pop    %edi
    1395:	5d                   	pop    %ebp
    1396:	c3                   	ret    

00001397 <stat>:

int
stat(const char *n, struct stat *st)
{
    1397:	55                   	push   %ebp
    1398:	89 e5                	mov    %esp,%ebp
    139a:	56                   	push   %esi
    139b:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    139c:	83 ec 08             	sub    $0x8,%esp
    139f:	6a 00                	push   $0x0
    13a1:	ff 75 08             	push   0x8(%ebp)
    13a4:	e8 d6 00 00 00       	call   147f <open>
  if(fd < 0)
    13a9:	83 c4 10             	add    $0x10,%esp
    13ac:	85 c0                	test   %eax,%eax
    13ae:	78 24                	js     13d4 <stat+0x3d>
    13b0:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    13b2:	83 ec 08             	sub    $0x8,%esp
    13b5:	ff 75 0c             	push   0xc(%ebp)
    13b8:	50                   	push   %eax
    13b9:	e8 d9 00 00 00       	call   1497 <fstat>
    13be:	89 c6                	mov    %eax,%esi
  close(fd);
    13c0:	89 1c 24             	mov    %ebx,(%esp)
    13c3:	e8 9f 00 00 00       	call   1467 <close>
  return r;
    13c8:	83 c4 10             	add    $0x10,%esp
}
    13cb:	89 f0                	mov    %esi,%eax
    13cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
    13d0:	5b                   	pop    %ebx
    13d1:	5e                   	pop    %esi
    13d2:	5d                   	pop    %ebp
    13d3:	c3                   	ret    
    return -1;
    13d4:	be ff ff ff ff       	mov    $0xffffffff,%esi
    13d9:	eb f0                	jmp    13cb <stat+0x34>

000013db <atoi>:

int
atoi(const char *s)
{
    13db:	55                   	push   %ebp
    13dc:	89 e5                	mov    %esp,%ebp
    13de:	53                   	push   %ebx
    13df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    13e2:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    13e7:	eb 10                	jmp    13f9 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    13e9:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    13ec:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    13ef:	83 c1 01             	add    $0x1,%ecx
    13f2:	0f be c0             	movsbl %al,%eax
    13f5:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    13f9:	0f b6 01             	movzbl (%ecx),%eax
    13fc:	8d 58 d0             	lea    -0x30(%eax),%ebx
    13ff:	80 fb 09             	cmp    $0x9,%bl
    1402:	76 e5                	jbe    13e9 <atoi+0xe>
  return n;
}
    1404:	89 d0                	mov    %edx,%eax
    1406:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1409:	c9                   	leave  
    140a:	c3                   	ret    

0000140b <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    140b:	55                   	push   %ebp
    140c:	89 e5                	mov    %esp,%ebp
    140e:	56                   	push   %esi
    140f:	53                   	push   %ebx
    1410:	8b 75 08             	mov    0x8(%ebp),%esi
    1413:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1416:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1419:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    141b:	eb 0d                	jmp    142a <memmove+0x1f>
    *dst++ = *src++;
    141d:	0f b6 01             	movzbl (%ecx),%eax
    1420:	88 02                	mov    %al,(%edx)
    1422:	8d 49 01             	lea    0x1(%ecx),%ecx
    1425:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1428:	89 d8                	mov    %ebx,%eax
    142a:	8d 58 ff             	lea    -0x1(%eax),%ebx
    142d:	85 c0                	test   %eax,%eax
    142f:	7f ec                	jg     141d <memmove+0x12>
  return vdst;
}
    1431:	89 f0                	mov    %esi,%eax
    1433:	5b                   	pop    %ebx
    1434:	5e                   	pop    %esi
    1435:	5d                   	pop    %ebp
    1436:	c3                   	ret    

00001437 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1437:	b8 01 00 00 00       	mov    $0x1,%eax
    143c:	cd 40                	int    $0x40
    143e:	c3                   	ret    

0000143f <exit>:
SYSCALL(exit)
    143f:	b8 02 00 00 00       	mov    $0x2,%eax
    1444:	cd 40                	int    $0x40
    1446:	c3                   	ret    

00001447 <wait>:
SYSCALL(wait)
    1447:	b8 03 00 00 00       	mov    $0x3,%eax
    144c:	cd 40                	int    $0x40
    144e:	c3                   	ret    

0000144f <pipe>:
SYSCALL(pipe)
    144f:	b8 04 00 00 00       	mov    $0x4,%eax
    1454:	cd 40                	int    $0x40
    1456:	c3                   	ret    

00001457 <read>:
SYSCALL(read)
    1457:	b8 05 00 00 00       	mov    $0x5,%eax
    145c:	cd 40                	int    $0x40
    145e:	c3                   	ret    

0000145f <write>:
SYSCALL(write)
    145f:	b8 10 00 00 00       	mov    $0x10,%eax
    1464:	cd 40                	int    $0x40
    1466:	c3                   	ret    

00001467 <close>:
SYSCALL(close)
    1467:	b8 15 00 00 00       	mov    $0x15,%eax
    146c:	cd 40                	int    $0x40
    146e:	c3                   	ret    

0000146f <kill>:
SYSCALL(kill)
    146f:	b8 06 00 00 00       	mov    $0x6,%eax
    1474:	cd 40                	int    $0x40
    1476:	c3                   	ret    

00001477 <exec>:
SYSCALL(exec)
    1477:	b8 07 00 00 00       	mov    $0x7,%eax
    147c:	cd 40                	int    $0x40
    147e:	c3                   	ret    

0000147f <open>:
SYSCALL(open)
    147f:	b8 0f 00 00 00       	mov    $0xf,%eax
    1484:	cd 40                	int    $0x40
    1486:	c3                   	ret    

00001487 <mknod>:
SYSCALL(mknod)
    1487:	b8 11 00 00 00       	mov    $0x11,%eax
    148c:	cd 40                	int    $0x40
    148e:	c3                   	ret    

0000148f <unlink>:
SYSCALL(unlink)
    148f:	b8 12 00 00 00       	mov    $0x12,%eax
    1494:	cd 40                	int    $0x40
    1496:	c3                   	ret    

00001497 <fstat>:
SYSCALL(fstat)
    1497:	b8 08 00 00 00       	mov    $0x8,%eax
    149c:	cd 40                	int    $0x40
    149e:	c3                   	ret    

0000149f <link>:
SYSCALL(link)
    149f:	b8 13 00 00 00       	mov    $0x13,%eax
    14a4:	cd 40                	int    $0x40
    14a6:	c3                   	ret    

000014a7 <mkdir>:
SYSCALL(mkdir)
    14a7:	b8 14 00 00 00       	mov    $0x14,%eax
    14ac:	cd 40                	int    $0x40
    14ae:	c3                   	ret    

000014af <chdir>:
SYSCALL(chdir)
    14af:	b8 09 00 00 00       	mov    $0x9,%eax
    14b4:	cd 40                	int    $0x40
    14b6:	c3                   	ret    

000014b7 <dup>:
SYSCALL(dup)
    14b7:	b8 0a 00 00 00       	mov    $0xa,%eax
    14bc:	cd 40                	int    $0x40
    14be:	c3                   	ret    

000014bf <getpid>:
SYSCALL(getpid)
    14bf:	b8 0b 00 00 00       	mov    $0xb,%eax
    14c4:	cd 40                	int    $0x40
    14c6:	c3                   	ret    

000014c7 <sbrk>:
SYSCALL(sbrk)
    14c7:	b8 0c 00 00 00       	mov    $0xc,%eax
    14cc:	cd 40                	int    $0x40
    14ce:	c3                   	ret    

000014cf <sleep>:
SYSCALL(sleep)
    14cf:	b8 0d 00 00 00       	mov    $0xd,%eax
    14d4:	cd 40                	int    $0x40
    14d6:	c3                   	ret    

000014d7 <uptime>:
SYSCALL(uptime)
    14d7:	b8 0e 00 00 00       	mov    $0xe,%eax
    14dc:	cd 40                	int    $0x40
    14de:	c3                   	ret    

000014df <settickets>:
SYSCALL(settickets)
    14df:	b8 16 00 00 00       	mov    $0x16,%eax
    14e4:	cd 40                	int    $0x40
    14e6:	c3                   	ret    

000014e7 <getpinfo>:
SYSCALL(getpinfo)
    14e7:	b8 17 00 00 00       	mov    $0x17,%eax
    14ec:	cd 40                	int    $0x40
    14ee:	c3                   	ret    

000014ef <mprotect>:
SYSCALL(mprotect)
    14ef:	b8 18 00 00 00       	mov    $0x18,%eax
    14f4:	cd 40                	int    $0x40
    14f6:	c3                   	ret    

000014f7 <munprotect>:
    14f7:	b8 19 00 00 00       	mov    $0x19,%eax
    14fc:	cd 40                	int    $0x40
    14fe:	c3                   	ret    

000014ff <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14ff:	55                   	push   %ebp
    1500:	89 e5                	mov    %esp,%ebp
    1502:	83 ec 1c             	sub    $0x1c,%esp
    1505:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1508:	6a 01                	push   $0x1
    150a:	8d 55 f4             	lea    -0xc(%ebp),%edx
    150d:	52                   	push   %edx
    150e:	50                   	push   %eax
    150f:	e8 4b ff ff ff       	call   145f <write>
}
    1514:	83 c4 10             	add    $0x10,%esp
    1517:	c9                   	leave  
    1518:	c3                   	ret    

00001519 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1519:	55                   	push   %ebp
    151a:	89 e5                	mov    %esp,%ebp
    151c:	57                   	push   %edi
    151d:	56                   	push   %esi
    151e:	53                   	push   %ebx
    151f:	83 ec 2c             	sub    $0x2c,%esp
    1522:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1525:	89 d0                	mov    %edx,%eax
    1527:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1529:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    152d:	0f 95 c1             	setne  %cl
    1530:	c1 ea 1f             	shr    $0x1f,%edx
    1533:	84 d1                	test   %dl,%cl
    1535:	74 44                	je     157b <printint+0x62>
    neg = 1;
    x = -xx;
    1537:	f7 d8                	neg    %eax
    1539:	89 c1                	mov    %eax,%ecx
    neg = 1;
    153b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1542:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1547:	89 c8                	mov    %ecx,%eax
    1549:	ba 00 00 00 00       	mov    $0x0,%edx
    154e:	f7 f6                	div    %esi
    1550:	89 df                	mov    %ebx,%edi
    1552:	83 c3 01             	add    $0x1,%ebx
    1555:	0f b6 92 ec 18 00 00 	movzbl 0x18ec(%edx),%edx
    155c:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1560:	89 ca                	mov    %ecx,%edx
    1562:	89 c1                	mov    %eax,%ecx
    1564:	39 d6                	cmp    %edx,%esi
    1566:	76 df                	jbe    1547 <printint+0x2e>
  if(neg)
    1568:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    156c:	74 31                	je     159f <printint+0x86>
    buf[i++] = '-';
    156e:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1573:	8d 5f 02             	lea    0x2(%edi),%ebx
    1576:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1579:	eb 17                	jmp    1592 <printint+0x79>
    x = xx;
    157b:	89 c1                	mov    %eax,%ecx
  neg = 0;
    157d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1584:	eb bc                	jmp    1542 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1586:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    158b:	89 f0                	mov    %esi,%eax
    158d:	e8 6d ff ff ff       	call   14ff <putc>
  while(--i >= 0)
    1592:	83 eb 01             	sub    $0x1,%ebx
    1595:	79 ef                	jns    1586 <printint+0x6d>
}
    1597:	83 c4 2c             	add    $0x2c,%esp
    159a:	5b                   	pop    %ebx
    159b:	5e                   	pop    %esi
    159c:	5f                   	pop    %edi
    159d:	5d                   	pop    %ebp
    159e:	c3                   	ret    
    159f:	8b 75 d0             	mov    -0x30(%ebp),%esi
    15a2:	eb ee                	jmp    1592 <printint+0x79>

000015a4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15a4:	55                   	push   %ebp
    15a5:	89 e5                	mov    %esp,%ebp
    15a7:	57                   	push   %edi
    15a8:	56                   	push   %esi
    15a9:	53                   	push   %ebx
    15aa:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    15ad:	8d 45 10             	lea    0x10(%ebp),%eax
    15b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    15b3:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    15b8:	bb 00 00 00 00       	mov    $0x0,%ebx
    15bd:	eb 14                	jmp    15d3 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    15bf:	89 fa                	mov    %edi,%edx
    15c1:	8b 45 08             	mov    0x8(%ebp),%eax
    15c4:	e8 36 ff ff ff       	call   14ff <putc>
    15c9:	eb 05                	jmp    15d0 <printf+0x2c>
      }
    } else if(state == '%'){
    15cb:	83 fe 25             	cmp    $0x25,%esi
    15ce:	74 25                	je     15f5 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    15d0:	83 c3 01             	add    $0x1,%ebx
    15d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    15d6:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    15da:	84 c0                	test   %al,%al
    15dc:	0f 84 20 01 00 00    	je     1702 <printf+0x15e>
    c = fmt[i] & 0xff;
    15e2:	0f be f8             	movsbl %al,%edi
    15e5:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    15e8:	85 f6                	test   %esi,%esi
    15ea:	75 df                	jne    15cb <printf+0x27>
      if(c == '%'){
    15ec:	83 f8 25             	cmp    $0x25,%eax
    15ef:	75 ce                	jne    15bf <printf+0x1b>
        state = '%';
    15f1:	89 c6                	mov    %eax,%esi
    15f3:	eb db                	jmp    15d0 <printf+0x2c>
      if(c == 'd'){
    15f5:	83 f8 25             	cmp    $0x25,%eax
    15f8:	0f 84 cf 00 00 00    	je     16cd <printf+0x129>
    15fe:	0f 8c dd 00 00 00    	jl     16e1 <printf+0x13d>
    1604:	83 f8 78             	cmp    $0x78,%eax
    1607:	0f 8f d4 00 00 00    	jg     16e1 <printf+0x13d>
    160d:	83 f8 63             	cmp    $0x63,%eax
    1610:	0f 8c cb 00 00 00    	jl     16e1 <printf+0x13d>
    1616:	83 e8 63             	sub    $0x63,%eax
    1619:	83 f8 15             	cmp    $0x15,%eax
    161c:	0f 87 bf 00 00 00    	ja     16e1 <printf+0x13d>
    1622:	ff 24 85 94 18 00 00 	jmp    *0x1894(,%eax,4)
        printint(fd, *ap, 10, 1);
    1629:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    162c:	8b 17                	mov    (%edi),%edx
    162e:	83 ec 0c             	sub    $0xc,%esp
    1631:	6a 01                	push   $0x1
    1633:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1638:	8b 45 08             	mov    0x8(%ebp),%eax
    163b:	e8 d9 fe ff ff       	call   1519 <printint>
        ap++;
    1640:	83 c7 04             	add    $0x4,%edi
    1643:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1646:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1649:	be 00 00 00 00       	mov    $0x0,%esi
    164e:	eb 80                	jmp    15d0 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1650:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1653:	8b 17                	mov    (%edi),%edx
    1655:	83 ec 0c             	sub    $0xc,%esp
    1658:	6a 00                	push   $0x0
    165a:	b9 10 00 00 00       	mov    $0x10,%ecx
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
    1662:	e8 b2 fe ff ff       	call   1519 <printint>
        ap++;
    1667:	83 c7 04             	add    $0x4,%edi
    166a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    166d:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1670:	be 00 00 00 00       	mov    $0x0,%esi
    1675:	e9 56 ff ff ff       	jmp    15d0 <printf+0x2c>
        s = (char*)*ap;
    167a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    167d:	8b 30                	mov    (%eax),%esi
        ap++;
    167f:	83 c0 04             	add    $0x4,%eax
    1682:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1685:	85 f6                	test   %esi,%esi
    1687:	75 15                	jne    169e <printf+0xfa>
          s = "(null)";
    1689:	be 8a 18 00 00       	mov    $0x188a,%esi
    168e:	eb 0e                	jmp    169e <printf+0xfa>
          putc(fd, *s);
    1690:	0f be d2             	movsbl %dl,%edx
    1693:	8b 45 08             	mov    0x8(%ebp),%eax
    1696:	e8 64 fe ff ff       	call   14ff <putc>
          s++;
    169b:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    169e:	0f b6 16             	movzbl (%esi),%edx
    16a1:	84 d2                	test   %dl,%dl
    16a3:	75 eb                	jne    1690 <printf+0xec>
      state = 0;
    16a5:	be 00 00 00 00       	mov    $0x0,%esi
    16aa:	e9 21 ff ff ff       	jmp    15d0 <printf+0x2c>
        putc(fd, *ap);
    16af:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    16b2:	0f be 17             	movsbl (%edi),%edx
    16b5:	8b 45 08             	mov    0x8(%ebp),%eax
    16b8:	e8 42 fe ff ff       	call   14ff <putc>
        ap++;
    16bd:	83 c7 04             	add    $0x4,%edi
    16c0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    16c3:	be 00 00 00 00       	mov    $0x0,%esi
    16c8:	e9 03 ff ff ff       	jmp    15d0 <printf+0x2c>
        putc(fd, c);
    16cd:	89 fa                	mov    %edi,%edx
    16cf:	8b 45 08             	mov    0x8(%ebp),%eax
    16d2:	e8 28 fe ff ff       	call   14ff <putc>
      state = 0;
    16d7:	be 00 00 00 00       	mov    $0x0,%esi
    16dc:	e9 ef fe ff ff       	jmp    15d0 <printf+0x2c>
        putc(fd, '%');
    16e1:	ba 25 00 00 00       	mov    $0x25,%edx
    16e6:	8b 45 08             	mov    0x8(%ebp),%eax
    16e9:	e8 11 fe ff ff       	call   14ff <putc>
        putc(fd, c);
    16ee:	89 fa                	mov    %edi,%edx
    16f0:	8b 45 08             	mov    0x8(%ebp),%eax
    16f3:	e8 07 fe ff ff       	call   14ff <putc>
      state = 0;
    16f8:	be 00 00 00 00       	mov    $0x0,%esi
    16fd:	e9 ce fe ff ff       	jmp    15d0 <printf+0x2c>
    }
  }
}
    1702:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1705:	5b                   	pop    %ebx
    1706:	5e                   	pop    %esi
    1707:	5f                   	pop    %edi
    1708:	5d                   	pop    %ebp
    1709:	c3                   	ret    

0000170a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    170a:	55                   	push   %ebp
    170b:	89 e5                	mov    %esp,%ebp
    170d:	57                   	push   %edi
    170e:	56                   	push   %esi
    170f:	53                   	push   %ebx
    1710:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1713:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1716:	a1 40 20 00 00       	mov    0x2040,%eax
    171b:	eb 02                	jmp    171f <free+0x15>
    171d:	89 d0                	mov    %edx,%eax
    171f:	39 c8                	cmp    %ecx,%eax
    1721:	73 04                	jae    1727 <free+0x1d>
    1723:	39 08                	cmp    %ecx,(%eax)
    1725:	77 12                	ja     1739 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1727:	8b 10                	mov    (%eax),%edx
    1729:	39 c2                	cmp    %eax,%edx
    172b:	77 f0                	ja     171d <free+0x13>
    172d:	39 c8                	cmp    %ecx,%eax
    172f:	72 08                	jb     1739 <free+0x2f>
    1731:	39 ca                	cmp    %ecx,%edx
    1733:	77 04                	ja     1739 <free+0x2f>
    1735:	89 d0                	mov    %edx,%eax
    1737:	eb e6                	jmp    171f <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1739:	8b 73 fc             	mov    -0x4(%ebx),%esi
    173c:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    173f:	8b 10                	mov    (%eax),%edx
    1741:	39 d7                	cmp    %edx,%edi
    1743:	74 19                	je     175e <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1745:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1748:	8b 50 04             	mov    0x4(%eax),%edx
    174b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    174e:	39 ce                	cmp    %ecx,%esi
    1750:	74 1b                	je     176d <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1752:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1754:	a3 40 20 00 00       	mov    %eax,0x2040
}
    1759:	5b                   	pop    %ebx
    175a:	5e                   	pop    %esi
    175b:	5f                   	pop    %edi
    175c:	5d                   	pop    %ebp
    175d:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    175e:	03 72 04             	add    0x4(%edx),%esi
    1761:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1764:	8b 10                	mov    (%eax),%edx
    1766:	8b 12                	mov    (%edx),%edx
    1768:	89 53 f8             	mov    %edx,-0x8(%ebx)
    176b:	eb db                	jmp    1748 <free+0x3e>
    p->s.size += bp->s.size;
    176d:	03 53 fc             	add    -0x4(%ebx),%edx
    1770:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1773:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1776:	89 10                	mov    %edx,(%eax)
    1778:	eb da                	jmp    1754 <free+0x4a>

0000177a <morecore>:

static Header*
morecore(uint nu)
{
    177a:	55                   	push   %ebp
    177b:	89 e5                	mov    %esp,%ebp
    177d:	53                   	push   %ebx
    177e:	83 ec 04             	sub    $0x4,%esp
    1781:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1783:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1788:	77 05                	ja     178f <morecore+0x15>
    nu = 4096;
    178a:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    178f:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1796:	83 ec 0c             	sub    $0xc,%esp
    1799:	50                   	push   %eax
    179a:	e8 28 fd ff ff       	call   14c7 <sbrk>
  if(p == (char*)-1)
    179f:	83 c4 10             	add    $0x10,%esp
    17a2:	83 f8 ff             	cmp    $0xffffffff,%eax
    17a5:	74 1c                	je     17c3 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    17a7:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17aa:	83 c0 08             	add    $0x8,%eax
    17ad:	83 ec 0c             	sub    $0xc,%esp
    17b0:	50                   	push   %eax
    17b1:	e8 54 ff ff ff       	call   170a <free>
  return freep;
    17b6:	a1 40 20 00 00       	mov    0x2040,%eax
    17bb:	83 c4 10             	add    $0x10,%esp
}
    17be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17c1:	c9                   	leave  
    17c2:	c3                   	ret    
    return 0;
    17c3:	b8 00 00 00 00       	mov    $0x0,%eax
    17c8:	eb f4                	jmp    17be <morecore+0x44>

000017ca <malloc>:

void*
malloc(uint nbytes)
{
    17ca:	55                   	push   %ebp
    17cb:	89 e5                	mov    %esp,%ebp
    17cd:	53                   	push   %ebx
    17ce:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17d1:	8b 45 08             	mov    0x8(%ebp),%eax
    17d4:	8d 58 07             	lea    0x7(%eax),%ebx
    17d7:	c1 eb 03             	shr    $0x3,%ebx
    17da:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    17dd:	8b 0d 40 20 00 00    	mov    0x2040,%ecx
    17e3:	85 c9                	test   %ecx,%ecx
    17e5:	74 04                	je     17eb <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17e7:	8b 01                	mov    (%ecx),%eax
    17e9:	eb 4a                	jmp    1835 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    17eb:	c7 05 40 20 00 00 44 	movl   $0x2044,0x2040
    17f2:	20 00 00 
    17f5:	c7 05 44 20 00 00 44 	movl   $0x2044,0x2044
    17fc:	20 00 00 
    base.s.size = 0;
    17ff:	c7 05 48 20 00 00 00 	movl   $0x0,0x2048
    1806:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1809:	b9 44 20 00 00       	mov    $0x2044,%ecx
    180e:	eb d7                	jmp    17e7 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1810:	74 19                	je     182b <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1812:	29 da                	sub    %ebx,%edx
    1814:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1817:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    181a:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    181d:	89 0d 40 20 00 00    	mov    %ecx,0x2040
      return (void*)(p + 1);
    1823:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1826:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1829:	c9                   	leave  
    182a:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    182b:	8b 10                	mov    (%eax),%edx
    182d:	89 11                	mov    %edx,(%ecx)
    182f:	eb ec                	jmp    181d <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1831:	89 c1                	mov    %eax,%ecx
    1833:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1835:	8b 50 04             	mov    0x4(%eax),%edx
    1838:	39 da                	cmp    %ebx,%edx
    183a:	73 d4                	jae    1810 <malloc+0x46>
    if(p == freep)
    183c:	39 05 40 20 00 00    	cmp    %eax,0x2040
    1842:	75 ed                	jne    1831 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1844:	89 d8                	mov    %ebx,%eax
    1846:	e8 2f ff ff ff       	call   177a <morecore>
    184b:	85 c0                	test   %eax,%eax
    184d:	75 e2                	jne    1831 <malloc+0x67>
    184f:	eb d5                	jmp    1826 <malloc+0x5c>
