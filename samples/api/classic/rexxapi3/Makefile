# A make file that should work on most Unix-like platforms

LIB3 = rexxapi3

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
all: lib$(LIB3).$(EXT)

$(LIB3).o: $(LIB3).c
	$(CC) -c $(LIB3).c $(REXX_CFLAGS) -o $(LIB3).o

lib$(LIB3).$(EXT): $(LIB3).o
	$(CC) $(LIB3).o ${REXX_LFLAGS} -o lib$(LIB3).$(EXT)

clean:
	rm -f *.o  *.so *.dylib
