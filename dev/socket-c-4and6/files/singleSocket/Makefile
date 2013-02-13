target = $(addsuffix .o,$(basename $(wildcard *.c)))

all: $(target)

%.o: %.c
	gcc -Wall -Wextra -o $@ $<

clean:
	rm -f *.o
