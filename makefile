TARGETS := maker

include ~/maker/variables.d

SOURCE := src/main.cpp
OPTIONS += -municode -lboost_filesystem-mt -lboost_iostreams-mt
undefine COMMAND

include ~/maker/all.d
