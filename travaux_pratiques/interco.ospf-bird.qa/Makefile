ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images files

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/author.xml \
	$(MAIN_DIR)/common/legal.xml \
	$(MAIN_DIR)/common/inetdoc.urls.xml \
	$(MAIN_DIR)/common/rfc.urls.xml

XML_FILES = \
	interco.ospf-bird.qa.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	rfc.urls.xml \
	$(wildcard files/*) \
	$(wildcard images/*)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
