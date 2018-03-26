ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))
SVGTARGET = $(addsuffix .svg,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = symlink $(PNGTARGET) $(SVGTARGET)

SYMLINKS = \
        $(MAIN_DIR)/images/thumbs/thumb006.png

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
