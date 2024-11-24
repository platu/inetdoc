ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images

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
	$(wildcard images/*)

CHAPTER_FILES = \
	../sysadm-net.iscsi.qa/sysadm-net.iscsi.qa.xml \
	../sysadm-net.nfs.qa/sysadm-net.nfs.qa.xml \
	../sysadm-net.ldap.qa/sysadm-net.ldap.qa.xml \
	../sysadm-net.autofs-ldap-nfs.qa/sysadm-net.autofs-ldap-nfs.qa.xml \

.PHONY: all $(PROCESS)

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

$(OUTPUT):
	mkdir -p $@

define generate-chapter
$(OUTPUT)/chapter-$(notdir $(1)): $(1) | $(OUTPUT)
	sed -f $(MAIN_DIR)/common/entity-extract.sed $$< >> $(OUTPUT)/chapter-entities.xml
	python3 $(MAIN_DIR)/common/article2chapter.py $$< > $$@
endef

$(foreach chapter,$(CHAPTER_FILES),$(eval $(call generate-chapter,$(chapter))))

chapters: $(OUTPUT)/chapter-entities.xml $(foreach chapter,$(CHAPTER_FILES),$(OUTPUT)/chapter-$(notdir $(chapter)))

