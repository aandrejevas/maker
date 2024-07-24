.DELETE_ON_ERROR .ONESHELL:

.PHONY: all $(TARGETS)
all: $(TARGETS)

# We have to execute make on all because we do not have all dependencies here.
$(TARGETS):
	@$(MAKE) MAKEFLAGS:= --eval=TARGET:=$@ --eval=OPTIONS:='$(call SOURCE,$@) $(call OPTIONS,$@)' -f'$(HOME)/maker/install.d'

$(MAKEFILE_LIST):;
