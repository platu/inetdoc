#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <netinet/in.h>

#define MAX_PORT 5
#define PORT_ARRAY_SIZE (MAX_PORT+1)
#define MAX_MSG 80
#define MSG_ARRAY_SIZE (MAX_MSG+1)
#define BACKLOG 5
// Utilisation d'une constante x dans la définition
// du format de saisie
#define str(x) # x
#define xstr(x) str(x)

enum IPVERSION {
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

  int listenSocket[2], connectSocket, status, i;
  unsigned short int msgLength;
  struct addrinfo hints, *servinfo, *p;
  struct sockaddr_storage clientAddress;
  socklen_t clientAddressLength = sizeof clientAddress;
  void *addr;
  char msg[MSG_ARRAY_SIZE], listenPort[PORT_ARRAY_SIZE], ipstr[INET6_ADDRSTRLEN];
  int optval = 1; // socket double et IPV6_V6ONLY à 1
  bool sockSuccess = false;
  struct timeval timeVal;
  fd_set readSet[2];

  listenSocket[v4] = listenSocket[v6] = -1;

  memset(listenPort, 0, sizeof listenPort);  // Mise à zéro du tampon
  puts("Entrez le numéro de port utilisé en écoute (entre 1500 et 65000) : ");
  scanf("%"xstr(MAX_PORT)"s", listenPort);

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC; // IPv6 et IPv4
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE; // use my IP

