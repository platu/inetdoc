ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink xml2xhtml xml2pdf

SYMLINKS = \
        $(MAIN_DIR)/common/author.xml \
        $(MAIN_DIR)/common/legal.xml \
        $(MAIN_DIR)/common/inetdoc.urls.xml

XML_FILES = \
	sysadm-net.autofs-nis-nfs.qa.xml \
	../sysadm-net.nis.qa/sysadm-net.nis.qa.xml \
	../sysadm-net.nfs/sysadm-net.nfs.xml \
    author.xml \
    legal.xml \
	inetdoc.urls.xml \

all: qandasets $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules

QANDASET_FILES = \
	$(OUTPUT)/qandaset-nis-server.xml \
	$(OUTPUT)/qandaset-nis-client-libc.xml \
	$(OUTPUT)/qandaset-nfs-common-package.xml

qandasets: symlink $(QANDASET_FILES) $(XML_FILES)

$(OUTPUT)/qandaset-nis-server.xml: ../sysadm-net.nis.qa/sysadm-net.nis.qa.xml
	@if [ ! -d $(OUTPUT) ]; then mkdir $(OUTPUT); fi
	sed "/<qandaset.* xml:id='sysadm-net.nis.server-qa'>/,/<\/qandaset/!d" $< > $@

$(OUTPUT)/qandaset-nis-client-libc.xml: ../sysadm-net.nis.qa/sysadm-net.nis.qa.xml
	@if [ ! -d $(OUTPUT) ]; then mkdir $(OUTPUT); fi
	sed "/<qandaset.* xml:id='sysadm-net.nis.client-libc'>/,/<\/qandaset/!d" $< > $@

$(OUTPUT)/qandaset-nfs-common-package.xml: ../sysadm-net.nfs/sysadm-net.nfs.xml
	@if [ ! -d $(OUTPUT) ]; then mkdir $(OUTPUT); fi
	sed "/<qandaset.* xml:id='sysadm-net.nfs.common-package'>/,/<\/qandaset/!d" $< > $@
