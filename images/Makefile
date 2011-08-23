ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Chemins définis par le paquet Debian docbook-xsl-ns
DOCBOOK_ADMONITIONS	= /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/images
DOCBOOK_CALLOUTS	= /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/images/callouts

# Liste des répertoires à traiter à partir de ce niveau
SYMLINKS = \
	$(DOCBOOK_ADMONITIONS)/caution.png \
	$(DOCBOOK_ADMONITIONS)/important.png \
	$(DOCBOOK_ADMONITIONS)/note.png \
	$(DOCBOOK_ADMONITIONS)/tip.png \
	$(DOCBOOK_ADMONITIONS)/warning.png \
	$(DOCBOOK_ADMONITIONS)/warning.png \
	$(DOCBOOK_CALLOUTS)/[0-9]*.png

# Type(s) de traitement
PROCESS = symlink 

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
