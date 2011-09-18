<![CDATA[
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/if.h>
#include <linux/if_tun.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <errno.h>
#include <unistd.h>

u_int16_t csum_partial(void *buffer, unsigned int len, u_int16_t prevsum)
{
	u_int32_t sum = 0;
	u_int16_t *ptr = buffer;

	while (len > 1)  {
		sum += *ptr++;
		len -= 2;
	}
	if (len) {
		union {
			u_int8_t byte;
			u_int16_t wyde;
		} odd;
		odd.wyde = 0;
		odd.byte = *((u_int8_t *)ptr);
		sum += odd.wyde;
	}
	sum = (sum >> 16) + (sum & 0xFFFF);
	sum += prevsum;
	return (sum + (sum >> 16));
}

int main ()
  {
      struct ifreq ifr;
      int fd, len, err;
      char *buf ;
      char *dev="";
	union {
		struct {
			struct iphdr ip;
		} fmt;
		unsigned char raw[65536];
	} u;

      if( (fd = open("/dev/net/tun", O_RDWR)) < 0 ) {
	 printf("Impossible d'ouvrir /dev/net/tun\n");
	 return -1;
      }

      memset(&ifr, 0, sizeof(ifr));

      /* Flags: IFF_TUN   - TUN device (no Ethernet headers) 
       *        IFF_TAP   - TAP device  
       *
       *        IFF_NO_PI - Do not provide packet information  
       */ 
      ifr.ifr_flags = IFF_TUN|IFF_NO_PI ; 
      if( *dev )
         strncpy(ifr.ifr_name, dev, IFNAMSIZ);

      if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 ){
         close(fd);
         return -1;
      }
      printf("le device utilisé est : %s \n",ifr.ifr_name);

	while ((len = read(fd, &u, sizeof(u))) > 0) {
		u_int32_t tmp;
 		struct icmphdr *icmp
			= (void *)((u_int32_t *)&u.fmt.ip + u.fmt.ip.ihl );
		struct tcphdr *tcp = (void *)icmp;
		struct udphdr *udp = (void *)icmp;
		
		fprintf(stderr, "SRC = %u.%u.%u.%u DST = %u.%u.%u.%u\n",
			(ntohl(u.fmt.ip.saddr) >> 24) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 16) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 8) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 0) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 24) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 16) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 8) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 0) & 0xFF);

		switch (u.fmt.ip.protocol) {
		case IPPROTO_ICMP:
			if (icmp->type == ICMP_ECHO) {
				fprintf(stderr, "PONG! (iphdr = %u bytes)\n",
					(unsigned int)((char *)icmp
						       - (char *)&u.fmt.ip));

				/* Turn it around */
				tmp = u.fmt.ip.saddr;
				u.fmt.ip.saddr = u.fmt.ip.daddr;
				u.fmt.ip.daddr = tmp;

				icmp->type = ICMP_ECHOREPLY;
				icmp->checksum = 0;
				icmp->checksum
					= ~csum_partial(icmp,
							ntohs(u.fmt.ip.tot_len)
							- u.fmt.ip.ihl*4, 0);

				{
					unsigned int i;
					for (i = 44;
					     i < ntohs(u.fmt.ip.tot_len); i++){
						printf("%u:0x%02X ", i,
						       ((unsigned char *)
							&u.fmt.ip)[i]);
					}
					printf("\n");
				}
				write(fd, &u, len);
			}
			break;
		case IPPROTO_TCP:
			fprintf(stderr, "TCP: %u -> %u\n", ntohs(tcp->source),
				ntohs(tcp->dest));
			break;

		case IPPROTO_UDP:
			fprintf(stderr, "UDP: %u -> %u\n", ntohs(udp->source),
				ntohs(udp->dest));
			break;
		}
	}
			
      return 0;
  }              
]]>
