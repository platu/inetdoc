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
	sysadm-net.iscsi \
	sysadm-net.nfs \
	sysadm-net.ldap \
	sysadm-net.autofs-ldap-nfs \
	sysadm-net.dns.qa \
	sysadm-net.set \
	interco_01.inter-vlan-iaas \
	interco_02.pppoe \
	interco_03.hub-and-spoke \
	interco_04.netfilter \
	interco_05.ospf \
	interco_06.synthese \
    interco.set \
	interco.ospf-bird

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
	sysadm-net.iscsi/$(ABSTRACT_FILE) \
	sysadm-net.nfs/$(ABSTRACT_FILE) \
	sysadm-net.ldap/$(ABSTRACT_FILE) \
	sysadm-net.autofs-ldap-nfs/$(ABSTRACT_FILE) \
	sysadm-net.dns.qa/$(ABSTRACT_FILE) \
	interco_01.inter-vlan-iaas/$(ABSTRACT_FILE) \
	interco_02.pppoe/$(ABSTRACT_FILE) \
	interco_03.hub-and-spoke/$(ABSTRACT_FILE) \
	interco_04.netfilter/$(ABSTRACT_FILE) \
	interco_05.ospf/$(ABSTRACT_FILE) \
	interco_06.synthese/$(ABSTRACT_FILE) \
	interco.ospf-bird/$(ABSTRACT_FILE) \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
