ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	socket-c \
	socket-qt

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-dev.xml \
	socket-c/$(ABSTRACT_FILE) \
	socket-qt/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
