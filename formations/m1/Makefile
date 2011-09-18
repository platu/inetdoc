ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/authorgroup.xml \
        $(MAIN_DIR)/common/legalgroup.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = m1.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
