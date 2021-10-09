AS=as
CFLAGS=--64
LD=ld
LDFLAGS=-nostdlib -melf_x86_64

OBJS=problem5.o ../utils/utils_print.o
TARGET=problem5

all: $(TARGET)

.s.o:
	$(AS) $(CFLAGS) $^ -o $@

problem5: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(OBJS) $(TARGET)
