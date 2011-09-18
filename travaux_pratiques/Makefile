ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	archi.tp \
	config.interface.lan \
	intro.analyse \
	interco.netfilter.qa \
	interco.netfilter.q \
	inter-vlan.routing

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-travaux_pratiques.xml \
	archi.tp/$(ABSTRACT_FILE) \
	config.interface.lan/$(ABSTRACT_FILE) \
	intro.analyse/$(ABSTRACT_FILE) \
	interco.netfilter.q/$(ABSTRACT_FILE) \
	inter-vlan.routing/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
