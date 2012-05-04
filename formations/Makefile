ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	reseau \
	sysadm-base \
	interco-lan-wan \
	security

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-formations.xml \
	reseau/$(ABSTRACT_FILE) \
	sysadm-base/$(ABSTRACT_FILE) \
	interco-lan-wan/$(ABSTRACT_FILE) \
	security/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
