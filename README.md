# maker

Project provides makefile templates for use in your makefiles to ease compilation and dependency generation of C++ sources.

- Inspiration:
	- https://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
	- https://tech.davis-hansson.com/p/make/

Example:
```makefile
private TARGETS := src/main1 main2 debug_main2

include ~/maker/variables.mk

$(wordlist 2,3,$(TARGETS)): private SOURCE := src/main2.cpp

$(word 3,$(TARGETS)): private OPTIONS := $(filter-out -Ofast,$(OPTIONS)) -g

include ~/maker/rules.mk
```
