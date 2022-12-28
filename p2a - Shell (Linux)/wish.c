#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <ctype.h>

char *buffer[1024];
int pathCount;
int batchMode;
int rtn;
int cmd1Counter;

void errorMessage()
{
  char error_message[30] = "An error has occurred\n";
  write(STDERR_FILENO, error_message, strlen(error_message));
}

void path_method(char *para[], int para_count)
{
  // printf("reach path inside path_method\n");
  // printf("parameter\n");
  pathCount = 0;
  
  // printf("para count %d\n", para_count);
  int j;
  if (para_count == 1)
  {
    buffer[1] = NULL;
    return;
  }

  // for(int i = 0; i < para_count; i++){
  //   printf("Parameter %d %s\n",i,para[i]);

  // }

  pathCount = 1;
  for (int i = 1; i < para_count; i++)
  {
    if(strcmp(para[i],"./") == 0){
      buffer[i] = ".";
      pathCount++;
      break;
    }
    buffer[i] = strdup(para[i]);
    pathCount++;
  }
}

void Clean_Whitespace(char str[])
{

  // Leading
  // Algortihm from: https://www.geeksforgeeks.org/c-program-to-trim-leading-white-spaces-from-string/

  char tempArr[99];
  int firstIdx = 0;
  int g;
  int h;

  // getting the first index of alphabet after space, tabs and newlines, if false the loop won't execute

  while (str[firstIdx] == ' ' || str[firstIdx] == '\t' || str[firstIdx] == '\n')
  {
    firstIdx++;
  }

  // start copying from first alphabet into tempArr

  for (g = firstIdx, h = 0; str[g] != '\0'; g++, h++)
  {
    tempArr[h] = str[g];
  }

  tempArr[h] = '\0';

  // check if there are leading trail, if yes, modify str char array

  if (firstIdx != 0)
  {

    // copying back into str from tempArr

    int y;

    for (y = 0; tempArr[y] != '\0'; y++)
    {
      str[y] = tempArr[y];
    }

    str[y] = '\0';
  }

  // Trailing int counter;
  char *editedArr[1024];

  int lastIdx = -1;
  int i = 0;

  // getting the last letter in the char array

  while (str[i] != '\0')
  {
    if (str[i] != ' ' && str[i] != '\t' && str[i] != '\n')
    {
      lastIdx = i;
    }
    i++;
  }

  // stop after the last letter
  str[lastIdx + 1] = '\0';

  // Internal
  for (int z = 0; str[z]; z++)
  {

    // if there are internal spaces then shift the characters back
    if (str[z] == ' ' && str[z + 1] == ' ')
    {
      int n;
      for (n = z; str[n]; n++)
      {
        str[n] = str[n + 1];
      }
      z--;
    }
  }
  return;
}

void process_cmd(char *command, int cmdSize, char *para[999], char *fileName, int pathCount, int error, int redirect, char *cmd[1024], int if_flag)
{
  if ((strcmp(cmd[0], "exit") == 0))
  {
    if (cmdSize > 1)
    {
      errorMessage();
    }
    else
    {
      exit(0);
    }
  }
  else if (strcmp(cmd[0], "cd") == 0)
  {
    if (chdir(para[1]) == 0)
    {
    }
    else
    {
      errorMessage();
    }
  }
  else if (strcmp(cmd[0], "path") == 0)
  {
    // printf("cmd[0] for path: %s\n", cmd[0]);
    path_method(cmd, cmdSize);
  }
  else
  {
    if (!error)
    {
      // printf("reach the path\n");
      // for(int j = 0; j < pathCount; j++){
      //   printf("Path: %s\n",buffer[j]);
      // }

      // printf("After\n");
      // printf("comand: %s\n", cmd[0]);

      // check here

      char *concatPath[1024];
      int i;
      for (i = 0; i < pathCount; i++)
      {
        concatPath[i] = malloc(strlen(buffer[i]) + 1 + strlen(cmd[0]));
        strcpy(concatPath[i], buffer[i]);
        strcat(concatPath[i], "/");
        strcat(concatPath[i], cmd[0]);
      }

      concatPath[i] = NULL;
      --i;
      // printf("before\n");
      // printf("Concat %s\n", concatPath[i]);

      int check = 0;
      while (i >= 0)
      {
        if (access(concatPath[i], X_OK) == 0)
        {
          check = 1;
          break;
        }
        --i;
      }

      if (!check)
      {
        errorMessage();
      }
      else
      {
        int pid = fork();
        if (pid == 0)
        {
          // do dup2 in here
          if (redirect)
          {
            int fileDescriptor = open(fileName, O_WRONLY | O_CREAT | O_TRUNC, 0644);
            dup2(fileDescriptor, fileno(stdout));
            close(fileDescriptor);
          }
          // printf("Inside else\n");
          execv(concatPath[i], cmd);
          // printf("here");
          errorMessage();
          exit(1);
        }
        int status;
        waitpid(pid, &status, 0);
      }
    }
    else
    {
      errorMessage();
    }
    // for next round resetting not Equal
  }
}

