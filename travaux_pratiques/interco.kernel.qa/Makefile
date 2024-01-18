ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	interco.kernel.qa.xml \
        author.xml \
        legal.xml \
	inetdoc.urls.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
