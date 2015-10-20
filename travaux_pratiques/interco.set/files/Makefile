ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.kernel.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.rawip.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.ppp.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.netfilter.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.inter-vlan.qa/files/*) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.ospf.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/interco.ospf.qa/files/*.sh)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
