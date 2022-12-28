
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
    1005:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    1008:	83 ec 0c             	sub    $0xc,%esp
    100b:	53                   	push   %ebx
    100c:	e8 1f 03 00 00       	call   1330 <strlen>
    1011:	01 d8                	add    %ebx,%eax
    1013:	83 c4 10             	add    $0x10,%esp
    1016:	eb 03                	jmp    101b <fmtname+0x1b>
    1018:	83 e8 01             	sub    $0x1,%eax
    101b:	39 d8                	cmp    %ebx,%eax
    101d:	72 05                	jb     1024 <fmtname+0x24>
    101f:	80 38 2f             	cmpb   $0x2f,(%eax)
    1022:	75 f4                	jne    1018 <fmtname+0x18>
    ;
  p++;
    1024:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    1027:	83 ec 0c             	sub    $0xc,%esp
    102a:	53                   	push   %ebx
    102b:	e8 00 03 00 00       	call   1330 <strlen>
    1030:	83 c4 10             	add    $0x10,%esp
    1033:	83 f8 0d             	cmp    $0xd,%eax
    1036:	76 09                	jbe    1041 <fmtname+0x41>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
    1038:	89 d8                	mov    %ebx,%eax
    103a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    103d:	5b                   	pop    %ebx
    103e:	5e                   	pop    %esi
    103f:	5d                   	pop    %ebp
    1040:	c3                   	ret    
  memmove(buf, p, strlen(p));
    1041:	83 ec 0c             	sub    $0xc,%esp
    1044:	53                   	push   %ebx
    1045:	e8 e6 02 00 00       	call   1330 <strlen>
    104a:	83 c4 0c             	add    $0xc,%esp
    104d:	50                   	push   %eax
    104e:	53                   	push   %ebx
    104f:	68 4c 1c 00 00       	push   $0x1c4c
    1054:	e8 f6 03 00 00       	call   144f <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    1059:	89 1c 24             	mov    %ebx,(%esp)
    105c:	e8 cf 02 00 00       	call   1330 <strlen>
    1061:	89 c6                	mov    %eax,%esi
    1063:	89 1c 24             	mov    %ebx,(%esp)
    1066:	e8 c5 02 00 00       	call   1330 <strlen>
    106b:	83 c4 0c             	add    $0xc,%esp
    106e:	ba 0e 00 00 00       	mov    $0xe,%edx
    1073:	29 f2                	sub    %esi,%edx
    1075:	52                   	push   %edx
    1076:	6a 20                	push   $0x20
    1078:	05 4c 1c 00 00       	add    $0x1c4c,%eax
    107d:	50                   	push   %eax
    107e:	e8 c5 02 00 00       	call   1348 <memset>
  return buf;
    1083:	83 c4 10             	add    $0x10,%esp
    1086:	bb 4c 1c 00 00       	mov    $0x1c4c,%ebx
    108b:	eb ab                	jmp    1038 <fmtname+0x38>

0000108d <ls>:

