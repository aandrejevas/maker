.DELETE_ON_ERROR .ONESHELL:

DEPENDENCY := $(addsuffix .d,$(basename $(TARGET)))
DIRECTORY := $(dir $(TARGET))

$(TARGET): $(DEPENDENCY) | $(DIRECTORY)
	g++ -MMD -o $@ $(OPTIONS)
	~/maker/bin/maker $<

$(DIRECTORY):
	mkdir -p $@

-include $(DEPENDENCY)

$(MAKEFILE_LIST):;
