ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(MAIN_DIR)/images/thumbs/thumb009.png

all: $(PROCESS) $(PNGTARGET)

include $(MAIN_DIR)/common/Makefile.Rules
