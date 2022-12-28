
_sh:     file format elf32-i386


Disassembly of section .text:

00001000 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
    1005:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1008:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
    100b:	83 ec 08             	sub    $0x8,%esp
    100e:	68 60 1f 00 00       	push   $0x1f60
    1013:	6a 02                	push   $0x2
    1015:	e8 99 0c 00 00       	call   1cb3 <printf>
  memset(buf, 0, nbuf);
    101a:	83 c4 0c             	add    $0xc,%esp
    101d:	56                   	push   %esi
    101e:	6a 00                	push   $0x0
    1020:	53                   	push   %ebx
    1021:	e8 ed 09 00 00       	call   1a13 <memset>
  gets(buf, nbuf);
    1026:	83 c4 08             	add    $0x8,%esp
    1029:	56                   	push   %esi
    102a:	53                   	push   %ebx
    102b:	e8 1f 0a 00 00       	call   1a4f <gets>
  if(buf[0] == 0) // EOF
    1030:	83 c4 10             	add    $0x10,%esp
    1033:	80 3b 00             	cmpb   $0x0,(%ebx)
    1036:	74 0c                	je     1044 <getcmd+0x44>
    return -1;
  return 0;
    1038:	b8 00 00 00 00       	mov    $0x0,%eax
}
    103d:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1040:	5b                   	pop    %ebx
    1041:	5e                   	pop    %esi
    1042:	5d                   	pop    %ebp
    1043:	c3                   	ret    
    return -1;
    1044:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1049:	eb f2                	jmp    103d <getcmd+0x3d>

0000104b <panic>:
  exit();
}

void
panic(char *s)
{
    104b:	55                   	push   %ebp
    104c:	89 e5                	mov    %esp,%ebp
    104e:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
    1051:	ff 75 08             	push   0x8(%ebp)
    1054:	68 fd 1f 00 00       	push   $0x1ffd
    1059:	6a 02                	push   $0x2
    105b:	e8 53 0c 00 00       	call   1cb3 <printf>
  exit();
    1060:	e8 e9 0a 00 00       	call   1b4e <exit>

00001065 <fork1>:
}

int
fork1(void)
{
    1065:	55                   	push   %ebp
    1066:	89 e5                	mov    %esp,%ebp
    1068:	83 ec 08             	sub    $0x8,%esp
  int pid;

  pid = fork();
    106b:	e8 d6 0a 00 00       	call   1b46 <fork>
  if(pid == -1)
    1070:	83 f8 ff             	cmp    $0xffffffff,%eax
    1073:	74 02                	je     1077 <fork1+0x12>
    panic("fork");
  return pid;
}
    1075:	c9                   	leave  
    1076:	c3                   	ret    
    panic("fork");
    1077:	83 ec 0c             	sub    $0xc,%esp
    107a:	68 63 1f 00 00       	push   $0x1f63
    107f:	e8 c7 ff ff ff       	call   104b <panic>

