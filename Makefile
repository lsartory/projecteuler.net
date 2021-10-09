TARGETS=hello problem*

.PHONY: subdirs $(TARGETS)
.PHONY: all clean

all: $(TARGETS)
$(TARGETS):
	$(MAKE) -C $@

clean:
	for dir in $(TARGETS); do $(MAKE) -C $$dir clean; done
