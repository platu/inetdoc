ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/author.xml \
	$(MAIN_DIR)/common/legal.xml \
	$(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
    synthese.xml \
    $(MAIN_DIR)/travaux_pratiques/interco_02.pppoe/pppoe.xml \
    $(MAIN_DIR)/travaux_pratiques/interco_03.hub-and-spoke/hub-and-spoke.xml \
    $(MAIN_DIR)/travaux_pratiques/interco_05.ospf/ospf.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	images/*.odg

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
