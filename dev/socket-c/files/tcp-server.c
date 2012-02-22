#include <arpa/inet.h>
#include <netdb.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_MSG 100
// 2 caractères pour les codes ASCII '\n' et '\0'
#define MSG_ARRAY_SIZE (MAX_MSG+2)

int main()
{
  int listenSocket, connectSocket, i;
  unsigned short int listenPort, msgLength;
  socklen_t clientAddressLength;
  struct sockaddr_in clientAddress, serverAddress;
  char msg[MSG_ARRAY_SIZE];

  puts("Entrez le numéro de port utilisé en écoute (entre 1500 et 65000) : ");
  scanf("%hu", &listenPort);

  // Création de socket en écoute et attente des requêtes des clients
  listenSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (listenSocket < 0) {
    fputs("Impossible de créer le socket en écoute", stderr);
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
  
  if (bind(listenSocket,
           (struct sockaddr *) &serverAddress,
           sizeof(serverAddress)) < 0) {
    fputs("Impossible de lier le socket en écoute", stderr);
    exit(EXIT_FAILURE);
  }

  // Attente des requêtes des clients.
  // C'est un appel non bloquant ; c'est-à-dire qu'il enregistre ce programme
  // auprès du système comme devant attendre des connexions sur ce socket avec
  // cette tâche. Ensuite, l'exécution se poursuit.
  listen(listenSocket, 5);
  
  while (1) {
    printf("Attente de connexion TCP sur le port %hu\n", listenPort);

    // On accepte une connexion avec un client qui en demande une. L'appel à la
    // fonction accept() est bloquant ; c'est-à-dire que le processus est
    // arrêté jusqu'à l'arrivée d'une demande de connexion. 
    // connectSocket est un nouveau socket que le système fournit séparément du
    // socket d'écoute listenSocket. Il serait possible d'accepter des
    // connexions supplémentaires reçues par listenSocket avant que
    // connectSocket soit clos ; mais ce programme ne fonctionne pas de cette
    // façon.
    clientAddressLength = sizeof(clientAddress);

    connectSocket = accept(listenSocket,
                           (struct sockaddr *) &clientAddress,
	                   &clientAddressLength);

    if (connectSocket < 0) {
      fputs("Impossible d'accepter une connexion", stderr);
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
    memset(msg, 0x0, MSG_ARRAY_SIZE);
    while (recv(connectSocket, msg, MAX_MSG, 0) > 0) {
      msgLength = strlen(msg);
      if (msgLength > 0) {
        printf("  --  %s\n", msg);

        // Conversion de cette ligne en majuscules.
        for (i = 0; i < msgLength; i++)
          msg[i] = toupper(msg[i]);

        // Renvoi de la ligne convertie au client.
        if (send(connectSocket, msg, msgLength + 1, 0) < 0)
          fputs("Émission du message modifié impossible", stderr);

        memset(msg, 0x0, MSG_ARRAY_SIZE);  // Mise à zéro du tampon
      }
    }
  }
}
