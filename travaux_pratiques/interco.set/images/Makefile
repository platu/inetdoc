ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.kernel.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.rawip.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.ppp.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.netfilter.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.inter-vlan.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.ospf-quagga.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.cs/images/*.png) \
	$(MAIN_DIR)/images/titleimage.jpg

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
