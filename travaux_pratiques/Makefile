ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	archi.tp

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-travaux_pratiques.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
