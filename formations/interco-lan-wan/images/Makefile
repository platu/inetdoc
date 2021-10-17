ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

PNGTARGET = $(addsuffix .png,$(basename $(wildcard *.odg)))

# Type(s) de traitement
PROCESS = $(PNGTARGET) symlink

SYMLINKS = \
	$(MAIN_DIR)/images/thumbs/thumb*.png \
	$(MAIN_DIR)/travaux_pratiques/interco.ppp.qa/images/WAN-DSL-Topology.png \
	$(MAIN_DIR)/travaux_pratiques/interco.ospf-frr.qa/images/ospf-cloud-logical-topology.png

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
