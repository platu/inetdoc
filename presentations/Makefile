ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	os-arch-hints \
	sysadm-base-1 \
	sysadm-base-2 \
	sysadm-base-3 \
	sysadm-base-4 \
	sysadm-base-5 \
	sysadm-base-6 \
	net-storage \
	net-identity \
	net-filesystems-object-storage \
    interco-c1

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-presentations.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
