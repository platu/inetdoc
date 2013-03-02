target = $(addsuffix .o,$(basename $(wildcard *.c)))

all: $(target) tcp-talker.c.patch

%.o: %.c
	gcc -Wall -Wextra -o $@ $<

tcp-talker.c.patch: udp-talker.c tcp-talker.c
	@diff -uBb $^ > $@ ; if [ $$? -eq 0 ]; then echo "no differences" ; fi

clean:
	rm -f *.o
