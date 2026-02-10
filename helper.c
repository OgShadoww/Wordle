#include <sys/ioctl.h>
#include <unistd.h>

int get_term_size(int *rows, int *cols) {
    struct winsize ws;
    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) != 0) return -1;
    *rows = (int)ws.ws_row;
    *cols = (int)ws.ws_col;
    return 0;
}
