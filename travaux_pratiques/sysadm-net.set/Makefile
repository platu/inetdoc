ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = files images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/rfc.urls.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	sysadm-net.set.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	$(OUTPUT)/chapter-sysadm-net.iscsi.qa.xml \
	$(OUTPUT)/chapter-sysadm-net.nfs.qa.xml \
	$(OUTPUT)/chapter-sysadm-net.ldap.qa.xml \
	$(OUTPUT)/chapter-sysadm-net.autofs-ldap-nfs.qa.xml \
	$(OUTPUT)/chapter-sysadm-net.dns.qa.xml \
	$(wildcard images/*.png)

CHAPTER_FILES = \
	../sysadm-net.iscsi.qa/sysadm-net.iscsi.qa.xml \
	../sysadm-net.nfs.qa/sysadm-net.nfs.qa.xml \
	../sysadm-net.ldap.qa/sysadm-net.ldap.qa.xml \
	../sysadm-net.autofs-ldap-nfs.qa/sysadm-net.autofs-ldap-nfs.qa.xml \
	../sysadm-net.dns.qa/sysadm-net.dns.qa.xml 

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

chapter-%.xml: $(CHAPTER_FILES) $(wildcard *.xml)
	@if [ ! -d $(OUTPUT) ]; then mkdir $(OUTPUT); fi
	@if [ ! -L $(OUTPUT)/files ]; then cd $(OUTPUT) && ln -s ../files .; fi
	@for chapter in $(CHAPTER_FILES); do \
		sed -f $(MAIN_DIR)/common/entity-extract.sed $$chapter >> $(OUTPUT)/chapter-entities.xml; \
		sed -f $(MAIN_DIR)/common/article2chapter.sed $$chapter > $(OUTPUT)/chapter-`basename $$chapter`; \
	done
