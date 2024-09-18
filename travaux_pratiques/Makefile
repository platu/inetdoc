ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	config.interface.lan \
	dessine-moi-un-reseau \
	config.interface.wlan \
	intro.analyse \
	sysadm-net.iscsi.qa \
	sysadm-net.nfs.qa \
	sysadm-net.ldap.qa \
	sysadm-net.autofs-ldap-nfs.qa \
	sysadm-net.nis.qa \
	sysadm-net.autofs-nis-nfs.qa \
	sysadm-net.dns.qa \
	sysadm-net.set \
	interco.kernel.qa \
	interco.rawip.qa \
	interco.ppp.qa \
	interco.pppoe.qa \
	interco.pppoe-cloud.qa \
	interco.netfilter.qa \
	interco.inter-vlan \
	interco.ospf-frr.qa \
	interco.ospf-bird.qa \
	interco.cs

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	biblio-travaux_pratiques.xml \
	config.interface.lan/$(ABSTRACT_FILE) \
	dessine-moi-un-reseau/$(ABSTRACT_FILE) \
	config.interface.wlan/$(ABSTRACT_FILE) \
	intro.analyse/$(ABSTRACT_FILE) \
	sysadm-net.iscsi.qa/$(ABSTRACT_FILE) \
	sysadm-net.nfs.qa/$(ABSTRACT_FILE) \
	sysadm-net.ldap.qa/$(ABSTRACT_FILE) \
	sysadm-net.autofs-ldap-nfs.qa/$(ABSTRACT_FILE) \
	sysadm-net.nis.qa/$(ABSTRACT_FILE) \
	sysadm-net.autofs-nis-nfs.qa/$(ABSTRACT_FILE) \
	sysadm-net.dns.qa/$(ABSTRACT_FILE) \
	interco.kernel.qa/$(ABSTRACT_FILE) \
	interco.rawip.qa/$(ABSTRACT_FILE) \
	interco.ppp.qa/$(ABSTRACT_FILE) \
	interco.pppoe.qa/$(ABSTRACT_FILE) \
	interco.pppoe-cloud.qa/$(ABSTRACT_FILE) \
	interco.netfilter.qa/$(ABSTRACT_FILE) \
	interco.inter-vlan/$(ABSTRACT_FILE) \
	interco.ospf-frr.qa/$(ABSTRACT_FILE) \
	interco.ospf-bird.qa/$(ABSTRACT_FILE) \
	interco.cs/$(ABSTRACT_FILE) \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
