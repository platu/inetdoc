ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

# Type(s) de traitement
PROCESS = symlink

SYMLINKS = \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.iscsi.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.nfs.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.ldap.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.autofs-ldap-nfs.qa/files/*.txt) \
	$(wildcard $(MAIN_DIR)/travaux_pratiques/sysadm-net.dns.qa/files/*.txt) 

all: $(PROCESS)

include $(MAIN_DIR)/common/Makefile.Rules