void
ls(char *path)
{
    108d:	55                   	push   %ebp
    108e:	89 e5                	mov    %esp,%ebp
    1090:	57                   	push   %edi
    1091:	56                   	push   %esi
    1092:	53                   	push   %ebx
    1093:	81 ec 54 02 00 00    	sub    $0x254,%esp
    1099:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    109c:	6a 00                	push   $0x0
    109e:	53                   	push   %ebx
    109f:	e8 1f 04 00 00       	call   14c3 <open>
    10a4:	83 c4 10             	add    $0x10,%esp
    10a7:	85 c0                	test   %eax,%eax
    10a9:	0f 88 8c 00 00 00    	js     113b <ls+0xae>
    10af:	89 c7                	mov    %eax,%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    10b1:	83 ec 08             	sub    $0x8,%esp
    10b4:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    10ba:	50                   	push   %eax
    10bb:	57                   	push   %edi
    10bc:	e8 1a 04 00 00       	call   14db <fstat>
    10c1:	83 c4 10             	add    $0x10,%esp
    10c4:	85 c0                	test   %eax,%eax
    10c6:	0f 88 84 00 00 00    	js     1150 <ls+0xc3>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
    10cc:	0f b7 85 c4 fd ff ff 	movzwl -0x23c(%ebp),%eax
    10d3:	0f bf f0             	movswl %ax,%esi
    10d6:	66 83 f8 01          	cmp    $0x1,%ax
    10da:	0f 84 8d 00 00 00    	je     116d <ls+0xe0>
    10e0:	66 83 f8 02          	cmp    $0x2,%ax
    10e4:	75 41                	jne    1127 <ls+0x9a>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    10e6:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
    10ec:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    10f2:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
    10f8:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	53                   	push   %ebx
    1102:	e8 f9 fe ff ff       	call   1000 <fmtname>
    1107:	83 c4 08             	add    $0x8,%esp
    110a:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
    1110:	ff b5 b0 fd ff ff    	push   -0x250(%ebp)
    1116:	56                   	push   %esi
    1117:	50                   	push   %eax
    1118:	68 c0 18 00 00       	push   $0x18c0
    111d:	6a 01                	push   $0x1
    111f:	e8 c4 04 00 00       	call   15e8 <printf>
    break;
    1124:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
    1127:	83 ec 0c             	sub    $0xc,%esp
    112a:	57                   	push   %edi
    112b:	e8 7b 03 00 00       	call   14ab <close>
    1130:	83 c4 10             	add    $0x10,%esp
}
    1133:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1136:	5b                   	pop    %ebx
    1137:	5e                   	pop    %esi
    1138:	5f                   	pop    %edi
    1139:	5d                   	pop    %ebp
    113a:	c3                   	ret    
    printf(2, "ls: cannot open %s\n", path);
    113b:	83 ec 04             	sub    $0x4,%esp
    113e:	53                   	push   %ebx
    113f:	68 98 18 00 00       	push   $0x1898
    1144:	6a 02                	push   $0x2
    1146:	e8 9d 04 00 00       	call   15e8 <printf>
    return;
    114b:	83 c4 10             	add    $0x10,%esp
    114e:	eb e3                	jmp    1133 <ls+0xa6>
    printf(2, "ls: cannot stat %s\n", path);
    1150:	83 ec 04             	sub    $0x4,%esp
    1153:	53                   	push   %ebx
    1154:	68 ac 18 00 00       	push   $0x18ac
    1159:	6a 02                	push   $0x2
    115b:	e8 88 04 00 00       	call   15e8 <printf>
    close(fd);
    1160:	89 3c 24             	mov    %edi,(%esp)
    1163:	e8 43 03 00 00       	call   14ab <close>
    return;
    1168:	83 c4 10             	add    $0x10,%esp
    116b:	eb c6                	jmp    1133 <ls+0xa6>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    116d:	83 ec 0c             	sub    $0xc,%esp
    1170:	53                   	push   %ebx
    1171:	e8 ba 01 00 00       	call   1330 <strlen>
    1176:	83 c0 10             	add    $0x10,%eax
    1179:	83 c4 10             	add    $0x10,%esp
    117c:	3d 00 02 00 00       	cmp    $0x200,%eax
    1181:	76 14                	jbe    1197 <ls+0x10a>
      printf(1, "ls: path too long\n");
    1183:	83 ec 08             	sub    $0x8,%esp
    1186:	68 cd 18 00 00       	push   $0x18cd
    118b:	6a 01                	push   $0x1
    118d:	e8 56 04 00 00       	call   15e8 <printf>
      break;
    1192:	83 c4 10             	add    $0x10,%esp
    1195:	eb 90                	jmp    1127 <ls+0x9a>
    strcpy(buf, path);
    1197:	83 ec 08             	sub    $0x8,%esp
    119a:	53                   	push   %ebx
    119b:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
    11a1:	56                   	push   %esi
    11a2:	e8 3d 01 00 00       	call   12e4 <strcpy>
    p = buf+strlen(buf);
    11a7:	89 34 24             	mov    %esi,(%esp)
    11aa:	e8 81 01 00 00       	call   1330 <strlen>
    11af:	01 c6                	add    %eax,%esi
    *p++ = '/';
    11b1:	8d 46 01             	lea    0x1(%esi),%eax
    11b4:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
    11ba:	c6 06 2f             	movb   $0x2f,(%esi)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    11bd:	83 c4 10             	add    $0x10,%esp
    11c0:	eb 19                	jmp    11db <ls+0x14e>
        printf(1, "ls: cannot stat %s\n", buf);
    11c2:	83 ec 04             	sub    $0x4,%esp
    11c5:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    11cb:	50                   	push   %eax
    11cc:	68 ac 18 00 00       	push   $0x18ac
    11d1:	6a 01                	push   $0x1
    11d3:	e8 10 04 00 00       	call   15e8 <printf>
        continue;
    11d8:	83 c4 10             	add    $0x10,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    11db:	83 ec 04             	sub    $0x4,%esp
    11de:	6a 10                	push   $0x10
    11e0:	8d 85 d8 fd ff ff    	lea    -0x228(%ebp),%eax
    11e6:	50                   	push   %eax
    11e7:	57                   	push   %edi
    11e8:	e8 ae 02 00 00       	call   149b <read>
    11ed:	83 c4 10             	add    $0x10,%esp
    11f0:	83 f8 10             	cmp    $0x10,%eax
    11f3:	0f 85 2e ff ff ff    	jne    1127 <ls+0x9a>
      if(de.inum == 0)
    11f9:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
    1200:	00 
    1201:	74 d8                	je     11db <ls+0x14e>
      memmove(p, de.name, DIRSIZ);
    1203:	83 ec 04             	sub    $0x4,%esp
    1206:	6a 0e                	push   $0xe
    1208:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
    120e:	50                   	push   %eax
    120f:	ff b5 ac fd ff ff    	push   -0x254(%ebp)
    1215:	e8 35 02 00 00       	call   144f <memmove>
      p[DIRSIZ] = 0;
    121a:	c6 46 0f 00          	movb   $0x0,0xf(%esi)
      if(stat(buf, &st) < 0){
    121e:	83 c4 08             	add    $0x8,%esp
    1221:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    1227:	50                   	push   %eax
    1228:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    122e:	50                   	push   %eax
    122f:	e8 a7 01 00 00       	call   13db <stat>
    1234:	83 c4 10             	add    $0x10,%esp
    1237:	85 c0                	test   %eax,%eax
    1239:	78 87                	js     11c2 <ls+0x135>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    123b:	8b 9d d4 fd ff ff    	mov    -0x22c(%ebp),%ebx
    1241:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
    1247:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    124d:	0f b7 8d c4 fd ff ff 	movzwl -0x23c(%ebp),%ecx
    1254:	66 89 8d b0 fd ff ff 	mov    %cx,-0x250(%ebp)
    125b:	83 ec 0c             	sub    $0xc,%esp
    125e:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    1264:	50                   	push   %eax
    1265:	e8 96 fd ff ff       	call   1000 <fmtname>
    126a:	89 c2                	mov    %eax,%edx
    126c:	83 c4 08             	add    $0x8,%esp
    126f:	53                   	push   %ebx
    1270:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
    1276:	0f bf 85 b0 fd ff ff 	movswl -0x250(%ebp),%eax
    127d:	50                   	push   %eax
    127e:	52                   	push   %edx
    127f:	68 c0 18 00 00       	push   $0x18c0
    1284:	6a 01                	push   $0x1
    1286:	e8 5d 03 00 00       	call   15e8 <printf>
    128b:	83 c4 20             	add    $0x20,%esp
    128e:	e9 48 ff ff ff       	jmp    11db <ls+0x14e>

00001293 <main>:

int
main(int argc, char *argv[])
{
    1293:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1297:	83 e4 f0             	and    $0xfffffff0,%esp
    129a:	ff 71 fc             	push   -0x4(%ecx)
    129d:	55                   	push   %ebp
    129e:	89 e5                	mov    %esp,%ebp
    12a0:	57                   	push   %edi
    12a1:	56                   	push   %esi
    12a2:	53                   	push   %ebx
    12a3:	51                   	push   %ecx
    12a4:	83 ec 08             	sub    $0x8,%esp
    12a7:	8b 31                	mov    (%ecx),%esi
    12a9:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
    12ac:	83 fe 01             	cmp    $0x1,%esi
    12af:	7e 07                	jle    12b8 <main+0x25>
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    12b1:	bb 01 00 00 00       	mov    $0x1,%ebx
    12b6:	eb 23                	jmp    12db <main+0x48>
    ls(".");
    12b8:	83 ec 0c             	sub    $0xc,%esp
    12bb:	68 e0 18 00 00       	push   $0x18e0
    12c0:	e8 c8 fd ff ff       	call   108d <ls>
    exit();
    12c5:	e8 b9 01 00 00       	call   1483 <exit>
    ls(argv[i]);
    12ca:	83 ec 0c             	sub    $0xc,%esp
    12cd:	ff 34 9f             	push   (%edi,%ebx,4)
    12d0:	e8 b8 fd ff ff       	call   108d <ls>
  for(i=1; i<argc; i++)
    12d5:	83 c3 01             	add    $0x1,%ebx
    12d8:	83 c4 10             	add    $0x10,%esp
    12db:	39 f3                	cmp    %esi,%ebx
    12dd:	7c eb                	jl     12ca <main+0x37>
  exit();
    12df:	e8 9f 01 00 00       	call   1483 <exit>

000012e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    12e4:	55                   	push   %ebp
    12e5:	89 e5                	mov    %esp,%ebp
    12e7:	56                   	push   %esi
    12e8:	53                   	push   %ebx
    12e9:	8b 75 08             	mov    0x8(%ebp),%esi
    12ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    12ef:	89 f0                	mov    %esi,%eax
    12f1:	89 d1                	mov    %edx,%ecx
    12f3:	83 c2 01             	add    $0x1,%edx
    12f6:	89 c3                	mov    %eax,%ebx
    12f8:	83 c0 01             	add    $0x1,%eax
    12fb:	0f b6 09             	movzbl (%ecx),%ecx
    12fe:	88 0b                	mov    %cl,(%ebx)
    1300:	84 c9                	test   %cl,%cl
    1302:	75 ed                	jne    12f1 <strcpy+0xd>
    ;
  return os;
}
    1304:	89 f0                	mov    %esi,%eax
    1306:	5b                   	pop    %ebx
    1307:	5e                   	pop    %esi
    1308:	5d                   	pop    %ebp
    1309:	c3                   	ret    

0000130a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    130a:	55                   	push   %ebp
    130b:	89 e5                	mov    %esp,%ebp
    130d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1310:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1313:	eb 06                	jmp    131b <strcmp+0x11>
    p++, q++;
    1315:	83 c1 01             	add    $0x1,%ecx
    1318:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    131b:	0f b6 01             	movzbl (%ecx),%eax
    131e:	84 c0                	test   %al,%al
    1320:	74 04                	je     1326 <strcmp+0x1c>
    1322:	3a 02                	cmp    (%edx),%al
    1324:	74 ef                	je     1315 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    1326:	0f b6 c0             	movzbl %al,%eax
    1329:	0f b6 12             	movzbl (%edx),%edx
    132c:	29 d0                	sub    %edx,%eax
}
    132e:	5d                   	pop    %ebp
    132f:	c3                   	ret    

