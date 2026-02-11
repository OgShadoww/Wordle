#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <time.h>
#include <unistd.h>

int get_term_size(int *rows, int *cols) {
    struct winsize ws;
    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) != 0) return -1;
    *rows = (int)ws.ws_row;
    *cols = (int)ws.ws_col;
    return 0;
}

uint64_t get_current_ms() {
  struct timeval tv;
  gettimeofday(&tv, NULL);

  return (uint64_t)tv.tv_sec * 1000ULL + (uint64_t)tv.tv_usec / 1000ULL;
}

void print_num(int n) {
  char buff[32];
  int i = 0;

  while (n > 0) {
    buff[i++] = '0' + (n % 10);
    n /= 10;
  }
  buff[i] = '\0';

  for (int j = 0; j < i / 2; j++) {
    char tmp = buff[j];
    buff[j] = buff[i - 1 - j];
    buff[i - 1 - j] = tmp;
  }
  
  printf("%s", buff);
  fflush(stdout);
  return;
}
