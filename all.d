.DELETE_ON_ERROR .ONESHELL:

.PHONY: all $(TARGETS)
all: $(TARGETS)
ifdef COMMAND
	-$(COMMAND) >>/dev/tty
endif

# We have to execute make on all because we do not have all dependencies here.
$(TARGETS):
	@$(MAKE) MAKEFLAGS:= --eval=TARGET:=$@ --eval=OPTIONS:='$(call SOURCE,$@) $(call OPTIONS,$@)' -f'~/maker/install.d'

$(MAKEFILE_LIST):;