00001330 <strlen>:

uint
strlen(const char *s)
{
    1330:	55                   	push   %ebp
    1331:	89 e5                	mov    %esp,%ebp
    1333:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1336:	b8 00 00 00 00       	mov    $0x0,%eax
    133b:	eb 03                	jmp    1340 <strlen+0x10>
    133d:	83 c0 01             	add    $0x1,%eax
    1340:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    1344:	75 f7                	jne    133d <strlen+0xd>
    ;
  return n;
}
    1346:	5d                   	pop    %ebp
    1347:	c3                   	ret    

00001348 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1348:	55                   	push   %ebp
    1349:	89 e5                	mov    %esp,%ebp
    134b:	57                   	push   %edi
    134c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    134f:	89 d7                	mov    %edx,%edi
    1351:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1354:	8b 45 0c             	mov    0xc(%ebp),%eax
    1357:	fc                   	cld    
    1358:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    135a:	89 d0                	mov    %edx,%eax
    135c:	8b 7d fc             	mov    -0x4(%ebp),%edi
    135f:	c9                   	leave  
    1360:	c3                   	ret    

00001361 <strchr>:

char*
strchr(const char *s, char c)
{
    1361:	55                   	push   %ebp
    1362:	89 e5                	mov    %esp,%ebp
    1364:	8b 45 08             	mov    0x8(%ebp),%eax
    1367:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    136b:	eb 03                	jmp    1370 <strchr+0xf>
    136d:	83 c0 01             	add    $0x1,%eax
    1370:	0f b6 10             	movzbl (%eax),%edx
    1373:	84 d2                	test   %dl,%dl
    1375:	74 06                	je     137d <strchr+0x1c>
    if(*s == c)
    1377:	38 ca                	cmp    %cl,%dl
    1379:	75 f2                	jne    136d <strchr+0xc>
    137b:	eb 05                	jmp    1382 <strchr+0x21>
      return (char*)s;
  return 0;
    137d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1382:	5d                   	pop    %ebp
    1383:	c3                   	ret    

00001384 <gets>:

char*
gets(char *buf, int max)
{
    1384:	55                   	push   %ebp
    1385:	89 e5                	mov    %esp,%ebp
    1387:	57                   	push   %edi
    1388:	56                   	push   %esi
    1389:	53                   	push   %ebx
    138a:	83 ec 1c             	sub    $0x1c,%esp
    138d:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1390:	bb 00 00 00 00       	mov    $0x0,%ebx
    1395:	89 de                	mov    %ebx,%esi
    1397:	83 c3 01             	add    $0x1,%ebx
    139a:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    139d:	7d 2e                	jge    13cd <gets+0x49>
    cc = read(0, &c, 1);
    139f:	83 ec 04             	sub    $0x4,%esp
    13a2:	6a 01                	push   $0x1
    13a4:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13a7:	50                   	push   %eax
    13a8:	6a 00                	push   $0x0
    13aa:	e8 ec 00 00 00       	call   149b <read>
    if(cc < 1)
    13af:	83 c4 10             	add    $0x10,%esp
    13b2:	85 c0                	test   %eax,%eax
    13b4:	7e 17                	jle    13cd <gets+0x49>
      break;
    buf[i++] = c;
    13b6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13ba:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    13bd:	3c 0a                	cmp    $0xa,%al
    13bf:	0f 94 c2             	sete   %dl
    13c2:	3c 0d                	cmp    $0xd,%al
    13c4:	0f 94 c0             	sete   %al
    13c7:	08 c2                	or     %al,%dl
    13c9:	74 ca                	je     1395 <gets+0x11>
    buf[i++] = c;
    13cb:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    13cd:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    13d1:	89 f8                	mov    %edi,%eax
    13d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13d6:	5b                   	pop    %ebx
    13d7:	5e                   	pop    %esi
    13d8:	5f                   	pop    %edi
    13d9:	5d                   	pop    %ebp
    13da:	c3                   	ret    

000013db <stat>:

int
stat(const char *n, struct stat *st)
{
    13db:	55                   	push   %ebp
    13dc:	89 e5                	mov    %esp,%ebp
    13de:	56                   	push   %esi
    13df:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13e0:	83 ec 08             	sub    $0x8,%esp
    13e3:	6a 00                	push   $0x0
    13e5:	ff 75 08             	push   0x8(%ebp)
    13e8:	e8 d6 00 00 00       	call   14c3 <open>
  if(fd < 0)
    13ed:	83 c4 10             	add    $0x10,%esp
    13f0:	85 c0                	test   %eax,%eax
    13f2:	78 24                	js     1418 <stat+0x3d>
    13f4:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    13f6:	83 ec 08             	sub    $0x8,%esp
    13f9:	ff 75 0c             	push   0xc(%ebp)
    13fc:	50                   	push   %eax
    13fd:	e8 d9 00 00 00       	call   14db <fstat>
    1402:	89 c6                	mov    %eax,%esi
  close(fd);
    1404:	89 1c 24             	mov    %ebx,(%esp)
    1407:	e8 9f 00 00 00       	call   14ab <close>
  return r;
    140c:	83 c4 10             	add    $0x10,%esp
}
    140f:	89 f0                	mov    %esi,%eax
    1411:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1414:	5b                   	pop    %ebx
    1415:	5e                   	pop    %esi
    1416:	5d                   	pop    %ebp
    1417:	c3                   	ret    
    return -1;
    1418:	be ff ff ff ff       	mov    $0xffffffff,%esi
    141d:	eb f0                	jmp    140f <stat+0x34>

0000141f <atoi>:

int
atoi(const char *s)
{
    141f:	55                   	push   %ebp
    1420:	89 e5                	mov    %esp,%ebp
    1422:	53                   	push   %ebx
    1423:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1426:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    142b:	eb 10                	jmp    143d <atoi+0x1e>
    n = n*10 + *s++ - '0';
    142d:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1430:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1433:	83 c1 01             	add    $0x1,%ecx
    1436:	0f be c0             	movsbl %al,%eax
    1439:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    143d:	0f b6 01             	movzbl (%ecx),%eax
    1440:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1443:	80 fb 09             	cmp    $0x9,%bl
    1446:	76 e5                	jbe    142d <atoi+0xe>
  return n;
}
    1448:	89 d0                	mov    %edx,%eax
    144a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    144d:	c9                   	leave  
    144e:	c3                   	ret    

0000144f <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    144f:	55                   	push   %ebp
    1450:	89 e5                	mov    %esp,%ebp
    1452:	56                   	push   %esi
    1453:	53                   	push   %ebx
    1454:	8b 75 08             	mov    0x8(%ebp),%esi
    1457:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    145a:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    145d:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    145f:	eb 0d                	jmp    146e <memmove+0x1f>
    *dst++ = *src++;
    1461:	0f b6 01             	movzbl (%ecx),%eax
    1464:	88 02                	mov    %al,(%edx)
    1466:	8d 49 01             	lea    0x1(%ecx),%ecx
    1469:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    146c:	89 d8                	mov    %ebx,%eax
    146e:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1471:	85 c0                	test   %eax,%eax
    1473:	7f ec                	jg     1461 <memmove+0x12>
  return vdst;
}
    1475:	89 f0                	mov    %esi,%eax
    1477:	5b                   	pop    %ebx
    1478:	5e                   	pop    %esi
    1479:	5d                   	pop    %ebp
    147a:	c3                   	ret    

0000147b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    147b:	b8 01 00 00 00       	mov    $0x1,%eax
    1480:	cd 40                	int    $0x40
    1482:	c3                   	ret    

00001483 <exit>:
SYSCALL(exit)
    1483:	b8 02 00 00 00       	mov    $0x2,%eax
    1488:	cd 40                	int    $0x40
    148a:	c3                   	ret    

0000148b <wait>:
SYSCALL(wait)
    148b:	b8 03 00 00 00       	mov    $0x3,%eax
    1490:	cd 40                	int    $0x40
    1492:	c3                   	ret    

00001493 <pipe>:
SYSCALL(pipe)
    1493:	b8 04 00 00 00       	mov    $0x4,%eax
    1498:	cd 40                	int    $0x40
    149a:	c3                   	ret    

0000149b <read>:
SYSCALL(read)
    149b:	b8 05 00 00 00       	mov    $0x5,%eax
    14a0:	cd 40                	int    $0x40
    14a2:	c3                   	ret    

000014a3 <write>:
SYSCALL(write)
    14a3:	b8 10 00 00 00       	mov    $0x10,%eax
    14a8:	cd 40                	int    $0x40
    14aa:	c3                   	ret    

000014ab <close>:
SYSCALL(close)
    14ab:	b8 15 00 00 00       	mov    $0x15,%eax
    14b0:	cd 40                	int    $0x40
    14b2:	c3                   	ret    

000014b3 <kill>:
SYSCALL(kill)
    14b3:	b8 06 00 00 00       	mov    $0x6,%eax
    14b8:	cd 40                	int    $0x40
    14ba:	c3                   	ret    

000014bb <exec>:
SYSCALL(exec)
    14bb:	b8 07 00 00 00       	mov    $0x7,%eax
    14c0:	cd 40                	int    $0x40
    14c2:	c3                   	ret    

000014c3 <open>:
SYSCALL(open)
    14c3:	b8 0f 00 00 00       	mov    $0xf,%eax
    14c8:	cd 40                	int    $0x40
    14ca:	c3                   	ret    

000014cb <mknod>:
SYSCALL(mknod)
    14cb:	b8 11 00 00 00       	mov    $0x11,%eax
    14d0:	cd 40                	int    $0x40
    14d2:	c3                   	ret    

000014d3 <unlink>:
SYSCALL(unlink)
    14d3:	b8 12 00 00 00       	mov    $0x12,%eax
    14d8:	cd 40                	int    $0x40
    14da:	c3                   	ret    

000014db <fstat>:
SYSCALL(fstat)
    14db:	b8 08 00 00 00       	mov    $0x8,%eax
    14e0:	cd 40                	int    $0x40
    14e2:	c3                   	ret    

000014e3 <link>:
SYSCALL(link)
    14e3:	b8 13 00 00 00       	mov    $0x13,%eax
    14e8:	cd 40                	int    $0x40
    14ea:	c3                   	ret    

000014eb <mkdir>:
SYSCALL(mkdir)
    14eb:	b8 14 00 00 00       	mov    $0x14,%eax
    14f0:	cd 40                	int    $0x40
    14f2:	c3                   	ret    

000014f3 <chdir>:
SYSCALL(chdir)
    14f3:	b8 09 00 00 00       	mov    $0x9,%eax
    14f8:	cd 40                	int    $0x40
    14fa:	c3                   	ret    

000014fb <dup>:
SYSCALL(dup)
    14fb:	b8 0a 00 00 00       	mov    $0xa,%eax
    1500:	cd 40                	int    $0x40
    1502:	c3                   	ret    

00001503 <getpid>:
SYSCALL(getpid)
    1503:	b8 0b 00 00 00       	mov    $0xb,%eax
    1508:	cd 40                	int    $0x40
    150a:	c3                   	ret    

0000150b <sbrk>:
SYSCALL(sbrk)
    150b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1510:	cd 40                	int    $0x40
    1512:	c3                   	ret    

00001513 <sleep>:
SYSCALL(sleep)
    1513:	b8 0d 00 00 00       	mov    $0xd,%eax
    1518:	cd 40                	int    $0x40
    151a:	c3                   	ret    

0000151b <uptime>:
SYSCALL(uptime)
    151b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1520:	cd 40                	int    $0x40
    1522:	c3                   	ret    

00001523 <settickets>:
SYSCALL(settickets)
    1523:	b8 16 00 00 00       	mov    $0x16,%eax
    1528:	cd 40                	int    $0x40
    152a:	c3                   	ret    

0000152b <getpinfo>:
SYSCALL(getpinfo)
    152b:	b8 17 00 00 00       	mov    $0x17,%eax
    1530:	cd 40                	int    $0x40
    1532:	c3                   	ret    

00001533 <mprotect>:
SYSCALL(mprotect)
    1533:	b8 18 00 00 00       	mov    $0x18,%eax
    1538:	cd 40                	int    $0x40
    153a:	c3                   	ret    

0000153b <munprotect>:
    153b:	b8 19 00 00 00       	mov    $0x19,%eax
    1540:	cd 40                	int    $0x40
    1542:	c3                   	ret    

00001543 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1543:	55                   	push   %ebp
    1544:	89 e5                	mov    %esp,%ebp
    1546:	83 ec 1c             	sub    $0x1c,%esp
    1549:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    154c:	6a 01                	push   $0x1
    154e:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1551:	52                   	push   %edx
    1552:	50                   	push   %eax
    1553:	e8 4b ff ff ff       	call   14a3 <write>
}
    1558:	83 c4 10             	add    $0x10,%esp
    155b:	c9                   	leave  
    155c:	c3                   	ret    

