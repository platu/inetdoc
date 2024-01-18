# $Id: Makefile 1321 2008-09-24 08:21:50Z latu $
# - philippe.latu(at)linux-france.org

# Répertoire racine
ifndef $(MAIN_DIR)
MAIN_DIR = prj/inetdoc
endif

# Répertoire courant
ifndef $(DIR)
DIR = $(MAIN_DIR)/guides/iptables-tutorial/images
endif

ifndef $(DEPTH)
DEPTH = $(shell echo $(DIR) | sed 's/[-._a-zA-Z0-9]*/\.\./g')
endif

# Type(s) de traitement
PROCESS_TYPE = dirs symlink file

SYMLINKS = \
	$(DEPTH)/$(MAIN_DIR)/images/?.png \
	$(DEPTH)/$(MAIN_DIR)/images/note.png \
	$(DEPTH)/$(MAIN_DIR)/images/important.png \
	$(DEPTH)/$(MAIN_DIR)/images/warning.png \
	$(DEPTH)/$(MAIN_DIR)/images/caution.png

FILES = $(wildcard *.png)

all: $(PROCESS_TYPE)

include $(DEPTH)/common/Makefile.Rules
