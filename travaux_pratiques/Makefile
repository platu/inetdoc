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
	sysadm-net.iscsi.q \
	sysadm-net.nfs.qa \
	sysadm-net.nfs.q \
	sysadm-net.ldap.qa \
	sysadm-net.ldap.q \
	sysadm-net.autofs-ldap-nfs.qa \
	sysadm-net.autofs-ldap-nfs.q \
	sysadm-net.nis.qa \
	sysadm-net.nis.q \
	sysadm-net.autofs-nis-nfs.qa \
	sysadm-net.autofs-nis-nfs.q \
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
	interco.netfilter.qa \
	interco.netfilter.q \
	interco.inter-vlan.qa \
	interco.ospf.qa \
	interco.ospf.q \
	interco.ovs.qa \
	interco.ovs.q \
	interco.cs \
	interco.set

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-travaux_pratiques.xml \
	infra.tp/$(ABSTRACT_FILE) \
	config.interface.lan/$(ABSTRACT_FILE) \
	dessine-moi-un-reseau/$(ABSTRACT_FILE) \
	config.interface.wlan/$(ABSTRACT_FILE) \
	intro.analyse/$(ABSTRACT_FILE) \
	sysadm-net.iscsi.q/$(ABSTRACT_FILE) \
	sysadm-net.nfs.q/$(ABSTRACT_FILE) \
	sysadm-net.ldap.q/$(ABSTRACT_FILE) \
	sysadm-net.autofs-ldap-nfs.q/$(ABSTRACT_FILE) \
	sysadm-net.nis.q/$(ABSTRACT_FILE) \
	sysadm-net.autofs-nis-nfs.q/$(ABSTRACT_FILE) \
	sysadm-net.dns.q/$(ABSTRACT_FILE) \
	interco.kernel.q/$(ABSTRACT_FILE) \
	interco.rawip.q/$(ABSTRACT_FILE) \
	interco.ppp.q/$(ABSTRACT_FILE) \
	interco.netfilter.q/$(ABSTRACT_FILE) \
	interco.inter-vlan.qa/$(ABSTRACT_FILE) \
	interco.ospf.q/$(ABSTRACT_FILE) \
	interco.ovs.q/$(ABSTRACT_FILE) \
	interco.cs/$(ABSTRACT_FILE) \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
