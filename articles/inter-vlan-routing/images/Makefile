ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = $(SVGTARGET) $(PNGTARGET)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
