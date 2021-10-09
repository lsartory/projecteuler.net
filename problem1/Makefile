AS=as
CFLAGS=--64
LD=ld
LDFLAGS=-nostdlib -melf_x86_64

OBJS=problem1.o ../utils/utils_print.o
TARGET=problem1

all: $(TARGET)

.s.o:
	$(AS) $(CFLAGS) $^ -o $@

problem1: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(OBJS) $(TARGET)
