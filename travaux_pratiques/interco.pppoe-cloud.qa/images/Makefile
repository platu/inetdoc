ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(patsubst %.odg,%.png,$(wildcard *.odg))

# Type(s) de traitement
PROCESS = $(PNGTARGET)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
