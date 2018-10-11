ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(MAIN_DIR)/images/thumbs/thumb*.png \
	$(MAIN_DIR)/travaux_pratiques/intro.analyse/images/wireshark-thumb.png \
	$(MAIN_DIR)/travaux_pratiques/sysadm-net.iscsi.qa/images/targetcli.png \
	$(MAIN_DIR)/travaux_pratiques/sysadm-net.ldap.qa/images/ldap-tree.png \
	$(MAIN_DIR)/travaux_pratiques/sysadm-net.autofs-ldap-nfs.qa/images/ldap-automount.png \
	$(MAIN_DIR)/travaux_pratiques/interco.ppp.qa/images/WAN-DSL-Topology.png \
	$(MAIN_DIR)/travaux_pratiques/interco.pppoe.qa/images/WAN-FTTH-Topology.png \
	$(MAIN_DIR)/travaux_pratiques/interco.ospf-quagga.qa/images/interco.ospf.physical-topology.png \
	$(MAIN_DIR)/articles/inter-vlan-routing-openvswitch/images/ovs-vm.png

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
