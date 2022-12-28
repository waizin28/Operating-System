#include "types.h"
#include "user.h"

int main(int argc, char** argv) {
  int* addr = (int*)argc;
  printf(1, "%d\n", *addr);
  exit();
}
