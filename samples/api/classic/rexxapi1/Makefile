# A make file that should work on most Unix-like platforms

LIB1 = rexxapi1

REXX_CFLAGS = `ooRexx-config --cflags` -fPIC

REXX_LFLAGS := $(shell ooRexx-config --libs) $(shell ooRexx-config --rpath)

UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
	EXT = dylib
	REXX_LFLAGS := $(REXX_LFLAGS) -dynamiclib
else
  EXT = so
  REXX_LFLAGS := $(REXX_LFLAGS) -shared -export-dynamic -nostartfiles
endif

# What we want to build.
all: lib$(LIB1).$(EXT)

$(LIB1).o: $(LIB1).c
	$(CC) -c $(LIB1).c $(REXX_CFLAGS) -o $(LIB1).o

lib$(LIB1).$(EXT): $(LIB1).o
	$(CC) $(LIB1).o ${REXX_LFLAGS} -o lib$(LIB1).$(EXT)

clean:
	rm -f *.o  *.so *.dylib
