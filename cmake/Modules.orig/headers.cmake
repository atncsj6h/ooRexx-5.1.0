#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

include( CheckIncludeFile )
include( checkHeader )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
check_header(
  alloca.h
  dlfcn.h
  features.h
  filehdr.h
  inttypes.h
  malloc.h
  nl_types.h
  pthread.h
  pwd.h
  sched.h
  signal.h
  stdint.h
  strings.h
  time.h
  wordexp.h
  xlocale.h

  sys/filio.h
  sys/ldr.h
  sys/resource.h
  sys/select.h
  sys/sem.h
  sys/signal.h
  sys/socket.h
  sys/time.h
  sys/utsname.h
  sys/wait.h
  sys/xattr.h
)
