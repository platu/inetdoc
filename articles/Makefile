ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	infosecconcepts \
	dynamips-dynagen \
	devmgmt \
	modelisation \
	pppoe \
	adressage.ipv4

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-articles.xml \
	infosecconcepts/$(ABSTRACT_FILE) \
	dynamips-dynagen/$(ABSTRACT_FILE) \
	devmgmt/$(ABSTRACT_FILE) \
	modelisation/$(ABSTRACT_FILE) \
	adressage.ipv4/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
