#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include( CheckFunctionExists )
include( checkFunction )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
check_function (
  catopen
  crypt
  dladdr
  euidaccess
  fstat
  gcvt
  geteuid
  getexecname
  getpgrp
  getpwuid
  gettimeofday
  getuserattr
  getxattr
  IDtouser
  listxattr
  memset
  nanosleep
  nsleep
  pthread_mutex_timedlock
  pthread_mutexattr_settype
  removexattr
  setlocale
  setxattr
  setpgid
  setpgrp
  sighold
  sigprocmask
  strdup
  wordexp
)
