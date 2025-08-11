
# https://discourse.cmake.org/t/how-to-force-cmake-use-mmd-flag-instead-of-md/9120/9
set(CMAKE_DEPFILE_FLAGS_CXX "-MMD -MF <DEP_FILE>")
# set(CMAKE_BUILD_TYPE Release)

set(CMAKE_CXX_EXTENSIONS False)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_STANDARD 26)

set(CMAKE_CXX_SCAN_FOR_MODULES False)
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION True)

set(CMAKE_SKIP_INSTALL_RULES True)
# set(CMAKE_EXPORT_COMPILE_COMMANDS True)



set(CXX_OPTIONS -fno-ident
	-fno-exceptions -fstrict-overflow -freg-struct-return -fno-plt -fvisibility=hidden

	-fimplicit-constexpr -fstrict-enums -fno-threadsafe-statics -fno-rtti -fno-operator-names -Wctor-dtor-privacy -Wstrict-null-sentinel -Wzero-as-null-pointer-constant -Wredundant-tags -Wmismatched-tags -Wextra-semi -Wsign-promo -Wold-style-cast

	-fmax-errors=5 -Wall -Wextra -Wdisabled-optimization -Winvalid-pch -Wundef -Wcast-align -Wcast-qual -Wconversion -Wsign-conversion -Warith-conversion -Wdouble-promotion -Wimplicit-fallthrough=5 -pedantic-errors -Wduplicated-cond -Wduplicated-branches -Wlogical-op -Wfloat-equal -Wpadded -Wpacked -Wredundant-decls -Wstrict-overflow -Wshadow=local -Wuseless-cast -Wnrvo

	-fmerge-all-constants -Ofast

	-finput-charset=UTF-8

	-fno-show-column

	-pipe

	-march=native -mtune=native

	-s)

set(CXX_DEFINITIONS NDEBUG)



if(NOT CXX_TARGETS)
	set(CXX_TARGETS ${CMAKE_PROJECT_NAME})
endif()

foreach(TARGET IN LISTS CXX_TARGETS)
	add_executable(${TARGET})

	set_target_properties(${TARGET} PROPERTIES
		SOURCES ${TARGET}.cpp
		COMPILE_OPTIONS "${CXX_OPTIONS}"
		COMPILE_DEFINITIONS "${CXX_DEFINITIONS}")
endforeach()

list(GET CXX_TARGETS 0 TARGET)
add_custom_target(run_first_target ALL COMMAND ${TARGET})
