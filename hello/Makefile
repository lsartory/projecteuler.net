AS=as
CFLAGS=--64
LD=ld
LDFLAGS=-nostdlib -melf_x86_64

OBJS=hello.o ../utils/utils_print.o
TARGET=hello

all: $(TARGET)

.s.o:
	$(AS) $(CFLAGS) $^ -o $@

hello: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(OBJS) $(TARGET)