  if ((status = getaddrinfo(NULL, listenPort, &hints, &servinfo)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    return 1;
  }

  // Scrutation des résultats et création de socket
  // Sortie après création d'une «prise» IPv4 et d'une «prise» IPv6
  p = servinfo;
  while ((p != NULL) && !sockSuccess) {

    // Identification de l'adresse courante
    if (p->ai_family == AF_INET) { // IPv4
      struct sockaddr_in *ipv4 = (struct sockaddr_in *)p->ai_addr;
      addr = &(ipv4->sin_addr);
      // conversion de l'adresse IP en une chaîne de caractères
      inet_ntop(p->ai_family, addr, ipstr, sizeof ipstr);
      printf(" IPv4: %s\n", ipstr);

      if ((listenSocket[v4] = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
        perror("socket:"); // Echec ouverture socket
      }

      else if (bind(listenSocket[v4], p->ai_addr, p->ai_addrlen) == -1) {
        close(listenSocket[v4]);
        perror("bind:");
	listenSocket[v4] = -1; // Echec socket en écoute
      }
    }
    else { // IPv6
      struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)p->ai_addr;
      addr = &(ipv6->sin6_addr);
      // conversion de l'adresse IP en une chaîne de caractères
      inet_ntop(p->ai_family, addr, ipstr, sizeof ipstr);
      printf(" IPv6: %s\n", ipstr);

      if ((listenSocket[v6] = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
        perror("socket:"); // Echec ouverture socket
      }

      else if (setsockopt(listenSocket[v6], IPPROTO_IPV6, IPV6_V6ONLY, &optval, sizeof optval) == -1) {
        perror("setsockopt:");
	listenSocket[v6] = -1; // Echec option bindv6only=1
      }

      else if (bind(listenSocket[v6], p->ai_addr, p->ai_addrlen) == -1) {
        close(listenSocket[v6]);
        perror("bind:");
	listenSocket[v6] = -1; // Echec socket en écoute
      }
    }

    if ((listenSocket[v4] != -1) && (listenSocket[v6] != -1)) // deux prises ouvertes
      sockSuccess = true;
    else
      p = p->ai_next; // Enregistrement d'adresse suivant
  }

  if (p == NULL) {
    fputs("Création de socket impossible\n", stderr);
    exit(EXIT_FAILURE);
  }

  // Libération de la mémoire occupée par les enregistrements
  freeaddrinfo(servinfo);

  printf("Attente de requête sur le port %s\n", listenPort);

  // Utilisation de select en mode scrutation
  timeVal.tv_sec = 0;
  timeVal.tv_usec = 0;

  // Attente des requêtes des clients.
  // Appel non bloquant et passage en mode passif
  // Demandes d'ouverture de connexion traitées par accept
  if (listen(listenSocket[v4], BACKLOG) == -1) {
    perror("listen");
    exit(EXIT_FAILURE);
  }

  if (listen(listenSocket[v6], BACKLOG) == -1) {
    perror("listen:");
    exit(EXIT_FAILURE);
  }

  while (1) {

    FD_ZERO(&readSet[v4]);
    FD_SET(listenSocket[v4], &readSet[v4]);
    FD_ZERO(&readSet[v6]);
    FD_SET(listenSocket[v6], &readSet[v6]);

    if (select(listenSocket[v4]+1, &readSet[v4], NULL, NULL, &timeVal) == -1) { // IPv4
      perror("select:");
      exit(EXIT_FAILURE);
    }

    if (select(listenSocket[v6]+1, &readSet[v6], NULL, NULL, &timeVal) == -1) { // IPv6
      perror("select:");
      exit(EXIT_FAILURE);
    }

    if (FD_ISSET(listenSocket[v4], &readSet[v4])) { // IPv4
      // Appel bloquant en attente d'une nouvelle connexion
      // connectSocket est la nouvelle prise utilisée pour la connexion active
      if ((connectSocket = accept(listenSocket[v4], (struct sockaddr *) &clientAddress,
				  &clientAddressLength)) == -1) {
        perror("accept:");
        close(listenSocket[v4]);
        exit(EXIT_FAILURE);
      }

      // Affichage de l'adresse IP du client.
      inet_ntop(clientAddress.ss_family, get_in_addr((struct sockaddr *)&clientAddress),
                ipstr, sizeof ipstr);
      printf(">>  connecté à [%s]:", ipstr);

      // Affichage du numéro de port du client.
      printf("%hu\n", ntohs(get_in_port((struct sockaddr *)&clientAddress)));

      // Mise à zéro du tampon de façon à connaître le délimiteur
      // de fin de chaîne.
      memset(msg, 0, sizeof msg);
      while (recv(connectSocket, msg, sizeof msg, 0) > 0) 
        if ((msgLength = strlen(msg)) > 0) {
          printf("  --  %s\n", msg);
          // Conversion de cette ligne en majuscules.
          for (i = 0; i < msgLength; i++)
            msg[i] = toupper(msg[i]);

          // Renvoi de la ligne convertie au client.
          if (send(connectSocket, msg, msgLength, 0) == -1) {
            perror("send:");
            close(listenSocket[v4]);
            exit(EXIT_FAILURE);
          }

          memset(msg, 0, sizeof msg);  // Mise à zéro du tampon
        }
    }

    if (FD_ISSET(listenSocket[v6], &readSet[v6])) { // IPv6
      // Appel bloquant en attente d'une nouvelle connexion
      // connectSocket est la nouvelle prise utilisée pour la connexion active
      if ((connectSocket = accept(listenSocket[v6], (struct sockaddr *) &clientAddress,
				  &clientAddressLength)) == -1) {
        perror("accept:");
        close(listenSocket[v6]);
        exit(EXIT_FAILURE);
      }

      // Affichage de l'adresse IP du client.
      inet_ntop(clientAddress.ss_family, get_in_addr((struct sockaddr *)&clientAddress),
                ipstr, sizeof ipstr);
      printf(">>  connecté à [%s]:", ipstr);

      // Affichage du numéro de port du client.
      printf("%hu\n", ntohs(get_in_port((struct sockaddr *)&clientAddress)));

      // Mise à zéro du tampon de façon à connaître le délimiteur
      // de fin de chaîne.
      memset(msg, 0, sizeof msg);
      while (recv(connectSocket, msg, sizeof msg, 0) > 0) 
        if ((msgLength = strlen(msg)) > 0) {
          printf("  --  %s\n", msg);
          // Conversion de cette ligne en majuscules.
          for (i = 0; i < msgLength; i++)
            msg[i] = toupper(msg[i]);

          // Renvoi de la ligne convertie au client.
          if (send(connectSocket, msg, msgLength, 0) == -1) {
            perror("send:");
            close(listenSocket[v6]);
            exit(EXIT_FAILURE);
          }

          memset(msg, 0, sizeof msg);  // Mise à zéro du tampon
        }
    }

  }

  // jamais atteint
  return 0;
}
