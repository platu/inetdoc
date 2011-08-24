ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	autodoc \
	lartc \
	zebra.statique \
	zebra.rip \
	zebra.ospf \
	iptables-tutorial

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

FILES = Advanced-routing-Howto

XML_FILES = \
	biblio-guides.xml \
	lartc/$(ABSTRACT_FILE) \
	zebra.statique/$(ABSTRACT_FILE) \
	zebra.rip/$(ABSTRACT_FILE) \
	zebra.ospf/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
