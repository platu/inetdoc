ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

target = $(addsuffix .o,$(basename $(wildcard *.c)))

all: $(target) tcp-client.c.patch tcp-server.c.patch

%.o: %.c
	gcc -Wall -o $@ $<

tcp-client.c.patch: udp-client.c tcp-client.c
	-diff -uBb $^ > $@

tcp-server.c.patch: udp-server.c tcp-server.c
	-diff -uBb $^ > $@

include $(MAIN_DIR)/common/Makefile.Rules
