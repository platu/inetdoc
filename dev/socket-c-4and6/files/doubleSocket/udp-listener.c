#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <netinet/in.h>

#define MAX_PORT 5
#define PORT_ARRAY_SIZE (MAX_PORT+1)
#define MAX_MSG 80
#define MSG_ARRAY_SIZE (MAX_MSG+1)
// Utilisation d'une constante x dans la définition
// du format de saisie
#define str(x) # x
#define xstr(x) str(x)

enum IP {
 v4, v6
};

// extraction adresse IPv4 ou IPv6:
void *get_in_addr(struct sockaddr *sa) {
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }

    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

// extraction numéro de port
unsigned short int get_in_port(struct sockaddr *sa) {
    if (sa->sa_family == AF_INET) {
        return ((struct sockaddr_in*)sa)->sin_port;
    }

    return ((struct sockaddr_in6*)sa)->sin6_port;
}

int main() {

  int listenSocket[2], status, recv, i;
  unsigned short int msgLength;
  struct addrinfo hints, *servinfo, *p;
  socklen_t clientAddressLength;
  struct sockaddr_storage clientAddress;
  char msg[MSG_ARRAY_SIZE], listenPort[PORT_ARRAY_SIZE], ipstr[INET6_ADDRSTRLEN];
  struct timeval timeVal;
  fd_set readSet[2];

  listenSocket[v4] = 0;
  listenSocket[v6] = 0;

  memset(listenPort, 0, sizeof listenPort);  // Mise à zéro du tampon
  puts("Entrez le numéro de port utilisé en écoute (entre 1500 et 65000) : ");
  scanf("%"xstr(MAX_PORT)"s", listenPort);

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC; // IPv6 et IPv4
  hints.ai_socktype = SOCK_DGRAM;
  hints.ai_flags = AI_PASSIVE; // use my IP

  if ((status = getaddrinfo(NULL, listenPort, &hints, &servinfo)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    return 1;
  }

  // Scrutation des résultats et création de socket
  // Sortie après création d'une «prise» IPv4 et d'une «prise» IPv6
  for (p = servinfo; p != NULL; p = p->ai_next) {
    void *addr;
    char ipver[5];
    // socket unique et IPV6_V6ONLY à 0
    // adresses IPv4 mappées
    int optval = 1;

    memset(ipver, 0, sizeof ipver);
    // pointeur vers l'adresse courante
    // les champs diffèrent entre IPv4 et IPv6
    if (p->ai_family == AF_INET) { // IPv4
      struct sockaddr_in *ipv4 = (struct sockaddr_in *)p->ai_addr;
      addr = &(ipv4->sin_addr);
      strncpy(ipver, "IPv4", 4);

      if ((listenSocket[v4] = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
        perror("udp-listener: socket");
        continue;
      }

      if (bind(listenSocket[v4], p->ai_addr, p->ai_addrlen) == -1) {
        close(listenSocket[v4]);
        perror("udp-listener: bind");
        continue;
      }
    }
    else { // IPv6
      struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)p->ai_addr;
      addr = &(ipv6->sin6_addr);
      strncpy(ipver, "IPv6", 4);

      if ((listenSocket[v6] = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
        perror("udp-listener: socket");
        continue;
      }

      if (setsockopt(listenSocket[v6], IPPROTO_IPV6, IPV6_V6ONLY, &optval, sizeof optval) == -1)
        perror("udp-listener: setsockopt");

      if (bind(listenSocket[v6], p->ai_addr, p->ai_addrlen) == -1) {
        close(listenSocket[v6]);
        perror("udp-listener: bind");
        continue;
      }
    }

    // conversion de l'adresse IP en une chaîne de caractères
    inet_ntop(p->ai_family, addr, ipstr, sizeof ipstr);
    printf(" %s: %s\n", ipver, ipstr);

    if ((listenSocket[v4] > 0) && (listenSocket[v6] > 0))
      break;
  }

  if (p == NULL) {
    fputs("Impossible de créer un socket\n", stderr);
    exit(EXIT_FAILURE);
  }

  freeaddrinfo(servinfo);

  printf("Attente de requête sur le port %s\n", listenPort);

  // Utilisation de select en mode scrutation
  timeVal.tv_sec = 0;
  timeVal.tv_usec = 0;

  while (1) {

    clientAddressLength = sizeof clientAddress;

    // Mise à zéro du tampon de façon à connaître le délimiteur
    // de fin de chaîne.
    memset(msg, 0, sizeof msg);

    FD_ZERO(&readSet[v4]);
    FD_SET(listenSocket[v4], &readSet[v4]);
    FD_ZERO(&readSet[v6]);
    FD_SET(listenSocket[v6], &readSet[v6]);

    if (select(listenSocket[v4]+1, &readSet[v4], NULL, NULL, &timeVal)) // IPv4
      if ((recv = recvfrom(listenSocket[v4], msg, sizeof msg, 0,
                           (struct sockaddr *) &clientAddress,
                           &clientAddressLength)) < 0) {
        perror("udp-listener: recvfrom");
        exit(EXIT_FAILURE);
      }
    if (select(listenSocket[v6]+1, &readSet[v6], NULL, NULL, &timeVal)) // IPv6
      if ((recv = recvfrom(listenSocket[v6], msg, sizeof msg, 0,
                           (struct sockaddr *) &clientAddress,
                           &clientAddressLength)) < 0) {
        perror("udp-listener: recvfrom");
        exit(EXIT_FAILURE);
      }

    msgLength = strlen(msg);
    if (msgLength > 0) {
      // Affichage de l'adresse IP du client.
      inet_ntop(clientAddress.ss_family, get_in_addr((struct sockaddr *)&clientAddress),
                ipstr, sizeof ipstr);
      printf(">>  Depuis [%s]:", ipstr);

      // Affichage du numéro de port du client.
      printf("%hu\n", ntohs(get_in_port((struct sockaddr *)&clientAddress)));

      // Affichage de la ligne reçue
      printf(">>  Message reçu : %s\n", msg);

      // Conversion de cette ligne en majuscules.
      for (i = 0; i < msgLength; i++)
        msg[i] = toupper(msg[i]);

      // Renvoi de la ligne convertie au client.
      if (clientAddress.ss_family == AF_INET) { // IPv4
        if (sendto(listenSocket[v4], msg, msgLength, 0,
                   (struct sockaddr *) &clientAddress,
                   sizeof clientAddress) < 0) {
          perror("udp-listener: sendto");
          exit(EXIT_FAILURE);
        }
      }
      else { // IPv6
        if (sendto(listenSocket[v6], msg, msgLength, 0,
                   (struct sockaddr *) &clientAddress,
                   sizeof clientAddress) < 0) {
          perror("udp-listener: sendto");
          exit(EXIT_FAILURE);
        }
      }
    }
  }

  // jamais atteint
  return 0;
}
