ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = xml2xhtml xml2pdf

XML_FILES = \
    iptables-tutorial.xml \
    bookinfo.xml \
    $(wildcard images/*.png chapters/*.xml appendices/*.xml licensing/*.xml scripts/*)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
