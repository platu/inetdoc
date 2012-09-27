ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

ABSTRACT_FILE = transform_output/abstract.xml

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

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
	sysadm-net.autofs-ldap-nfs.abstract.xml

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

sysadm-net.iscsi.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.iscsi.q/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.nfs.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.nfs.q/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.ldap.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.ldap.q/$(ABSTRACT_FILE)
	ln -s $< $@

sysadm-net.autofs-ldap-nfs.abstract.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.autofs-ldap-nfs.q/$(ABSTRACT_FILE)
	ln -s $< $@
