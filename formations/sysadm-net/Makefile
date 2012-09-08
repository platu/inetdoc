ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	sysadm-net.xml \
        author.xml \
        legal.xml \
        inetdoc.urls.xml \
	sysadm-net.iscsi.abstract.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

sysadm-net.iscsi.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.iscsi.q/$(ABSTRACT_FILE)
	ln -s $< $@

