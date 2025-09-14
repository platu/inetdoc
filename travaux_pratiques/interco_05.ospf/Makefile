ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/author.xml \
	$(MAIN_DIR)/common/legal.xml \
	$(MAIN_DIR)/common/inetdoc.urls.ent \
	$(MAIN_DIR)/common/rfc.urls.ent

XML_FILES = \
	ospf.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.ent \
	rfc.urls.ent \
	$(wildcard files/*) \
	$(wildcard images/*)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
