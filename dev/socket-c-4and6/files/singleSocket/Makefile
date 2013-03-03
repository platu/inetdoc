target = $(addsuffix .o,$(basename $(wildcard *.c)))

all: $(target) tcp-listener.c.patch

%.o: %.c
	gcc -Wall -Wextra -o $@ $<

tcp-listener.c.patch: udp-listener.c tcp-listener.c
	@diff -uBb $^ > $@ ; if [ $$? -eq 0 ]; then echo "no differences" ; fi

clean:
	rm -f *.o
