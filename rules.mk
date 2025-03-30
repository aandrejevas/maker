.DELETE_ON_ERROR .ONESHELL:

private DEPENDENCIES := $(addsuffix .mk,$(TARGETS))

.PHONY: all
all: $(TARGETS)
ifdef COMMAND
	-$(COMMAND)
endif

# Some strategies to write complicated static pattern rules:
# https://stackoverflow.com/questions/57367690/gnu-make-how-to-make-a-static-pattern-rule-for-files-that-are-not-in-the-same-di
#
# We leave the directory creation to the shell bc if make would be concerned with it then we would be
# doing extra checks in the case that the compiler itself creates the directories passed to it.
#
# We do not check for compiler changes (which imply system header changes), library header changes, makefile
# changes and if any of those happen we leave it to the programmer to unconditionally make all targets (by passing -B).
$(TARGETS): bin/%.exe: bin/%.exe.mk $(firstword $(MAKEFILE_LIST))
	[[ -d $(@D) ]] || mkdir -p $(@D)
	g++ -MMD -MP -MF $< -o $@ $(SOURCE) $(OPTIONS)

# We can't put this rule after the include and without the DEPENDENCIES variable bc then in the case that
# a dependency file does not exit the MAKEFILE_LIST variable would not get updated and make would fail.
#
# There is a way to prevent a target from getting implicit recipes and to error if it does not exist:
# https://stackoverflow.com/questions/54172409/gnu-make-ensure-existence-of-prerequisite-and-disable-implicit-rule-search
$(MAKEFILE_LIST) $(DEPENDENCIES):;

# We do not care that by default the rules in dependencies are not empty recipes
# At the same time bc they are not, it is possible to have multiple rules with the same targets.
-include $(DEPENDENCIES)
