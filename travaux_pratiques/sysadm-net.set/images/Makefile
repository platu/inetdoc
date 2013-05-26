ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.iscsi.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.nfs.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.ldap.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.autofs-ldap-nfs.qa/images/*.png) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.dns.qa/images/*.png) \
	$(MAIN_DIR)/images/titleimage.png

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
