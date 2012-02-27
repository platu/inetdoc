#include <netdb.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_MSG 100
// 2 caractères pour les codes ASCII '\n' et '\0'
#define MSG_ARRAY_SIZE (MAX_MSG+2)
// Utilisation d'une constante x dans la définition
// du format de saisie
#define str(x) # x
#define xstr(x) str(x)

int main()
{
  int socketDescriptor;
  int msgLength;
  unsigned short int serverPort;
  struct sockaddr_in serverAddress;
  struct hostent *hostInfo;
  struct timeval timeVal;
  fd_set readSet;
  char msg[MSG_ARRAY_SIZE];

  puts("Entrez le nom du serveur ou son adresse IP : ");

  memset(msg, 0x0, MSG_ARRAY_SIZE);  // Mise à zéro du tampon
  scanf("%"xstr(MAX_MSG)"s", msg);

  // gethostbyname() reçoit un nom d'hôte ou une adresse IP en notation
  // standard 4 octets en décimal séparés par des points puis renvoie un
  // pointeur sur une structure hostent. Nous avons besoin de cette structure
  // plus loin. La composition de cette structure n'est pas importante pour
  // l'instant.
  hostInfo = gethostbyname(msg);
  if (hostInfo == NULL) {
    fprintf(stderr, "Problème dans l'interprétation des informations d'hôte : %s\n", msg);
    exit(EXIT_FAILURE);
  }

  puts("Entrez le numéro de port du serveur : ");
  scanf("%hu", &serverPort);

  // Création de socket. "PF_INET" correspond à la famille de protocole IPv4.
  // "SOCK_DGRAM" correspond à un service de datagramme non orienté connexion.
  // "IPPROTO_UDP" désigne le protocole UDP utilisé au niveau transport.
  socketDescriptor = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
  if (socketDescriptor < 0) {
    fputs("Impossible de créer le socket", stderr);
    exit(EXIT_FAILURE);
  }

  // Initialisation des champs de la structure serverAddress
  serverAddress.sin_family = hostInfo->h_addrtype;
  memcpy((char *) &serverAddress.sin_addr.s_addr,
         hostInfo->h_addr_list[0], hostInfo->h_length);
  serverAddress.sin_port = htons(serverPort);

  puts("\nEntrez quelques caractères au clavier.");
  puts("Le serveur les modifiera et les renverra.");
  puts("Pour sortir, entrez une ligne avec le caractère '.' uniquement.");
  puts("Si une ligne dépasse "xstr(MAX_MSG)" caractères,");
  puts("seuls les "xstr(MAX_MSG)" premiers caractères seront utilisés.\n");

  // Invite de commande pour l'utilisateur et lecture des caractères jusqu'à la
  // limite MAX_MSG. Puis suppression du saut de ligne en mémoire tampon.
  puts("Saisie du message : ");
  memset(msg, 0x0, MSG_ARRAY_SIZE);  // Mise à zéro du tampon
  scanf(" %"xstr(MAX_MSG)"[^\n]%*c", msg);

  // Arrêt lorsque l'utilisateur saisit une ligne ne contenant qu'un point
  while (strcmp(msg, ".")) {
    if ((msgLength = strlen(msg)) > 0) {
      // Envoi de la ligne au serveur
      if (sendto(socketDescriptor, msg, msgLength, 0,
                 (struct sockaddr *) &serverAddress,
                 sizeof(serverAddress)) < 0) {
        fputs("Émission du message impossible", stderr);
        close(socketDescriptor);
        exit(EXIT_FAILURE);
      }

      // Attente de la réponse pendant une seconde.
      FD_ZERO(&readSet);
      FD_SET(socketDescriptor, &readSet);
      timeVal.tv_sec = 1;
      timeVal.tv_usec = 0;

      if (select(socketDescriptor+1, &readSet, NULL, NULL, &timeVal)) {
        // Lecture de la ligne modifiée par le serveur.
        memset(msg, 0x0, MSG_ARRAY_SIZE);  // Mise à zéro du tampon
        if (recv(socketDescriptor, msg, MAX_MSG, 0) < 0) {
          fputs("Aucune réponse du serveur ?", stderr);
          close(socketDescriptor);
          exit(EXIT_FAILURE);
        }

        printf("Message traité : %s\n", msg);
      }
      else {
        puts("** Le serveur n'a répondu dans la seconde.");
      }
    }
    // Invite de commande pour l'utilisateur et lecture des caractères jusqu'à la
    // limite MAX_MSG. Puis suppression du saut de ligne en mémoire tampon.
    // Comme ci-dessus.
    puts("Saisie du message : ");
    memset(msg, 0x0, MSG_ARRAY_SIZE);  // Mise à zéro du tampon
    scanf(" %"xstr(MAX_MSG)"[^\n]%*c", msg);
  }

  close(socketDescriptor);
  return 0;
}
