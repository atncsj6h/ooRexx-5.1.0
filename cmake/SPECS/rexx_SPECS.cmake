#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# categorized sets of files used in all platforms.
set( interpreter_api_SRCS
  ${interpreter_api_dir}/CallContextStubs.cpp
  ${interpreter_api_dir}/InterpreterAPI.cpp
  ${interpreter_api_dir}/InterpreterInstanceStubs.cpp
  ${interpreter_api_dir}/MethodContextStubs.cpp
  ${interpreter_api_dir}/ThreadContextStubs.cpp
)

set( classes_support_SRCS
  ${classes_support_dir}/HashCollection.cpp
  ${classes_support_dir}/HashContents.cpp
  ${classes_support_dir}/ListContents.cpp
  ${classes_support_dir}/ProgramMetaData.cpp
  ${classes_support_dir}/CompoundTableElement.cpp
  ${classes_support_dir}/CompoundVariableTable.cpp
  ${classes_support_dir}/CompoundVariableTail.cpp
  ${classes_support_dir}/RexxDateTime.cpp
  ${classes_support_dir}/StringUtil.cpp
)

set( classes_SRCS
  ${classes_dir}/ArrayClass.cpp
  ${classes_dir}/BagClass.cpp
  ${classes_dir}/BufferClass.cpp
  ${classes_dir}/ClassClass.cpp
  ${classes_dir}/ContextClass.cpp
  ${classes_dir}/DirectoryClass.cpp
  ${classes_dir}/EventSemaphore.cpp
  ${classes_dir}/IntegerClass.cpp
  ${classes_dir}/ListClass.cpp
  ${classes_dir}/MessageClass.cpp
  ${classes_dir}/MethodClass.cpp
  ${classes_dir}/MutableBufferClass.cpp
  ${classes_dir}/MutexSemaphore.cpp
  ${classes_dir}/NumberStringClass.cpp
  ${classes_dir}/NumberStringMath.cpp
  ${classes_dir}/NumberStringMath2.cpp
  ${classes_dir}/ObjectClass.cpp
  ${classes_dir}/PackageClass.cpp
  ${classes_dir}/PointerClass.cpp
  ${classes_dir}/QueueClass.cpp
  ${classes_dir}/RelationClass.cpp
  ${classes_dir}/RexxInfoClass.cpp
  ${classes_dir}/RoutineClass.cpp
  ${classes_dir}/RexxQueueMethods.cpp
  ${classes_dir}/SetClass.cpp
  ${classes_dir}/StemClass.cpp
  ${classes_dir}/StringClass.cpp
  ${classes_dir}/StringClassBit.cpp
  ${classes_dir}/StringClassConversion.cpp
  ${classes_dir}/StringClassMisc.cpp
  ${classes_dir}/StringClassSub.cpp
  ${classes_dir}/StringClassUtil.cpp
  ${classes_dir}/StringClassWord.cpp
  ${classes_dir}/StringTableClass.cpp
  ${classes_dir}/SupplierClass.cpp
  ${classes_dir}/TableClass.cpp
  ${classes_dir}/IdentityTableClass.cpp
  ${classes_dir}/WeakReferenceClass.cpp
  ${classes_dir}/StackFrameClass.cpp
  ${classes_dir}/VariableReference.cpp
)

set( package_SRCS
  ${package_dir}/LibraryPackage.cpp
  ${package_dir}/PackageManager.cpp
)

set( memory_SRCS
  ${memory_dir}/DeadObject.cpp
  ${memory_dir}/FileNameBuffer.cpp
  ${memory_dir}/GlobalNames.cpp
  ${memory_dir}/MapBucket.cpp
  ${memory_dir}/MapTable.cpp
  ${memory_dir}/MemorySegment.cpp
  ${memory_dir}/MemoryStack.cpp
  ${memory_dir}/MemoryStats.cpp
  ${memory_dir}/NumberArray.cpp
  ${memory_dir}/PointerBucket.cpp
  ${memory_dir}/PointerTable.cpp
  ${memory_dir}/ProtectedObject.cpp
  ${memory_dir}/Envelope.cpp
  ${memory_dir}/InternalStack.cpp
  ${memory_dir}/SmartBuffer.cpp
  ${memory_dir}/UninitDispatcher.cpp
  ${memory_dir}/Setup.cpp
  ${memory_dir}/RexxMemory.cpp
)

set( execution_SRCS
  ${execution_dir}/CPPCode.cpp
  ${execution_dir}/ActivationStack.cpp
  ${execution_dir}/ActivationSettings.cpp
  ${execution_dir}/RexxActivation.cpp
  ${execution_dir}/BaseCode.cpp
  ${execution_dir}/RexxCode.cpp
  ${execution_dir}/BaseExecutable.cpp
  ${execution_dir}/RexxLocalVariables.cpp
  ${execution_dir}/NativeActivation.cpp
  ${execution_dir}/NativeCode.cpp
  ${execution_dir}/RexxVariable.cpp
  ${execution_dir}/TrapHandler.cpp
  ${execution_dir}/VariableDictionary.cpp
  ${execution_dir}/SecurityManager.cpp
  ${execution_dir}/TraceSetting.cpp
)

