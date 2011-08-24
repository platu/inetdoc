ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = xml2xhtml xml2pdf

XML_FILES = zebra.rip.xml

all: $(PROCESS) $(wildcard images/*.png)

include $(MAIN_DIR)/common/Makefile.Rules
