<![CDATA[
#include <stdio.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>

main ()
{

int sock_fd ;
struct sockaddr_ll sll;
struct ifreq ifr;
char buffer[2000];
int nb_octet;

if (sock_fd = socket(AF_PACKET,SOCK_RAW,htons(ETH_P_ALL)) == -1 ) {
		printf("Erreur dans la création de la socket\n");
		return-1 ;
	}

memset(&ifr, 0, sizeof(ifr));
strncpy (ifr.ifr_name, "eth0", sizeof(ifr.ifr_name));

if (ioctl(sock_fd,SIOCGIFINDEX, &ifr) == -1 ) {
		printf("Erreur dans la recherche de index\n");
		return -1 ;
	}

memset(&sll, 0, sizeof(sll));
sll.sll_family = AF_PACKET ;
sll.sll_ifindex = ifr.ifr_ifindex ;
sll.sll_protocol = htons(ETH_P_ALL);

if (bind(sock_fd, (struct sockaddr *) &sll, sizeof(sll)) == -1) {
		printf("Erreur avec bind\n");
		return -1 ;
	};

	nb_octet=recvfrom(sock_fd,buffer,sizeof(buffer),0,NULL,0);
	printf("Nombre d'octets reçus : %d\n",nb_octet);
}
]]>
