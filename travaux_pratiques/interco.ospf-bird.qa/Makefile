ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images files

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
	$(MAIN_DIR)/common/author.xml \
	$(MAIN_DIR)/common/legal.xml \
	$(MAIN_DIR)/common/inetdoc.urls.xml \
	$(MAIN_DIR)/common/rfc.urls.xml

XML_FILES = \
	interco.ospf-bird.qa.xml \
	addressing.xml \
	vm.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	rfc.urls.xml \
	$(wildcard files/*) \
	$(wildcard images/*)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

addressing.xml: $(MAIN_DIR)/travaux_pratiques/interco.ospf-quagga.qa/interco.ospf-quagga.qa.xml
	sed -n -e "/interco\.ospf-quagga\.archi/,/\/sect1/{p; /\/sect1/q}" $? > $@
	sed -i "s/quagga/bird/g" $@

vm.xml: $(MAIN_DIR)/travaux_pratiques/interco.ospf-quagga.qa/interco.ospf-quagga.qa.xml
	sed -n -e "/interco\.ospf-quagga\.vm/,/\/sect1/{p; /\/sect1/q}" $? > $@
	sed -i "s/quagga/bird/g" $@
