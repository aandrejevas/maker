.DELETE_ON_ERROR .ONESHELL:

.PHONY: all $(TARGETS)
all: $(TARGETS)

# Define and use flags variables

# We have to execute make on all because we do not have all dependencies here.
$(TARGETS):
	@$(MAKE) MAKEFLAGS:= --eval=TARGET:=$@ --eval=OPTIONS:='-fno-ident -fno-exceptions -fstrict-overflow -freg-struct-return -fno-plt -fno-common -fimplicit-constexpr -fno-implement-inlines -ffold-simple-inlines -fconcepts-diagnostics-depth=5 -fmax-errors=5 -Wall -Wextra -Wdisabled-optimization -Winvalid-pch -Wundef -Wcast-align=strict -Wcast-qual -Wconversion -Wsign-conversion -Warith-conversion -Wdouble-promotion -Wimplicit-fallthrough=5 -Wpedantic -Wduplicated-cond -Wduplicated-branches -Wlogical-op -Wfloat-equal -Wpadded -Wpacked -Wredundant-decls -Wunknown-pragmas -Wstrict-overflow -Wshadow=local -fstrict-enums -fno-threadsafe-statics -fno-rtti -fno-enforce-eh-specs -fnothrow-opt -fno-gnu-keywords -Wctad-maybe-unsupported -Wctor-dtor-privacy -Wnon-virtual-dtor -Wsuggest-override -Wsuggest-final-types -Wsuggest-final-methods -Wstrict-null-sentinel -Wzero-as-null-pointer-constant -Wconditionally-supported -Wredundant-tags -Wmismatched-tags -Wextra-semi -Wsign-promo -Wold-style-cast -Wuseless-cast -fmerge-all-constants -fwhole-program -Ofast -DNDEBUG -pipe -march=native -mtune=native -s -static -std=c++26 $(call SOURCE,$@) -lboost_iostreams-mt' -f install.d

$(MAKEFILE_LIST):;
