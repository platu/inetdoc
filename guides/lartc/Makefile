ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = xml2xhtml xml2pdf

XML_FILES = lartc.xml

all: $(PROCESS) lartc.html

include $(MAIN_DIR)/common/Makefile.Rules

lartc.html: $(MAIN_DIR)/guides/lartc/index.html
	ln -s $< $@
