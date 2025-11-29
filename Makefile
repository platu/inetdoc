ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = \
	images \
	articles \
	guides \
	presentations \
	travaux_pratiques \
	dev \

# Type(s) de traitement
PROCESS = subdirs $(MAIN_DIR)/tp

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

$(MAIN_DIR)/tp:
	ln -s travaux_pratiques tp
