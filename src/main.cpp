#include <stdlib.h>
#include <stdlib.h>
#include <chrono>
#include <csignal>
#include <cstdio>
#include <ctime>
#include <time.h>

static volatile sig_atomic_t sig_caught = 0;

void signal_handler(int signal) {
  sig_caught = 1;
}

int main() {
  printf("Hello World!");
}