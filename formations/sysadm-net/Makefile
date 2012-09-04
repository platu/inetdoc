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
        inetdoc.urls.xml
#	seance1.abstract.xml \
#	seance2.abstract.xml \
#	seance3.abstract.xml \
#	seance4.abstract.xml \
#	seance5.abstract.xml \
#	seance6.abstract.xml \

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

seance1.abstract.xml: $(MAIN_DIR)/guides/linux.networking/$(ABSTRACT_FILE)
	ln -s $< $@

