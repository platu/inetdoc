ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	infosecconcepts \
	dynamips-dynagen \
	devmgmt \
	modelisation \
	wireshark-as-user \
	rnis \
	pppoe \
	adressage.ipv4 \
	ospf-migration \
	ospf-triangle-multiple-default \
	lan-segmentation \
	inter-vlan-routing

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-articles.xml \
	infosecconcepts/$(ABSTRACT_FILE) \
	dynamips-dynagen/$(ABSTRACT_FILE) \
	devmgmt/$(ABSTRACT_FILE) \
	modelisation/$(ABSTRACT_FILE) \
	wireshark-as-user/$(ABSTRACT_FILE) \
	rnis/$(ABSTRACT_FILE) \
	pppoe/$(ABSTRACT_FILE) \
	adressage.ipv4/$(ABSTRACT_FILE) \
	ospf-migration/$(ABSTRACT_FILE) \
	ospf-triangle-multiple-default/$(ABSTRACT_FILE) \
	lan-segmentation/$(ABSTRACT_FILE) \
	inter-vlan-routing/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
