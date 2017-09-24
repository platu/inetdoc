ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(MAIN_DIR)/images/thumbs/thumb004.png \
	$(MAIN_DIR)/articles/modelisation/images/modelisation-osi.svg \
	$(MAIN_DIR)/articles/inter-vlan-routing/images/ieee8021q-frame.svg

all: $(PROCESS) $(SVGTARGET) $(PNGTARGET)

include $(MAIN_DIR)/common/Makefile.Rules
