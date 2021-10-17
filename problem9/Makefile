AS=as
CFLAGS=--64
LD=ld
LDFLAGS=-nostdlib -melf_x86_64

OBJS=problem9.o ../utils/utils_print.o
TARGET=problem9

all: $(TARGET)

.s.o:
	$(AS) $(CFLAGS) $^ -o $@

problem9: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(OBJS) $(TARGET)
