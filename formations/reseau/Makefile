ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	reseau.xml \
	modelisations.abstract.xml \
	ethernet.abstract.xml \
	lan-segmentation.abstract.xml \
        author.xml \
        legal.xml \
        inetdoc.urls.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

modelisations.abstract.xml: $(MAIN_DIR)/articles/modelisation/$(ABSTRACT_FILE)
	ln -s $< $@

ethernet.abstract.xml: $(MAIN_DIR)/articles/ethernet/$(ABSTRACT_FILE)
	ln -s $< $@

lan-segmentation.abstract.xml: $(MAIN_DIR)/articles/lan-segmentation/$(ABSTRACT_FILE)
	ln -s $< $@