00001084 <runcmd>:
{
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
    1087:	53                   	push   %ebx
    1088:	83 ec 14             	sub    $0x14,%esp
    108b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
    108e:	85 db                	test   %ebx,%ebx
    1090:	74 0e                	je     10a0 <runcmd+0x1c>
  switch(cmd->type){
    1092:	8b 03                	mov    (%ebx),%eax
    1094:	83 f8 05             	cmp    $0x5,%eax
    1097:	77 0c                	ja     10a5 <runcmd+0x21>
    1099:	ff 24 85 18 20 00 00 	jmp    *0x2018(,%eax,4)
    exit();
    10a0:	e8 a9 0a 00 00       	call   1b4e <exit>
    panic("runcmd");
    10a5:	83 ec 0c             	sub    $0xc,%esp
    10a8:	68 68 1f 00 00       	push   $0x1f68
    10ad:	e8 99 ff ff ff       	call   104b <panic>
    if(ecmd->argv[0] == 0)
    10b2:	8b 43 04             	mov    0x4(%ebx),%eax
    10b5:	85 c0                	test   %eax,%eax
    10b7:	74 27                	je     10e0 <runcmd+0x5c>
    exec(ecmd->argv[0], ecmd->argv);
    10b9:	8d 53 04             	lea    0x4(%ebx),%edx
    10bc:	83 ec 08             	sub    $0x8,%esp
    10bf:	52                   	push   %edx
    10c0:	50                   	push   %eax
    10c1:	e8 c0 0a 00 00       	call   1b86 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    10c6:	83 c4 0c             	add    $0xc,%esp
    10c9:	ff 73 04             	push   0x4(%ebx)
    10cc:	68 6f 1f 00 00       	push   $0x1f6f
    10d1:	6a 02                	push   $0x2
    10d3:	e8 db 0b 00 00       	call   1cb3 <printf>
    break;
    10d8:	83 c4 10             	add    $0x10,%esp
  exit();
    10db:	e8 6e 0a 00 00       	call   1b4e <exit>
      exit();
    10e0:	e8 69 0a 00 00       	call   1b4e <exit>
    close(rcmd->fd);
    10e5:	83 ec 0c             	sub    $0xc,%esp
    10e8:	ff 73 14             	push   0x14(%ebx)
    10eb:	e8 86 0a 00 00       	call   1b76 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
    10f0:	83 c4 08             	add    $0x8,%esp
    10f3:	ff 73 10             	push   0x10(%ebx)
    10f6:	ff 73 08             	push   0x8(%ebx)
    10f9:	e8 90 0a 00 00       	call   1b8e <open>
    10fe:	83 c4 10             	add    $0x10,%esp
    1101:	85 c0                	test   %eax,%eax
    1103:	78 0b                	js     1110 <runcmd+0x8c>
    runcmd(rcmd->cmd);
    1105:	83 ec 0c             	sub    $0xc,%esp
    1108:	ff 73 04             	push   0x4(%ebx)
    110b:	e8 74 ff ff ff       	call   1084 <runcmd>
      printf(2, "open %s failed\n", rcmd->file);
    1110:	83 ec 04             	sub    $0x4,%esp
    1113:	ff 73 08             	push   0x8(%ebx)
    1116:	68 7f 1f 00 00       	push   $0x1f7f
    111b:	6a 02                	push   $0x2
    111d:	e8 91 0b 00 00       	call   1cb3 <printf>
      exit();
    1122:	e8 27 0a 00 00       	call   1b4e <exit>
    if(fork1() == 0)
    1127:	e8 39 ff ff ff       	call   1065 <fork1>
    112c:	85 c0                	test   %eax,%eax
    112e:	74 10                	je     1140 <runcmd+0xbc>
    wait();
    1130:	e8 21 0a 00 00       	call   1b56 <wait>
    runcmd(lcmd->right);
    1135:	83 ec 0c             	sub    $0xc,%esp
    1138:	ff 73 08             	push   0x8(%ebx)
    113b:	e8 44 ff ff ff       	call   1084 <runcmd>
      runcmd(lcmd->left);
    1140:	83 ec 0c             	sub    $0xc,%esp
    1143:	ff 73 04             	push   0x4(%ebx)
    1146:	e8 39 ff ff ff       	call   1084 <runcmd>
    if(pipe(p) < 0)
    114b:	83 ec 0c             	sub    $0xc,%esp
    114e:	8d 45 f0             	lea    -0x10(%ebp),%eax
    1151:	50                   	push   %eax
    1152:	e8 07 0a 00 00       	call   1b5e <pipe>
    1157:	83 c4 10             	add    $0x10,%esp
    115a:	85 c0                	test   %eax,%eax
    115c:	78 3a                	js     1198 <runcmd+0x114>
    if(fork1() == 0){
    115e:	e8 02 ff ff ff       	call   1065 <fork1>
    1163:	85 c0                	test   %eax,%eax
    1165:	74 3e                	je     11a5 <runcmd+0x121>
    if(fork1() == 0){
    1167:	e8 f9 fe ff ff       	call   1065 <fork1>
    116c:	85 c0                	test   %eax,%eax
    116e:	74 6b                	je     11db <runcmd+0x157>
    close(p[0]);
    1170:	83 ec 0c             	sub    $0xc,%esp
    1173:	ff 75 f0             	push   -0x10(%ebp)
    1176:	e8 fb 09 00 00       	call   1b76 <close>
    close(p[1]);
    117b:	83 c4 04             	add    $0x4,%esp
    117e:	ff 75 f4             	push   -0xc(%ebp)
    1181:	e8 f0 09 00 00       	call   1b76 <close>
    wait();
    1186:	e8 cb 09 00 00       	call   1b56 <wait>
    wait();
    118b:	e8 c6 09 00 00       	call   1b56 <wait>
    break;
    1190:	83 c4 10             	add    $0x10,%esp
    1193:	e9 43 ff ff ff       	jmp    10db <runcmd+0x57>
      panic("pipe");
    1198:	83 ec 0c             	sub    $0xc,%esp
    119b:	68 8f 1f 00 00       	push   $0x1f8f
    11a0:	e8 a6 fe ff ff       	call   104b <panic>
      close(1);
    11a5:	83 ec 0c             	sub    $0xc,%esp
    11a8:	6a 01                	push   $0x1
    11aa:	e8 c7 09 00 00       	call   1b76 <close>
      dup(p[1]);
    11af:	83 c4 04             	add    $0x4,%esp
    11b2:	ff 75 f4             	push   -0xc(%ebp)
    11b5:	e8 0c 0a 00 00       	call   1bc6 <dup>
      close(p[0]);
    11ba:	83 c4 04             	add    $0x4,%esp
    11bd:	ff 75 f0             	push   -0x10(%ebp)
    11c0:	e8 b1 09 00 00       	call   1b76 <close>
      close(p[1]);
    11c5:	83 c4 04             	add    $0x4,%esp
    11c8:	ff 75 f4             	push   -0xc(%ebp)
    11cb:	e8 a6 09 00 00       	call   1b76 <close>
      runcmd(pcmd->left);
    11d0:	83 c4 04             	add    $0x4,%esp
    11d3:	ff 73 04             	push   0x4(%ebx)
    11d6:	e8 a9 fe ff ff       	call   1084 <runcmd>
      close(0);
    11db:	83 ec 0c             	sub    $0xc,%esp
    11de:	6a 00                	push   $0x0
    11e0:	e8 91 09 00 00       	call   1b76 <close>
      dup(p[0]);
    11e5:	83 c4 04             	add    $0x4,%esp
    11e8:	ff 75 f0             	push   -0x10(%ebp)
    11eb:	e8 d6 09 00 00       	call   1bc6 <dup>
      close(p[0]);
    11f0:	83 c4 04             	add    $0x4,%esp
    11f3:	ff 75 f0             	push   -0x10(%ebp)
    11f6:	e8 7b 09 00 00       	call   1b76 <close>
      close(p[1]);
    11fb:	83 c4 04             	add    $0x4,%esp
    11fe:	ff 75 f4             	push   -0xc(%ebp)
    1201:	e8 70 09 00 00       	call   1b76 <close>
      runcmd(pcmd->right);
    1206:	83 c4 04             	add    $0x4,%esp
    1209:	ff 73 08             	push   0x8(%ebx)
    120c:	e8 73 fe ff ff       	call   1084 <runcmd>
    if(fork1() == 0)
    1211:	e8 4f fe ff ff       	call   1065 <fork1>
    1216:	85 c0                	test   %eax,%eax
    1218:	0f 85 bd fe ff ff    	jne    10db <runcmd+0x57>
      runcmd(bcmd->cmd);
    121e:	83 ec 0c             	sub    $0xc,%esp
    1221:	ff 73 04             	push   0x4(%ebx)
    1224:	e8 5b fe ff ff       	call   1084 <runcmd>

00001229 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
    1229:	55                   	push   %ebp
    122a:	89 e5                	mov    %esp,%ebp
    122c:	53                   	push   %ebx
    122d:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1230:	6a 54                	push   $0x54
    1232:	e8 a2 0c 00 00       	call   1ed9 <malloc>
    1237:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1239:	83 c4 0c             	add    $0xc,%esp
    123c:	6a 54                	push   $0x54
    123e:	6a 00                	push   $0x0
    1240:	50                   	push   %eax
    1241:	e8 cd 07 00 00       	call   1a13 <memset>
  cmd->type = EXEC;
    1246:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
    124c:	89 d8                	mov    %ebx,%eax
    124e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1251:	c9                   	leave  
    1252:	c3                   	ret    

00001253 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    1253:	55                   	push   %ebp
    1254:	89 e5                	mov    %esp,%ebp
    1256:	53                   	push   %ebx
    1257:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    125a:	6a 18                	push   $0x18
    125c:	e8 78 0c 00 00       	call   1ed9 <malloc>
    1261:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1263:	83 c4 0c             	add    $0xc,%esp
    1266:	6a 18                	push   $0x18
    1268:	6a 00                	push   $0x0
    126a:	50                   	push   %eax
    126b:	e8 a3 07 00 00       	call   1a13 <memset>
  cmd->type = REDIR;
    1270:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
    127c:	8b 45 0c             	mov    0xc(%ebp),%eax
    127f:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
    1282:	8b 45 10             	mov    0x10(%ebp),%eax
    1285:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
    1288:	8b 45 14             	mov    0x14(%ebp),%eax
    128b:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
    128e:	8b 45 18             	mov    0x18(%ebp),%eax
    1291:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
    1294:	89 d8                	mov    %ebx,%eax
    1296:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1299:	c9                   	leave  
    129a:	c3                   	ret    

0000129b <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    129b:	55                   	push   %ebp
    129c:	89 e5                	mov    %esp,%ebp
    129e:	53                   	push   %ebx
    129f:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    12a2:	6a 0c                	push   $0xc
    12a4:	e8 30 0c 00 00       	call   1ed9 <malloc>
    12a9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    12ab:	83 c4 0c             	add    $0xc,%esp
    12ae:	6a 0c                	push   $0xc
    12b0:	6a 00                	push   $0x0
    12b2:	50                   	push   %eax
    12b3:	e8 5b 07 00 00       	call   1a13 <memset>
  cmd->type = PIPE;
    12b8:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
    12c1:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
    12c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c7:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
    12ca:	89 d8                	mov    %ebx,%eax
    12cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12cf:	c9                   	leave  
    12d0:	c3                   	ret    

000012d1 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    12d1:	55                   	push   %ebp
    12d2:	89 e5                	mov    %esp,%ebp
    12d4:	53                   	push   %ebx
    12d5:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    12d8:	6a 0c                	push   $0xc
    12da:	e8 fa 0b 00 00       	call   1ed9 <malloc>
    12df:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    12e1:	83 c4 0c             	add    $0xc,%esp
    12e4:	6a 0c                	push   $0xc
    12e6:	6a 00                	push   $0x0
    12e8:	50                   	push   %eax
    12e9:	e8 25 07 00 00       	call   1a13 <memset>
  cmd->type = LIST;
    12ee:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
    12f4:	8b 45 08             	mov    0x8(%ebp),%eax
    12f7:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
    12fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    12fd:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
    1300:	89 d8                	mov    %ebx,%eax
    1302:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1305:	c9                   	leave  
    1306:	c3                   	ret    

00001307 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
    1307:	55                   	push   %ebp
    1308:	89 e5                	mov    %esp,%ebp
    130a:	53                   	push   %ebx
    130b:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    130e:	6a 08                	push   $0x8
    1310:	e8 c4 0b 00 00       	call   1ed9 <malloc>
    1315:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1317:	83 c4 0c             	add    $0xc,%esp
    131a:	6a 08                	push   $0x8
    131c:	6a 00                	push   $0x0
    131e:	50                   	push   %eax
    131f:	e8 ef 06 00 00       	call   1a13 <memset>
  cmd->type = BACK;
    1324:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
    132a:	8b 45 08             	mov    0x8(%ebp),%eax
    132d:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
    1330:	89 d8                	mov    %ebx,%eax
    1332:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1335:	c9                   	leave  
    1336:	c3                   	ret    

00001337 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    1337:	55                   	push   %ebp
    1338:	89 e5                	mov    %esp,%ebp
    133a:	57                   	push   %edi
    133b:	56                   	push   %esi
    133c:	53                   	push   %ebx
    133d:	83 ec 0c             	sub    $0xc,%esp
    1340:	8b 75 0c             	mov    0xc(%ebp),%esi
    1343:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *s;
  int ret;

  s = *ps;
    1346:	8b 45 08             	mov    0x8(%ebp),%eax
    1349:	8b 18                	mov    (%eax),%ebx
  while(s < es && strchr(whitespace, *s))
    134b:	eb 03                	jmp    1350 <gettoken+0x19>
    s++;
    134d:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
    1350:	39 f3                	cmp    %esi,%ebx
    1352:	73 18                	jae    136c <gettoken+0x35>
    1354:	83 ec 08             	sub    $0x8,%esp
    1357:	0f be 03             	movsbl (%ebx),%eax
    135a:	50                   	push   %eax
    135b:	68 28 26 00 00       	push   $0x2628
    1360:	e8 c7 06 00 00       	call   1a2c <strchr>
    1365:	83 c4 10             	add    $0x10,%esp
    1368:	85 c0                	test   %eax,%eax
    136a:	75 e1                	jne    134d <gettoken+0x16>
  if(q)
    136c:	85 ff                	test   %edi,%edi
    136e:	74 02                	je     1372 <gettoken+0x3b>
    *q = s;
    1370:	89 1f                	mov    %ebx,(%edi)
  ret = *s;
    1372:	0f b6 03             	movzbl (%ebx),%eax
    1375:	0f be f8             	movsbl %al,%edi
  switch(*s){
    1378:	3c 3c                	cmp    $0x3c,%al
    137a:	7f 27                	jg     13a3 <gettoken+0x6c>
    137c:	3c 3b                	cmp    $0x3b,%al
    137e:	7d 13                	jge    1393 <gettoken+0x5c>
    1380:	84 c0                	test   %al,%al
    1382:	74 12                	je     1396 <gettoken+0x5f>
    1384:	78 41                	js     13c7 <gettoken+0x90>
    1386:	3c 26                	cmp    $0x26,%al
    1388:	74 09                	je     1393 <gettoken+0x5c>
    138a:	7c 3b                	jl     13c7 <gettoken+0x90>
    138c:	83 e8 28             	sub    $0x28,%eax
    138f:	3c 01                	cmp    $0x1,%al
    1391:	77 34                	ja     13c7 <gettoken+0x90>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    1393:	83 c3 01             	add    $0x1,%ebx
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    1396:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    139a:	74 77                	je     1413 <gettoken+0xdc>
    *eq = s;
    139c:	8b 45 14             	mov    0x14(%ebp),%eax
    139f:	89 18                	mov    %ebx,(%eax)
    13a1:	eb 70                	jmp    1413 <gettoken+0xdc>
  switch(*s){
    13a3:	3c 3e                	cmp    $0x3e,%al
    13a5:	75 0d                	jne    13b4 <gettoken+0x7d>
    s++;
    13a7:	8d 43 01             	lea    0x1(%ebx),%eax
    if(*s == '>'){
    13aa:	80 7b 01 3e          	cmpb   $0x3e,0x1(%ebx)
    13ae:	74 0a                	je     13ba <gettoken+0x83>
    s++;
    13b0:	89 c3                	mov    %eax,%ebx
    13b2:	eb e2                	jmp    1396 <gettoken+0x5f>
  switch(*s){
    13b4:	3c 7c                	cmp    $0x7c,%al
    13b6:	75 0f                	jne    13c7 <gettoken+0x90>
    13b8:	eb d9                	jmp    1393 <gettoken+0x5c>
      s++;
    13ba:	83 c3 02             	add    $0x2,%ebx
      ret = '+';
    13bd:	bf 2b 00 00 00       	mov    $0x2b,%edi
    13c2:	eb d2                	jmp    1396 <gettoken+0x5f>
      s++;
    13c4:	83 c3 01             	add    $0x1,%ebx
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    13c7:	39 f3                	cmp    %esi,%ebx
    13c9:	73 37                	jae    1402 <gettoken+0xcb>
    13cb:	83 ec 08             	sub    $0x8,%esp
    13ce:	0f be 03             	movsbl (%ebx),%eax
    13d1:	50                   	push   %eax
    13d2:	68 28 26 00 00       	push   $0x2628
    13d7:	e8 50 06 00 00       	call   1a2c <strchr>
    13dc:	83 c4 10             	add    $0x10,%esp
    13df:	85 c0                	test   %eax,%eax
    13e1:	75 26                	jne    1409 <gettoken+0xd2>
    13e3:	83 ec 08             	sub    $0x8,%esp
    13e6:	0f be 03             	movsbl (%ebx),%eax
    13e9:	50                   	push   %eax
    13ea:	68 20 26 00 00       	push   $0x2620
    13ef:	e8 38 06 00 00       	call   1a2c <strchr>
    13f4:	83 c4 10             	add    $0x10,%esp
    13f7:	85 c0                	test   %eax,%eax
    13f9:	74 c9                	je     13c4 <gettoken+0x8d>
    ret = 'a';
    13fb:	bf 61 00 00 00       	mov    $0x61,%edi
    1400:	eb 94                	jmp    1396 <gettoken+0x5f>
    1402:	bf 61 00 00 00       	mov    $0x61,%edi
    1407:	eb 8d                	jmp    1396 <gettoken+0x5f>
    1409:	bf 61 00 00 00       	mov    $0x61,%edi
    140e:	eb 86                	jmp    1396 <gettoken+0x5f>

  while(s < es && strchr(whitespace, *s))
    s++;
    1410:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
    1413:	39 f3                	cmp    %esi,%ebx
    1415:	73 18                	jae    142f <gettoken+0xf8>
    1417:	83 ec 08             	sub    $0x8,%esp
    141a:	0f be 03             	movsbl (%ebx),%eax
    141d:	50                   	push   %eax
    141e:	68 28 26 00 00       	push   $0x2628
    1423:	e8 04 06 00 00       	call   1a2c <strchr>
    1428:	83 c4 10             	add    $0x10,%esp
    142b:	85 c0                	test   %eax,%eax
    142d:	75 e1                	jne    1410 <gettoken+0xd9>
  *ps = s;
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	89 18                	mov    %ebx,(%eax)
  return ret;
}
    1434:	89 f8                	mov    %edi,%eax
    1436:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1439:	5b                   	pop    %ebx
    143a:	5e                   	pop    %esi
    143b:	5f                   	pop    %edi
    143c:	5d                   	pop    %ebp
    143d:	c3                   	ret    

0000143e <peek>:

int
peek(char **ps, char *es, char *toks)
{
    143e:	55                   	push   %ebp
    143f:	89 e5                	mov    %esp,%ebp
    1441:	57                   	push   %edi
    1442:	56                   	push   %esi
    1443:	53                   	push   %ebx
    1444:	83 ec 0c             	sub    $0xc,%esp
    1447:	8b 7d 08             	mov    0x8(%ebp),%edi
    144a:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
    144d:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
    144f:	eb 03                	jmp    1454 <peek+0x16>
    s++;
    1451:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
    1454:	39 f3                	cmp    %esi,%ebx
    1456:	73 18                	jae    1470 <peek+0x32>
    1458:	83 ec 08             	sub    $0x8,%esp
    145b:	0f be 03             	movsbl (%ebx),%eax
    145e:	50                   	push   %eax
    145f:	68 28 26 00 00       	push   $0x2628
    1464:	e8 c3 05 00 00       	call   1a2c <strchr>
    1469:	83 c4 10             	add    $0x10,%esp
    146c:	85 c0                	test   %eax,%eax
    146e:	75 e1                	jne    1451 <peek+0x13>
  *ps = s;
    1470:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
    1472:	0f b6 03             	movzbl (%ebx),%eax
    1475:	84 c0                	test   %al,%al
    1477:	75 0d                	jne    1486 <peek+0x48>
    1479:	b8 00 00 00 00       	mov    $0x0,%eax
}
    147e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1481:	5b                   	pop    %ebx
    1482:	5e                   	pop    %esi
    1483:	5f                   	pop    %edi
    1484:	5d                   	pop    %ebp
    1485:	c3                   	ret    
  return *s && strchr(toks, *s);
    1486:	83 ec 08             	sub    $0x8,%esp
    1489:	0f be c0             	movsbl %al,%eax
    148c:	50                   	push   %eax
    148d:	ff 75 10             	push   0x10(%ebp)
    1490:	e8 97 05 00 00       	call   1a2c <strchr>
    1495:	83 c4 10             	add    $0x10,%esp
    1498:	85 c0                	test   %eax,%eax
    149a:	74 07                	je     14a3 <peek+0x65>
    149c:	b8 01 00 00 00       	mov    $0x1,%eax
    14a1:	eb db                	jmp    147e <peek+0x40>
    14a3:	b8 00 00 00 00       	mov    $0x0,%eax
    14a8:	eb d4                	jmp    147e <peek+0x40>

000014aa <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    14aa:	55                   	push   %ebp
    14ab:	89 e5                	mov    %esp,%ebp
    14ad:	57                   	push   %edi
    14ae:	56                   	push   %esi
    14af:	53                   	push   %ebx
    14b0:	83 ec 1c             	sub    $0x1c,%esp
    14b3:	8b 7d 0c             	mov    0xc(%ebp),%edi
    14b6:	8b 75 10             	mov    0x10(%ebp),%esi
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    14b9:	eb 28                	jmp    14e3 <parseredirs+0x39>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    14bb:	83 ec 0c             	sub    $0xc,%esp
    14be:	68 94 1f 00 00       	push   $0x1f94
    14c3:	e8 83 fb ff ff       	call   104b <panic>
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    14c8:	83 ec 0c             	sub    $0xc,%esp
    14cb:	6a 00                	push   $0x0
    14cd:	6a 00                	push   $0x0
    14cf:	ff 75 e0             	push   -0x20(%ebp)
    14d2:	ff 75 e4             	push   -0x1c(%ebp)
    14d5:	ff 75 08             	push   0x8(%ebp)
    14d8:	e8 76 fd ff ff       	call   1253 <redircmd>
    14dd:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    14e0:	83 c4 20             	add    $0x20,%esp
  while(peek(ps, es, "<>")){
    14e3:	83 ec 04             	sub    $0x4,%esp
    14e6:	68 b1 1f 00 00       	push   $0x1fb1
    14eb:	56                   	push   %esi
    14ec:	57                   	push   %edi
    14ed:	e8 4c ff ff ff       	call   143e <peek>
    14f2:	83 c4 10             	add    $0x10,%esp
    14f5:	85 c0                	test   %eax,%eax
    14f7:	74 76                	je     156f <parseredirs+0xc5>
    tok = gettoken(ps, es, 0, 0);
    14f9:	6a 00                	push   $0x0
    14fb:	6a 00                	push   $0x0
    14fd:	56                   	push   %esi
    14fe:	57                   	push   %edi
    14ff:	e8 33 fe ff ff       	call   1337 <gettoken>
    1504:	89 c3                	mov    %eax,%ebx
    if(gettoken(ps, es, &q, &eq) != 'a')
    1506:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1509:	50                   	push   %eax
    150a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    150d:	50                   	push   %eax
    150e:	56                   	push   %esi
    150f:	57                   	push   %edi
    1510:	e8 22 fe ff ff       	call   1337 <gettoken>
    1515:	83 c4 20             	add    $0x20,%esp
    1518:	83 f8 61             	cmp    $0x61,%eax
    151b:	75 9e                	jne    14bb <parseredirs+0x11>
    switch(tok){
    151d:	83 fb 3c             	cmp    $0x3c,%ebx
    1520:	74 a6                	je     14c8 <parseredirs+0x1e>
    1522:	83 fb 3e             	cmp    $0x3e,%ebx
    1525:	74 25                	je     154c <parseredirs+0xa2>
    1527:	83 fb 2b             	cmp    $0x2b,%ebx
    152a:	75 b7                	jne    14e3 <parseredirs+0x39>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    152c:	83 ec 0c             	sub    $0xc,%esp
    152f:	6a 01                	push   $0x1
    1531:	68 01 02 00 00       	push   $0x201
    1536:	ff 75 e0             	push   -0x20(%ebp)
    1539:	ff 75 e4             	push   -0x1c(%ebp)
    153c:	ff 75 08             	push   0x8(%ebp)
    153f:	e8 0f fd ff ff       	call   1253 <redircmd>
    1544:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1547:	83 c4 20             	add    $0x20,%esp
    154a:	eb 97                	jmp    14e3 <parseredirs+0x39>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    154c:	83 ec 0c             	sub    $0xc,%esp
    154f:	6a 01                	push   $0x1
    1551:	68 01 02 00 00       	push   $0x201
    1556:	ff 75 e0             	push   -0x20(%ebp)
    1559:	ff 75 e4             	push   -0x1c(%ebp)
    155c:	ff 75 08             	push   0x8(%ebp)
    155f:	e8 ef fc ff ff       	call   1253 <redircmd>
    1564:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1567:	83 c4 20             	add    $0x20,%esp
    156a:	e9 74 ff ff ff       	jmp    14e3 <parseredirs+0x39>
    }
  }
  return cmd;
}
    156f:	8b 45 08             	mov    0x8(%ebp),%eax
    1572:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1575:	5b                   	pop    %ebx
    1576:	5e                   	pop    %esi
    1577:	5f                   	pop    %edi
    1578:	5d                   	pop    %ebp
    1579:	c3                   	ret    

0000157a <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
    157a:	55                   	push   %ebp
    157b:	89 e5                	mov    %esp,%ebp
    157d:	57                   	push   %edi
    157e:	56                   	push   %esi
    157f:	53                   	push   %ebx
    1580:	83 ec 30             	sub    $0x30,%esp
    1583:	8b 75 08             	mov    0x8(%ebp),%esi
    1586:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    1589:	68 b4 1f 00 00       	push   $0x1fb4
    158e:	57                   	push   %edi
    158f:	56                   	push   %esi
    1590:	e8 a9 fe ff ff       	call   143e <peek>
    1595:	83 c4 10             	add    $0x10,%esp
    1598:	85 c0                	test   %eax,%eax
    159a:	75 1d                	jne    15b9 <parseexec+0x3f>
    159c:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
    159e:	e8 86 fc ff ff       	call   1229 <execcmd>
    15a3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
    15a6:	83 ec 04             	sub    $0x4,%esp
    15a9:	57                   	push   %edi
    15aa:	56                   	push   %esi
    15ab:	50                   	push   %eax
    15ac:	e8 f9 fe ff ff       	call   14aa <parseredirs>
    15b1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
    15b4:	83 c4 10             	add    $0x10,%esp
    15b7:	eb 3b                	jmp    15f4 <parseexec+0x7a>
    return parseblock(ps, es);
    15b9:	83 ec 08             	sub    $0x8,%esp
    15bc:	57                   	push   %edi
    15bd:	56                   	push   %esi
    15be:	e8 8f 01 00 00       	call   1752 <parseblock>
    15c3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15c6:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
    15c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15cf:	5b                   	pop    %ebx
    15d0:	5e                   	pop    %esi
    15d1:	5f                   	pop    %edi
    15d2:	5d                   	pop    %ebp
    15d3:	c3                   	ret    
      panic("syntax");
    15d4:	83 ec 0c             	sub    $0xc,%esp
    15d7:	68 b6 1f 00 00       	push   $0x1fb6
    15dc:	e8 6a fa ff ff       	call   104b <panic>
    ret = parseredirs(ret, ps, es);
    15e1:	83 ec 04             	sub    $0x4,%esp
    15e4:	57                   	push   %edi
    15e5:	56                   	push   %esi
    15e6:	ff 75 d4             	push   -0x2c(%ebp)
    15e9:	e8 bc fe ff ff       	call   14aa <parseredirs>
    15ee:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15f1:	83 c4 10             	add    $0x10,%esp
  while(!peek(ps, es, "|)&;")){
    15f4:	83 ec 04             	sub    $0x4,%esp
    15f7:	68 cb 1f 00 00       	push   $0x1fcb
    15fc:	57                   	push   %edi
    15fd:	56                   	push   %esi
    15fe:	e8 3b fe ff ff       	call   143e <peek>
    1603:	83 c4 10             	add    $0x10,%esp
    1606:	85 c0                	test   %eax,%eax
    1608:	75 41                	jne    164b <parseexec+0xd1>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    160a:	8d 45 e0             	lea    -0x20(%ebp),%eax
    160d:	50                   	push   %eax
    160e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1611:	50                   	push   %eax
    1612:	57                   	push   %edi
    1613:	56                   	push   %esi
    1614:	e8 1e fd ff ff       	call   1337 <gettoken>
    1619:	83 c4 10             	add    $0x10,%esp
    161c:	85 c0                	test   %eax,%eax
    161e:	74 2b                	je     164b <parseexec+0xd1>
    if(tok != 'a')
    1620:	83 f8 61             	cmp    $0x61,%eax
    1623:	75 af                	jne    15d4 <parseexec+0x5a>
    cmd->argv[argc] = q;
    1625:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1628:	8b 55 d0             	mov    -0x30(%ebp),%edx
    162b:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
    162f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1632:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
    1636:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
    1639:	83 fb 09             	cmp    $0x9,%ebx
    163c:	7e a3                	jle    15e1 <parseexec+0x67>
      panic("too many args");
    163e:	83 ec 0c             	sub    $0xc,%esp
    1641:	68 bd 1f 00 00       	push   $0x1fbd
    1646:	e8 00 fa ff ff       	call   104b <panic>
  cmd->argv[argc] = 0;
    164b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    164e:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
    1655:	00 
  cmd->eargv[argc] = 0;
    1656:	c7 44 98 2c 00 00 00 	movl   $0x0,0x2c(%eax,%ebx,4)
    165d:	00 
  return ret;
    165e:	e9 66 ff ff ff       	jmp    15c9 <parseexec+0x4f>

00001663 <parsepipe>:
{
    1663:	55                   	push   %ebp
    1664:	89 e5                	mov    %esp,%ebp
    1666:	57                   	push   %edi
    1667:	56                   	push   %esi
    1668:	53                   	push   %ebx
    1669:	83 ec 14             	sub    $0x14,%esp
    166c:	8b 75 08             	mov    0x8(%ebp),%esi
    166f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
    1672:	57                   	push   %edi
    1673:	56                   	push   %esi
    1674:	e8 01 ff ff ff       	call   157a <parseexec>
    1679:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
    167b:	83 c4 0c             	add    $0xc,%esp
    167e:	68 d0 1f 00 00       	push   $0x1fd0
    1683:	57                   	push   %edi
    1684:	56                   	push   %esi
    1685:	e8 b4 fd ff ff       	call   143e <peek>
    168a:	83 c4 10             	add    $0x10,%esp
    168d:	85 c0                	test   %eax,%eax
    168f:	75 0a                	jne    169b <parsepipe+0x38>
}
    1691:	89 d8                	mov    %ebx,%eax
    1693:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1696:	5b                   	pop    %ebx
    1697:	5e                   	pop    %esi
    1698:	5f                   	pop    %edi
    1699:	5d                   	pop    %ebp
    169a:	c3                   	ret    
    gettoken(ps, es, 0, 0);
    169b:	6a 00                	push   $0x0
    169d:	6a 00                	push   $0x0
    169f:	57                   	push   %edi
    16a0:	56                   	push   %esi
    16a1:	e8 91 fc ff ff       	call   1337 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
    16a6:	83 c4 08             	add    $0x8,%esp
    16a9:	57                   	push   %edi
    16aa:	56                   	push   %esi
    16ab:	e8 b3 ff ff ff       	call   1663 <parsepipe>
    16b0:	83 c4 08             	add    $0x8,%esp
    16b3:	50                   	push   %eax
    16b4:	53                   	push   %ebx
    16b5:	e8 e1 fb ff ff       	call   129b <pipecmd>
    16ba:	89 c3                	mov    %eax,%ebx
    16bc:	83 c4 10             	add    $0x10,%esp
  return cmd;
    16bf:	eb d0                	jmp    1691 <parsepipe+0x2e>

000016c1 <parseline>:
{
    16c1:	55                   	push   %ebp
    16c2:	89 e5                	mov    %esp,%ebp
    16c4:	57                   	push   %edi
    16c5:	56                   	push   %esi
    16c6:	53                   	push   %ebx
    16c7:	83 ec 14             	sub    $0x14,%esp
    16ca:	8b 75 08             	mov    0x8(%ebp),%esi
    16cd:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
    16d0:	57                   	push   %edi
    16d1:	56                   	push   %esi
    16d2:	e8 8c ff ff ff       	call   1663 <parsepipe>
    16d7:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
    16d9:	83 c4 10             	add    $0x10,%esp
    16dc:	eb 18                	jmp    16f6 <parseline+0x35>
    gettoken(ps, es, 0, 0);
    16de:	6a 00                	push   $0x0
    16e0:	6a 00                	push   $0x0
    16e2:	57                   	push   %edi
    16e3:	56                   	push   %esi
    16e4:	e8 4e fc ff ff       	call   1337 <gettoken>
    cmd = backcmd(cmd);
    16e9:	89 1c 24             	mov    %ebx,(%esp)
    16ec:	e8 16 fc ff ff       	call   1307 <backcmd>
    16f1:	89 c3                	mov    %eax,%ebx
    16f3:	83 c4 10             	add    $0x10,%esp
  while(peek(ps, es, "&")){
    16f6:	83 ec 04             	sub    $0x4,%esp
    16f9:	68 d2 1f 00 00       	push   $0x1fd2
    16fe:	57                   	push   %edi
    16ff:	56                   	push   %esi
    1700:	e8 39 fd ff ff       	call   143e <peek>
    1705:	83 c4 10             	add    $0x10,%esp
    1708:	85 c0                	test   %eax,%eax
    170a:	75 d2                	jne    16de <parseline+0x1d>
  if(peek(ps, es, ";")){
    170c:	83 ec 04             	sub    $0x4,%esp
    170f:	68 ce 1f 00 00       	push   $0x1fce
    1714:	57                   	push   %edi
    1715:	56                   	push   %esi
    1716:	e8 23 fd ff ff       	call   143e <peek>
    171b:	83 c4 10             	add    $0x10,%esp
    171e:	85 c0                	test   %eax,%eax
    1720:	75 0a                	jne    172c <parseline+0x6b>
}
    1722:	89 d8                	mov    %ebx,%eax
    1724:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1727:	5b                   	pop    %ebx
    1728:	5e                   	pop    %esi
    1729:	5f                   	pop    %edi
    172a:	5d                   	pop    %ebp
    172b:	c3                   	ret    
    gettoken(ps, es, 0, 0);
    172c:	6a 00                	push   $0x0
    172e:	6a 00                	push   $0x0
    1730:	57                   	push   %edi
    1731:	56                   	push   %esi
    1732:	e8 00 fc ff ff       	call   1337 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
    1737:	83 c4 08             	add    $0x8,%esp
    173a:	57                   	push   %edi
    173b:	56                   	push   %esi
    173c:	e8 80 ff ff ff       	call   16c1 <parseline>
    1741:	83 c4 08             	add    $0x8,%esp
    1744:	50                   	push   %eax
    1745:	53                   	push   %ebx
    1746:	e8 86 fb ff ff       	call   12d1 <listcmd>
    174b:	89 c3                	mov    %eax,%ebx
    174d:	83 c4 10             	add    $0x10,%esp
  return cmd;
    1750:	eb d0                	jmp    1722 <parseline+0x61>

00001752 <parseblock>:
{
    1752:	55                   	push   %ebp
    1753:	89 e5                	mov    %esp,%ebp
    1755:	57                   	push   %edi
    1756:	56                   	push   %esi
    1757:	53                   	push   %ebx
    1758:	83 ec 10             	sub    $0x10,%esp
    175b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    175e:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
    1761:	68 b4 1f 00 00       	push   $0x1fb4
    1766:	56                   	push   %esi
    1767:	53                   	push   %ebx
    1768:	e8 d1 fc ff ff       	call   143e <peek>
    176d:	83 c4 10             	add    $0x10,%esp
    1770:	85 c0                	test   %eax,%eax
    1772:	74 4b                	je     17bf <parseblock+0x6d>
  gettoken(ps, es, 0, 0);
    1774:	6a 00                	push   $0x0
    1776:	6a 00                	push   $0x0
    1778:	56                   	push   %esi
    1779:	53                   	push   %ebx
    177a:	e8 b8 fb ff ff       	call   1337 <gettoken>
  cmd = parseline(ps, es);
    177f:	83 c4 08             	add    $0x8,%esp
    1782:	56                   	push   %esi
    1783:	53                   	push   %ebx
    1784:	e8 38 ff ff ff       	call   16c1 <parseline>
    1789:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
    178b:	83 c4 0c             	add    $0xc,%esp
    178e:	68 f0 1f 00 00       	push   $0x1ff0
    1793:	56                   	push   %esi
    1794:	53                   	push   %ebx
    1795:	e8 a4 fc ff ff       	call   143e <peek>
    179a:	83 c4 10             	add    $0x10,%esp
    179d:	85 c0                	test   %eax,%eax
    179f:	74 2b                	je     17cc <parseblock+0x7a>
  gettoken(ps, es, 0, 0);
    17a1:	6a 00                	push   $0x0
    17a3:	6a 00                	push   $0x0
    17a5:	56                   	push   %esi
    17a6:	53                   	push   %ebx
    17a7:	e8 8b fb ff ff       	call   1337 <gettoken>
  cmd = parseredirs(cmd, ps, es);
    17ac:	83 c4 0c             	add    $0xc,%esp
    17af:	56                   	push   %esi
    17b0:	53                   	push   %ebx
    17b1:	57                   	push   %edi
    17b2:	e8 f3 fc ff ff       	call   14aa <parseredirs>
}
    17b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17ba:	5b                   	pop    %ebx
    17bb:	5e                   	pop    %esi
    17bc:	5f                   	pop    %edi
    17bd:	5d                   	pop    %ebp
    17be:	c3                   	ret    
    panic("parseblock");
    17bf:	83 ec 0c             	sub    $0xc,%esp
    17c2:	68 d4 1f 00 00       	push   $0x1fd4
    17c7:	e8 7f f8 ff ff       	call   104b <panic>
    panic("syntax - missing )");
    17cc:	83 ec 0c             	sub    $0xc,%esp
    17cf:	68 df 1f 00 00       	push   $0x1fdf
    17d4:	e8 72 f8 ff ff       	call   104b <panic>

000017d9 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    17d9:	55                   	push   %ebp
    17da:	89 e5                	mov    %esp,%ebp
    17dc:	53                   	push   %ebx
    17dd:	83 ec 04             	sub    $0x4,%esp
    17e0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    17e3:	85 db                	test   %ebx,%ebx
    17e5:	74 1f                	je     1806 <nulterminate+0x2d>
    return 0;

  switch(cmd->type){
    17e7:	8b 03                	mov    (%ebx),%eax
    17e9:	83 f8 05             	cmp    $0x5,%eax
    17ec:	77 18                	ja     1806 <nulterminate+0x2d>
    17ee:	ff 24 85 30 20 00 00 	jmp    *0x2030(,%eax,4)
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    17f5:	8b 54 83 2c          	mov    0x2c(%ebx,%eax,4),%edx
    17f9:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
    17fc:	83 c0 01             	add    $0x1,%eax
    17ff:	83 7c 83 04 00       	cmpl   $0x0,0x4(%ebx,%eax,4)
    1804:	75 ef                	jne    17f5 <nulterminate+0x1c>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    1806:	89 d8                	mov    %ebx,%eax
    1808:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    180b:	c9                   	leave  
    180c:	c3                   	ret    
  switch(cmd->type){
    180d:	b8 00 00 00 00       	mov    $0x0,%eax
    1812:	eb eb                	jmp    17ff <nulterminate+0x26>
    nulterminate(rcmd->cmd);
    1814:	83 ec 0c             	sub    $0xc,%esp
    1817:	ff 73 04             	push   0x4(%ebx)
    181a:	e8 ba ff ff ff       	call   17d9 <nulterminate>
    *rcmd->efile = 0;
    181f:	8b 43 0c             	mov    0xc(%ebx),%eax
    1822:	c6 00 00             	movb   $0x0,(%eax)
    break;
    1825:	83 c4 10             	add    $0x10,%esp
    1828:	eb dc                	jmp    1806 <nulterminate+0x2d>
    nulterminate(pcmd->left);
    182a:	83 ec 0c             	sub    $0xc,%esp
    182d:	ff 73 04             	push   0x4(%ebx)
    1830:	e8 a4 ff ff ff       	call   17d9 <nulterminate>
    nulterminate(pcmd->right);
    1835:	83 c4 04             	add    $0x4,%esp
    1838:	ff 73 08             	push   0x8(%ebx)
    183b:	e8 99 ff ff ff       	call   17d9 <nulterminate>
    break;
    1840:	83 c4 10             	add    $0x10,%esp
    1843:	eb c1                	jmp    1806 <nulterminate+0x2d>
    nulterminate(lcmd->left);
    1845:	83 ec 0c             	sub    $0xc,%esp
    1848:	ff 73 04             	push   0x4(%ebx)
    184b:	e8 89 ff ff ff       	call   17d9 <nulterminate>
    nulterminate(lcmd->right);
    1850:	83 c4 04             	add    $0x4,%esp
    1853:	ff 73 08             	push   0x8(%ebx)
    1856:	e8 7e ff ff ff       	call   17d9 <nulterminate>
    break;
    185b:	83 c4 10             	add    $0x10,%esp
    185e:	eb a6                	jmp    1806 <nulterminate+0x2d>
    nulterminate(bcmd->cmd);
    1860:	83 ec 0c             	sub    $0xc,%esp
    1863:	ff 73 04             	push   0x4(%ebx)
    1866:	e8 6e ff ff ff       	call   17d9 <nulterminate>
    break;
    186b:	83 c4 10             	add    $0x10,%esp
    186e:	eb 96                	jmp    1806 <nulterminate+0x2d>

00001870 <parsecmd>:
{
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	56                   	push   %esi
    1874:	53                   	push   %ebx
  es = s + strlen(s);
    1875:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1878:	83 ec 0c             	sub    $0xc,%esp
    187b:	53                   	push   %ebx
    187c:	e8 7a 01 00 00       	call   19fb <strlen>
    1881:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
    1883:	83 c4 08             	add    $0x8,%esp
    1886:	53                   	push   %ebx
    1887:	8d 45 08             	lea    0x8(%ebp),%eax
    188a:	50                   	push   %eax
    188b:	e8 31 fe ff ff       	call   16c1 <parseline>
    1890:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
    1892:	83 c4 0c             	add    $0xc,%esp
    1895:	68 7e 1f 00 00       	push   $0x1f7e
    189a:	53                   	push   %ebx
    189b:	8d 45 08             	lea    0x8(%ebp),%eax
    189e:	50                   	push   %eax
    189f:	e8 9a fb ff ff       	call   143e <peek>
  if(s != es){
    18a4:	8b 45 08             	mov    0x8(%ebp),%eax
    18a7:	83 c4 10             	add    $0x10,%esp
    18aa:	39 d8                	cmp    %ebx,%eax
    18ac:	75 12                	jne    18c0 <parsecmd+0x50>
  nulterminate(cmd);
    18ae:	83 ec 0c             	sub    $0xc,%esp
    18b1:	56                   	push   %esi
    18b2:	e8 22 ff ff ff       	call   17d9 <nulterminate>
}
    18b7:	89 f0                	mov    %esi,%eax
    18b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
    18bc:	5b                   	pop    %ebx
    18bd:	5e                   	pop    %esi
    18be:	5d                   	pop    %ebp
    18bf:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
    18c0:	83 ec 04             	sub    $0x4,%esp
    18c3:	50                   	push   %eax
    18c4:	68 f2 1f 00 00       	push   $0x1ff2
    18c9:	6a 02                	push   $0x2
    18cb:	e8 e3 03 00 00       	call   1cb3 <printf>
    panic("syntax");
    18d0:	c7 04 24 b6 1f 00 00 	movl   $0x1fb6,(%esp)
    18d7:	e8 6f f7 ff ff       	call   104b <panic>

000018dc <main>:
{
    18dc:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    18e0:	83 e4 f0             	and    $0xfffffff0,%esp
    18e3:	ff 71 fc             	push   -0x4(%ecx)
    18e6:	55                   	push   %ebp
    18e7:	89 e5                	mov    %esp,%ebp
    18e9:	51                   	push   %ecx
    18ea:	83 ec 04             	sub    $0x4,%esp
  while((fd = open("console", O_RDWR)) >= 0){
    18ed:	83 ec 08             	sub    $0x8,%esp
    18f0:	6a 02                	push   $0x2
    18f2:	68 01 20 00 00       	push   $0x2001
    18f7:	e8 92 02 00 00       	call   1b8e <open>
    18fc:	83 c4 10             	add    $0x10,%esp
    18ff:	85 c0                	test   %eax,%eax
    1901:	78 21                	js     1924 <main+0x48>
    if(fd >= 3){
    1903:	83 f8 02             	cmp    $0x2,%eax
    1906:	7e e5                	jle    18ed <main+0x11>
      close(fd);
    1908:	83 ec 0c             	sub    $0xc,%esp
    190b:	50                   	push   %eax
    190c:	e8 65 02 00 00       	call   1b76 <close>
      break;
    1911:	83 c4 10             	add    $0x10,%esp
    1914:	eb 0e                	jmp    1924 <main+0x48>
    if(fork1() == 0)
    1916:	e8 4a f7 ff ff       	call   1065 <fork1>
    191b:	85 c0                	test   %eax,%eax
    191d:	74 76                	je     1995 <main+0xb9>
    wait();
    191f:	e8 32 02 00 00       	call   1b56 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
    1924:	83 ec 08             	sub    $0x8,%esp
    1927:	6a 64                	push   $0x64
    1929:	68 40 26 00 00       	push   $0x2640
    192e:	e8 cd f6 ff ff       	call   1000 <getcmd>
    1933:	83 c4 10             	add    $0x10,%esp
    1936:	85 c0                	test   %eax,%eax
    1938:	78 70                	js     19aa <main+0xce>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    193a:	80 3d 40 26 00 00 63 	cmpb   $0x63,0x2640
    1941:	75 d3                	jne    1916 <main+0x3a>
    1943:	80 3d 41 26 00 00 64 	cmpb   $0x64,0x2641
    194a:	75 ca                	jne    1916 <main+0x3a>
    194c:	80 3d 42 26 00 00 20 	cmpb   $0x20,0x2642
    1953:	75 c1                	jne    1916 <main+0x3a>
      buf[strlen(buf)-1] = 0;  // chop \n
    1955:	83 ec 0c             	sub    $0xc,%esp
    1958:	68 40 26 00 00       	push   $0x2640
    195d:	e8 99 00 00 00       	call   19fb <strlen>
    1962:	c6 80 3f 26 00 00 00 	movb   $0x0,0x263f(%eax)
      if(chdir(buf+3) < 0)
    1969:	c7 04 24 43 26 00 00 	movl   $0x2643,(%esp)
    1970:	e8 49 02 00 00       	call   1bbe <chdir>
    1975:	83 c4 10             	add    $0x10,%esp
    1978:	85 c0                	test   %eax,%eax
    197a:	79 a8                	jns    1924 <main+0x48>
        printf(2, "cannot cd %s\n", buf+3);
    197c:	83 ec 04             	sub    $0x4,%esp
    197f:	68 43 26 00 00       	push   $0x2643
    1984:	68 09 20 00 00       	push   $0x2009
    1989:	6a 02                	push   $0x2
    198b:	e8 23 03 00 00       	call   1cb3 <printf>
    1990:	83 c4 10             	add    $0x10,%esp
      continue;
    1993:	eb 8f                	jmp    1924 <main+0x48>
      runcmd(parsecmd(buf));
    1995:	83 ec 0c             	sub    $0xc,%esp
    1998:	68 40 26 00 00       	push   $0x2640
    199d:	e8 ce fe ff ff       	call   1870 <parsecmd>
    19a2:	89 04 24             	mov    %eax,(%esp)
    19a5:	e8 da f6 ff ff       	call   1084 <runcmd>
  exit();
    19aa:	e8 9f 01 00 00       	call   1b4e <exit>

000019af <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    19af:	55                   	push   %ebp
    19b0:	89 e5                	mov    %esp,%ebp
    19b2:	56                   	push   %esi
    19b3:	53                   	push   %ebx
    19b4:	8b 75 08             	mov    0x8(%ebp),%esi
    19b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    19ba:	89 f0                	mov    %esi,%eax
    19bc:	89 d1                	mov    %edx,%ecx
    19be:	83 c2 01             	add    $0x1,%edx
    19c1:	89 c3                	mov    %eax,%ebx
    19c3:	83 c0 01             	add    $0x1,%eax
    19c6:	0f b6 09             	movzbl (%ecx),%ecx
    19c9:	88 0b                	mov    %cl,(%ebx)
    19cb:	84 c9                	test   %cl,%cl
    19cd:	75 ed                	jne    19bc <strcpy+0xd>
    ;
  return os;
}
    19cf:	89 f0                	mov    %esi,%eax
    19d1:	5b                   	pop    %ebx
    19d2:	5e                   	pop    %esi
    19d3:	5d                   	pop    %ebp
    19d4:	c3                   	ret    

000019d5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    19d5:	55                   	push   %ebp
    19d6:	89 e5                	mov    %esp,%ebp
    19d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19db:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    19de:	eb 06                	jmp    19e6 <strcmp+0x11>
    p++, q++;
    19e0:	83 c1 01             	add    $0x1,%ecx
    19e3:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    19e6:	0f b6 01             	movzbl (%ecx),%eax
    19e9:	84 c0                	test   %al,%al
    19eb:	74 04                	je     19f1 <strcmp+0x1c>
    19ed:	3a 02                	cmp    (%edx),%al
    19ef:	74 ef                	je     19e0 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    19f1:	0f b6 c0             	movzbl %al,%eax
    19f4:	0f b6 12             	movzbl (%edx),%edx
    19f7:	29 d0                	sub    %edx,%eax
}
    19f9:	5d                   	pop    %ebp
    19fa:	c3                   	ret    

000019fb <strlen>:

uint
strlen(const char *s)
{
    19fb:	55                   	push   %ebp
    19fc:	89 e5                	mov    %esp,%ebp
    19fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1a01:	b8 00 00 00 00       	mov    $0x0,%eax
    1a06:	eb 03                	jmp    1a0b <strlen+0x10>
    1a08:	83 c0 01             	add    $0x1,%eax
    1a0b:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    1a0f:	75 f7                	jne    1a08 <strlen+0xd>
    ;
  return n;
}
    1a11:	5d                   	pop    %ebp
    1a12:	c3                   	ret    

00001a13 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1a13:	55                   	push   %ebp
    1a14:	89 e5                	mov    %esp,%ebp
    1a16:	57                   	push   %edi
    1a17:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1a1a:	89 d7                	mov    %edx,%edi
    1a1c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a22:	fc                   	cld    
    1a23:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1a25:	89 d0                	mov    %edx,%eax
    1a27:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1a2a:	c9                   	leave  
    1a2b:	c3                   	ret    

00001a2c <strchr>:

char*
strchr(const char *s, char c)
{
    1a2c:	55                   	push   %ebp
    1a2d:	89 e5                	mov    %esp,%ebp
    1a2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a32:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1a36:	eb 03                	jmp    1a3b <strchr+0xf>
    1a38:	83 c0 01             	add    $0x1,%eax
    1a3b:	0f b6 10             	movzbl (%eax),%edx
    1a3e:	84 d2                	test   %dl,%dl
    1a40:	74 06                	je     1a48 <strchr+0x1c>
    if(*s == c)
    1a42:	38 ca                	cmp    %cl,%dl
    1a44:	75 f2                	jne    1a38 <strchr+0xc>
    1a46:	eb 05                	jmp    1a4d <strchr+0x21>
      return (char*)s;
  return 0;
    1a48:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a4d:	5d                   	pop    %ebp
    1a4e:	c3                   	ret    

00001a4f <gets>:

char*
gets(char *buf, int max)
{
    1a4f:	55                   	push   %ebp
    1a50:	89 e5                	mov    %esp,%ebp
    1a52:	57                   	push   %edi
    1a53:	56                   	push   %esi
    1a54:	53                   	push   %ebx
    1a55:	83 ec 1c             	sub    $0x1c,%esp
    1a58:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1a5b:	bb 00 00 00 00       	mov    $0x0,%ebx
    1a60:	89 de                	mov    %ebx,%esi
    1a62:	83 c3 01             	add    $0x1,%ebx
    1a65:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1a68:	7d 2e                	jge    1a98 <gets+0x49>
    cc = read(0, &c, 1);
    1a6a:	83 ec 04             	sub    $0x4,%esp
    1a6d:	6a 01                	push   $0x1
    1a6f:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1a72:	50                   	push   %eax
    1a73:	6a 00                	push   $0x0
    1a75:	e8 ec 00 00 00       	call   1b66 <read>
    if(cc < 1)
    1a7a:	83 c4 10             	add    $0x10,%esp
    1a7d:	85 c0                	test   %eax,%eax
    1a7f:	7e 17                	jle    1a98 <gets+0x49>
      break;
    buf[i++] = c;
    1a81:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1a85:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    1a88:	3c 0a                	cmp    $0xa,%al
    1a8a:	0f 94 c2             	sete   %dl
    1a8d:	3c 0d                	cmp    $0xd,%al
    1a8f:	0f 94 c0             	sete   %al
    1a92:	08 c2                	or     %al,%dl
    1a94:	74 ca                	je     1a60 <gets+0x11>
    buf[i++] = c;
    1a96:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1a98:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1a9c:	89 f8                	mov    %edi,%eax
    1a9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1aa1:	5b                   	pop    %ebx
    1aa2:	5e                   	pop    %esi
    1aa3:	5f                   	pop    %edi
    1aa4:	5d                   	pop    %ebp
    1aa5:	c3                   	ret    

00001aa6 <stat>:

int
stat(const char *n, struct stat *st)
{
    1aa6:	55                   	push   %ebp
    1aa7:	89 e5                	mov    %esp,%ebp
    1aa9:	56                   	push   %esi
    1aaa:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1aab:	83 ec 08             	sub    $0x8,%esp
    1aae:	6a 00                	push   $0x0
    1ab0:	ff 75 08             	push   0x8(%ebp)
    1ab3:	e8 d6 00 00 00       	call   1b8e <open>
  if(fd < 0)
    1ab8:	83 c4 10             	add    $0x10,%esp
    1abb:	85 c0                	test   %eax,%eax
    1abd:	78 24                	js     1ae3 <stat+0x3d>
    1abf:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    1ac1:	83 ec 08             	sub    $0x8,%esp
    1ac4:	ff 75 0c             	push   0xc(%ebp)
    1ac7:	50                   	push   %eax
    1ac8:	e8 d9 00 00 00       	call   1ba6 <fstat>
    1acd:	89 c6                	mov    %eax,%esi
  close(fd);
    1acf:	89 1c 24             	mov    %ebx,(%esp)
    1ad2:	e8 9f 00 00 00       	call   1b76 <close>
  return r;
    1ad7:	83 c4 10             	add    $0x10,%esp
}
    1ada:	89 f0                	mov    %esi,%eax
    1adc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1adf:	5b                   	pop    %ebx
    1ae0:	5e                   	pop    %esi
    1ae1:	5d                   	pop    %ebp
    1ae2:	c3                   	ret    
    return -1;
    1ae3:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1ae8:	eb f0                	jmp    1ada <stat+0x34>

00001aea <atoi>:

int
atoi(const char *s)
{
    1aea:	55                   	push   %ebp
    1aeb:	89 e5                	mov    %esp,%ebp
    1aed:	53                   	push   %ebx
    1aee:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    1af1:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    1af6:	eb 10                	jmp    1b08 <atoi+0x1e>
    n = n*10 + *s++ - '0';
    1af8:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
    1afb:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
    1afe:	83 c1 01             	add    $0x1,%ecx
    1b01:	0f be c0             	movsbl %al,%eax
    1b04:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
  while('0' <= *s && *s <= '9')
    1b08:	0f b6 01             	movzbl (%ecx),%eax
    1b0b:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1b0e:	80 fb 09             	cmp    $0x9,%bl
    1b11:	76 e5                	jbe    1af8 <atoi+0xe>
  return n;
}
    1b13:	89 d0                	mov    %edx,%eax
    1b15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1b18:	c9                   	leave  
    1b19:	c3                   	ret    

00001b1a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1b1a:	55                   	push   %ebp
    1b1b:	89 e5                	mov    %esp,%ebp
    1b1d:	56                   	push   %esi
    1b1e:	53                   	push   %ebx
    1b1f:	8b 75 08             	mov    0x8(%ebp),%esi
    1b22:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1b25:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
    1b28:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
    1b2a:	eb 0d                	jmp    1b39 <memmove+0x1f>
    *dst++ = *src++;
    1b2c:	0f b6 01             	movzbl (%ecx),%eax
    1b2f:	88 02                	mov    %al,(%edx)
    1b31:	8d 49 01             	lea    0x1(%ecx),%ecx
    1b34:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
    1b37:	89 d8                	mov    %ebx,%eax
    1b39:	8d 58 ff             	lea    -0x1(%eax),%ebx
    1b3c:	85 c0                	test   %eax,%eax
    1b3e:	7f ec                	jg     1b2c <memmove+0x12>
  return vdst;
}
    1b40:	89 f0                	mov    %esi,%eax
    1b42:	5b                   	pop    %ebx
    1b43:	5e                   	pop    %esi
    1b44:	5d                   	pop    %ebp
    1b45:	c3                   	ret    

00001b46 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1b46:	b8 01 00 00 00       	mov    $0x1,%eax
    1b4b:	cd 40                	int    $0x40
    1b4d:	c3                   	ret    

00001b4e <exit>:
SYSCALL(exit)
    1b4e:	b8 02 00 00 00       	mov    $0x2,%eax
    1b53:	cd 40                	int    $0x40
    1b55:	c3                   	ret    

00001b56 <wait>:
SYSCALL(wait)
    1b56:	b8 03 00 00 00       	mov    $0x3,%eax
    1b5b:	cd 40                	int    $0x40
    1b5d:	c3                   	ret    

00001b5e <pipe>:
SYSCALL(pipe)
    1b5e:	b8 04 00 00 00       	mov    $0x4,%eax
    1b63:	cd 40                	int    $0x40
    1b65:	c3                   	ret    

00001b66 <read>:
SYSCALL(read)
    1b66:	b8 05 00 00 00       	mov    $0x5,%eax
    1b6b:	cd 40                	int    $0x40
    1b6d:	c3                   	ret    

00001b6e <write>:
SYSCALL(write)
    1b6e:	b8 10 00 00 00       	mov    $0x10,%eax
    1b73:	cd 40                	int    $0x40
    1b75:	c3                   	ret    

00001b76 <close>:
SYSCALL(close)
    1b76:	b8 15 00 00 00       	mov    $0x15,%eax
    1b7b:	cd 40                	int    $0x40
    1b7d:	c3                   	ret    

00001b7e <kill>:
SYSCALL(kill)
    1b7e:	b8 06 00 00 00       	mov    $0x6,%eax
    1b83:	cd 40                	int    $0x40
    1b85:	c3                   	ret    

00001b86 <exec>:
SYSCALL(exec)
    1b86:	b8 07 00 00 00       	mov    $0x7,%eax
    1b8b:	cd 40                	int    $0x40
    1b8d:	c3                   	ret    

00001b8e <open>:
SYSCALL(open)
    1b8e:	b8 0f 00 00 00       	mov    $0xf,%eax
    1b93:	cd 40                	int    $0x40
    1b95:	c3                   	ret    

00001b96 <mknod>:
SYSCALL(mknod)
    1b96:	b8 11 00 00 00       	mov    $0x11,%eax
    1b9b:	cd 40                	int    $0x40
    1b9d:	c3                   	ret    

00001b9e <unlink>:
SYSCALL(unlink)
    1b9e:	b8 12 00 00 00       	mov    $0x12,%eax
    1ba3:	cd 40                	int    $0x40
    1ba5:	c3                   	ret    

00001ba6 <fstat>:
SYSCALL(fstat)
    1ba6:	b8 08 00 00 00       	mov    $0x8,%eax
    1bab:	cd 40                	int    $0x40
    1bad:	c3                   	ret    

00001bae <link>:
SYSCALL(link)
    1bae:	b8 13 00 00 00       	mov    $0x13,%eax
    1bb3:	cd 40                	int    $0x40
    1bb5:	c3                   	ret    

00001bb6 <mkdir>:
SYSCALL(mkdir)
    1bb6:	b8 14 00 00 00       	mov    $0x14,%eax
    1bbb:	cd 40                	int    $0x40
    1bbd:	c3                   	ret    

00001bbe <chdir>:
SYSCALL(chdir)
    1bbe:	b8 09 00 00 00       	mov    $0x9,%eax
    1bc3:	cd 40                	int    $0x40
    1bc5:	c3                   	ret    

00001bc6 <dup>:
SYSCALL(dup)
    1bc6:	b8 0a 00 00 00       	mov    $0xa,%eax
    1bcb:	cd 40                	int    $0x40
    1bcd:	c3                   	ret    

00001bce <getpid>:
SYSCALL(getpid)
    1bce:	b8 0b 00 00 00       	mov    $0xb,%eax
    1bd3:	cd 40                	int    $0x40
    1bd5:	c3                   	ret    

00001bd6 <sbrk>:
SYSCALL(sbrk)
    1bd6:	b8 0c 00 00 00       	mov    $0xc,%eax
    1bdb:	cd 40                	int    $0x40
    1bdd:	c3                   	ret    

00001bde <sleep>:
SYSCALL(sleep)
    1bde:	b8 0d 00 00 00       	mov    $0xd,%eax
    1be3:	cd 40                	int    $0x40
    1be5:	c3                   	ret    

00001be6 <uptime>:
SYSCALL(uptime)
    1be6:	b8 0e 00 00 00       	mov    $0xe,%eax
    1beb:	cd 40                	int    $0x40
    1bed:	c3                   	ret    

00001bee <settickets>:
SYSCALL(settickets)
    1bee:	b8 16 00 00 00       	mov    $0x16,%eax
    1bf3:	cd 40                	int    $0x40
    1bf5:	c3                   	ret    

00001bf6 <getpinfo>:
SYSCALL(getpinfo)
    1bf6:	b8 17 00 00 00       	mov    $0x17,%eax
    1bfb:	cd 40                	int    $0x40
    1bfd:	c3                   	ret    

00001bfe <mprotect>:
SYSCALL(mprotect)
    1bfe:	b8 18 00 00 00       	mov    $0x18,%eax
    1c03:	cd 40                	int    $0x40
    1c05:	c3                   	ret    

00001c06 <munprotect>:
    1c06:	b8 19 00 00 00       	mov    $0x19,%eax
    1c0b:	cd 40                	int    $0x40
    1c0d:	c3                   	ret    

00001c0e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1c0e:	55                   	push   %ebp
    1c0f:	89 e5                	mov    %esp,%ebp
    1c11:	83 ec 1c             	sub    $0x1c,%esp
    1c14:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    1c17:	6a 01                	push   $0x1
    1c19:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1c1c:	52                   	push   %edx
    1c1d:	50                   	push   %eax
    1c1e:	e8 4b ff ff ff       	call   1b6e <write>
}
    1c23:	83 c4 10             	add    $0x10,%esp
    1c26:	c9                   	leave  
    1c27:	c3                   	ret    

00001c28 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1c28:	55                   	push   %ebp
    1c29:	89 e5                	mov    %esp,%ebp
    1c2b:	57                   	push   %edi
    1c2c:	56                   	push   %esi
    1c2d:	53                   	push   %ebx
    1c2e:	83 ec 2c             	sub    $0x2c,%esp
    1c31:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1c34:	89 d0                	mov    %edx,%eax
    1c36:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1c38:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1c3c:	0f 95 c1             	setne  %cl
    1c3f:	c1 ea 1f             	shr    $0x1f,%edx
    1c42:	84 d1                	test   %dl,%cl
    1c44:	74 44                	je     1c8a <printint+0x62>
    neg = 1;
    x = -xx;
    1c46:	f7 d8                	neg    %eax
    1c48:	89 c1                	mov    %eax,%ecx
    neg = 1;
    1c4a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1c51:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    1c56:	89 c8                	mov    %ecx,%eax
    1c58:	ba 00 00 00 00       	mov    $0x0,%edx
    1c5d:	f7 f6                	div    %esi
    1c5f:	89 df                	mov    %ebx,%edi
    1c61:	83 c3 01             	add    $0x1,%ebx
    1c64:	0f b6 92 a8 20 00 00 	movzbl 0x20a8(%edx),%edx
    1c6b:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    1c6f:	89 ca                	mov    %ecx,%edx
    1c71:	89 c1                	mov    %eax,%ecx
    1c73:	39 d6                	cmp    %edx,%esi
    1c75:	76 df                	jbe    1c56 <printint+0x2e>
  if(neg)
    1c77:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    1c7b:	74 31                	je     1cae <printint+0x86>
    buf[i++] = '-';
    1c7d:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    1c82:	8d 5f 02             	lea    0x2(%edi),%ebx
    1c85:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1c88:	eb 17                	jmp    1ca1 <printint+0x79>
    x = xx;
    1c8a:	89 c1                	mov    %eax,%ecx
  neg = 0;
    1c8c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    1c93:	eb bc                	jmp    1c51 <printint+0x29>

  while(--i >= 0)
    putc(fd, buf[i]);
    1c95:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    1c9a:	89 f0                	mov    %esi,%eax
    1c9c:	e8 6d ff ff ff       	call   1c0e <putc>
  while(--i >= 0)
    1ca1:	83 eb 01             	sub    $0x1,%ebx
    1ca4:	79 ef                	jns    1c95 <printint+0x6d>
}
    1ca6:	83 c4 2c             	add    $0x2c,%esp
    1ca9:	5b                   	pop    %ebx
    1caa:	5e                   	pop    %esi
    1cab:	5f                   	pop    %edi
    1cac:	5d                   	pop    %ebp
    1cad:	c3                   	ret    
    1cae:	8b 75 d0             	mov    -0x30(%ebp),%esi
    1cb1:	eb ee                	jmp    1ca1 <printint+0x79>

00001cb3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1cb3:	55                   	push   %ebp
    1cb4:	89 e5                	mov    %esp,%ebp
    1cb6:	57                   	push   %edi
    1cb7:	56                   	push   %esi
    1cb8:	53                   	push   %ebx
    1cb9:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1cbc:	8d 45 10             	lea    0x10(%ebp),%eax
    1cbf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    1cc2:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    1cc7:	bb 00 00 00 00       	mov    $0x0,%ebx
    1ccc:	eb 14                	jmp    1ce2 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    1cce:	89 fa                	mov    %edi,%edx
    1cd0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd3:	e8 36 ff ff ff       	call   1c0e <putc>
    1cd8:	eb 05                	jmp    1cdf <printf+0x2c>
      }
    } else if(state == '%'){
    1cda:	83 fe 25             	cmp    $0x25,%esi
    1cdd:	74 25                	je     1d04 <printf+0x51>
  for(i = 0; fmt[i]; i++){
    1cdf:	83 c3 01             	add    $0x1,%ebx
    1ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ce5:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
    1ce9:	84 c0                	test   %al,%al
    1ceb:	0f 84 20 01 00 00    	je     1e11 <printf+0x15e>
    c = fmt[i] & 0xff;
    1cf1:	0f be f8             	movsbl %al,%edi
    1cf4:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    1cf7:	85 f6                	test   %esi,%esi
    1cf9:	75 df                	jne    1cda <printf+0x27>
      if(c == '%'){
    1cfb:	83 f8 25             	cmp    $0x25,%eax
    1cfe:	75 ce                	jne    1cce <printf+0x1b>
        state = '%';
    1d00:	89 c6                	mov    %eax,%esi
    1d02:	eb db                	jmp    1cdf <printf+0x2c>
      if(c == 'd'){
    1d04:	83 f8 25             	cmp    $0x25,%eax
    1d07:	0f 84 cf 00 00 00    	je     1ddc <printf+0x129>
    1d0d:	0f 8c dd 00 00 00    	jl     1df0 <printf+0x13d>
    1d13:	83 f8 78             	cmp    $0x78,%eax
    1d16:	0f 8f d4 00 00 00    	jg     1df0 <printf+0x13d>
    1d1c:	83 f8 63             	cmp    $0x63,%eax
    1d1f:	0f 8c cb 00 00 00    	jl     1df0 <printf+0x13d>
    1d25:	83 e8 63             	sub    $0x63,%eax
    1d28:	83 f8 15             	cmp    $0x15,%eax
    1d2b:	0f 87 bf 00 00 00    	ja     1df0 <printf+0x13d>
    1d31:	ff 24 85 50 20 00 00 	jmp    *0x2050(,%eax,4)
        printint(fd, *ap, 10, 1);
    1d38:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1d3b:	8b 17                	mov    (%edi),%edx
    1d3d:	83 ec 0c             	sub    $0xc,%esp
    1d40:	6a 01                	push   $0x1
    1d42:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1d47:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4a:	e8 d9 fe ff ff       	call   1c28 <printint>
        ap++;
    1d4f:	83 c7 04             	add    $0x4,%edi
    1d52:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1d55:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1d58:	be 00 00 00 00       	mov    $0x0,%esi
    1d5d:	eb 80                	jmp    1cdf <printf+0x2c>
        printint(fd, *ap, 16, 0);
    1d5f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1d62:	8b 17                	mov    (%edi),%edx
    1d64:	83 ec 0c             	sub    $0xc,%esp
    1d67:	6a 00                	push   $0x0
    1d69:	b9 10 00 00 00       	mov    $0x10,%ecx
    1d6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d71:	e8 b2 fe ff ff       	call   1c28 <printint>
        ap++;
    1d76:	83 c7 04             	add    $0x4,%edi
    1d79:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1d7c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1d7f:	be 00 00 00 00       	mov    $0x0,%esi
    1d84:	e9 56 ff ff ff       	jmp    1cdf <printf+0x2c>
        s = (char*)*ap;
    1d89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d8c:	8b 30                	mov    (%eax),%esi
        ap++;
    1d8e:	83 c0 04             	add    $0x4,%eax
    1d91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    1d94:	85 f6                	test   %esi,%esi
    1d96:	75 15                	jne    1dad <printf+0xfa>
          s = "(null)";
    1d98:	be 48 20 00 00       	mov    $0x2048,%esi
    1d9d:	eb 0e                	jmp    1dad <printf+0xfa>
          putc(fd, *s);
    1d9f:	0f be d2             	movsbl %dl,%edx
    1da2:	8b 45 08             	mov    0x8(%ebp),%eax
    1da5:	e8 64 fe ff ff       	call   1c0e <putc>
          s++;
    1daa:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
    1dad:	0f b6 16             	movzbl (%esi),%edx
    1db0:	84 d2                	test   %dl,%dl
    1db2:	75 eb                	jne    1d9f <printf+0xec>
      state = 0;
    1db4:	be 00 00 00 00       	mov    $0x0,%esi
    1db9:	e9 21 ff ff ff       	jmp    1cdf <printf+0x2c>
        putc(fd, *ap);
    1dbe:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    1dc1:	0f be 17             	movsbl (%edi),%edx
    1dc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc7:	e8 42 fe ff ff       	call   1c0e <putc>
        ap++;
    1dcc:	83 c7 04             	add    $0x4,%edi
    1dcf:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    1dd2:	be 00 00 00 00       	mov    $0x0,%esi
    1dd7:	e9 03 ff ff ff       	jmp    1cdf <printf+0x2c>
        putc(fd, c);
    1ddc:	89 fa                	mov    %edi,%edx
    1dde:	8b 45 08             	mov    0x8(%ebp),%eax
    1de1:	e8 28 fe ff ff       	call   1c0e <putc>
      state = 0;
    1de6:	be 00 00 00 00       	mov    $0x0,%esi
    1deb:	e9 ef fe ff ff       	jmp    1cdf <printf+0x2c>
        putc(fd, '%');
    1df0:	ba 25 00 00 00       	mov    $0x25,%edx
    1df5:	8b 45 08             	mov    0x8(%ebp),%eax
    1df8:	e8 11 fe ff ff       	call   1c0e <putc>
        putc(fd, c);
    1dfd:	89 fa                	mov    %edi,%edx
    1dff:	8b 45 08             	mov    0x8(%ebp),%eax
    1e02:	e8 07 fe ff ff       	call   1c0e <putc>
      state = 0;
    1e07:	be 00 00 00 00       	mov    $0x0,%esi
    1e0c:	e9 ce fe ff ff       	jmp    1cdf <printf+0x2c>
    }
  }
}
    1e11:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e14:	5b                   	pop    %ebx
    1e15:	5e                   	pop    %esi
    1e16:	5f                   	pop    %edi
    1e17:	5d                   	pop    %ebp
    1e18:	c3                   	ret    

00001e19 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1e19:	55                   	push   %ebp
    1e1a:	89 e5                	mov    %esp,%ebp
    1e1c:	57                   	push   %edi
    1e1d:	56                   	push   %esi
    1e1e:	53                   	push   %ebx
    1e1f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1e22:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1e25:	a1 a4 26 00 00       	mov    0x26a4,%eax
    1e2a:	eb 02                	jmp    1e2e <free+0x15>
    1e2c:	89 d0                	mov    %edx,%eax
    1e2e:	39 c8                	cmp    %ecx,%eax
    1e30:	73 04                	jae    1e36 <free+0x1d>
    1e32:	39 08                	cmp    %ecx,(%eax)
    1e34:	77 12                	ja     1e48 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1e36:	8b 10                	mov    (%eax),%edx
    1e38:	39 c2                	cmp    %eax,%edx
    1e3a:	77 f0                	ja     1e2c <free+0x13>
    1e3c:	39 c8                	cmp    %ecx,%eax
    1e3e:	72 08                	jb     1e48 <free+0x2f>
    1e40:	39 ca                	cmp    %ecx,%edx
    1e42:	77 04                	ja     1e48 <free+0x2f>
    1e44:	89 d0                	mov    %edx,%eax
    1e46:	eb e6                	jmp    1e2e <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1e48:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1e4b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1e4e:	8b 10                	mov    (%eax),%edx
    1e50:	39 d7                	cmp    %edx,%edi
    1e52:	74 19                	je     1e6d <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1e54:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1e57:	8b 50 04             	mov    0x4(%eax),%edx
    1e5a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1e5d:	39 ce                	cmp    %ecx,%esi
    1e5f:	74 1b                	je     1e7c <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1e61:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1e63:	a3 a4 26 00 00       	mov    %eax,0x26a4
}
    1e68:	5b                   	pop    %ebx
    1e69:	5e                   	pop    %esi
    1e6a:	5f                   	pop    %edi
    1e6b:	5d                   	pop    %ebp
    1e6c:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1e6d:	03 72 04             	add    0x4(%edx),%esi
    1e70:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1e73:	8b 10                	mov    (%eax),%edx
    1e75:	8b 12                	mov    (%edx),%edx
    1e77:	89 53 f8             	mov    %edx,-0x8(%ebx)
    1e7a:	eb db                	jmp    1e57 <free+0x3e>
    p->s.size += bp->s.size;
    1e7c:	03 53 fc             	add    -0x4(%ebx),%edx
    1e7f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1e82:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1e85:	89 10                	mov    %edx,(%eax)
    1e87:	eb da                	jmp    1e63 <free+0x4a>

00001e89 <morecore>:

static Header*
morecore(uint nu)
{
    1e89:	55                   	push   %ebp
    1e8a:	89 e5                	mov    %esp,%ebp
    1e8c:	53                   	push   %ebx
    1e8d:	83 ec 04             	sub    $0x4,%esp
    1e90:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    1e92:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    1e97:	77 05                	ja     1e9e <morecore+0x15>
    nu = 4096;
    1e99:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    1e9e:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    1ea5:	83 ec 0c             	sub    $0xc,%esp
    1ea8:	50                   	push   %eax
    1ea9:	e8 28 fd ff ff       	call   1bd6 <sbrk>
  if(p == (char*)-1)
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	83 f8 ff             	cmp    $0xffffffff,%eax
    1eb4:	74 1c                	je     1ed2 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1eb6:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1eb9:	83 c0 08             	add    $0x8,%eax
    1ebc:	83 ec 0c             	sub    $0xc,%esp
    1ebf:	50                   	push   %eax
    1ec0:	e8 54 ff ff ff       	call   1e19 <free>
  return freep;
    1ec5:	a1 a4 26 00 00       	mov    0x26a4,%eax
    1eca:	83 c4 10             	add    $0x10,%esp
}
    1ecd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ed0:	c9                   	leave  
    1ed1:	c3                   	ret    
    return 0;
    1ed2:	b8 00 00 00 00       	mov    $0x0,%eax
    1ed7:	eb f4                	jmp    1ecd <morecore+0x44>

00001ed9 <malloc>:

void*
malloc(uint nbytes)
{
    1ed9:	55                   	push   %ebp
    1eda:	89 e5                	mov    %esp,%ebp
    1edc:	53                   	push   %ebx
    1edd:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1ee0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee3:	8d 58 07             	lea    0x7(%eax),%ebx
    1ee6:	c1 eb 03             	shr    $0x3,%ebx
    1ee9:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1eec:	8b 0d a4 26 00 00    	mov    0x26a4,%ecx
    1ef2:	85 c9                	test   %ecx,%ecx
    1ef4:	74 04                	je     1efa <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ef6:	8b 01                	mov    (%ecx),%eax
    1ef8:	eb 4a                	jmp    1f44 <malloc+0x6b>
    base.s.ptr = freep = prevp = &base;
    1efa:	c7 05 a4 26 00 00 a8 	movl   $0x26a8,0x26a4
    1f01:	26 00 00 
    1f04:	c7 05 a8 26 00 00 a8 	movl   $0x26a8,0x26a8
    1f0b:	26 00 00 
    base.s.size = 0;
    1f0e:	c7 05 ac 26 00 00 00 	movl   $0x0,0x26ac
    1f15:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    1f18:	b9 a8 26 00 00       	mov    $0x26a8,%ecx
    1f1d:	eb d7                	jmp    1ef6 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1f1f:	74 19                	je     1f3a <malloc+0x61>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1f21:	29 da                	sub    %ebx,%edx
    1f23:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1f26:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1f29:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1f2c:	89 0d a4 26 00 00    	mov    %ecx,0x26a4
      return (void*)(p + 1);
    1f32:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f38:	c9                   	leave  
    1f39:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1f3a:	8b 10                	mov    (%eax),%edx
    1f3c:	89 11                	mov    %edx,(%ecx)
    1f3e:	eb ec                	jmp    1f2c <malloc+0x53>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f40:	89 c1                	mov    %eax,%ecx
    1f42:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    1f44:	8b 50 04             	mov    0x4(%eax),%edx
    1f47:	39 da                	cmp    %ebx,%edx
    1f49:	73 d4                	jae    1f1f <malloc+0x46>
    if(p == freep)
    1f4b:	39 05 a4 26 00 00    	cmp    %eax,0x26a4
    1f51:	75 ed                	jne    1f40 <malloc+0x67>
      if((p = morecore(nunits)) == 0)
    1f53:	89 d8                	mov    %ebx,%eax
    1f55:	e8 2f ff ff ff       	call   1e89 <morecore>
    1f5a:	85 c0                	test   %eax,%eax
    1f5c:	75 e2                	jne    1f40 <malloc+0x67>
    1f5e:	eb d5                	jmp    1f35 <malloc+0x5c>
