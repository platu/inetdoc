ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SVGTARGET = $(addsuffix .svg,$(basename $(wildcard *.odg)))
# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
        $(MAIN_DIR)/images/thumbs/thumb006.png

all: $(PROCESS) $(SVGTARGET)

include $(MAIN_DIR)/common/Makefile.Rules