0000155d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    155d:	55                   	push   %ebp
    155e:	89 e5                	mov    %esp,%ebp
    1560:	57                   	push   %edi
    1561:	56                   	push   %esi
    1562:	53                   	push   %ebx
    1563:	83 ec 2c             	sub    $0x2c,%esp
    1566:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1569:	89 d0                	mov    %edx,%eax
    156b:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    156d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1571:	0f 95 c1             	setne  %cl
    1574:	c1 ea 1f             	shr    $0x1f,%edx
    1577:	84 d1                	test   %dl,%cl
    1579:	74 44                	je     15bf <printint+0x62>
    neg = 1;
    x = -xx;
    157b:	f7 d8                	neg    %eax
    157d:	89 c1                	mov    %eax,%ecx
    neg = 1;
    157f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1586:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    158b:	89 c8                	mov    %ecx,%eax
    158d:	ba 00 00 00 00       	mov    $0x0,%edx
    1592:	f7 f6                	div    %esi
    1594:	89 df                	mov    %ebx,%edi
    1596:	83 c3 01             	add    $0x1,%ebx
    1599:	0f b6 92 44 19 00 00 	movzbl 0x1944(%edx),%edx
    15a0:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    15a4:	89 ca                	mov    %ecx,%edx
    15a6:	89 c1                	mov    %eax,%ecx
    15a8:	39 d6                	cmp    %edx,%esi
    15aa:	76 df                	jbe    158b <printint+0x2e>
  if(neg)
    15ac:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    15b0:	74 31                	je     15e3 <printint+0x86>
    buf[i++] = '-';
    15b2:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    15b7:	8d 5f 02             	lea    0x2(%edi),%ebx
    15ba:	8b 75 d0             	mov    -0x30(%ebp),%esi
    15bd:	eb 17                	jmp    15d6 <printint+0x79>
    x = xx;
    15bf:	89 c1                	mov    %eax,%ecx
  neg = 0;
    15c1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    15c8:	eb bc                	jmp    1586 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    15ca:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    15cf:	89 f0                	mov    %esi,%eax
    15d1:	e8 6d ff ff ff       	call   1543 <putc>
  while(--i >= 0)
    15d6:	83 eb 01             	sub    $0x1,%ebx
    15d9:	79 ef                	jns    15ca <printint+0x6d>
}
    15db:	83 c4 2c             	add    $0x2c,%esp
    15de:	5b                   	pop    %ebx
    15df:	5e                   	pop    %esi
    15e0:	5f                   	pop    %edi
    15e1:	5d                   	pop    %ebp
    15e2:	c3                   	ret    
    15e3:	8b 75 d0             	mov    -0x30(%ebp),%esi
    15e6:	eb ee                	jmp    15d6 <printint+0x79>

