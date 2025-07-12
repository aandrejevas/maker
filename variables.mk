private TARGETS := $(addprefix bin/,$(addsuffix .exe,$(TARGETS)))

# We want to replicate the behavior that we would get if we launched the target from its parent directory.
COMMAND := cd $(dir $(firstword $(TARGETS))); ./$(notdir $(firstword $(TARGETS))) >>$(MAKE_TERMERR)

# We only define target specific variables where that is needed to increase performance.
SOURCE = $*.cpp

# By default on:
#	-fno-common – https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-fcommon
#	-ffold-simple-inlines – https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html#index-ffold-simple-inlines
# Do not use:
#	-fnothrow-opt – nereikalingas, nes nauji C++ standartai nebeturi throw()/dynamic exception specification.
#	-fno-enforce-eh-specs – nereikalingas, nes nauji C++ standartai nebeturi throw()/dynamic exception specification.
#	-Wctad-maybe-unsupported – Nenaudojame, nes 99% atvejų, ctad yra palaikomas.
#	-fvisibility-inlines-hidden – https://stackoverflow.com/questions/48621251/why-fvisibility-inlines-hidden-is-not-the-default
#	-fno-char8_t – nenorime leisti, kad būtų galima tą patį dalyką atlikti dviem būdais (https://utf8everywhere.org/ :) ).
#	-municode – anksčiau reikėjo UNICODE macro, bet dabar windows -A API's priima UTF-8 tekstą; taip pat argumentas leistų apibrėžti neteisingą main.
#	-Wno-alloc-size-larger-than – kompiliatorius klaidingai metė įspėjimą tai reikėjo argumento, bet jei taip dar bus tai kode tai išspręsti.
#	-Wshadow=compatible-local – Galvojau, kad su šiuo argumentu, galėsiu apibrėžti const& su tuo pačiu vardu, bet meta šią klaidą ir -Winit-self, ir panaudojus vardą -Wmaybe-uninitialized, nes po lygu vardas nurodo į naują reikšmę, kuri yra neinicializuota.
# Use:
#	-DNDEBUG – be kabučių, nes taupome vietą, čia ne kelias koks, kad reiktų kabučių.
#	-fvisibility=hidden – https://www.youtube.com/watch?v=vtz8S10hGuc
#	-fno-plt – https://stackoverflow.com/questions/68602608/static-and-dynamic-linking-whats-the-need-for-plt https://lists.alpinelinux.org/%7Ealpine/devel/%3C1628515011.zujvcn248v.none%40localhost%3E
#	-finput-charset=UTF-8 – patikrinau ir nėra automatiškai paduodamas nustatymas. Taip pat nereikia tikėtis, kad lokalė bus tinkama. Patikrinau ant testo failo, kurį radau GCC repozitorijoje ir kuris pilnas UTF-8 klaidingų simbolių sekų, ir be šito nustatymo kompiliatorius klaidos nemetė (įkopijuoti neįmanoma klaidingų simbolių į vscode, nes vscode ir naršyklės pakeičia simbolius, net išsaugant testo failą be formatavimo vscode pakeitė klaidingus simbolius, įmanoma redaguoti testo failą su terminalo teksto redaktoriais).
#
# CODE_GENERATION - CPP_LANGUAGE - WARNING - OPTIMIZATION - PREPROCESSOR - DIAGNOSTIC - OVERALL - MACHINE - LINKER - C_LANGUAGE
OPTIONS :=	-fno-ident -fno-exceptions -fstrict-overflow -freg-struct-return -fno-plt -fvisibility=hidden \
			\
			-fimplicit-constexpr -fstrict-enums -fno-threadsafe-statics -fno-rtti -fno-gnu-keywords -fno-operator-names -Wctor-dtor-privacy -Wstrict-null-sentinel -Wzero-as-null-pointer-constant -Wredundant-tags -Wmismatched-tags -Wextra-semi -Wsign-promo -Wold-style-cast \
			\
			-fmax-errors=5 -Wall -Wextra -Wdisabled-optimization -Winvalid-pch -Wundef -Wcast-align -Wcast-qual -Wconversion -Wsign-conversion -Warith-conversion -Wdouble-promotion -Wimplicit-fallthrough=5 -Wpedantic -Wduplicated-cond -Wduplicated-branches -Wlogical-op -Wfloat-equal -Wpadded -Wpacked -Wredundant-decls -Wstrict-overflow -Wshadow=local -Wuseless-cast -Wnrvo \
			\
			-fmerge-all-constants -flto=auto -fuse-linker-plugin -Ofast \
			\
			-DNDEBUG -finput-charset=UTF-8 \
			\
			-fno-show-column \
			\
			-pipe \
			\
			-march=native -mtune=native \
			\
			-s -static -static-libstdc++ \
			\
			-std=c++26

# Add it if you need it.
private VERBOSE := -fconcepts-diagnostics-depth=5 -fdiagnostics-all-candidates
