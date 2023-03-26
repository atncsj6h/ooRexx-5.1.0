# A make file that should work on most Unix-like platforms

REXX_CFLAGS := $(shell oorexx-config --cflags) -fPIC

REXX_LFLAGS := $(shell oorexx-config --libs) $(shell oorexx-config --rpath)

UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
	EXT = dylib
	REXX_LFLAGS := $(REXX_LFLAGS) -dynamiclib
else
  EXT = so
  REXX_LFLAGS := $(REXX_LFLAGS) -shared -export-dynamic -nostartfiles
endif

# What we want to build.
all:  external_routines external_methods external_methods_routines

external_routines:
	@echo "building [$@] ..."
	$(CC) -c $@.cpp $(REXX_CFLAGS) -o $@.o
	$(CC) $@.o ${REXX_LFLAGS} -o lib$@.$(EXT)

external_methods:
	@echo "building [$@] ..."
	$(CC) -c $@.cpp $(REXX_CFLAGS) -o $@.o
	$(CC) $@.o ${REXX_LFLAGS} -o lib$@.$(EXT)

external_methods_routines:
	@echo "building [$@] ..."
	$(CC) -c $@.cpp $(REXX_CFLAGS) -o $@.o
	$(CC) $@.o ${REXX_LFLAGS} -o lib$@.$(EXT)

clean:
	rm -f *.o *.so *.$(EXT)