000015e8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    15e8:	55                   	push   %ebp
    15e9:	89 e5                	mov    %esp,%ebp
    15eb:	57                   	push   %edi
    15ec:	56                   	push   %esi
    15ed:	53                   	push   %ebx
    15ee:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    15f1:	8d 45 10             	lea    0x10(%ebp),%eax
    15f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    15f7:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    15fc:	bb 00 00 00 00       	mov    $0x0,%ebx
    1601:	eb 14                	jmp    1617 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1603:	89 fa                	mov    %edi,%edx
    1605:	8b 45 08             	mov    0x8(%ebp),%eax
    1608:	e8 36 ff ff ff       	call   1543 <putc>
    160d:	eb 05                	jmp    1614 <printf+0x2c>
      }
    } else if(state == '%'){
    160f:	83 fe 25             	cmp    $0x25,%esi
    1612:	74 25                	je     1639 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1614:	83 c3 01             	add    $0x1,%ebx
    1617:	8b 45 0c             	mov    0xc(%ebp),%eax
    161a:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    161e:	84 c0                	test   %al,%al
    1620:	0f 84 20 01 00 00    	je     1746 <printf+0x15e>
    c = fmt[i] & 0xff;
    1626:	0f be f8             	movsbl %al,%edi
    1629:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    162c:	85 f6                	test   %esi,%esi
    162e:	75 df                	jne    160f <printf+0x27>
      if(c == '%'){
    1630:	83 f8 25             	cmp    $0x25,%eax
    1633:	75 ce                	jne    1603 <printf+0x1b>
        state = '%';
    1635:	89 c6                	mov    %eax,%esi
    1637:	eb db                	jmp    1614 <printf+0x2c>
      if(c == 'd'){
    1639:	83 f8 25             	cmp    $0x25,%eax
    163c:	0f 84 cf 00 00 00    	je     1711 <printf+0x129>
    1642:	0f 8c dd 00 00 00    	jl     1725 <printf+0x13d>
    1648:	83 f8 78             	cmp    $0x78,%eax
    164b:	0f 8f d4 00 00 00    	jg     1725 <printf+0x13d>
    1651:	83 f8 63             	cmp    $0x63,%eax
    1654:	0f 8c cb 00 00 00    	jl     1725 <printf+0x13d>
    165a:	83 e8 63             	sub    $0x63,%eax
    165d:	83 f8 15             	cmp    $0x15,%eax
    1660:	0f 87 bf 00 00 00    	ja     1725 <printf+0x13d>
    1666:	ff 24 85 ec 18 00 00 	jmp    *0x18ec(,%eax,4)
        printint(fd, *ap, 10, 1);
    166d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1670:	8b 17                	mov    (%edi),%edx
    1672:	83 ec 0c             	sub    $0xc,%esp
    1675:	6a 01                	push   $0x1
    1677:	b9 0a 00 00 00       	mov    $0xa,%ecx
    167c:	8b 45 08             	mov    0x8(%ebp),%eax
    167f:	e8 d9 fe ff ff       	call   155d <printint>
        ap++;
    1684:	83 c7 04             	add    $0x4,%edi
    1687:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    168a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    168d:	be 00 00 00 00       	mov    $0x0,%esi
    1692:	eb 80                	jmp    1614 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1694:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1697:	8b 17                	mov    (%edi),%edx
    1699:	83 ec 0c             	sub    $0xc,%esp
    169c:	6a 00                	push   $0x0
    169e:	b9 10 00 00 00       	mov    $0x10,%ecx
    16a3:	8b 45 08             	mov    0x8(%ebp),%eax
    16a6:	e8 b2 fe ff ff       	call   155d <printint>
        ap++;
    16ab:	83 c7 04             	add    $0x4,%edi
    16ae:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    16b1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16b4:	be 00 00 00 00       	mov    $0x0,%esi
    16b9:	e9 56 ff ff ff       	jmp    1614 <printf+0x2c>
        s = (char*)*ap;
    16be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16c1:	8b 30                	mov    (%eax),%esi
        ap++;
    16c3:	83 c0 04             	add    $0x4,%eax
    16c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    16c9:	85 f6                	test   %esi,%esi
    16cb:	75 15                	jne    16e2 <printf+0xfa>
          s = "(null)";
    16cd:	be e2 18 00 00       	mov    $0x18e2,%esi
    16d2:	eb 0e                	jmp    16e2 <printf+0xfa>
          putc(fd, *s);
    16d4:	0f be d2             	movsbl %dl,%edx
    16d7:	8b 45 08             	mov    0x8(%ebp),%eax
    16da:	e8 64 fe ff ff       	call   1543 <putc>
          s++;
    16df:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    16e2:	0f b6 16             	movzbl (%esi),%edx
    16e5:	84 d2                	test   %dl,%dl
    16e7:	75 eb                	jne    16d4 <printf+0xec>
      state = 0;
    16e9:	be 00 00 00 00       	mov    $0x0,%esi
    16ee:	e9 21 ff ff ff       	jmp    1614 <printf+0x2c>
        putc(fd, *ap);
    16f3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    16f6:	0f be 17             	movsbl (%edi),%edx
    16f9:	8b 45 08             	mov    0x8(%ebp),%eax
    16fc:	e8 42 fe ff ff       	call   1543 <putc>
        ap++;
    1701:	83 c7 04             	add    $0x4,%edi
    1704:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1707:	be 00 00 00 00       	mov    $0x0,%esi
    170c:	e9 03 ff ff ff       	jmp    1614 <printf+0x2c>
        putc(fd, c);
    1711:	89 fa                	mov    %edi,%edx
    1713:	8b 45 08             	mov    0x8(%ebp),%eax
    1716:	e8 28 fe ff ff       	call   1543 <putc>
      state = 0;
    171b:	be 00 00 00 00       	mov    $0x0,%esi
    1720:	e9 ef fe ff ff       	jmp    1614 <printf+0x2c>
        putc(fd, '%');
    1725:	ba 25 00 00 00       	mov    $0x25,%edx
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	e8 11 fe ff ff       	call   1543 <putc>
        putc(fd, c);
    1732:	89 fa                	mov    %edi,%edx
    1734:	8b 45 08             	mov    0x8(%ebp),%eax
    1737:	e8 07 fe ff ff       	call   1543 <putc>
      state = 0;
    173c:	be 00 00 00 00       	mov    $0x0,%esi
    1741:	e9 ce fe ff ff       	jmp    1614 <printf+0x2c>
    }
  }
}
    1746:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1749:	5b                   	pop    %ebx
    174a:	5e                   	pop    %esi
    174b:	5f                   	pop    %edi
    174c:	5d                   	pop    %ebp
    174d:	c3                   	ret    

