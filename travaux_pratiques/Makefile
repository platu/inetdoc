ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	infra.tp \
	config.interface.lan \
	dessine-moi-un-reseau \
	config.interface.wlan \
	intro.analyse \
	sysadm-net.iscsi.qa \
	sysadm-net.nfs.qa \
	sysadm-net.ldap.qa \
	sysadm-net.ldap.q \
	sysadm-net.autofs-ldap-nfs.qa \
	sysadm-net.autofs-ldap-nfs.q \
	sysadm-net.nis.qa \
	sysadm-net.autofs-nis-nfs.qa \
	sysadm-net.dns.qa \
	sysadm-net.dns.q \
	sysadm-net.set \
	interco.kernel.qa \
	interco.kernel.q \
	interco.rawip.qa \
	interco.rawip.q \
	interco.ppp.qa \
	interco.ppp.q \
	interco.pppoe.qa \
	interco.pppoe.q \
	interco.pppoe-cloud.qa \
	interco.pppoe-cloud.q \
	interco.netfilter.qa \
	interco.netfilter.q \
	interco.inter-vlan.qa \
	interco.inter-vlan-cloud.qa \
	interco.ospf-quagga.qa \
	interco.ospf-quagga.q \
	interco.ospf-bird.qa \
	interco.ospf-bird.q \
	interco.cs

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	biblio-travaux_pratiques.xml \
	infra.tp/$(ABSTRACT_FILE) \
	config.interface.lan/$(ABSTRACT_FILE) \
	dessine-moi-un-reseau/$(ABSTRACT_FILE) \
	config.interface.wlan/$(ABSTRACT_FILE) \
	intro.analyse/$(ABSTRACT_FILE) \
	sysadm-net.iscsi.qa/$(ABSTRACT_FILE) \
	sysadm-net.nfs.qa/$(ABSTRACT_FILE) \
	sysadm-net.ldap.q/$(ABSTRACT_FILE) \
	sysadm-net.autofs-ldap-nfs.q/$(ABSTRACT_FILE) \
	sysadm-net.nis.qa/$(ABSTRACT_FILE) \
	sysadm-net.autofs-nis-nfs.qa/$(ABSTRACT_FILE) \
	sysadm-net.dns.q/$(ABSTRACT_FILE) \
	interco.kernel.q/$(ABSTRACT_FILE) \
	interco.rawip.q/$(ABSTRACT_FILE) \
	interco.ppp.q/$(ABSTRACT_FILE) \
	interco.pppoe.q/$(ABSTRACT_FILE) \
	interco.pppoe-cloud.q/$(ABSTRACT_FILE) \
	interco.netfilter.q/$(ABSTRACT_FILE) \
	interco.inter-vlan.qa/$(ABSTRACT_FILE) \
	interco.ospf-quagga.q/$(ABSTRACT_FILE) \
	interco.cs/$(ABSTRACT_FILE) \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
