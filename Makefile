ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	guides \
	presentations

#	articles	\
	cours		\
	formations	\

# Type(s) de traitement
PROCESS = subdirs 

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
