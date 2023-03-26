# A make file that should work on most Unix-like platforms

EXE1 = callrexx1
EXE2 = callrexx2

REXX_CFLAGS = `oorexx-config --cflags` -fPIC

REXX_LFLAGS := $(shell oorexx-config --libs) $(shell oorexx-config --rpath)

# What we want to build.
all: $(EXE1) $(EXE2)

$(EXE1): $(EXE1).cpp
	$(CC) $(EXE1).cpp $(REXX_CFLAGS) ${REXX_LFLAGS} -o $(EXE1)

$(EXE2): $(EXE2).c
	$(CC) $(EXE2).c  $(REXX_CFLAGS) $(REXX_LFLAGS) -o $(EXE2)

clean:
	rm -f $(EXE1) $(EXE2)

