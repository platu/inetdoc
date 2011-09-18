<![CDATA[
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

int main(void)
{
    int socket_unix, len;
    struct sockaddr_un local;

    if ((socket_unix = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }

    local.sun_family = AF_UNIX;
    strcpy(local.sun_path,"/tmp/test_socket_unix");
    unlink(local.sun_path);
    len = strlen(local.sun_path) + sizeof(local.sun_family);

    if (bind(socket_unix, (struct sockaddr *)&local, len) == -1) {
        perror("bind");
        exit(1);
    }

    system("ls -l /tmp/");

    unlink(local.sun_path);
    return 0;
}
]]>
