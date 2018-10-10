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
	interco.set.xml \
	author.xml \
	legal.xml \
	inetdoc.urls.xml \
	$(OUTPUT)/chapter-interco.kernel.qa.xml \
	$(OUTPUT)/chapter-interco.rawip.qa.xml \
	$(OUTPUT)/chapter-interco.ppp.qa.xml \
	$(OUTPUT)/chapter-interco.netfilter.qa.xml \
	$(OUTPUT)/chapter-interco.inter-vlan.qa.xml \
	$(OUTPUT)/chapter-interco.ospf-bird.qa.xml \
	$(OUTPUT)/chapter-interco.cs.xml \
	$(wildcard files/*) \
	$(wildcard images/*.png)

CHAPTER_FILES = \
	../interco.kernel.qa/interco.kernel.qa.xml \
	../interco.rawip.qa/interco.rawip.qa.xml \
	../interco.ppp.qa/interco.ppp.qa.xml \
	../interco.netfilter.qa/interco.netfilter.qa.xml \
	../interco.inter-vlan.qa/interco.inter-vlan.qa.xml \
	../interco.ospf-bird.qa/interco.ospf-bird.qa.xml \
	../interco.cs/interco.cs.xml 

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

chapter-%.xml: $(CHAPTER_FILES) $(wildcard *.xml)
	@if [ ! -d $(OUTPUT) ]; then mkdir $(OUTPUT); fi
	@if [ ! -L $(OUTPUT)/files ]; then cd $(OUTPUT) && ln -s ../files .; fi
	@for chapter in $(CHAPTER_FILES); do \
		sed -f $(MAIN_DIR)/common/entity-extract.sed $$chapter >> $(OUTPUT)/chapter-entities.xml; \
		sed -f $(MAIN_DIR)/common/article2chapter.sed $$chapter > $(OUTPUT)/chapter-`basename $$chapter`; \
	done
