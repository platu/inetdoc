ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	infra.tp \
	if-lan.qa \
	intro.analyse \
	interco.kernel.qa \
	interco.kernel.q \
	interco.rawip.qa \
	interco.rawip.q \
	interco.ppp.qa \
	interco.ppp.q \
	interco.netfilter.qa \
	interco.netfilter.q \
	interco.inter-vlan.qa \
	interco.ospf.qa \
	interco.ospf.q \
	interco.cs

# Type(s) de traitement
PROCESS = subdirs xml2xhtml xml2pdf

XML_FILES = \
	biblio-travaux_pratiques.xml \
	infra.tp/$(ABSTRACT_FILE) \
	config.interface.lan/$(ABSTRACT_FILE) \
	intro.analyse/$(ABSTRACT_FILE) \
	interco.kernel.q/$(ABSTRACT_FILE) \
	interco.rawip.q/$(ABSTRACT_FILE) \
	interco.ppp.q/$(ABSTRACT_FILE) \
	interco.netfilter.q/$(ABSTRACT_FILE) \
	interco.inter-vlan.qa/$(ABSTRACT_FILE) \
	interco.ospf.q/$(ABSTRACT_FILE) \
	interco.cs/$(ABSTRACT_FILE)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
