
_usertests:     file format elf32-i386


Disassembly of section .text:

00001000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
    1006:	68 c0 4b 00 00       	push   $0x4bc0
    100b:	ff 35 b4 6b 00 00    	push   0x6bb4
    1011:	e8 67 38 00 00       	call   487d <printf>

  if(mkdir("iputdir") < 0){
    1016:	c7 04 24 53 4b 00 00 	movl   $0x4b53,(%esp)
    101d:	e8 5e 37 00 00       	call   4780 <mkdir>
    1022:	83 c4 10             	add    $0x10,%esp
    1025:	85 c0                	test   %eax,%eax
    1027:	78 54                	js     107d <iputtest+0x7d>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    1029:	83 ec 0c             	sub    $0xc,%esp
    102c:	68 53 4b 00 00       	push   $0x4b53
    1031:	e8 52 37 00 00       	call   4788 <chdir>
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	85 c0                	test   %eax,%eax
    103b:	78 58                	js     1095 <iputtest+0x95>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    103d:	83 ec 0c             	sub    $0xc,%esp
    1040:	68 50 4b 00 00       	push   $0x4b50
    1045:	e8 1e 37 00 00       	call   4768 <unlink>
    104a:	83 c4 10             	add    $0x10,%esp
    104d:	85 c0                	test   %eax,%eax
    104f:	78 5c                	js     10ad <iputtest+0xad>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    1051:	83 ec 0c             	sub    $0xc,%esp
    1054:	68 75 4b 00 00       	push   $0x4b75
    1059:	e8 2a 37 00 00       	call   4788 <chdir>
    105e:	83 c4 10             	add    $0x10,%esp
    1061:	85 c0                	test   %eax,%eax
    1063:	78 60                	js     10c5 <iputtest+0xc5>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
    1065:	83 ec 08             	sub    $0x8,%esp
    1068:	68 f8 4b 00 00       	push   $0x4bf8
    106d:	ff 35 b4 6b 00 00    	push   0x6bb4
    1073:	e8 05 38 00 00       	call   487d <printf>
}
    1078:	83 c4 10             	add    $0x10,%esp
    107b:	c9                   	leave  
    107c:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
    107d:	83 ec 08             	sub    $0x8,%esp
    1080:	68 2c 4b 00 00       	push   $0x4b2c
    1085:	ff 35 b4 6b 00 00    	push   0x6bb4
    108b:	e8 ed 37 00 00       	call   487d <printf>
    exit();
    1090:	e8 83 36 00 00       	call   4718 <exit>
    printf(stdout, "chdir iputdir failed\n");
    1095:	83 ec 08             	sub    $0x8,%esp
    1098:	68 3a 4b 00 00       	push   $0x4b3a
    109d:	ff 35 b4 6b 00 00    	push   0x6bb4
    10a3:	e8 d5 37 00 00       	call   487d <printf>
    exit();
    10a8:	e8 6b 36 00 00       	call   4718 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
    10ad:	83 ec 08             	sub    $0x8,%esp
    10b0:	68 5b 4b 00 00       	push   $0x4b5b
    10b5:	ff 35 b4 6b 00 00    	push   0x6bb4
    10bb:	e8 bd 37 00 00       	call   487d <printf>
    exit();
    10c0:	e8 53 36 00 00       	call   4718 <exit>
    printf(stdout, "chdir / failed\n");
    10c5:	83 ec 08             	sub    $0x8,%esp
    10c8:	68 77 4b 00 00       	push   $0x4b77
    10cd:	ff 35 b4 6b 00 00    	push   0x6bb4
    10d3:	e8 a5 37 00 00       	call   487d <printf>
    exit();
    10d8:	e8 3b 36 00 00       	call   4718 <exit>

000010dd <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    10dd:	55                   	push   %ebp
    10de:	89 e5                	mov    %esp,%ebp
    10e0:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
    10e3:	68 87 4b 00 00       	push   $0x4b87
    10e8:	ff 35 b4 6b 00 00    	push   0x6bb4
    10ee:	e8 8a 37 00 00       	call   487d <printf>

  pid = fork();
    10f3:	e8 18 36 00 00       	call   4710 <fork>
  if(pid < 0){
    10f8:	83 c4 10             	add    $0x10,%esp
    10fb:	85 c0                	test   %eax,%eax
    10fd:	78 47                	js     1146 <exitiputtest+0x69>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    10ff:	0f 85 a1 00 00 00    	jne    11a6 <exitiputtest+0xc9>
    if(mkdir("iputdir") < 0){
    1105:	83 ec 0c             	sub    $0xc,%esp
    1108:	68 53 4b 00 00       	push   $0x4b53
    110d:	e8 6e 36 00 00       	call   4780 <mkdir>
    1112:	83 c4 10             	add    $0x10,%esp
    1115:	85 c0                	test   %eax,%eax
    1117:	78 45                	js     115e <exitiputtest+0x81>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
    1119:	83 ec 0c             	sub    $0xc,%esp
    111c:	68 53 4b 00 00       	push   $0x4b53
    1121:	e8 62 36 00 00       	call   4788 <chdir>
    1126:	83 c4 10             	add    $0x10,%esp
    1129:	85 c0                	test   %eax,%eax
    112b:	78 49                	js     1176 <exitiputtest+0x99>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
    112d:	83 ec 0c             	sub    $0xc,%esp
    1130:	68 50 4b 00 00       	push   $0x4b50
    1135:	e8 2e 36 00 00       	call   4768 <unlink>
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	85 c0                	test   %eax,%eax
    113f:	78 4d                	js     118e <exitiputtest+0xb1>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
    1141:	e8 d2 35 00 00       	call   4718 <exit>
    printf(stdout, "fork failed\n");
    1146:	83 ec 08             	sub    $0x8,%esp
    1149:	68 6d 5a 00 00       	push   $0x5a6d
    114e:	ff 35 b4 6b 00 00    	push   0x6bb4
    1154:	e8 24 37 00 00       	call   487d <printf>
    exit();
    1159:	e8 ba 35 00 00       	call   4718 <exit>
      printf(stdout, "mkdir failed\n");
    115e:	83 ec 08             	sub    $0x8,%esp
    1161:	68 2c 4b 00 00       	push   $0x4b2c
    1166:	ff 35 b4 6b 00 00    	push   0x6bb4
    116c:	e8 0c 37 00 00       	call   487d <printf>
      exit();
    1171:	e8 a2 35 00 00       	call   4718 <exit>
      printf(stdout, "child chdir failed\n");
    1176:	83 ec 08             	sub    $0x8,%esp
    1179:	68 96 4b 00 00       	push   $0x4b96
    117e:	ff 35 b4 6b 00 00    	push   0x6bb4
    1184:	e8 f4 36 00 00       	call   487d <printf>
      exit();
    1189:	e8 8a 35 00 00       	call   4718 <exit>
      printf(stdout, "unlink ../iputdir failed\n");
    118e:	83 ec 08             	sub    $0x8,%esp
    1191:	68 5b 4b 00 00       	push   $0x4b5b
    1196:	ff 35 b4 6b 00 00    	push   0x6bb4
    119c:	e8 dc 36 00 00       	call   487d <printf>
      exit();
    11a1:	e8 72 35 00 00       	call   4718 <exit>
  }
  wait();
    11a6:	e8 75 35 00 00       	call   4720 <wait>
  printf(stdout, "exitiput test ok\n");
    11ab:	83 ec 08             	sub    $0x8,%esp
    11ae:	68 aa 4b 00 00       	push   $0x4baa
    11b3:	ff 35 b4 6b 00 00    	push   0x6bb4
    11b9:	e8 bf 36 00 00       	call   487d <printf>
}
    11be:	83 c4 10             	add    $0x10,%esp
    11c1:	c9                   	leave  
    11c2:	c3                   	ret    

