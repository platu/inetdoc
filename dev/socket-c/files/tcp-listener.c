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
#define BACKLOG 5
// Utilisation d'une constante x dans la définition
// du format de saisie
#define str(x) # x
#define xstr(x) str(x)

int main()
{
  int listenSocket, connectSocket, status, i;
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
  hints.ai_socktype = SOCK_STREAM; // TCP
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
  
  // Attente des requêtes des clients.
  // Appel non bloquant et passage en mode passif
  // Demandes d'ouverture de connexion traitées par accept
  if (listen(listenSocket, BACKLOG) == -1) {
    perror("listen");
    exit(EXIT_FAILURE);
  }
  
  while (1) {
    printf("Attente de connexion TCP sur le port %s\n", listenPort);

    // Appel accept() bloquant
    // connectSocket est une nouvelle prise indépendante
    if ((connectSocket = accept(listenSocket, 
                                (struct sockaddr *) &clientAddress,
				&clientAddressLength)) == -1) {
      perror("accept:");
      close(listenSocket);
      exit(EXIT_FAILURE);
    }
    
    // Affichage de l'adresse IP du client.
    // inet_ntoa() convertit une adresse IP stockée sous forme binaire en une
    // chaîne de caractères
    printf(">>  connecté à %s", inet_ntoa(clientAddress.sin_addr));

    // Affichage du numéro de port client
    // ntohs() convertit un entier court (short) de l'agencement réseau (octet
    // de poids fort en premier) vers l'agencement hôte (sur x86 on trouve
    // l'octet de poids faible en premier).
    printf(":%hu\n", ntohs(clientAddress.sin_port));

    // Lecture de la chaîne sur le socket en utilisant recv(). La chaîne est
    // stockée dans le tableau msg. Si aucun message n'arrive, recv() reste en
    // attente.
    // On remplit le tableau avec des zéros de façon à connaître la fin de
    // chaîne de caractères
    memset(msg, 0, sizeof msg);
    while (recv(connectSocket, msg, sizeof msg, 0) > 0) {
      msgLength = strlen(msg);
      if (msgLength > 0) {
        printf("  --  %s\n", msg);

        // Conversion de cette ligne en majuscules.
        for (i = 0; i < msgLength; i++)
          msg[i] = toupper(msg[i]);

        // Renvoi de la ligne convertie au client.
        if (send(connectSocket, msg, msgLength + 1, 0) == -1) {
          perror("send:");
          close(listenSocket);
          exit(EXIT_FAILURE);
        }

        memset(msg, 0, sizeof msg);  // Mise à zéro du tampon
      }
    }
  }
}
