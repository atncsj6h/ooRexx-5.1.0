/*----------------------------------------------------------------------------*/
/*                                                                            */
/* Copyright (c) 1995, 2004 IBM Corporation. All rights reserved.             */
/* Copyright (c) 2005, 2023 Rexx Language Association. All rights reserved.,  */
/*                                                                            */
/* This program and the accompanying materials are made available under       */
/* the terms of the Common Public License v1.0 which accompanies this         */
/* distribution. A copy is also available at the following address:           */
/* https://www.oorexx.org/license.html                                        */
/*                                                                            */
/* Redistribution and use in source and binary forms, with or                 */
/* without modification, are permitted provided that the following            */
/* conditions are met:                                                        */
/*                                                                            */
/* Redistributions of source code must retain the above copyright             */
/* notice, this list of conditions and the following disclaimer.              */
/* Redistributions in binary form must reproduce the above copyright          */
/* notice, this list of conditions and the following disclaimer in            */
/* the documentation and/or other materials provided with the distribution.   */
/*                                                                            */
/* Neither the name of Rexx Language Association nor the names                */
/* of its contributors may be used to endorse or promote products             */
/* derived from this software without specific prior written permission.      */
/*                                                                            */
/* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS        */
/* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT          */
/* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS          */
/* FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   */
/* OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,      */
/* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED   */
/* TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,        */
/* OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY     */
/* OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING    */
/* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS         */
/* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.               */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/******************************************************************************/
/* REXX Shared runtime                                                        */
/*                                                                            */
/* Unix implementation of the SysLibrary                                      */
/*                                                                            */
/******************************************************************************/

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include "SysLibrary.hpp"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <dlfcn.h>
#include "SysProcess.hpp"

SysLibrary::SysLibrary()
{
    libraryHandle = NULL;
}


void * SysLibrary::getProcedure(
  const char *name)                      /* required procedure name           */
/******************************************************************************/
/* Function:  Resolve a named procedure in a library                          */
/******************************************************************************/
{
    return dlsym(libraryHandle, name);
}


bool SysLibrary::load(
    const char *name)                    /* required library name             */
/******************************************************************************/
/* Function:  Load a named library, returning success/failure flag            */
/******************************************************************************/
{
    char nameBuffer[PC_PATH_MAX+PC_NAME_MAX+1];

    if (strlen(name) > PC_NAME_MAX-16)
    {
        return false;
    }

    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    APPLE man dlopen is clear about the fact that the `cwd` is searched first

    Linux on the other side tells nothing , but the results of testing is
    that a LD_LIBRARY_PATH has to be set pointing to the cwd

    so I guess we lose nothing by forcing a cwd search
    */

    // try a `cwd` load
    sprintf(nameBuffer, "./%s%s%s",
        SHARED_LIBRARY_PREFIX, name, SHARED_LIBRARY_SUFFIX);
    // printf("SysLibrary.cpp trying a `cwd` load >>%s<<\n", nameBuffer);
    libraryHandle = dlopen(nameBuffer, RTLD_LAZY);
    if (libraryHandle)
    {
        return true;
    }

    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        trying an unqualified load might load a library not aligned
        to the rest of current rexx executable

        since we have all the info needed the safe way is to do a
        qualified load from the runtime library directory,

        that' s why I flipped  the load try sequence
    */

    // if not found, then try from the runtime lib directory
    sprintf(nameBuffer, "%s%s%s%s",
        SysProcess::getLibraryLocation(), SHARED_LIBRARY_PREFIX, name, SHARED_LIBRARY_SUFFIX);
    // printf("SysLibrary.cpp trying the runtime lib directory >>%s<<\n", nameBuffer);
    libraryHandle = dlopen(nameBuffer, RTLD_LAZY);
    if (libraryHandle)
    {
        return true;
    }

    // try an unqualified load last
    //
    sprintf(nameBuffer, "%s%s%s",
        SHARED_LIBRARY_PREFIX, name, SHARED_LIBRARY_SUFFIX);
    // printf("SysLibrary.cpp trying an unqualified load >>%s<<\n", nameBuffer);
    libraryHandle = dlopen(nameBuffer, RTLD_LAZY);
    if (libraryHandle)
    {
        return true;
    }

    return false;

}


/**
 * Free a loaded library if the library is still loaded.
 *
 * @return True if we unloaded ok, false otherwise.
 */
bool SysLibrary::unload()
{
    if (libraryHandle != NULL)
    {
        dlclose(libraryHandle);
        return true;
    }
    return false;
}
