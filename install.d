.DELETE_ON_ERROR .ONESHELL:

DEPENDENCY := $(patsubst %exe,%d,$(TARGET))

$(TARGET): $(DEPENDENCY)
	mkdir -p $(@D)
	g++ -o $@ -MMD $(OPTIONS)
#	$(SYSTEMDRIVE)/maker/bin/maker $<

$(MAKEFILE_LIST) $(DEPENDENCY):;

-include $(DEPENDENCY)
