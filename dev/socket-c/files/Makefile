ifndef $(MAIN_DIR)
MAIN_DIR = $(HOME)/inetdoc
endif

target = $(addsuffix .o,$(basename $(wildcard *.c)))

all: $(target) tcp-talker.c.patch tcp-listener.c.patch

%.o: %.c
	gcc -Wall -Wextra -o $@ $<

tcp-talker.c.patch: udp-talker.c tcp-talker.c
	@diff -uBb $^ > $@ ; if [ $$? -eq 0 ]; then echo "no differences" ; fi

tcp-listener.c.patch: udp-listener.c tcp-listener.c
	@diff -uBb $^ > $@ ; if [ $$? -eq 0 ]; then echo "no differences" ; fi

include $(MAIN_DIR)/common/Makefile.Rules
