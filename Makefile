ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	guides

#	articles	\
	cours		\
	guides		\
	formations	\

# Type(s) de traitement
PROCESS_TYPE = subdirs 

all: $(PROCESS_TYPE)

include $(MAIN_DIR)/common/Makefile.Rules