set( behaviour_SRCS
  ${behaviour_dir}/PrimitiveBehaviours.cpp
  ${behaviour_dir}/RexxBehaviour.cpp
  ${behaviour_dir}/MethodDictionary.cpp
  ${behaviour_dir}/VirtualFunctionTable.cpp
)

set( concurrency_SRCS
  ${concurrency_dir}/ActivityDispatcher.cpp
  ${concurrency_dir}/ActivityManager.cpp
  ${concurrency_dir}/ActivationFrame.cpp
  ${concurrency_dir}/CallbackDispatcher.cpp
  ${concurrency_dir}/TrappingDispatcher.cpp
  ${concurrency_dir}/ConditionTrappingDispatcher.cpp
  ${concurrency_dir}/ExitHandler.cpp
  ${concurrency_dir}/CommandHandler.cpp
  ${concurrency_dir}/MessageDispatcher.cpp
  ${concurrency_dir}/Activity.cpp
  ${concurrency_dir}/RexxStartDispatcher.cpp
  ${concurrency_dir}/TranslateDispatcher.cpp
)

set( expression_SRCS
  ${expression_dir}/BuiltinFunctions.cpp
  ${expression_dir}/CommonExternalFunctions.cpp
  ${expression_dir}/ExpressionClassResolver.cpp
  ${expression_dir}/ExpressionCompoundVariable.cpp
  ${expression_dir}/ExpressionDotVariable.cpp
  ${expression_dir}/SpecialDotVariable.cpp
  ${expression_dir}/ExpressionFunction.cpp
  ${expression_dir}/ExpressionMessage.cpp
  ${expression_dir}/ExpressionOperator.cpp
  ${expression_dir}/ExpressionQualifiedFunction.cpp
  ${expression_dir}/ExpressionStack.cpp
  ${expression_dir}/ExpressionStem.cpp
  ${expression_dir}/ExpressionVariable.cpp
  ${expression_dir}/IndirectVariableReference.cpp
  ${expression_dir}/ExpressionList.cpp
  ${expression_dir}/ExpressionLogical.cpp
  ${expression_dir}/VariableReferenceOp.cpp
)

set( instructions_SRCS
  ${instructions_dir}/AddressInstruction.cpp
  ${instructions_dir}/AddressWithInstruction.cpp
  ${instructions_dir}/AssignmentInstruction.cpp
  ${instructions_dir}/AddressInstruction.cpp
  ${instructions_dir}/BaseDoInstruction.cpp
  ${instructions_dir}/CallInstruction.cpp
  ${instructions_dir}/ClassDirective.cpp
  ${instructions_dir}/CommandInstruction.cpp
  ${instructions_dir}/CommandIOContext.cpp
  ${instructions_dir}/CommandIOConfiguration.cpp
  ${instructions_dir}/ConstantDirective.cpp
  ${instructions_dir}/InputRedirector.cpp
  ${instructions_dir}/OutputRedirector.cpp
  ${instructions_dir}/DoBlock.cpp
  ${instructions_dir}/DoBlockComponents.cpp
  ${instructions_dir}/DoCountInstruction.cpp
  ${instructions_dir}/SimpleDoInstruction.cpp
  ${instructions_dir}/ControlledDoInstruction.cpp
  ${instructions_dir}/DoForeverInstruction.cpp
  ${instructions_dir}/DoOverInstruction.cpp
  ${instructions_dir}/DoWithInstruction.cpp
  ${instructions_dir}/DoWhileInstruction.cpp
  ${instructions_dir}/DropInstruction.cpp
  ${instructions_dir}/ElseInstruction.cpp
  ${instructions_dir}/EndIf.cpp
  ${instructions_dir}/EndInstruction.cpp
  ${instructions_dir}/ExitInstruction.cpp
  ${instructions_dir}/ExposeInstruction.cpp
  ${instructions_dir}/ForwardInstruction.cpp
  ${instructions_dir}/GuardInstruction.cpp
  ${instructions_dir}/IfInstruction.cpp
  ${instructions_dir}/InterpretInstruction.cpp
  ${instructions_dir}/LabelInstruction.cpp
  ${instructions_dir}/LeaveInstruction.cpp
  ${instructions_dir}/LibraryDirective.cpp
  ${instructions_dir}/MessageInstruction.cpp
  ${instructions_dir}/NopInstruction.cpp
  ${instructions_dir}/NumericInstruction.cpp
  ${instructions_dir}/OptionsInstruction.cpp
  ${instructions_dir}/OtherwiseInstruction.cpp
  ${instructions_dir}/ParseInstruction.cpp
  ${instructions_dir}/ParseTarget.cpp
  ${instructions_dir}/ParseTrigger.cpp
  ${instructions_dir}/ProcedureInstruction.cpp
  ${instructions_dir}/QueueInstruction.cpp
  ${instructions_dir}/RaiseInstruction.cpp
  ${instructions_dir}/ReplyInstruction.cpp
  ${instructions_dir}/RequiresDirective.cpp
  ${instructions_dir}/ReturnInstruction.cpp
  ${instructions_dir}/RexxInstruction.cpp
  ${instructions_dir}/SayInstruction.cpp
  ${instructions_dir}/SelectInstruction.cpp
  ${instructions_dir}/SignalInstruction.cpp
  ${instructions_dir}/ThenInstruction.cpp
  ${instructions_dir}/TraceInstruction.cpp
  ${instructions_dir}/UseInstruction.cpp
  ${instructions_dir}/UseArgVariableRef.cpp
  ${instructions_dir}/UseLocalInstruction.cpp
  ${instructions_dir}/WhenCaseInstruction.cpp
)