0000174e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    174e:	55                   	push   %ebp
    174f:	89 e5                	mov    %esp,%ebp
    1751:	57                   	push   %edi
    1752:	56                   	push   %esi
    1753:	53                   	push   %ebx
    1754:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1757:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    175a:	a1 5c 1c 00 00       	mov    0x1c5c,%eax
    175f:	eb 02                	jmp    1763 <free+0x15>
    1761:	89 d0                	mov    %edx,%eax
    1763:	39 c8                	cmp    %ecx,%eax
    1765:	73 04                	jae    176b <free+0x1d>
    1767:	39 08                	cmp    %ecx,(%eax)
    1769:	77 12                	ja     177d <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    176b:	8b 10                	mov    (%eax),%edx
    176d:	39 c2                	cmp    %eax,%edx
    176f:	77 f0                	ja     1761 <free+0x13>
    1771:	39 c8                	cmp    %ecx,%eax
    1773:	72 08                	jb     177d <free+0x2f>
    1775:	39 ca                	cmp    %ecx,%edx
    1777:	77 04                	ja     177d <free+0x2f>
    1779:	89 d0                	mov    %edx,%eax
    177b:	eb e6                	jmp    1763 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    177d:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1780:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1783:	8b 10                	mov    (%eax),%edx
    1785:	39 d7                	cmp    %edx,%edi
    1787:	74 19                	je     17a2 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1789:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    178c:	8b 50 04             	mov    0x4(%eax),%edx
    178f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1792:	39 ce                	cmp    %ecx,%esi
    1794:	74 1b                	je     17b1 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1796:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1798:	a3 5c 1c 00 00       	mov    %eax,0x1c5c
}
    179d:	5b                   	pop    %ebx
    179e:	5e                   	pop    %esi
    179f:	5f                   	pop    %edi
    17a0:	5d                   	pop    %ebp
    17a1:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    17a2:	03 72 04             	add    0x4(%edx),%esi
    17a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    17a8:	8b 10                	mov    (%eax),%edx
    17aa:	8b 12                	mov    (%edx),%edx
    17ac:	89 53 f8             	mov    %edx,-0x8(%ebx)
    17af:	eb db                	jmp    178c <free+0x3e>
    p->s.size += bp->s.size;
    17b1:	03 53 fc             	add    -0x4(%ebx),%edx
    17b4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17b7:	8b 53 f8             	mov    -0x8(%ebx),%edx
    17ba:	89 10                	mov    %edx,(%eax)
    17bc:	eb da                	jmp    1798 <free+0x4a>

