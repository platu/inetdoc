#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define MAX_MSG 80
#define MSG_ARRAY_SIZE (MAX_MSG+1)

int main()
{
  int listenSocket, i;
  unsigned short int listenPort, msgLength;
  struct sockaddr_in clientAddress, serverAddress;
  socklen_t clientAddressLength = sizeof clientAddress;
  char msg[MSG_ARRAY_SIZE];

  puts("Entrez le numéro de port utilisé en écoute (entre 1500 et 65000) : ");
  scanf("%hu", &listenPort);

  // Création de socket en écoute et attente des requêtes des clients
  if ((listenSocket = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1) {
    perror("socket:");
    exit(EXIT_FAILURE);
  }
  
  // On relie le socket au port en écoute.
  // On commence par initialiser les champs de la structure serverAddress puis
  // on appelle bind(). Les fonctions htonl() et htons() convertissent
  // respectivement les entiers longs et les entiers courts du rangement hôte
  // (sur x86 on trouve l'octet de poids faible en premier) vers le rangement
  // réseau (octet de poids fort en premier).
  serverAddress.sin_family = PF_INET;
  serverAddress.sin_addr.s_addr = htonl(INADDR_ANY);
  serverAddress.sin_port = htons(listenPort);
  
  if (bind(listenSocket, (struct sockaddr *) &serverAddress, sizeof(serverAddress)) == -1) {
    perror("bind:");
    close(listenSocket);
    exit(EXIT_FAILURE);
  }

  printf("Attente de requête sur le port %hu\n", listenPort);

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