000011c3 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    11c3:	55                   	push   %ebp
    11c4:	89 e5                	mov    %esp,%ebp
    11c6:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
    11c9:	68 bc 4b 00 00       	push   $0x4bbc
    11ce:	ff 35 b4 6b 00 00    	push   0x6bb4
    11d4:	e8 a4 36 00 00       	call   487d <printf>
  if(mkdir("oidir") < 0){
    11d9:	c7 04 24 cb 4b 00 00 	movl   $0x4bcb,(%esp)
    11e0:	e8 9b 35 00 00       	call   4780 <mkdir>
    11e5:	83 c4 10             	add    $0x10,%esp
    11e8:	85 c0                	test   %eax,%eax
    11ea:	78 39                	js     1225 <openiputtest+0x62>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
    11ec:	e8 1f 35 00 00       	call   4710 <fork>
  if(pid < 0){
    11f1:	85 c0                	test   %eax,%eax
    11f3:	78 48                	js     123d <openiputtest+0x7a>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    11f5:	75 63                	jne    125a <openiputtest+0x97>
    int fd = open("oidir", O_RDWR);
    11f7:	83 ec 08             	sub    $0x8,%esp
    11fa:	6a 02                	push   $0x2
    11fc:	68 cb 4b 00 00       	push   $0x4bcb
    1201:	e8 52 35 00 00       	call   4758 <open>
    if(fd >= 0){
    1206:	83 c4 10             	add    $0x10,%esp
    1209:	85 c0                	test   %eax,%eax
    120b:	78 48                	js     1255 <openiputtest+0x92>
      printf(stdout, "open directory for write succeeded\n");
    120d:	83 ec 08             	sub    $0x8,%esp
    1210:	68 50 5b 00 00       	push   $0x5b50
    1215:	ff 35 b4 6b 00 00    	push   0x6bb4
    121b:	e8 5d 36 00 00       	call   487d <printf>
      exit();
    1220:	e8 f3 34 00 00       	call   4718 <exit>
    printf(stdout, "mkdir oidir failed\n");
    1225:	83 ec 08             	sub    $0x8,%esp
    1228:	68 d1 4b 00 00       	push   $0x4bd1
    122d:	ff 35 b4 6b 00 00    	push   0x6bb4
    1233:	e8 45 36 00 00       	call   487d <printf>
    exit();
    1238:	e8 db 34 00 00       	call   4718 <exit>
    printf(stdout, "fork failed\n");
    123d:	83 ec 08             	sub    $0x8,%esp
    1240:	68 6d 5a 00 00       	push   $0x5a6d
    1245:	ff 35 b4 6b 00 00    	push   0x6bb4
    124b:	e8 2d 36 00 00       	call   487d <printf>
    exit();
    1250:	e8 c3 34 00 00       	call   4718 <exit>
    }
    exit();
    1255:	e8 be 34 00 00       	call   4718 <exit>
  }
  sleep(1);
    125a:	83 ec 0c             	sub    $0xc,%esp
    125d:	6a 01                	push   $0x1
    125f:	e8 44 35 00 00       	call   47a8 <sleep>
  if(unlink("oidir") != 0){
    1264:	c7 04 24 cb 4b 00 00 	movl   $0x4bcb,(%esp)
    126b:	e8 f8 34 00 00       	call   4768 <unlink>
    1270:	83 c4 10             	add    $0x10,%esp
    1273:	85 c0                	test   %eax,%eax
    1275:	75 1d                	jne    1294 <openiputtest+0xd1>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
    1277:	e8 a4 34 00 00       	call   4720 <wait>
  printf(stdout, "openiput test ok\n");
    127c:	83 ec 08             	sub    $0x8,%esp
    127f:	68 f4 4b 00 00       	push   $0x4bf4
    1284:	ff 35 b4 6b 00 00    	push   0x6bb4
    128a:	e8 ee 35 00 00       	call   487d <printf>
}
    128f:	83 c4 10             	add    $0x10,%esp
    1292:	c9                   	leave  
    1293:	c3                   	ret    
    printf(stdout, "unlink failed\n");
    1294:	83 ec 08             	sub    $0x8,%esp
    1297:	68 e5 4b 00 00       	push   $0x4be5
    129c:	ff 35 b4 6b 00 00    	push   0x6bb4
    12a2:	e8 d6 35 00 00       	call   487d <printf>
    exit();
    12a7:	e8 6c 34 00 00       	call   4718 <exit>

000012ac <opentest>:

// simple file system tests

void
opentest(void)
{
    12ac:	55                   	push   %ebp
    12ad:	89 e5                	mov    %esp,%ebp
    12af:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
    12b2:	68 06 4c 00 00       	push   $0x4c06
    12b7:	ff 35 b4 6b 00 00    	push   0x6bb4
    12bd:	e8 bb 35 00 00       	call   487d <printf>
  fd = open("echo", 0);
    12c2:	83 c4 08             	add    $0x8,%esp
    12c5:	6a 00                	push   $0x0
    12c7:	68 11 4c 00 00       	push   $0x4c11
    12cc:	e8 87 34 00 00       	call   4758 <open>
  if(fd < 0){
    12d1:	83 c4 10             	add    $0x10,%esp
    12d4:	85 c0                	test   %eax,%eax
    12d6:	78 37                	js     130f <opentest+0x63>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
    12d8:	83 ec 0c             	sub    $0xc,%esp
    12db:	50                   	push   %eax
    12dc:	e8 5f 34 00 00       	call   4740 <close>
  fd = open("doesnotexist", 0);
    12e1:	83 c4 08             	add    $0x8,%esp
    12e4:	6a 00                	push   $0x0
    12e6:	68 29 4c 00 00       	push   $0x4c29
    12eb:	e8 68 34 00 00       	call   4758 <open>
  if(fd >= 0){
    12f0:	83 c4 10             	add    $0x10,%esp
    12f3:	85 c0                	test   %eax,%eax
    12f5:	79 30                	jns    1327 <opentest+0x7b>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
    12f7:	83 ec 08             	sub    $0x8,%esp
    12fa:	68 54 4c 00 00       	push   $0x4c54
    12ff:	ff 35 b4 6b 00 00    	push   0x6bb4
    1305:	e8 73 35 00 00       	call   487d <printf>
}
    130a:	83 c4 10             	add    $0x10,%esp
    130d:	c9                   	leave  
    130e:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
    130f:	83 ec 08             	sub    $0x8,%esp
    1312:	68 16 4c 00 00       	push   $0x4c16
    1317:	ff 35 b4 6b 00 00    	push   0x6bb4
    131d:	e8 5b 35 00 00       	call   487d <printf>
    exit();
    1322:	e8 f1 33 00 00       	call   4718 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
    1327:	83 ec 08             	sub    $0x8,%esp
    132a:	68 36 4c 00 00       	push   $0x4c36
    132f:	ff 35 b4 6b 00 00    	push   0x6bb4
    1335:	e8 43 35 00 00       	call   487d <printf>
    exit();
    133a:	e8 d9 33 00 00       	call   4718 <exit>

0000133f <writetest>:

void
writetest(void)
{
    133f:	55                   	push   %ebp
    1340:	89 e5                	mov    %esp,%ebp
    1342:	56                   	push   %esi
    1343:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
    1344:	83 ec 08             	sub    $0x8,%esp
    1347:	68 62 4c 00 00       	push   $0x4c62
    134c:	ff 35 b4 6b 00 00    	push   0x6bb4
    1352:	e8 26 35 00 00       	call   487d <printf>
  fd = open("small", O_CREATE|O_RDWR);
    1357:	83 c4 08             	add    $0x8,%esp
    135a:	68 02 02 00 00       	push   $0x202
    135f:	68 73 4c 00 00       	push   $0x4c73
    1364:	e8 ef 33 00 00       	call   4758 <open>
  if(fd >= 0){
    1369:	83 c4 10             	add    $0x10,%esp
    136c:	85 c0                	test   %eax,%eax
    136e:	78 57                	js     13c7 <writetest+0x88>
    1370:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
    1372:	83 ec 08             	sub    $0x8,%esp
    1375:	68 79 4c 00 00       	push   $0x4c79
    137a:	ff 35 b4 6b 00 00    	push   0x6bb4
    1380:	e8 f8 34 00 00       	call   487d <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    1385:	83 c4 10             	add    $0x10,%esp
    1388:	bb 00 00 00 00       	mov    $0x0,%ebx
    138d:	83 fb 63             	cmp    $0x63,%ebx
    1390:	7f 7f                	jg     1411 <writetest+0xd2>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
    1392:	83 ec 04             	sub    $0x4,%esp
    1395:	6a 0a                	push   $0xa
    1397:	68 b0 4c 00 00       	push   $0x4cb0
    139c:	56                   	push   %esi
    139d:	e8 96 33 00 00       	call   4738 <write>
    13a2:	83 c4 10             	add    $0x10,%esp
    13a5:	83 f8 0a             	cmp    $0xa,%eax
    13a8:	75 35                	jne    13df <writetest+0xa0>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
    13aa:	83 ec 04             	sub    $0x4,%esp
    13ad:	6a 0a                	push   $0xa
    13af:	68 bb 4c 00 00       	push   $0x4cbb
    13b4:	56                   	push   %esi
    13b5:	e8 7e 33 00 00       	call   4738 <write>
    13ba:	83 c4 10             	add    $0x10,%esp
    13bd:	83 f8 0a             	cmp    $0xa,%eax
    13c0:	75 36                	jne    13f8 <writetest+0xb9>
  for(i = 0; i < 100; i++){
    13c2:	83 c3 01             	add    $0x1,%ebx
    13c5:	eb c6                	jmp    138d <writetest+0x4e>
    printf(stdout, "error: creat small failed!\n");
    13c7:	83 ec 08             	sub    $0x8,%esp
    13ca:	68 94 4c 00 00       	push   $0x4c94
    13cf:	ff 35 b4 6b 00 00    	push   0x6bb4
    13d5:	e8 a3 34 00 00       	call   487d <printf>
    exit();
    13da:	e8 39 33 00 00       	call   4718 <exit>
      printf(stdout, "error: write aa %d new file failed\n", i);
    13df:	83 ec 04             	sub    $0x4,%esp
    13e2:	53                   	push   %ebx
    13e3:	68 74 5b 00 00       	push   $0x5b74
    13e8:	ff 35 b4 6b 00 00    	push   0x6bb4
    13ee:	e8 8a 34 00 00       	call   487d <printf>
      exit();
    13f3:	e8 20 33 00 00       	call   4718 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
    13f8:	83 ec 04             	sub    $0x4,%esp
    13fb:	53                   	push   %ebx
    13fc:	68 98 5b 00 00       	push   $0x5b98
    1401:	ff 35 b4 6b 00 00    	push   0x6bb4
    1407:	e8 71 34 00 00       	call   487d <printf>
      exit();
    140c:	e8 07 33 00 00       	call   4718 <exit>
    }
  }
  printf(stdout, "writes ok\n");
    1411:	83 ec 08             	sub    $0x8,%esp
    1414:	68 c6 4c 00 00       	push   $0x4cc6
    1419:	ff 35 b4 6b 00 00    	push   0x6bb4
    141f:	e8 59 34 00 00       	call   487d <printf>
  close(fd);
    1424:	89 34 24             	mov    %esi,(%esp)
    1427:	e8 14 33 00 00       	call   4740 <close>
  fd = open("small", O_RDONLY);
    142c:	83 c4 08             	add    $0x8,%esp
    142f:	6a 00                	push   $0x0
    1431:	68 73 4c 00 00       	push   $0x4c73
    1436:	e8 1d 33 00 00       	call   4758 <open>
    143b:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    143d:	83 c4 10             	add    $0x10,%esp
    1440:	85 c0                	test   %eax,%eax
    1442:	78 7b                	js     14bf <writetest+0x180>
    printf(stdout, "open small succeeded ok\n");
    1444:	83 ec 08             	sub    $0x8,%esp
    1447:	68 d1 4c 00 00       	push   $0x4cd1
    144c:	ff 35 b4 6b 00 00    	push   0x6bb4
    1452:	e8 26 34 00 00       	call   487d <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    1457:	83 c4 0c             	add    $0xc,%esp
    145a:	68 d0 07 00 00       	push   $0x7d0
    145f:	68 00 93 00 00       	push   $0x9300
    1464:	53                   	push   %ebx
    1465:	e8 c6 32 00 00       	call   4730 <read>
  if(i == 2000){
    146a:	83 c4 10             	add    $0x10,%esp
    146d:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    1472:	75 63                	jne    14d7 <writetest+0x198>
    printf(stdout, "read succeeded ok\n");
    1474:	83 ec 08             	sub    $0x8,%esp
    1477:	68 05 4d 00 00       	push   $0x4d05
    147c:	ff 35 b4 6b 00 00    	push   0x6bb4
    1482:	e8 f6 33 00 00       	call   487d <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    1487:	89 1c 24             	mov    %ebx,(%esp)
    148a:	e8 b1 32 00 00       	call   4740 <close>

  if(unlink("small") < 0){
    148f:	c7 04 24 73 4c 00 00 	movl   $0x4c73,(%esp)
    1496:	e8 cd 32 00 00       	call   4768 <unlink>
    149b:	83 c4 10             	add    $0x10,%esp
    149e:	85 c0                	test   %eax,%eax
    14a0:	78 4d                	js     14ef <writetest+0x1b0>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
    14a2:	83 ec 08             	sub    $0x8,%esp
    14a5:	68 2d 4d 00 00       	push   $0x4d2d
    14aa:	ff 35 b4 6b 00 00    	push   0x6bb4
    14b0:	e8 c8 33 00 00       	call   487d <printf>
}
    14b5:	83 c4 10             	add    $0x10,%esp
    14b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    14bb:	5b                   	pop    %ebx
    14bc:	5e                   	pop    %esi
    14bd:	5d                   	pop    %ebp
    14be:	c3                   	ret    
    printf(stdout, "error: open small failed!\n");
    14bf:	83 ec 08             	sub    $0x8,%esp
    14c2:	68 ea 4c 00 00       	push   $0x4cea
    14c7:	ff 35 b4 6b 00 00    	push   0x6bb4
    14cd:	e8 ab 33 00 00       	call   487d <printf>
    exit();
    14d2:	e8 41 32 00 00       	call   4718 <exit>
    printf(stdout, "read failed\n");
    14d7:	83 ec 08             	sub    $0x8,%esp
    14da:	68 31 50 00 00       	push   $0x5031
    14df:	ff 35 b4 6b 00 00    	push   0x6bb4
    14e5:	e8 93 33 00 00       	call   487d <printf>
    exit();
    14ea:	e8 29 32 00 00       	call   4718 <exit>
    printf(stdout, "unlink small failed\n");
    14ef:	83 ec 08             	sub    $0x8,%esp
    14f2:	68 18 4d 00 00       	push   $0x4d18
    14f7:	ff 35 b4 6b 00 00    	push   0x6bb4
    14fd:	e8 7b 33 00 00       	call   487d <printf>
    exit();
    1502:	e8 11 32 00 00       	call   4718 <exit>

00001507 <writetest1>:

void
writetest1(void)
{
    1507:	55                   	push   %ebp
    1508:	89 e5                	mov    %esp,%ebp
    150a:	56                   	push   %esi
    150b:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
    150c:	83 ec 08             	sub    $0x8,%esp
    150f:	68 41 4d 00 00       	push   $0x4d41
    1514:	ff 35 b4 6b 00 00    	push   0x6bb4
    151a:	e8 5e 33 00 00       	call   487d <printf>

  fd = open("big", O_CREATE|O_RDWR);
    151f:	83 c4 08             	add    $0x8,%esp
    1522:	68 02 02 00 00       	push   $0x202
    1527:	68 bb 4d 00 00       	push   $0x4dbb
    152c:	e8 27 32 00 00       	call   4758 <open>
  if(fd < 0){
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	85 c0                	test   %eax,%eax
    1536:	78 37                	js     156f <writetest1+0x68>
    1538:	89 c6                	mov    %eax,%esi
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    153a:	bb 00 00 00 00       	mov    $0x0,%ebx
    153f:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    1545:	77 59                	ja     15a0 <writetest1+0x99>
    ((int*)buf)[0] = i;
    1547:	89 1d 00 93 00 00    	mov    %ebx,0x9300
    if(write(fd, buf, 512) != 512){
    154d:	83 ec 04             	sub    $0x4,%esp
    1550:	68 00 02 00 00       	push   $0x200
    1555:	68 00 93 00 00       	push   $0x9300
    155a:	56                   	push   %esi
    155b:	e8 d8 31 00 00       	call   4738 <write>
    1560:	83 c4 10             	add    $0x10,%esp
    1563:	3d 00 02 00 00       	cmp    $0x200,%eax
    1568:	75 1d                	jne    1587 <writetest1+0x80>
  for(i = 0; i < MAXFILE; i++){
    156a:	83 c3 01             	add    $0x1,%ebx
    156d:	eb d0                	jmp    153f <writetest1+0x38>
    printf(stdout, "error: creat big failed!\n");
    156f:	83 ec 08             	sub    $0x8,%esp
    1572:	68 51 4d 00 00       	push   $0x4d51
    1577:	ff 35 b4 6b 00 00    	push   0x6bb4
    157d:	e8 fb 32 00 00       	call   487d <printf>
    exit();
    1582:	e8 91 31 00 00       	call   4718 <exit>
      printf(stdout, "error: write big file failed\n", i);
    1587:	83 ec 04             	sub    $0x4,%esp
    158a:	53                   	push   %ebx
    158b:	68 6b 4d 00 00       	push   $0x4d6b
    1590:	ff 35 b4 6b 00 00    	push   0x6bb4
    1596:	e8 e2 32 00 00       	call   487d <printf>
      exit();
    159b:	e8 78 31 00 00       	call   4718 <exit>
    }
  }

  close(fd);
    15a0:	83 ec 0c             	sub    $0xc,%esp
    15a3:	56                   	push   %esi
    15a4:	e8 97 31 00 00       	call   4740 <close>

  fd = open("big", O_RDONLY);
    15a9:	83 c4 08             	add    $0x8,%esp
    15ac:	6a 00                	push   $0x0
    15ae:	68 bb 4d 00 00       	push   $0x4dbb
    15b3:	e8 a0 31 00 00       	call   4758 <open>
    15b8:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    15ba:	83 c4 10             	add    $0x10,%esp
    15bd:	85 c0                	test   %eax,%eax
    15bf:	78 3c                	js     15fd <writetest1+0xf6>
    printf(stdout, "error: open big failed!\n");
    exit();
  }

  n = 0;
    15c1:	bb 00 00 00 00       	mov    $0x0,%ebx
  for(;;){
    i = read(fd, buf, 512);
    15c6:	83 ec 04             	sub    $0x4,%esp
    15c9:	68 00 02 00 00       	push   $0x200
    15ce:	68 00 93 00 00       	push   $0x9300
    15d3:	56                   	push   %esi
    15d4:	e8 57 31 00 00       	call   4730 <read>
    if(i == 0){
    15d9:	83 c4 10             	add    $0x10,%esp
    15dc:	85 c0                	test   %eax,%eax
    15de:	74 35                	je     1615 <writetest1+0x10e>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
    15e0:	3d 00 02 00 00       	cmp    $0x200,%eax
    15e5:	0f 85 84 00 00 00    	jne    166f <writetest1+0x168>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
    15eb:	a1 00 93 00 00       	mov    0x9300,%eax
    15f0:	39 d8                	cmp    %ebx,%eax
    15f2:	0f 85 90 00 00 00    	jne    1688 <writetest1+0x181>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
    15f8:	83 c3 01             	add    $0x1,%ebx
    i = read(fd, buf, 512);
    15fb:	eb c9                	jmp    15c6 <writetest1+0xbf>
    printf(stdout, "error: open big failed!\n");
    15fd:	83 ec 08             	sub    $0x8,%esp
    1600:	68 89 4d 00 00       	push   $0x4d89
    1605:	ff 35 b4 6b 00 00    	push   0x6bb4
    160b:	e8 6d 32 00 00       	call   487d <printf>
    exit();
    1610:	e8 03 31 00 00       	call   4718 <exit>
      if(n == MAXFILE - 1){
    1615:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    161b:	74 39                	je     1656 <writetest1+0x14f>
  }
  close(fd);
    161d:	83 ec 0c             	sub    $0xc,%esp
    1620:	56                   	push   %esi
    1621:	e8 1a 31 00 00       	call   4740 <close>
  if(unlink("big") < 0){
    1626:	c7 04 24 bb 4d 00 00 	movl   $0x4dbb,(%esp)
    162d:	e8 36 31 00 00       	call   4768 <unlink>
    1632:	83 c4 10             	add    $0x10,%esp
    1635:	85 c0                	test   %eax,%eax
    1637:	78 66                	js     169f <writetest1+0x198>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
    1639:	83 ec 08             	sub    $0x8,%esp
    163c:	68 e2 4d 00 00       	push   $0x4de2
    1641:	ff 35 b4 6b 00 00    	push   0x6bb4
    1647:	e8 31 32 00 00       	call   487d <printf>
}
    164c:	83 c4 10             	add    $0x10,%esp
    164f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1652:	5b                   	pop    %ebx
    1653:	5e                   	pop    %esi
    1654:	5d                   	pop    %ebp
    1655:	c3                   	ret    
        printf(stdout, "read only %d blocks from big", n);
    1656:	83 ec 04             	sub    $0x4,%esp
    1659:	53                   	push   %ebx
    165a:	68 a2 4d 00 00       	push   $0x4da2
    165f:	ff 35 b4 6b 00 00    	push   0x6bb4
    1665:	e8 13 32 00 00       	call   487d <printf>
        exit();
    166a:	e8 a9 30 00 00       	call   4718 <exit>
      printf(stdout, "read failed %d\n", i);
    166f:	83 ec 04             	sub    $0x4,%esp
    1672:	50                   	push   %eax
    1673:	68 bf 4d 00 00       	push   $0x4dbf
    1678:	ff 35 b4 6b 00 00    	push   0x6bb4
    167e:	e8 fa 31 00 00       	call   487d <printf>
      exit();
    1683:	e8 90 30 00 00       	call   4718 <exit>
      printf(stdout, "read content of block %d is %d\n",
    1688:	50                   	push   %eax
    1689:	53                   	push   %ebx
    168a:	68 bc 5b 00 00       	push   $0x5bbc
    168f:	ff 35 b4 6b 00 00    	push   0x6bb4
    1695:	e8 e3 31 00 00       	call   487d <printf>
      exit();
    169a:	e8 79 30 00 00       	call   4718 <exit>
    printf(stdout, "unlink big failed\n");
    169f:	83 ec 08             	sub    $0x8,%esp
    16a2:	68 cf 4d 00 00       	push   $0x4dcf
    16a7:	ff 35 b4 6b 00 00    	push   0x6bb4
    16ad:	e8 cb 31 00 00       	call   487d <printf>
    exit();
    16b2:	e8 61 30 00 00       	call   4718 <exit>

000016b7 <createtest>:

void
createtest(void)
{
    16b7:	55                   	push   %ebp
    16b8:	89 e5                	mov    %esp,%ebp
    16ba:	53                   	push   %ebx
    16bb:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    16be:	68 dc 5b 00 00       	push   $0x5bdc
    16c3:	ff 35 b4 6b 00 00    	push   0x6bb4
    16c9:	e8 af 31 00 00       	call   487d <printf>

  name[0] = 'a';
    16ce:	c6 05 f0 92 00 00 61 	movb   $0x61,0x92f0
  name[2] = '\0';
    16d5:	c6 05 f2 92 00 00 00 	movb   $0x0,0x92f2
  for(i = 0; i < 52; i++){
    16dc:	83 c4 10             	add    $0x10,%esp
    16df:	bb 00 00 00 00       	mov    $0x0,%ebx
    16e4:	eb 28                	jmp    170e <createtest+0x57>
    name[1] = '0' + i;
    16e6:	8d 43 30             	lea    0x30(%ebx),%eax
    16e9:	a2 f1 92 00 00       	mov    %al,0x92f1
    fd = open(name, O_CREATE|O_RDWR);
    16ee:	83 ec 08             	sub    $0x8,%esp
    16f1:	68 02 02 00 00       	push   $0x202
    16f6:	68 f0 92 00 00       	push   $0x92f0
    16fb:	e8 58 30 00 00       	call   4758 <open>
    close(fd);
    1700:	89 04 24             	mov    %eax,(%esp)
    1703:	e8 38 30 00 00       	call   4740 <close>
  for(i = 0; i < 52; i++){
    1708:	83 c3 01             	add    $0x1,%ebx
    170b:	83 c4 10             	add    $0x10,%esp
    170e:	83 fb 33             	cmp    $0x33,%ebx
    1711:	7e d3                	jle    16e6 <createtest+0x2f>
  }
  name[0] = 'a';
    1713:	c6 05 f0 92 00 00 61 	movb   $0x61,0x92f0
  name[2] = '\0';
    171a:	c6 05 f2 92 00 00 00 	movb   $0x0,0x92f2
  for(i = 0; i < 52; i++){
    1721:	bb 00 00 00 00       	mov    $0x0,%ebx
    1726:	eb 1b                	jmp    1743 <createtest+0x8c>
    name[1] = '0' + i;
    1728:	8d 43 30             	lea    0x30(%ebx),%eax
    172b:	a2 f1 92 00 00       	mov    %al,0x92f1
    unlink(name);
    1730:	83 ec 0c             	sub    $0xc,%esp
    1733:	68 f0 92 00 00       	push   $0x92f0
    1738:	e8 2b 30 00 00       	call   4768 <unlink>
  for(i = 0; i < 52; i++){
    173d:	83 c3 01             	add    $0x1,%ebx
    1740:	83 c4 10             	add    $0x10,%esp
    1743:	83 fb 33             	cmp    $0x33,%ebx
    1746:	7e e0                	jle    1728 <createtest+0x71>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    1748:	83 ec 08             	sub    $0x8,%esp
    174b:	68 04 5c 00 00       	push   $0x5c04
    1750:	ff 35 b4 6b 00 00    	push   0x6bb4
    1756:	e8 22 31 00 00       	call   487d <printf>
}
    175b:	83 c4 10             	add    $0x10,%esp
    175e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1761:	c9                   	leave  
    1762:	c3                   	ret    

00001763 <dirtest>:

void dirtest(void)
{
    1763:	55                   	push   %ebp
    1764:	89 e5                	mov    %esp,%ebp
    1766:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
    1769:	68 f0 4d 00 00       	push   $0x4df0
    176e:	ff 35 b4 6b 00 00    	push   0x6bb4
    1774:	e8 04 31 00 00       	call   487d <printf>

  if(mkdir("dir0") < 0){
    1779:	c7 04 24 fc 4d 00 00 	movl   $0x4dfc,(%esp)
    1780:	e8 fb 2f 00 00       	call   4780 <mkdir>
    1785:	83 c4 10             	add    $0x10,%esp
    1788:	85 c0                	test   %eax,%eax
    178a:	78 54                	js     17e0 <dirtest+0x7d>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    178c:	83 ec 0c             	sub    $0xc,%esp
    178f:	68 fc 4d 00 00       	push   $0x4dfc
    1794:	e8 ef 2f 00 00       	call   4788 <chdir>
    1799:	83 c4 10             	add    $0x10,%esp
    179c:	85 c0                	test   %eax,%eax
    179e:	78 58                	js     17f8 <dirtest+0x95>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    17a0:	83 ec 0c             	sub    $0xc,%esp
    17a3:	68 a1 53 00 00       	push   $0x53a1
    17a8:	e8 db 2f 00 00       	call   4788 <chdir>
    17ad:	83 c4 10             	add    $0x10,%esp
    17b0:	85 c0                	test   %eax,%eax
    17b2:	78 5c                	js     1810 <dirtest+0xad>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    17b4:	83 ec 0c             	sub    $0xc,%esp
    17b7:	68 fc 4d 00 00       	push   $0x4dfc
    17bc:	e8 a7 2f 00 00       	call   4768 <unlink>
    17c1:	83 c4 10             	add    $0x10,%esp
    17c4:	85 c0                	test   %eax,%eax
    17c6:	78 60                	js     1828 <dirtest+0xc5>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
    17c8:	83 ec 08             	sub    $0x8,%esp
    17cb:	68 39 4e 00 00       	push   $0x4e39
    17d0:	ff 35 b4 6b 00 00    	push   0x6bb4
    17d6:	e8 a2 30 00 00       	call   487d <printf>
}
    17db:	83 c4 10             	add    $0x10,%esp
    17de:	c9                   	leave  
    17df:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
    17e0:	83 ec 08             	sub    $0x8,%esp
    17e3:	68 2c 4b 00 00       	push   $0x4b2c
    17e8:	ff 35 b4 6b 00 00    	push   0x6bb4
    17ee:	e8 8a 30 00 00       	call   487d <printf>
    exit();
    17f3:	e8 20 2f 00 00       	call   4718 <exit>
    printf(stdout, "chdir dir0 failed\n");
    17f8:	83 ec 08             	sub    $0x8,%esp
    17fb:	68 01 4e 00 00       	push   $0x4e01
    1800:	ff 35 b4 6b 00 00    	push   0x6bb4
    1806:	e8 72 30 00 00       	call   487d <printf>
    exit();
    180b:	e8 08 2f 00 00       	call   4718 <exit>
    printf(stdout, "chdir .. failed\n");
    1810:	83 ec 08             	sub    $0x8,%esp
    1813:	68 14 4e 00 00       	push   $0x4e14
    1818:	ff 35 b4 6b 00 00    	push   0x6bb4
    181e:	e8 5a 30 00 00       	call   487d <printf>
    exit();
    1823:	e8 f0 2e 00 00       	call   4718 <exit>
    printf(stdout, "unlink dir0 failed\n");
    1828:	83 ec 08             	sub    $0x8,%esp
    182b:	68 25 4e 00 00       	push   $0x4e25
    1830:	ff 35 b4 6b 00 00    	push   0x6bb4
    1836:	e8 42 30 00 00       	call   487d <printf>
    exit();
    183b:	e8 d8 2e 00 00       	call   4718 <exit>

00001840 <exectest>:

void
exectest(void)
{
    1840:	55                   	push   %ebp
    1841:	89 e5                	mov    %esp,%ebp
    1843:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
    1846:	68 48 4e 00 00       	push   $0x4e48
    184b:	ff 35 b4 6b 00 00    	push   0x6bb4
    1851:	e8 27 30 00 00       	call   487d <printf>
  if(exec("echo", echoargv) < 0){
    1856:	83 c4 08             	add    $0x8,%esp
    1859:	68 b8 6b 00 00       	push   $0x6bb8
    185e:	68 11 4c 00 00       	push   $0x4c11
    1863:	e8 e8 2e 00 00       	call   4750 <exec>
    1868:	83 c4 10             	add    $0x10,%esp
    186b:	85 c0                	test   %eax,%eax
    186d:	78 02                	js     1871 <exectest+0x31>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
    186f:	c9                   	leave  
    1870:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
    1871:	83 ec 08             	sub    $0x8,%esp
    1874:	68 53 4e 00 00       	push   $0x4e53
    1879:	ff 35 b4 6b 00 00    	push   0x6bb4
    187f:	e8 f9 2f 00 00       	call   487d <printf>
    exit();
    1884:	e8 8f 2e 00 00       	call   4718 <exit>

00001889 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    1889:	55                   	push   %ebp
    188a:	89 e5                	mov    %esp,%ebp
    188c:	57                   	push   %edi
    188d:	56                   	push   %esi
    188e:	53                   	push   %ebx
    188f:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    1892:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1895:	50                   	push   %eax
    1896:	e8 8d 2e 00 00       	call   4728 <pipe>
    189b:	83 c4 10             	add    $0x10,%esp
    189e:	85 c0                	test   %eax,%eax
    18a0:	75 74                	jne    1916 <pipe1+0x8d>
    18a2:	89 c6                	mov    %eax,%esi
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
    18a4:	e8 67 2e 00 00       	call   4710 <fork>
    18a9:	89 c7                	mov    %eax,%edi
  seq = 0;
  if(pid == 0){
    18ab:	85 c0                	test   %eax,%eax
    18ad:	74 7b                	je     192a <pipe1+0xa1>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    18af:	0f 8e 60 01 00 00    	jle    1a15 <pipe1+0x18c>
    close(fds[1]);
    18b5:	83 ec 0c             	sub    $0xc,%esp
    18b8:	ff 75 e4             	push   -0x1c(%ebp)
    18bb:	e8 80 2e 00 00       	call   4740 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
    18c0:	83 c4 10             	add    $0x10,%esp
    total = 0;
    18c3:	89 75 d0             	mov    %esi,-0x30(%ebp)
  seq = 0;
    18c6:	89 f3                	mov    %esi,%ebx
    cc = 1;
    18c8:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
    18cf:	83 ec 04             	sub    $0x4,%esp
    18d2:	ff 75 d4             	push   -0x2c(%ebp)
    18d5:	68 00 93 00 00       	push   $0x9300
    18da:	ff 75 e0             	push   -0x20(%ebp)
    18dd:	e8 4e 2e 00 00       	call   4730 <read>
    18e2:	89 c7                	mov    %eax,%edi
    18e4:	83 c4 10             	add    $0x10,%esp
    18e7:	85 c0                	test   %eax,%eax
    18e9:	0f 8e e2 00 00 00    	jle    19d1 <pipe1+0x148>
      for(i = 0; i < n; i++){
    18ef:	89 f0                	mov    %esi,%eax
    18f1:	89 d9                	mov    %ebx,%ecx
    18f3:	39 f8                	cmp    %edi,%eax
    18f5:	0f 8d b4 00 00 00    	jge    19af <pipe1+0x126>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    18fb:	0f be 98 00 93 00 00 	movsbl 0x9300(%eax),%ebx
    1902:	8d 51 01             	lea    0x1(%ecx),%edx
    1905:	31 cb                	xor    %ecx,%ebx
    1907:	84 db                	test   %bl,%bl
    1909:	0f 85 86 00 00 00    	jne    1995 <pipe1+0x10c>
      for(i = 0; i < n; i++){
    190f:	83 c0 01             	add    $0x1,%eax
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1912:	89 d1                	mov    %edx,%ecx
    1914:	eb dd                	jmp    18f3 <pipe1+0x6a>
    printf(1, "pipe() failed\n");
    1916:	83 ec 08             	sub    $0x8,%esp
    1919:	68 65 4e 00 00       	push   $0x4e65
    191e:	6a 01                	push   $0x1
    1920:	e8 58 2f 00 00       	call   487d <printf>
    exit();
    1925:	e8 ee 2d 00 00       	call   4718 <exit>
    close(fds[0]);
    192a:	83 ec 0c             	sub    $0xc,%esp
    192d:	ff 75 e0             	push   -0x20(%ebp)
    1930:	e8 0b 2e 00 00       	call   4740 <close>
    for(n = 0; n < 5; n++){
    1935:	83 c4 10             	add    $0x10,%esp
    1938:	89 fe                	mov    %edi,%esi
  seq = 0;
    193a:	89 fb                	mov    %edi,%ebx
    for(n = 0; n < 5; n++){
    193c:	eb 35                	jmp    1973 <pipe1+0xea>
        buf[i] = seq++;
    193e:	88 98 00 93 00 00    	mov    %bl,0x9300(%eax)
      for(i = 0; i < 1033; i++)
    1944:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
    1947:	8d 5b 01             	lea    0x1(%ebx),%ebx
      for(i = 0; i < 1033; i++)
    194a:	3d 08 04 00 00       	cmp    $0x408,%eax
    194f:	7e ed                	jle    193e <pipe1+0xb5>
      if(write(fds[1], buf, 1033) != 1033){
    1951:	83 ec 04             	sub    $0x4,%esp
    1954:	68 09 04 00 00       	push   $0x409
    1959:	68 00 93 00 00       	push   $0x9300
    195e:	ff 75 e4             	push   -0x1c(%ebp)
    1961:	e8 d2 2d 00 00       	call   4738 <write>
    1966:	83 c4 10             	add    $0x10,%esp
    1969:	3d 09 04 00 00       	cmp    $0x409,%eax
    196e:	75 0c                	jne    197c <pipe1+0xf3>
    for(n = 0; n < 5; n++){
    1970:	83 c6 01             	add    $0x1,%esi
    1973:	83 fe 04             	cmp    $0x4,%esi
    1976:	7f 18                	jg     1990 <pipe1+0x107>
      for(i = 0; i < 1033; i++)
    1978:	89 f8                	mov    %edi,%eax
    197a:	eb ce                	jmp    194a <pipe1+0xc1>
        printf(1, "pipe1 oops 1\n");
    197c:	83 ec 08             	sub    $0x8,%esp
    197f:	68 74 4e 00 00       	push   $0x4e74
    1984:	6a 01                	push   $0x1
    1986:	e8 f2 2e 00 00       	call   487d <printf>
        exit();
    198b:	e8 88 2d 00 00       	call   4718 <exit>
    exit();
    1990:	e8 83 2d 00 00       	call   4718 <exit>
          printf(1, "pipe1 oops 2\n");
    1995:	83 ec 08             	sub    $0x8,%esp
    1998:	68 82 4e 00 00       	push   $0x4e82
    199d:	6a 01                	push   $0x1
    199f:	e8 d9 2e 00 00       	call   487d <printf>
          return;
    19a4:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
    19a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19aa:	5b                   	pop    %ebx
    19ab:	5e                   	pop    %esi
    19ac:	5f                   	pop    %edi
    19ad:	5d                   	pop    %ebp
    19ae:	c3                   	ret    
      total += n;
    19af:	89 cb                	mov    %ecx,%ebx
    19b1:	01 7d d0             	add    %edi,-0x30(%ebp)
      cc = cc * 2;
    19b4:	d1 65 d4             	shll   -0x2c(%ebp)
    19b7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      if(cc > sizeof(buf))
    19ba:	3d 00 20 00 00       	cmp    $0x2000,%eax
    19bf:	0f 86 0a ff ff ff    	jbe    18cf <pipe1+0x46>
        cc = sizeof(buf);
    19c5:	c7 45 d4 00 20 00 00 	movl   $0x2000,-0x2c(%ebp)
    19cc:	e9 fe fe ff ff       	jmp    18cf <pipe1+0x46>
    if(total != 5 * 1033){
    19d1:	81 7d d0 2d 14 00 00 	cmpl   $0x142d,-0x30(%ebp)
    19d8:	75 24                	jne    19fe <pipe1+0x175>
    close(fds[0]);
    19da:	83 ec 0c             	sub    $0xc,%esp
    19dd:	ff 75 e0             	push   -0x20(%ebp)
    19e0:	e8 5b 2d 00 00       	call   4740 <close>
    wait();
    19e5:	e8 36 2d 00 00       	call   4720 <wait>
  printf(1, "pipe1 ok\n");
    19ea:	83 c4 08             	add    $0x8,%esp
    19ed:	68 a7 4e 00 00       	push   $0x4ea7
    19f2:	6a 01                	push   $0x1
    19f4:	e8 84 2e 00 00       	call   487d <printf>
    19f9:	83 c4 10             	add    $0x10,%esp
    19fc:	eb a9                	jmp    19a7 <pipe1+0x11e>
      printf(1, "pipe1 oops 3 total %d\n", total);
    19fe:	83 ec 04             	sub    $0x4,%esp
    1a01:	ff 75 d0             	push   -0x30(%ebp)
    1a04:	68 90 4e 00 00       	push   $0x4e90
    1a09:	6a 01                	push   $0x1
    1a0b:	e8 6d 2e 00 00       	call   487d <printf>
      exit();
    1a10:	e8 03 2d 00 00       	call   4718 <exit>
    printf(1, "fork() failed\n");
    1a15:	83 ec 08             	sub    $0x8,%esp
    1a18:	68 b1 4e 00 00       	push   $0x4eb1
    1a1d:	6a 01                	push   $0x1
    1a1f:	e8 59 2e 00 00       	call   487d <printf>
    exit();
    1a24:	e8 ef 2c 00 00       	call   4718 <exit>

00001a29 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    1a29:	55                   	push   %ebp
    1a2a:	89 e5                	mov    %esp,%ebp
    1a2c:	57                   	push   %edi
    1a2d:	56                   	push   %esi
    1a2e:	53                   	push   %ebx
    1a2f:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    1a32:	68 c0 4e 00 00       	push   $0x4ec0
    1a37:	6a 01                	push   $0x1
    1a39:	e8 3f 2e 00 00       	call   487d <printf>
  pid1 = fork();
    1a3e:	e8 cd 2c 00 00       	call   4710 <fork>
  if(pid1 == 0)
    1a43:	83 c4 10             	add    $0x10,%esp
    1a46:	85 c0                	test   %eax,%eax
    1a48:	75 02                	jne    1a4c <preempt+0x23>
    for(;;)
    1a4a:	eb fe                	jmp    1a4a <preempt+0x21>
    1a4c:	89 c3                	mov    %eax,%ebx
      ;

  pid2 = fork();
    1a4e:	e8 bd 2c 00 00       	call   4710 <fork>
    1a53:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
    1a55:	85 c0                	test   %eax,%eax
    1a57:	75 02                	jne    1a5b <preempt+0x32>
    for(;;)
    1a59:	eb fe                	jmp    1a59 <preempt+0x30>
      ;

  pipe(pfds);
    1a5b:	83 ec 0c             	sub    $0xc,%esp
    1a5e:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1a61:	50                   	push   %eax
    1a62:	e8 c1 2c 00 00       	call   4728 <pipe>
  pid3 = fork();
    1a67:	e8 a4 2c 00 00       	call   4710 <fork>
    1a6c:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
    1a6e:	83 c4 10             	add    $0x10,%esp
    1a71:	85 c0                	test   %eax,%eax
    1a73:	75 49                	jne    1abe <preempt+0x95>
    close(pfds[0]);
    1a75:	83 ec 0c             	sub    $0xc,%esp
    1a78:	ff 75 e0             	push   -0x20(%ebp)
    1a7b:	e8 c0 2c 00 00       	call   4740 <close>
    if(write(pfds[1], "x", 1) != 1)
    1a80:	83 c4 0c             	add    $0xc,%esp
    1a83:	6a 01                	push   $0x1
    1a85:	68 85 54 00 00       	push   $0x5485
    1a8a:	ff 75 e4             	push   -0x1c(%ebp)
    1a8d:	e8 a6 2c 00 00       	call   4738 <write>
    1a92:	83 c4 10             	add    $0x10,%esp
    1a95:	83 f8 01             	cmp    $0x1,%eax
    1a98:	75 10                	jne    1aaa <preempt+0x81>
      printf(1, "preempt write error");
    close(pfds[1]);
    1a9a:	83 ec 0c             	sub    $0xc,%esp
    1a9d:	ff 75 e4             	push   -0x1c(%ebp)
    1aa0:	e8 9b 2c 00 00       	call   4740 <close>
    1aa5:	83 c4 10             	add    $0x10,%esp
    for(;;)
    1aa8:	eb fe                	jmp    1aa8 <preempt+0x7f>
      printf(1, "preempt write error");
    1aaa:	83 ec 08             	sub    $0x8,%esp
    1aad:	68 ca 4e 00 00       	push   $0x4eca
    1ab2:	6a 01                	push   $0x1
    1ab4:	e8 c4 2d 00 00       	call   487d <printf>
    1ab9:	83 c4 10             	add    $0x10,%esp
    1abc:	eb dc                	jmp    1a9a <preempt+0x71>
      ;
  }

  close(pfds[1]);
    1abe:	83 ec 0c             	sub    $0xc,%esp
    1ac1:	ff 75 e4             	push   -0x1c(%ebp)
    1ac4:	e8 77 2c 00 00       	call   4740 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1ac9:	83 c4 0c             	add    $0xc,%esp
    1acc:	68 00 20 00 00       	push   $0x2000
    1ad1:	68 00 93 00 00       	push   $0x9300
    1ad6:	ff 75 e0             	push   -0x20(%ebp)
    1ad9:	e8 52 2c 00 00       	call   4730 <read>
    1ade:	83 c4 10             	add    $0x10,%esp
    1ae1:	83 f8 01             	cmp    $0x1,%eax
    1ae4:	74 1a                	je     1b00 <preempt+0xd7>
    printf(1, "preempt read error");
    1ae6:	83 ec 08             	sub    $0x8,%esp
    1ae9:	68 de 4e 00 00       	push   $0x4ede
    1aee:	6a 01                	push   $0x1
    1af0:	e8 88 2d 00 00       	call   487d <printf>
    return;
    1af5:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
    1af8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1afb:	5b                   	pop    %ebx
    1afc:	5e                   	pop    %esi
    1afd:	5f                   	pop    %edi
    1afe:	5d                   	pop    %ebp
    1aff:	c3                   	ret    
  close(pfds[0]);
    1b00:	83 ec 0c             	sub    $0xc,%esp
    1b03:	ff 75 e0             	push   -0x20(%ebp)
    1b06:	e8 35 2c 00 00       	call   4740 <close>
  printf(1, "kill... ");
    1b0b:	83 c4 08             	add    $0x8,%esp
    1b0e:	68 f1 4e 00 00       	push   $0x4ef1
    1b13:	6a 01                	push   $0x1
    1b15:	e8 63 2d 00 00       	call   487d <printf>
  kill(pid1);
    1b1a:	89 1c 24             	mov    %ebx,(%esp)
    1b1d:	e8 26 2c 00 00       	call   4748 <kill>
  kill(pid2);
    1b22:	89 34 24             	mov    %esi,(%esp)
    1b25:	e8 1e 2c 00 00       	call   4748 <kill>
  kill(pid3);
    1b2a:	89 3c 24             	mov    %edi,(%esp)
    1b2d:	e8 16 2c 00 00       	call   4748 <kill>
  printf(1, "wait... ");
    1b32:	83 c4 08             	add    $0x8,%esp
    1b35:	68 fa 4e 00 00       	push   $0x4efa
    1b3a:	6a 01                	push   $0x1
    1b3c:	e8 3c 2d 00 00       	call   487d <printf>
  wait();
    1b41:	e8 da 2b 00 00       	call   4720 <wait>
  wait();
    1b46:	e8 d5 2b 00 00       	call   4720 <wait>
  wait();
    1b4b:	e8 d0 2b 00 00       	call   4720 <wait>
  printf(1, "preempt ok\n");
    1b50:	83 c4 08             	add    $0x8,%esp
    1b53:	68 03 4f 00 00       	push   $0x4f03
    1b58:	6a 01                	push   $0x1
    1b5a:	e8 1e 2d 00 00       	call   487d <printf>
    1b5f:	83 c4 10             	add    $0x10,%esp
    1b62:	eb 94                	jmp    1af8 <preempt+0xcf>

00001b64 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
    1b64:	55                   	push   %ebp
    1b65:	89 e5                	mov    %esp,%ebp
    1b67:	56                   	push   %esi
    1b68:	53                   	push   %ebx
  int i, pid;

  for(i = 0; i < 100; i++){
    1b69:	be 00 00 00 00       	mov    $0x0,%esi
    1b6e:	83 fe 63             	cmp    $0x63,%esi
    1b71:	7f 4d                	jg     1bc0 <exitwait+0x5c>
    pid = fork();
    1b73:	e8 98 2b 00 00       	call   4710 <fork>
    1b78:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1b7a:	85 c0                	test   %eax,%eax
    1b7c:	78 10                	js     1b8e <exitwait+0x2a>
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
    1b7e:	74 3b                	je     1bbb <exitwait+0x57>
      if(wait() != pid){
    1b80:	e8 9b 2b 00 00       	call   4720 <wait>
    1b85:	39 d8                	cmp    %ebx,%eax
    1b87:	75 1e                	jne    1ba7 <exitwait+0x43>
  for(i = 0; i < 100; i++){
    1b89:	83 c6 01             	add    $0x1,%esi
    1b8c:	eb e0                	jmp    1b6e <exitwait+0xa>
      printf(1, "fork failed\n");
    1b8e:	83 ec 08             	sub    $0x8,%esp
    1b91:	68 6d 5a 00 00       	push   $0x5a6d
    1b96:	6a 01                	push   $0x1
    1b98:	e8 e0 2c 00 00       	call   487d <printf>
      return;
    1b9d:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
    1ba0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1ba3:	5b                   	pop    %ebx
    1ba4:	5e                   	pop    %esi
    1ba5:	5d                   	pop    %ebp
    1ba6:	c3                   	ret    
        printf(1, "wait wrong pid\n");
    1ba7:	83 ec 08             	sub    $0x8,%esp
    1baa:	68 0f 4f 00 00       	push   $0x4f0f
    1baf:	6a 01                	push   $0x1
    1bb1:	e8 c7 2c 00 00       	call   487d <printf>
        return;
    1bb6:	83 c4 10             	add    $0x10,%esp
    1bb9:	eb e5                	jmp    1ba0 <exitwait+0x3c>
      exit();
    1bbb:	e8 58 2b 00 00       	call   4718 <exit>
  printf(1, "exitwait ok\n");
    1bc0:	83 ec 08             	sub    $0x8,%esp
    1bc3:	68 1f 4f 00 00       	push   $0x4f1f
    1bc8:	6a 01                	push   $0x1
    1bca:	e8 ae 2c 00 00       	call   487d <printf>
    1bcf:	83 c4 10             	add    $0x10,%esp
    1bd2:	eb cc                	jmp    1ba0 <exitwait+0x3c>

00001bd4 <mem>:

void
mem(void)
{
    1bd4:	55                   	push   %ebp
    1bd5:	89 e5                	mov    %esp,%ebp
    1bd7:	57                   	push   %edi
    1bd8:	56                   	push   %esi
    1bd9:	53                   	push   %ebx
    1bda:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    1bdd:	68 2c 4f 00 00       	push   $0x4f2c
    1be2:	6a 01                	push   $0x1
    1be4:	e8 94 2c 00 00       	call   487d <printf>
  ppid = getpid();
    1be9:	e8 aa 2b 00 00       	call   4798 <getpid>
    1bee:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
    1bf0:	e8 1b 2b 00 00       	call   4710 <fork>
    1bf5:	83 c4 10             	add    $0x10,%esp
    1bf8:	85 c0                	test   %eax,%eax
    1bfa:	0f 85 82 00 00 00    	jne    1c82 <mem+0xae>
    m1 = 0;
    1c00:	bb 00 00 00 00       	mov    $0x0,%ebx
    1c05:	eb 04                	jmp    1c0b <mem+0x37>
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
    1c07:	89 18                	mov    %ebx,(%eax)
      m1 = m2;
    1c09:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
    1c0b:	83 ec 0c             	sub    $0xc,%esp
    1c0e:	68 11 27 00 00       	push   $0x2711
    1c13:	e8 8b 2e 00 00       	call   4aa3 <malloc>
    1c18:	83 c4 10             	add    $0x10,%esp
    1c1b:	85 c0                	test   %eax,%eax
    1c1d:	75 e8                	jne    1c07 <mem+0x33>
    1c1f:	eb 10                	jmp    1c31 <mem+0x5d>
    }
    while(m1){
      m2 = *(char**)m1;
    1c21:	8b 3b                	mov    (%ebx),%edi
      free(m1);
    1c23:	83 ec 0c             	sub    $0xc,%esp
    1c26:	53                   	push   %ebx
    1c27:	e8 b7 2d 00 00       	call   49e3 <free>
    1c2c:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
    1c2f:	89 fb                	mov    %edi,%ebx
    while(m1){
    1c31:	85 db                	test   %ebx,%ebx
    1c33:	75 ec                	jne    1c21 <mem+0x4d>
    }
    m1 = malloc(1024*20);
    1c35:	83 ec 0c             	sub    $0xc,%esp
    1c38:	68 00 50 00 00       	push   $0x5000
    1c3d:	e8 61 2e 00 00       	call   4aa3 <malloc>
    if(m1 == 0){
    1c42:	83 c4 10             	add    $0x10,%esp
    1c45:	85 c0                	test   %eax,%eax
    1c47:	74 1d                	je     1c66 <mem+0x92>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
    1c49:	83 ec 0c             	sub    $0xc,%esp
    1c4c:	50                   	push   %eax
    1c4d:	e8 91 2d 00 00       	call   49e3 <free>
    printf(1, "mem ok\n");
    1c52:	83 c4 08             	add    $0x8,%esp
    1c55:	68 50 4f 00 00       	push   $0x4f50
    1c5a:	6a 01                	push   $0x1
    1c5c:	e8 1c 2c 00 00       	call   487d <printf>
    exit();
    1c61:	e8 b2 2a 00 00       	call   4718 <exit>
      printf(1, "couldn't allocate mem?!!\n");
    1c66:	83 ec 08             	sub    $0x8,%esp
    1c69:	68 36 4f 00 00       	push   $0x4f36
    1c6e:	6a 01                	push   $0x1
    1c70:	e8 08 2c 00 00       	call   487d <printf>
      kill(ppid);
    1c75:	89 34 24             	mov    %esi,(%esp)
    1c78:	e8 cb 2a 00 00       	call   4748 <kill>
      exit();
    1c7d:	e8 96 2a 00 00       	call   4718 <exit>
  } else {
    wait();
    1c82:	e8 99 2a 00 00       	call   4720 <wait>
  }
}
    1c87:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c8a:	5b                   	pop    %ebx
    1c8b:	5e                   	pop    %esi
    1c8c:	5f                   	pop    %edi
    1c8d:	5d                   	pop    %ebp
    1c8e:	c3                   	ret    

00001c8f <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    1c8f:	55                   	push   %ebp
    1c90:	89 e5                	mov    %esp,%ebp
    1c92:	57                   	push   %edi
    1c93:	56                   	push   %esi
    1c94:	53                   	push   %ebx
    1c95:	83 ec 24             	sub    $0x24,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    1c98:	68 58 4f 00 00       	push   $0x4f58
    1c9d:	6a 01                	push   $0x1
    1c9f:	e8 d9 2b 00 00       	call   487d <printf>

  unlink("sharedfd");
    1ca4:	c7 04 24 67 4f 00 00 	movl   $0x4f67,(%esp)
    1cab:	e8 b8 2a 00 00       	call   4768 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1cb0:	83 c4 08             	add    $0x8,%esp
    1cb3:	68 02 02 00 00       	push   $0x202
    1cb8:	68 67 4f 00 00       	push   $0x4f67
    1cbd:	e8 96 2a 00 00       	call   4758 <open>
  if(fd < 0){
    1cc2:	83 c4 10             	add    $0x10,%esp
    1cc5:	85 c0                	test   %eax,%eax
    1cc7:	78 4d                	js     1d16 <sharedfd+0x87>
    1cc9:	89 c6                	mov    %eax,%esi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    1ccb:	e8 40 2a 00 00       	call   4710 <fork>
    1cd0:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1cd2:	85 c0                	test   %eax,%eax
    1cd4:	75 57                	jne    1d2d <sharedfd+0x9e>
    1cd6:	b8 63 00 00 00       	mov    $0x63,%eax
    1cdb:	83 ec 04             	sub    $0x4,%esp
    1cde:	6a 0a                	push   $0xa
    1ce0:	50                   	push   %eax
    1ce1:	8d 45 de             	lea    -0x22(%ebp),%eax
    1ce4:	50                   	push   %eax
    1ce5:	e8 f3 28 00 00       	call   45dd <memset>
  for(i = 0; i < 1000; i++){
    1cea:	83 c4 10             	add    $0x10,%esp
    1ced:	bb 00 00 00 00       	mov    $0x0,%ebx
    1cf2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
    1cf8:	7f 4c                	jg     1d46 <sharedfd+0xb7>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1cfa:	83 ec 04             	sub    $0x4,%esp
    1cfd:	6a 0a                	push   $0xa
    1cff:	8d 45 de             	lea    -0x22(%ebp),%eax
    1d02:	50                   	push   %eax
    1d03:	56                   	push   %esi
    1d04:	e8 2f 2a 00 00       	call   4738 <write>
    1d09:	83 c4 10             	add    $0x10,%esp
    1d0c:	83 f8 0a             	cmp    $0xa,%eax
    1d0f:	75 23                	jne    1d34 <sharedfd+0xa5>
  for(i = 0; i < 1000; i++){
    1d11:	83 c3 01             	add    $0x1,%ebx
    1d14:	eb dc                	jmp    1cf2 <sharedfd+0x63>
    printf(1, "fstests: cannot open sharedfd for writing");
    1d16:	83 ec 08             	sub    $0x8,%esp
    1d19:	68 2c 5c 00 00       	push   $0x5c2c
    1d1e:	6a 01                	push   $0x1
    1d20:	e8 58 2b 00 00       	call   487d <printf>
    return;
    1d25:	83 c4 10             	add    $0x10,%esp
    1d28:	e9 e4 00 00 00       	jmp    1e11 <sharedfd+0x182>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1d2d:	b8 70 00 00 00       	mov    $0x70,%eax
    1d32:	eb a7                	jmp    1cdb <sharedfd+0x4c>
      printf(1, "fstests: write sharedfd failed\n");
    1d34:	83 ec 08             	sub    $0x8,%esp
    1d37:	68 58 5c 00 00       	push   $0x5c58
    1d3c:	6a 01                	push   $0x1
    1d3e:	e8 3a 2b 00 00       	call   487d <printf>
      break;
    1d43:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
    1d46:	85 ff                	test   %edi,%edi
    1d48:	74 4d                	je     1d97 <sharedfd+0x108>
    exit();
  else
    wait();
    1d4a:	e8 d1 29 00 00       	call   4720 <wait>
  close(fd);
    1d4f:	83 ec 0c             	sub    $0xc,%esp
    1d52:	56                   	push   %esi
    1d53:	e8 e8 29 00 00       	call   4740 <close>
  fd = open("sharedfd", 0);
    1d58:	83 c4 08             	add    $0x8,%esp
    1d5b:	6a 00                	push   $0x0
    1d5d:	68 67 4f 00 00       	push   $0x4f67
    1d62:	e8 f1 29 00 00       	call   4758 <open>
    1d67:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    1d69:	83 c4 10             	add    $0x10,%esp
    1d6c:	85 c0                	test   %eax,%eax
    1d6e:	78 2c                	js     1d9c <sharedfd+0x10d>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
    1d70:	be 00 00 00 00       	mov    $0x0,%esi
    1d75:	bb 00 00 00 00       	mov    $0x0,%ebx
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1d7a:	83 ec 04             	sub    $0x4,%esp
    1d7d:	6a 0a                	push   $0xa
    1d7f:	8d 45 de             	lea    -0x22(%ebp),%eax
    1d82:	50                   	push   %eax
    1d83:	57                   	push   %edi
    1d84:	e8 a7 29 00 00       	call   4730 <read>
    1d89:	83 c4 10             	add    $0x10,%esp
    1d8c:	85 c0                	test   %eax,%eax
    1d8e:	7e 41                	jle    1dd1 <sharedfd+0x142>
    for(i = 0; i < sizeof(buf); i++){
    1d90:	b8 00 00 00 00       	mov    $0x0,%eax
    1d95:	eb 21                	jmp    1db8 <sharedfd+0x129>
    exit();
    1d97:	e8 7c 29 00 00       	call   4718 <exit>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1d9c:	83 ec 08             	sub    $0x8,%esp
    1d9f:	68 78 5c 00 00       	push   $0x5c78
    1da4:	6a 01                	push   $0x1
    1da6:	e8 d2 2a 00 00       	call   487d <printf>
    return;
    1dab:	83 c4 10             	add    $0x10,%esp
    1dae:	eb 61                	jmp    1e11 <sharedfd+0x182>
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
    1db0:	80 fa 70             	cmp    $0x70,%dl
    1db3:	74 17                	je     1dcc <sharedfd+0x13d>
    for(i = 0; i < sizeof(buf); i++){
    1db5:	83 c0 01             	add    $0x1,%eax
    1db8:	83 f8 09             	cmp    $0x9,%eax
    1dbb:	77 bd                	ja     1d7a <sharedfd+0xeb>
      if(buf[i] == 'c')
    1dbd:	0f b6 54 05 de       	movzbl -0x22(%ebp,%eax,1),%edx
    1dc2:	80 fa 63             	cmp    $0x63,%dl
    1dc5:	75 e9                	jne    1db0 <sharedfd+0x121>
        nc++;
    1dc7:	83 c3 01             	add    $0x1,%ebx
    1dca:	eb e4                	jmp    1db0 <sharedfd+0x121>
        np++;
    1dcc:	83 c6 01             	add    $0x1,%esi
    1dcf:	eb e4                	jmp    1db5 <sharedfd+0x126>
    }
  }
  close(fd);
    1dd1:	83 ec 0c             	sub    $0xc,%esp
    1dd4:	57                   	push   %edi
    1dd5:	e8 66 29 00 00       	call   4740 <close>
  unlink("sharedfd");
    1dda:	c7 04 24 67 4f 00 00 	movl   $0x4f67,(%esp)
    1de1:	e8 82 29 00 00       	call   4768 <unlink>
  if(nc == 10000 && np == 10000){
    1de6:	83 c4 10             	add    $0x10,%esp
    1de9:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    1def:	0f 94 c2             	sete   %dl
    1df2:	81 fe 10 27 00 00    	cmp    $0x2710,%esi
    1df8:	0f 94 c0             	sete   %al
    1dfb:	84 c2                	test   %al,%dl
    1dfd:	74 1a                	je     1e19 <sharedfd+0x18a>
    printf(1, "sharedfd ok\n");
    1dff:	83 ec 08             	sub    $0x8,%esp
    1e02:	68 70 4f 00 00       	push   $0x4f70
    1e07:	6a 01                	push   $0x1
    1e09:	e8 6f 2a 00 00       	call   487d <printf>
    1e0e:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    1e11:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e14:	5b                   	pop    %ebx
    1e15:	5e                   	pop    %esi
    1e16:	5f                   	pop    %edi
    1e17:	5d                   	pop    %ebp
    1e18:	c3                   	ret    
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1e19:	56                   	push   %esi
    1e1a:	53                   	push   %ebx
    1e1b:	68 7d 4f 00 00       	push   $0x4f7d
    1e20:	6a 01                	push   $0x1
    1e22:	e8 56 2a 00 00       	call   487d <printf>
    exit();
    1e27:	e8 ec 28 00 00       	call   4718 <exit>

00001e2c <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1e2c:	55                   	push   %ebp
    1e2d:	89 e5                	mov    %esp,%ebp
    1e2f:	57                   	push   %edi
    1e30:	56                   	push   %esi
    1e31:	53                   	push   %ebx
    1e32:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1e35:	c7 45 d8 92 4f 00 00 	movl   $0x4f92,-0x28(%ebp)
    1e3c:	c7 45 dc db 50 00 00 	movl   $0x50db,-0x24(%ebp)
    1e43:	c7 45 e0 df 50 00 00 	movl   $0x50df,-0x20(%ebp)
    1e4a:	c7 45 e4 95 4f 00 00 	movl   $0x4f95,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    1e51:	68 98 4f 00 00       	push   $0x4f98
    1e56:	6a 01                	push   $0x1
    1e58:	e8 20 2a 00 00       	call   487d <printf>

  for(pi = 0; pi < 4; pi++){
    1e5d:	83 c4 10             	add    $0x10,%esp
    1e60:	be 00 00 00 00       	mov    $0x0,%esi
    1e65:	eb 45                	jmp    1eac <fourfiles+0x80>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1e67:	83 ec 08             	sub    $0x8,%esp
    1e6a:	68 6d 5a 00 00       	push   $0x5a6d
    1e6f:	6a 01                	push   $0x1
    1e71:	e8 07 2a 00 00       	call   487d <printf>
      exit();
    1e76:	e8 9d 28 00 00       	call   4718 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    1e7b:	83 ec 08             	sub    $0x8,%esp
    1e7e:	68 33 52 00 00       	push   $0x5233
    1e83:	6a 01                	push   $0x1
    1e85:	e8 f3 29 00 00       	call   487d <printf>
        exit();
    1e8a:	e8 89 28 00 00       	call   4718 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    1e8f:	83 ec 04             	sub    $0x4,%esp
    1e92:	50                   	push   %eax
    1e93:	68 a8 4f 00 00       	push   $0x4fa8
    1e98:	6a 01                	push   $0x1
    1e9a:	e8 de 29 00 00       	call   487d <printf>
          exit();
    1e9f:	e8 74 28 00 00       	call   4718 <exit>
        }
      }
      exit();
    1ea4:	e8 6f 28 00 00       	call   4718 <exit>
  for(pi = 0; pi < 4; pi++){
    1ea9:	83 c6 01             	add    $0x1,%esi
    1eac:	83 fe 03             	cmp    $0x3,%esi
    1eaf:	7f 78                	jg     1f29 <fourfiles+0xfd>
    fname = names[pi];
    1eb1:	8b 7c b5 d8          	mov    -0x28(%ebp,%esi,4),%edi
    unlink(fname);
    1eb5:	83 ec 0c             	sub    $0xc,%esp
    1eb8:	57                   	push   %edi
    1eb9:	e8 aa 28 00 00       	call   4768 <unlink>
    pid = fork();
    1ebe:	e8 4d 28 00 00       	call   4710 <fork>
    if(pid < 0){
    1ec3:	83 c4 10             	add    $0x10,%esp
    1ec6:	85 c0                	test   %eax,%eax
    1ec8:	78 9d                	js     1e67 <fourfiles+0x3b>
    if(pid == 0){
    1eca:	75 dd                	jne    1ea9 <fourfiles+0x7d>
      fd = open(fname, O_CREATE | O_RDWR);
    1ecc:	89 c3                	mov    %eax,%ebx
    1ece:	83 ec 08             	sub    $0x8,%esp
    1ed1:	68 02 02 00 00       	push   $0x202
    1ed6:	57                   	push   %edi
    1ed7:	e8 7c 28 00 00       	call   4758 <open>
    1edc:	89 c7                	mov    %eax,%edi
      if(fd < 0){
    1ede:	83 c4 10             	add    $0x10,%esp
    1ee1:	85 c0                	test   %eax,%eax
    1ee3:	78 96                	js     1e7b <fourfiles+0x4f>
      memset(buf, '0'+pi, 512);
    1ee5:	83 ec 04             	sub    $0x4,%esp
    1ee8:	68 00 02 00 00       	push   $0x200
    1eed:	83 c6 30             	add    $0x30,%esi
    1ef0:	56                   	push   %esi
    1ef1:	68 00 93 00 00       	push   $0x9300
    1ef6:	e8 e2 26 00 00       	call   45dd <memset>
      for(i = 0; i < 12; i++){
    1efb:	83 c4 10             	add    $0x10,%esp
    1efe:	83 fb 0b             	cmp    $0xb,%ebx
    1f01:	7f a1                	jg     1ea4 <fourfiles+0x78>
        if((n = write(fd, buf, 500)) != 500){
    1f03:	83 ec 04             	sub    $0x4,%esp
    1f06:	68 f4 01 00 00       	push   $0x1f4
    1f0b:	68 00 93 00 00       	push   $0x9300
    1f10:	57                   	push   %edi
    1f11:	e8 22 28 00 00       	call   4738 <write>
    1f16:	83 c4 10             	add    $0x10,%esp
    1f19:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1f1e:	0f 85 6b ff ff ff    	jne    1e8f <fourfiles+0x63>
      for(i = 0; i < 12; i++){
    1f24:	83 c3 01             	add    $0x1,%ebx
    1f27:	eb d5                	jmp    1efe <fourfiles+0xd2>
    }
  }

  for(pi = 0; pi < 4; pi++){
    1f29:	bb 00 00 00 00       	mov    $0x0,%ebx
    1f2e:	eb 08                	jmp    1f38 <fourfiles+0x10c>
    wait();
    1f30:	e8 eb 27 00 00       	call   4720 <wait>
  for(pi = 0; pi < 4; pi++){
    1f35:	83 c3 01             	add    $0x1,%ebx
    1f38:	83 fb 03             	cmp    $0x3,%ebx
    1f3b:	7e f3                	jle    1f30 <fourfiles+0x104>
  }

  for(i = 0; i < 2; i++){
    1f3d:	bb 00 00 00 00       	mov    $0x0,%ebx
    1f42:	eb 75                	jmp    1fb9 <fourfiles+0x18d>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    1f44:	83 ec 08             	sub    $0x8,%esp
    1f47:	68 b9 4f 00 00       	push   $0x4fb9
    1f4c:	6a 01                	push   $0x1
    1f4e:	e8 2a 29 00 00       	call   487d <printf>
          exit();
    1f53:	e8 c0 27 00 00       	call   4718 <exit>
        }
      }
      total += n;
    1f58:	01 7d d4             	add    %edi,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1f5b:	83 ec 04             	sub    $0x4,%esp
    1f5e:	68 00 20 00 00       	push   $0x2000
    1f63:	68 00 93 00 00       	push   $0x9300
    1f68:	56                   	push   %esi
    1f69:	e8 c2 27 00 00       	call   4730 <read>
    1f6e:	89 c7                	mov    %eax,%edi
    1f70:	83 c4 10             	add    $0x10,%esp
    1f73:	85 c0                	test   %eax,%eax
    1f75:	7e 1c                	jle    1f93 <fourfiles+0x167>
      for(j = 0; j < n; j++){
    1f77:	b8 00 00 00 00       	mov    $0x0,%eax
    1f7c:	39 f8                	cmp    %edi,%eax
    1f7e:	7d d8                	jge    1f58 <fourfiles+0x12c>
        if(buf[j] != '0'+i){
    1f80:	0f be 88 00 93 00 00 	movsbl 0x9300(%eax),%ecx
    1f87:	8d 53 30             	lea    0x30(%ebx),%edx
    1f8a:	39 d1                	cmp    %edx,%ecx
    1f8c:	75 b6                	jne    1f44 <fourfiles+0x118>
      for(j = 0; j < n; j++){
    1f8e:	83 c0 01             	add    $0x1,%eax
    1f91:	eb e9                	jmp    1f7c <fourfiles+0x150>
    }
    close(fd);
    1f93:	83 ec 0c             	sub    $0xc,%esp
    1f96:	56                   	push   %esi
    1f97:	e8 a4 27 00 00       	call   4740 <close>
    if(total != 12*500){
    1f9c:	83 c4 10             	add    $0x10,%esp
    1f9f:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
    1fa6:	75 39                	jne    1fe1 <fourfiles+0x1b5>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    1fa8:	83 ec 0c             	sub    $0xc,%esp
    1fab:	ff 75 d0             	push   -0x30(%ebp)
    1fae:	e8 b5 27 00 00       	call   4768 <unlink>
  for(i = 0; i < 2; i++){
    1fb3:	83 c3 01             	add    $0x1,%ebx
    1fb6:	83 c4 10             	add    $0x10,%esp
    1fb9:	83 fb 01             	cmp    $0x1,%ebx
    1fbc:	7f 3a                	jg     1ff8 <fourfiles+0x1cc>
    fname = names[i];
    1fbe:	8b 44 9d d8          	mov    -0x28(%ebp,%ebx,4),%eax
    1fc2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    1fc5:	83 ec 08             	sub    $0x8,%esp
    1fc8:	6a 00                	push   $0x0
    1fca:	50                   	push   %eax
    1fcb:	e8 88 27 00 00       	call   4758 <open>
    1fd0:	89 c6                	mov    %eax,%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1fd2:	83 c4 10             	add    $0x10,%esp
    total = 0;
    1fd5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1fdc:	e9 7a ff ff ff       	jmp    1f5b <fourfiles+0x12f>
      printf(1, "wrong length %d\n", total);
    1fe1:	83 ec 04             	sub    $0x4,%esp
    1fe4:	ff 75 d4             	push   -0x2c(%ebp)
    1fe7:	68 c5 4f 00 00       	push   $0x4fc5
    1fec:	6a 01                	push   $0x1
    1fee:	e8 8a 28 00 00       	call   487d <printf>
      exit();
    1ff3:	e8 20 27 00 00       	call   4718 <exit>
  }

  printf(1, "fourfiles ok\n");
    1ff8:	83 ec 08             	sub    $0x8,%esp
    1ffb:	68 d6 4f 00 00       	push   $0x4fd6
    2000:	6a 01                	push   $0x1
    2002:	e8 76 28 00 00       	call   487d <printf>
}
    2007:	83 c4 10             	add    $0x10,%esp
    200a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    200d:	5b                   	pop    %ebx
    200e:	5e                   	pop    %esi
    200f:	5f                   	pop    %edi
    2010:	5d                   	pop    %ebp
    2011:	c3                   	ret    

00002012 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    2012:	55                   	push   %ebp
    2013:	89 e5                	mov    %esp,%ebp
    2015:	56                   	push   %esi
    2016:	53                   	push   %ebx
    2017:	83 ec 28             	sub    $0x28,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    201a:	68 e4 4f 00 00       	push   $0x4fe4
    201f:	6a 01                	push   $0x1
    2021:	e8 57 28 00 00       	call   487d <printf>

  for(pi = 0; pi < 4; pi++){
    2026:	83 c4 10             	add    $0x10,%esp
    2029:	be 00 00 00 00       	mov    $0x0,%esi
    202e:	83 fe 03             	cmp    $0x3,%esi
    2031:	0f 8f bc 00 00 00    	jg     20f3 <createdelete+0xe1>
    pid = fork();
    2037:	e8 d4 26 00 00       	call   4710 <fork>
    203c:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    203e:	85 c0                	test   %eax,%eax
    2040:	78 07                	js     2049 <createdelete+0x37>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    2042:	74 19                	je     205d <createdelete+0x4b>
  for(pi = 0; pi < 4; pi++){
    2044:	83 c6 01             	add    $0x1,%esi
    2047:	eb e5                	jmp    202e <createdelete+0x1c>
      printf(1, "fork failed\n");
    2049:	83 ec 08             	sub    $0x8,%esp
    204c:	68 6d 5a 00 00       	push   $0x5a6d
    2051:	6a 01                	push   $0x1
    2053:	e8 25 28 00 00       	call   487d <printf>
      exit();
    2058:	e8 bb 26 00 00       	call   4718 <exit>
      name[0] = 'p' + pi;
    205d:	8d 46 70             	lea    0x70(%esi),%eax
    2060:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[2] = '\0';
    2063:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
      for(i = 0; i < N; i++){
    2067:	eb 17                	jmp    2080 <createdelete+0x6e>
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    2069:	83 ec 08             	sub    $0x8,%esp
    206c:	68 33 52 00 00       	push   $0x5233
    2071:	6a 01                	push   $0x1
    2073:	e8 05 28 00 00       	call   487d <printf>
          exit();
    2078:	e8 9b 26 00 00       	call   4718 <exit>
      for(i = 0; i < N; i++){
    207d:	83 c3 01             	add    $0x1,%ebx
    2080:	83 fb 13             	cmp    $0x13,%ebx
    2083:	7f 69                	jg     20ee <createdelete+0xdc>
        name[1] = '0' + i;
    2085:	8d 43 30             	lea    0x30(%ebx),%eax
    2088:	88 45 d9             	mov    %al,-0x27(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    208b:	83 ec 08             	sub    $0x8,%esp
    208e:	68 02 02 00 00       	push   $0x202
    2093:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2096:	50                   	push   %eax
    2097:	e8 bc 26 00 00       	call   4758 <open>
        if(fd < 0){
    209c:	83 c4 10             	add    $0x10,%esp
    209f:	85 c0                	test   %eax,%eax
    20a1:	78 c6                	js     2069 <createdelete+0x57>
        }
        close(fd);
    20a3:	83 ec 0c             	sub    $0xc,%esp
    20a6:	50                   	push   %eax
    20a7:	e8 94 26 00 00       	call   4740 <close>
        if(i > 0 && (i % 2 ) == 0){
    20ac:	83 c4 10             	add    $0x10,%esp
    20af:	85 db                	test   %ebx,%ebx
    20b1:	7e ca                	jle    207d <createdelete+0x6b>
    20b3:	f6 c3 01             	test   $0x1,%bl
    20b6:	75 c5                	jne    207d <createdelete+0x6b>
          name[1] = '0' + (i / 2);
    20b8:	89 d8                	mov    %ebx,%eax
    20ba:	c1 e8 1f             	shr    $0x1f,%eax
    20bd:	01 d8                	add    %ebx,%eax
    20bf:	d1 f8                	sar    %eax
    20c1:	83 c0 30             	add    $0x30,%eax
    20c4:	88 45 d9             	mov    %al,-0x27(%ebp)
          if(unlink(name) < 0){
    20c7:	83 ec 0c             	sub    $0xc,%esp
    20ca:	8d 45 d8             	lea    -0x28(%ebp),%eax
    20cd:	50                   	push   %eax
    20ce:	e8 95 26 00 00       	call   4768 <unlink>
    20d3:	83 c4 10             	add    $0x10,%esp
    20d6:	85 c0                	test   %eax,%eax
    20d8:	79 a3                	jns    207d <createdelete+0x6b>
            printf(1, "unlink failed\n");
    20da:	83 ec 08             	sub    $0x8,%esp
    20dd:	68 e5 4b 00 00       	push   $0x4be5
    20e2:	6a 01                	push   $0x1
    20e4:	e8 94 27 00 00       	call   487d <printf>
            exit();
    20e9:	e8 2a 26 00 00       	call   4718 <exit>
          }
        }
      }
      exit();
    20ee:	e8 25 26 00 00       	call   4718 <exit>
    }
  }

  for(pi = 0; pi < 4; pi++){
    20f3:	bb 00 00 00 00       	mov    $0x0,%ebx
    20f8:	eb 08                	jmp    2102 <createdelete+0xf0>
    wait();
    20fa:	e8 21 26 00 00       	call   4720 <wait>
  for(pi = 0; pi < 4; pi++){
    20ff:	83 c3 01             	add    $0x1,%ebx
    2102:	83 fb 03             	cmp    $0x3,%ebx
    2105:	7e f3                	jle    20fa <createdelete+0xe8>
  }

  name[0] = name[1] = name[2] = 0;
    2107:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    210b:	c6 45 d9 00          	movb   $0x0,-0x27(%ebp)
    210f:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
  for(i = 0; i < N; i++){
    2113:	bb 00 00 00 00       	mov    $0x0,%ebx
    2118:	e9 89 00 00 00       	jmp    21a6 <createdelete+0x194>
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    211d:	8d 53 ff             	lea    -0x1(%ebx),%edx
    2120:	83 fa 08             	cmp    $0x8,%edx
    2123:	76 54                	jbe    2179 <createdelete+0x167>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
    2125:	85 c0                	test   %eax,%eax
    2127:	79 6c                	jns    2195 <createdelete+0x183>
    for(pi = 0; pi < 4; pi++){
    2129:	83 c6 01             	add    $0x1,%esi
    212c:	83 fe 03             	cmp    $0x3,%esi
    212f:	7f 72                	jg     21a3 <createdelete+0x191>
      name[0] = 'p' + pi;
    2131:	8d 46 70             	lea    0x70(%esi),%eax
    2134:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[1] = '0' + i;
    2137:	8d 43 30             	lea    0x30(%ebx),%eax
    213a:	88 45 d9             	mov    %al,-0x27(%ebp)
      fd = open(name, 0);
    213d:	83 ec 08             	sub    $0x8,%esp
    2140:	6a 00                	push   $0x0
    2142:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2145:	50                   	push   %eax
    2146:	e8 0d 26 00 00       	call   4758 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    214b:	83 c4 10             	add    $0x10,%esp
    214e:	85 db                	test   %ebx,%ebx
    2150:	0f 94 c2             	sete   %dl
    2153:	83 fb 09             	cmp    $0x9,%ebx
    2156:	0f 9f c1             	setg   %cl
    2159:	08 ca                	or     %cl,%dl
    215b:	74 c0                	je     211d <createdelete+0x10b>
    215d:	85 c0                	test   %eax,%eax
    215f:	79 bc                	jns    211d <createdelete+0x10b>
        printf(1, "oops createdelete %s didn't exist\n", name);
    2161:	83 ec 04             	sub    $0x4,%esp
    2164:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2167:	50                   	push   %eax
    2168:	68 a4 5c 00 00       	push   $0x5ca4
    216d:	6a 01                	push   $0x1
    216f:	e8 09 27 00 00       	call   487d <printf>
        exit();
    2174:	e8 9f 25 00 00       	call   4718 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2179:	85 c0                	test   %eax,%eax
    217b:	78 a8                	js     2125 <createdelete+0x113>
        printf(1, "oops createdelete %s did exist\n", name);
    217d:	83 ec 04             	sub    $0x4,%esp
    2180:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2183:	50                   	push   %eax
    2184:	68 c8 5c 00 00       	push   $0x5cc8
    2189:	6a 01                	push   $0x1
    218b:	e8 ed 26 00 00       	call   487d <printf>
        exit();
    2190:	e8 83 25 00 00       	call   4718 <exit>
        close(fd);
    2195:	83 ec 0c             	sub    $0xc,%esp
    2198:	50                   	push   %eax
    2199:	e8 a2 25 00 00       	call   4740 <close>
    219e:	83 c4 10             	add    $0x10,%esp
    21a1:	eb 86                	jmp    2129 <createdelete+0x117>
  for(i = 0; i < N; i++){
    21a3:	83 c3 01             	add    $0x1,%ebx
    21a6:	83 fb 13             	cmp    $0x13,%ebx
    21a9:	7f 0a                	jg     21b5 <createdelete+0x1a3>
    for(pi = 0; pi < 4; pi++){
    21ab:	be 00 00 00 00       	mov    $0x0,%esi
    21b0:	e9 77 ff ff ff       	jmp    212c <createdelete+0x11a>
    }
  }

  for(i = 0; i < N; i++){
    21b5:	be 00 00 00 00       	mov    $0x0,%esi
    21ba:	eb 26                	jmp    21e2 <createdelete+0x1d0>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    21bc:	8d 46 70             	lea    0x70(%esi),%eax
    21bf:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[1] = '0' + i;
    21c2:	8d 46 30             	lea    0x30(%esi),%eax
    21c5:	88 45 d9             	mov    %al,-0x27(%ebp)
      unlink(name);
    21c8:	83 ec 0c             	sub    $0xc,%esp
    21cb:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21ce:	50                   	push   %eax
    21cf:	e8 94 25 00 00       	call   4768 <unlink>
    for(pi = 0; pi < 4; pi++){
    21d4:	83 c3 01             	add    $0x1,%ebx
    21d7:	83 c4 10             	add    $0x10,%esp
    21da:	83 fb 03             	cmp    $0x3,%ebx
    21dd:	7e dd                	jle    21bc <createdelete+0x1aa>
  for(i = 0; i < N; i++){
    21df:	83 c6 01             	add    $0x1,%esi
    21e2:	83 fe 13             	cmp    $0x13,%esi
    21e5:	7f 07                	jg     21ee <createdelete+0x1dc>
    for(pi = 0; pi < 4; pi++){
    21e7:	bb 00 00 00 00       	mov    $0x0,%ebx
    21ec:	eb ec                	jmp    21da <createdelete+0x1c8>
    }
  }

  printf(1, "createdelete ok\n");
    21ee:	83 ec 08             	sub    $0x8,%esp
    21f1:	68 f7 4f 00 00       	push   $0x4ff7
    21f6:	6a 01                	push   $0x1
    21f8:	e8 80 26 00 00       	call   487d <printf>
}
    21fd:	83 c4 10             	add    $0x10,%esp
    2200:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2203:	5b                   	pop    %ebx
    2204:	5e                   	pop    %esi
    2205:	5d                   	pop    %ebp
    2206:	c3                   	ret    

00002207 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    2207:	55                   	push   %ebp
    2208:	89 e5                	mov    %esp,%ebp
    220a:	56                   	push   %esi
    220b:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    220c:	83 ec 08             	sub    $0x8,%esp
    220f:	68 08 50 00 00       	push   $0x5008
    2214:	6a 01                	push   $0x1
    2216:	e8 62 26 00 00       	call   487d <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    221b:	83 c4 08             	add    $0x8,%esp
    221e:	68 02 02 00 00       	push   $0x202
    2223:	68 19 50 00 00       	push   $0x5019
    2228:	e8 2b 25 00 00       	call   4758 <open>
  if(fd < 0){
    222d:	83 c4 10             	add    $0x10,%esp
    2230:	85 c0                	test   %eax,%eax
    2232:	0f 88 f0 00 00 00    	js     2328 <unlinkread+0x121>
    2238:	89 c3                	mov    %eax,%ebx
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    223a:	83 ec 04             	sub    $0x4,%esp
    223d:	6a 05                	push   $0x5
    223f:	68 3e 50 00 00       	push   $0x503e
    2244:	50                   	push   %eax
    2245:	e8 ee 24 00 00       	call   4738 <write>
  close(fd);
    224a:	89 1c 24             	mov    %ebx,(%esp)
    224d:	e8 ee 24 00 00       	call   4740 <close>

  fd = open("unlinkread", O_RDWR);
    2252:	83 c4 08             	add    $0x8,%esp
    2255:	6a 02                	push   $0x2
    2257:	68 19 50 00 00       	push   $0x5019
    225c:	e8 f7 24 00 00       	call   4758 <open>
    2261:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2263:	83 c4 10             	add    $0x10,%esp
    2266:	85 c0                	test   %eax,%eax
    2268:	0f 88 ce 00 00 00    	js     233c <unlinkread+0x135>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    226e:	83 ec 0c             	sub    $0xc,%esp
    2271:	68 19 50 00 00       	push   $0x5019
    2276:	e8 ed 24 00 00       	call   4768 <unlink>
    227b:	83 c4 10             	add    $0x10,%esp
    227e:	85 c0                	test   %eax,%eax
    2280:	0f 85 ca 00 00 00    	jne    2350 <unlinkread+0x149>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    2286:	83 ec 08             	sub    $0x8,%esp
    2289:	68 02 02 00 00       	push   $0x202
    228e:	68 19 50 00 00       	push   $0x5019
    2293:	e8 c0 24 00 00       	call   4758 <open>
    2298:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    229a:	83 c4 0c             	add    $0xc,%esp
    229d:	6a 03                	push   $0x3
    229f:	68 76 50 00 00       	push   $0x5076
    22a4:	50                   	push   %eax
    22a5:	e8 8e 24 00 00       	call   4738 <write>
  close(fd1);
    22aa:	89 34 24             	mov    %esi,(%esp)
    22ad:	e8 8e 24 00 00       	call   4740 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    22b2:	83 c4 0c             	add    $0xc,%esp
    22b5:	68 00 20 00 00       	push   $0x2000
    22ba:	68 00 93 00 00       	push   $0x9300
    22bf:	53                   	push   %ebx
    22c0:	e8 6b 24 00 00       	call   4730 <read>
    22c5:	83 c4 10             	add    $0x10,%esp
    22c8:	83 f8 05             	cmp    $0x5,%eax
    22cb:	0f 85 93 00 00 00    	jne    2364 <unlinkread+0x15d>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    22d1:	80 3d 00 93 00 00 68 	cmpb   $0x68,0x9300
    22d8:	0f 85 9a 00 00 00    	jne    2378 <unlinkread+0x171>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    22de:	83 ec 04             	sub    $0x4,%esp
    22e1:	6a 0a                	push   $0xa
    22e3:	68 00 93 00 00       	push   $0x9300
    22e8:	53                   	push   %ebx
    22e9:	e8 4a 24 00 00       	call   4738 <write>
    22ee:	83 c4 10             	add    $0x10,%esp
    22f1:	83 f8 0a             	cmp    $0xa,%eax
    22f4:	0f 85 92 00 00 00    	jne    238c <unlinkread+0x185>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    22fa:	83 ec 0c             	sub    $0xc,%esp
    22fd:	53                   	push   %ebx
    22fe:	e8 3d 24 00 00       	call   4740 <close>
  unlink("unlinkread");
    2303:	c7 04 24 19 50 00 00 	movl   $0x5019,(%esp)
    230a:	e8 59 24 00 00       	call   4768 <unlink>
  printf(1, "unlinkread ok\n");
    230f:	83 c4 08             	add    $0x8,%esp
    2312:	68 c1 50 00 00       	push   $0x50c1
    2317:	6a 01                	push   $0x1
    2319:	e8 5f 25 00 00       	call   487d <printf>
}
    231e:	83 c4 10             	add    $0x10,%esp
    2321:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2324:	5b                   	pop    %ebx
    2325:	5e                   	pop    %esi
    2326:	5d                   	pop    %ebp
    2327:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    2328:	83 ec 08             	sub    $0x8,%esp
    232b:	68 24 50 00 00       	push   $0x5024
    2330:	6a 01                	push   $0x1
    2332:	e8 46 25 00 00       	call   487d <printf>
    exit();
    2337:	e8 dc 23 00 00       	call   4718 <exit>
    printf(1, "open unlinkread failed\n");
    233c:	83 ec 08             	sub    $0x8,%esp
    233f:	68 44 50 00 00       	push   $0x5044
    2344:	6a 01                	push   $0x1
    2346:	e8 32 25 00 00       	call   487d <printf>
    exit();
    234b:	e8 c8 23 00 00       	call   4718 <exit>
    printf(1, "unlink unlinkread failed\n");
    2350:	83 ec 08             	sub    $0x8,%esp
    2353:	68 5c 50 00 00       	push   $0x505c
    2358:	6a 01                	push   $0x1
    235a:	e8 1e 25 00 00       	call   487d <printf>
    exit();
    235f:	e8 b4 23 00 00       	call   4718 <exit>
    printf(1, "unlinkread read failed");
    2364:	83 ec 08             	sub    $0x8,%esp
    2367:	68 7a 50 00 00       	push   $0x507a
    236c:	6a 01                	push   $0x1
    236e:	e8 0a 25 00 00       	call   487d <printf>
    exit();
    2373:	e8 a0 23 00 00       	call   4718 <exit>
    printf(1, "unlinkread wrong data\n");
    2378:	83 ec 08             	sub    $0x8,%esp
    237b:	68 91 50 00 00       	push   $0x5091
    2380:	6a 01                	push   $0x1
    2382:	e8 f6 24 00 00       	call   487d <printf>
    exit();
    2387:	e8 8c 23 00 00       	call   4718 <exit>
    printf(1, "unlinkread write failed\n");
    238c:	83 ec 08             	sub    $0x8,%esp
    238f:	68 a8 50 00 00       	push   $0x50a8
    2394:	6a 01                	push   $0x1
    2396:	e8 e2 24 00 00       	call   487d <printf>
    exit();
    239b:	e8 78 23 00 00       	call   4718 <exit>

000023a0 <linktest>:

void
linktest(void)
{
    23a0:	55                   	push   %ebp
    23a1:	89 e5                	mov    %esp,%ebp
    23a3:	53                   	push   %ebx
    23a4:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    23a7:	68 d0 50 00 00       	push   $0x50d0
    23ac:	6a 01                	push   $0x1
    23ae:	e8 ca 24 00 00       	call   487d <printf>

  unlink("lf1");
    23b3:	c7 04 24 da 50 00 00 	movl   $0x50da,(%esp)
    23ba:	e8 a9 23 00 00       	call   4768 <unlink>
  unlink("lf2");
    23bf:	c7 04 24 de 50 00 00 	movl   $0x50de,(%esp)
    23c6:	e8 9d 23 00 00       	call   4768 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    23cb:	83 c4 08             	add    $0x8,%esp
    23ce:	68 02 02 00 00       	push   $0x202
    23d3:	68 da 50 00 00       	push   $0x50da
    23d8:	e8 7b 23 00 00       	call   4758 <open>
  if(fd < 0){
    23dd:	83 c4 10             	add    $0x10,%esp
    23e0:	85 c0                	test   %eax,%eax
    23e2:	0f 88 2a 01 00 00    	js     2512 <linktest+0x172>
    23e8:	89 c3                	mov    %eax,%ebx
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    23ea:	83 ec 04             	sub    $0x4,%esp
    23ed:	6a 05                	push   $0x5
    23ef:	68 3e 50 00 00       	push   $0x503e
    23f4:	50                   	push   %eax
    23f5:	e8 3e 23 00 00       	call   4738 <write>
    23fa:	83 c4 10             	add    $0x10,%esp
    23fd:	83 f8 05             	cmp    $0x5,%eax
    2400:	0f 85 20 01 00 00    	jne    2526 <linktest+0x186>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    2406:	83 ec 0c             	sub    $0xc,%esp
    2409:	53                   	push   %ebx
    240a:	e8 31 23 00 00       	call   4740 <close>

  if(link("lf1", "lf2") < 0){
    240f:	83 c4 08             	add    $0x8,%esp
    2412:	68 de 50 00 00       	push   $0x50de
    2417:	68 da 50 00 00       	push   $0x50da
    241c:	e8 57 23 00 00       	call   4778 <link>
    2421:	83 c4 10             	add    $0x10,%esp
    2424:	85 c0                	test   %eax,%eax
    2426:	0f 88 0e 01 00 00    	js     253a <linktest+0x19a>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    242c:	83 ec 0c             	sub    $0xc,%esp
    242f:	68 da 50 00 00       	push   $0x50da
    2434:	e8 2f 23 00 00       	call   4768 <unlink>

  if(open("lf1", 0) >= 0){
    2439:	83 c4 08             	add    $0x8,%esp
    243c:	6a 00                	push   $0x0
    243e:	68 da 50 00 00       	push   $0x50da
    2443:	e8 10 23 00 00       	call   4758 <open>
    2448:	83 c4 10             	add    $0x10,%esp
    244b:	85 c0                	test   %eax,%eax
    244d:	0f 89 fb 00 00 00    	jns    254e <linktest+0x1ae>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    2453:	83 ec 08             	sub    $0x8,%esp
    2456:	6a 00                	push   $0x0
    2458:	68 de 50 00 00       	push   $0x50de
    245d:	e8 f6 22 00 00       	call   4758 <open>
    2462:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2464:	83 c4 10             	add    $0x10,%esp
    2467:	85 c0                	test   %eax,%eax
    2469:	0f 88 f3 00 00 00    	js     2562 <linktest+0x1c2>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    246f:	83 ec 04             	sub    $0x4,%esp
    2472:	68 00 20 00 00       	push   $0x2000
    2477:	68 00 93 00 00       	push   $0x9300
    247c:	50                   	push   %eax
    247d:	e8 ae 22 00 00       	call   4730 <read>
    2482:	83 c4 10             	add    $0x10,%esp
    2485:	83 f8 05             	cmp    $0x5,%eax
    2488:	0f 85 e8 00 00 00    	jne    2576 <linktest+0x1d6>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    248e:	83 ec 0c             	sub    $0xc,%esp
    2491:	53                   	push   %ebx
    2492:	e8 a9 22 00 00       	call   4740 <close>

  if(link("lf2", "lf2") >= 0){
    2497:	83 c4 08             	add    $0x8,%esp
    249a:	68 de 50 00 00       	push   $0x50de
    249f:	68 de 50 00 00       	push   $0x50de
    24a4:	e8 cf 22 00 00       	call   4778 <link>
    24a9:	83 c4 10             	add    $0x10,%esp
    24ac:	85 c0                	test   %eax,%eax
    24ae:	0f 89 d6 00 00 00    	jns    258a <linktest+0x1ea>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    24b4:	83 ec 0c             	sub    $0xc,%esp
    24b7:	68 de 50 00 00       	push   $0x50de
    24bc:	e8 a7 22 00 00       	call   4768 <unlink>
  if(link("lf2", "lf1") >= 0){
    24c1:	83 c4 08             	add    $0x8,%esp
    24c4:	68 da 50 00 00       	push   $0x50da
    24c9:	68 de 50 00 00       	push   $0x50de
    24ce:	e8 a5 22 00 00       	call   4778 <link>
    24d3:	83 c4 10             	add    $0x10,%esp
    24d6:	85 c0                	test   %eax,%eax
    24d8:	0f 89 c0 00 00 00    	jns    259e <linktest+0x1fe>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    24de:	83 ec 08             	sub    $0x8,%esp
    24e1:	68 da 50 00 00       	push   $0x50da
    24e6:	68 a2 53 00 00       	push   $0x53a2
    24eb:	e8 88 22 00 00       	call   4778 <link>
    24f0:	83 c4 10             	add    $0x10,%esp
    24f3:	85 c0                	test   %eax,%eax
    24f5:	0f 89 b7 00 00 00    	jns    25b2 <linktest+0x212>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    24fb:	83 ec 08             	sub    $0x8,%esp
    24fe:	68 78 51 00 00       	push   $0x5178
    2503:	6a 01                	push   $0x1
    2505:	e8 73 23 00 00       	call   487d <printf>
}
    250a:	83 c4 10             	add    $0x10,%esp
    250d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2510:	c9                   	leave  
    2511:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    2512:	83 ec 08             	sub    $0x8,%esp
    2515:	68 e2 50 00 00       	push   $0x50e2
    251a:	6a 01                	push   $0x1
    251c:	e8 5c 23 00 00       	call   487d <printf>
    exit();
    2521:	e8 f2 21 00 00       	call   4718 <exit>
    printf(1, "write lf1 failed\n");
    2526:	83 ec 08             	sub    $0x8,%esp
    2529:	68 f5 50 00 00       	push   $0x50f5
    252e:	6a 01                	push   $0x1
    2530:	e8 48 23 00 00       	call   487d <printf>
    exit();
    2535:	e8 de 21 00 00       	call   4718 <exit>
    printf(1, "link lf1 lf2 failed\n");
    253a:	83 ec 08             	sub    $0x8,%esp
    253d:	68 07 51 00 00       	push   $0x5107
    2542:	6a 01                	push   $0x1
    2544:	e8 34 23 00 00       	call   487d <printf>
    exit();
    2549:	e8 ca 21 00 00       	call   4718 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    254e:	83 ec 08             	sub    $0x8,%esp
    2551:	68 e8 5c 00 00       	push   $0x5ce8
    2556:	6a 01                	push   $0x1
    2558:	e8 20 23 00 00       	call   487d <printf>
    exit();
    255d:	e8 b6 21 00 00       	call   4718 <exit>
    printf(1, "open lf2 failed\n");
    2562:	83 ec 08             	sub    $0x8,%esp
    2565:	68 1c 51 00 00       	push   $0x511c
    256a:	6a 01                	push   $0x1
    256c:	e8 0c 23 00 00       	call   487d <printf>
    exit();
    2571:	e8 a2 21 00 00       	call   4718 <exit>
    printf(1, "read lf2 failed\n");
    2576:	83 ec 08             	sub    $0x8,%esp
    2579:	68 2d 51 00 00       	push   $0x512d
    257e:	6a 01                	push   $0x1
    2580:	e8 f8 22 00 00       	call   487d <printf>
    exit();
    2585:	e8 8e 21 00 00       	call   4718 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    258a:	83 ec 08             	sub    $0x8,%esp
    258d:	68 3e 51 00 00       	push   $0x513e
    2592:	6a 01                	push   $0x1
    2594:	e8 e4 22 00 00       	call   487d <printf>
    exit();
    2599:	e8 7a 21 00 00       	call   4718 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    259e:	83 ec 08             	sub    $0x8,%esp
    25a1:	68 10 5d 00 00       	push   $0x5d10
    25a6:	6a 01                	push   $0x1
    25a8:	e8 d0 22 00 00       	call   487d <printf>
    exit();
    25ad:	e8 66 21 00 00       	call   4718 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    25b2:	83 ec 08             	sub    $0x8,%esp
    25b5:	68 5c 51 00 00       	push   $0x515c
    25ba:	6a 01                	push   $0x1
    25bc:	e8 bc 22 00 00       	call   487d <printf>
    exit();
    25c1:	e8 52 21 00 00       	call   4718 <exit>

000025c6 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    25c6:	55                   	push   %ebp
    25c7:	89 e5                	mov    %esp,%ebp
    25c9:	57                   	push   %edi
    25ca:	56                   	push   %esi
    25cb:	53                   	push   %ebx
    25cc:	83 ec 54             	sub    $0x54,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    25cf:	68 85 51 00 00       	push   $0x5185
    25d4:	6a 01                	push   $0x1
    25d6:	e8 a2 22 00 00       	call   487d <printf>
  file[0] = 'C';
    25db:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    25df:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    25e3:	83 c4 10             	add    $0x10,%esp
    25e6:	bb 00 00 00 00       	mov    $0x0,%ebx
    25eb:	eb 5e                	jmp    264b <concreate+0x85>
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    25ed:	85 f6                	test   %esi,%esi
    25ef:	75 22                	jne    2613 <concreate+0x4d>
    25f1:	ba 67 66 66 66       	mov    $0x66666667,%edx
    25f6:	89 d8                	mov    %ebx,%eax
    25f8:	f7 ea                	imul   %edx
    25fa:	d1 fa                	sar    %edx
    25fc:	89 d8                	mov    %ebx,%eax
    25fe:	c1 f8 1f             	sar    $0x1f,%eax
    2601:	29 c2                	sub    %eax,%edx
    2603:	8d 04 92             	lea    (%edx,%edx,4),%eax
    2606:	89 da                	mov    %ebx,%edx
    2608:	29 c2                	sub    %eax,%edx
    260a:	83 fa 01             	cmp    $0x1,%edx
    260d:	0f 84 9b 00 00 00    	je     26ae <concreate+0xe8>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    2613:	83 ec 08             	sub    $0x8,%esp
    2616:	68 02 02 00 00       	push   $0x202
    261b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    261e:	50                   	push   %eax
    261f:	e8 34 21 00 00       	call   4758 <open>
      if(fd < 0){
    2624:	83 c4 10             	add    $0x10,%esp
    2627:	85 c0                	test   %eax,%eax
    2629:	0f 88 98 00 00 00    	js     26c7 <concreate+0x101>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    262f:	83 ec 0c             	sub    $0xc,%esp
    2632:	50                   	push   %eax
    2633:	e8 08 21 00 00       	call   4740 <close>
    2638:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    263b:	85 f6                	test   %esi,%esi
    263d:	0f 84 9c 00 00 00    	je     26df <concreate+0x119>
      exit();
    else
      wait();
    2643:	e8 d8 20 00 00       	call   4720 <wait>
  for(i = 0; i < 40; i++){
    2648:	83 c3 01             	add    $0x1,%ebx
    264b:	83 fb 27             	cmp    $0x27,%ebx
    264e:	0f 8f 90 00 00 00    	jg     26e4 <concreate+0x11e>
    file[1] = '0' + i;
    2654:	8d 43 30             	lea    0x30(%ebx),%eax
    2657:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    265a:	83 ec 0c             	sub    $0xc,%esp
    265d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2660:	50                   	push   %eax
    2661:	e8 02 21 00 00       	call   4768 <unlink>
    pid = fork();
    2666:	e8 a5 20 00 00       	call   4710 <fork>
    266b:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    266d:	83 c4 10             	add    $0x10,%esp
    2670:	85 c0                	test   %eax,%eax
    2672:	0f 84 75 ff ff ff    	je     25ed <concreate+0x27>
    2678:	ba 56 55 55 55       	mov    $0x55555556,%edx
    267d:	89 d8                	mov    %ebx,%eax
    267f:	f7 ea                	imul   %edx
    2681:	89 d8                	mov    %ebx,%eax
    2683:	c1 f8 1f             	sar    $0x1f,%eax
    2686:	29 c2                	sub    %eax,%edx
    2688:	8d 04 52             	lea    (%edx,%edx,2),%eax
    268b:	89 da                	mov    %ebx,%edx
    268d:	29 c2                	sub    %eax,%edx
    268f:	83 fa 01             	cmp    $0x1,%edx
    2692:	0f 85 55 ff ff ff    	jne    25ed <concreate+0x27>
      link("C0", file);
    2698:	83 ec 08             	sub    $0x8,%esp
    269b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    269e:	50                   	push   %eax
    269f:	68 95 51 00 00       	push   $0x5195
    26a4:	e8 cf 20 00 00       	call   4778 <link>
    26a9:	83 c4 10             	add    $0x10,%esp
    26ac:	eb 8d                	jmp    263b <concreate+0x75>
      link("C0", file);
    26ae:	83 ec 08             	sub    $0x8,%esp
    26b1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    26b4:	50                   	push   %eax
    26b5:	68 95 51 00 00       	push   $0x5195
    26ba:	e8 b9 20 00 00       	call   4778 <link>
    26bf:	83 c4 10             	add    $0x10,%esp
    26c2:	e9 74 ff ff ff       	jmp    263b <concreate+0x75>
        printf(1, "concreate create %s failed\n", file);
    26c7:	83 ec 04             	sub    $0x4,%esp
    26ca:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    26cd:	50                   	push   %eax
    26ce:	68 98 51 00 00       	push   $0x5198
    26d3:	6a 01                	push   $0x1
    26d5:	e8 a3 21 00 00       	call   487d <printf>
        exit();
    26da:	e8 39 20 00 00       	call   4718 <exit>
      exit();
    26df:	e8 34 20 00 00       	call   4718 <exit>
  }

  memset(fa, 0, sizeof(fa));
    26e4:	83 ec 04             	sub    $0x4,%esp
    26e7:	6a 28                	push   $0x28
    26e9:	6a 00                	push   $0x0
    26eb:	8d 45 bd             	lea    -0x43(%ebp),%eax
    26ee:	50                   	push   %eax
    26ef:	e8 e9 1e 00 00       	call   45dd <memset>
  fd = open(".", 0);
    26f4:	83 c4 08             	add    $0x8,%esp
    26f7:	6a 00                	push   $0x0
    26f9:	68 a2 53 00 00       	push   $0x53a2
    26fe:	e8 55 20 00 00       	call   4758 <open>
    2703:	89 c3                	mov    %eax,%ebx
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    2705:	83 c4 10             	add    $0x10,%esp
  n = 0;
    2708:	be 00 00 00 00       	mov    $0x0,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    270d:	83 ec 04             	sub    $0x4,%esp
    2710:	6a 10                	push   $0x10
    2712:	8d 45 ac             	lea    -0x54(%ebp),%eax
    2715:	50                   	push   %eax
    2716:	53                   	push   %ebx
    2717:	e8 14 20 00 00       	call   4730 <read>
    271c:	83 c4 10             	add    $0x10,%esp
    271f:	85 c0                	test   %eax,%eax
    2721:	7e 60                	jle    2783 <concreate+0x1bd>
    if(de.inum == 0)
    2723:	66 83 7d ac 00       	cmpw   $0x0,-0x54(%ebp)
    2728:	74 e3                	je     270d <concreate+0x147>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    272a:	80 7d ae 43          	cmpb   $0x43,-0x52(%ebp)
    272e:	75 dd                	jne    270d <concreate+0x147>
    2730:	80 7d b0 00          	cmpb   $0x0,-0x50(%ebp)
    2734:	75 d7                	jne    270d <concreate+0x147>
      i = de.name[1] - '0';
    2736:	0f be 45 af          	movsbl -0x51(%ebp),%eax
    273a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    273d:	83 f8 27             	cmp    $0x27,%eax
    2740:	77 11                	ja     2753 <concreate+0x18d>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    2742:	80 7c 05 bd 00       	cmpb   $0x0,-0x43(%ebp,%eax,1)
    2747:	75 22                	jne    276b <concreate+0x1a5>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    2749:	c6 44 05 bd 01       	movb   $0x1,-0x43(%ebp,%eax,1)
      n++;
    274e:	83 c6 01             	add    $0x1,%esi
    2751:	eb ba                	jmp    270d <concreate+0x147>
        printf(1, "concreate weird file %s\n", de.name);
    2753:	83 ec 04             	sub    $0x4,%esp
    2756:	8d 45 ae             	lea    -0x52(%ebp),%eax
    2759:	50                   	push   %eax
    275a:	68 b4 51 00 00       	push   $0x51b4
    275f:	6a 01                	push   $0x1
    2761:	e8 17 21 00 00       	call   487d <printf>
        exit();
    2766:	e8 ad 1f 00 00       	call   4718 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    276b:	83 ec 04             	sub    $0x4,%esp
    276e:	8d 45 ae             	lea    -0x52(%ebp),%eax
    2771:	50                   	push   %eax
    2772:	68 cd 51 00 00       	push   $0x51cd
    2777:	6a 01                	push   $0x1
    2779:	e8 ff 20 00 00       	call   487d <printf>
        exit();
    277e:	e8 95 1f 00 00       	call   4718 <exit>
    }
  }
  close(fd);
    2783:	83 ec 0c             	sub    $0xc,%esp
    2786:	53                   	push   %ebx
    2787:	e8 b4 1f 00 00       	call   4740 <close>

  if(n != 40){
    278c:	83 c4 10             	add    $0x10,%esp
    278f:	83 fe 28             	cmp    $0x28,%esi
    2792:	75 0a                	jne    279e <concreate+0x1d8>
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    2794:	bb 00 00 00 00       	mov    $0x0,%ebx
    2799:	e9 86 00 00 00       	jmp    2824 <concreate+0x25e>
    printf(1, "concreate not enough files in directory listing\n");
    279e:	83 ec 08             	sub    $0x8,%esp
    27a1:	68 34 5d 00 00       	push   $0x5d34
    27a6:	6a 01                	push   $0x1
    27a8:	e8 d0 20 00 00       	call   487d <printf>
    exit();
    27ad:	e8 66 1f 00 00       	call   4718 <exit>
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    27b2:	83 ec 08             	sub    $0x8,%esp
    27b5:	68 6d 5a 00 00       	push   $0x5a6d
    27ba:	6a 01                	push   $0x1
    27bc:	e8 bc 20 00 00       	call   487d <printf>
      exit();
    27c1:	e8 52 1f 00 00       	call   4718 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
      close(open(file, 0));
    27c6:	83 ec 08             	sub    $0x8,%esp
    27c9:	6a 00                	push   $0x0
    27cb:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    27ce:	57                   	push   %edi
    27cf:	e8 84 1f 00 00       	call   4758 <open>
    27d4:	89 04 24             	mov    %eax,(%esp)
    27d7:	e8 64 1f 00 00       	call   4740 <close>
      close(open(file, 0));
    27dc:	83 c4 08             	add    $0x8,%esp
    27df:	6a 00                	push   $0x0
    27e1:	57                   	push   %edi
    27e2:	e8 71 1f 00 00       	call   4758 <open>
    27e7:	89 04 24             	mov    %eax,(%esp)
    27ea:	e8 51 1f 00 00       	call   4740 <close>
      close(open(file, 0));
    27ef:	83 c4 08             	add    $0x8,%esp
    27f2:	6a 00                	push   $0x0
    27f4:	57                   	push   %edi
    27f5:	e8 5e 1f 00 00       	call   4758 <open>
    27fa:	89 04 24             	mov    %eax,(%esp)
    27fd:	e8 3e 1f 00 00       	call   4740 <close>
      close(open(file, 0));
    2802:	83 c4 08             	add    $0x8,%esp
    2805:	6a 00                	push   $0x0
    2807:	57                   	push   %edi
    2808:	e8 4b 1f 00 00       	call   4758 <open>
    280d:	89 04 24             	mov    %eax,(%esp)
    2810:	e8 2b 1f 00 00       	call   4740 <close>
    2815:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    2818:	85 f6                	test   %esi,%esi
    281a:	74 79                	je     2895 <concreate+0x2cf>
      exit();
    else
      wait();
    281c:	e8 ff 1e 00 00       	call   4720 <wait>
  for(i = 0; i < 40; i++){
    2821:	83 c3 01             	add    $0x1,%ebx
    2824:	83 fb 27             	cmp    $0x27,%ebx
    2827:	7f 71                	jg     289a <concreate+0x2d4>
    file[1] = '0' + i;
    2829:	8d 43 30             	lea    0x30(%ebx),%eax
    282c:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    282f:	e8 dc 1e 00 00       	call   4710 <fork>
    2834:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    2836:	85 c0                	test   %eax,%eax
    2838:	0f 88 74 ff ff ff    	js     27b2 <concreate+0x1ec>
    if(((i % 3) == 0 && pid == 0) ||
    283e:	ba 56 55 55 55       	mov    $0x55555556,%edx
    2843:	89 d8                	mov    %ebx,%eax
    2845:	f7 ea                	imul   %edx
    2847:	89 d8                	mov    %ebx,%eax
    2849:	c1 f8 1f             	sar    $0x1f,%eax
    284c:	29 c2                	sub    %eax,%edx
    284e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    2851:	89 da                	mov    %ebx,%edx
    2853:	29 c2                	sub    %eax,%edx
    2855:	89 d0                	mov    %edx,%eax
    2857:	09 f0                	or     %esi,%eax
    2859:	0f 84 67 ff ff ff    	je     27c6 <concreate+0x200>
    285f:	83 fa 01             	cmp    $0x1,%edx
    2862:	75 08                	jne    286c <concreate+0x2a6>
       ((i % 3) == 1 && pid != 0)){
    2864:	85 f6                	test   %esi,%esi
    2866:	0f 85 5a ff ff ff    	jne    27c6 <concreate+0x200>
      unlink(file);
    286c:	83 ec 0c             	sub    $0xc,%esp
    286f:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    2872:	57                   	push   %edi
    2873:	e8 f0 1e 00 00       	call   4768 <unlink>
      unlink(file);
    2878:	89 3c 24             	mov    %edi,(%esp)
    287b:	e8 e8 1e 00 00       	call   4768 <unlink>
      unlink(file);
    2880:	89 3c 24             	mov    %edi,(%esp)
    2883:	e8 e0 1e 00 00       	call   4768 <unlink>
      unlink(file);
    2888:	89 3c 24             	mov    %edi,(%esp)
    288b:	e8 d8 1e 00 00       	call   4768 <unlink>
    2890:	83 c4 10             	add    $0x10,%esp
    2893:	eb 83                	jmp    2818 <concreate+0x252>
      exit();
    2895:	e8 7e 1e 00 00       	call   4718 <exit>
  }

  printf(1, "concreate ok\n");
    289a:	83 ec 08             	sub    $0x8,%esp
    289d:	68 ea 51 00 00       	push   $0x51ea
    28a2:	6a 01                	push   $0x1
    28a4:	e8 d4 1f 00 00       	call   487d <printf>
}
    28a9:	83 c4 10             	add    $0x10,%esp
    28ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    28af:	5b                   	pop    %ebx
    28b0:	5e                   	pop    %esi
    28b1:	5f                   	pop    %edi
    28b2:	5d                   	pop    %ebp
    28b3:	c3                   	ret    

000028b4 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    28b4:	55                   	push   %ebp
    28b5:	89 e5                	mov    %esp,%ebp
    28b7:	57                   	push   %edi
    28b8:	56                   	push   %esi
    28b9:	53                   	push   %ebx
    28ba:	83 ec 14             	sub    $0x14,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    28bd:	68 f8 51 00 00       	push   $0x51f8
    28c2:	6a 01                	push   $0x1
    28c4:	e8 b4 1f 00 00       	call   487d <printf>

  unlink("x");
    28c9:	c7 04 24 85 54 00 00 	movl   $0x5485,(%esp)
    28d0:	e8 93 1e 00 00       	call   4768 <unlink>
  pid = fork();
    28d5:	e8 36 1e 00 00       	call   4710 <fork>
  if(pid < 0){
    28da:	83 c4 10             	add    $0x10,%esp
    28dd:	85 c0                	test   %eax,%eax
    28df:	78 10                	js     28f1 <linkunlink+0x3d>
    28e1:	89 c7                	mov    %eax,%edi
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    28e3:	74 20                	je     2905 <linkunlink+0x51>
    28e5:	bb 01 00 00 00       	mov    $0x1,%ebx
    28ea:	be 00 00 00 00       	mov    $0x0,%esi
    28ef:	eb 3b                	jmp    292c <linkunlink+0x78>
    printf(1, "fork failed\n");
    28f1:	83 ec 08             	sub    $0x8,%esp
    28f4:	68 6d 5a 00 00       	push   $0x5a6d
    28f9:	6a 01                	push   $0x1
    28fb:	e8 7d 1f 00 00       	call   487d <printf>
    exit();
    2900:	e8 13 1e 00 00       	call   4718 <exit>
  unsigned int x = (pid ? 1 : 97);
    2905:	bb 61 00 00 00       	mov    $0x61,%ebx
    290a:	eb de                	jmp    28ea <linkunlink+0x36>
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    290c:	83 ec 08             	sub    $0x8,%esp
    290f:	68 02 02 00 00       	push   $0x202
    2914:	68 85 54 00 00       	push   $0x5485
    2919:	e8 3a 1e 00 00       	call   4758 <open>
    291e:	89 04 24             	mov    %eax,(%esp)
    2921:	e8 1a 1e 00 00       	call   4740 <close>
    2926:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    2929:	83 c6 01             	add    $0x1,%esi
    292c:	83 fe 63             	cmp    $0x63,%esi
    292f:	7f 52                	jg     2983 <linkunlink+0xcf>
    x = x * 1103515245 + 12345;
    2931:	69 db 6d 4e c6 41    	imul   $0x41c64e6d,%ebx,%ebx
    2937:	81 c3 39 30 00 00    	add    $0x3039,%ebx
    if((x % 3) == 0){
    293d:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    2942:	89 d8                	mov    %ebx,%eax
    2944:	f7 e2                	mul    %edx
    2946:	89 d0                	mov    %edx,%eax
    2948:	d1 e8                	shr    %eax
    294a:	83 e2 fe             	and    $0xfffffffe,%edx
    294d:	01 c2                	add    %eax,%edx
    294f:	89 d8                	mov    %ebx,%eax
    2951:	29 d0                	sub    %edx,%eax
    2953:	74 b7                	je     290c <linkunlink+0x58>
    } else if((x % 3) == 1){
    2955:	83 f8 01             	cmp    $0x1,%eax
    2958:	74 12                	je     296c <linkunlink+0xb8>
      link("cat", "x");
    } else {
      unlink("x");
    295a:	83 ec 0c             	sub    $0xc,%esp
    295d:	68 85 54 00 00       	push   $0x5485
    2962:	e8 01 1e 00 00       	call   4768 <unlink>
    2967:	83 c4 10             	add    $0x10,%esp
    296a:	eb bd                	jmp    2929 <linkunlink+0x75>
      link("cat", "x");
    296c:	83 ec 08             	sub    $0x8,%esp
    296f:	68 85 54 00 00       	push   $0x5485
    2974:	68 09 52 00 00       	push   $0x5209
    2979:	e8 fa 1d 00 00       	call   4778 <link>
    297e:	83 c4 10             	add    $0x10,%esp
    2981:	eb a6                	jmp    2929 <linkunlink+0x75>
    }
  }

  if(pid)
    2983:	85 ff                	test   %edi,%edi
    2985:	74 1c                	je     29a3 <linkunlink+0xef>
    wait();
    2987:	e8 94 1d 00 00       	call   4720 <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    298c:	83 ec 08             	sub    $0x8,%esp
    298f:	68 0d 52 00 00       	push   $0x520d
    2994:	6a 01                	push   $0x1
    2996:	e8 e2 1e 00 00       	call   487d <printf>
}
    299b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    299e:	5b                   	pop    %ebx
    299f:	5e                   	pop    %esi
    29a0:	5f                   	pop    %edi
    29a1:	5d                   	pop    %ebp
    29a2:	c3                   	ret    
    exit();
    29a3:	e8 70 1d 00 00       	call   4718 <exit>

000029a8 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    29a8:	55                   	push   %ebp
    29a9:	89 e5                	mov    %esp,%ebp
    29ab:	53                   	push   %ebx
    29ac:	83 ec 1c             	sub    $0x1c,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    29af:	68 1c 52 00 00       	push   $0x521c
    29b4:	6a 01                	push   $0x1
    29b6:	e8 c2 1e 00 00       	call   487d <printf>
  unlink("bd");
    29bb:	c7 04 24 29 52 00 00 	movl   $0x5229,(%esp)
    29c2:	e8 a1 1d 00 00       	call   4768 <unlink>

  fd = open("bd", O_CREATE);
    29c7:	83 c4 08             	add    $0x8,%esp
    29ca:	68 00 02 00 00       	push   $0x200
    29cf:	68 29 52 00 00       	push   $0x5229
    29d4:	e8 7f 1d 00 00       	call   4758 <open>
  if(fd < 0){
    29d9:	83 c4 10             	add    $0x10,%esp
    29dc:	85 c0                	test   %eax,%eax
    29de:	78 65                	js     2a45 <bigdir+0x9d>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    29e0:	83 ec 0c             	sub    $0xc,%esp
    29e3:	50                   	push   %eax
    29e4:	e8 57 1d 00 00       	call   4740 <close>

  for(i = 0; i < 500; i++){
    29e9:	83 c4 10             	add    $0x10,%esp
    29ec:	bb 00 00 00 00       	mov    $0x0,%ebx
    29f1:	81 fb f3 01 00 00    	cmp    $0x1f3,%ebx
    29f7:	7f 74                	jg     2a6d <bigdir+0xc5>
    name[0] = 'x';
    29f9:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    29fd:	8d 43 3f             	lea    0x3f(%ebx),%eax
    2a00:	85 db                	test   %ebx,%ebx
    2a02:	0f 49 c3             	cmovns %ebx,%eax
    2a05:	c1 f8 06             	sar    $0x6,%eax
    2a08:	83 c0 30             	add    $0x30,%eax
    2a0b:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    2a0e:	89 da                	mov    %ebx,%edx
    2a10:	c1 fa 1f             	sar    $0x1f,%edx
    2a13:	c1 ea 1a             	shr    $0x1a,%edx
    2a16:	8d 04 13             	lea    (%ebx,%edx,1),%eax
    2a19:	83 e0 3f             	and    $0x3f,%eax
    2a1c:	29 d0                	sub    %edx,%eax
    2a1e:	83 c0 30             	add    $0x30,%eax
    2a21:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    2a24:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    2a28:	83 ec 08             	sub    $0x8,%esp
    2a2b:	8d 45 ee             	lea    -0x12(%ebp),%eax
    2a2e:	50                   	push   %eax
    2a2f:	68 29 52 00 00       	push   $0x5229
    2a34:	e8 3f 1d 00 00       	call   4778 <link>
    2a39:	83 c4 10             	add    $0x10,%esp
    2a3c:	85 c0                	test   %eax,%eax
    2a3e:	75 19                	jne    2a59 <bigdir+0xb1>
  for(i = 0; i < 500; i++){
    2a40:	83 c3 01             	add    $0x1,%ebx
    2a43:	eb ac                	jmp    29f1 <bigdir+0x49>
    printf(1, "bigdir create failed\n");
    2a45:	83 ec 08             	sub    $0x8,%esp
    2a48:	68 2c 52 00 00       	push   $0x522c
    2a4d:	6a 01                	push   $0x1
    2a4f:	e8 29 1e 00 00       	call   487d <printf>
    exit();
    2a54:	e8 bf 1c 00 00       	call   4718 <exit>
      printf(1, "bigdir link failed\n");
    2a59:	83 ec 08             	sub    $0x8,%esp
    2a5c:	68 42 52 00 00       	push   $0x5242
    2a61:	6a 01                	push   $0x1
    2a63:	e8 15 1e 00 00       	call   487d <printf>
      exit();
    2a68:	e8 ab 1c 00 00       	call   4718 <exit>
    }
  }

  unlink("bd");
    2a6d:	83 ec 0c             	sub    $0xc,%esp
    2a70:	68 29 52 00 00       	push   $0x5229
    2a75:	e8 ee 1c 00 00       	call   4768 <unlink>
  for(i = 0; i < 500; i++){
    2a7a:	83 c4 10             	add    $0x10,%esp
    2a7d:	bb 00 00 00 00       	mov    $0x0,%ebx
    2a82:	eb 03                	jmp    2a87 <bigdir+0xdf>
    2a84:	83 c3 01             	add    $0x1,%ebx
    2a87:	81 fb f3 01 00 00    	cmp    $0x1f3,%ebx
    2a8d:	7f 56                	jg     2ae5 <bigdir+0x13d>
    name[0] = 'x';
    2a8f:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    2a93:	8d 43 3f             	lea    0x3f(%ebx),%eax
    2a96:	85 db                	test   %ebx,%ebx
    2a98:	0f 49 c3             	cmovns %ebx,%eax
    2a9b:	c1 f8 06             	sar    $0x6,%eax
    2a9e:	83 c0 30             	add    $0x30,%eax
    2aa1:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    2aa4:	89 da                	mov    %ebx,%edx
    2aa6:	c1 fa 1f             	sar    $0x1f,%edx
    2aa9:	c1 ea 1a             	shr    $0x1a,%edx
    2aac:	8d 04 13             	lea    (%ebx,%edx,1),%eax
    2aaf:	83 e0 3f             	and    $0x3f,%eax
    2ab2:	29 d0                	sub    %edx,%eax
    2ab4:	83 c0 30             	add    $0x30,%eax
    2ab7:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    2aba:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    2abe:	83 ec 0c             	sub    $0xc,%esp
    2ac1:	8d 45 ee             	lea    -0x12(%ebp),%eax
    2ac4:	50                   	push   %eax
    2ac5:	e8 9e 1c 00 00       	call   4768 <unlink>
    2aca:	83 c4 10             	add    $0x10,%esp
    2acd:	85 c0                	test   %eax,%eax
    2acf:	74 b3                	je     2a84 <bigdir+0xdc>
      printf(1, "bigdir unlink failed");
    2ad1:	83 ec 08             	sub    $0x8,%esp
    2ad4:	68 56 52 00 00       	push   $0x5256
    2ad9:	6a 01                	push   $0x1
    2adb:	e8 9d 1d 00 00       	call   487d <printf>
      exit();
    2ae0:	e8 33 1c 00 00       	call   4718 <exit>
    }
  }

  printf(1, "bigdir ok\n");
    2ae5:	83 ec 08             	sub    $0x8,%esp
    2ae8:	68 6b 52 00 00       	push   $0x526b
    2aed:	6a 01                	push   $0x1
    2aef:	e8 89 1d 00 00       	call   487d <printf>
}
    2af4:	83 c4 10             	add    $0x10,%esp
    2af7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2afa:	c9                   	leave  
    2afb:	c3                   	ret    

00002afc <subdir>:

void
subdir(void)
{
    2afc:	55                   	push   %ebp
    2afd:	89 e5                	mov    %esp,%ebp
    2aff:	53                   	push   %ebx
    2b00:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    2b03:	68 76 52 00 00       	push   $0x5276
    2b08:	6a 01                	push   $0x1
    2b0a:	e8 6e 1d 00 00       	call   487d <printf>

  unlink("ff");
    2b0f:	c7 04 24 ff 52 00 00 	movl   $0x52ff,(%esp)
    2b16:	e8 4d 1c 00 00       	call   4768 <unlink>
  if(mkdir("dd") != 0){
    2b1b:	c7 04 24 9c 53 00 00 	movl   $0x539c,(%esp)
    2b22:	e8 59 1c 00 00       	call   4780 <mkdir>
    2b27:	83 c4 10             	add    $0x10,%esp
    2b2a:	85 c0                	test   %eax,%eax
    2b2c:	0f 85 14 04 00 00    	jne    2f46 <subdir+0x44a>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    2b32:	83 ec 08             	sub    $0x8,%esp
    2b35:	68 02 02 00 00       	push   $0x202
    2b3a:	68 d5 52 00 00       	push   $0x52d5
    2b3f:	e8 14 1c 00 00       	call   4758 <open>
    2b44:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2b46:	83 c4 10             	add    $0x10,%esp
    2b49:	85 c0                	test   %eax,%eax
    2b4b:	0f 88 09 04 00 00    	js     2f5a <subdir+0x45e>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    2b51:	83 ec 04             	sub    $0x4,%esp
    2b54:	6a 02                	push   $0x2
    2b56:	68 ff 52 00 00       	push   $0x52ff
    2b5b:	50                   	push   %eax
    2b5c:	e8 d7 1b 00 00       	call   4738 <write>
  close(fd);
    2b61:	89 1c 24             	mov    %ebx,(%esp)
    2b64:	e8 d7 1b 00 00       	call   4740 <close>

  if(unlink("dd") >= 0){
    2b69:	c7 04 24 9c 53 00 00 	movl   $0x539c,(%esp)
    2b70:	e8 f3 1b 00 00       	call   4768 <unlink>
    2b75:	83 c4 10             	add    $0x10,%esp
    2b78:	85 c0                	test   %eax,%eax
    2b7a:	0f 89 ee 03 00 00    	jns    2f6e <subdir+0x472>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    2b80:	83 ec 0c             	sub    $0xc,%esp
    2b83:	68 b0 52 00 00       	push   $0x52b0
    2b88:	e8 f3 1b 00 00       	call   4780 <mkdir>
    2b8d:	83 c4 10             	add    $0x10,%esp
    2b90:	85 c0                	test   %eax,%eax
    2b92:	0f 85 ea 03 00 00    	jne    2f82 <subdir+0x486>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2b98:	83 ec 08             	sub    $0x8,%esp
    2b9b:	68 02 02 00 00       	push   $0x202
    2ba0:	68 d2 52 00 00       	push   $0x52d2
    2ba5:	e8 ae 1b 00 00       	call   4758 <open>
    2baa:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2bac:	83 c4 10             	add    $0x10,%esp
    2baf:	85 c0                	test   %eax,%eax
    2bb1:	0f 88 df 03 00 00    	js     2f96 <subdir+0x49a>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    2bb7:	83 ec 04             	sub    $0x4,%esp
    2bba:	6a 02                	push   $0x2
    2bbc:	68 f3 52 00 00       	push   $0x52f3
    2bc1:	50                   	push   %eax
    2bc2:	e8 71 1b 00 00       	call   4738 <write>
  close(fd);
    2bc7:	89 1c 24             	mov    %ebx,(%esp)
    2bca:	e8 71 1b 00 00       	call   4740 <close>

  fd = open("dd/dd/../ff", 0);
    2bcf:	83 c4 08             	add    $0x8,%esp
    2bd2:	6a 00                	push   $0x0
    2bd4:	68 f6 52 00 00       	push   $0x52f6
    2bd9:	e8 7a 1b 00 00       	call   4758 <open>
    2bde:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2be0:	83 c4 10             	add    $0x10,%esp
    2be3:	85 c0                	test   %eax,%eax
    2be5:	0f 88 bf 03 00 00    	js     2faa <subdir+0x4ae>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    2beb:	83 ec 04             	sub    $0x4,%esp
    2bee:	68 00 20 00 00       	push   $0x2000
    2bf3:	68 00 93 00 00       	push   $0x9300
    2bf8:	50                   	push   %eax
    2bf9:	e8 32 1b 00 00       	call   4730 <read>
  if(cc != 2 || buf[0] != 'f'){
    2bfe:	83 c4 10             	add    $0x10,%esp
    2c01:	83 f8 02             	cmp    $0x2,%eax
    2c04:	0f 85 b4 03 00 00    	jne    2fbe <subdir+0x4c2>
    2c0a:	80 3d 00 93 00 00 66 	cmpb   $0x66,0x9300
    2c11:	0f 85 a7 03 00 00    	jne    2fbe <subdir+0x4c2>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    2c17:	83 ec 0c             	sub    $0xc,%esp
    2c1a:	53                   	push   %ebx
    2c1b:	e8 20 1b 00 00       	call   4740 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2c20:	83 c4 08             	add    $0x8,%esp
    2c23:	68 36 53 00 00       	push   $0x5336
    2c28:	68 d2 52 00 00       	push   $0x52d2
    2c2d:	e8 46 1b 00 00       	call   4778 <link>
    2c32:	83 c4 10             	add    $0x10,%esp
    2c35:	85 c0                	test   %eax,%eax
    2c37:	0f 85 95 03 00 00    	jne    2fd2 <subdir+0x4d6>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    2c3d:	83 ec 0c             	sub    $0xc,%esp
    2c40:	68 d2 52 00 00       	push   $0x52d2
    2c45:	e8 1e 1b 00 00       	call   4768 <unlink>
    2c4a:	83 c4 10             	add    $0x10,%esp
    2c4d:	85 c0                	test   %eax,%eax
    2c4f:	0f 85 91 03 00 00    	jne    2fe6 <subdir+0x4ea>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2c55:	83 ec 08             	sub    $0x8,%esp
    2c58:	6a 00                	push   $0x0
    2c5a:	68 d2 52 00 00       	push   $0x52d2
    2c5f:	e8 f4 1a 00 00       	call   4758 <open>
    2c64:	83 c4 10             	add    $0x10,%esp
    2c67:	85 c0                	test   %eax,%eax
    2c69:	0f 89 8b 03 00 00    	jns    2ffa <subdir+0x4fe>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    2c6f:	83 ec 0c             	sub    $0xc,%esp
    2c72:	68 9c 53 00 00       	push   $0x539c
    2c77:	e8 0c 1b 00 00       	call   4788 <chdir>
    2c7c:	83 c4 10             	add    $0x10,%esp
    2c7f:	85 c0                	test   %eax,%eax
    2c81:	0f 85 87 03 00 00    	jne    300e <subdir+0x512>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    2c87:	83 ec 0c             	sub    $0xc,%esp
    2c8a:	68 6a 53 00 00       	push   $0x536a
    2c8f:	e8 f4 1a 00 00       	call   4788 <chdir>
    2c94:	83 c4 10             	add    $0x10,%esp
    2c97:	85 c0                	test   %eax,%eax
    2c99:	0f 85 83 03 00 00    	jne    3022 <subdir+0x526>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    2c9f:	83 ec 0c             	sub    $0xc,%esp
    2ca2:	68 90 53 00 00       	push   $0x5390
    2ca7:	e8 dc 1a 00 00       	call   4788 <chdir>
    2cac:	83 c4 10             	add    $0x10,%esp
    2caf:	85 c0                	test   %eax,%eax
    2cb1:	0f 85 7f 03 00 00    	jne    3036 <subdir+0x53a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    2cb7:	83 ec 0c             	sub    $0xc,%esp
    2cba:	68 9f 53 00 00       	push   $0x539f
    2cbf:	e8 c4 1a 00 00       	call   4788 <chdir>
    2cc4:	83 c4 10             	add    $0x10,%esp
    2cc7:	85 c0                	test   %eax,%eax
    2cc9:	0f 85 7b 03 00 00    	jne    304a <subdir+0x54e>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    2ccf:	83 ec 08             	sub    $0x8,%esp
    2cd2:	6a 00                	push   $0x0
    2cd4:	68 36 53 00 00       	push   $0x5336
    2cd9:	e8 7a 1a 00 00       	call   4758 <open>
    2cde:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2ce0:	83 c4 10             	add    $0x10,%esp
    2ce3:	85 c0                	test   %eax,%eax
    2ce5:	0f 88 73 03 00 00    	js     305e <subdir+0x562>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2ceb:	83 ec 04             	sub    $0x4,%esp
    2cee:	68 00 20 00 00       	push   $0x2000
    2cf3:	68 00 93 00 00       	push   $0x9300
    2cf8:	50                   	push   %eax
    2cf9:	e8 32 1a 00 00       	call   4730 <read>
    2cfe:	83 c4 10             	add    $0x10,%esp
    2d01:	83 f8 02             	cmp    $0x2,%eax
    2d04:	0f 85 68 03 00 00    	jne    3072 <subdir+0x576>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    2d0a:	83 ec 0c             	sub    $0xc,%esp
    2d0d:	53                   	push   %ebx
    2d0e:	e8 2d 1a 00 00       	call   4740 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2d13:	83 c4 08             	add    $0x8,%esp
    2d16:	6a 00                	push   $0x0
    2d18:	68 d2 52 00 00       	push   $0x52d2
    2d1d:	e8 36 1a 00 00       	call   4758 <open>
    2d22:	83 c4 10             	add    $0x10,%esp
    2d25:	85 c0                	test   %eax,%eax
    2d27:	0f 89 59 03 00 00    	jns    3086 <subdir+0x58a>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2d2d:	83 ec 08             	sub    $0x8,%esp
    2d30:	68 02 02 00 00       	push   $0x202
    2d35:	68 ea 53 00 00       	push   $0x53ea
    2d3a:	e8 19 1a 00 00       	call   4758 <open>
    2d3f:	83 c4 10             	add    $0x10,%esp
    2d42:	85 c0                	test   %eax,%eax
    2d44:	0f 89 50 03 00 00    	jns    309a <subdir+0x59e>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2d4a:	83 ec 08             	sub    $0x8,%esp
    2d4d:	68 02 02 00 00       	push   $0x202
    2d52:	68 0f 54 00 00       	push   $0x540f
    2d57:	e8 fc 19 00 00       	call   4758 <open>
    2d5c:	83 c4 10             	add    $0x10,%esp
    2d5f:	85 c0                	test   %eax,%eax
    2d61:	0f 89 47 03 00 00    	jns    30ae <subdir+0x5b2>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    2d67:	83 ec 08             	sub    $0x8,%esp
    2d6a:	68 00 02 00 00       	push   $0x200
    2d6f:	68 9c 53 00 00       	push   $0x539c
    2d74:	e8 df 19 00 00       	call   4758 <open>
    2d79:	83 c4 10             	add    $0x10,%esp
    2d7c:	85 c0                	test   %eax,%eax
    2d7e:	0f 89 3e 03 00 00    	jns    30c2 <subdir+0x5c6>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    2d84:	83 ec 08             	sub    $0x8,%esp
    2d87:	6a 02                	push   $0x2
    2d89:	68 9c 53 00 00       	push   $0x539c
    2d8e:	e8 c5 19 00 00       	call   4758 <open>
    2d93:	83 c4 10             	add    $0x10,%esp
    2d96:	85 c0                	test   %eax,%eax
    2d98:	0f 89 38 03 00 00    	jns    30d6 <subdir+0x5da>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    2d9e:	83 ec 08             	sub    $0x8,%esp
    2da1:	6a 01                	push   $0x1
    2da3:	68 9c 53 00 00       	push   $0x539c
    2da8:	e8 ab 19 00 00       	call   4758 <open>
    2dad:	83 c4 10             	add    $0x10,%esp
    2db0:	85 c0                	test   %eax,%eax
    2db2:	0f 89 32 03 00 00    	jns    30ea <subdir+0x5ee>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2db8:	83 ec 08             	sub    $0x8,%esp
    2dbb:	68 7e 54 00 00       	push   $0x547e
    2dc0:	68 ea 53 00 00       	push   $0x53ea
    2dc5:	e8 ae 19 00 00       	call   4778 <link>
    2dca:	83 c4 10             	add    $0x10,%esp
    2dcd:	85 c0                	test   %eax,%eax
    2dcf:	0f 84 29 03 00 00    	je     30fe <subdir+0x602>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2dd5:	83 ec 08             	sub    $0x8,%esp
    2dd8:	68 7e 54 00 00       	push   $0x547e
    2ddd:	68 0f 54 00 00       	push   $0x540f
    2de2:	e8 91 19 00 00       	call   4778 <link>
    2de7:	83 c4 10             	add    $0x10,%esp
    2dea:	85 c0                	test   %eax,%eax
    2dec:	0f 84 20 03 00 00    	je     3112 <subdir+0x616>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2df2:	83 ec 08             	sub    $0x8,%esp
    2df5:	68 36 53 00 00       	push   $0x5336
    2dfa:	68 d5 52 00 00       	push   $0x52d5
    2dff:	e8 74 19 00 00       	call   4778 <link>
    2e04:	83 c4 10             	add    $0x10,%esp
    2e07:	85 c0                	test   %eax,%eax
    2e09:	0f 84 17 03 00 00    	je     3126 <subdir+0x62a>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    2e0f:	83 ec 0c             	sub    $0xc,%esp
    2e12:	68 ea 53 00 00       	push   $0x53ea
    2e17:	e8 64 19 00 00       	call   4780 <mkdir>
    2e1c:	83 c4 10             	add    $0x10,%esp
    2e1f:	85 c0                	test   %eax,%eax
    2e21:	0f 84 13 03 00 00    	je     313a <subdir+0x63e>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    2e27:	83 ec 0c             	sub    $0xc,%esp
    2e2a:	68 0f 54 00 00       	push   $0x540f
    2e2f:	e8 4c 19 00 00       	call   4780 <mkdir>
    2e34:	83 c4 10             	add    $0x10,%esp
    2e37:	85 c0                	test   %eax,%eax
    2e39:	0f 84 0f 03 00 00    	je     314e <subdir+0x652>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    2e3f:	83 ec 0c             	sub    $0xc,%esp
    2e42:	68 36 53 00 00       	push   $0x5336
    2e47:	e8 34 19 00 00       	call   4780 <mkdir>
    2e4c:	83 c4 10             	add    $0x10,%esp
    2e4f:	85 c0                	test   %eax,%eax
    2e51:	0f 84 0b 03 00 00    	je     3162 <subdir+0x666>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    2e57:	83 ec 0c             	sub    $0xc,%esp
    2e5a:	68 0f 54 00 00       	push   $0x540f
    2e5f:	e8 04 19 00 00       	call   4768 <unlink>
    2e64:	83 c4 10             	add    $0x10,%esp
    2e67:	85 c0                	test   %eax,%eax
    2e69:	0f 84 07 03 00 00    	je     3176 <subdir+0x67a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    2e6f:	83 ec 0c             	sub    $0xc,%esp
    2e72:	68 ea 53 00 00       	push   $0x53ea
    2e77:	e8 ec 18 00 00       	call   4768 <unlink>
    2e7c:	83 c4 10             	add    $0x10,%esp
    2e7f:	85 c0                	test   %eax,%eax
    2e81:	0f 84 03 03 00 00    	je     318a <subdir+0x68e>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    2e87:	83 ec 0c             	sub    $0xc,%esp
    2e8a:	68 d5 52 00 00       	push   $0x52d5
    2e8f:	e8 f4 18 00 00       	call   4788 <chdir>
    2e94:	83 c4 10             	add    $0x10,%esp
    2e97:	85 c0                	test   %eax,%eax
    2e99:	0f 84 ff 02 00 00    	je     319e <subdir+0x6a2>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    2e9f:	83 ec 0c             	sub    $0xc,%esp
    2ea2:	68 81 54 00 00       	push   $0x5481
    2ea7:	e8 dc 18 00 00       	call   4788 <chdir>
    2eac:	83 c4 10             	add    $0x10,%esp
    2eaf:	85 c0                	test   %eax,%eax
    2eb1:	0f 84 fb 02 00 00    	je     31b2 <subdir+0x6b6>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    2eb7:	83 ec 0c             	sub    $0xc,%esp
    2eba:	68 36 53 00 00       	push   $0x5336
    2ebf:	e8 a4 18 00 00       	call   4768 <unlink>
    2ec4:	83 c4 10             	add    $0x10,%esp
    2ec7:	85 c0                	test   %eax,%eax
    2ec9:	0f 85 f7 02 00 00    	jne    31c6 <subdir+0x6ca>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    2ecf:	83 ec 0c             	sub    $0xc,%esp
    2ed2:	68 d5 52 00 00       	push   $0x52d5
    2ed7:	e8 8c 18 00 00       	call   4768 <unlink>
    2edc:	83 c4 10             	add    $0x10,%esp
    2edf:	85 c0                	test   %eax,%eax
    2ee1:	0f 85 f3 02 00 00    	jne    31da <subdir+0x6de>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    2ee7:	83 ec 0c             	sub    $0xc,%esp
    2eea:	68 9c 53 00 00       	push   $0x539c
    2eef:	e8 74 18 00 00       	call   4768 <unlink>
    2ef4:	83 c4 10             	add    $0x10,%esp
    2ef7:	85 c0                	test   %eax,%eax
    2ef9:	0f 84 ef 02 00 00    	je     31ee <subdir+0x6f2>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    2eff:	83 ec 0c             	sub    $0xc,%esp
    2f02:	68 b1 52 00 00       	push   $0x52b1
    2f07:	e8 5c 18 00 00       	call   4768 <unlink>
    2f0c:	83 c4 10             	add    $0x10,%esp
    2f0f:	85 c0                	test   %eax,%eax
    2f11:	0f 88 eb 02 00 00    	js     3202 <subdir+0x706>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    2f17:	83 ec 0c             	sub    $0xc,%esp
    2f1a:	68 9c 53 00 00       	push   $0x539c
    2f1f:	e8 44 18 00 00       	call   4768 <unlink>
    2f24:	83 c4 10             	add    $0x10,%esp
    2f27:	85 c0                	test   %eax,%eax
    2f29:	0f 88 e7 02 00 00    	js     3216 <subdir+0x71a>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    2f2f:	83 ec 08             	sub    $0x8,%esp
    2f32:	68 7e 55 00 00       	push   $0x557e
    2f37:	6a 01                	push   $0x1
    2f39:	e8 3f 19 00 00       	call   487d <printf>
}
    2f3e:	83 c4 10             	add    $0x10,%esp
    2f41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2f44:	c9                   	leave  
    2f45:	c3                   	ret    
    printf(1, "subdir mkdir dd failed\n");
    2f46:	83 ec 08             	sub    $0x8,%esp
    2f49:	68 83 52 00 00       	push   $0x5283
    2f4e:	6a 01                	push   $0x1
    2f50:	e8 28 19 00 00       	call   487d <printf>
    exit();
    2f55:	e8 be 17 00 00       	call   4718 <exit>
    printf(1, "create dd/ff failed\n");
    2f5a:	83 ec 08             	sub    $0x8,%esp
    2f5d:	68 9b 52 00 00       	push   $0x529b
    2f62:	6a 01                	push   $0x1
    2f64:	e8 14 19 00 00       	call   487d <printf>
    exit();
    2f69:	e8 aa 17 00 00       	call   4718 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2f6e:	83 ec 08             	sub    $0x8,%esp
    2f71:	68 68 5d 00 00       	push   $0x5d68
    2f76:	6a 01                	push   $0x1
    2f78:	e8 00 19 00 00       	call   487d <printf>
    exit();
    2f7d:	e8 96 17 00 00       	call   4718 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    2f82:	83 ec 08             	sub    $0x8,%esp
    2f85:	68 b7 52 00 00       	push   $0x52b7
    2f8a:	6a 01                	push   $0x1
    2f8c:	e8 ec 18 00 00       	call   487d <printf>
    exit();
    2f91:	e8 82 17 00 00       	call   4718 <exit>
    printf(1, "create dd/dd/ff failed\n");
    2f96:	83 ec 08             	sub    $0x8,%esp
    2f99:	68 db 52 00 00       	push   $0x52db
    2f9e:	6a 01                	push   $0x1
    2fa0:	e8 d8 18 00 00       	call   487d <printf>
    exit();
    2fa5:	e8 6e 17 00 00       	call   4718 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    2faa:	83 ec 08             	sub    $0x8,%esp
    2fad:	68 02 53 00 00       	push   $0x5302
    2fb2:	6a 01                	push   $0x1
    2fb4:	e8 c4 18 00 00       	call   487d <printf>
    exit();
    2fb9:	e8 5a 17 00 00       	call   4718 <exit>
    printf(1, "dd/dd/../ff wrong content\n");
    2fbe:	83 ec 08             	sub    $0x8,%esp
    2fc1:	68 1b 53 00 00       	push   $0x531b
    2fc6:	6a 01                	push   $0x1
    2fc8:	e8 b0 18 00 00       	call   487d <printf>
    exit();
    2fcd:	e8 46 17 00 00       	call   4718 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2fd2:	83 ec 08             	sub    $0x8,%esp
    2fd5:	68 90 5d 00 00       	push   $0x5d90
    2fda:	6a 01                	push   $0x1
    2fdc:	e8 9c 18 00 00       	call   487d <printf>
    exit();
    2fe1:	e8 32 17 00 00       	call   4718 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    2fe6:	83 ec 08             	sub    $0x8,%esp
    2fe9:	68 41 53 00 00       	push   $0x5341
    2fee:	6a 01                	push   $0x1
    2ff0:	e8 88 18 00 00       	call   487d <printf>
    exit();
    2ff5:	e8 1e 17 00 00       	call   4718 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2ffa:	83 ec 08             	sub    $0x8,%esp
    2ffd:	68 b4 5d 00 00       	push   $0x5db4
    3002:	6a 01                	push   $0x1
    3004:	e8 74 18 00 00       	call   487d <printf>
    exit();
    3009:	e8 0a 17 00 00       	call   4718 <exit>
    printf(1, "chdir dd failed\n");
    300e:	83 ec 08             	sub    $0x8,%esp
    3011:	68 59 53 00 00       	push   $0x5359
    3016:	6a 01                	push   $0x1
    3018:	e8 60 18 00 00       	call   487d <printf>
    exit();
    301d:	e8 f6 16 00 00       	call   4718 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    3022:	83 ec 08             	sub    $0x8,%esp
    3025:	68 76 53 00 00       	push   $0x5376
    302a:	6a 01                	push   $0x1
    302c:	e8 4c 18 00 00       	call   487d <printf>
    exit();
    3031:	e8 e2 16 00 00       	call   4718 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    3036:	83 ec 08             	sub    $0x8,%esp
    3039:	68 76 53 00 00       	push   $0x5376
    303e:	6a 01                	push   $0x1
    3040:	e8 38 18 00 00       	call   487d <printf>
    exit();
    3045:	e8 ce 16 00 00       	call   4718 <exit>
    printf(1, "chdir ./.. failed\n");
    304a:	83 ec 08             	sub    $0x8,%esp
    304d:	68 a4 53 00 00       	push   $0x53a4
    3052:	6a 01                	push   $0x1
    3054:	e8 24 18 00 00       	call   487d <printf>
    exit();
    3059:	e8 ba 16 00 00       	call   4718 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    305e:	83 ec 08             	sub    $0x8,%esp
    3061:	68 b7 53 00 00       	push   $0x53b7
    3066:	6a 01                	push   $0x1
    3068:	e8 10 18 00 00       	call   487d <printf>
    exit();
    306d:	e8 a6 16 00 00       	call   4718 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    3072:	83 ec 08             	sub    $0x8,%esp
    3075:	68 cf 53 00 00       	push   $0x53cf
    307a:	6a 01                	push   $0x1
    307c:	e8 fc 17 00 00       	call   487d <printf>
    exit();
    3081:	e8 92 16 00 00       	call   4718 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    3086:	83 ec 08             	sub    $0x8,%esp
    3089:	68 d8 5d 00 00       	push   $0x5dd8
    308e:	6a 01                	push   $0x1
    3090:	e8 e8 17 00 00       	call   487d <printf>
    exit();
    3095:	e8 7e 16 00 00       	call   4718 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    309a:	83 ec 08             	sub    $0x8,%esp
    309d:	68 f3 53 00 00       	push   $0x53f3
    30a2:	6a 01                	push   $0x1
    30a4:	e8 d4 17 00 00       	call   487d <printf>
    exit();
    30a9:	e8 6a 16 00 00       	call   4718 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    30ae:	83 ec 08             	sub    $0x8,%esp
    30b1:	68 18 54 00 00       	push   $0x5418
    30b6:	6a 01                	push   $0x1
    30b8:	e8 c0 17 00 00       	call   487d <printf>
    exit();
    30bd:	e8 56 16 00 00       	call   4718 <exit>
    printf(1, "create dd succeeded!\n");
    30c2:	83 ec 08             	sub    $0x8,%esp
    30c5:	68 34 54 00 00       	push   $0x5434
    30ca:	6a 01                	push   $0x1
    30cc:	e8 ac 17 00 00       	call   487d <printf>
    exit();
    30d1:	e8 42 16 00 00       	call   4718 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    30d6:	83 ec 08             	sub    $0x8,%esp
    30d9:	68 4a 54 00 00       	push   $0x544a
    30de:	6a 01                	push   $0x1
    30e0:	e8 98 17 00 00       	call   487d <printf>
    exit();
    30e5:	e8 2e 16 00 00       	call   4718 <exit>
    printf(1, "open dd wronly succeeded!\n");
    30ea:	83 ec 08             	sub    $0x8,%esp
    30ed:	68 63 54 00 00       	push   $0x5463
    30f2:	6a 01                	push   $0x1
    30f4:	e8 84 17 00 00       	call   487d <printf>
    exit();
    30f9:	e8 1a 16 00 00       	call   4718 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    30fe:	83 ec 08             	sub    $0x8,%esp
    3101:	68 00 5e 00 00       	push   $0x5e00
    3106:	6a 01                	push   $0x1
    3108:	e8 70 17 00 00       	call   487d <printf>
    exit();
    310d:	e8 06 16 00 00       	call   4718 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    3112:	83 ec 08             	sub    $0x8,%esp
    3115:	68 24 5e 00 00       	push   $0x5e24
    311a:	6a 01                	push   $0x1
    311c:	e8 5c 17 00 00       	call   487d <printf>
    exit();
    3121:	e8 f2 15 00 00       	call   4718 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    3126:	83 ec 08             	sub    $0x8,%esp
    3129:	68 48 5e 00 00       	push   $0x5e48
    312e:	6a 01                	push   $0x1
    3130:	e8 48 17 00 00       	call   487d <printf>
    exit();
    3135:	e8 de 15 00 00       	call   4718 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    313a:	83 ec 08             	sub    $0x8,%esp
    313d:	68 87 54 00 00       	push   $0x5487
    3142:	6a 01                	push   $0x1
    3144:	e8 34 17 00 00       	call   487d <printf>
    exit();
    3149:	e8 ca 15 00 00       	call   4718 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    314e:	83 ec 08             	sub    $0x8,%esp
    3151:	68 a2 54 00 00       	push   $0x54a2
    3156:	6a 01                	push   $0x1
    3158:	e8 20 17 00 00       	call   487d <printf>
    exit();
    315d:	e8 b6 15 00 00       	call   4718 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    3162:	83 ec 08             	sub    $0x8,%esp
    3165:	68 bd 54 00 00       	push   $0x54bd
    316a:	6a 01                	push   $0x1
    316c:	e8 0c 17 00 00       	call   487d <printf>
    exit();
    3171:	e8 a2 15 00 00       	call   4718 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    3176:	83 ec 08             	sub    $0x8,%esp
    3179:	68 da 54 00 00       	push   $0x54da
    317e:	6a 01                	push   $0x1
    3180:	e8 f8 16 00 00       	call   487d <printf>
    exit();
    3185:	e8 8e 15 00 00       	call   4718 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    318a:	83 ec 08             	sub    $0x8,%esp
    318d:	68 f6 54 00 00       	push   $0x54f6
    3192:	6a 01                	push   $0x1
    3194:	e8 e4 16 00 00       	call   487d <printf>
    exit();
    3199:	e8 7a 15 00 00       	call   4718 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    319e:	83 ec 08             	sub    $0x8,%esp
    31a1:	68 12 55 00 00       	push   $0x5512
    31a6:	6a 01                	push   $0x1
    31a8:	e8 d0 16 00 00       	call   487d <printf>
    exit();
    31ad:	e8 66 15 00 00       	call   4718 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    31b2:	83 ec 08             	sub    $0x8,%esp
    31b5:	68 2a 55 00 00       	push   $0x552a
    31ba:	6a 01                	push   $0x1
    31bc:	e8 bc 16 00 00       	call   487d <printf>
    exit();
    31c1:	e8 52 15 00 00       	call   4718 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    31c6:	83 ec 08             	sub    $0x8,%esp
    31c9:	68 41 53 00 00       	push   $0x5341
    31ce:	6a 01                	push   $0x1
    31d0:	e8 a8 16 00 00       	call   487d <printf>
    exit();
    31d5:	e8 3e 15 00 00       	call   4718 <exit>
    printf(1, "unlink dd/ff failed\n");
    31da:	83 ec 08             	sub    $0x8,%esp
    31dd:	68 42 55 00 00       	push   $0x5542
    31e2:	6a 01                	push   $0x1
    31e4:	e8 94 16 00 00       	call   487d <printf>
    exit();
    31e9:	e8 2a 15 00 00       	call   4718 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    31ee:	83 ec 08             	sub    $0x8,%esp
    31f1:	68 6c 5e 00 00       	push   $0x5e6c
    31f6:	6a 01                	push   $0x1
    31f8:	e8 80 16 00 00       	call   487d <printf>
    exit();
    31fd:	e8 16 15 00 00       	call   4718 <exit>
    printf(1, "unlink dd/dd failed\n");
    3202:	83 ec 08             	sub    $0x8,%esp
    3205:	68 57 55 00 00       	push   $0x5557
    320a:	6a 01                	push   $0x1
    320c:	e8 6c 16 00 00       	call   487d <printf>
    exit();
    3211:	e8 02 15 00 00       	call   4718 <exit>
    printf(1, "unlink dd failed\n");
    3216:	83 ec 08             	sub    $0x8,%esp
    3219:	68 6c 55 00 00       	push   $0x556c
    321e:	6a 01                	push   $0x1
    3220:	e8 58 16 00 00       	call   487d <printf>
    exit();
    3225:	e8 ee 14 00 00       	call   4718 <exit>

0000322a <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    322a:	55                   	push   %ebp
    322b:	89 e5                	mov    %esp,%ebp
    322d:	57                   	push   %edi
    322e:	56                   	push   %esi
    322f:	53                   	push   %ebx
    3230:	83 ec 14             	sub    $0x14,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    3233:	68 89 55 00 00       	push   $0x5589
    3238:	6a 01                	push   $0x1
    323a:	e8 3e 16 00 00       	call   487d <printf>

  unlink("bigwrite");
    323f:	c7 04 24 98 55 00 00 	movl   $0x5598,(%esp)
    3246:	e8 1d 15 00 00       	call   4768 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    324b:	83 c4 10             	add    $0x10,%esp
    324e:	be f3 01 00 00       	mov    $0x1f3,%esi
    3253:	eb 45                	jmp    329a <bigwrite+0x70>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    3255:	83 ec 08             	sub    $0x8,%esp
    3258:	68 a1 55 00 00       	push   $0x55a1
    325d:	6a 01                	push   $0x1
    325f:	e8 19 16 00 00       	call   487d <printf>
      exit();
    3264:	e8 af 14 00 00       	call   4718 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    3269:	50                   	push   %eax
    326a:	56                   	push   %esi
    326b:	68 b9 55 00 00       	push   $0x55b9
    3270:	6a 01                	push   $0x1
    3272:	e8 06 16 00 00       	call   487d <printf>
        exit();
    3277:	e8 9c 14 00 00       	call   4718 <exit>
      }
    }
    close(fd);
    327c:	83 ec 0c             	sub    $0xc,%esp
    327f:	57                   	push   %edi
    3280:	e8 bb 14 00 00       	call   4740 <close>
    unlink("bigwrite");
    3285:	c7 04 24 98 55 00 00 	movl   $0x5598,(%esp)
    328c:	e8 d7 14 00 00       	call   4768 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    3291:	81 c6 d7 01 00 00    	add    $0x1d7,%esi
    3297:	83 c4 10             	add    $0x10,%esp
    329a:	81 fe ff 17 00 00    	cmp    $0x17ff,%esi
    32a0:	7f 40                	jg     32e2 <bigwrite+0xb8>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    32a2:	83 ec 08             	sub    $0x8,%esp
    32a5:	68 02 02 00 00       	push   $0x202
    32aa:	68 98 55 00 00       	push   $0x5598
    32af:	e8 a4 14 00 00       	call   4758 <open>
    32b4:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    32b6:	83 c4 10             	add    $0x10,%esp
    32b9:	85 c0                	test   %eax,%eax
    32bb:	78 98                	js     3255 <bigwrite+0x2b>
    for(i = 0; i < 2; i++){
    32bd:	bb 00 00 00 00       	mov    $0x0,%ebx
    32c2:	83 fb 01             	cmp    $0x1,%ebx
    32c5:	7f b5                	jg     327c <bigwrite+0x52>
      int cc = write(fd, buf, sz);
    32c7:	83 ec 04             	sub    $0x4,%esp
    32ca:	56                   	push   %esi
    32cb:	68 00 93 00 00       	push   $0x9300
    32d0:	57                   	push   %edi
    32d1:	e8 62 14 00 00       	call   4738 <write>
      if(cc != sz){
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	39 c6                	cmp    %eax,%esi
    32db:	75 8c                	jne    3269 <bigwrite+0x3f>
    for(i = 0; i < 2; i++){
    32dd:	83 c3 01             	add    $0x1,%ebx
    32e0:	eb e0                	jmp    32c2 <bigwrite+0x98>
  }

  printf(1, "bigwrite ok\n");
    32e2:	83 ec 08             	sub    $0x8,%esp
    32e5:	68 cb 55 00 00       	push   $0x55cb
    32ea:	6a 01                	push   $0x1
    32ec:	e8 8c 15 00 00       	call   487d <printf>
}
    32f1:	83 c4 10             	add    $0x10,%esp
    32f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    32f7:	5b                   	pop    %ebx
    32f8:	5e                   	pop    %esi
    32f9:	5f                   	pop    %edi
    32fa:	5d                   	pop    %ebp
    32fb:	c3                   	ret    

000032fc <bigfile>:

void
bigfile(void)
{
    32fc:	55                   	push   %ebp
    32fd:	89 e5                	mov    %esp,%ebp
    32ff:	57                   	push   %edi
    3300:	56                   	push   %esi
    3301:	53                   	push   %ebx
    3302:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    3305:	68 d8 55 00 00       	push   $0x55d8
    330a:	6a 01                	push   $0x1
    330c:	e8 6c 15 00 00       	call   487d <printf>

  unlink("bigfile");
    3311:	c7 04 24 f4 55 00 00 	movl   $0x55f4,(%esp)
    3318:	e8 4b 14 00 00       	call   4768 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    331d:	83 c4 08             	add    $0x8,%esp
    3320:	68 02 02 00 00       	push   $0x202
    3325:	68 f4 55 00 00       	push   $0x55f4
    332a:	e8 29 14 00 00       	call   4758 <open>
  if(fd < 0){
    332f:	83 c4 10             	add    $0x10,%esp
    3332:	85 c0                	test   %eax,%eax
    3334:	78 41                	js     3377 <bigfile+0x7b>
    3336:	89 c6                	mov    %eax,%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    3338:	bb 00 00 00 00       	mov    $0x0,%ebx
    333d:	83 fb 13             	cmp    $0x13,%ebx
    3340:	7f 5d                	jg     339f <bigfile+0xa3>
    memset(buf, i, 600);
    3342:	83 ec 04             	sub    $0x4,%esp
    3345:	68 58 02 00 00       	push   $0x258
    334a:	53                   	push   %ebx
    334b:	68 00 93 00 00       	push   $0x9300
    3350:	e8 88 12 00 00       	call   45dd <memset>
    if(write(fd, buf, 600) != 600){
    3355:	83 c4 0c             	add    $0xc,%esp
    3358:	68 58 02 00 00       	push   $0x258
    335d:	68 00 93 00 00       	push   $0x9300
    3362:	56                   	push   %esi
    3363:	e8 d0 13 00 00       	call   4738 <write>
    3368:	83 c4 10             	add    $0x10,%esp
    336b:	3d 58 02 00 00       	cmp    $0x258,%eax
    3370:	75 19                	jne    338b <bigfile+0x8f>
  for(i = 0; i < 20; i++){
    3372:	83 c3 01             	add    $0x1,%ebx
    3375:	eb c6                	jmp    333d <bigfile+0x41>
    printf(1, "cannot create bigfile");
    3377:	83 ec 08             	sub    $0x8,%esp
    337a:	68 e6 55 00 00       	push   $0x55e6
    337f:	6a 01                	push   $0x1
    3381:	e8 f7 14 00 00       	call   487d <printf>
    exit();
    3386:	e8 8d 13 00 00       	call   4718 <exit>
      printf(1, "write bigfile failed\n");
    338b:	83 ec 08             	sub    $0x8,%esp
    338e:	68 fc 55 00 00       	push   $0x55fc
    3393:	6a 01                	push   $0x1
    3395:	e8 e3 14 00 00       	call   487d <printf>
      exit();
    339a:	e8 79 13 00 00       	call   4718 <exit>
    }
  }
  close(fd);
    339f:	83 ec 0c             	sub    $0xc,%esp
    33a2:	56                   	push   %esi
    33a3:	e8 98 13 00 00       	call   4740 <close>

  fd = open("bigfile", 0);
    33a8:	83 c4 08             	add    $0x8,%esp
    33ab:	6a 00                	push   $0x0
    33ad:	68 f4 55 00 00       	push   $0x55f4
    33b2:	e8 a1 13 00 00       	call   4758 <open>
    33b7:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    33b9:	83 c4 10             	add    $0x10,%esp
    33bc:	85 c0                	test   %eax,%eax
    33be:	78 53                	js     3413 <bigfile+0x117>
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
    33c0:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; ; i++){
    33c5:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(fd, buf, 300);
    33ca:	83 ec 04             	sub    $0x4,%esp
    33cd:	68 2c 01 00 00       	push   $0x12c
    33d2:	68 00 93 00 00       	push   $0x9300
    33d7:	57                   	push   %edi
    33d8:	e8 53 13 00 00       	call   4730 <read>
    if(cc < 0){
    33dd:	83 c4 10             	add    $0x10,%esp
    33e0:	85 c0                	test   %eax,%eax
    33e2:	78 43                	js     3427 <bigfile+0x12b>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    33e4:	74 7d                	je     3463 <bigfile+0x167>
      break;
    if(cc != 300){
    33e6:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    33eb:	75 4e                	jne    343b <bigfile+0x13f>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    33ed:	0f be 0d 00 93 00 00 	movsbl 0x9300,%ecx
    33f4:	89 da                	mov    %ebx,%edx
    33f6:	c1 ea 1f             	shr    $0x1f,%edx
    33f9:	01 da                	add    %ebx,%edx
    33fb:	d1 fa                	sar    %edx
    33fd:	39 d1                	cmp    %edx,%ecx
    33ff:	75 4e                	jne    344f <bigfile+0x153>
    3401:	0f be 0d 2b 94 00 00 	movsbl 0x942b,%ecx
    3408:	39 ca                	cmp    %ecx,%edx
    340a:	75 43                	jne    344f <bigfile+0x153>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    340c:	01 c6                	add    %eax,%esi
  for(i = 0; ; i++){
    340e:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    3411:	eb b7                	jmp    33ca <bigfile+0xce>
    printf(1, "cannot open bigfile\n");
    3413:	83 ec 08             	sub    $0x8,%esp
    3416:	68 12 56 00 00       	push   $0x5612
    341b:	6a 01                	push   $0x1
    341d:	e8 5b 14 00 00       	call   487d <printf>
    exit();
    3422:	e8 f1 12 00 00       	call   4718 <exit>
      printf(1, "read bigfile failed\n");
    3427:	83 ec 08             	sub    $0x8,%esp
    342a:	68 27 56 00 00       	push   $0x5627
    342f:	6a 01                	push   $0x1
    3431:	e8 47 14 00 00       	call   487d <printf>
      exit();
    3436:	e8 dd 12 00 00       	call   4718 <exit>
      printf(1, "short read bigfile\n");
    343b:	83 ec 08             	sub    $0x8,%esp
    343e:	68 3c 56 00 00       	push   $0x563c
    3443:	6a 01                	push   $0x1
    3445:	e8 33 14 00 00       	call   487d <printf>
      exit();
    344a:	e8 c9 12 00 00       	call   4718 <exit>
      printf(1, "read bigfile wrong data\n");
    344f:	83 ec 08             	sub    $0x8,%esp
    3452:	68 50 56 00 00       	push   $0x5650
    3457:	6a 01                	push   $0x1
    3459:	e8 1f 14 00 00       	call   487d <printf>
      exit();
    345e:	e8 b5 12 00 00       	call   4718 <exit>
  }
  close(fd);
    3463:	83 ec 0c             	sub    $0xc,%esp
    3466:	57                   	push   %edi
    3467:	e8 d4 12 00 00       	call   4740 <close>
  if(total != 20*600){
    346c:	83 c4 10             	add    $0x10,%esp
    346f:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    3475:	75 27                	jne    349e <bigfile+0x1a2>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    3477:	83 ec 0c             	sub    $0xc,%esp
    347a:	68 f4 55 00 00       	push   $0x55f4
    347f:	e8 e4 12 00 00       	call   4768 <unlink>

  printf(1, "bigfile test ok\n");
    3484:	83 c4 08             	add    $0x8,%esp
    3487:	68 83 56 00 00       	push   $0x5683
    348c:	6a 01                	push   $0x1
    348e:	e8 ea 13 00 00       	call   487d <printf>
}
    3493:	83 c4 10             	add    $0x10,%esp
    3496:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3499:	5b                   	pop    %ebx
    349a:	5e                   	pop    %esi
    349b:	5f                   	pop    %edi
    349c:	5d                   	pop    %ebp
    349d:	c3                   	ret    
    printf(1, "read bigfile wrong total\n");
    349e:	83 ec 08             	sub    $0x8,%esp
    34a1:	68 69 56 00 00       	push   $0x5669
    34a6:	6a 01                	push   $0x1
    34a8:	e8 d0 13 00 00       	call   487d <printf>
    exit();
    34ad:	e8 66 12 00 00       	call   4718 <exit>

000034b2 <fourteen>:

void
fourteen(void)
{
    34b2:	55                   	push   %ebp
    34b3:	89 e5                	mov    %esp,%ebp
    34b5:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    34b8:	68 94 56 00 00       	push   $0x5694
    34bd:	6a 01                	push   $0x1
    34bf:	e8 b9 13 00 00       	call   487d <printf>

  if(mkdir("12345678901234") != 0){
    34c4:	c7 04 24 cf 56 00 00 	movl   $0x56cf,(%esp)
    34cb:	e8 b0 12 00 00       	call   4780 <mkdir>
    34d0:	83 c4 10             	add    $0x10,%esp
    34d3:	85 c0                	test   %eax,%eax
    34d5:	0f 85 9c 00 00 00    	jne    3577 <fourteen+0xc5>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    34db:	83 ec 0c             	sub    $0xc,%esp
    34de:	68 8c 5e 00 00       	push   $0x5e8c
    34e3:	e8 98 12 00 00       	call   4780 <mkdir>
    34e8:	83 c4 10             	add    $0x10,%esp
    34eb:	85 c0                	test   %eax,%eax
    34ed:	0f 85 98 00 00 00    	jne    358b <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    34f3:	83 ec 08             	sub    $0x8,%esp
    34f6:	68 00 02 00 00       	push   $0x200
    34fb:	68 dc 5e 00 00       	push   $0x5edc
    3500:	e8 53 12 00 00       	call   4758 <open>
  if(fd < 0){
    3505:	83 c4 10             	add    $0x10,%esp
    3508:	85 c0                	test   %eax,%eax
    350a:	0f 88 8f 00 00 00    	js     359f <fourteen+0xed>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    3510:	83 ec 0c             	sub    $0xc,%esp
    3513:	50                   	push   %eax
    3514:	e8 27 12 00 00       	call   4740 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3519:	83 c4 08             	add    $0x8,%esp
    351c:	6a 00                	push   $0x0
    351e:	68 4c 5f 00 00       	push   $0x5f4c
    3523:	e8 30 12 00 00       	call   4758 <open>
  if(fd < 0){
    3528:	83 c4 10             	add    $0x10,%esp
    352b:	85 c0                	test   %eax,%eax
    352d:	0f 88 80 00 00 00    	js     35b3 <fourteen+0x101>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    3533:	83 ec 0c             	sub    $0xc,%esp
    3536:	50                   	push   %eax
    3537:	e8 04 12 00 00       	call   4740 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    353c:	c7 04 24 c0 56 00 00 	movl   $0x56c0,(%esp)
    3543:	e8 38 12 00 00       	call   4780 <mkdir>
    3548:	83 c4 10             	add    $0x10,%esp
    354b:	85 c0                	test   %eax,%eax
    354d:	74 78                	je     35c7 <fourteen+0x115>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    354f:	83 ec 0c             	sub    $0xc,%esp
    3552:	68 e8 5f 00 00       	push   $0x5fe8
    3557:	e8 24 12 00 00       	call   4780 <mkdir>
    355c:	83 c4 10             	add    $0x10,%esp
    355f:	85 c0                	test   %eax,%eax
    3561:	74 78                	je     35db <fourteen+0x129>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    3563:	83 ec 08             	sub    $0x8,%esp
    3566:	68 de 56 00 00       	push   $0x56de
    356b:	6a 01                	push   $0x1
    356d:	e8 0b 13 00 00       	call   487d <printf>
}
    3572:	83 c4 10             	add    $0x10,%esp
    3575:	c9                   	leave  
    3576:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    3577:	83 ec 08             	sub    $0x8,%esp
    357a:	68 a3 56 00 00       	push   $0x56a3
    357f:	6a 01                	push   $0x1
    3581:	e8 f7 12 00 00       	call   487d <printf>
    exit();
    3586:	e8 8d 11 00 00       	call   4718 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    358b:	83 ec 08             	sub    $0x8,%esp
    358e:	68 ac 5e 00 00       	push   $0x5eac
    3593:	6a 01                	push   $0x1
    3595:	e8 e3 12 00 00       	call   487d <printf>
    exit();
    359a:	e8 79 11 00 00       	call   4718 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    359f:	83 ec 08             	sub    $0x8,%esp
    35a2:	68 0c 5f 00 00       	push   $0x5f0c
    35a7:	6a 01                	push   $0x1
    35a9:	e8 cf 12 00 00       	call   487d <printf>
    exit();
    35ae:	e8 65 11 00 00       	call   4718 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    35b3:	83 ec 08             	sub    $0x8,%esp
    35b6:	68 7c 5f 00 00       	push   $0x5f7c
    35bb:	6a 01                	push   $0x1
    35bd:	e8 bb 12 00 00       	call   487d <printf>
    exit();
    35c2:	e8 51 11 00 00       	call   4718 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    35c7:	83 ec 08             	sub    $0x8,%esp
    35ca:	68 b8 5f 00 00       	push   $0x5fb8
    35cf:	6a 01                	push   $0x1
    35d1:	e8 a7 12 00 00       	call   487d <printf>
    exit();
    35d6:	e8 3d 11 00 00       	call   4718 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    35db:	83 ec 08             	sub    $0x8,%esp
    35de:	68 08 60 00 00       	push   $0x6008
    35e3:	6a 01                	push   $0x1
    35e5:	e8 93 12 00 00       	call   487d <printf>
    exit();
    35ea:	e8 29 11 00 00       	call   4718 <exit>

000035ef <rmdot>:

void
rmdot(void)
{
    35ef:	55                   	push   %ebp
    35f0:	89 e5                	mov    %esp,%ebp
    35f2:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    35f5:	68 eb 56 00 00       	push   $0x56eb
    35fa:	6a 01                	push   $0x1
    35fc:	e8 7c 12 00 00       	call   487d <printf>
  if(mkdir("dots") != 0){
    3601:	c7 04 24 f7 56 00 00 	movl   $0x56f7,(%esp)
    3608:	e8 73 11 00 00       	call   4780 <mkdir>
    360d:	83 c4 10             	add    $0x10,%esp
    3610:	85 c0                	test   %eax,%eax
    3612:	0f 85 bc 00 00 00    	jne    36d4 <rmdot+0xe5>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    3618:	83 ec 0c             	sub    $0xc,%esp
    361b:	68 f7 56 00 00       	push   $0x56f7
    3620:	e8 63 11 00 00       	call   4788 <chdir>
    3625:	83 c4 10             	add    $0x10,%esp
    3628:	85 c0                	test   %eax,%eax
    362a:	0f 85 b8 00 00 00    	jne    36e8 <rmdot+0xf9>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    3630:	83 ec 0c             	sub    $0xc,%esp
    3633:	68 a2 53 00 00       	push   $0x53a2
    3638:	e8 2b 11 00 00       	call   4768 <unlink>
    363d:	83 c4 10             	add    $0x10,%esp
    3640:	85 c0                	test   %eax,%eax
    3642:	0f 84 b4 00 00 00    	je     36fc <rmdot+0x10d>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    3648:	83 ec 0c             	sub    $0xc,%esp
    364b:	68 a1 53 00 00       	push   $0x53a1
    3650:	e8 13 11 00 00       	call   4768 <unlink>
    3655:	83 c4 10             	add    $0x10,%esp
    3658:	85 c0                	test   %eax,%eax
    365a:	0f 84 b0 00 00 00    	je     3710 <rmdot+0x121>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    3660:	83 ec 0c             	sub    $0xc,%esp
    3663:	68 75 4b 00 00       	push   $0x4b75
    3668:	e8 1b 11 00 00       	call   4788 <chdir>
    366d:	83 c4 10             	add    $0x10,%esp
    3670:	85 c0                	test   %eax,%eax
    3672:	0f 85 ac 00 00 00    	jne    3724 <rmdot+0x135>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    3678:	83 ec 0c             	sub    $0xc,%esp
    367b:	68 3f 57 00 00       	push   $0x573f
    3680:	e8 e3 10 00 00       	call   4768 <unlink>
    3685:	83 c4 10             	add    $0x10,%esp
    3688:	85 c0                	test   %eax,%eax
    368a:	0f 84 a8 00 00 00    	je     3738 <rmdot+0x149>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    3690:	83 ec 0c             	sub    $0xc,%esp
    3693:	68 5d 57 00 00       	push   $0x575d
    3698:	e8 cb 10 00 00       	call   4768 <unlink>
    369d:	83 c4 10             	add    $0x10,%esp
    36a0:	85 c0                	test   %eax,%eax
    36a2:	0f 84 a4 00 00 00    	je     374c <rmdot+0x15d>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    36a8:	83 ec 0c             	sub    $0xc,%esp
    36ab:	68 f7 56 00 00       	push   $0x56f7
    36b0:	e8 b3 10 00 00       	call   4768 <unlink>
    36b5:	83 c4 10             	add    $0x10,%esp
    36b8:	85 c0                	test   %eax,%eax
    36ba:	0f 85 a0 00 00 00    	jne    3760 <rmdot+0x171>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    36c0:	83 ec 08             	sub    $0x8,%esp
    36c3:	68 92 57 00 00       	push   $0x5792
    36c8:	6a 01                	push   $0x1
    36ca:	e8 ae 11 00 00       	call   487d <printf>
}
    36cf:	83 c4 10             	add    $0x10,%esp
    36d2:	c9                   	leave  
    36d3:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    36d4:	83 ec 08             	sub    $0x8,%esp
    36d7:	68 fc 56 00 00       	push   $0x56fc
    36dc:	6a 01                	push   $0x1
    36de:	e8 9a 11 00 00       	call   487d <printf>
    exit();
    36e3:	e8 30 10 00 00       	call   4718 <exit>
    printf(1, "chdir dots failed\n");
    36e8:	83 ec 08             	sub    $0x8,%esp
    36eb:	68 0f 57 00 00       	push   $0x570f
    36f0:	6a 01                	push   $0x1
    36f2:	e8 86 11 00 00       	call   487d <printf>
    exit();
    36f7:	e8 1c 10 00 00       	call   4718 <exit>
    printf(1, "rm . worked!\n");
    36fc:	83 ec 08             	sub    $0x8,%esp
    36ff:	68 22 57 00 00       	push   $0x5722
    3704:	6a 01                	push   $0x1
    3706:	e8 72 11 00 00       	call   487d <printf>
    exit();
    370b:	e8 08 10 00 00       	call   4718 <exit>
    printf(1, "rm .. worked!\n");
    3710:	83 ec 08             	sub    $0x8,%esp
    3713:	68 30 57 00 00       	push   $0x5730
    3718:	6a 01                	push   $0x1
    371a:	e8 5e 11 00 00       	call   487d <printf>
    exit();
    371f:	e8 f4 0f 00 00       	call   4718 <exit>
    printf(1, "chdir / failed\n");
    3724:	83 ec 08             	sub    $0x8,%esp
    3727:	68 77 4b 00 00       	push   $0x4b77
    372c:	6a 01                	push   $0x1
    372e:	e8 4a 11 00 00       	call   487d <printf>
    exit();
    3733:	e8 e0 0f 00 00       	call   4718 <exit>
    printf(1, "unlink dots/. worked!\n");
    3738:	83 ec 08             	sub    $0x8,%esp
    373b:	68 46 57 00 00       	push   $0x5746
    3740:	6a 01                	push   $0x1
    3742:	e8 36 11 00 00       	call   487d <printf>
    exit();
    3747:	e8 cc 0f 00 00       	call   4718 <exit>
    printf(1, "unlink dots/.. worked!\n");
    374c:	83 ec 08             	sub    $0x8,%esp
    374f:	68 65 57 00 00       	push   $0x5765
    3754:	6a 01                	push   $0x1
    3756:	e8 22 11 00 00       	call   487d <printf>
    exit();
    375b:	e8 b8 0f 00 00       	call   4718 <exit>
    printf(1, "unlink dots failed!\n");
    3760:	83 ec 08             	sub    $0x8,%esp
    3763:	68 7d 57 00 00       	push   $0x577d
    3768:	6a 01                	push   $0x1
    376a:	e8 0e 11 00 00       	call   487d <printf>
    exit();
    376f:	e8 a4 0f 00 00       	call   4718 <exit>

00003774 <dirfile>:

void
dirfile(void)
{
    3774:	55                   	push   %ebp
    3775:	89 e5                	mov    %esp,%ebp
    3777:	53                   	push   %ebx
    3778:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    377b:	68 9c 57 00 00       	push   $0x579c
    3780:	6a 01                	push   $0x1
    3782:	e8 f6 10 00 00       	call   487d <printf>

  fd = open("dirfile", O_CREATE);
    3787:	83 c4 08             	add    $0x8,%esp
    378a:	68 00 02 00 00       	push   $0x200
    378f:	68 a9 57 00 00       	push   $0x57a9
    3794:	e8 bf 0f 00 00       	call   4758 <open>
  if(fd < 0){
    3799:	83 c4 10             	add    $0x10,%esp
    379c:	85 c0                	test   %eax,%eax
    379e:	0f 88 22 01 00 00    	js     38c6 <dirfile+0x152>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    37a4:	83 ec 0c             	sub    $0xc,%esp
    37a7:	50                   	push   %eax
    37a8:	e8 93 0f 00 00       	call   4740 <close>
  if(chdir("dirfile") == 0){
    37ad:	c7 04 24 a9 57 00 00 	movl   $0x57a9,(%esp)
    37b4:	e8 cf 0f 00 00       	call   4788 <chdir>
    37b9:	83 c4 10             	add    $0x10,%esp
    37bc:	85 c0                	test   %eax,%eax
    37be:	0f 84 16 01 00 00    	je     38da <dirfile+0x166>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    37c4:	83 ec 08             	sub    $0x8,%esp
    37c7:	6a 00                	push   $0x0
    37c9:	68 e2 57 00 00       	push   $0x57e2
    37ce:	e8 85 0f 00 00       	call   4758 <open>
  if(fd >= 0){
    37d3:	83 c4 10             	add    $0x10,%esp
    37d6:	85 c0                	test   %eax,%eax
    37d8:	0f 89 10 01 00 00    	jns    38ee <dirfile+0x17a>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    37de:	83 ec 08             	sub    $0x8,%esp
    37e1:	68 00 02 00 00       	push   $0x200
    37e6:	68 e2 57 00 00       	push   $0x57e2
    37eb:	e8 68 0f 00 00       	call   4758 <open>
  if(fd >= 0){
    37f0:	83 c4 10             	add    $0x10,%esp
    37f3:	85 c0                	test   %eax,%eax
    37f5:	0f 89 07 01 00 00    	jns    3902 <dirfile+0x18e>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    37fb:	83 ec 0c             	sub    $0xc,%esp
    37fe:	68 e2 57 00 00       	push   $0x57e2
    3803:	e8 78 0f 00 00       	call   4780 <mkdir>
    3808:	83 c4 10             	add    $0x10,%esp
    380b:	85 c0                	test   %eax,%eax
    380d:	0f 84 03 01 00 00    	je     3916 <dirfile+0x1a2>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    3813:	83 ec 0c             	sub    $0xc,%esp
    3816:	68 e2 57 00 00       	push   $0x57e2
    381b:	e8 48 0f 00 00       	call   4768 <unlink>
    3820:	83 c4 10             	add    $0x10,%esp
    3823:	85 c0                	test   %eax,%eax
    3825:	0f 84 ff 00 00 00    	je     392a <dirfile+0x1b6>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    382b:	83 ec 08             	sub    $0x8,%esp
    382e:	68 e2 57 00 00       	push   $0x57e2
    3833:	68 46 58 00 00       	push   $0x5846
    3838:	e8 3b 0f 00 00       	call   4778 <link>
    383d:	83 c4 10             	add    $0x10,%esp
    3840:	85 c0                	test   %eax,%eax
    3842:	0f 84 f6 00 00 00    	je     393e <dirfile+0x1ca>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    3848:	83 ec 0c             	sub    $0xc,%esp
    384b:	68 a9 57 00 00       	push   $0x57a9
    3850:	e8 13 0f 00 00       	call   4768 <unlink>
    3855:	83 c4 10             	add    $0x10,%esp
    3858:	85 c0                	test   %eax,%eax
    385a:	0f 85 f2 00 00 00    	jne    3952 <dirfile+0x1de>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    3860:	83 ec 08             	sub    $0x8,%esp
    3863:	6a 02                	push   $0x2
    3865:	68 a2 53 00 00       	push   $0x53a2
    386a:	e8 e9 0e 00 00       	call   4758 <open>
  if(fd >= 0){
    386f:	83 c4 10             	add    $0x10,%esp
    3872:	85 c0                	test   %eax,%eax
    3874:	0f 89 ec 00 00 00    	jns    3966 <dirfile+0x1f2>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    387a:	83 ec 08             	sub    $0x8,%esp
    387d:	6a 00                	push   $0x0
    387f:	68 a2 53 00 00       	push   $0x53a2
    3884:	e8 cf 0e 00 00       	call   4758 <open>
    3889:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    388b:	83 c4 0c             	add    $0xc,%esp
    388e:	6a 01                	push   $0x1
    3890:	68 85 54 00 00       	push   $0x5485
    3895:	50                   	push   %eax
    3896:	e8 9d 0e 00 00       	call   4738 <write>
    389b:	83 c4 10             	add    $0x10,%esp
    389e:	85 c0                	test   %eax,%eax
    38a0:	0f 8f d4 00 00 00    	jg     397a <dirfile+0x206>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    38a6:	83 ec 0c             	sub    $0xc,%esp
    38a9:	53                   	push   %ebx
    38aa:	e8 91 0e 00 00       	call   4740 <close>

  printf(1, "dir vs file OK\n");
    38af:	83 c4 08             	add    $0x8,%esp
    38b2:	68 79 58 00 00       	push   $0x5879
    38b7:	6a 01                	push   $0x1
    38b9:	e8 bf 0f 00 00       	call   487d <printf>
}
    38be:	83 c4 10             	add    $0x10,%esp
    38c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    38c4:	c9                   	leave  
    38c5:	c3                   	ret    
    printf(1, "create dirfile failed\n");
    38c6:	83 ec 08             	sub    $0x8,%esp
    38c9:	68 b1 57 00 00       	push   $0x57b1
    38ce:	6a 01                	push   $0x1
    38d0:	e8 a8 0f 00 00       	call   487d <printf>
    exit();
    38d5:	e8 3e 0e 00 00       	call   4718 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    38da:	83 ec 08             	sub    $0x8,%esp
    38dd:	68 c8 57 00 00       	push   $0x57c8
    38e2:	6a 01                	push   $0x1
    38e4:	e8 94 0f 00 00       	call   487d <printf>
    exit();
    38e9:	e8 2a 0e 00 00       	call   4718 <exit>
    printf(1, "create dirfile/xx succeeded!\n");
    38ee:	83 ec 08             	sub    $0x8,%esp
    38f1:	68 ed 57 00 00       	push   $0x57ed
    38f6:	6a 01                	push   $0x1
    38f8:	e8 80 0f 00 00       	call   487d <printf>
    exit();
    38fd:	e8 16 0e 00 00       	call   4718 <exit>
    printf(1, "create dirfile/xx succeeded!\n");
    3902:	83 ec 08             	sub    $0x8,%esp
    3905:	68 ed 57 00 00       	push   $0x57ed
    390a:	6a 01                	push   $0x1
    390c:	e8 6c 0f 00 00       	call   487d <printf>
    exit();
    3911:	e8 02 0e 00 00       	call   4718 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    3916:	83 ec 08             	sub    $0x8,%esp
    3919:	68 0b 58 00 00       	push   $0x580b
    391e:	6a 01                	push   $0x1
    3920:	e8 58 0f 00 00       	call   487d <printf>
    exit();
    3925:	e8 ee 0d 00 00       	call   4718 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    392a:	83 ec 08             	sub    $0x8,%esp
    392d:	68 28 58 00 00       	push   $0x5828
    3932:	6a 01                	push   $0x1
    3934:	e8 44 0f 00 00       	call   487d <printf>
    exit();
    3939:	e8 da 0d 00 00       	call   4718 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    393e:	83 ec 08             	sub    $0x8,%esp
    3941:	68 3c 60 00 00       	push   $0x603c
    3946:	6a 01                	push   $0x1
    3948:	e8 30 0f 00 00       	call   487d <printf>
    exit();
    394d:	e8 c6 0d 00 00       	call   4718 <exit>
    printf(1, "unlink dirfile failed!\n");
    3952:	83 ec 08             	sub    $0x8,%esp
    3955:	68 4d 58 00 00       	push   $0x584d
    395a:	6a 01                	push   $0x1
    395c:	e8 1c 0f 00 00       	call   487d <printf>
    exit();
    3961:	e8 b2 0d 00 00       	call   4718 <exit>
    printf(1, "open . for writing succeeded!\n");
    3966:	83 ec 08             	sub    $0x8,%esp
    3969:	68 5c 60 00 00       	push   $0x605c
    396e:	6a 01                	push   $0x1
    3970:	e8 08 0f 00 00       	call   487d <printf>
    exit();
    3975:	e8 9e 0d 00 00       	call   4718 <exit>
    printf(1, "write . succeeded!\n");
    397a:	83 ec 08             	sub    $0x8,%esp
    397d:	68 65 58 00 00       	push   $0x5865
    3982:	6a 01                	push   $0x1
    3984:	e8 f4 0e 00 00       	call   487d <printf>
    exit();
    3989:	e8 8a 0d 00 00       	call   4718 <exit>

0000398e <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    398e:	55                   	push   %ebp
    398f:	89 e5                	mov    %esp,%ebp
    3991:	53                   	push   %ebx
    3992:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    3995:	68 89 58 00 00       	push   $0x5889
    399a:	6a 01                	push   $0x1
    399c:	e8 dc 0e 00 00       	call   487d <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    39a1:	83 c4 10             	add    $0x10,%esp
    39a4:	bb 00 00 00 00       	mov    $0x0,%ebx
    39a9:	eb 4c                	jmp    39f7 <iref+0x69>
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    39ab:	83 ec 08             	sub    $0x8,%esp
    39ae:	68 a0 58 00 00       	push   $0x58a0
    39b3:	6a 01                	push   $0x1
    39b5:	e8 c3 0e 00 00       	call   487d <printf>
      exit();
    39ba:	e8 59 0d 00 00       	call   4718 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    39bf:	83 ec 08             	sub    $0x8,%esp
    39c2:	68 b4 58 00 00       	push   $0x58b4
    39c7:	6a 01                	push   $0x1
    39c9:	e8 af 0e 00 00       	call   487d <printf>
      exit();
    39ce:	e8 45 0d 00 00       	call   4718 <exit>

    mkdir("");
    link("README", "");
    fd = open("", O_CREATE);
    if(fd >= 0)
      close(fd);
    39d3:	83 ec 0c             	sub    $0xc,%esp
    39d6:	50                   	push   %eax
    39d7:	e8 64 0d 00 00       	call   4740 <close>
    39dc:	83 c4 10             	add    $0x10,%esp
    39df:	e9 80 00 00 00       	jmp    3a64 <iref+0xd6>
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
    39e4:	83 ec 0c             	sub    $0xc,%esp
    39e7:	68 84 54 00 00       	push   $0x5484
    39ec:	e8 77 0d 00 00       	call   4768 <unlink>
  for(i = 0; i < 50 + 1; i++){
    39f1:	83 c3 01             	add    $0x1,%ebx
    39f4:	83 c4 10             	add    $0x10,%esp
    39f7:	83 fb 32             	cmp    $0x32,%ebx
    39fa:	0f 8f 92 00 00 00    	jg     3a92 <iref+0x104>
    if(mkdir("irefd") != 0){
    3a00:	83 ec 0c             	sub    $0xc,%esp
    3a03:	68 9a 58 00 00       	push   $0x589a
    3a08:	e8 73 0d 00 00       	call   4780 <mkdir>
    3a0d:	83 c4 10             	add    $0x10,%esp
    3a10:	85 c0                	test   %eax,%eax
    3a12:	75 97                	jne    39ab <iref+0x1d>
    if(chdir("irefd") != 0){
    3a14:	83 ec 0c             	sub    $0xc,%esp
    3a17:	68 9a 58 00 00       	push   $0x589a
    3a1c:	e8 67 0d 00 00       	call   4788 <chdir>
    3a21:	83 c4 10             	add    $0x10,%esp
    3a24:	85 c0                	test   %eax,%eax
    3a26:	75 97                	jne    39bf <iref+0x31>
    mkdir("");
    3a28:	83 ec 0c             	sub    $0xc,%esp
    3a2b:	68 4f 4f 00 00       	push   $0x4f4f
    3a30:	e8 4b 0d 00 00       	call   4780 <mkdir>
    link("README", "");
    3a35:	83 c4 08             	add    $0x8,%esp
    3a38:	68 4f 4f 00 00       	push   $0x4f4f
    3a3d:	68 46 58 00 00       	push   $0x5846
    3a42:	e8 31 0d 00 00       	call   4778 <link>
    fd = open("", O_CREATE);
    3a47:	83 c4 08             	add    $0x8,%esp
    3a4a:	68 00 02 00 00       	push   $0x200
    3a4f:	68 4f 4f 00 00       	push   $0x4f4f
    3a54:	e8 ff 0c 00 00       	call   4758 <open>
    if(fd >= 0)
    3a59:	83 c4 10             	add    $0x10,%esp
    3a5c:	85 c0                	test   %eax,%eax
    3a5e:	0f 89 6f ff ff ff    	jns    39d3 <iref+0x45>
    fd = open("xx", O_CREATE);
    3a64:	83 ec 08             	sub    $0x8,%esp
    3a67:	68 00 02 00 00       	push   $0x200
    3a6c:	68 84 54 00 00       	push   $0x5484
    3a71:	e8 e2 0c 00 00       	call   4758 <open>
    if(fd >= 0)
    3a76:	83 c4 10             	add    $0x10,%esp
    3a79:	85 c0                	test   %eax,%eax
    3a7b:	0f 88 63 ff ff ff    	js     39e4 <iref+0x56>
      close(fd);
    3a81:	83 ec 0c             	sub    $0xc,%esp
    3a84:	50                   	push   %eax
    3a85:	e8 b6 0c 00 00       	call   4740 <close>
    3a8a:	83 c4 10             	add    $0x10,%esp
    3a8d:	e9 52 ff ff ff       	jmp    39e4 <iref+0x56>
  }

  chdir("/");
    3a92:	83 ec 0c             	sub    $0xc,%esp
    3a95:	68 75 4b 00 00       	push   $0x4b75
    3a9a:	e8 e9 0c 00 00       	call   4788 <chdir>
  printf(1, "empty file name OK\n");
    3a9f:	83 c4 08             	add    $0x8,%esp
    3aa2:	68 c8 58 00 00       	push   $0x58c8
    3aa7:	6a 01                	push   $0x1
    3aa9:	e8 cf 0d 00 00       	call   487d <printf>
}
    3aae:	83 c4 10             	add    $0x10,%esp
    3ab1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3ab4:	c9                   	leave  
    3ab5:	c3                   	ret    

00003ab6 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    3ab6:	55                   	push   %ebp
    3ab7:	89 e5                	mov    %esp,%ebp
    3ab9:	53                   	push   %ebx
    3aba:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    3abd:	68 dc 58 00 00       	push   $0x58dc
    3ac2:	6a 01                	push   $0x1
    3ac4:	e8 b4 0d 00 00       	call   487d <printf>

  for(n=0; n<1000; n++){
    3ac9:	83 c4 10             	add    $0x10,%esp
    3acc:	bb 00 00 00 00       	mov    $0x0,%ebx
    3ad1:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
    3ad7:	7f 15                	jg     3aee <forktest+0x38>
    pid = fork();
    3ad9:	e8 32 0c 00 00       	call   4710 <fork>
    if(pid < 0)
    3ade:	85 c0                	test   %eax,%eax
    3ae0:	78 0c                	js     3aee <forktest+0x38>
      break;
    if(pid == 0)
    3ae2:	74 05                	je     3ae9 <forktest+0x33>
  for(n=0; n<1000; n++){
    3ae4:	83 c3 01             	add    $0x1,%ebx
    3ae7:	eb e8                	jmp    3ad1 <forktest+0x1b>
      exit();
    3ae9:	e8 2a 0c 00 00       	call   4718 <exit>
  }

  if(n == 1000){
    3aee:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    3af4:	74 12                	je     3b08 <forktest+0x52>
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    3af6:	85 db                	test   %ebx,%ebx
    3af8:	7e 36                	jle    3b30 <forktest+0x7a>
    if(wait() < 0){
    3afa:	e8 21 0c 00 00       	call   4720 <wait>
    3aff:	85 c0                	test   %eax,%eax
    3b01:	78 19                	js     3b1c <forktest+0x66>
  for(; n > 0; n--){
    3b03:	83 eb 01             	sub    $0x1,%ebx
    3b06:	eb ee                	jmp    3af6 <forktest+0x40>
    printf(1, "fork claimed to work 1000 times!\n");
    3b08:	83 ec 08             	sub    $0x8,%esp
    3b0b:	68 7c 60 00 00       	push   $0x607c
    3b10:	6a 01                	push   $0x1
    3b12:	e8 66 0d 00 00       	call   487d <printf>
    exit();
    3b17:	e8 fc 0b 00 00       	call   4718 <exit>
      printf(1, "wait stopped early\n");
    3b1c:	83 ec 08             	sub    $0x8,%esp
    3b1f:	68 e7 58 00 00       	push   $0x58e7
    3b24:	6a 01                	push   $0x1
    3b26:	e8 52 0d 00 00       	call   487d <printf>
      exit();
    3b2b:	e8 e8 0b 00 00       	call   4718 <exit>
    }
  }

  if(wait() != -1){
    3b30:	e8 eb 0b 00 00       	call   4720 <wait>
    3b35:	83 f8 ff             	cmp    $0xffffffff,%eax
    3b38:	75 17                	jne    3b51 <forktest+0x9b>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    3b3a:	83 ec 08             	sub    $0x8,%esp
    3b3d:	68 0e 59 00 00       	push   $0x590e
    3b42:	6a 01                	push   $0x1
    3b44:	e8 34 0d 00 00       	call   487d <printf>
}
    3b49:	83 c4 10             	add    $0x10,%esp
    3b4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b4f:	c9                   	leave  
    3b50:	c3                   	ret    
    printf(1, "wait got too many\n");
    3b51:	83 ec 08             	sub    $0x8,%esp
    3b54:	68 fb 58 00 00       	push   $0x58fb
    3b59:	6a 01                	push   $0x1
    3b5b:	e8 1d 0d 00 00       	call   487d <printf>
    exit();
    3b60:	e8 b3 0b 00 00       	call   4718 <exit>

00003b65 <sbrktest>:

void
sbrktest(void)
{
    3b65:	55                   	push   %ebp
    3b66:	89 e5                	mov    %esp,%ebp
    3b68:	57                   	push   %edi
    3b69:	56                   	push   %esi
    3b6a:	53                   	push   %ebx
    3b6b:	83 ec 54             	sub    $0x54,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    3b6e:	68 1c 59 00 00       	push   $0x591c
    3b73:	ff 35 b4 6b 00 00    	push   0x6bb4
    3b79:	e8 ff 0c 00 00       	call   487d <printf>
  oldbrk = sbrk(0);
    3b7e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b85:	e8 16 0c 00 00       	call   47a0 <sbrk>
    3b8a:	89 c7                	mov    %eax,%edi

  // can one sbrk() less than a page?
  a = sbrk(0);
    3b8c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b93:	e8 08 0c 00 00       	call   47a0 <sbrk>
    3b98:	89 c6                	mov    %eax,%esi
  int i;
  for(i = 0; i < 5000; i++){
    3b9a:	83 c4 10             	add    $0x10,%esp
    3b9d:	bb 00 00 00 00       	mov    $0x0,%ebx
    3ba2:	81 fb 87 13 00 00    	cmp    $0x1387,%ebx
    3ba8:	7f 3a                	jg     3be4 <sbrktest+0x7f>
    b = sbrk(1);
    3baa:	83 ec 0c             	sub    $0xc,%esp
    3bad:	6a 01                	push   $0x1
    3baf:	e8 ec 0b 00 00       	call   47a0 <sbrk>
    if(b != a){
    3bb4:	83 c4 10             	add    $0x10,%esp
    3bb7:	39 c6                	cmp    %eax,%esi
    3bb9:	75 0b                	jne    3bc6 <sbrktest+0x61>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    3bbb:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    3bbe:	8d 70 01             	lea    0x1(%eax),%esi
  for(i = 0; i < 5000; i++){
    3bc1:	83 c3 01             	add    $0x1,%ebx
    3bc4:	eb dc                	jmp    3ba2 <sbrktest+0x3d>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3bc6:	83 ec 0c             	sub    $0xc,%esp
    3bc9:	50                   	push   %eax
    3bca:	56                   	push   %esi
    3bcb:	53                   	push   %ebx
    3bcc:	68 27 59 00 00       	push   $0x5927
    3bd1:	ff 35 b4 6b 00 00    	push   0x6bb4
    3bd7:	e8 a1 0c 00 00       	call   487d <printf>
      exit();
    3bdc:	83 c4 20             	add    $0x20,%esp
    3bdf:	e8 34 0b 00 00       	call   4718 <exit>
  }
  pid = fork();
    3be4:	e8 27 0b 00 00       	call   4710 <fork>
    3be9:	89 c3                	mov    %eax,%ebx
  if(pid < 0){
    3beb:	85 c0                	test   %eax,%eax
    3bed:	0f 88 4c 01 00 00    	js     3d3f <sbrktest+0x1da>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    3bf3:	83 ec 0c             	sub    $0xc,%esp
    3bf6:	6a 01                	push   $0x1
    3bf8:	e8 a3 0b 00 00       	call   47a0 <sbrk>
  c = sbrk(1);
    3bfd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c04:	e8 97 0b 00 00       	call   47a0 <sbrk>
  if(c != a + 1){
    3c09:	83 c6 01             	add    $0x1,%esi
    3c0c:	83 c4 10             	add    $0x10,%esp
    3c0f:	39 c6                	cmp    %eax,%esi
    3c11:	0f 85 40 01 00 00    	jne    3d57 <sbrktest+0x1f2>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    3c17:	85 db                	test   %ebx,%ebx
    3c19:	0f 84 50 01 00 00    	je     3d6f <sbrktest+0x20a>
    exit();
  wait();
    3c1f:	e8 fc 0a 00 00       	call   4720 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3c24:	83 ec 0c             	sub    $0xc,%esp
    3c27:	6a 00                	push   $0x0
    3c29:	e8 72 0b 00 00       	call   47a0 <sbrk>
    3c2e:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    3c30:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3c35:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    3c37:	89 04 24             	mov    %eax,(%esp)
    3c3a:	e8 61 0b 00 00       	call   47a0 <sbrk>
  if (p != a) {
    3c3f:	83 c4 10             	add    $0x10,%esp
    3c42:	39 c3                	cmp    %eax,%ebx
    3c44:	0f 85 2a 01 00 00    	jne    3d74 <sbrktest+0x20f>
  }
  lastaddr = (char*) (BIG-1);
  //*lastaddr = 99; // Remzi: Why doesn't this work anymore?

  // can one de-allocate?
  a = sbrk(0);
    3c4a:	83 ec 0c             	sub    $0xc,%esp
    3c4d:	6a 00                	push   $0x0
    3c4f:	e8 4c 0b 00 00       	call   47a0 <sbrk>
    3c54:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    3c56:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    3c5d:	e8 3e 0b 00 00       	call   47a0 <sbrk>
  if(c == (char*)0xffffffff){
    3c62:	83 c4 10             	add    $0x10,%esp
    3c65:	83 f8 ff             	cmp    $0xffffffff,%eax
    3c68:	0f 84 1e 01 00 00    	je     3d8c <sbrktest+0x227>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    3c6e:	83 ec 0c             	sub    $0xc,%esp
    3c71:	6a 00                	push   $0x0
    3c73:	e8 28 0b 00 00       	call   47a0 <sbrk>
  if(c != a - 4096){
    3c78:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    3c7e:	83 c4 10             	add    $0x10,%esp
    3c81:	39 c2                	cmp    %eax,%edx
    3c83:	0f 85 1b 01 00 00    	jne    3da4 <sbrktest+0x23f>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3c89:	83 ec 0c             	sub    $0xc,%esp
    3c8c:	6a 00                	push   $0x0
    3c8e:	e8 0d 0b 00 00       	call   47a0 <sbrk>
    3c93:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    3c95:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    3c9c:	e8 ff 0a 00 00       	call   47a0 <sbrk>
    3ca1:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    3ca3:	83 c4 10             	add    $0x10,%esp
    3ca6:	39 c3                	cmp    %eax,%ebx
    3ca8:	0f 85 0d 01 00 00    	jne    3dbb <sbrktest+0x256>
    3cae:	83 ec 0c             	sub    $0xc,%esp
    3cb1:	6a 00                	push   $0x0
    3cb3:	e8 e8 0a 00 00       	call   47a0 <sbrk>
    3cb8:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    3cbe:	83 c4 10             	add    $0x10,%esp
    3cc1:	39 c2                	cmp    %eax,%edx
    3cc3:	0f 85 f2 00 00 00    	jne    3dbb <sbrktest+0x256>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    3cc9:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    3cd0:	0f 84 fc 00 00 00    	je     3dd2 <sbrktest+0x26d>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    3cd6:	83 ec 0c             	sub    $0xc,%esp
    3cd9:	6a 00                	push   $0x0
    3cdb:	e8 c0 0a 00 00       	call   47a0 <sbrk>
    3ce0:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    3ce2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3ce9:	e8 b2 0a 00 00       	call   47a0 <sbrk>
    3cee:	89 c2                	mov    %eax,%edx
    3cf0:	89 f8                	mov    %edi,%eax
    3cf2:	29 d0                	sub    %edx,%eax
    3cf4:	89 04 24             	mov    %eax,(%esp)
    3cf7:	e8 a4 0a 00 00       	call   47a0 <sbrk>
  if(c != a){
    3cfc:	83 c4 10             	add    $0x10,%esp
    3cff:	39 c3                	cmp    %eax,%ebx
    3d01:	0f 85 e3 00 00 00    	jne    3dea <sbrktest+0x285>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3d07:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    3d0c:	81 fb 7f 84 1e 80    	cmp    $0x801e847f,%ebx
    3d12:	0f 87 23 01 00 00    	ja     3e3b <sbrktest+0x2d6>
    ppid = getpid();
    3d18:	e8 7b 0a 00 00       	call   4798 <getpid>
    3d1d:	89 c6                	mov    %eax,%esi
    pid = fork();
    3d1f:	e8 ec 09 00 00       	call   4710 <fork>
    if(pid < 0){
    3d24:	85 c0                	test   %eax,%eax
    3d26:	0f 88 d5 00 00 00    	js     3e01 <sbrktest+0x29c>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    3d2c:	0f 84 e7 00 00 00    	je     3e19 <sbrktest+0x2b4>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    3d32:	e8 e9 09 00 00       	call   4720 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3d37:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    3d3d:	eb cd                	jmp    3d0c <sbrktest+0x1a7>
    printf(stdout, "sbrk test fork failed\n");
    3d3f:	83 ec 08             	sub    $0x8,%esp
    3d42:	68 42 59 00 00       	push   $0x5942
    3d47:	ff 35 b4 6b 00 00    	push   0x6bb4
    3d4d:	e8 2b 0b 00 00       	call   487d <printf>
    exit();
    3d52:	e8 c1 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3d57:	83 ec 08             	sub    $0x8,%esp
    3d5a:	68 59 59 00 00       	push   $0x5959
    3d5f:	ff 35 b4 6b 00 00    	push   0x6bb4
    3d65:	e8 13 0b 00 00       	call   487d <printf>
    exit();
    3d6a:	e8 a9 09 00 00       	call   4718 <exit>
    exit();
    3d6f:	e8 a4 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3d74:	83 ec 08             	sub    $0x8,%esp
    3d77:	68 a0 60 00 00       	push   $0x60a0
    3d7c:	ff 35 b4 6b 00 00    	push   0x6bb4
    3d82:	e8 f6 0a 00 00       	call   487d <printf>
    exit();
    3d87:	e8 8c 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    3d8c:	83 ec 08             	sub    $0x8,%esp
    3d8f:	68 75 59 00 00       	push   $0x5975
    3d94:	ff 35 b4 6b 00 00    	push   0x6bb4
    3d9a:	e8 de 0a 00 00       	call   487d <printf>
    exit();
    3d9f:	e8 74 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3da4:	50                   	push   %eax
    3da5:	53                   	push   %ebx
    3da6:	68 e0 60 00 00       	push   $0x60e0
    3dab:	ff 35 b4 6b 00 00    	push   0x6bb4
    3db1:	e8 c7 0a 00 00       	call   487d <printf>
    exit();
    3db6:	e8 5d 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3dbb:	56                   	push   %esi
    3dbc:	53                   	push   %ebx
    3dbd:	68 18 61 00 00       	push   $0x6118
    3dc2:	ff 35 b4 6b 00 00    	push   0x6bb4
    3dc8:	e8 b0 0a 00 00       	call   487d <printf>
    exit();
    3dcd:	e8 46 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3dd2:	83 ec 08             	sub    $0x8,%esp
    3dd5:	68 40 61 00 00       	push   $0x6140
    3dda:	ff 35 b4 6b 00 00    	push   0x6bb4
    3de0:	e8 98 0a 00 00       	call   487d <printf>
    exit();
    3de5:	e8 2e 09 00 00       	call   4718 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3dea:	50                   	push   %eax
    3deb:	53                   	push   %ebx
    3dec:	68 70 61 00 00       	push   $0x6170
    3df1:	ff 35 b4 6b 00 00    	push   0x6bb4
    3df7:	e8 81 0a 00 00       	call   487d <printf>
    exit();
    3dfc:	e8 17 09 00 00       	call   4718 <exit>
      printf(stdout, "fork failed\n");
    3e01:	83 ec 08             	sub    $0x8,%esp
    3e04:	68 6d 5a 00 00       	push   $0x5a6d
    3e09:	ff 35 b4 6b 00 00    	push   0x6bb4
    3e0f:	e8 69 0a 00 00       	call   487d <printf>
      exit();
    3e14:	e8 ff 08 00 00       	call   4718 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3e19:	0f be 03             	movsbl (%ebx),%eax
    3e1c:	50                   	push   %eax
    3e1d:	53                   	push   %ebx
    3e1e:	68 90 59 00 00       	push   $0x5990
    3e23:	ff 35 b4 6b 00 00    	push   0x6bb4
    3e29:	e8 4f 0a 00 00       	call   487d <printf>
      kill(ppid);
    3e2e:	89 34 24             	mov    %esi,(%esp)
    3e31:	e8 12 09 00 00       	call   4748 <kill>
      exit();
    3e36:	e8 dd 08 00 00       	call   4718 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    3e3b:	83 ec 0c             	sub    $0xc,%esp
    3e3e:	8d 45 e0             	lea    -0x20(%ebp),%eax
    3e41:	50                   	push   %eax
    3e42:	e8 e1 08 00 00       	call   4728 <pipe>
    3e47:	89 c3                	mov    %eax,%ebx
    3e49:	83 c4 10             	add    $0x10,%esp
    3e4c:	85 c0                	test   %eax,%eax
    3e4e:	75 04                	jne    3e54 <sbrktest+0x2ef>
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3e50:	89 c6                	mov    %eax,%esi
    3e52:	eb 59                	jmp    3ead <sbrktest+0x348>
    printf(1, "pipe() failed\n");
    3e54:	83 ec 08             	sub    $0x8,%esp
    3e57:	68 65 4e 00 00       	push   $0x4e65
    3e5c:	6a 01                	push   $0x1
    3e5e:	e8 1a 0a 00 00       	call   487d <printf>
    exit();
    3e63:	e8 b0 08 00 00       	call   4718 <exit>
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3e68:	83 ec 0c             	sub    $0xc,%esp
    3e6b:	6a 00                	push   $0x0
    3e6d:	e8 2e 09 00 00       	call   47a0 <sbrk>
    3e72:	89 c2                	mov    %eax,%edx
    3e74:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3e79:	29 d0                	sub    %edx,%eax
    3e7b:	89 04 24             	mov    %eax,(%esp)
    3e7e:	e8 1d 09 00 00       	call   47a0 <sbrk>
      write(fds[1], "x", 1);
    3e83:	83 c4 0c             	add    $0xc,%esp
    3e86:	6a 01                	push   $0x1
    3e88:	68 85 54 00 00       	push   $0x5485
    3e8d:	ff 75 e4             	push   -0x1c(%ebp)
    3e90:	e8 a3 08 00 00       	call   4738 <write>
    3e95:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3e98:	83 ec 0c             	sub    $0xc,%esp
    3e9b:	68 e8 03 00 00       	push   $0x3e8
    3ea0:	e8 03 09 00 00       	call   47a8 <sleep>
    3ea5:	83 c4 10             	add    $0x10,%esp
    3ea8:	eb ee                	jmp    3e98 <sbrktest+0x333>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3eaa:	83 c6 01             	add    $0x1,%esi
    3ead:	83 fe 09             	cmp    $0x9,%esi
    3eb0:	77 28                	ja     3eda <sbrktest+0x375>
    if((pids[i] = fork()) == 0){
    3eb2:	e8 59 08 00 00       	call   4710 <fork>
    3eb7:	89 44 b5 b8          	mov    %eax,-0x48(%ebp,%esi,4)
    3ebb:	85 c0                	test   %eax,%eax
    3ebd:	74 a9                	je     3e68 <sbrktest+0x303>
    }
    if(pids[i] != -1)
    3ebf:	83 f8 ff             	cmp    $0xffffffff,%eax
    3ec2:	74 e6                	je     3eaa <sbrktest+0x345>
      read(fds[0], &scratch, 1);
    3ec4:	83 ec 04             	sub    $0x4,%esp
    3ec7:	6a 01                	push   $0x1
    3ec9:	8d 45 b7             	lea    -0x49(%ebp),%eax
    3ecc:	50                   	push   %eax
    3ecd:	ff 75 e0             	push   -0x20(%ebp)
    3ed0:	e8 5b 08 00 00       	call   4730 <read>
    3ed5:	83 c4 10             	add    $0x10,%esp
    3ed8:	eb d0                	jmp    3eaa <sbrktest+0x345>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3eda:	83 ec 0c             	sub    $0xc,%esp
    3edd:	68 00 10 00 00       	push   $0x1000
    3ee2:	e8 b9 08 00 00       	call   47a0 <sbrk>
    3ee7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3ee9:	83 c4 10             	add    $0x10,%esp
    3eec:	eb 03                	jmp    3ef1 <sbrktest+0x38c>
    3eee:	83 c3 01             	add    $0x1,%ebx
    3ef1:	83 fb 09             	cmp    $0x9,%ebx
    3ef4:	77 1c                	ja     3f12 <sbrktest+0x3ad>
    if(pids[i] == -1)
    3ef6:	8b 44 9d b8          	mov    -0x48(%ebp,%ebx,4),%eax
    3efa:	83 f8 ff             	cmp    $0xffffffff,%eax
    3efd:	74 ef                	je     3eee <sbrktest+0x389>
      continue;
    kill(pids[i]);
    3eff:	83 ec 0c             	sub    $0xc,%esp
    3f02:	50                   	push   %eax
    3f03:	e8 40 08 00 00       	call   4748 <kill>
    wait();
    3f08:	e8 13 08 00 00       	call   4720 <wait>
    3f0d:	83 c4 10             	add    $0x10,%esp
    3f10:	eb dc                	jmp    3eee <sbrktest+0x389>
  }
  if(c == (char*)0xffffffff){
    3f12:	83 fe ff             	cmp    $0xffffffff,%esi
    3f15:	74 2f                	je     3f46 <sbrktest+0x3e1>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    3f17:	83 ec 0c             	sub    $0xc,%esp
    3f1a:	6a 00                	push   $0x0
    3f1c:	e8 7f 08 00 00       	call   47a0 <sbrk>
    3f21:	83 c4 10             	add    $0x10,%esp
    3f24:	39 c7                	cmp    %eax,%edi
    3f26:	72 36                	jb     3f5e <sbrktest+0x3f9>
    sbrk(-(sbrk(0) - oldbrk));

  printf(stdout, "sbrk test OK\n");
    3f28:	83 ec 08             	sub    $0x8,%esp
    3f2b:	68 c4 59 00 00       	push   $0x59c4
    3f30:	ff 35 b4 6b 00 00    	push   0x6bb4
    3f36:	e8 42 09 00 00       	call   487d <printf>
}
    3f3b:	83 c4 10             	add    $0x10,%esp
    3f3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3f41:	5b                   	pop    %ebx
    3f42:	5e                   	pop    %esi
    3f43:	5f                   	pop    %edi
    3f44:	5d                   	pop    %ebp
    3f45:	c3                   	ret    
    printf(stdout, "failed sbrk leaked memory\n");
    3f46:	83 ec 08             	sub    $0x8,%esp
    3f49:	68 a9 59 00 00       	push   $0x59a9
    3f4e:	ff 35 b4 6b 00 00    	push   0x6bb4
    3f54:	e8 24 09 00 00       	call   487d <printf>
    exit();
    3f59:	e8 ba 07 00 00       	call   4718 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    3f5e:	83 ec 0c             	sub    $0xc,%esp
    3f61:	6a 00                	push   $0x0
    3f63:	e8 38 08 00 00       	call   47a0 <sbrk>
    3f68:	29 c7                	sub    %eax,%edi
    3f6a:	89 3c 24             	mov    %edi,(%esp)
    3f6d:	e8 2e 08 00 00       	call   47a0 <sbrk>
    3f72:	83 c4 10             	add    $0x10,%esp
    3f75:	eb b1                	jmp    3f28 <sbrktest+0x3c3>

00003f77 <validateint>:
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3f77:	c3                   	ret    

00003f78 <validatetest>:

void
validatetest(void)
{
    3f78:	55                   	push   %ebp
    3f79:	89 e5                	mov    %esp,%ebp
    3f7b:	56                   	push   %esi
    3f7c:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3f7d:	83 ec 08             	sub    $0x8,%esp
    3f80:	68 d2 59 00 00       	push   $0x59d2
    3f85:	ff 35 b4 6b 00 00    	push   0x6bb4
    3f8b:	e8 ed 08 00 00       	call   487d <printf>
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    3f90:	83 c4 10             	add    $0x10,%esp
    3f93:	be 00 00 00 00       	mov    $0x0,%esi
    3f98:	81 fe 00 30 11 00    	cmp    $0x113000,%esi
    3f9e:	77 69                	ja     4009 <validatetest+0x91>
    if((pid = fork()) == 0){
    3fa0:	e8 6b 07 00 00       	call   4710 <fork>
    3fa5:	89 c3                	mov    %eax,%ebx
    3fa7:	85 c0                	test   %eax,%eax
    3fa9:	74 41                	je     3fec <validatetest+0x74>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    3fab:	83 ec 0c             	sub    $0xc,%esp
    3fae:	6a 00                	push   $0x0
    3fb0:	e8 f3 07 00 00       	call   47a8 <sleep>
    sleep(0);
    3fb5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3fbc:	e8 e7 07 00 00       	call   47a8 <sleep>
    kill(pid);
    3fc1:	89 1c 24             	mov    %ebx,(%esp)
    3fc4:	e8 7f 07 00 00       	call   4748 <kill>
    wait();
    3fc9:	e8 52 07 00 00       	call   4720 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3fce:	83 c4 08             	add    $0x8,%esp
    3fd1:	56                   	push   %esi
    3fd2:	68 e1 59 00 00       	push   $0x59e1
    3fd7:	e8 9c 07 00 00       	call   4778 <link>
    3fdc:	83 c4 10             	add    $0x10,%esp
    3fdf:	83 f8 ff             	cmp    $0xffffffff,%eax
    3fe2:	75 0d                	jne    3ff1 <validatetest+0x79>
  for(p = 0; p <= (uint)hi; p += 4096){
    3fe4:	81 c6 00 10 00 00    	add    $0x1000,%esi
    3fea:	eb ac                	jmp    3f98 <validatetest+0x20>
      exit();
    3fec:	e8 27 07 00 00       	call   4718 <exit>
      printf(stdout, "link should not succeed\n");
    3ff1:	83 ec 08             	sub    $0x8,%esp
    3ff4:	68 ec 59 00 00       	push   $0x59ec
    3ff9:	ff 35 b4 6b 00 00    	push   0x6bb4
    3fff:	e8 79 08 00 00       	call   487d <printf>
      exit();
    4004:	e8 0f 07 00 00       	call   4718 <exit>
    }
  }

  printf(stdout, "validate ok\n");
    4009:	83 ec 08             	sub    $0x8,%esp
    400c:	68 05 5a 00 00       	push   $0x5a05
    4011:	ff 35 b4 6b 00 00    	push   0x6bb4
    4017:	e8 61 08 00 00       	call   487d <printf>
}
    401c:	83 c4 10             	add    $0x10,%esp
    401f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    4022:	5b                   	pop    %ebx
    4023:	5e                   	pop    %esi
    4024:	5d                   	pop    %ebp
    4025:	c3                   	ret    

00004026 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    4026:	55                   	push   %ebp
    4027:	89 e5                	mov    %esp,%ebp
    4029:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    402c:	68 12 5a 00 00       	push   $0x5a12
    4031:	ff 35 b4 6b 00 00    	push   0x6bb4
    4037:	e8 41 08 00 00       	call   487d <printf>
  for(i = 0; i < sizeof(uninit); i++){
    403c:	83 c4 10             	add    $0x10,%esp
    403f:	b8 00 00 00 00       	mov    $0x0,%eax
    4044:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    4049:	77 26                	ja     4071 <bsstest+0x4b>
    if(uninit[i] != '\0'){
    404b:	80 b8 e0 6b 00 00 00 	cmpb   $0x0,0x6be0(%eax)
    4052:	75 05                	jne    4059 <bsstest+0x33>
  for(i = 0; i < sizeof(uninit); i++){
    4054:	83 c0 01             	add    $0x1,%eax
    4057:	eb eb                	jmp    4044 <bsstest+0x1e>
      printf(stdout, "bss test failed\n");
    4059:	83 ec 08             	sub    $0x8,%esp
    405c:	68 1c 5a 00 00       	push   $0x5a1c
    4061:	ff 35 b4 6b 00 00    	push   0x6bb4
    4067:	e8 11 08 00 00       	call   487d <printf>
      exit();
    406c:	e8 a7 06 00 00       	call   4718 <exit>
    }
  }
  printf(stdout, "bss test ok\n");
    4071:	83 ec 08             	sub    $0x8,%esp
    4074:	68 2d 5a 00 00       	push   $0x5a2d
    4079:	ff 35 b4 6b 00 00    	push   0x6bb4
    407f:	e8 f9 07 00 00       	call   487d <printf>
}
    4084:	83 c4 10             	add    $0x10,%esp
    4087:	c9                   	leave  
    4088:	c3                   	ret    

00004089 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    4089:	55                   	push   %ebp
    408a:	89 e5                	mov    %esp,%ebp
    408c:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    408f:	68 3a 5a 00 00       	push   $0x5a3a
    4094:	e8 cf 06 00 00       	call   4768 <unlink>
  pid = fork();
    4099:	e8 72 06 00 00       	call   4710 <fork>
  if(pid == 0){
    409e:	83 c4 10             	add    $0x10,%esp
    40a1:	85 c0                	test   %eax,%eax
    40a3:	74 4d                	je     40f2 <bigargtest+0x69>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    40a5:	0f 88 ad 00 00 00    	js     4158 <bigargtest+0xcf>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    40ab:	e8 70 06 00 00       	call   4720 <wait>
  fd = open("bigarg-ok", 0);
    40b0:	83 ec 08             	sub    $0x8,%esp
    40b3:	6a 00                	push   $0x0
    40b5:	68 3a 5a 00 00       	push   $0x5a3a
    40ba:	e8 99 06 00 00       	call   4758 <open>
  if(fd < 0){
    40bf:	83 c4 10             	add    $0x10,%esp
    40c2:	85 c0                	test   %eax,%eax
    40c4:	0f 88 a6 00 00 00    	js     4170 <bigargtest+0xe7>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    40ca:	83 ec 0c             	sub    $0xc,%esp
    40cd:	50                   	push   %eax
    40ce:	e8 6d 06 00 00       	call   4740 <close>
  unlink("bigarg-ok");
    40d3:	c7 04 24 3a 5a 00 00 	movl   $0x5a3a,(%esp)
    40da:	e8 89 06 00 00       	call   4768 <unlink>
}
    40df:	83 c4 10             	add    $0x10,%esp
    40e2:	c9                   	leave  
    40e3:	c3                   	ret    
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    40e4:	c7 04 85 00 b3 00 00 	movl   $0x6194,0xb300(,%eax,4)
    40eb:	94 61 00 00 
    for(i = 0; i < MAXARG-1; i++)
    40ef:	83 c0 01             	add    $0x1,%eax
    40f2:	83 f8 1e             	cmp    $0x1e,%eax
    40f5:	7e ed                	jle    40e4 <bigargtest+0x5b>
    args[MAXARG-1] = 0;
    40f7:	c7 05 7c b3 00 00 00 	movl   $0x0,0xb37c
    40fe:	00 00 00 
    printf(stdout, "bigarg test\n");
    4101:	83 ec 08             	sub    $0x8,%esp
    4104:	68 44 5a 00 00       	push   $0x5a44
    4109:	ff 35 b4 6b 00 00    	push   0x6bb4
    410f:	e8 69 07 00 00       	call   487d <printf>
    exec("echo", args);
    4114:	83 c4 08             	add    $0x8,%esp
    4117:	68 00 b3 00 00       	push   $0xb300
    411c:	68 11 4c 00 00       	push   $0x4c11
    4121:	e8 2a 06 00 00       	call   4750 <exec>
    printf(stdout, "bigarg test ok\n");
    4126:	83 c4 08             	add    $0x8,%esp
    4129:	68 51 5a 00 00       	push   $0x5a51
    412e:	ff 35 b4 6b 00 00    	push   0x6bb4
    4134:	e8 44 07 00 00       	call   487d <printf>
    fd = open("bigarg-ok", O_CREATE);
    4139:	83 c4 08             	add    $0x8,%esp
    413c:	68 00 02 00 00       	push   $0x200
    4141:	68 3a 5a 00 00       	push   $0x5a3a
    4146:	e8 0d 06 00 00       	call   4758 <open>
    close(fd);
    414b:	89 04 24             	mov    %eax,(%esp)
    414e:	e8 ed 05 00 00       	call   4740 <close>
    exit();
    4153:	e8 c0 05 00 00       	call   4718 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    4158:	83 ec 08             	sub    $0x8,%esp
    415b:	68 61 5a 00 00       	push   $0x5a61
    4160:	ff 35 b4 6b 00 00    	push   0x6bb4
    4166:	e8 12 07 00 00       	call   487d <printf>
    exit();
    416b:	e8 a8 05 00 00       	call   4718 <exit>
    printf(stdout, "bigarg test failed!\n");
    4170:	83 ec 08             	sub    $0x8,%esp
    4173:	68 7a 5a 00 00       	push   $0x5a7a
    4178:	ff 35 b4 6b 00 00    	push   0x6bb4
    417e:	e8 fa 06 00 00       	call   487d <printf>
    exit();
    4183:	e8 90 05 00 00       	call   4718 <exit>

00004188 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    4188:	55                   	push   %ebp
    4189:	89 e5                	mov    %esp,%ebp
    418b:	57                   	push   %edi
    418c:	56                   	push   %esi
    418d:	53                   	push   %ebx
    418e:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    4191:	68 8f 5a 00 00       	push   $0x5a8f
    4196:	6a 01                	push   $0x1
    4198:	e8 e0 06 00 00       	call   487d <printf>
    419d:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    41a0:	bb 00 00 00 00       	mov    $0x0,%ebx
    char name[64];
    name[0] = 'f';
    41a5:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    41a9:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    41ae:	89 d8                	mov    %ebx,%eax
    41b0:	f7 ea                	imul   %edx
    41b2:	c1 fa 06             	sar    $0x6,%edx
    41b5:	89 de                	mov    %ebx,%esi
    41b7:	c1 fe 1f             	sar    $0x1f,%esi
    41ba:	29 f2                	sub    %esi,%edx
    41bc:	8d 42 30             	lea    0x30(%edx),%eax
    41bf:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    41c2:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    41c8:	89 d9                	mov    %ebx,%ecx
    41ca:	29 d1                	sub    %edx,%ecx
    41cc:	bf 1f 85 eb 51       	mov    $0x51eb851f,%edi
    41d1:	89 c8                	mov    %ecx,%eax
    41d3:	f7 ef                	imul   %edi
    41d5:	c1 fa 05             	sar    $0x5,%edx
    41d8:	c1 f9 1f             	sar    $0x1f,%ecx
    41db:	29 ca                	sub    %ecx,%edx
    41dd:	83 c2 30             	add    $0x30,%edx
    41e0:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    41e3:	89 d8                	mov    %ebx,%eax
    41e5:	f7 ef                	imul   %edi
    41e7:	89 d7                	mov    %edx,%edi
    41e9:	c1 ff 05             	sar    $0x5,%edi
    41ec:	29 f7                	sub    %esi,%edi
    41ee:	6b c7 64             	imul   $0x64,%edi,%eax
    41f1:	89 df                	mov    %ebx,%edi
    41f3:	29 c7                	sub    %eax,%edi
    41f5:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    41fa:	89 f8                	mov    %edi,%eax
    41fc:	f7 e9                	imul   %ecx
    41fe:	c1 fa 02             	sar    $0x2,%edx
    4201:	c1 ff 1f             	sar    $0x1f,%edi
    4204:	29 fa                	sub    %edi,%edx
    4206:	83 c2 30             	add    $0x30,%edx
    4209:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    420c:	89 d8                	mov    %ebx,%eax
    420e:	f7 e9                	imul   %ecx
    4210:	c1 fa 02             	sar    $0x2,%edx
    4213:	29 f2                	sub    %esi,%edx
    4215:	8d 04 92             	lea    (%edx,%edx,4),%eax
    4218:	01 c0                	add    %eax,%eax
    421a:	89 da                	mov    %ebx,%edx
    421c:	29 c2                	sub    %eax,%edx
    421e:	83 c2 30             	add    $0x30,%edx
    4221:	88 55 ac             	mov    %dl,-0x54(%ebp)
    name[5] = '\0';
    4224:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    4228:	83 ec 04             	sub    $0x4,%esp
    422b:	8d 75 a8             	lea    -0x58(%ebp),%esi
    422e:	56                   	push   %esi
    422f:	68 9c 5a 00 00       	push   $0x5a9c
    4234:	6a 01                	push   $0x1
    4236:	e8 42 06 00 00       	call   487d <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    423b:	83 c4 08             	add    $0x8,%esp
    423e:	68 02 02 00 00       	push   $0x202
    4243:	56                   	push   %esi
    4244:	e8 0f 05 00 00       	call   4758 <open>
    4249:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    424b:	83 c4 10             	add    $0x10,%esp
    424e:	85 c0                	test   %eax,%eax
    4250:	79 1b                	jns    426d <fsfull+0xe5>
      printf(1, "open %s failed\n", name);
    4252:	83 ec 04             	sub    $0x4,%esp
    4255:	8d 45 a8             	lea    -0x58(%ebp),%eax
    4258:	50                   	push   %eax
    4259:	68 a8 5a 00 00       	push   $0x5aa8
    425e:	6a 01                	push   $0x1
    4260:	e8 18 06 00 00       	call   487d <printf>
      break;
    4265:	83 c4 10             	add    $0x10,%esp
    4268:	e9 e6 00 00 00       	jmp    4353 <fsfull+0x1cb>
    }
    int total = 0;
    426d:	bf 00 00 00 00       	mov    $0x0,%edi
    while(1){
      int cc = write(fd, buf, 512);
    4272:	83 ec 04             	sub    $0x4,%esp
    4275:	68 00 02 00 00       	push   $0x200
    427a:	68 00 93 00 00       	push   $0x9300
    427f:	56                   	push   %esi
    4280:	e8 b3 04 00 00       	call   4738 <write>
      if(cc < 512)
    4285:	83 c4 10             	add    $0x10,%esp
    4288:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    428d:	7e 04                	jle    4293 <fsfull+0x10b>
        break;
      total += cc;
    428f:	01 c7                	add    %eax,%edi
    while(1){
    4291:	eb df                	jmp    4272 <fsfull+0xea>
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    4293:	83 ec 04             	sub    $0x4,%esp
    4296:	57                   	push   %edi
    4297:	68 b8 5a 00 00       	push   $0x5ab8
    429c:	6a 01                	push   $0x1
    429e:	e8 da 05 00 00       	call   487d <printf>
    close(fd);
    42a3:	89 34 24             	mov    %esi,(%esp)
    42a6:	e8 95 04 00 00       	call   4740 <close>
    if(total == 0)
    42ab:	83 c4 10             	add    $0x10,%esp
    42ae:	85 ff                	test   %edi,%edi
    42b0:	0f 84 9d 00 00 00    	je     4353 <fsfull+0x1cb>
  for(nfiles = 0; ; nfiles++){
    42b6:	83 c3 01             	add    $0x1,%ebx
    42b9:	e9 e7 fe ff ff       	jmp    41a5 <fsfull+0x1d>
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    42be:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    42c2:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    42c7:	89 d8                	mov    %ebx,%eax
    42c9:	f7 ea                	imul   %edx
    42cb:	c1 fa 06             	sar    $0x6,%edx
    42ce:	89 de                	mov    %ebx,%esi
    42d0:	c1 fe 1f             	sar    $0x1f,%esi
    42d3:	29 f2                	sub    %esi,%edx
    42d5:	8d 42 30             	lea    0x30(%edx),%eax
    42d8:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    42db:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    42e1:	89 d9                	mov    %ebx,%ecx
    42e3:	29 d1                	sub    %edx,%ecx
    42e5:	bf 1f 85 eb 51       	mov    $0x51eb851f,%edi
    42ea:	89 c8                	mov    %ecx,%eax
    42ec:	f7 ef                	imul   %edi
    42ee:	c1 fa 05             	sar    $0x5,%edx
    42f1:	c1 f9 1f             	sar    $0x1f,%ecx
    42f4:	29 ca                	sub    %ecx,%edx
    42f6:	83 c2 30             	add    $0x30,%edx
    42f9:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    42fc:	89 d8                	mov    %ebx,%eax
    42fe:	f7 ef                	imul   %edi
    4300:	89 d7                	mov    %edx,%edi
    4302:	c1 ff 05             	sar    $0x5,%edi
    4305:	29 f7                	sub    %esi,%edi
    4307:	6b c7 64             	imul   $0x64,%edi,%eax
    430a:	89 df                	mov    %ebx,%edi
    430c:	29 c7                	sub    %eax,%edi
    430e:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    4313:	89 f8                	mov    %edi,%eax
    4315:	f7 e9                	imul   %ecx
    4317:	c1 fa 02             	sar    $0x2,%edx
    431a:	c1 ff 1f             	sar    $0x1f,%edi
    431d:	29 fa                	sub    %edi,%edx
    431f:	83 c2 30             	add    $0x30,%edx
    4322:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    4325:	89 d8                	mov    %ebx,%eax
    4327:	f7 e9                	imul   %ecx
    4329:	c1 fa 02             	sar    $0x2,%edx
    432c:	29 f2                	sub    %esi,%edx
    432e:	8d 04 92             	lea    (%edx,%edx,4),%eax
    4331:	01 c0                	add    %eax,%eax
    4333:	89 da                	mov    %ebx,%edx
    4335:	29 c2                	sub    %eax,%edx
    4337:	83 c2 30             	add    $0x30,%edx
    433a:	88 55 ac             	mov    %dl,-0x54(%ebp)
    name[5] = '\0';
    433d:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    4341:	83 ec 0c             	sub    $0xc,%esp
    4344:	8d 45 a8             	lea    -0x58(%ebp),%eax
    4347:	50                   	push   %eax
    4348:	e8 1b 04 00 00       	call   4768 <unlink>
    nfiles--;
    434d:	83 eb 01             	sub    $0x1,%ebx
    4350:	83 c4 10             	add    $0x10,%esp
  while(nfiles >= 0){
    4353:	85 db                	test   %ebx,%ebx
    4355:	0f 89 63 ff ff ff    	jns    42be <fsfull+0x136>
  }

  printf(1, "fsfull test finished\n");
    435b:	83 ec 08             	sub    $0x8,%esp
    435e:	68 c8 5a 00 00       	push   $0x5ac8
    4363:	6a 01                	push   $0x1
    4365:	e8 13 05 00 00       	call   487d <printf>
}
    436a:	83 c4 10             	add    $0x10,%esp
    436d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    4370:	5b                   	pop    %ebx
    4371:	5e                   	pop    %esi
    4372:	5f                   	pop    %edi
    4373:	5d                   	pop    %ebp
    4374:	c3                   	ret    

00004375 <uio>:

void
uio()
{
    4375:	55                   	push   %ebp
    4376:	89 e5                	mov    %esp,%ebp
    4378:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    437b:	68 de 5a 00 00       	push   $0x5ade
    4380:	6a 01                	push   $0x1
    4382:	e8 f6 04 00 00       	call   487d <printf>
  pid = fork();
    4387:	e8 84 03 00 00       	call   4710 <fork>
  if(pid == 0){
    438c:	83 c4 10             	add    $0x10,%esp
    438f:	85 c0                	test   %eax,%eax
    4391:	74 1b                	je     43ae <uio+0x39>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    4393:	78 3e                	js     43d3 <uio+0x5e>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    4395:	e8 86 03 00 00       	call   4720 <wait>
  printf(1, "uio test done\n");
    439a:	83 ec 08             	sub    $0x8,%esp
    439d:	68 e8 5a 00 00       	push   $0x5ae8
    43a2:	6a 01                	push   $0x1
    43a4:	e8 d4 04 00 00       	call   487d <printf>
}
    43a9:	83 c4 10             	add    $0x10,%esp
    43ac:	c9                   	leave  
    43ad:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    43ae:	b8 09 00 00 00       	mov    $0x9,%eax
    43b3:	ba 70 00 00 00       	mov    $0x70,%edx
    43b8:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    43b9:	ba 71 00 00 00       	mov    $0x71,%edx
    43be:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    43bf:	83 ec 08             	sub    $0x8,%esp
    43c2:	68 74 62 00 00       	push   $0x6274
    43c7:	6a 01                	push   $0x1
    43c9:	e8 af 04 00 00       	call   487d <printf>
    exit();
    43ce:	e8 45 03 00 00       	call   4718 <exit>
    printf (1, "fork failed\n");
    43d3:	83 ec 08             	sub    $0x8,%esp
    43d6:	68 6d 5a 00 00       	push   $0x5a6d
    43db:	6a 01                	push   $0x1
    43dd:	e8 9b 04 00 00       	call   487d <printf>
    exit();
    43e2:	e8 31 03 00 00       	call   4718 <exit>

000043e7 <argptest>:

void argptest()
{
    43e7:	55                   	push   %ebp
    43e8:	89 e5                	mov    %esp,%ebp
    43ea:	53                   	push   %ebx
    43eb:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    43ee:	6a 00                	push   $0x0
    43f0:	68 f7 5a 00 00       	push   $0x5af7
    43f5:	e8 5e 03 00 00       	call   4758 <open>
  if (fd < 0) {
    43fa:	83 c4 10             	add    $0x10,%esp
    43fd:	85 c0                	test   %eax,%eax
    43ff:	78 3a                	js     443b <argptest+0x54>
    4401:	89 c3                	mov    %eax,%ebx
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    4403:	83 ec 0c             	sub    $0xc,%esp
    4406:	6a 00                	push   $0x0
    4408:	e8 93 03 00 00       	call   47a0 <sbrk>
    440d:	83 e8 01             	sub    $0x1,%eax
    4410:	83 c4 0c             	add    $0xc,%esp
    4413:	6a ff                	push   $0xffffffff
    4415:	50                   	push   %eax
    4416:	53                   	push   %ebx
    4417:	e8 14 03 00 00       	call   4730 <read>
  close(fd);
    441c:	89 1c 24             	mov    %ebx,(%esp)
    441f:	e8 1c 03 00 00       	call   4740 <close>
  printf(1, "arg test passed\n");
    4424:	83 c4 08             	add    $0x8,%esp
    4427:	68 09 5b 00 00       	push   $0x5b09
    442c:	6a 01                	push   $0x1
    442e:	e8 4a 04 00 00       	call   487d <printf>
}
    4433:	83 c4 10             	add    $0x10,%esp
    4436:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4439:	c9                   	leave  
    443a:	c3                   	ret    
    printf(2, "open failed\n");
    443b:	83 ec 08             	sub    $0x8,%esp
    443e:	68 fc 5a 00 00       	push   $0x5afc
    4443:	6a 02                	push   $0x2
    4445:	e8 33 04 00 00       	call   487d <printf>
    exit();
    444a:	e8 c9 02 00 00       	call   4718 <exit>

0000444f <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    444f:	69 05 b0 6b 00 00 0d 	imul   $0x19660d,0x6bb0,%eax
    4456:	66 19 00 
    4459:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    445e:	a3 b0 6b 00 00       	mov    %eax,0x6bb0
  return randstate;
}
    4463:	c3                   	ret    

00004464 <main>:

int
main(int argc, char *argv[])
{
    4464:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    4468:	83 e4 f0             	and    $0xfffffff0,%esp
    446b:	ff 71 fc             	push   -0x4(%ecx)
    446e:	55                   	push   %ebp
    446f:	89 e5                	mov    %esp,%ebp
    4471:	51                   	push   %ecx
    4472:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
    4475:	68 1a 5b 00 00       	push   $0x5b1a
    447a:	6a 01                	push   $0x1
    447c:	e8 fc 03 00 00       	call   487d <printf>

  if(open("usertests.ran", 0) >= 0){
    4481:	83 c4 08             	add    $0x8,%esp
    4484:	6a 00                	push   $0x0
    4486:	68 2e 5b 00 00       	push   $0x5b2e
    448b:	e8 c8 02 00 00       	call   4758 <open>
    4490:	83 c4 10             	add    $0x10,%esp
    4493:	85 c0                	test   %eax,%eax
    4495:	78 14                	js     44ab <main+0x47>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    4497:	83 ec 08             	sub    $0x8,%esp
    449a:	68 98 62 00 00       	push   $0x6298
    449f:	6a 01                	push   $0x1
    44a1:	e8 d7 03 00 00       	call   487d <printf>
    exit();
    44a6:	e8 6d 02 00 00       	call   4718 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    44ab:	83 ec 08             	sub    $0x8,%esp
    44ae:	68 00 02 00 00       	push   $0x200
    44b3:	68 2e 5b 00 00       	push   $0x5b2e
    44b8:	e8 9b 02 00 00       	call   4758 <open>
    44bd:	89 04 24             	mov    %eax,(%esp)
    44c0:	e8 7b 02 00 00       	call   4740 <close>

  argptest();
    44c5:	e8 1d ff ff ff       	call   43e7 <argptest>
  createdelete();
    44ca:	e8 43 db ff ff       	call   2012 <createdelete>
  linkunlink();
    44cf:	e8 e0 e3 ff ff       	call   28b4 <linkunlink>
  concreate();
    44d4:	e8 ed e0 ff ff       	call   25c6 <concreate>
  fourfiles();
    44d9:	e8 4e d9 ff ff       	call   1e2c <fourfiles>
  sharedfd();
    44de:	e8 ac d7 ff ff       	call   1c8f <sharedfd>

  bigargtest();
    44e3:	e8 a1 fb ff ff       	call   4089 <bigargtest>
  bigwrite();
    44e8:	e8 3d ed ff ff       	call   322a <bigwrite>
  bigargtest();
    44ed:	e8 97 fb ff ff       	call   4089 <bigargtest>
  bsstest();
    44f2:	e8 2f fb ff ff       	call   4026 <bsstest>
  sbrktest();
    44f7:	e8 69 f6 ff ff       	call   3b65 <sbrktest>
  validatetest();
    44fc:	e8 77 fa ff ff       	call   3f78 <validatetest>

  opentest();
    4501:	e8 a6 cd ff ff       	call   12ac <opentest>
  writetest();
    4506:	e8 34 ce ff ff       	call   133f <writetest>
  writetest1();
    450b:	e8 f7 cf ff ff       	call   1507 <writetest1>
  createtest();
    4510:	e8 a2 d1 ff ff       	call   16b7 <createtest>

  openiputtest();
    4515:	e8 a9 cc ff ff       	call   11c3 <openiputtest>
  exitiputtest();
    451a:	e8 be cb ff ff       	call   10dd <exitiputtest>
  iputtest();
    451f:	e8 dc ca ff ff       	call   1000 <iputtest>

  mem();
    4524:	e8 ab d6 ff ff       	call   1bd4 <mem>
  pipe1();
    4529:	e8 5b d3 ff ff       	call   1889 <pipe1>
  preempt();
    452e:	e8 f6 d4 ff ff       	call   1a29 <preempt>
  exitwait();
    4533:	e8 2c d6 ff ff       	call   1b64 <exitwait>

  rmdot();
    4538:	e8 b2 f0 ff ff       	call   35ef <rmdot>
  fourteen();
    453d:	e8 70 ef ff ff       	call   34b2 <fourteen>
  bigfile();
    4542:	e8 b5 ed ff ff       	call   32fc <bigfile>
  subdir();
    4547:	e8 b0 e5 ff ff       	call   2afc <subdir>
  linktest();
    454c:	e8 4f de ff ff       	call   23a0 <linktest>
  unlinkread();
    4551:	e8 b1 dc ff ff       	call   2207 <unlinkread>
  dirfile();
    4556:	e8 19 f2 ff ff       	call   3774 <dirfile>
  iref();
    455b:	e8 2e f4 ff ff       	call   398e <iref>
  forktest();
    4560:	e8 51 f5 ff ff       	call   3ab6 <forktest>
  bigdir(); // slow
    4565:	e8 3e e4 ff ff       	call   29a8 <bigdir>

  uio();
    456a:	e8 06 fe ff ff       	call   4375 <uio>

  exectest();
    456f:	e8 cc d2 ff ff       	call   1840 <exectest>

  exit();
    4574:	e8 9f 01 00 00       	call   4718 <exit>

00004579 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    4579:	55                   	push   %ebp
    457a:	89 e5                	mov    %esp,%ebp
    457c:	56                   	push   %esi
    457d:	53                   	push   %ebx
    457e:	8b 75 08             	mov    0x8(%ebp),%esi
    4581:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    4584:	89 f0                	mov    %esi,%eax
    4586:	89 d1                	mov    %edx,%ecx
    4588:	83 c2 01             	add    $0x1,%edx
    458b:	89 c3                	mov    %eax,%ebx
    458d:	83 c0 01             	add    $0x1,%eax
    4590:	0f b6 09             	movzbl (%ecx),%ecx
    4593:	88 0b                	mov    %cl,(%ebx)
    4595:	84 c9                	test   %cl,%cl
    4597:	75 ed                	jne    4586 <strcpy+0xd>
    ;
  return os;
}
    4599:	89 f0                	mov    %esi,%eax
    459b:	5b                   	pop    %ebx
    459c:	5e                   	pop    %esi
    459d:	5d                   	pop    %ebp
    459e:	c3                   	ret    

0000459f <strcmp>:

int
strcmp(const char *p, const char *q)
{
    459f:	55                   	push   %ebp
    45a0:	89 e5                	mov    %esp,%ebp
    45a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    45a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    45a8:	eb 06                	jmp    45b0 <strcmp+0x11>
    p++, q++;
    45aa:	83 c1 01             	add    $0x1,%ecx
    45ad:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    45b0:	0f b6 01             	movzbl (%ecx),%eax
    45b3:	84 c0                	test   %al,%al
    45b5:	74 04                	je     45bb <strcmp+0x1c>
    45b7:	3a 02                	cmp    (%edx),%al
    45b9:	74 ef                	je     45aa <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    45bb:	0f b6 c0             	movzbl %al,%eax
    45be:	0f b6 12             	movzbl (%edx),%edx
    45c1:	29 d0                	sub    %edx,%eax
}
    45c3:	5d                   	pop    %ebp
    45c4:	c3                   	ret    

000045c5 <strlen>:

uint
strlen(const char *s)
{
    45c5:	55                   	push   %ebp
    45c6:	89 e5                	mov    %esp,%ebp
    45c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    45cb:	b8 00 00 00 00       	mov    $0x0,%eax
    45d0:	eb 03                	jmp    45d5 <strlen+0x10>
    45d2:	83 c0 01             	add    $0x1,%eax
    45d5:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    45d9:	75 f7                	jne    45d2 <strlen+0xd>
    ;
  return n;
}
    45db:	5d                   	pop    %ebp
    45dc:	c3                   	ret    

000045dd <memset>:

void*
memset(void *dst, int c, uint n)
{
    45dd:	55                   	push   %ebp
    45de:	89 e5                	mov    %esp,%ebp
    45e0:	57                   	push   %edi
    45e1:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    45e4:	89 d7                	mov    %edx,%edi
    45e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    45e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    45ec:	fc                   	cld    
    45ed:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    45ef:	89 d0                	mov    %edx,%eax
    45f1:	8b 7d fc             	mov    -0x4(%ebp),%edi
    45f4:	c9                   	leave  
    45f5:	c3                   	ret    

000045f6 <strchr>:

char*
strchr(const char *s, char c)
{
    45f6:	55                   	push   %ebp
    45f7:	89 e5                	mov    %esp,%ebp
    45f9:	8b 45 08             	mov    0x8(%ebp),%eax
    45fc:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    4600:	eb 03                	jmp    4605 <strchr+0xf>
    4602:	83 c0 01             	add    $0x1,%eax
    4605:	0f b6 10             	movzbl (%eax),%edx
    4608:	84 d2                	test   %dl,%dl
    460a:	74 06                	je     4612 <strchr+0x1c>
    if(*s == c)
    460c:	38 ca                	cmp    %cl,%dl
    460e:	75 f2                	jne    4602 <strchr+0xc>
    4610:	eb 05                	jmp    4617 <strchr+0x21>
      return (char*)s;
  return 0;
    4612:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4617:	5d                   	pop    %ebp
    4618:	c3                   	ret    

00004619 <gets>:

char*
gets(char *buf, int max)
{
    4619:	55                   	push   %ebp
    461a:	89 e5                	mov    %esp,%ebp
    461c:	57                   	push   %edi
    461d:	56                   	push   %esi
    461e:	53                   	push   %ebx
    461f:	83 ec 1c             	sub    $0x1c,%esp
    4622:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4625:	bb 00 00 00 00       	mov    $0x0,%ebx
    462a:	89 de                	mov    %ebx,%esi
    462c:	83 c3 01             	add    $0x1,%ebx
    462f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    4632:	7d 2e                	jge    4662 <gets+0x49>
    cc = read(0, &c, 1);
    4634:	83 ec 04             	sub    $0x4,%esp
    4637:	6a 01                	push   $0x1
    4639:	8d 45 e7             	lea    -0x19(%ebp),%eax
    463c:	50                   	push   %eax
    463d:	6a 00                	push   $0x0
    463f:	e8 ec 00 00 00       	call   4730 <read>
    if(cc < 1)
    4644:	83 c4 10             	add    $0x10,%esp
    4647:	85 c0                	test   %eax,%eax
    4649:	7e 17                	jle    4662 <gets+0x49>
      break;
    buf[i++] = c;
    464b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    464f:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    4652:	3c 0a                	cmp    $0xa,%al
    4654:	0f 94 c2             	sete   %dl
    4657:	3c 0d                	cmp    $0xd,%al
    4659:	0f 94 c0             	sete   %al
    465c:	08 c2                	or     %al,%dl
    465e:	74 ca                	je     462a <gets+0x11>
    buf[i++] = c;
    4660:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    4662:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    4666:	89 f8                	mov    %edi,%eax
    4668:	8d 65 f4             	lea    -0xc(%ebp),%esp
    466b:	5b                   	pop    %ebx
    466c:	5e                   	pop    %esi
    466d:	5f                   	pop    %edi
    466e:	5d                   	pop    %ebp
    466f:	c3                   	ret    

00004670 <stat>:

int
stat(const char *n, struct stat *st)
{
    4670:	55                   	push   %ebp
    4671:	89 e5                	mov    %esp,%ebp
    4673:	56                   	push   %esi
    4674:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4675:	83 ec 08             	sub    $0x8,%esp
    4678:	6a 00                	push   $0x0
    467a:	ff 75 08             	push   0x8(%ebp)
    467d:	e8 d6 00 00 00       	call   4758 <open>
  if(fd < 0)
    4682:	83 c4 10             	add    $0x10,%esp
    4685:	85 c0                	test   %eax,%eax
    4687:	78 24                	js     46ad <stat+0x3d>
    4689:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    468b:	83 ec 08             	sub    $0x8,%esp
    468e:	ff 75 0c             	push   0xc(%ebp)
    4691:	50                   	push   %eax
    4692:	e8 d9 00 00 00       	call   4770 <fstat>
    4697:	89 c6                	mov    %eax,%esi
  close(fd);
    4699:	89 1c 24             	mov    %ebx,(%esp)
    469c:	e8 9f 00 00 00       	call   4740 <close>
  return r;
    46a1:	83 c4 10             	add    $0x10,%esp
}
    46a4:	89 f0                	mov    %esi,%eax
    46a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    46a9:	5b                   	pop    %ebx
    46aa:	5e                   	pop    %esi
    46ab:	5d                   	pop    %ebp
    46ac:	c3                   	ret    
    return -1;
    46ad:	be ff ff ff ff       	mov    $0xffffffff,%esi
    46b2:	eb f0                	jmp    46a4 <stat+0x34>

000046b4 <atoi>:

int
atoi(const char *s)
{
    46b4:	55                   	push   %ebp
    46b5:	89 e5                	mov    %esp,%ebp
    46b7:	53                   	push   %ebx
    46b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    46bb:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    46c0:	eb 10                	jmp    46d2 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    46c2:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    46c5:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    46c8:	83 c1 01             	add    $0x1,%ecx
    46cb:	0f be c0             	movsbl %al,%eax
    46ce:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    46d2:	0f b6 01             	movzbl (%ecx),%eax
    46d5:	8d 58 d0             	lea    -0x30(%eax),%ebx
    46d8:	80 fb 09             	cmp    $0x9,%bl
    46db:	76 e5                	jbe    46c2 <atoi+0xe>
  return n;
}
    46dd:	89 d0                	mov    %edx,%eax
    46df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    46e2:	c9                   	leave  
    46e3:	c3                   	ret    

000046e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    46e4:	55                   	push   %ebp
    46e5:	89 e5                	mov    %esp,%ebp
    46e7:	56                   	push   %esi
    46e8:	53                   	push   %ebx
    46e9:	8b 75 08             	mov    0x8(%ebp),%esi
    46ec:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    46ef:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    46f2:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    46f4:	eb 0d                	jmp    4703 <memmove+0x1f>
    *dst++ = *src++;
    46f6:	0f b6 01             	movzbl (%ecx),%eax
    46f9:	88 02                	mov    %al,(%edx)
    46fb:	8d 49 01             	lea    0x1(%ecx),%ecx
    46fe:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    4701:	89 d8                	mov    %ebx,%eax
    4703:	8d 58 ff             	lea    -0x1(%eax),%ebx
    4706:	85 c0                	test   %eax,%eax
    4708:	7f ec                	jg     46f6 <memmove+0x12>
  return vdst;
}
    470a:	89 f0                	mov    %esi,%eax
    470c:	5b                   	pop    %ebx
    470d:	5e                   	pop    %esi
    470e:	5d                   	pop    %ebp
    470f:	c3                   	ret    

00004710 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4710:	b8 01 00 00 00       	mov    $0x1,%eax
    4715:	cd 40                	int    $0x40
    4717:	c3                   	ret    

00004718 <exit>:
SYSCALL(exit)
    4718:	b8 02 00 00 00       	mov    $0x2,%eax
    471d:	cd 40                	int    $0x40
    471f:	c3                   	ret    

00004720 <wait>:
SYSCALL(wait)
    4720:	b8 03 00 00 00       	mov    $0x3,%eax
    4725:	cd 40                	int    $0x40
    4727:	c3                   	ret    

00004728 <pipe>:
SYSCALL(pipe)
    4728:	b8 04 00 00 00       	mov    $0x4,%eax
    472d:	cd 40                	int    $0x40
    472f:	c3                   	ret    

00004730 <read>:
SYSCALL(read)
    4730:	b8 05 00 00 00       	mov    $0x5,%eax
    4735:	cd 40                	int    $0x40
    4737:	c3                   	ret    

00004738 <write>:
SYSCALL(write)
    4738:	b8 10 00 00 00       	mov    $0x10,%eax
    473d:	cd 40                	int    $0x40
    473f:	c3                   	ret    

00004740 <close>:
SYSCALL(close)
    4740:	b8 15 00 00 00       	mov    $0x15,%eax
    4745:	cd 40                	int    $0x40
    4747:	c3                   	ret    

00004748 <kill>:
SYSCALL(kill)
    4748:	b8 06 00 00 00       	mov    $0x6,%eax
    474d:	cd 40                	int    $0x40
    474f:	c3                   	ret    

00004750 <exec>:
SYSCALL(exec)
    4750:	b8 07 00 00 00       	mov    $0x7,%eax
    4755:	cd 40                	int    $0x40
    4757:	c3                   	ret    

00004758 <open>:
SYSCALL(open)
    4758:	b8 0f 00 00 00       	mov    $0xf,%eax
    475d:	cd 40                	int    $0x40
    475f:	c3                   	ret    

00004760 <mknod>:
SYSCALL(mknod)
    4760:	b8 11 00 00 00       	mov    $0x11,%eax
    4765:	cd 40                	int    $0x40
    4767:	c3                   	ret    

00004768 <unlink>:
SYSCALL(unlink)
    4768:	b8 12 00 00 00       	mov    $0x12,%eax
    476d:	cd 40                	int    $0x40
    476f:	c3                   	ret    

00004770 <fstat>:
SYSCALL(fstat)
    4770:	b8 08 00 00 00       	mov    $0x8,%eax
    4775:	cd 40                	int    $0x40
    4777:	c3                   	ret    

00004778 <link>:
SYSCALL(link)
    4778:	b8 13 00 00 00       	mov    $0x13,%eax
    477d:	cd 40                	int    $0x40
    477f:	c3                   	ret    

00004780 <mkdir>:
SYSCALL(mkdir)
    4780:	b8 14 00 00 00       	mov    $0x14,%eax
    4785:	cd 40                	int    $0x40
    4787:	c3                   	ret    

00004788 <chdir>:
SYSCALL(chdir)
    4788:	b8 09 00 00 00       	mov    $0x9,%eax
    478d:	cd 40                	int    $0x40
    478f:	c3                   	ret    

00004790 <dup>:
SYSCALL(dup)
    4790:	b8 0a 00 00 00       	mov    $0xa,%eax
    4795:	cd 40                	int    $0x40
    4797:	c3                   	ret    

00004798 <getpid>:
SYSCALL(getpid)
    4798:	b8 0b 00 00 00       	mov    $0xb,%eax
    479d:	cd 40                	int    $0x40
    479f:	c3                   	ret    

000047a0 <sbrk>:
SYSCALL(sbrk)
    47a0:	b8 0c 00 00 00       	mov    $0xc,%eax
    47a5:	cd 40                	int    $0x40
    47a7:	c3                   	ret    

000047a8 <sleep>:
SYSCALL(sleep)
    47a8:	b8 0d 00 00 00       	mov    $0xd,%eax
    47ad:	cd 40                	int    $0x40
    47af:	c3                   	ret    

000047b0 <uptime>:
SYSCALL(uptime)
    47b0:	b8 0e 00 00 00       	mov    $0xe,%eax
    47b5:	cd 40                	int    $0x40
    47b7:	c3                   	ret    

000047b8 <settickets>:
SYSCALL(settickets)
    47b8:	b8 16 00 00 00       	mov    $0x16,%eax
    47bd:	cd 40                	int    $0x40
    47bf:	c3                   	ret    

000047c0 <getpinfo>:
SYSCALL(getpinfo)
    47c0:	b8 17 00 00 00       	mov    $0x17,%eax
    47c5:	cd 40                	int    $0x40
    47c7:	c3                   	ret    

000047c8 <mprotect>:
SYSCALL(mprotect)
    47c8:	b8 18 00 00 00       	mov    $0x18,%eax
    47cd:	cd 40                	int    $0x40
    47cf:	c3                   	ret    

000047d0 <munprotect>:
    47d0:	b8 19 00 00 00       	mov    $0x19,%eax
    47d5:	cd 40                	int    $0x40
    47d7:	c3                   	ret    

000047d8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    47d8:	55                   	push   %ebp
    47d9:	89 e5                	mov    %esp,%ebp
    47db:	83 ec 1c             	sub    $0x1c,%esp
    47de:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    47e1:	6a 01                	push   $0x1
    47e3:	8d 55 f4             	lea    -0xc(%ebp),%edx
    47e6:	52                   	push   %edx
    47e7:	50                   	push   %eax
    47e8:	e8 4b ff ff ff       	call   4738 <write>
}
    47ed:	83 c4 10             	add    $0x10,%esp
    47f0:	c9                   	leave  
    47f1:	c3                   	ret    

000047f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    47f2:	55                   	push   %ebp
    47f3:	89 e5                	mov    %esp,%ebp
    47f5:	57                   	push   %edi
    47f6:	56                   	push   %esi
    47f7:	53                   	push   %ebx
    47f8:	83 ec 2c             	sub    $0x2c,%esp
    47fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
    47fe:	89 d0                	mov    %edx,%eax
    4800:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4802:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    4806:	0f 95 c1             	setne  %cl
    4809:	c1 ea 1f             	shr    $0x1f,%edx
    480c:	84 d1                	test   %dl,%cl
    480e:	74 44                	je     4854 <printint+0x62>
    neg = 1;
    x = -xx;
    4810:	f7 d8                	neg    %eax
    4812:	89 c1                	mov    %eax,%ecx
    neg = 1;
    4814:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    481b:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    4820:	89 c8                	mov    %ecx,%eax
    4822:	ba 00 00 00 00       	mov    $0x0,%edx
    4827:	f7 f6                	div    %esi
    4829:	89 df                	mov    %ebx,%edi
    482b:	83 c3 01             	add    $0x1,%ebx
    482e:	0f b6 92 24 63 00 00 	movzbl 0x6324(%edx),%edx
    4835:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    4839:	89 ca                	mov    %ecx,%edx
    483b:	89 c1                	mov    %eax,%ecx
    483d:	39 d6                	cmp    %edx,%esi
    483f:	76 df                	jbe    4820 <printint+0x2e>
  if(neg)
    4841:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    4845:	74 31                	je     4878 <printint+0x86>
    buf[i++] = '-';
    4847:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    484c:	8d 5f 02             	lea    0x2(%edi),%ebx
    484f:	8b 75 d0             	mov    -0x30(%ebp),%esi
    4852:	eb 17                	jmp    486b <printint+0x79>
    x = xx;
    4854:	89 c1                	mov    %eax,%ecx
  neg = 0;
    4856:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    485d:	eb bc                	jmp    481b <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    485f:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    4864:	89 f0                	mov    %esi,%eax
    4866:	e8 6d ff ff ff       	call   47d8 <putc>
  while(--i >= 0)
    486b:	83 eb 01             	sub    $0x1,%ebx
    486e:	79 ef                	jns    485f <printint+0x6d>
}
    4870:	83 c4 2c             	add    $0x2c,%esp
    4873:	5b                   	pop    %ebx
    4874:	5e                   	pop    %esi
    4875:	5f                   	pop    %edi
    4876:	5d                   	pop    %ebp
    4877:	c3                   	ret    
    4878:	8b 75 d0             	mov    -0x30(%ebp),%esi
    487b:	eb ee                	jmp    486b <printint+0x79>

0000487d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    487d:	55                   	push   %ebp
    487e:	89 e5                	mov    %esp,%ebp
    4880:	57                   	push   %edi
    4881:	56                   	push   %esi
    4882:	53                   	push   %ebx
    4883:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    4886:	8d 45 10             	lea    0x10(%ebp),%eax
    4889:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    488c:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    4891:	bb 00 00 00 00       	mov    $0x0,%ebx
    4896:	eb 14                	jmp    48ac <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    4898:	89 fa                	mov    %edi,%edx
    489a:	8b 45 08             	mov    0x8(%ebp),%eax
    489d:	e8 36 ff ff ff       	call   47d8 <putc>
    48a2:	eb 05                	jmp    48a9 <printf+0x2c>
      }
    } else if(state == '%'){
    48a4:	83 fe 25             	cmp    $0x25,%esi
    48a7:	74 25                	je     48ce <printf+0x51>
  for(i = 0; fmt[i]; i++){
    48a9:	83 c3 01             	add    $0x1,%ebx
    48ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    48af:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    48b3:	84 c0                	test   %al,%al
    48b5:	0f 84 20 01 00 00    	je     49db <printf+0x15e>
    c = fmt[i] & 0xff;
    48bb:	0f be f8             	movsbl %al,%edi
    48be:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    48c1:	85 f6                	test   %esi,%esi
    48c3:	75 df                	jne    48a4 <printf+0x27>
      if(c == '%'){
    48c5:	83 f8 25             	cmp    $0x25,%eax
    48c8:	75 ce                	jne    4898 <printf+0x1b>
        state = '%';
    48ca:	89 c6                	mov    %eax,%esi
    48cc:	eb db                	jmp    48a9 <printf+0x2c>
      if(c == 'd'){
    48ce:	83 f8 25             	cmp    $0x25,%eax
    48d1:	0f 84 cf 00 00 00    	je     49a6 <printf+0x129>
    48d7:	0f 8c dd 00 00 00    	jl     49ba <printf+0x13d>
    48dd:	83 f8 78             	cmp    $0x78,%eax
    48e0:	0f 8f d4 00 00 00    	jg     49ba <printf+0x13d>
    48e6:	83 f8 63             	cmp    $0x63,%eax
    48e9:	0f 8c cb 00 00 00    	jl     49ba <printf+0x13d>
    48ef:	83 e8 63             	sub    $0x63,%eax
    48f2:	83 f8 15             	cmp    $0x15,%eax
    48f5:	0f 87 bf 00 00 00    	ja     49ba <printf+0x13d>
    48fb:	ff 24 85 cc 62 00 00 	jmp    *0x62cc(,%eax,4)
        printint(fd, *ap, 10, 1);
    4902:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    4905:	8b 17                	mov    (%edi),%edx
    4907:	83 ec 0c             	sub    $0xc,%esp
    490a:	6a 01                	push   $0x1
    490c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    4911:	8b 45 08             	mov    0x8(%ebp),%eax
    4914:	e8 d9 fe ff ff       	call   47f2 <printint>
        ap++;
    4919:	83 c7 04             	add    $0x4,%edi
    491c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    491f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    4922:	be 00 00 00 00       	mov    $0x0,%esi
    4927:	eb 80                	jmp    48a9 <printf+0x2c>
        printint(fd, *ap, 16, 0);
    4929:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    492c:	8b 17                	mov    (%edi),%edx
    492e:	83 ec 0c             	sub    $0xc,%esp
    4931:	6a 00                	push   $0x0
    4933:	b9 10 00 00 00       	mov    $0x10,%ecx
    4938:	8b 45 08             	mov    0x8(%ebp),%eax
    493b:	e8 b2 fe ff ff       	call   47f2 <printint>
        ap++;
    4940:	83 c7 04             	add    $0x4,%edi
    4943:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    4946:	83 c4 10             	add    $0x10,%esp
      state = 0;
    4949:	be 00 00 00 00       	mov    $0x0,%esi
    494e:	e9 56 ff ff ff       	jmp    48a9 <printf+0x2c>
        s = (char*)*ap;
    4953:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4956:	8b 30                	mov    (%eax),%esi
        ap++;
    4958:	83 c0 04             	add    $0x4,%eax
    495b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    495e:	85 f6                	test   %esi,%esi
    4960:	75 15                	jne    4977 <printf+0xfa>
          s = "(null)";
    4962:	be c2 62 00 00       	mov    $0x62c2,%esi
    4967:	eb 0e                	jmp    4977 <printf+0xfa>
          putc(fd, *s);
    4969:	0f be d2             	movsbl %dl,%edx
    496c:	8b 45 08             	mov    0x8(%ebp),%eax
    496f:	e8 64 fe ff ff       	call   47d8 <putc>
          s++;
    4974:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    4977:	0f b6 16             	movzbl (%esi),%edx
    497a:	84 d2                	test   %dl,%dl
    497c:	75 eb                	jne    4969 <printf+0xec>
      state = 0;
    497e:	be 00 00 00 00       	mov    $0x0,%esi
    4983:	e9 21 ff ff ff       	jmp    48a9 <printf+0x2c>
        putc(fd, *ap);
    4988:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    498b:	0f be 17             	movsbl (%edi),%edx
    498e:	8b 45 08             	mov    0x8(%ebp),%eax
    4991:	e8 42 fe ff ff       	call   47d8 <putc>
        ap++;
    4996:	83 c7 04             	add    $0x4,%edi
    4999:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    499c:	be 00 00 00 00       	mov    $0x0,%esi
    49a1:	e9 03 ff ff ff       	jmp    48a9 <printf+0x2c>
        putc(fd, c);
    49a6:	89 fa                	mov    %edi,%edx
    49a8:	8b 45 08             	mov    0x8(%ebp),%eax
    49ab:	e8 28 fe ff ff       	call   47d8 <putc>
      state = 0;
    49b0:	be 00 00 00 00       	mov    $0x0,%esi
    49b5:	e9 ef fe ff ff       	jmp    48a9 <printf+0x2c>
        putc(fd, '%');
    49ba:	ba 25 00 00 00       	mov    $0x25,%edx
    49bf:	8b 45 08             	mov    0x8(%ebp),%eax
    49c2:	e8 11 fe ff ff       	call   47d8 <putc>
        putc(fd, c);
    49c7:	89 fa                	mov    %edi,%edx
    49c9:	8b 45 08             	mov    0x8(%ebp),%eax
    49cc:	e8 07 fe ff ff       	call   47d8 <putc>
      state = 0;
    49d1:	be 00 00 00 00       	mov    $0x0,%esi
    49d6:	e9 ce fe ff ff       	jmp    48a9 <printf+0x2c>
    }
  }
}
    49db:	8d 65 f4             	lea    -0xc(%ebp),%esp
    49de:	5b                   	pop    %ebx
    49df:	5e                   	pop    %esi
    49e0:	5f                   	pop    %edi
    49e1:	5d                   	pop    %ebp
    49e2:	c3                   	ret    

000049e3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    49e3:	55                   	push   %ebp
    49e4:	89 e5                	mov    %esp,%ebp
    49e6:	57                   	push   %edi
    49e7:	56                   	push   %esi
    49e8:	53                   	push   %ebx
    49e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    49ec:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    49ef:	a1 80 b3 00 00       	mov    0xb380,%eax
    49f4:	eb 02                	jmp    49f8 <free+0x15>
    49f6:	89 d0                	mov    %edx,%eax
    49f8:	39 c8                	cmp    %ecx,%eax
    49fa:	73 04                	jae    4a00 <free+0x1d>
    49fc:	39 08                	cmp    %ecx,(%eax)
    49fe:	77 12                	ja     4a12 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4a00:	8b 10                	mov    (%eax),%edx
    4a02:	39 c2                	cmp    %eax,%edx
    4a04:	77 f0                	ja     49f6 <free+0x13>
    4a06:	39 c8                	cmp    %ecx,%eax
    4a08:	72 08                	jb     4a12 <free+0x2f>
    4a0a:	39 ca                	cmp    %ecx,%edx
    4a0c:	77 04                	ja     4a12 <free+0x2f>
    4a0e:	89 d0                	mov    %edx,%eax
    4a10:	eb e6                	jmp    49f8 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    4a12:	8b 73 fc             	mov    -0x4(%ebx),%esi
    4a15:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    4a18:	8b 10                	mov    (%eax),%edx
    4a1a:	39 d7                	cmp    %edx,%edi
    4a1c:	74 19                	je     4a37 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    4a1e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    4a21:	8b 50 04             	mov    0x4(%eax),%edx
    4a24:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4a27:	39 ce                	cmp    %ecx,%esi
    4a29:	74 1b                	je     4a46 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    4a2b:	89 08                	mov    %ecx,(%eax)
  freep = p;
    4a2d:	a3 80 b3 00 00       	mov    %eax,0xb380
}
    4a32:	5b                   	pop    %ebx
    4a33:	5e                   	pop    %esi
    4a34:	5f                   	pop    %edi
    4a35:	5d                   	pop    %ebp
    4a36:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    4a37:	03 72 04             	add    0x4(%edx),%esi
    4a3a:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4a3d:	8b 10                	mov    (%eax),%edx
    4a3f:	8b 12                	mov    (%edx),%edx
    4a41:	89 53 f8             	mov    %edx,-0x8(%ebx)
    4a44:	eb db                	jmp    4a21 <free+0x3e>
    p->s.size += bp->s.size;
    4a46:	03 53 fc             	add    -0x4(%ebx),%edx
    4a49:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4a4c:	8b 53 f8             	mov    -0x8(%ebx),%edx
    4a4f:	89 10                	mov    %edx,(%eax)
    4a51:	eb da                	jmp    4a2d <free+0x4a>

00004a53 <morecore>:

static Header*
morecore(uint nu)
{
    4a53:	55                   	push   %ebp
    4a54:	89 e5                	mov    %esp,%ebp
    4a56:	53                   	push   %ebx
    4a57:	83 ec 04             	sub    $0x4,%esp
    4a5a:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    4a5c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    4a61:	77 05                	ja     4a68 <morecore+0x15>
    nu = 4096;
    4a63:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    4a68:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    4a6f:	83 ec 0c             	sub    $0xc,%esp
    4a72:	50                   	push   %eax
    4a73:	e8 28 fd ff ff       	call   47a0 <sbrk>
  if(p == (char*)-1)
    4a78:	83 c4 10             	add    $0x10,%esp
    4a7b:	83 f8 ff             	cmp    $0xffffffff,%eax
    4a7e:	74 1c                	je     4a9c <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    4a80:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    4a83:	83 c0 08             	add    $0x8,%eax
    4a86:	83 ec 0c             	sub    $0xc,%esp
    4a89:	50                   	push   %eax
    4a8a:	e8 54 ff ff ff       	call   49e3 <free>
  return freep;
    4a8f:	a1 80 b3 00 00       	mov    0xb380,%eax
    4a94:	83 c4 10             	add    $0x10,%esp
}
    4a97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4a9a:	c9                   	leave  
    4a9b:	c3                   	ret    
    return 0;
    4a9c:	b8 00 00 00 00       	mov    $0x0,%eax
    4aa1:	eb f4                	jmp    4a97 <morecore+0x44>

00004aa3 <malloc>:

void*
malloc(uint nbytes)
{
    4aa3:	55                   	push   %ebp
    4aa4:	89 e5                	mov    %esp,%ebp
    4aa6:	53                   	push   %ebx
    4aa7:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4aaa:	8b 45 08             	mov    0x8(%ebp),%eax
    4aad:	8d 58 07             	lea    0x7(%eax),%ebx
    4ab0:	c1 eb 03             	shr    $0x3,%ebx
    4ab3:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    4ab6:	8b 0d 80 b3 00 00    	mov    0xb380,%ecx
    4abc:	85 c9                	test   %ecx,%ecx
    4abe:	74 04                	je     4ac4 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4ac0:	8b 01                	mov    (%ecx),%eax
    4ac2:	eb 4a                	jmp    4b0e <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    4ac4:	c7 05 80 b3 00 00 84 	movl   $0xb384,0xb380
    4acb:	b3 00 00 
    4ace:	c7 05 84 b3 00 00 84 	movl   $0xb384,0xb384
    4ad5:	b3 00 00 
    base.s.size = 0;
    4ad8:	c7 05 88 b3 00 00 00 	movl   $0x0,0xb388
    4adf:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    4ae2:	b9 84 b3 00 00       	mov    $0xb384,%ecx
    4ae7:	eb d7                	jmp    4ac0 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    4ae9:	74 19                	je     4b04 <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    4aeb:	29 da                	sub    %ebx,%edx
    4aed:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4af0:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    4af3:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    4af6:	89 0d 80 b3 00 00    	mov    %ecx,0xb380
      return (void*)(p + 1);
    4afc:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    4aff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4b02:	c9                   	leave  
    4b03:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    4b04:	8b 10                	mov    (%eax),%edx
    4b06:	89 11                	mov    %edx,(%ecx)
    4b08:	eb ec                	jmp    4af6 <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4b0a:	89 c1                	mov    %eax,%ecx
    4b0c:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    4b0e:	8b 50 04             	mov    0x4(%eax),%edx
    4b11:	39 da                	cmp    %ebx,%edx
    4b13:	73 d4                	jae    4ae9 <malloc+0x46>
    if(p == freep)
    4b15:	39 05 80 b3 00 00    	cmp    %eax,0xb380
    4b1b:	75 ed                	jne    4b0a <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    4b1d:	89 d8                	mov    %ebx,%eax
    4b1f:	e8 2f ff ff ff       	call   4a53 <morecore>
    4b24:	85 c0                	test   %eax,%eax
    4b26:	75 e2                	jne    4b0a <malloc+0x67>
    4b28:	eb d5                	jmp    4aff <malloc+0x5c>
