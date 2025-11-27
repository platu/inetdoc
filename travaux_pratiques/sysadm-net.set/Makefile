ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

SUBDIRS = images

# Type(s) de traitement
PROCESS = subdirs symlink xml2xhtml xml2pdf

SYMLINKS = \
    $(MAIN_DIR)/common/author.xml \
    $(MAIN_DIR)/common/legal.xml \
    $(MAIN_DIR)/common/rfc.urls.ent \
    $(MAIN_DIR)/common/inetdoc.urls.ent

XML_FILES = \
    sysadm-net.set.xml \
    author.xml \
    legal.xml \
    inetdoc.urls.ent \
    $(OUTPUT)/chapter-sysadm-net.iscsi.xml \
    $(OUTPUT)/chapter-sysadm-net.nfs.xml \
    $(OUTPUT)/chapter-sysadm-net.ldap.xml \
    $(OUTPUT)/chapter-sysadm-net.autofs-ldap-nfs.xml \
    $(wildcard images/*) \
    w3centities-f.ent

CHAPTER_FILES = \
    ../sysadm-net.iscsi/sysadm-net.iscsi.xml \
    ../sysadm-net.nfs/sysadm-net.nfs.xml \
    ../sysadm-net.ldap/sysadm-net.ldap.xml \
    ../sysadm-net.autofs-ldap-nfs/sysadm-net.autofs-ldap-nfs.xml \

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

w3centities-f.ent:
    wget -O $@ https://www.w3.org/TR/xml-entity-names/w3centities-f.ent