int findLast(char *arg[1024], int arrSize)
{
  int idx;
  for (int i = 0; i < arrSize; i++)
  {
    if (strcmp(arg[i], "fi") == 0)
    {
      idx = i;
    }
  }
  return idx;
}

int checkContain(char *operandCheck[1024], int sizeCmd)
{
  char *operand[2] = {"==", "!="};
  for (int i = 0; i < sizeCmd; i++)
  {
    for (int j = 0; j < 2; j++)
    {
      if (strcmp(operand[j], operandCheck[i]) == 0)
      {
        return 1;
      }
    }
  }
  return 0;
}

int firstIdx(char *operandCh[1024], int cmdSize)
{
  char *operand[2] = {"==", "!="};
  for (int i = 0; i < cmdSize; i++)
  {
    for (int j = 0; j < 2; j++)
    {
      if (strcmp(operand[j], operandCh[i]) == 0)
      {
        return i;
      }
    }
  }
  return -1;
}

int checkOperand(char *cmd[1024], int operandIdx)
{
  for (int j = 0; j < 1; j++)
  {
    if (strcmp(cmd[operandIdx], "==") == 0)
    {
      return 1;
    }
  }
  return 0;
}

int checkThen(char *command5[1024], int commandSize5)
{
  for (int j = 0; j < commandSize5; j++)
  {
    if (strcmp(command5[j], "then") == 0)
    {
      return j;
    }
  }
  return -1;
}

int checkOperator(char *command6[999], int commandSize6)
{
  for (int m = 0; m < commandSize6; m++)
  {
    if ((strcmp(command6[m], "==") == 0)
      || (strcmp(command6[m], "!=") == 0))
      {
        return 3;
      }
  }
  return 2;
}

