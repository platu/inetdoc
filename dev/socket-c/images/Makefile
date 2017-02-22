ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SVGTARGET = $(addsuffix .svg,$(basename $(wildcard *.odg)))
PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(MAIN_DIR)/images/thumbs/thumb009.png

all: $(PROCESS) $(SVGTARGET) $(PNGTARGET)

include $(MAIN_DIR)/common/Makefile.Rules