000017be <morecore>:

static Header*
morecore(uint nu)
{
    17be:	55                   	push   %ebp
    17bf:	89 e5                	mov    %esp,%ebp
    17c1:	53                   	push   %ebx
    17c2:	83 ec 04             	sub    $0x4,%esp
    17c5:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    17c7:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    17cc:	77 05                	ja     17d3 <morecore+0x15>
    nu = 4096;
    17ce:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    17d3:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    17da:	83 ec 0c             	sub    $0xc,%esp
    17dd:	50                   	push   %eax
    17de:	e8 28 fd ff ff       	call   150b <sbrk>
  if(p == (char*)-1)
    17e3:	83 c4 10             	add    $0x10,%esp
    17e6:	83 f8 ff             	cmp    $0xffffffff,%eax
    17e9:	74 1c                	je     1807 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    17eb:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17ee:	83 c0 08             	add    $0x8,%eax
    17f1:	83 ec 0c             	sub    $0xc,%esp
    17f4:	50                   	push   %eax
    17f5:	e8 54 ff ff ff       	call   174e <free>
  return freep;
    17fa:	a1 5c 1c 00 00       	mov    0x1c5c,%eax
    17ff:	83 c4 10             	add    $0x10,%esp
}
    1802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1805:	c9                   	leave  
    1806:	c3                   	ret    
    return 0;
    1807:	b8 00 00 00 00       	mov    $0x0,%eax
    180c:	eb f4                	jmp    1802 <morecore+0x44>