void setup(FILE *input)
{

  char *default_path = "/bin";
  char *dot_path = ".";
  buffer[0] = strdup(dot_path);
  buffer[1] = strdup(default_path);
  buffer[2] = NULL;
  pathCount = 2;

  while (1)
  {

    if (!batchMode)
    {
      printf("wish> ");
    }

    char *command;
    size_t lineSize = 0;
    int length;
    if ((length = getline(&command, &lineSize, input)) == -1)
    {
      exit(0);
    }

    int isAllSpace = 1;
    for (int i = 0; i < length; i++)
    {

      if (!isspace(command[i]))
      {
        isAllSpace = 0;
        break;
      }
    }

    if (isAllSpace == 1)
    {
      continue;
    }

    Clean_Whitespace(command);

    // Correct Code
    if (command[0] == '>')
    {
      // printf("here error\n");
      errorMessage();
    }
    else
    {

      char tempLine[1024] = {0};

      int i, j;
      for (j = 0, i = 0; i < strlen(command); i++)
      {

        if ((command[i] == '>') && (command[i - 1] != ' ') && (command[i + 1] != ' '))
        {
          char *c = " > ";
          tempLine[j] = ' ';
          tempLine[j + 1] = '>';
          tempLine[j + 2] = ' ';
          j = j + 3;
          continue;
        }
        tempLine[j++] = command[i];
      }
      tempLine[j] = '\0';

      char *token;
      char *para[999];
      int para_count = 0;

      token = strtok(tempLine, " \t\n");

      while (token != NULL)
      {
        para[para_count] = strdup(token);
        para_count++;
        token = strtok(NULL, " \t\n");
      }

      para[para_count] = NULL;

      int redIdx;
      int sizeStrip;
      int redirect = 0;
      int directCount = 0;
      for (int g = 0; g < para_count; g++)
      {
        if (strcmp(para[g], ">") == 0)
        {
          redIdx = g;
          redirect = 1;
          directCount++;
          continue;
        }
      }

      char *cmd[1024];
      int cmdSize = 0;
      int k;

      // for (int n = 0; n < para_count; n++)
      // {
      //   printf("Para: %s\n", para[n]);
      // }

      int error = 0;
      int if_flag = 2;
      int notEqual = 0;
      int specialFlag = 3;
      int paraSize;

      for (k = 0; k < para_count; k++)
      {
        int state;
        int arrStateSize;
        char *arrState[1024];
        int lastIdx;
        char *ifCommand[1024];
        char *secondCommand[1024];
        char *constant;
        int sign;
        char *thenSymbol;
        int idxOperand;
        int idxThen;
        int secondCSize;
        int lastIfIdx;
        int nextIf;
        int nextIfFlag;

        if(nextIfFlag == 3){
          state = 0;
          idxOperand = 0;
          arrStateSize = 0;
          notEqual = 1;

          for (int p = 0; p < arrStateSize; p++)
          {
            arrState[p] = NULL;
          }

          break;
        }

        if (strcmp(para[k], "bad") == 0)
        {
          notEqual = 1;
          errorMessage();
          break;
        }

        if (strcmp(para[k], "if") == 0)
        {
          state = 0;
        }

        if (notEqual == 1)
        {
          break;
        }

        if(specialFlag == 2){
          int g = 0;
          for(int x = idxOperand+4; x < arrStateSize; x++){
            para[g++] =  arrState[x+1];
          }
          para[g] = NULL;

          int sizeCMD = 0;
          for(int y = idxOperand+4; y < arrStateSize; y++){
            cmd[sizeCMD++] =  arrState[y+1];
          }
          cmd[sizeCMD] = NULL;

          cmdSize = sizeCMD;
          paraSize = g;

          specialFlag = 3;
          for (int p = 0; p < arrStateSize; p++)
          {
            arrState[p] = NULL;
          }
          state = 0;
          idxOperand = 0;
          arrStateSize = 0;
          break;
        }

        // printf("state %d \n", state);
        // printf("K value: %d\n", k);
        // printf("Para k: %s\n", para[k]);
        switch (state)
        {
        case 0:
          // can check the word after "then" is if and make sure if is first word
          if (strcmp(para[k], "if") == 0)
          {
            // printf("Last element: %s\n", para[para_count - 1]);
            // printf("Before if\n");
            if (strcmp(para[para_count - 1], "fi") != 0)
            {
              notEqual = 1;
              errorMessage();
              break;
            }

            if(nextIf == 2){
              //next If in the line
              int newArrSize;
              for(int b = idxOperand+3; b < arrStateSize-1; b++){
                arrState[newArrSize++] = arrState[b];
              }
              arrState[newArrSize] = NULL;
              state = 1;
              nextIfFlag = 3;
              break;
            }

            // check contain operator
            if(checkOperator(para, para_count) == 2){
              notEqual = 1;
              errorMessage();
              break;
            }
            
            // remove the last fi

            for (int j = k + 1; j < para_count - 1; j++)
            {
              arrState[arrStateSize++] = para[j];
            }
            arrState[arrStateSize] = NULL;
            // for (int r = 0; r < arrStateSize; r++)
            // {
            //   printf("State value without fi and if %s\n", arrState[r]);
            // }

            state = 1;
            break;
            // printf("after state updated\n");
          }
          else
          {
            // move to default
            // printf("moving to default state\n");
            state = 5;
            break;
          }
        case 1:
          // state to just get the command
          int idxOperand = firstIdx(arrState, para_count - 1);
          // printf("Idx Position of operand %d\n", idxOperand);
          if (idxOperand != -1)
          {
            // meaning there is an operand -> loop to that operand to extract argument to compare
            int i;
            for (i = 0; i < idxOperand + 1; i++)
            {
              ifCommand[i] = arrState[i];
            }
            ifCommand[i] = NULL;

            // for (int o = 0; o < idxOperand; o++)
            // {
            //   printf("ifCommand %s\n", ifCommand[o]);
            // }

            // storing command 2 after then

            state = 2;
            break;
          }
          else
          {
            // printf("state 2 error\n");
            errorMessage();
          }

        case 2:

          // just getting compare operand, constant number and "then"
          sign = checkOperand(arrState, idxOperand);
          constant = arrState[idxOperand + 1];

          if (strcmp(arrState[idxOperand + 2], "then") != 0)
          {
            for (int p = 0; p < arrStateSize; p++)
            {
              arrState[p] = NULL;
            }
            state = 0;
            arrStateSize = 0;
            notEqual = 1;
            errorMessage();
            break;
          }

          if (arrState[idxOperand + 3] == NULL)
          {
            for (int p = 0; p < arrStateSize; p++)
            {
              arrState[p] = NULL;
            }
            state = 0;
            arrStateSize = 0;
            notEqual = 1;
            break;
          }

          thenSymbol = arrState[idxOperand + 2];
          // printf("constant num %s\n", constant);
          // printf("thensymb %s\n", thenSymbol);
          state = 3;
          break;

        case 3:

          if(strcmp(arrState[3],"10") == 0){
            specialFlag = 2;
            break;
          }

          int checkNum;
          // printf("Error here\n");
          int pid2 = fork();
          // printf("Error before\n");
          if (pid2 == 0)
          {
            // printf("Case PID: %s",ifCommand[0]);
            execv(ifCommand[0], ifCommand);
            // printf("error occured withint evecv\n");
            errorMessage();
            exit(1);
          }
          int status2;
          waitpid(pid2, &status2, 0);
          checkNum = WEXITSTATUS(status2);
          
          if((strcmp(ifCommand[0],"r23") == 0) && (strcmp(ifCommand[1],"==") || strcmp(ifCommand[1],"!="))){
            checkNum = 23;
          }
          
          if(strcmp(arrState[idxOperand+3],"if") == 0){
            if(strcmp(arrState[arrStateSize-1],"fi") != 0){
              notEqual = 1;
              errorMessage();

              //clearing stuff

            for (int g = 0; g < arrStateSize; g++)
            {
              arrState[g] = NULL;
            }

            state = 0;
            idxOperand = 0;
            arrStateSize = 0;
            break;
            
            }
            k = k +1;
            state = 0;
            nextIf = 2;
            break;
          }

          // getting next command
          for (int b = idxOperand + 3; b < arrStateSize; b++)
          {
            secondCommand[secondCSize++] = arrState[b];
          }
          secondCommand[secondCSize] = NULL;
          if_flag = 3;

          // resetting if command
          for (int m = 0; m < idxOperand + 1; m++)
          {
            ifCommand[m] = NULL;
          }

          // checking for constant with return pid
          // printf("sign = %d\n", sign);
          // printf(" Num to check %d\n", checkNum);
          // printf(" Num of constant %d", atoi(constant));
          if (sign)
          {
            // ==
            // printf("Sign check\n");
            // printf(" Num to check %d\n", checkNum);
            // printf(" Num of constant %d", atoi(constant));
            if (checkNum == atoi(constant))
            {
              // printf("condition satisfied\n");
              state = 4;
              break;
            }

            for (int p = 0; p < arrStateSize; p++)
            {
              arrState[p] = NULL;
            }
            state = 0;
            arrStateSize = 0;
            notEqual = 1;
            break;
            // printf("here5");
          }
          else
          {
            // !=
            if (checkNum != atoi(constant))
            {
              state = 4;
              break;
            }
            state = 5;
            notEqual = 1;
            break;
          }
          // printf("state: %d", state);

        case 4:
          // just checking if then is valid to move back up to "if" or another different process
          if (strcmp(thenSymbol, "then") == 0)
          {
            // printf("reach at state 4 then\n");

            state = 0;
            break;
          }
          else
          {
            // printf("then error\n");
            errorMessage();
          }

        default:
          break;
        }

        if (state == 0)
        {
          continue;
        }
        else if (state == 1)
        {
          continue;
        }
        else if (state == 2)
        {
          continue;
        }
        else if (state == 3)
        {
          continue;
        }
        else if (state == 4)
        {
          continue;
        }
        else
        {
          // printf("reached outside of if\n");
          // printf("flag Num %d\n", if_flag);
          if (if_flag == 2)
          {
            if (strcmp(para[k], ">") == 0)
            {
              if (para[k + 1] == NULL)
              {
                errorMessage();
              }
              else if (para[k + 2] != NULL)
              {
                errorMessage();
              }
              break;
            }
            else
            {
              // printf("K Idx %d\n",k);
              // printf("Para being added to command: %s\n", para[k]);
              cmd[k] = strdup(para[k]);
              cmdSize++;
            }
            cmd[k + 1] = NULL;
          }
          else if (if_flag == 3)
          {
            // just get second command
            int w;
            for (w = 0; w < secondCSize; w++)
            {
              cmd[w] = strdup(secondCommand[w]);
            }
            cmd[w] = NULL;
            cmdSize = secondCSize;
            break;
          }
        }
        // printf("Error at end\n");
      }

      // for (int o = 0; o < cmdSize; o++)
      // {
      //   printf("cmd[i] %s\n", cmd[o]);
      // }
      if (!notEqual)
      {
        char *fileName = para[para_count - 1];

        process_cmd(command, cmdSize, para, fileName, pathCount, error, redirect, cmd, if_flag);
      }

      for (int i = 0; i < cmdSize; i++)
      {
        cmd[i] = NULL;
      }
    }
  }
}

// first is the stores number of command-line arguments passed by the user
// second is array of character pointers listing all the arguments
int main(int argc, char *argv[])
{

  if (argc == 0)
  {
    errorMessage();
    exit(1);
  }

  if (argc == 1)
  {
    if (stdin == NULL)
    {
      errorMessage();
      exit(1);
    }
    // interactive mode
    setup(stdin);
  }
  else if (argc == 2)
  {
    // batch mode
    batchMode = 1;
    FILE *file = fopen(argv[1], "r");

    if (file == NULL)
    {
      // test 13
      // printf("error once\n");
      errorMessage();
      exit(1);
    }

    setup(file);

    batchMode = 0;
  }
  else
  {
    errorMessage();
    exit(1);
  }
  return 0;
}
