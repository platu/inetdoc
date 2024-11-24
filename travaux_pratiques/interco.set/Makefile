ifndef MAIN_DIR
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
	interco.set.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	$(OUTPUT)/chapter-inter-vlan-iaas.xml \
	$(OUTPUT)/chapter-pppoe.xml \
	$(OUTPUT)/chapter-hub-and-spoke.xml \
	$(OUTPUT)/chapter-netfilter.xml \
	$(OUTPUT)/chapter-ospf.xml \
	$(OUTPUT)/chapter-synthese.xml \
	$(OUTPUT)/chapter-entities.xml \
	$(wildcard images/*)

CHAPTER_FILES = \
	../interco_01.inter-vlan-iaas/inter-vlan-iaas.xml \
	../interco_02.pppoe/pppoe.xml \
	../interco_03.hub-and-spoke/hub-and-spoke.xml \
	../interco_04.netfilter/netfilter.xml \
	../interco_05.ospf/ospf.xml \
	../interco_06.synthese/synthese.xml

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