set( parser_SRCS
  ${parser_dir}/Clause.cpp
  ${parser_dir}/KeywordConstants.cpp
  ${parser_dir}/DirectiveParser.cpp
  ${parser_dir}/InstructionParser.cpp
  ${parser_dir}/LanguageParser.cpp
  ${parser_dir}/ProgramSource.cpp
  ${parser_dir}/Scanner.cpp
  ${parser_dir}/Token.cpp
)

set( platform_SRCS
  ${interpreter_platform_dir}/ExternalFunctions.cpp
  ${interpreter_platform_dir}/MemorySupport.cpp
  ${interpreter_platform_dir}/MiscSystem.cpp
  ${interpreter_platform_dir}/SysActivity.cpp
  ${interpreter_platform_dir}/SysFileSystem.cpp
  ${interpreter_platform_dir}/SysInterpreterInstance.cpp
  ${interpreter_platform_dir}/SysRexxUtil.cpp
  ${interpreter_platform_dir}/SystemCommands.cpp
  ${interpreter_platform_dir}/SystemInitialization.cpp
  ${interpreter_platform_dir}/SystemInterpreter.cpp
  ${interpreter_platform_dir}/TimeSupport.cpp
  ${interpreter_platform_dir}/UseridFunction.cpp
  ${interpreter_platform_dir}/ValueFunction.cpp
)

set( common_SRCS
  ${common_dir}/Utilities.cpp
  ${common_platform_dir}/SysFile.cpp
  ${common_platform_dir}/SysLibrary.cpp
  ${common_platform_dir}/SysProcess.cpp
  ${common_platform_dir}/SysSemaphore.cpp
  ${common_platform_dir}/SysThread.cpp
)

set( runtime_SRCS
  ${runtime_dir}/InternalPackage.cpp
  ${runtime_dir}/Interpreter.cpp
  ${runtime_dir}/InterpreterInstance.cpp
  ${runtime_dir}/Numerics.cpp
  ${runtime_dir}/RexxUtilCommon.cpp
  ${runtime_dir}/Version.cpp
)

set( streamlibrary_SRCS
  ${streamlibrary_dir}/StreamCommandParser.cpp
  ${streamlibrary_dir}/StreamNative.cpp
  ${streamlibrary_dir}/FileNative.cpp
)

# Full set of files used in all platforms.
set( common_rexx_SRCS
  ${classes_SRCS}
  ${classes_support_SRCS}
  ${interpreter_api_SRCS}
  ${behaviour_SRCS}
  ${execution_SRCS}
  ${memory_SRCS}
  ${package_SRCS}
  ${concurrency_SRCS}
  ${expression_SRCS}
  ${instructions_SRCS}
  ${parser_SRCS}
  ${platform_SRCS}
  ${common_SRCS}
  ${runtime_SRCS}
  ${streamlibrary_SRCS}
)

# additional source files required by specific platforms
set( platform_interpreter_SRCS
  ${interpreter_platform_dir}/RexxMain.cpp
)

set( rexx_SRCS
  ${common_rexx_SRCS}
  ${platform_interpreter_SRCS}
)


# Include file definition
set( rexx_include_DIRS
  ${lib_dir}
  ${api_dir}
  ${api_platform_dir}
  ${common_dir}
  ${common_platform_dir}
  ${interpreter_dir}
  ${behaviour_dir}
  ${execution_dir}
  ${memory_dir}
  ${package_dir}
  ${concurrency_dir}
  ${expression_dir}
  ${instructions_dir}
  ${classes_dir}
  ${classes_support_dir}
  ${runtime_dir}
  ${parser_dir}
  ${messages_dir}
  ${streamlibrary_dir}
  ${interpreter_common_dir}
  ${interpreter_platform_dir}
)

# link library definitions
set( common_rexx_LIBS
  rexxapi
)

set( platform_rexx_LIBS
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rexx_LIBS
  rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)


set( rexx_pragma_DIAG
  deprecated-declarations
  stringop-overflow
)



