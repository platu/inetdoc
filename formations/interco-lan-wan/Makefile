ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images

# Type(s) de traitement
PROCESS = symlink subdirs xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/authorgroup.xml \
	$(MAIN_DIR)/common/legalgroup.xml \
	$(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	interco-lan-wan.xml \
	cs2.abstract.xml \
	tp1.abstract.xml \
	tp2.abstract.xml \
	tp3.abstract.xml \
	tp4.abstract.xml \
	tp5.abstract.xml \
	tp6.abstract.xml \
	tp7.abstract.xml \
	authorgroup.xml \
	legalgroup.xml \
	inetdoc.urls.xml \
	$(wildcard images/*)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

cs2.abstract.xml: $(MAIN_DIR)/guides/linux.networking/$(ABSTRACT_FILE)
	ln -s $< $@

tp1.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.kernel.q/$(ABSTRACT_FILE)
	ln -s $< $@

tp2.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.rawip.q/$(ABSTRACT_FILE)
	ln -s $< $@

tp3.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.ppp.q/$(ABSTRACT_FILE)
	ln -s $< $@

tp4.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.netfilter.q/$(ABSTRACT_FILE)
	ln -s $< $@

tp5.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.inter-vlan.qa/$(ABSTRACT_FILE)
	ln -s $< $@

tp6.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.ospf-quagga.q/$(ABSTRACT_FILE)
	ln -s $< $@

tp7.abstract.xml: $(MAIN_DIR)/travaux_pratiques/interco.cs/$(ABSTRACT_FILE)
	ln -s $< $@
