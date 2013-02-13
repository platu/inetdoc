/*
*  showip.c -- Affiche les adresses IP correspondant à un nom d'hôte donné en
*  ligne de commande
*
*  This code was first published in the
*  Beej's Guide to Network Programming
*  Credit has to be given back to beej(at)beej.us
*/
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

int main (int argc, char *argv[]) {

  struct addrinfo hints, *res, *p;
  int status;
  char ipstr[INET6_ADDRSTRLEN];

  if (argc != 2) {
    fprintf(stderr, "usage: showip hostname\n");
    return 1;
  }

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC; // IPv4 ou IPv6
  hints.ai_socktype = SOCK_STREAM;

  if ((status = getaddrinfo(argv[1], NULL, &hints, &res)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    return 2;
  }

  printf("IP addresses for %s:\n\n", argv[1]);

  for (p = res; p != NULL; p = p->ai_next) {
    void *addr;
    char ipver[5];

    memset(ipver, 0, sizeof ipver);
    // pointeur vers l'adresse courante
    // les champs diffèrent entre IPv4 et IPv6
    if (p->ai_family == AF_INET) { // IPv4
      struct sockaddr_in *ipv4 = (struct sockaddr_in *)p->ai_addr;
      addr = &(ipv4->sin_addr);
      strncpy(ipver, "IPv4", 4);
    }
    else { // IPv6
      struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)p->ai_addr;
      addr = &(ipv6->sin6_addr);
      strncpy(ipver, "IPv6", 4);
    }

    // conversion de l'adresse IP en une chaîne de caractères
    inet_ntop(p->ai_family, addr, ipstr, sizeof ipstr);
    printf(" %s: %s\n", ipver, ipstr);
  }

  freeaddrinfo(res); // libération de la liste chaînée

  return 0;
}
