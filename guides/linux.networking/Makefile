ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/authorgroup.xml \
        $(MAIN_DIR)/common/legalgroup.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	linux.networking.xml \
        authorgroup.xml \
        legalgroup.xml \
	inetdoc.urls.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
