ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = symlink $(PNGTARGET)

SYMLINKS = $(MAIN_DIR)/travaux_pratiques/interco.ospf-quagga.qa/images/*.png

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
