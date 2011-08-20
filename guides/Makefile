ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	autodoc

#	lartc				\
	rnis				\
	iptables-tutorial		\
	zebra.statique			\
	zebra.rip			\
	zebra.ospf

# Type(s) de traitement
PROCESS = subdirs xml2xhtml

FILES = Advanced-routing-Howto

XML_FILES = \
	biblio.xml

#	guides.biblio.xml \
	lartc/status.xml \
	lartc/abstract.xml \
	rnis/status.xml \
	rnis/abstract.xml \
	zebra.statique/status.xml \
	zebra.statique/abstract.xml \
	zebra.ospf/status.xml \
	zebra.ospf/abstract.xml \
	zebra.rip/status.xml \
	zebra.rip/abstract.xml \

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
