TARGETS := $(addprefix bin/,$(addsuffix .exe,$(TARGETS)))

COMMAND := $(firstword $(TARGETS))

SOURCE = $(patsubst bin/%exe,%cpp,$(1))

# https://stackoverflow.com/questions/68602608/static-and-dynamic-linking-whats-the-need-for-plt
# https://lists.alpinelinux.org/%7Ealpine/devel/%3C1628515011.zujvcn248v.none%40localhost%3E
# CODE_GENERATION - CPP_LANGUAGE - WARNING - OPTIMIZATION - PREPROCESSOR - DIAGNOSTIC - OVERALL - MACHINE - LINKER - C_LANGUAGE
OPTIONS :=	-fno-ident -fno-exceptions -fstrict-overflow -freg-struct-return -fno-plt -fno-common \
			\
			-fimplicit-constexpr -ffold-simple-inlines -fstrict-enums -fno-threadsafe-statics -fno-rtti -fno-enforce-eh-specs -fnothrow-opt -fno-gnu-keywords -fno-operator-names -Wctad-maybe-unsupported -Wctor-dtor-privacy -Wstrict-null-sentinel -Wzero-as-null-pointer-constant -Wredundant-tags -Wmismatched-tags -Wextra-semi -Wsign-promo -Wold-style-cast \
			\
			-fconcepts-diagnostics-depth=5 -fmax-errors=5 -Wall -Wextra -Wdisabled-optimization -Winvalid-pch -Wundef -Wcast-align -Wcast-qual -Wconversion -Wsign-conversion -Warith-conversion -Wdouble-promotion -Wimplicit-fallthrough=5 -Wpedantic -Wduplicated-cond -Wduplicated-branches -Wlogical-op -Wfloat-equal -Wpadded -Wpacked -Wredundant-decls -Wstrict-overflow -Wshadow=local -Wuseless-cast -Wnrvo \
			\
			-fmerge-all-constants -flto=auto -fuse-linker-plugin -Ofast \
			\
			-DNDEBUG \
			\
			-fno-show-column \
			\
			-pipe \
			\
			-march=native -mtune=native \
			\
			-s -static \
			\
			-std=c++26
