# $Id: Makefile 1043 2007-01-28 08:56:35Z latu $
# - philippe.latu(at)linux-france.org

# Répertoire racine
ifndef $(MAIN_DIR)
MAIN_DIR = prj/inetdoc
endif

# Répertoire courant
ifndef $(DIR)
DIR = $(MAIN_DIR)/securite/tutoriel/images
endif

ifndef $(DEPTH)
DEPTH = $(shell echo $(DIR) | sed 's/[-._a-zA-Z0-9]*/\.\./g')
endif

# Type(s) de traitement
PROCESS_TYPE = dirs symlink file

SYMLINKS = \
	$(DEPTH)/$(MAIN_DIR)/images/*[0-9].png \
	$(DEPTH)/$(MAIN_DIR)/images/note.png

FILES = $(wildcard *.png)

all: $(PROCESS_TYPE)

include $(DEPTH)/common/Makefile.Rules
