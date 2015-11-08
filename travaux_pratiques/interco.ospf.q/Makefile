ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images

# Type(s) de traitement
PROCESS = subdirs qonly symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml \
        $(MAIN_DIR)/common/rfc.urls.xml

XML_FILES = \
	interco.ospf.q.xml \
	inetdoc.urls.xml \
	rfc.urls.xml \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
