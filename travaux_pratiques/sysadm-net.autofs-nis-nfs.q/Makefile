ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = qonly symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	sysadm-net.autofs-nis-nfs.q.xml \
	inetdoc.urls.xml

all: qandasets $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

QANDASET_FILES = \
	$(OUTPUT)/qandaset-nis-server.xml \
	$(OUTPUT)/qandaset-nis-client-libc.xml \
	$(OUTPUT)/qandaset-nfs-common-package.xml

qandasets: $(QANDASET_FILES)

$(OUTPUT)/qandaset-%.xml: $(MAIN_DIR)/travaux_pratiques/sysadm-net.autofs-nis-nfs.qa/$(OUTPUT)/qandaset-%.xml
	@if [ ! -d $(OUTPUT) ]; then mkdir $(OUTPUT); fi
	ln -s $< $@
