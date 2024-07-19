TARGETS := $(patsubst %,bin/%.exe,$(TARGETS))

SOURCE = $(patsubst bin/%exe,%cpp,$(1))
