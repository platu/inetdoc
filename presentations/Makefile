ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	sysadm-base-1 \
	sysadm-base-2 \
	stockage-reseau \
	network-filesystems

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-presentations.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
