ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SUBDIRS = files

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml \
        $(MAIN_DIR)/common/rfc.urls.xml

XML_FILES = \
	interco.ospf.qa.xml \
        author.xml \
        legal.xml \
	inetdoc.urls.xml \
	rfc.urls.xml \
	images/*.odg

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
