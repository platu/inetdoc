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
// Utilisation d'une constante x dans la définition
// du format de saisie
#define str(x) # x
#define xstr(x) str(x)

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

  int listenSocket, status, recv, i;
  unsigned short int msgLength;
  struct addrinfo hints, *servinfo, *p;
  struct sockaddr_storage clientAddress;
  socklen_t clientAddressLength = sizeof clientAddress;
  void *addr;
  char msg[MSG_ARRAY_SIZE], listenPort[PORT_ARRAY_SIZE], ipstr[INET6_ADDRSTRLEN], ipver;
  int optval = 0; // socket unique et IPV6_V6ONLY à 0
  bool sockSuccess = false;

  memset(listenPort, 0, sizeof listenPort);  // Mise à zéro du tampon
  puts("Entrez le numéro de port utilisé en écoute (entre 1500 et 65000) : ");
  scanf("%"xstr(MAX_PORT)"s", listenPort);

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_INET6;      // IPv6 et IPv4 mappées
  hints.ai_socktype = SOCK_DGRAM;  // UDP
  hints.ai_flags = AI_PASSIVE;     // Toutes les adresses disponibles

  if ((status = getaddrinfo(NULL, listenPort, &hints, &servinfo)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    return 1;
  }

  // Scrutation des résultats et création de socket
  // Sortie après création de la première «prise»
  p = servinfo;
  while((p != NULL) && !sockSuccess) {

    // Identification de l'adresse courante
    if (p->ai_family == AF_INET) { // IPv4
      struct sockaddr_in *ipv4 = (struct sockaddr_in *)p->ai_addr;
      addr = &(ipv4->sin_addr);
      ipver = '4';
    }
    else { // IPv6
      struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)p->ai_addr;
      addr = &(ipv6->sin6_addr);
      ipver = '6';
    }

    // Conversion de l'adresse IP en une chaîne de caractères
    inet_ntop(p->ai_family, addr, ipstr, sizeof ipstr);
    printf(" IPv%c: %s\n", ipver, ipstr);

    if ((listenSocket = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
      perror("socket:");
      sockSuccess = false; // Echec ouverture socket
      p = p->ai_next;      // Enregistrement d'adresse suivant
    }

    else if ((p->ai_family == AF_INET6) && // IPv6 uniquement
             (setsockopt(listenSocket, IPPROTO_IPV6, IPV6_V6ONLY, &optval, sizeof optval) == -1)) {
      close(listenSocket);
      perror("setsockopt:");
      sockSuccess = false; // Echec option bindv6only=0
      p = p->ai_next;      // Enregistrement d'adresse suivant
    }

    else if (bind(listenSocket, p->ai_addr, p->ai_addrlen) == -1) {
      close(listenSocket);
      perror("bind:");
      sockSuccess = false; // Echec socket en écoute
      p = p->ai_next;      // Enregistrement d'adresse suivant
    }

    else // La prise est bien ouverte
      sockSuccess = true;
  }

  if (p == NULL) {
    fputs("Création de socket impossible\n", stderr);
    exit(EXIT_FAILURE);
  }

  // Libération de la mémoire occupée par les enregistrements
  freeaddrinfo(servinfo);

  printf("Attente de requête sur le port %s\n", listenPort);

  while (1) {

    // Mise à zéro du tampon de façon à connaître le délimiteur
    // de fin de chaîne.
    memset(msg, 0, sizeof msg);
    if ((recv = recvfrom(listenSocket, msg, sizeof msg, 0,
                         (struct sockaddr *) &clientAddress,
                         &clientAddressLength)) < 0) {
      perror("recvfrom:");
      exit(EXIT_FAILURE);
    }

    if ((msgLength = strlen(msg)) > 0) {
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
      if (sendto(listenSocket, msg, msgLength, 0, (struct sockaddr *) &clientAddress,
                 clientAddressLength) == -1) {
        perror("sendto:");
        exit(EXIT_FAILURE);
      }
    }
  }

  // Jamais atteint
  return 0;
}
