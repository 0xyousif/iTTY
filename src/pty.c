#include <stdio.h>
#include <unistd.h>
#include <util.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>

#include "ghostty/vt.h"
#include "libiosexec.h"


int pty_spawn(pid_t *child_out, uint16_t cols, uint16_t rows, int cell_width, int cell_height, const char *shell)
{
    int pty_fd;
    struct winsize ws = {
        .ws_row = rows,
        .ws_col = cols,
        .ws_xpixel = (unsigned short)(cols * cell_width),
        .ws_ypixel = (unsigned short)(rows * cell_height),
    };

    pid_t child = forkpty(&pty_fd, NULL, NULL, &ws);
    if (child < 0) {
        perror("forkpty");
        return -1;
    }

    if (child == 0) {
        const char *shell_name = strrchr(shell, '/');
        shell_name = shell_name ? shell_name + 1 : shell;

        setenv("TERM", "xterm-256color", 1);
        execl(shell, shell_name, NULL);
        _exit(127);
    }

    int flags = fcntl(pty_fd, F_GETFL);
    if (flags < 0 || fcntl(pty_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
        perror("fcntl O_NONBLOCK");
        close(pty_fd);
        return -1;
    }

    *child_out = child;
    return pty_fd;
}


void pty_write(int pty_fd, const char *buf, size_t len)
{
    while (len > 0) {
        ssize_t n = write(pty_fd, buf, len);
        if (n > 0) {
            buf += n;
            len -= (size_t)n;
        } else if (n < 0) {
            if (errno == EINTR)
                continue;
            break;
        }
    }
}

typedef enum {
    PTY_READ_OK,   
    PTY_READ_EOF,   
    PTY_READ_ERROR, 
} PtyReadResult;

PtyReadResult pty_read(int pty_fd, GhosttyTerminal terminal)
{
    uint8_t buf[4096];
    for (;;) {
        ssize_t n = read(pty_fd, buf, sizeof(buf));
        if (n > 0) {
            ghostty_terminal_vt_write(terminal, buf, (size_t)n);
        } else if (n == 0) {
            return PTY_READ_EOF;
        } else {
            if (errno == EAGAIN)
                return PTY_READ_OK;
            if (errno == EINTR)
                continue;
            if (errno == EIO)
                return PTY_READ_EOF;
            perror("pty read");
            return PTY_READ_ERROR;
        }
    }
}