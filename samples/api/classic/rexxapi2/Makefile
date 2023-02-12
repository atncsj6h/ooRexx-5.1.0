# A make file that should work on most Unix-like platforms

LIB2 = rexxapi2

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
all: lib$(LIB2).$(EXT)

$(LIB2).o: $(LIB2).c
	$(CC) -c $(LIB2).c $(REXX_CFLAGS) -o $(LIB2).o

lib$(LIB2).$(EXT): $(LIB2).o
	$(CC) $(LIB2).o ${REXX_LFLAGS} -o lib$(LIB2).$(EXT)

clean:
	rm -f *.o  *.so *.dylib
