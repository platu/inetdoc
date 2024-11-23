ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco_01.inter-vlan-iaas/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco_02.pppoe/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco_03.hub-and-spoke/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco_04.netfilter/images/*.jpeg) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco_05.ospf/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco_06.synthese/images/*.png) \
	$(MAIN_DIR)/images/titleimage.jpg

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
