#pragma once

#include <sys/types.h>
#include <stdint.h>
#include "ghostty/vt.h"

typedef enum {
    PTY_READ_OK,   
    PTY_READ_EOF,   
    PTY_READ_ERROR, 
} PtyReadResult;

int pty_spawn(pid_t *child_out, uint16_t cols, uint16_t rows, int cell_width, int cell_height, const char *shell);
void pty_write(int pty_fd, const char *buf, size_t len);
PtyReadResult pty_read(int pty_fd, GhosttyTerminal terminal);
