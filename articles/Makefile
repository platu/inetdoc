ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	infosecconcepts \
	modelisation \
	ethernet \
	adressage.ipv4 \
	autoconf-ipv6 \
	ospf-triangle-multiple-default \
	lan-segmentation \
	inter-vlan-routing \
	inter-vlan-routing-openvswitch \
	site2site-ipsecvpn \
	images

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-articles.xml \
	$(wildcard images/*.png) \
	infosecconcepts/$(ABSTRACT_FILE) \
	modelisation/$(ABSTRACT_FILE) \
	ethernet/$(ABSTRACT_FILE) \
	adressage.ipv4/$(ABSTRACT_FILE) \
	autoconf-ipv6/$(ABSTRACT_FILE) \
	ospf-triangle-multiple-default/$(ABSTRACT_FILE) \
	lan-segmentation/$(ABSTRACT_FILE) \
	inter-vlan-routing/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
