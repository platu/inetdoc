ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

SYMLINKS = \
        $(MAIN_DIR)/travaux_pratiques/interco.ospf-bird.qa/images/interco.ospf.ns.odg

# Type(s) de traitement
PROCESS = symlink $(PNGTARGET)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
