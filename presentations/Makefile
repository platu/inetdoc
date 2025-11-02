ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	sysadm-c1 \
	sysadm-base-2 \
	sysadm-base-3 \
	sysadm-base-4 \
	sysadm-base-5 \
	sysadm-base-6 \
	asr-c1 \
	asr-c2 \
	asr-c3 \
    interco-c1

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-presentations.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
