# A make file that should work on most Unix-like platforms

REXX_CFLAGS := $(shell ooRexx-config --cflags) -fPIC

REXX_LFLAGS := $(shell ooRexx-config --libs) $(shell ooRexx-config --rpath)

# What we want to build.
all: runRexxProgram stackOverflow

runRexxProgram: runRexxProgram.cpp
	$(CC) runRexxProgram.cpp $(REXX_CFLAGS) ${REXX_LFLAGS} -o runRexxProgram

stackOverflow: stackOverflow.cpp
	$(CC) stackOverflow.cpp  $(REXX_CFLAGS) $(REXX_LFLAGS) -o stackOverflow

clean:
	rm -f stackOverflow runRexxProgram

