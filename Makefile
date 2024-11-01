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
PROCESS = subdirs /var/www/tp favicon.ico

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

/var/www/tp:
	cd /var/www && ln -s travaux_pratiques tp

favicon.ico:
	ln -s images/$@
