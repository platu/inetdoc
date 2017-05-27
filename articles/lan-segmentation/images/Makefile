ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SVGTARGET = $(addsuffix .svg,$(basename $(wildcard *.odg)))
PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(MAIN_DIR)/images/thumbs/thumb004.png \
	$(MAIN_DIR)/articles/modelisation/images/modelisation-osi.svg

all: $(PROCESS) $(SVGTARGET) $(PNGTARGET)

include $(MAIN_DIR)/common/Makefile.Rules
