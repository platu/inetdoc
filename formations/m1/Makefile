ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/authorgroup.xml \
        $(MAIN_DIR)/common/legalgroup.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml \

XML_FILES = \
	m1.xml \
	linux.networking.abstract.xml \
	noyau.tp.abstract.xml \
	rawip.tp.abstract.xml


all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

linux.networking.abstract.xml: $(MAIN_DIR)/guides/linux.networking/$(ABSTRACT_FILE)
	ln -s $< $@

noyau.tp.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.kernel.q/$(ABSTRACT_FILE)
	ln -s $< $@

rawip.tp.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.rawip.q/$(ABSTRACT_FILE)
	ln -s $< $@