0000180e <malloc>:

void*
malloc(uint nbytes)
{
    180e:	55                   	push   %ebp
    180f:	89 e5                	mov    %esp,%ebp
    1811:	53                   	push   %ebx
    1812:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1815:	8b 45 08             	mov    0x8(%ebp),%eax
    1818:	8d 58 07             	lea    0x7(%eax),%ebx
    181b:	c1 eb 03             	shr    $0x3,%ebx
    181e:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1821:	8b 0d 5c 1c 00 00    	mov    0x1c5c,%ecx
    1827:	85 c9                	test   %ecx,%ecx
    1829:	74 04                	je     182f <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    182b:	8b 01                	mov    (%ecx),%eax
    182d:	eb 4a                	jmp    1879 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    182f:	c7 05 5c 1c 00 00 60 	movl   $0x1c60,0x1c5c
    1836:	1c 00 00 
    1839:	c7 05 60 1c 00 00 60 	movl   $0x1c60,0x1c60
    1840:	1c 00 00 
    base.s.size = 0;
    1843:	c7 05 64 1c 00 00 00 	movl   $0x0,0x1c64
    184a:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    184d:	b9 60 1c 00 00       	mov    $0x1c60,%ecx
    1852:	eb d7                	jmp    182b <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1854:	74 19                	je     186f <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1856:	29 da                	sub    %ebx,%edx
    1858:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    185b:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    185e:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1861:	89 0d 5c 1c 00 00    	mov    %ecx,0x1c5c
      return (void*)(p + 1);
    1867:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    186a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    186d:	c9                   	leave  
    186e:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    186f:	8b 10                	mov    (%eax),%edx
    1871:	89 11                	mov    %edx,(%ecx)
    1873:	eb ec                	jmp    1861 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1875:	89 c1                	mov    %eax,%ecx
    1877:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1879:	8b 50 04             	mov    0x4(%eax),%edx
    187c:	39 da                	cmp    %ebx,%edx
    187e:	73 d4                	jae    1854 <malloc+0x46>
    if(p == freep)
    1880:	39 05 5c 1c 00 00    	cmp    %eax,0x1c5c
    1886:	75 ed                	jne    1875 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1888:	89 d8                	mov    %ebx,%eax
    188a:	e8 2f ff ff ff       	call   17be <morecore>
    188f:	85 c0                	test   %eax,%eax
    1891:	75 e2                	jne    1875 <malloc+0x67>
    1893:	eb d5                	jmp    186a <malloc+0x5c>
