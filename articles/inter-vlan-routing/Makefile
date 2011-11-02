ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml

XML_FILES = \
	inter-vlan-routing.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
