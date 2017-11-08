ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(MAIN_DIR)/travaux_pratiques/interco.ospf-bird.qa/files/*.{sh,patch} \
	$(MAIN_DIR)/travaux_pratiques/interco.ospf-bird.qa/files/*interfaces*

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
