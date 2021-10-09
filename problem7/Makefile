AS=as
CFLAGS=--64
LD=ld
LDFLAGS=-nostdlib -melf_x86_64

OBJS=problem7.o ../utils/utils_print.o
TARGET=problem7

all: $(TARGET)

.s.o:
	$(AS) $(CFLAGS) $^ -o $@

problem7: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(OBJS) $(TARGET)
