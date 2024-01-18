ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	lartc \
	iptables-tutorial \
	tutoriel-secu \
	amavisd-new \
	squid-guard \
	vm \
	linux.networking

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-guides.xml \
	lartc/$(ABSTRACT_FILE) \
	amavisd-new/$(ABSTRACT_FILE) \
	squid-guard/$(ABSTRACT_FILE) \
	vm/$(ABSTRACT_FILE) \
	linux.networking/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
