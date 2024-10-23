.DELETE_ON_ERROR .ONESHELL:

.PHONY: all $(TARGETS)
all: $(TARGETS)
ifdef COMMAND
	-$(COMMAND)
endif

# We have to execute make on all because we do not have all dependencies here.
$(TARGETS): | bin
	@$(MAKE) MAKEFLAGS:= --eval=TARGET:=$@ --eval=OPTIONS:='$(call SOURCE,$@) $(call OPTIONS,$@)' -f'~/maker/install.d' >>bin/make.txt

bin:
	@mkdir bin

$(MAKEFILE_LIST):;
