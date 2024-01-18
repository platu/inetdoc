ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = xml2xhtml xml2pdf

XML_FILES = iptables-tutorial.xml $(wildcard images/*.png chapters/*.xml scripts/*)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
