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
	adressage.ipv4.abstract.xml \
	config.interface.lan.abstract.xml \
	dessine.moi.un.reseau.abstract.xml \
	intro.analyse.abstract.xml \
	socket-c.abstract.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

modelisations.abstract.xml: $(MAIN_DIR)/articles/modelisation/$(ABSTRACT_FILE)
	ln -s $< $@

ethernet.abstract.xml: $(MAIN_DIR)/articles/ethernet/$(ABSTRACT_FILE)
	ln -s $< $@

lan-segmentation.abstract.xml: $(MAIN_DIR)/articles/lan-segmentation/$(ABSTRACT_FILE)
	ln -s $< $@

adressage.ipv4.abstract.xml: $(MAIN_DIR)/articles/adressage.ipv4/$(ABSTRACT_FILE)
	ln -s $< $@

config.interface.lan.abstract.xml: $(MAIN_DIR)/travaux_pratiques/config.interface.lan/$(ABSTRACT_FILE)
	ln -s $< $@

dessine.moi.un.reseau.abstract.xml: $(MAIN_DIR)/travaux_pratiques/dessine-moi-un-reseau/$(ABSTRACT_FILE)
	ln -s $< $@

intro.analyse.abstract.xml: $(MAIN_DIR)/travaux_pratiques/intro.analyse/$(ABSTRACT_FILE)
	ln -s $< $@

socket-c.abstract.xml: $(MAIN_DIR)/dev/socket-c/$(ABSTRACT_FILE)
	ln -s $< $@
