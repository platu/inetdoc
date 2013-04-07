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

int main()
{
  int listenSocket, status, i;
  unsigned short int msgLength;
  struct addrinfo hints, *servinfo;
  struct sockaddr_in clientAddress;
  socklen_t clientAddressLength = sizeof clientAddress;
  char msg[MSG_ARRAY_SIZE], listenPort[PORT_ARRAY_SIZE];

  memset(listenPort, 0, sizeof listenPort);  // Mise à zéro du tampon
  puts("Entrez le numéro de port utilisé en écoute (entre 1500 et 65000) : ");
  scanf("%"xstr(MAX_PORT)"s", listenPort);

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_INET;       // IPv4
  hints.ai_socktype = SOCK_DGRAM;  // UDP
  hints.ai_flags = AI_PASSIVE;     // Toutes les adresses disponibles

  if ((status = getaddrinfo(NULL, listenPort, &hints, &servinfo)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(status));
    exit(EXIT_FAILURE);
  }

  if ((listenSocket = socket(servinfo->ai_family, servinfo->ai_socktype,
                             servinfo->ai_protocol)) == -1) {
    perror("socket:");
    exit(EXIT_FAILURE);
  }

  if (bind(listenSocket, servinfo->ai_addr, servinfo->ai_addrlen) == -1) {
    close(listenSocket);
    perror("bind:");
    exit(EXIT_FAILURE);
  }

  // Libération de la mémoire occupée par les enregistrements
  freeaddrinfo(servinfo);

  printf("Attente de requête sur le port %s\n", listenPort);

  while (1) {

    // Mise à zéro du tampon de façon à connaître le délimiteur
    // de fin de chaîne.
    memset(msg, 0, sizeof msg);
    if (recvfrom(listenSocket, msg, sizeof msg, 0,
                 (struct sockaddr *) &clientAddress,
                 &clientAddressLength) == -1) {
      perror("recvfrom:");
      close(listenSocket);
      exit(EXIT_FAILURE);
    }

    msgLength = strlen(msg);
    if (msgLength > 0) {
      // Affichage de l'adresse IP du client.
      printf(">>  depuis %s", inet_ntoa(clientAddress.sin_addr));

      // Affichage du numéro de port du client.
      printf(":%hu\n", ntohs(clientAddress.sin_port));

      // Affichage de la ligne reçue
      printf("  Message reçu : %s\n", msg);

      // Conversion de cette ligne en majuscules.
      for (i = 0; i < msgLength; i++)
        msg[i] = toupper(msg[i]);

      // Renvoi de la ligne convertie au client.
      if (sendto(listenSocket, msg, msgLength, 0,
                 (struct sockaddr *) &clientAddress,
                 clientAddressLength) == -1) {
        perror("sendto:");
        close(listenSocket);
        exit(EXIT_FAILURE);
      }
    }
  }
}
