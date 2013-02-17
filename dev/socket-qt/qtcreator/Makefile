ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

project = gui-udp-listener nogui-udp-listener

target = $(addsuffix .tar.gz, $(project))

all: $(target)

$(target): $(foreach proj, $(project), $(wildcard $(proj)/*))
	@for proj in $(project); do \
	  tar czf $$proj.tar.gz $$proj; \
	done

include $(MAIN_DIR)/common/Makefile.Rules
