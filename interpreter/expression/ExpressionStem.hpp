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
/* REXX Kernel                                           ExpressionStem.hpp   */
/*                                                                            */
/* Primitive Expression Stem Class Definitions                                */
/*                                                                            */
/******************************************************************************/
#ifndef Included_RexxStemVariable
#define Included_RexxStemVariable

#include "ExpressionBaseVariable.hpp"

class RexxVariable;

/**
 * A "retriever" class representing a Stem variable.  This
 * performs all of the normal operations expected from
 * an expression term or variable accessor.
 */
class RexxStemVariable : public RexxVariableBase
{
 public:
    void *operator new(size_t);
    inline void  operator delete(void *) { ; }

    inline RexxStemVariable(RESTORETYPE restoreType) { ; };
    RexxStemVariable(RexxString *, size_t);

    void live(size_t) override;
    void liveGeneral(MarkReason reason) override;
    void flatten(Envelope *) override;

    // overrides of RexxInternalObject evaluaton methods
    RexxObject *evaluate(RexxActivation *, ExpressionStack *) override;
    RexxObject *getValue(VariableDictionary *) override;
    RexxObject *getValue(RexxActivation *) override;
    RexxObject *getRealValue(VariableDictionary *) override;
    RexxObject *getRealValue(RexxActivation *) override;
    VariableReference *getVariableReference(VariableDictionary *) override;
    VariableReference *getVariableReference(RexxActivation *) override;

    // overrides of RexxVariableBase methods
    bool exists(RexxActivation *) override;
    void set(RexxActivation *, RexxObject *)  override;
    void set(VariableDictionary *, RexxObject *)  override;
    void assign(RexxActivation *, RexxObject *) override;
    void drop(RexxActivation *) override;
    void drop(VariableDictionary *) override;
    void setGuard(RexxActivation *) override;
    void clearGuard(RexxActivation *) override;
    void setGuard(VariableDictionary *) override;
    void clearGuard(VariableDictionary *) override;
    void expose(RexxActivation *, VariableDictionary *) override;
    void procedureExpose(RexxActivation *, RexxActivation *) override;
    void alias(RexxActivation *, RexxVariable *) override;

    // class-specific methods
    bool sort(RexxActivation *context, RexxString *prefix, int order, int type, size_t start, size_t end, size_t firstcol, size_t lastcol);
    inline size_t getIndex() {return stemIndex;};

 protected:

    RexxString  *stemName;                   // the stem variable name
    size_t       stemIndex;                  // lookaside table index
};
#endif
