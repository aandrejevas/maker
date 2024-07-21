TARGETS := maker

include variables.d

SOURCE := src/main.cpp
OPTIONS := $(OPTIONS) -lboost_iostreams-mt

include all.d
