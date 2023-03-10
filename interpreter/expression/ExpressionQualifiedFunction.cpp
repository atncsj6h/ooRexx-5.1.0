/*----------------------------------------------------------------------------*/
/*                                                                            */
/* Copyright (c) 1995, 2004 IBM Corporation. All rights reserved.             */
/* Copyright (c) 2005, 2023 Rexx Language Association. All rights reserved.   */
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
/* REXX Translator                                                            */
/*                                                                            */
/* Primitive Function Invocation Class                                        */
/*                                                                            */
/******************************************************************************/
#include "RexxCore.h"
#include "StringClass.hpp"
#include "QueueClass.hpp"
#include "RexxActivation.hpp"
#include "RexxInstruction.hpp"
#include "ExpressionQualifiedFunction.hpp"
#include "Activity.hpp"
#include "ProtectedObject.hpp"
#include "RoutineClass.hpp"


/**
 * Allocate a new function call object.
 *
 * @param size     The base object size
 * @param argCount The count of function arguments need to allocate space.
 *
 * @return The storage for creating a function object.
 */
void *QualifiedFunction::operator new(size_t size, size_t argCount)
{
    if (argCount == 0)
    {
        // allocate with singleton item chopped off
        return new_object(size - sizeof(RexxObject *), T_QualifiedFunction);
    }
    else
    {
        // allocate with the space needed for the arguments
        return new_object(size + (argCount - 1) * sizeof(RexxObject *), T_QualifiedFunction);
    }
}

/**
 * Construct a function call expression object.
 *
 * @param n        The namespace qualifier
 * @param f        The function name.
 * @param argCount The argument count.
 * @param argList
 */
QualifiedFunction::QualifiedFunction(RexxString *n, RexxString *f, size_t argCount, QueueClass *argList)
{
    namespaceName = n;
    functionName = f;
    argumentCount = argCount;

    // now copy any arguments from the sub term stack
    // NOTE:  The arguments are in last-to-first order on the stack.
    initializeObjectArray(argCount, arguments, RexxInternalObject, argList);
}


/**
 * Perform garbage collection on a live object.
 *
 * @param liveMark The current live mark.
 */
void QualifiedFunction::live(size_t liveMark)
{
    memory_mark(namespaceName);
    memory_mark(functionName);
    memory_mark_array(argumentCount, arguments);
}


/**
 * Perform generalized live marking on an object.  This is
 * used when mark-and-sweep processing is needed for purposes
 * other than garbage collection.
 *
 * @param reason The reason for the marking call.
 */
void QualifiedFunction::liveGeneral(MarkReason reason)
{
    memory_mark_general(namespaceName);
    memory_mark_general(functionName);
    memory_mark_general_array(argumentCount, arguments);
}


/**
 * Flatten a source object.
 *
 * @param envelope The envelope that will hold the flattened object.
 */
void QualifiedFunction::flatten(Envelope *envelope)
{
    setUpFlatten(QualifiedFunction)

    flattenRef(namespaceName);
    flattenRef(functionName);
    flattenArrayRefs(argumentCount, arguments);

    cleanUpFlatten
}


/**
 * Evaluate a function call.
 *
 * @param context The current execution context.
 * @param stack   the current evaluation stack.
 *
 * @return The function return value.
 */
RexxObject *QualifiedFunction::evaluate(RexxActivation *context, ExpressionStack *stack)
{
    // save the top of the stack for popping values off later.
    size_t stacktop = stack->location();

    // evaluate the arguments first
    RexxInstruction::evaluateArguments(context, stack, arguments, argumentCount);

    ProtectedObject   result;            // returned result

    // get the current package from the context
    PackageClass *package = context->getPackage();

    // we must be able to find the named namespace
    PackageClass *namespacePackage = package->findNamespace(namespaceName);
    if (namespacePackage == OREF_NULL)
    {
        reportException(Error_Execution_no_namespace, namespaceName, package->getProgramName());
    }

    // we only look for public routines in the namespaces
    RoutineClass *resolvedRoutine = namespacePackage->findPublicRoutine(functionName);
    // we give a specific error for this one
    if (resolvedRoutine == OREF_NULL)
    {
        reportException(Error_Routine_not_found_namespace, functionName, namespaceName);
    }

    // call the resolved function
    resolvedRoutine->call(context->getActivity(), functionName, stack->arguments(argumentCount), argumentCount, GlobalNames::FUNCTION, OREF_NULL, EXTERNALCALL, result);

    // functions must have a return result
    if (result.isNull())
    {
         reportException(Error_Function_no_data_function, functionName);
    }

    // remove the arguments from the stack and push our result
    stack->setTop(stacktop);
    stack->push(result);

    // trace if needed and return the result
    context->traceFunction(functionName, result);
    return result;
}
