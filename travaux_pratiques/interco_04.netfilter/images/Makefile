ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(patsubst %.odg,%.png,$(wildcard *.odg))

# Type(s) de traitement
PROCESS = $(PNGTARGET) symlink

SYMLINKS = $(MAIN_DIR)/travaux_pratiques/interco_03.hub-and-spoke/images/hub-and-spoke-logical-topology.png

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
