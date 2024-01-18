ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Liste des répertoires à traiter à partir de ce niveau
SUBDIRS = images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	sysadm-net.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	sysadm-net.iscsi.abstract.xml \
	sysadm-net.nfs.abstract.xml \
	sysadm-net.ldap.abstract.xml \
	sysadm-net.autofs-ldap-nfs.abstract.xml \
	sysadm-net.dns.abstract.xml \
	$(wildcard images/*.png)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

sysadm-net.iscsi.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.iscsi.qa/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.nfs.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.nfs.qa/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.ldap.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.ldap.qa/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.autofs-ldap-nfs.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.autofs-ldap-nfs.qa/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.dns.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.dns.qa/$(ABSTRACT_FILE)
	ln -s $< $@
