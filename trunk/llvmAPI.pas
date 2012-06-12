(*
    LLVM API for Delphi
      > Author: Aleksey A. Naumov [alexey.naumov@gmail.com]
      > License: BSD
      > Delphi API Version: 0.3c
      > LLVM C API Version: 3.1 Official Release

    Tested on Windows only & D2007, DXE2, FPC 2.6.
*)
unit llvmAPI;

{$IFDEF FPC}
  {$IFDEF CPUX86_64}
    {$DEFINE CPUX64}
  {$ENDIF}
{$ENDIF}

{.$DEFINE LLVM_DEBUG}                          // Only for debug w/ vLogs
{.$DEFINE LLVM_TRACE}                          // Only for trace w/ vLogs
{.$DEFINE LLVM_DYNAMIC_LINK}                   // Dynamic or Static linking of llvm.dll

// Modules
{$DEFINE LLVM_API_ANALYSIS}                   // Analysis.h
{$DEFINE LLVM_API_BITREADER}                  // BitReader.h
{$DEFINE LLVM_API_BITWRITER}                  // BitWriter.h
{$DEFINE LLVM_API_CORE}                       // Core.h
{-$DEFINE LLVM_API_DISASSEMBLER}               // Disassembler.h
{-$DEFINE LLVM_API_ENHANCEDDISASSEMBLY}        // EnhancedDisassembly.h
{$DEFINE LLVM_API_EXECUTIONENGINE}            // ExecutionEngine.h
{-$DEFINE LLVM_API_INITIALIZATION}             // Initialization.h
{-$DEFINE LLVM_API_LINKTIMEOPTIMIZER}          // LinkTimeOptimizer.h
{-$DEFINE LLVM_API_LTO}                        // lto.h
{$DEFINE LLVM_API_OBJECT}                     // Object.h
{$DEFINE LLVM_API_TARGET}                     // Target.h
{-$DEFINE LLVM_API_TARGETMACHINE}              // TargetMachine.h

{-$DEFINE LLVM_API_IPO}                        // Transforms\IPO.h
{-$DEFINE LLVM_API_PASSMANAGERBUILDER}         // Transforms\PassManagerBuilder.h
{-$DEFINE LLVM_API_SCALAR}                     // Transforms\Scalar.h
{-$DEFINE LLVM_API_VECTORIZE}                  // Transforms\Vectorize.h

// Options
{-$DEFINE ORIGINAL_LLVMBOOL}                   // Use LLVMBool = Integer

interface

uses
  Windows,
{$IFDEF LLVM_DEBUG}
  vLogs,
{$ENDIF}
  SysUtils;

// Internals & workarounds
const
  LLVMVersion = '3.1';
{$IFNDEF CPUX64}
  LLVMArch = 'x86';
{$ELSE}
  LLVMArch = 'x86_64';
{$ENDIF}
  LLVMVersionMajor = 3;
  LLVMVersionMinor = 1;
{$IFDEF MSWINDOWS}
  LLVMLibraryExt = '.dll';
{$ENDIF}
  LLVMLibrary = 'llvm-' + LLVMVersion + '.' + LLVMArch + LLVMLibraryExt;

type
  uint64_t  = UInt64;
  puint64_t = ^UInt64;
  uint8_t   = Byte;
  size_t    = {$IFDEF CPUX64}UInt64{$ELSE}Cardinal{$ENDIF};  // #WARNING
  psize_t   = ^size_t;
  off_t     = Int64;     // #WARNING

{$IFNDEF ORIGINAL_LLVMBOOL}
type
  LLVMBool = (
    LLVMFalse = 0,
    LLVMTrue = 1
  );
{$ENDIF}


// Converted C API
type
//*================================================= START of Core.h =================================================*//
{$IFDEF LLVM_API_CORE}

(*
 * @defgroup LLVMCCore Core
 *
 * This modules provide an interface to libLLVMCore, which implements
 * the LLVM intermediate representation as well as other related types
 * and utilities.
 *
 * LLVM uses a polymorphic type hierarchy which C cannot represent, therefore
 * parameters must be passed as base types. Despite the declared types, most
 * of the functions provided operate only on branches of the type hierarchy.
 * The declared parameter names are descriptive and specify which type is
 * required. Additionally, each type hierarchy is documented along with the
 * functions that operate upon it. For more detail, refer to LLVM's C++ code.
 * If in doubt, refer to Core.cpp, which performs paramter downcasts in the
 * form unwrap<RequiredType>(Param).
 *
 * Many exotic languages can interoperate with C code but have a harder time
 * with C++ due to name mangling. So in addition to C, this interface enables
 * tools written in such languages.
 *
 * When included into a C++ source file, also declares 'wrap' and 'unwrap'
 * helpers to perform opaque reference<-->pointer conversions. These helpers
 * are shorter and more tightly typed than writing the casts by hand when
 * authoring bindings. In assert builds, they will do runtime type checking.
 *
 * @{
 *)

  //typedef int LLVMBool;
{$IFDEF ORIGINAL_LLVMBOOL}
  LLVMBool = Integer;
{$ENDIF}

(* Opaque types. *)

(*
 * The top-level container for all LLVM global data. See the LLVMContext class.
 *)
  //typedef struct LLVMOpaqueContext *LLVMContextRef;
  LLVMOpaqueContext = packed record
  end;
  LLVMContextRef = ^LLVMOpaqueContext; 

(*
 * The top-level container for all other LLVM Intermediate Representation (IR)
 * objects.
 *
 * @see llvm::Module
 *)
  //typedef struct LLVMOpaqueModule *LLVMModuleRef;
  LLVMOpaqueModule = packed record
  end;
  LLVMModuleRef = ^LLVMOpaqueModule;

(*
 * Each value in the LLVM IR has a type, an LLVMTypeRef.
 *
 * @see llvm::Type
 *)
  //typedef struct LLVMOpaqueType *LLVMTypeRef;
  LLVMOpaqueType = packed record
  end;
  LLVMTypeRef = ^LLVMOpaqueType;

(*
 * Represents an individual value in LLVM IR.
 *
 * This models llvm::Value.
 *)
  //typedef struct LLVMOpaqueValue *LLVMValueRef;
  LLVMOpaqueValue = packed record
  end;
  LLVMValueRef = ^LLVMOpaqueValue;

(*
 * Represents a basic block of instruction in LLVM IR.
 *
 * This models llvm::BasicBlock.
 *)
  //typedef struct LLVMOpaqueBasicBlock *LLVMBasicBlockRef;
  LLVMOpaqueBasicBlock = packed record
  end;
  LLVMBasicBlockRef = ^LLVMOpaqueBasicBlock;

(*
 * Represents an LLVM basic block builder.
 *
 * This models llvm::IRBuilder.
 *)
  //typedef struct LLVMOpaqueBuilder *LLVMBuilderRef;
  LLVMOpaqueBuilder = packed record
  end;
  LLVMBuilderRef = ^LLVMOpaqueBuilder;

(*
 * Interface used to provide a module to JIT or interpreter.
 * This is now just a synonym for llvm::Module, but we have to keep using the
 * different type to keep binary compatibility.
 *)
  //typedef struct LLVMOpaqueModuleProvider *LLVMModuleProviderRef;
  LLVMOpaqueModuleProvider = packed record
  end;
  LLVMModuleProviderRef = ^LLVMOpaqueModuleProvider;

(*
 * Used to provide a module to JIT or interpreter.
 *
 * @see llvm::MemoryBuffer
 *)
  //typedef struct LLVMOpaqueMemoryBuffer *LLVMMemoryBufferRef;
  LLVMOpaqueMemoryBuffer = packed record
  end;
  LLVMMemoryBufferRef = ^LLVMOpaqueMemoryBuffer;

(* @see llvm::PassManagerBase *)
  //typedef struct LLVMOpaquePassManager *LLVMPassManagerRef;
  LLVMOpaquePassManager = packed record
  end;
  LLVMPassManagerRef = ^LLVMOpaquePassManager;

(* @see llvm::PassRegistry *)
  //typedef struct LLVMOpaquePassRegistry *LLVMPassRegistryRef;
  LLVMOpaquePassRegistry = packed record
  end;
  LLVMPassRegistryRef = ^LLVMOpaquePassRegistry;

(*
 * Used to get the users and usees of a Value.
 *
 * @see llvm::Use *)
  //typedef struct LLVMOpaqueUse *LLVMUseRef;
  LLVMOpaqueUse = packed record
  end;
  LLVMUseRef = ^LLVMOpaqueUse;

(*
typedef enum {
    LLVMZExtAttribute       = 1<<0,
    LLVMSExtAttribute       = 1<<1,
    LLVMNoReturnAttribute   = 1<<2,
    LLVMInRegAttribute      = 1<<3,
    LLVMStructRetAttribute  = 1<<4,
    LLVMNoUnwindAttribute   = 1<<5,
    LLVMNoAliasAttribute    = 1<<6,
    LLVMByValAttribute      = 1<<7,
    LLVMNestAttribute       = 1<<8,
    LLVMReadNoneAttribute   = 1<<9,
    LLVMReadOnlyAttribute   = 1<<10,
    LLVMNoInlineAttribute   = 1<<11,
    LLVMAlwaysInlineAttribute    = 1<<12,
    LLVMOptimizeForSizeAttribute = 1<<13,
    LLVMStackProtectAttribute    = 1<<14,
    LLVMStackProtectReqAttribute = 1<<15,
    LLVMAlignment = 31<<16,
    LLVMNoCaptureAttribute  = 1<<21,
    LLVMNoRedZoneAttribute  = 1<<22,
    LLVMNoImplicitFloatAttribute = 1<<23,
    LLVMNakedAttribute      = 1<<24,
    LLVMInlineHintAttribute = 1<<25,
    LLVMStackAlignment = 7<<26,
    LLVMReturnsTwice = 1 << 29,
    LLVMUWTable = 1 << 30,
    LLVMNonLazyBind = 1 << 31

    // FIXME: This attribute is currently not included in the C API as
    // a temporary measure until the API/ABI impact to the C API is understood
    // and the path forward agreed upon.
    //LLVMAddressSafety = 1ULL << 32
} LLVMAttribute;
*)
  // #WARNING
  LLVMAttribute = (
    LLVMZExtAttribute            = 1 shl 0,
    LLVMSExtAttribute            = 1 shl 1,
    LLVMNoReturnAttribute        = 1 shl 2,
    LLVMInRegAttribute           = 1 shl 3,
    LLVMStructRetAttribute       = 1 shl 4,
    LLVMNoUnwindAttribute        = 1 shl 5,
    LLVMNoAliasAttribute         = 1 shl 6,
    LLVMByValAttribute           = 1 shl 7,
    LLVMNestAttribute            = 1 shl 8,
    LLVMReadNoneAttribute        = 1 shl 9,
    LLVMReadOnlyAttribute        = 1 shl 10,
    LLVMNoInlineAttribute        = 1 shl 11,
    LLVMAlwaysInlineAttribute    = 1 shl 12,
    LLVMOptimizeForSizeAttribute = 1 shl 13,
    LLVMStackProtectAttribute    = 1 shl 14,
    LLVMStackProtectReqAttribute = 1 shl 15,
    LLVMAlignment                = 31 shl 16,
    LLVMNoCaptureAttribute       = 1 shl 21,
    LLVMNoRedZoneAttribute       = 1 shl 22,
    LLVMNoImplicitFloatAttribute = 1 shl 23,
    LLVMNakedAttribute           = 1 shl 24,
    LLVMInlineHintAttribute      = 1 shl 25,
    LLVMStackAlignment           = 7 shl 26,
    LLVMReturnsTwice             = 1 shl 29,
    LLVMUWTable                  = 1 shl 30,
    LLVMNonLazyBind              = 1 shl 31

    // FIXME: This attribute is currently not included in the C API as
    // a temporary measure until the API/ABI impact to the C API is understood
    // and the path forward agreed upon.
    //LLVMAddressSafety          = 1ULL shl 32
  );

(*
typedef enum {
  // Terminator Instructions 
  LLVMRet            = 1,
  LLVMBr             = 2,
  LLVMSwitch         = 3,
  LLVMIndirectBr     = 4,
  LLVMInvoke         = 5,
  // removed 6 due to API changes 
  LLVMUnreachable    = 7,

  // Standard Binary Operators 
  LLVMAdd            = 8,
  LLVMFAdd           = 9,
  LLVMSub            = 10,
  LLVMFSub           = 11,
  LLVMMul            = 12,
  LLVMFMul           = 13,
  LLVMUDiv           = 14,
  LLVMSDiv           = 15,
  LLVMFDiv           = 16,
  LLVMURem           = 17,
  LLVMSRem           = 18,
  LLVMFRem           = 19,

  // Logical Operators 
  LLVMShl            = 20,
  LLVMLShr           = 21,
  LLVMAShr           = 22,
  LLVMAnd            = 23,
  LLVMOr             = 24,
  LLVMXor            = 25,

  // Memory Operators 
  LLVMAlloca         = 26,
  LLVMLoad           = 27,
  LLVMStore          = 28,
  LLVMGetElementPtr  = 29,

  // Cast Operators 
  LLVMTrunc          = 30,
  LLVMZExt           = 31,
  LLVMSExt           = 32,
  LLVMFPToUI         = 33,
  LLVMFPToSI         = 34,
  LLVMUIToFP         = 35,
  LLVMSIToFP         = 36,
  LLVMFPTrunc        = 37,
  LLVMFPExt          = 38,
  LLVMPtrToInt       = 39,
  LLVMIntToPtr       = 40,
  LLVMBitCast        = 41,

  // Other Operators 
  LLVMICmp           = 42,
  LLVMFCmp           = 43,
  LLVMPHI            = 44,
  LLVMCall           = 45,
  LLVMSelect         = 46,
  LLVMUserOp1        = 47,
  LLVMUserOp2        = 48,
  LLVMVAArg          = 49,
  LLVMExtractElement = 50,
  LLVMInsertElement  = 51,
  LLVMShuffleVector  = 52,
  LLVMExtractValue   = 53,
  LLVMInsertValue    = 54,

  // Atomic operators 
  LLVMFence          = 55,
  LLVMAtomicCmpXchg  = 56,
  LLVMAtomicRMW      = 57,

  // Exception Handling Operators 
  LLVMResume         = 58,
  LLVMLandingPad     = 59

} LLVMOpcode;
*)
  LLVMOpcode = (
    // Terminator Instructions 
    LLVMRet            = 1,
    LLVMBr             = 2,
    LLVMSwitch         = 3,
    LLVMIndirectBr     = 4,
    LLVMInvoke         = 5,
    // removed 6 due to API changes 
    LLVMUnreachable    = 7,

    // Standard Binary Operators 
    LLVMAdd            = 8,
    LLVMFAdd           = 9,
    LLVMSub            = 10,
    LLVMFSub           = 11,
    LLVMMul            = 12,
    LLVMFMul           = 13,
    LLVMUDiv           = 14,
    LLVMSDiv           = 15,
    LLVMFDiv           = 16,
    LLVMURem           = 17,
    LLVMSRem           = 18,
    LLVMFRem           = 19,

    // Logical Operators 
    LLVMShl            = 20,
    LLVMLShr           = 21,
    LLVMAShr           = 22,
    LLVMAnd            = 23,
    LLVMOr             = 24,
    LLVMXor            = 25,

    // Memory Operators 
    LLVMAlloca         = 26,
    LLVMLoad           = 27,
    LLVMStore          = 28,
    LLVMGetElementPtr  = 29,

    // Cast Operators 
    LLVMTrunc          = 30,
    LLVMZExt           = 31,
    LLVMSExt           = 32,
    LLVMFPToUI         = 33,
    LLVMFPToSI         = 34,
    LLVMUIToFP         = 35,
    LLVMSIToFP         = 36,
    LLVMFPTrunc        = 37,
    LLVMFPExt          = 38,
    LLVMPtrToInt       = 39,
    LLVMIntToPtr       = 40,
    LLVMBitCast        = 41,

    // Other Operators 
    LLVMICmp           = 42,
    LLVMFCmp           = 43,
    LLVMPHI            = 44,
    LLVMCall           = 45,
    LLVMSelect         = 46,
    LLVMUserOp1        = 47,
    LLVMUserOp2        = 48,
    LLVMVAArg          = 49,
    LLVMExtractElement = 50,
    LLVMInsertElement  = 51,
    LLVMShuffleVector  = 52,
    LLVMExtractValue   = 53,
    LLVMInsertValue    = 54,

    // Atomic operators 
    LLVMFence          = 55,
    LLVMAtomicCmpXchg  = 56,
    LLVMAtomicRMW      = 57,

    // Exception Handling Operators 
    LLVMResume         = 58,
    LLVMLandingPad     = 59
  );

(*
typedef enum {
  LLVMVoidTypeKind,        // type with no size 
  LLVMHalfTypeKind,        // 16 bit floating point type 
  LLVMFloatTypeKind,       // 32 bit floating point type
  LLVMDoubleTypeKind,      // 64 bit floating point type 
  LLVMX86_FP80TypeKind,    // 80 bit floating point type (X87) 
  LLVMFP128TypeKind,       // 128 bit floating point type (112-bit mantissa)
  LLVMPPC_FP128TypeKind,   // 128 bit floating point type (two 64-bits) 
  LLVMLabelTypeKind,       // Labels 
  LLVMIntegerTypeKind,     // Arbitrary bit width integers 
  LLVMFunctionTypeKind,    // Functions 
  LLVMStructTypeKind,      // Structures 
  LLVMArrayTypeKind,       // Arrays 
  LLVMPointerTypeKind,     // Pointers 
  LLVMVectorTypeKind,      // SIMD 'packed' format, or other vector type 
  LLVMMetadataTypeKind,    // Metadata 
  LLVMX86_MMXTypeKind      // X86 MMX 
} LLVMTypeKind;
*)
  LLVMTypeKind = (
    LLVMVoidTypeKind,        // type with no size 
    LLVMHalfTypeKind,        // 16 bit floating point type 
    LLVMFloatTypeKind,       // 32 bit floating point type
    LLVMDoubleTypeKind,      // 64 bit floating point type 
    LLVMX86_FP80TypeKind,    // 80 bit floating point type (X87) 
    LLVMFP128TypeKind,       // 128 bit floating point type (112-bit mantissa)
    LLVMPPC_FP128TypeKind,   // 128 bit floating point type (two 64-bits) 
    LLVMLabelTypeKind,       // Labels 
    LLVMIntegerTypeKind,     // Arbitrary bit width integers 
    LLVMFunctionTypeKind,    // Functions 
    LLVMStructTypeKind,      // Structures 
    LLVMArrayTypeKind,       // Arrays 
    LLVMPointerTypeKind,     // Pointers 
    LLVMVectorTypeKind,      // SIMD 'packed' format, or other vector type 
    LLVMMetadataTypeKind,    // Metadata 
    LLVMX86_MMXTypeKind      // X86 MMX 
  );

(*
typedef enum {
  LLVMExternalLinkage,    // Externally visible function 
  LLVMAvailableExternallyLinkage,
  LLVMLinkOnceAnyLinkage, // Keep one copy of function when linking (inline)
  LLVMLinkOnceODRLinkage, // Same, but only replaced by something
                            equivalent. 
  LLVMWeakAnyLinkage,     // Keep one copy of function when linking (weak) 
  LLVMWeakODRLinkage,     // Same, but only replaced by something
                            equivalent. 
  LLVMAppendingLinkage,   // Special purpose, only applies to global arrays 
  LLVMInternalLinkage,    // Rename collisions when linking (static
                               functions) 
  LLVMPrivateLinkage,     // Like Internal, but omit from symbol table 
  LLVMDLLImportLinkage,   // Function to be imported from DLL 
  LLVMDLLExportLinkage,   // Function to be accessible from DLL 
  LLVMExternalWeakLinkage,// ExternalWeak linkage description 
  LLVMGhostLinkage,       // Obsolete 
  LLVMCommonLinkage,      // Tentative definitions 
  LLVMLinkerPrivateLinkage, // Like Private, but linker removes. 
  LLVMLinkerPrivateWeakLinkage, // Like LinkerPrivate, but is weak. 
  LLVMLinkerPrivateWeakDefAutoLinkage // Like LinkerPrivateWeak, but possibly
                                           hidden. 
} LLVMLinkage;
*)
  LLVMLinkage = (
    LLVMExternalLinkage,    // Externally visible function 
    LLVMAvailableExternallyLinkage,
    LLVMLinkOnceAnyLinkage, // Keep one copy of function when linking (inline)
    LLVMLinkOnceODRLinkage, // Same, but only replaced by something equivalent. 
    LLVMWeakAnyLinkage,     // Keep one copy of function when linking (weak) 
    LLVMWeakODRLinkage,     // Same, but only replaced by something equivalent. 
    LLVMAppendingLinkage,   // Special purpose, only applies to global arrays 
    LLVMInternalLinkage,    // Rename collisions when linking (static functions) 
    LLVMPrivateLinkage,     // Like Internal, but omit from symbol table 
    LLVMDLLImportLinkage,   // Function to be imported from DLL 
    LLVMDLLExportLinkage,   // Function to be accessible from DLL 
    LLVMExternalWeakLinkage,// ExternalWeak linkage description 
    LLVMGhostLinkage,       // Obsolete 
    LLVMCommonLinkage,      // Tentative definitions 
    LLVMLinkerPrivateLinkage, // Like Private, but linker removes. 
    LLVMLinkerPrivateWeakLinkage, // Like LinkerPrivate, but is weak. 
    LLVMLinkerPrivateWeakDefAutoLinkage // Like LinkerPrivateWeak, but possibly hidden. 
  );

(*
typedef enum {
  LLVMDefaultVisibility,  // The GV is visible 
  LLVMHiddenVisibility,   // The GV is hidden 
  LLVMProtectedVisibility // The GV is protected 
} LLVMVisibility;
*)
  LLVMVisibility = (
    LLVMDefaultVisibility,  // The GV is visible 
    LLVMHiddenVisibility,   // The GV is hidden 
    LLVMProtectedVisibility // The GV is protected 
  );

(*
typedef enum {
  LLVMCCallConv           = 0,
  LLVMFastCallConv        = 8,
  LLVMColdCallConv        = 9,
  LLVMX86StdcallCallConv  = 64,
  LLVMX86FastcallCallConv = 65
} LLVMCallConv;
*)
  LLVMCallConv = (
    LLVMCCallConv           = 0,
    LLVMFastCallConv        = 8,
    LLVMColdCallConv        = 9,
    LLVMX86StdcallCallConv  = 64,
    LLVMX86FastcallCallConv = 65
  );

(*
typedef enum {
  LLVMIntEQ = 32, // equal 
  LLVMIntNE,      // not equal 
  LLVMIntUGT,     // unsigned greater than 
  LLVMIntUGE,     // unsigned greater or equal 
  LLVMIntULT,     // unsigned less than 
  LLVMIntULE,     // unsigned less or equal 
  LLVMIntSGT,     // signed greater than 
  LLVMIntSGE,     // signed greater or equal 
  LLVMIntSLT,     // signed less than 
  LLVMIntSLE      // signed less or equal 
} LLVMIntPredicate;
*)
  LLVMIntPredicate = (
    LLVMIntEQ = 32, // equal 
    LLVMIntNE,      // not equal 
    LLVMIntUGT,     // unsigned greater than 
    LLVMIntUGE,     // unsigned greater or equal 
    LLVMIntULT,     // unsigned less than 
    LLVMIntULE,     // unsigned less or equal 
    LLVMIntSGT,     // signed greater than 
    LLVMIntSGE,     // signed greater or equal 
    LLVMIntSLT,     // signed less than 
    LLVMIntSLE      // signed less or equal 
  );

(*
typedef enum {
  LLVMRealPredicateFalse, // Always false (always folded) 
  LLVMRealOEQ,            // True if ordered and equal 
  LLVMRealOGT,            // True if ordered and greater than 
  LLVMRealOGE,            // True if ordered and greater than or equal 
  LLVMRealOLT,            // True if ordered and less than 
  LLVMRealOLE,            // True if ordered and less than or equal 
  LLVMRealONE,            // True if ordered and operands are unequal 
  LLVMRealORD,            // True if ordered (no nans) 
  LLVMRealUNO,            // True if unordered: isnan(X) | isnan(Y) 
  LLVMRealUEQ,            // True if unordered or equal 
  LLVMRealUGT,            // True if unordered or greater than 
  LLVMRealUGE,            // True if unordered, greater than, or equal 
  LLVMRealULT,            // True if unordered or less than 
  LLVMRealULE,            // True if unordered, less than, or equal 
  LLVMRealUNE,            // True if unordered or not equal 
  LLVMRealPredicateTrue   // Always true (always folded) 
} LLVMRealPredicate;
*)
  LLVMRealPredicate = (
    LLVMRealPredicateFalse, // Always false (always folded) 
    LLVMRealOEQ,            // True if ordered and equal 
    LLVMRealOGT,            // True if ordered and greater than 
    LLVMRealOGE,            // True if ordered and greater than or equal 
    LLVMRealOLT,            // True if ordered and less than 
    LLVMRealOLE,            // True if ordered and less than or equal 
    LLVMRealONE,            // True if ordered and operands are unequal 
    LLVMRealORD,            // True if ordered (no nans) 
    LLVMRealUNO,            // True if unordered: isnan(X) | isnan(Y) 
    LLVMRealUEQ,            // True if unordered or equal 
    LLVMRealUGT,            // True if unordered or greater than 
    LLVMRealUGE,            // True if unordered, greater than, or equal 
    LLVMRealULT,            // True if unordered or less than 
    LLVMRealULE,            // True if unordered, less than, or equal 
    LLVMRealUNE,            // True if unordered or not equal 
    LLVMRealPredicateTrue   // Always true (always folded) 
  );

(*
typedef enum {
  LLVMLandingPadCatch,    // A catch clause   
  LLVMLandingPadFilter    // A filter clause  
} LLVMLandingPadClauseTy;
*)
  LLVMLandingPadClauseTy = (
    LLVMLandingPadCatch,    // A catch clause   
    LLVMLandingPadFilter    // A filter clause  
  );

(*
 * @}
 *)

  //void LLVMInitializeCore(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeCore = procedure(R: LLVMPassRegistryRef); cdecl;
{$ELSE}
  procedure LLVMInitializeCore(R: LLVMPassRegistryRef); cdecl; external LLVMLibrary name 'LLVMInitializeCore';
{$ENDIF}


(*===-- Error handling ----------------------------------------------------===*)

  //void LLVMDisposeMessage(char *Message);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeMessage = procedure(_Message: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMDisposeMessage(_Message: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMDisposeMessage';
{$ENDIF}

(*
 * @defgroup LLVMCCoreContext Contexts
 *
 * Contexts are execution states for the core LLVM IR system.
 *
 * Most types are tied to a context instance. Multiple contexts can
 * exist simultaneously. A single context is not thread safe. However,
 * different contexts can execute on different threads simultaneously.
 *
 * @{
 *)

(*
 * Create a new context.
 *
 * Every call to this function should be paired with a call to
 * LLVMContextDispose() or the context will leak memory.
 *)
  //LLVMContextRef LLVMContextCreate(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMContextCreate = function(): LLVMContextRef; cdecl;
{$ELSE}
  function LLVMContextCreate(): LLVMContextRef; cdecl; external LLVMLibrary name 'LLVMContextCreate';
{$ENDIF}

(*
 * Obtain the global context instance.
 *)
  //LLVMContextRef LLVMGetGlobalContext(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetGlobalContext = function(): LLVMContextRef; cdecl;
{$ELSE}
  function LLVMGetGlobalContext(): LLVMContextRef; cdecl; external LLVMLibrary name 'LLVMGetGlobalContext';
{$ENDIF}

(*
 * Destroy a context instance.
 *
 * This should be called for every call to LLVMContextCreate() or memory
 * will be leaked.
 *)
  //void LLVMContextDispose(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMContextDispose = procedure(C: LLVMContextRef); cdecl;
{$ELSE}
  procedure LLVMContextDispose(C: LLVMContextRef); cdecl; external LLVMLibrary name 'LLVMContextDispose';
{$ENDIF}

  //unsigned LLVMGetMDKindIDInContext(LLVMContextRef C, const char* Name, unsigned SLen);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetMDKindIDInContext = function(C: LLVMContextRef; Name: PAnsiChar; SLen: Cardinal): Cardinal; cdecl;
{$ELSE}
  function LLVMGetMDKindIDInContext(C: LLVMContextRef; Name: PAnsiChar; SLen: Cardinal): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetMDKindIDInContext';
{$ENDIF}
  
  //unsigned LLVMGetMDKindID(const char* Name, unsigned SLen);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetMDKindID = function(Name: PAnsiChar; SLen: Cardinal): Cardinal; cdecl;
{$ELSE}
  function LLVMGetMDKindID(Name: PAnsiChar; SLen: Cardinal): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetMDKindID';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreModule Modules
 *
 * Modules represent the top-level structure in a LLVM program. An LLVM
 * module is effectively a translation unit or a collection of
 * translation units merged together.
 *
 * @{
 *)

(*
 * Create a new, empty module in the global context.
 *
 * This is equivalent to calling LLVMModuleCreateWithNameInContext with
 * LLVMGetGlobalContext() as the context parameter.
 *
 * Every invocation should be paired with LLVMDisposeModule() or memory
 * will be leaked.
 *)
  //LLVMModuleRef LLVMModuleCreateWithName(const char *ModuleID);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMModuleCreateWithName = function(ModuleID: PAnsiChar): LLVMModuleRef; cdecl;
{$ELSE}
  function LLVMModuleCreateWithName(ModuleID: PAnsiChar): LLVMModuleRef; cdecl; external LLVMLibrary name 'LLVMModuleCreateWithName';
{$ENDIF}

(*
 * Create a new, empty module in a specific context.
 *
 * Every invocation should be paired with LLVMDisposeModule() or memory
 * will be leaked.
 *)
  //LLVMModuleRef LLVMModuleCreateWithNameInContext(const char *ModuleID, LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMModuleCreateWithNameInContext = function(ModuleID: PAnsiChar; C: LLVMContextRef): LLVMModuleRef; cdecl;
{$ELSE}
  function LLVMModuleCreateWithNameInContext(ModuleID: PAnsiChar; C: LLVMContextRef): LLVMModuleRef; cdecl; external LLVMLibrary name 'LLVMModuleCreateWithNameInContext';
{$ENDIF}

(*
 * Destroy a module instance.
 *
 * This must be called for every created module or memory will be
 * leaked.
 *)
  //void LLVMDisposeModule(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeModule = procedure(M: LLVMModuleRef); cdecl;
{$ELSE}
  procedure LLVMDisposeModule(M: LLVMModuleRef); cdecl; external LLVMLibrary name 'LLVMDisposeModule';
{$ENDIF}

(*
 * Obtain the data layout for a module.
 *
 * @see Module::getDataLayout()
 *)
  //const char *LLVMGetDataLayout(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetDataLayout = function(M: LLVMModuleRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetDataLayout(M: LLVMModuleRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetDataLayout';
{$ENDIF}

(*
 * Set the data layout for a module.
 *
 * @see Module::setDataLayout()
 *)
  //void LLVMSetDataLayout(LLVMModuleRef M, const char *Triple);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetDataLayout = procedure(M: LLVMModuleRef; Triple: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMSetDataLayout(M: LLVMModuleRef; Triple: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMSetDataLayout';
{$ENDIF}

(*
 * Obtain the target triple for a module.
 *
 * @see Module::getTargetTriple()
 *)
  //const char *LLVMGetTarget(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTarget = function(M: LLVMModuleRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetTarget(M: LLVMModuleRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetTarget';
{$ENDIF}

(*
 * Set the target triple for a module.
 *
 * @see Module::setTargetTriple()
 *)
  //void LLVMSetTarget(LLVMModuleRef M, const char *Triple);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetTarget = procedure(M: LLVMModuleRef; Triple: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMSetTarget(M: LLVMModuleRef; Triple: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMSetTarget';
{$ENDIF}

(*
 * Dump a representation of a module to stderr.
 *
 * @see Module::dump()
 *)
  //void LLVMDumpModule(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDumpModule = procedure(M: LLVMModuleRef); cdecl;
{$ELSE}
  procedure LLVMDumpModule(M: LLVMModuleRef); cdecl; external LLVMLibrary name 'LLVMDumpModule';
{$ENDIF}

(*
 * Set inline assembly for a module.
 *
 * @see Module::setModuleInlineAsm()
 *)
  //void LLVMSetModuleInlineAsm(LLVMModuleRef M, const char *Asm);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetModuleInlineAsm = procedure(M: LLVMModuleRef; _Asm: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMSetModuleInlineAsm(M: LLVMModuleRef; _Asm: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMSetModuleInlineAsm';
{$ENDIF}

(*
 * Obtain the context to which this module is associated.
 *
 * @see Module::getContext()
 *)
  //LLVMContextRef LLVMGetModuleContext(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetModuleContext = function(M: LLVMModuleRef): LLVMContextRef; cdecl;
{$ELSE}
  function LLVMGetModuleContext(M: LLVMModuleRef): LLVMContextRef; cdecl; external LLVMLibrary name 'LLVMGetModuleContext';
{$ENDIF}

(*
 * Obtain a Type from a module by its registered name.
 *)
  //LLVMTypeRef LLVMGetTypeByName(LLVMModuleRef M, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTypeByName = function(M: LLVMModuleRef; Name: PAnsiChar): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMGetTypeByName(M: LLVMModuleRef; Name: PAnsiChar): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMGetTypeByName';
{$ENDIF}

(*
 * Obtain the number of operands for named metadata in a module.
 *
 * @see llvm::Module::getNamedMetadata()
 *)
  //unsigned LLVMGetNamedMetadataNumOperands(LLVMModuleRef M, const char* name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNamedMetadataNumOperands = function(M: LLVMModuleRef; Name: PAnsiChar): Cardinal; cdecl;
{$ELSE}
  function LLVMGetNamedMetadataNumOperands(M: LLVMModuleRef; Name: PAnsiChar): Cardinal; cdecl;  external LLVMLibrary name 'LLVMGetNamedMetadataNumOperands';
{$ENDIF}

(*
 * Obtain the named metadata operands for a module.
 *
 * The passed LLVMValueRef pointer should refer to an array of
 * LLVMValueRef at least LLVMGetNamedMetadataNumOperands long. This
 * array will be populated with the LLVMValueRef instances. Each
 * instance corresponds to a llvm::MDNode.
 *
 * @see llvm::Module::getNamedMetadata()
 * @see llvm::MDNode::getOperand()
 *)
  //void LLVMGetNamedMetadataOperands(LLVMModuleRef M, const char* name, LLVMValueRef *Dest);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNamedMetadataOperands = procedure(M: LLVMModuleRef; Name: PAnsiChar; var Dest: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMGetNamedMetadataOperands(M: LLVMModuleRef; Name: PAnsiChar; var Dest: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMGetNamedMetadataOperands';
{$ENDIF}

(*
 * Add an operand to named metadata.
 *
 * @see llvm::Module::getNamedMetadata()
 * @see llvm::MDNode::addOperand()
 *)
  //void LLVMAddNamedMetadataOperand(LLVMModuleRef M, const char* name,
  //                               LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddNamedMetadataOperand = procedure(M: LLVMModuleRef; Name: PAnsiChar; Val: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMAddNamedMetadataOperand(M: LLVMModuleRef; Name: PAnsiChar; Val: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMAddNamedMetadataOperand';
{$ENDIF}

(*
 * Add a function to a module under a specified name.
 *
 * @see llvm::Function::Create()
 *)
  //LLVMValueRef LLVMAddFunction(LLVMModuleRef M, const char *Name, LLVMTypeRef FunctionTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddFunction = function(M: LLVMModuleRef; Name: PAnsiChar; FunctionTy: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMAddFunction(M: LLVMModuleRef; Name: PAnsiChar; FunctionTy: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMAddFunction';
{$ENDIF}

(*
 * Obtain a Function value from a Module by its name.
 *
 * The returned value corresponds to a llvm::Function value.
 *
 * @see llvm::Module::getFunction()
 *)
  //LLVMValueRef LLVMGetNamedFunction(LLVMModuleRef M, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNamedFunction = function(M: LLVMModuleRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetNamedFunction(M: LLVMModuleRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetNamedFunction';
{$ENDIF}

(*
 * Obtain an iterator to the first Function in a Module.
 *
 * @see llvm::Module::begin()
 *)
  //LLVMValueRef LLVMGetFirstFunction(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstFunction = function(M: LLVMModuleRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetFirstFunction(M: LLVMModuleRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetFirstFunction';
{$ENDIF}

(*
 * Obtain an iterator to the last Function in a Module.
 *
 * @see llvm::Module::end()
 *)
  //LLVMValueRef LLVMGetLastFunction(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetLastFunction = function(M: LLVMModuleRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetLastFunction(M: LLVMModuleRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetLastFunction';
{$ENDIF}

(*
 * Advance a Function iterator to the next Function.
 *
 * Returns NULL if the iterator was already at the end and there are no more
 * functions.
 *)
  //LLVMValueRef LLVMGetNextFunction(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextFunction = function(Fn: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetNextFunction(Fn: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetNextFunction';
{$ENDIF}

(*
 * Decrement a Function iterator to the previous Function.
 *
 * Returns NULL if the iterator was already at the beginning and there are
 * no previous functions.
 *)
  //LLVMValueRef LLVMGetPreviousFunction(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPreviousFunction = function(Fn: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetPreviousFunction(Fn: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetPreviousFunction';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreType Types
 *
 * Types represent the type of a value.
 *
 * Types are associated with a context instance. The context internally
 * deduplicates types so there is only 1 instance of a specific type
 * alive at a time. In other words, a unique type is shared among all
 * consumers within a context.
 *
 * A Type in the C API corresponds to llvm::Type.
 *
 * Types have the following hierarchy:
 *
 *   types:
 *     integer type
 *     real type
 *     function type
 *     sequence types:
 *       array type
 *       pointer type
 *       vector type
 *     void type
 *     label type
 *     opaque type
 *
 * @{
 *)

(*
 * Obtain the enumerated type of a Type instance.
 *
 * @see llvm::Type:getTypeID()
 *)
  //LLVMTypeKind LLVMGetTypeKind(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTypeKind = function(Ty: LLVMTypeRef): LLVMTypeKind; cdecl;
{$ELSE}
  function LLVMGetTypeKind(Ty: LLVMTypeRef): LLVMTypeKind; cdecl; external LLVMLibrary name 'LLVMGetTypeKind';
{$ENDIF}

(*
 * Whether the type has a known size.
 *
 * Things that don't have a size are abstract types, labels, and void.a
 *
 * @see llvm::Type::isSized()
 *)
  //LLVMBool LLVMTypeIsSized(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMTypeIsSized = function(Ty: LLVMTypeRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMTypeIsSized(Ty: LLVMTypeRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMTypeIsSized';
{$ENDIF}

(*
 * Obtain the context to which this type instance is associated.
 *
 * @see llvm::Type::getContext()
 *)
  //LLVMContextRef LLVMGetTypeContext(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTypeContext = function(Ty: LLVMTypeRef): LLVMContextRef; cdecl;
{$ELSE}
  function LLVMGetTypeContext(Ty: LLVMTypeRef): LLVMContextRef; cdecl; external LLVMLibrary name 'LLVMGetTypeContext';
{$ENDIF}

(*
 * @defgroup LLVMCCoreTypeInt Integer Types
 *
 * Functions in this section operate on integer types.
 *
 * @{
 *)

(*
 * Obtain an integer type from a context with specified bit width.
 *)
  //LLVMTypeRef LLVMInt1TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt1TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt1TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt1TypeInContext';
{$ENDIF}
  //LLVMTypeRef LLVMInt8TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt8TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt8TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt8TypeInContext';
{$ENDIF}
  //LLVMTypeRef LLVMInt16TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt16TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt16TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt16TypeInContext';
{$ENDIF}
  //LLVMTypeRef LLVMInt32TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt32TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt32TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt32TypeInContext';
{$ENDIF}
  //LLVMTypeRef LLVMInt64TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt64TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt64TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt64TypeInContext';
{$ENDIF}
  //LLVMTypeRef LLVMIntTypeInContext(LLVMContextRef C, unsigned NumBits);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIntTypeInContext = function(C: LLVMContextRef; NumBits: Cardinal): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMIntTypeInContext(C: LLVMContextRef; NumBits: Cardinal): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMIntTypeInContext';
{$ENDIF}

(*
 * Obtain an integer type from the global context with a specified bit
 * width.
 *)
  //LLVMTypeRef LLVMInt1Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt1Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt1Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt1Type';
{$ENDIF}
  //LLVMTypeRef LLVMInt8Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt8Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt8Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt8Type';
{$ENDIF}
  //LLVMTypeRef LLVMInt16Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt16Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt16Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt16Type';
{$ENDIF}
  //LLVMTypeRef LLVMInt32Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt32Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt32Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt32Type';
{$ENDIF}
  //LLVMTypeRef LLVMInt64Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInt64Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMInt64Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMInt64Type';
{$ENDIF}
  //LLVMTypeRef LLVMIntType(unsigned NumBits);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIntType = function(NumBits: Cardinal): LLVMTypeRef; cdecl; 
{$ELSE}
  function LLVMIntType(NumBits: Cardinal): LLVMTypeRef; cdecl;  external LLVMLibrary name 'LLVMIntType';
{$ENDIF}
  //unsigned LLVMGetIntTypeWidth(LLVMTypeRef IntegerTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetIntTypeWidth = function(IntegerTy: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetIntTypeWidth(IntegerTy: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetIntTypeWidth';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreTypeFloat Floating Point Types
 *
 * @{
 *)

(*
 * Obtain a 16-bit floating point type from a context.
 *)
  //LLVMTypeRef LLVMHalfTypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMHalfTypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMHalfTypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMHalfTypeInContext';
{$ENDIF}

(*
 * Obtain a 32-bit floating point type from a context.
 *)
  //LLVMTypeRef LLVMFloatTypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFloatTypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMFloatTypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMFloatTypeInContext';
{$ENDIF}

(*
 * Obtain a 64-bit floating point type from a context.
 *)
  //LLVMTypeRef LLVMDoubleTypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDoubleTypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMDoubleTypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMDoubleTypeInContext';
{$ENDIF}

(*
 * Obtain a 80-bit floating point type (X87) from a context.
 *)
  //LLVMTypeRef LLVMX86FP80TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMX86FP80TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMX86FP80TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMX86FP80TypeInContext';
{$ENDIF}

(*
 * Obtain a 128-bit floating point type (112-bit mantissa) from a
 * context.
 *)
  //LLVMTypeRef LLVMFP128TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFP128TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMFP128TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMFP128TypeInContext';
{$ENDIF}

(*
 * Obtain a 128-bit floating point type (two 64-bits) from a context.
 *)
  //LLVMTypeRef LLVMPPCFP128TypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPPCFP128TypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMPPCFP128TypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMPPCFP128TypeInContext';
{$ENDIF}

(*
 * Obtain a floating point type from the global context.
 *
 * These map to the functions in this group of the same name.
 *)
  //LLVMTypeRef LLVMHalfType(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMHalfType = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMHalfType(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMHalfType';
{$ENDIF}
  //LLVMTypeRef LLVMFloatType(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFloatType = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMFloatType(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMFloatType';
{$ENDIF}
  //LLVMTypeRef LLVMDoubleType(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDoubleType = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMDoubleType(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMDoubleType';
{$ENDIF}
  //LLVMTypeRef LLVMX86FP80Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMX86FP80Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMX86FP80Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMX86FP80Type';
{$ENDIF}
  //LLVMTypeRef LLVMFP128Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFP128Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMFP128Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMFP128Type';
{$ENDIF}
  //LLVMTypeRef LLVMPPCFP128Type(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPPCFP128Type = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMPPCFP128Type(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMPPCFP128Type';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreTypeFunction Function Types
 *
 * @{
 *)

(*
 * Obtain a function type consisting of a specified signature.
 *
 * The function is defined as a tuple of a return Type, a list of
 * parameter types, and whether the function is variadic.
 *)
  //LLVMTypeRef LLVMFunctionType(LLVMTypeRef ReturnType,
  //                           LLVMTypeRef *ParamTypes, unsigned ParamCount,
  //                           LLVMBool IsVarArg);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFunctionType = function(ReturnType: LLVMTypeRef; {var} ParamTypes: Pointer{LLVMTypeRef}; ParamCount: Cardinal; IsVarArg: LLVMBool): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMFunctionType(ReturnType: LLVMTypeRef; {var} ParamTypes: Pointer{LLVMTypeRef}; ParamCount: Cardinal; IsVarArg: LLVMBool): LLVMTypeRef; cdecl;  external LLVMLibrary name 'LLVMFunctionType';
{$ENDIF}

(*
 * Returns whether a function type is variadic.
 *)
  //LLVMBool LLVMIsFunctionVarArg(LLVMTypeRef FunctionTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsFunctionVarArg = function(FunctionTy: LLVMTypeRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsFunctionVarArg(FunctionTy: LLVMTypeRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsFunctionVarArg';
{$ENDIF}

(*
 * Obtain the Type this function Type returns.
 *)
  //LLVMTypeRef LLVMGetReturnType(LLVMTypeRef FunctionTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetReturnType = function(FunctionTy: LLVMTypeRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMGetReturnType(FunctionTy: LLVMTypeRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMGetReturnType';
{$ENDIF}

(*
 * Obtain the number of parameters this function accepts.
 *)
  //unsigned LLVMCountParamTypes(LLVMTypeRef FunctionTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCountParamTypes = function(FunctionTy: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMCountParamTypes(FunctionTy: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMCountParamTypes';
{$ENDIF}

(*
 * Obtain the types of a function's parameters.
 *
 * The Dest parameter should point to a pre-allocated array of
 * LLVMTypeRef at least LLVMCountParamTypes() large. On return, the
 * first LLVMCountParamTypes() entries in the array will be populated
 * with LLVMTypeRef instances.
 *
 * @param FunctionTy The function type to operate on.
 * @param Dest Memory address of an array to be filled with result.
 *)
  //void LLVMGetParamTypes(LLVMTypeRef FunctionTy, LLVMTypeRef *Dest);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetParamTypes = procedure(FunctionTy: LLVMTypeRef; var Dest: LLVMTypeRef); cdecl;
{$ELSE}
  procedure LLVMGetParamTypes(FunctionTy: LLVMTypeRef; var Dest: LLVMTypeRef); cdecl; external LLVMLibrary name 'LLVMGetParamTypes';
{$ENDIF}
  
(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreTypeStruct Structure Types
 *
 * These functions relate to LLVMTypeRef instances.
 *
 * @see llvm::StructType
 *
 * @{
 *)

(*
 * Create a new structure type in a context.
 *
 * A structure is specified by a list of inner elements/types and
 * whether these can be packed together.
 *
 * @see llvm::StructType::create()
 *)
  //LLVMTypeRef LLVMStructTypeInContext(LLVMContextRef C, LLVMTypeRef *ElementTypes,
  //                                  unsigned ElementCount, LLVMBool Packed);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMStructTypeInContext = function(C: LLVMContextRef; {var} ElementTypes: Pointer{LLVMTypeRef}; ElementCount: Cardinal; _Packed: LLVMBool): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMStructTypeInContext(C: LLVMContextRef; {var} ElementTypes: Pointer{LLVMTypeRef}; ElementCount: Cardinal; _Packed: LLVMBool): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMStructTypeInContext';
{$ENDIF}
  
(*
 * Create a new structure type in the global context.
 *
 * @see llvm::StructType::create()
 *)
  //LLVMTypeRef LLVMStructType(LLVMTypeRef *ElementTypes, unsigned ElementCount,
  //                         LLVMBool Packed);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMStructType = function({var} ElementTypes: Pointer{LLVMTypeRef}; ElementCount: Cardinal; _Packed: LLVMBool): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMStructType({var} ElementTypes: Pointer{LLVMTypeRef}; ElementCount: Cardinal; _Packed: LLVMBool): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMStructType';
{$ENDIF}

(*
 * Create an empty structure in a context having a specified name.
 *
 * @see llvm::StructType::create()
 *)
  //LLVMTypeRef LLVMStructCreateNamed(LLVMContextRef C, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMStructCreateNamed = function(C: LLVMContextRef; Name: PAnsiChar): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMStructCreateNamed(C: LLVMContextRef; Name: PAnsiChar): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMStructCreateNamed';
{$ENDIF}

(*
 * Obtain the name of a structure.
 *
 * @see llvm::StructType::getName()
 *)
  //const char *LLVMGetStructName(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetStructName = function(Ty: LLVMTypeRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetStructName(Ty: LLVMTypeRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetStructName';
{$ENDIF}

(*
 * Set the contents of a structure type.
 *
 * @see llvm::StructType::setBody()
 *)
  //void LLVMStructSetBody(LLVMTypeRef StructTy, LLVMTypeRef *ElementTypes,
  //                     unsigned ElementCount, LLVMBool Packed);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMStructSetBody = procedure(StructTy: LLVMTypeRef; {var} ElementTypes: Pointer{LLVMTypeRef}; ElementCount: Cardinal; _Packed: LLVMBool); cdecl;
{$ELSE}
  procedure LLVMStructSetBody(StructTy: LLVMTypeRef; {var} ElementTypes: Pointer{LLVMTypeRef}; ElementCount: Cardinal; _Packed: LLVMBool); cdecl; external LLVMLibrary name 'LLVMStructSetBody';
{$ENDIF}

(*
 * Get the number of elements defined inside the structure.
 *
 * @see llvm::StructType::getNumElements()
 *)
  //unsigned LLVMCountStructElementTypes(LLVMTypeRef StructTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCountStructElementTypes = function(StructTy: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMCountStructElementTypes(StructTy: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMCountStructElementTypes';
{$ENDIF}

(*
 * Get the elements within a structure.
 *
 * The function is passed the address of a pre-allocated array of
 * LLVMTypeRef at least LLVMCountStructElementTypes() long. After
 * invocation, this array will be populated with the structure's
 * elements. The objects in the destination array will have a lifetime
 * of the structure type itself, which is the lifetime of the context it
 * is contained in.
 *)
  //void LLVMGetStructElementTypes(LLVMTypeRef StructTy, LLVMTypeRef *Dest);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetStructElementTypes = procedure(StructTy: LLVMTypeRef; var Dest: LLVMTypeRef); cdecl;
{$ELSE}
  procedure LLVMGetStructElementTypes(StructTy: LLVMTypeRef; var Dest: LLVMTypeRef); cdecl; external LLVMLibrary name 'LLVMGetStructElementTypes';
{$ENDIF}

(*
 * Determine whether a structure is packed.
 *
 * @see llvm::StructType::isPacked()
 *)
  //LLVMBool LLVMIsPackedStruct(LLVMTypeRef StructTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsPackedStruct = function(StructTy: LLVMTypeRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsPackedStruct(StructTy: LLVMTypeRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsPackedStruct';
{$ENDIF}

(*
 * Determine whether a structure is opaque.
 *
 * @see llvm::StructType::isOpaque()
 *)
  //LLVMBool LLVMIsOpaqueStruct(LLVMTypeRef StructTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsOpaqueStruct = function(StructTy: LLVMTypeRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsOpaqueStruct(StructTy: LLVMTypeRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsOpaqueStruct';
{$ENDIF}

(*
 * @}
 *)


(*
 * @defgroup LLVMCCoreTypeSequential Sequential Types
 *
 * Sequential types represents "arrays" of types. This is a super class
 * for array, vector, and pointer types.
 *
 * @{
 *)

(*
 * Obtain the type of elements within a sequential type.
 *
 * This works on array, vector, and pointer types.
 *
 * @see llvm::SequentialType::getElementType()
 *)
  //LLVMTypeRef LLVMGetElementType(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetElementType = function(Ty: LLVMTypeRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMGetElementType(Ty: LLVMTypeRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMGetElementType';
{$ENDIF}

(*
 * Create a fixed size array type that refers to a specific type.
 *
 * The created type will exist in the context that its element type
 * exists in.
 *
 * @see llvm::ArrayType::get()
 *)
  //LLVMTypeRef LLVMArrayType(LLVMTypeRef ElementType, unsigned ElementCount);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMArrayType = function(ElementType: LLVMTypeRef; ElementCount: Cardinal): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMArrayType(ElementType: LLVMTypeRef; ElementCount: Cardinal): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMArrayType';
{$ENDIF}

(*
 * Obtain the length of an array type.
 *
 * This only works on types that represent arrays.
 *
 * @see llvm::ArrayType::getNumElements()
 *)
  //unsigned LLVMGetArrayLength(LLVMTypeRef ArrayTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetArrayLength = function(ArrayTy: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetArrayLength(ArrayTy: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetArrayLength';
{$ENDIF}

(*
 * Create a pointer type that points to a defined type.
 *
 * The created type will exist in the context that its pointee type
 * exists in.
 *
 * @see llvm::PointerType::get()
 *)
  //LLVMTypeRef LLVMPointerType(LLVMTypeRef ElementType, unsigned AddressSpace);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPointerType = function(ElementType: LLVMTypeRef; AddressSpace: Cardinal): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMPointerType(ElementType: LLVMTypeRef; AddressSpace: Cardinal): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMPointerType';
{$ENDIF}

(*
 * Obtain the address space of a pointer type.
 *
 * This only works on types that represent pointers.
 *
 * @see llvm::PointerType::getAddressSpace()
 *)
  //unsigned LLVMGetPointerAddressSpace(LLVMTypeRef PointerTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPointerAddressSpace = function(PointerTy: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetPointerAddressSpace(PointerTy: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetPointerAddressSpace';
{$ENDIF}

(*
 * Create a vector type that contains a defined type and has a specific
 * number of elements.
 *
 * The created type will exist in the context thats its element type
 * exists in.
 *
 * @see llvm::VectorType::get()
 *)
  //LLVMTypeRef LLVMVectorType(LLVMTypeRef ElementType, unsigned ElementCount);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMVectorType = function(ElementType: LLVMTypeRef; ElementCount: Cardinal): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMVectorType(ElementType: LLVMTypeRef; ElementCount: Cardinal): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMVectorType';
{$ENDIF}

(*
 * Obtain the number of elements in a vector type.
 *
 * This only works on types that represent vectors.
 *
 * @see llvm::VectorType::getNumElements()
 *)
  //unsigned LLVMGetVectorSize(LLVMTypeRef VectorTy);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetVectorSize = function(VectorTy: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetVectorSize(VectorTy: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetVectorSize';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreTypeOther Other Types
 *
 * @{
 *)

(*
 * Create a void type in a context.
 *)
  //LLVMTypeRef LLVMVoidTypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMVoidTypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMVoidTypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMVoidTypeInContext';
{$ENDIF}

(*
 * Create a label type in a context.
 *)
  //LLVMTypeRef LLVMLabelTypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMLabelTypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMLabelTypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMLabelTypeInContext';
{$ENDIF}

(*
 * Create a X86 MMX type in a context.
 *)
  //LLVMTypeRef LLVMX86MMXTypeInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMX86MMXTypeInContext = function(C: LLVMContextRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMX86MMXTypeInContext(C: LLVMContextRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMX86MMXTypeInContext';
{$ENDIF}

(*
 * These are similar to the above functions except they operate on the
 * global context.
 *)
  //LLVMTypeRef LLVMVoidType(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMVoidType = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMVoidType(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMVoidType';
{$ENDIF}
  //LLVMTypeRef LLVMLabelType(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMLabelType = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMLabelType(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMLabelType';
{$ENDIF}
  //LLVMTypeRef LLVMX86MMXType(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMX86MMXType = function(): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMX86MMXType(): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMX86MMXType';
{$ENDIF}

(*
 * @}
 *)

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValues Values
 *
 * The bulk of LLVM's object model consists of values, which comprise a very
 * rich type hierarchy.
 *
 * LLVMValueRef essentially represents llvm::Value. There is a rich
 * hierarchy of classes within this type. Depending on the instance
 * obtain, not all APIs are available.
 *
 * Callers can determine the type of a LLVMValueRef by calling the
 * LLVMIsA* family of functions (e.g. LLVMIsAArgument()). These
 * functions are defined by a macro, so it isn't obvious which are
 * available by looking at the Doxygen source code. Instead, look at the
 * source definition of LLVM_FOR_EACH_VALUE_SUBCLASS and note the list
 * of value names given. These value names also correspond to classes in
 * the llvm::Value hierarchy.
 *
 * @{
 *)

(*
#define LLVM_FOR_EACH_VALUE_SUBCLASS(macro) \
  macro(Argument)                           \
  macro(BasicBlock)                         \
  macro(InlineAsm)                          \
  macro(MDNode)                             \
  macro(MDString)                           \
  macro(User)                               \
    macro(Constant)                         \
      macro(BlockAddress)                   \
      macro(ConstantAggregateZero)          \
      macro(ConstantArray)                  \
      macro(ConstantExpr)                   \
      macro(ConstantFP)                     \
      macro(ConstantInt)                    \
      macro(ConstantPointerNull)            \
      macro(ConstantStruct)                 \
      macro(ConstantVector)                 \
      macro(GlobalValue)                    \
        macro(Function)                     \
        macro(GlobalAlias)                  \
        macro(GlobalVariable)               \
      macro(UndefValue)                     \
    macro(Instruction)                      \
      macro(BinaryOperator)                 \
      macro(CallInst)                       \
        macro(IntrinsicInst)                \
          macro(DbgInfoIntrinsic)           \
            macro(DbgDeclareInst)           \
          macro(MemIntrinsic)               \
            macro(MemCpyInst)               \
            macro(MemMoveInst)              \
            macro(MemSetInst)               \
      macro(CmpInst)                        \
        macro(FCmpInst)                     \
        macro(ICmpInst)                     \
      macro(ExtractElementInst)             \
      macro(GetElementPtrInst)              \
      macro(InsertElementInst)              \
      macro(InsertValueInst)                \
      macro(LandingPadInst)                 \
      macro(PHINode)                        \
      macro(SelectInst)                     \
      macro(ShuffleVectorInst)              \
      macro(StoreInst)                      \
      macro(TerminatorInst)                 \
        macro(BranchInst)                   \
        macro(IndirectBrInst)               \
        macro(InvokeInst)                   \
        macro(ReturnInst)                   \
        macro(SwitchInst)                   \
        macro(UnreachableInst)              \
        macro(ResumeInst)                   \
    macro(UnaryInstruction)                 \
      macro(AllocaInst)                     \
      macro(CastInst)                       \
        macro(BitCastInst)                  \
        macro(FPExtInst)                    \
        macro(FPToSIInst)                   \
        macro(FPToUIInst)                   \
        macro(FPTruncInst)                  \
        macro(IntToPtrInst)                 \
        macro(PtrToIntInst)                 \
        macro(SExtInst)                     \
        macro(SIToFPInst)                   \
        macro(TruncInst)                    \
        macro(UIToFPInst)                   \
        macro(ZExtInst)                     \
      macro(ExtractValueInst)               \
      macro(LoadInst)                       \
      macro(VAArgInst)
*)

(*
 * @defgroup LLVMCCoreValueGeneral General APIs
 *
 * Functions in this section work on all LLVMValueRef instances,
 * regardless of their sub-type. They correspond to functions available
 * on llvm::Value.
 *
 * @{
 *)

(*
 * Obtain the type of a value.
 *
 * @see llvm::Value::getType()
 *)
  //LLVMTypeRef LLVMTypeOf(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMTypeOf = function(Val: LLVMValueRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMTypeOf(Val: LLVMValueRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMTypeOf';
{$ENDIF}

(*
 * Obtain the string name of a value.
 *
 * @see llvm::Value::getName()
 *)
  //const char *LLVMGetValueName(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetValueName = function(Val: LLVMValueRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetValueName(Val: LLVMValueRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetValueName';
{$ENDIF}

(*
 * Set the string name of a value.
 *
 * @see llvm::Value::setName()
 *)
  //void LLVMSetValueName(LLVMValueRef Val, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetValueName = procedure(Val: LLVMValueRef; Name: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMSetValueName(Val: LLVMValueRef; Name: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMSetValueName';
{$ENDIF}

(*
 * Dump a representation of a value to stderr.
 *
 * @see llvm::Value::dump()
 *)
  //void LLVMDumpValue(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDumpValue = procedure(Val: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMDumpValue(Val: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMDumpValue';
{$ENDIF}

(*
 * Replace all uses of a value with another one.
 *
 * @see llvm::Value::replaceAllUsesWith()
 *)
  //void LLVMReplaceAllUsesWith(LLVMValueRef OldVal, LLVMValueRef NewVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMReplaceAllUsesWith = procedure(OldVal: LLVMValueRef; NewVal: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMReplaceAllUsesWith(OldVal: LLVMValueRef; NewVal: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMReplaceAllUsesWith';
{$ENDIF}

(*
 * Determine whether the specified constant instance is constant.
 *)
  //LLVMBool LLVMIsConstant(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsConstant = function(Val: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsConstant(Val: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsConstant';
{$ENDIF}

(*
 * Determine whether a value instance is undefined.
 *)
  //LLVMBool LLVMIsUndef(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsUndef = function(Val: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsUndef(Val: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsUndef';
{$ENDIF}

(*
 * Convert value instances between types.
 *
 * Internally, a LLVMValueRef is "pinned" to a specific type. This
 * series of functions allows you to cast an instance to a specific
 * type.
 *
 * If the cast is not valid for the specified type, NULL is returned.
 *
 * @see llvm::dyn_cast_or_null<>
 *)
  //#define LLVM_DECLARE_VALUE_CAST(name) \
  //  LLVMValueRef LLVMIsA##name(LLVMValueRef Val);
  //LLVM_FOR_EACH_VALUE_SUBCLASS(LLVM_DECLARE_VALUE_CAST)
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAArgument = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsAArgument(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAArgument';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsABasicBlock = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsABasicBlock(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsABasicBlock';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAInlineAsm = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsAInlineAsm(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAInlineAsm';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAMDNode = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsAMDNode(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAMDNode';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAMDString = function(Val: LLVMValueRef): LLVMValueRef; cdecl;  
{$ELSE}
  function LLVMIsAMDString(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAMDString';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAUser = function(Val: LLVMValueRef): LLVMValueRef; cdecl;      
{$ELSE}
  function LLVMIsAUser(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAUser';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstant = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsAConstant(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAConstant';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsABlockAddress = function(Val: LLVMValueRef): LLVMValueRef; cdecl; 
{$ELSE}
  function LLVMIsABlockAddress(Val: LLVMValueRef): LLVMValueRef; cdecl;  external LLVMLibrary name 'LLVMIsABlockAddress';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantAggregateZero = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsAConstantAggregateZero(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAConstantAggregateZero';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantArray = function(Val: LLVMValueRef): LLVMValueRef; cdecl;        
{$ELSE}
  function LLVMIsAConstantArray(Val: LLVMValueRef): LLVMValueRef; cdecl;         external LLVMLibrary name 'LLVMIsAConstantArray';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantExpr = function(Val: LLVMValueRef): LLVMValueRef; cdecl;         
{$ELSE}
  function LLVMIsAConstantExpr(Val: LLVMValueRef): LLVMValueRef; cdecl;          external LLVMLibrary name 'LLVMIsAConstantExpr';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantFP = function(Val: LLVMValueRef): LLVMValueRef; cdecl;           
{$ELSE}
  function LLVMIsAConstantFP(Val: LLVMValueRef): LLVMValueRef; cdecl;            external LLVMLibrary name 'LLVMIsAConstantFP';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantInt = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                    
{$ELSE}
  function LLVMIsAConstantInt(Val: LLVMValueRef): LLVMValueRef; cdecl;                     external LLVMLibrary name 'LLVMIsAConstantInt';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantPointerNull = function(Val: LLVMValueRef): LLVMValueRef; cdecl;            
{$ELSE}
  function LLVMIsAConstantPointerNull(Val: LLVMValueRef): LLVMValueRef; cdecl;             external LLVMLibrary name 'LLVMIsAConstantPointerNull';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantStruct = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsAConstantStruct(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsAConstantStruct';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAConstantVector = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsAConstantVector(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsAConstantVector';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAGlobalValue = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                    
{$ELSE}
  function LLVMIsAGlobalValue(Val: LLVMValueRef): LLVMValueRef; cdecl;                     external LLVMLibrary name 'LLVMIsAGlobalValue';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAFunction = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsAFunction(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsAFunction';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAGlobalAlias = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsAGlobalAlias(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsAGlobalAlias';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAGlobalVariable = function(Val: LLVMValueRef): LLVMValueRef; cdecl;               
{$ELSE}
  function LLVMIsAGlobalVariable(Val: LLVMValueRef): LLVMValueRef; cdecl;                external LLVMLibrary name 'LLVMIsAGlobalVariable';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAUndefValue = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsAUndefValue(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsAUndefValue';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAInstruction = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                      
{$ELSE}
  function LLVMIsAInstruction(Val: LLVMValueRef): LLVMValueRef; cdecl;                       external LLVMLibrary name 'LLVMIsAInstruction';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsABinaryOperator = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsABinaryOperator(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsABinaryOperator';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsACallInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                       
{$ELSE}
  function LLVMIsACallInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                        external LLVMLibrary name 'LLVMIsACallInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAIntrinsicInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                
{$ELSE}
  function LLVMIsAIntrinsicInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                 external LLVMLibrary name 'LLVMIsAIntrinsicInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsADbgInfoIntrinsic = function(Val: LLVMValueRef): LLVMValueRef; cdecl;           
{$ELSE}
  function LLVMIsADbgInfoIntrinsic(Val: LLVMValueRef): LLVMValueRef; cdecl;            external LLVMLibrary name 'LLVMIsADbgInfoIntrinsic';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsADbgDeclareInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;           
{$ELSE}
  function LLVMIsADbgDeclareInst(Val: LLVMValueRef): LLVMValueRef; cdecl;            external LLVMLibrary name 'LLVMIsADbgDeclareInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAMemIntrinsic = function(Val: LLVMValueRef): LLVMValueRef; cdecl;               
{$ELSE}
  function LLVMIsAMemIntrinsic(Val: LLVMValueRef): LLVMValueRef; cdecl;                external LLVMLibrary name 'LLVMIsAMemIntrinsic';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAMemCpyInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;               
{$ELSE}
  function LLVMIsAMemCpyInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                external LLVMLibrary name 'LLVMIsAMemCpyInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAMemMoveInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;             
{$ELSE}
  function LLVMIsAMemMoveInst(Val: LLVMValueRef): LLVMValueRef; cdecl;              external LLVMLibrary name 'LLVMIsAMemMoveInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAMemSetInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;               
{$ELSE}
  function LLVMIsAMemSetInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                external LLVMLibrary name 'LLVMIsAMemSetInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsACmpInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                        
{$ELSE}
  function LLVMIsACmpInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                         external LLVMLibrary name 'LLVMIsACmpInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAFCmpInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsAFCmpInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsAFCmpInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAICmpInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsAICmpInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsAICmpInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAExtractElementInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;             
{$ELSE}
  function LLVMIsAExtractElementInst(Val: LLVMValueRef): LLVMValueRef; cdecl;              external LLVMLibrary name 'LLVMIsAExtractElementInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAGetElementPtrInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;              
{$ELSE}
  function LLVMIsAGetElementPtrInst(Val: LLVMValueRef): LLVMValueRef; cdecl;               external LLVMLibrary name 'LLVMIsAGetElementPtrInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAInsertElementInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;              
{$ELSE}
  function LLVMIsAInsertElementInst(Val: LLVMValueRef): LLVMValueRef; cdecl;               external LLVMLibrary name 'LLVMIsAInsertElementInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAInsertValueInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                
{$ELSE}
  function LLVMIsAInsertValueInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                 external LLVMLibrary name 'LLVMIsAInsertValueInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsALandingPadInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsALandingPadInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsALandingPadInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAPHINode = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                        
{$ELSE}
  function LLVMIsAPHINode(Val: LLVMValueRef): LLVMValueRef; cdecl;                         external LLVMLibrary name 'LLVMIsAPHINode';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsASelectInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsASelectInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsASelectInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAShuffleVectorInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;              
{$ELSE}
  function LLVMIsAShuffleVectorInst(Val: LLVMValueRef): LLVMValueRef; cdecl;               external LLVMLibrary name 'LLVMIsAShuffleVectorInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAStoreInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                      
{$ELSE}
  function LLVMIsAStoreInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                       external LLVMLibrary name 'LLVMIsAStoreInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsATerminatorInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsATerminatorInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsATerminatorInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsABranchInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsABranchInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsABranchInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAIndirectBrInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;               
{$ELSE}
  function LLVMIsAIndirectBrInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                external LLVMLibrary name 'LLVMIsAIndirectBrInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAInvokeInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsAInvokeInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsAInvokeInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAReturnInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsAReturnInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsAReturnInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsASwitchInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsASwitchInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsASwitchInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAUnreachableInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;              
{$ELSE}
  function LLVMIsAUnreachableInst(Val: LLVMValueRef): LLVMValueRef; cdecl;               external LLVMLibrary name 'LLVMIsAUnreachableInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAResumeInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsAResumeInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsAResumeInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAUnaryInstruction = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsAUnaryInstruction(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsAUnaryInstruction';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAAllocaInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsAAllocaInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsAAllocaInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsACastInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                       
{$ELSE}
  function LLVMIsACastInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                        external LLVMLibrary name 'LLVMIsACastInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsABitCastInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                  
{$ELSE}
  function LLVMIsABitCastInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                   external LLVMLibrary name 'LLVMIsABitCastInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAFPExtInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                    
{$ELSE}
  function LLVMIsAFPExtInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                     external LLVMLibrary name 'LLVMIsAFPExtInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAFPToSIInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsAFPToSIInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsAFPToSIInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAFPToUIInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsAFPToUIInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsAFPToUIInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAFPTruncInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                  
{$ELSE}
  function LLVMIsAFPTruncInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                   external LLVMLibrary name 'LLVMIsAFPTruncInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAIntToPtrInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsAIntToPtrInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsAIntToPtrInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAPtrToIntInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                 
{$ELSE}
  function LLVMIsAPtrToIntInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                  external LLVMLibrary name 'LLVMIsAPtrToIntInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsASExtInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsASExtInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsASExtInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsASIToFPInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsASIToFPInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsASIToFPInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsATruncInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                    
{$ELSE}
  function LLVMIsATruncInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                     external LLVMLibrary name 'LLVMIsATruncInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAUIToFPInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                   
{$ELSE}
  function LLVMIsAUIToFPInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                    external LLVMLibrary name 'LLVMIsAUIToFPInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAZExtInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                     
{$ELSE}
  function LLVMIsAZExtInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                      external LLVMLibrary name 'LLVMIsAZExtInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAExtractValueInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;               
{$ELSE}
  function LLVMIsAExtractValueInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                external LLVMLibrary name 'LLVMIsAExtractValueInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsALoadInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;                       
{$ELSE}
  function LLVMIsALoadInst(Val: LLVMValueRef): LLVMValueRef; cdecl;                        external LLVMLibrary name 'LLVMIsALoadInst';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsAVAArgInst = function(Val: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMIsAVAArgInst(Val: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMIsAVAArgInst';
{$ENDIF}
  
(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueUses Usage
 *
 * This module defines functions that allow you to inspect the uses of a
 * LLVMValueRef.
 *
 * It is possible to obtain a LLVMUseRef for any LLVMValueRef instance.
 * Each LLVMUseRef (which corresponds to a llvm::Use instance) holds a
 * llvm::User and llvm::Value.
 *
 * @{
 *)

(*
 * Obtain the first use of a value.
 *
 * Uses are obtained in an iterator fashion. First, call this function
 * to obtain a reference to the first use. Then, call LLVMGetNextUse()
 * on that instance and all subsequently obtained instances untl
 * LLVMGetNextUse() returns NULL.
 *
 * @see llvm::Value::use_begin()
 *)
  //LLVMUseRef LLVMGetFirstUse(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstUse = function(Val: LLVMValueRef): LLVMUseRef; cdecl;
{$ELSE}
  function LLVMGetFirstUse(Val: LLVMValueRef): LLVMUseRef; cdecl; external LLVMLibrary name 'LLVMGetFirstUse';
{$ENDIF}

(*
 * Obtain the next use of a value.
 *
 * This effectively advances the iterator. It returns NULL if you are on
 * the final use and no more are available.
 *)
  //LLVMUseRef LLVMGetNextUse(LLVMUseRef U);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextUse = function(U: LLVMUseRef): LLVMUseRef; cdecl;
{$ELSE}
  function LLVMGetNextUse(U: LLVMUseRef): LLVMUseRef; cdecl; external LLVMLibrary name 'LLVMGetNextUse';
{$ENDIF}

(*
 * Obtain the user value for a user.
 *
 * The returned value corresponds to a llvm::User type.
 *
 * @see llvm::Use::getUser()
 *)
  //LLVMValueRef LLVMGetUser(LLVMUseRef U);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetUser = function(U: LLVMUseRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetUser(U: LLVMUseRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetUser';
{$ENDIF}

(*
 * Obtain the value this use corresponds to.
 *
 * @see llvm::Use::get().
 *)
  //LLVMValueRef LLVMGetUsedValue(LLVMUseRef U);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetUsedValue = function(U: LLVMUseRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetUsedValue(U: LLVMUseRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetUsedValue';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueUser User value
 *
 * Function in this group pertain to LLVMValueRef instances that descent
 * from llvm::User. This includes constants, instructions, and
 * operators.
 *
 * @{
 *)

(*
 * Obtain an operand at a specific index in a llvm::User value.
 *
 * @see llvm::User::getOperand()
 *)
  //LLVMValueRef LLVMGetOperand(LLVMValueRef Val, unsigned Index);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetOperand = function(Val: LLVMValueRef; Index: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetOperand(Val: LLVMValueRef; Index: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetOperand';
{$ENDIF}

(*
 * Set an operand at a specific index in a llvm::User value.
 *
 * @see llvm::User::setOperand()
 *)
  //void LLVMSetOperand(LLVMValueRef User, unsigned Index, LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetOperand = procedure(User: LLVMValueRef; Index: Cardinal; Val: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMSetOperand(User: LLVMValueRef; Index: Cardinal; Val: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMSetOperand';
{$ENDIF}

(*
 * Obtain the number of operands in a llvm::User value.
 *
 * @see llvm::User::getNumOperands()
 *)
  //int LLVMGetNumOperands(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNumOperands = function(Val: LLVMValueRef): Integer; cdecl;
{$ELSE}
  function LLVMGetNumOperands(Val: LLVMValueRef): Integer; cdecl; external LLVMLibrary name 'LLVMGetNumOperands';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueConstant Constants
 *
 * This section contains APIs for interacting with LLVMValueRef that
 * correspond to llvm::Constant instances.
 *
 * These functions will work for any LLVMValueRef in the llvm::Constant
 * class hierarchy.
 *
 * @{
 *)

(*
 * Obtain a constant value referring to the null instance of a type.
 *
 * @see llvm::Constant::getNullValue()
 *)
  //LLVMValueRef LLVMConstNull(LLVMTypeRef Ty); (* all zeroes *)
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNull = function(Ty: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNull(Ty: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNull';
{$ENDIF}

(*
 * Obtain a constant value referring to the instance of a type
 * consisting of all ones.
 *
 * This is only valid for integer types.
 *
 * @see llvm::Constant::getAllOnesValue()
 *)
  //LLVMValueRef LLVMConstAllOnes(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstAllOnes = function(Ty: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstAllOnes(Ty: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstAllOnes';
{$ENDIF}

(*
 * Obtain a constant value referring to an undefined value of a type.
 *
 * @see llvm::UndefValue::get()
 *)
  //LLVMValueRef LLVMGetUndef(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetUndef = function(Ty: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetUndef(Ty: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetUndef';
{$ENDIF}

(*
 * Determine whether a value instance is null.
 *
 * @see llvm::Constant::isNullValue()
 *)
  //LLVMBool LLVMIsNull(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsNull = function(Val: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsNull(Val: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsNull';
{$ENDIF}

(*
 * Obtain a constant that is a constant pointer pointing to NULL for a
 * specified type.
 *)
  //LLVMValueRef LLVMConstPointerNull(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstPointerNull = function(Ty: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstPointerNull(Ty: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstPointerNull';
{$ENDIF}

(*
 * @defgroup LLVMCCoreValueConstantScalar Scalar constants
 *
 * Functions in this group model LLVMValueRef instances that correspond
 * to constants referring to scalar types.
 *
 * For integer types, the LLVMTypeRef parameter should correspond to a
 * llvm::IntegerType instance and the returned LLVMValueRef will
 * correspond to a llvm::ConstantInt.
 *
 * For floating point types, the LLVMTypeRef returned corresponds to a
 * llvm::ConstantFP.
 *
 * @{
 *)

(*
 * Obtain a constant value for an integer type.
 *
 * The returned value corresponds to a llvm::ConstantInt.
 *
 * @see llvm::ConstantInt::get()
 *
 * @param IntTy Integer type to obtain value of.
 * @param N The value the returned instance should refer to.
 * @param SignExtend Whether to sign extend the produced value.
 *)
  //LLVMValueRef LLVMConstInt(LLVMTypeRef IntTy, unsigned long long N,
  //                        LLVMBool SignExtend);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstInt = function(IntTy: LLVMTypeRef; N: UInt64; SignExtend: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstInt(IntTy: LLVMTypeRef; N: UInt64; SignExtend: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstInt';
{$ENDIF}

(*
 * Obtain a constant value for an integer of arbitrary precision.
 *
 * @see llvm::ConstantInt::get()
 *)
  //LLVMValueRef LLVMConstIntOfArbitraryPrecision(LLVMTypeRef IntTy,
  //                                            unsigned NumWords,
  //                                            const uint64_t Words[]);
  // #WARNING
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntOfArbitraryPrecision = function(IntTy: LLVMTypeRef; NumWords: Cardinal; Words: puint64_t): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstIntOfArbitraryPrecision(IntTy: LLVMTypeRef; NumWords: Cardinal; Words: puint64_t): LLVMValueRef; cdecl; external LLVMLibrary name 'TLLVMConstIntOfArbitraryPrecision';
{$ENDIF}

(*
 * Obtain a constant value for an integer parsed from a string.
 *
 * A similar API, LLVMConstIntOfStringAndSize is also available. If the
 * string's length is available, it is preferred to call that function
 * instead.
 *
 * @see llvm::ConstantInt::get()
 *)
  //LLVMValueRef LLVMConstIntOfString(LLVMTypeRef IntTy, const char *Text,
  //                                uint8_t Radix);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntOfString = function(IntTy: LLVMTypeRef; Text: PAnsiChar; Radix: uint8_t): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstIntOfString(IntTy: LLVMTypeRef; Text: PAnsiChar; Radix: uint8_t): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstIntOfString';
{$ENDIF}

(*
 * Obtain a constant value for an integer parsed from a string with
 * specified length.
 *
 * @see llvm::ConstantInt::get()
 *)
  //LLVMValueRef LLVMConstIntOfStringAndSize(LLVMTypeRef IntTy, const char *Text,
  //                                       unsigned SLen, uint8_t Radix);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntOfStringAndSize = function(IntTy: LLVMTypeRef; Text: PAnsiChar; SLen: Cardinal; Radix: uint8_t): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstIntOfStringAndSize(IntTy: LLVMTypeRef; Text: PAnsiChar; SLen: Cardinal; Radix: uint8_t): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstIntOfStringAndSize';
{$ENDIF}

(*
 * Obtain a constant value referring to a double floating point value.
 *)
  //LLVMValueRef LLVMConstReal(LLVMTypeRef RealTy, double N);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstReal = function(RealTy: LLVMTypeRef; N: Double): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstReal(RealTy: LLVMTypeRef; N: Double): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstReal';
{$ENDIF}

(*
 * Obtain a constant for a floating point value parsed from a string.
 *
 * A similar API, LLVMConstRealOfStringAndSize is also available. It
 * should be used if the input string's length is known.
 *)
  //LLVMValueRef LLVMConstRealOfString(LLVMTypeRef RealTy, const char *Text);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstRealOfString = function(RealTy: LLVMTypeRef; Text: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstRealOfString(RealTy: LLVMTypeRef; Text: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstRealOfString';
{$ENDIF}

(*
 * Obtain a constant for a floating point value parsed from a string.
 *)
  //LLVMValueRef LLVMConstRealOfStringAndSize(LLVMTypeRef RealTy, const char *Text,
  //                                        unsigned SLen);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstRealOfStringAndSize = function(RealTy: LLVMTypeRef; Text: PAnsiChar; SLen: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstRealOfStringAndSize(RealTy: LLVMTypeRef; Text: PAnsiChar; SLen: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstRealOfStringAndSize';
{$ENDIF}

(*
 * Obtain the zero extended value for an integer constant value.
 *
 * @see llvm::ConstantInt::getZExtValue()
 *)
  //unsigned long long LLVMConstIntGetZExtValue(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntGetZExtValue = function(ConstantVal: LLVMValueRef): UInt64; cdecl;
{$ELSE}
  function LLVMConstIntGetZExtValue(ConstantVal: LLVMValueRef): UInt64; cdecl; external LLVMLibrary name 'LLVMConstIntGetZExtValue';
{$ENDIF}

(*
 * Obtain the sign extended value for an integer constant value.
 *
 * @see llvm::ConstantInt::getSExtValue()
 *)
  //long long LLVMConstIntGetSExtValue(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntGetSExtValue = function(ConstantVal: LLVMValueRef): Int64; cdecl;
{$ELSE}
  function LLVMConstIntGetSExtValue(ConstantVal: LLVMValueRef): Int64; cdecl; external LLVMLibrary name 'LLVMConstIntGetSExtValue';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueConstantComposite Composite Constants
 *
 * Functions in this group operate on composite constants.
 *
 * @{
 *)

(*
 * Create a ConstantDataSequential and initialize it with a string.
 *
 * @see llvm::ConstantDataArray::getString()
 *)
  //LLVMValueRef LLVMConstStringInContext(LLVMContextRef C, const char *Str,
  //                                    unsigned Length, LLVMBool DontNullTerminate);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstStringInContext = function(C: LLVMContextRef; Str: PAnsiChar; Length: Cardinal; DontNullTerminate: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstStringInContext(C: LLVMContextRef; Str: PAnsiChar; Length: Cardinal; DontNullTerminate: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstStringInContext';
{$ENDIF}

(*
 * Create a ConstantDataSequential with string content in the global context.
 *
 * This is the same as LLVMConstStringInContext except it operates on the
 * global context.
 *
 * @see LLVMConstStringInContext()
 * @see llvm::ConstantDataArray::getString()
 *)
  //LLVMValueRef LLVMConstString(const char *Str, unsigned Length,
  //                           LLVMBool DontNullTerminate);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstString = function(Str: PAnsiChar; Length: Cardinal; DontNullTerminate: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstString(Str: PAnsiChar; Length: Cardinal; DontNullTerminate: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstString';
{$ENDIF}

(*
 * Create an anonymous ConstantStruct with the specified values.
 *
 * @see llvm::ConstantStruct::getAnon()
 *)
  //LLVMValueRef LLVMConstStructInContext(LLVMContextRef C,
  //                                    LLVMValueRef *ConstantVals,
  //                                    unsigned Count, LLVMBool Packed);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstStructInContext = function(C: LLVMContextRef; {var} ConstantVals: Pointer{LLVMValueRef}; Count: Cardinal; _Packed: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstStructInContext(C: LLVMContextRef; {var} ConstantVals: Pointer{LLVMValueRef}; Count: Cardinal; _Packed: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstStructInContext';
{$ENDIF}

(*
 * Create a ConstantStruct in the global Context.
 *
 * This is the same as LLVMConstStructInContext except it operates on the
 * global Context.
 *
 * @see LLVMConstStructInContext()
 *)
  //LLVMValueRef LLVMConstStruct(LLVMValueRef *ConstantVals, unsigned Count,
  //                           LLVMBool Packed);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstStruct = function({var} ConstantVals: Pointer{LLVMValueRef}; Count: Cardinal; _Packed: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstStruct({var} ConstantVals: Pointer{LLVMValueRef}; Count: Cardinal; _Packed: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstStruct';
{$ENDIF}

(*
 * Create a ConstantArray from values.
 *
 * @see llvm::ConstantArray::get()
 *)
  //LLVMValueRef LLVMConstArray(LLVMTypeRef ElementTy,
  //                          LLVMValueRef *ConstantVals, unsigned Length);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstArray = function(ElementTy: LLVMTypeRef; {var} ConstantVals: Pointer{LLVMValueRef}; Length: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstArray(ElementTy: LLVMTypeRef; {var} ConstantVals: Pointer{LLVMValueRef}; Length: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstArray';
{$ENDIF}

(*
 * Create a non-anonymous ConstantStruct from values.
 *
 * @see llvm::ConstantStruct::get()
 *)
  //LLVMValueRef LLVMConstNamedStruct(LLVMTypeRef StructTy,
  //                                LLVMValueRef *ConstantVals,
  //                                unsigned Count);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNamedStruct = function(StructTy: LLVMTypeRef; {var} ConstantVals: Pointer{LLVMValueRef}; Count: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNamedStruct(StructTy: LLVMTypeRef; {var} ConstantVals: Pointer{LLVMValueRef}; Count: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNamedStruct';
{$ENDIF}

(*
 * Create a ConstantVector from values.
 *
 * @see llvm::ConstantVector::get()
 *)
  //LLVMValueRef LLVMConstVector(LLVMValueRef *ScalarConstantVals, unsigned Size);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstVector = function({var} ScalarConstantVals: Pointer{LLVMValueRef}; Size: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstVector({var} ScalarConstantVals: Pointer{LLVMValueRef}; Size: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstVector';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueConstantExpressions Constant Expressions
 *
 * Functions in this group correspond to APIs on llvm::ConstantExpr.
 *
 * @see llvm::ConstantExpr.
 *
 * @{
 *)
  //LLVMOpcode LLVMGetConstOpcode(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetConstOpcode = function(ConstantVal: LLVMValueRef): LLVMOpcode; cdecl;
{$ELSE}
  function LLVMGetConstOpcode(ConstantVal: LLVMValueRef): LLVMOpcode; cdecl; external LLVMLibrary name 'LLVMGetConstOpcode';
{$ENDIF}
  //LLVMValueRef LLVMAlignOf(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAlignOf = function(Ty: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMAlignOf(Ty: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMAlignOf';
{$ENDIF}
  //LLVMValueRef LLVMSizeOf(LLVMTypeRef Ty);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSizeOf = function(Ty: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMSizeOf(Ty: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMSizeOf';
{$ENDIF}
  //LLVMValueRef LLVMConstNeg(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNeg = function(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNeg(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNeg';
{$ENDIF}
  //LLVMValueRef LLVMConstNSWNeg(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNSWNeg = function(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNSWNeg(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNSWNeg';
{$ENDIF}
  //LLVMValueRef LLVMConstNUWNeg(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNUWNeg = function(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNUWNeg(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNUWNeg';
{$ENDIF}
  //LLVMValueRef LLVMConstFNeg(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFNeg = function(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFNeg(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFNeg';
{$ENDIF}
  //LLVMValueRef LLVMConstNot(LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNot = function(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNot(ConstantVal: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNot';
{$ENDIF}
  //LLVMValueRef LLVMConstAdd(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstAdd = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstAdd(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstAdd';
{$ENDIF}
  //LLVMValueRef LLVMConstNSWAdd(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNSWAdd = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNSWAdd(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNSWAdd';
{$ENDIF}
  //LLVMValueRef LLVMConstNUWAdd(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNUWAdd = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNUWAdd(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNUWAdd';
{$ENDIF}
  //LLVMValueRef LLVMConstFAdd(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFAdd = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFAdd(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFAdd';
{$ENDIF}
  //LLVMValueRef LLVMConstSub(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSub = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSub(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSub';
{$ENDIF}
  //LLVMValueRef LLVMConstNSWSub(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNSWSub = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNSWSub(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNSWSub';
{$ENDIF}
  //LLVMValueRef LLVMConstNUWSub(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNUWSub = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNUWSub(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNUWSub';
{$ENDIF}
  //LLVMValueRef LLVMConstFSub(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFSub = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFSub(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFSub';
{$ENDIF}
  //LLVMValueRef LLVMConstMul(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstMul = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstMul(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstMul';
{$ENDIF}
  //LLVMValueRef LLVMConstNSWMul(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNSWMul = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNSWMul(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNSWMul';
{$ENDIF}
  //LLVMValueRef LLVMConstNUWMul(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstNUWMul = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstNUWMul(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstNUWMul';
{$ENDIF}
  //LLVMValueRef LLVMConstFMul(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFMul = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFMul(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFMul';
{$ENDIF}
  //LLVMValueRef LLVMConstUDiv(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstUDiv = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstUDiv(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstUDiv';
{$ENDIF}
  //LLVMValueRef LLVMConstSDiv(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSDiv = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSDiv(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSDiv';
{$ENDIF}
  //LLVMValueRef LLVMConstExactSDiv(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstExactSDiv = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstExactSDiv(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstExactSDiv';
{$ENDIF}
  //LLVMValueRef LLVMConstFDiv(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFDiv = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFDiv(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFDiv';
{$ENDIF}
  //LLVMValueRef LLVMConstURem(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstURem = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstURem(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstURem';
{$ENDIF}
  //LLVMValueRef LLVMConstSRem(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSRem = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSRem(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSRem';
{$ENDIF}
  //LLVMValueRef LLVMConstFRem(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFRem = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFRem(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFRem';
{$ENDIF}
  //LLVMValueRef LLVMConstAnd(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstAnd = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstAnd(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstAnd';
{$ENDIF}
  //LLVMValueRef LLVMConstOr(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstOr = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstOr(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstOr';
{$ENDIF}
  //LLVMValueRef LLVMConstXor(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstXor = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstXor(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstXor';
{$ENDIF}
  //LLVMValueRef LLVMConstICmp(LLVMIntPredicate Predicate,
  //                         LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstICmp = function(Predicate: LLVMIntPredicate; LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstICmp(Predicate: LLVMIntPredicate; LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstICmp';
{$ENDIF}
  //LLVMValueRef LLVMConstFCmp(LLVMRealPredicate Predicate,
  //                         LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFCmp = function(Predicate: LLVMIntPredicate; LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFCmp(Predicate: LLVMIntPredicate; LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFCmp';
{$ENDIF}
  //LLVMValueRef LLVMConstShl(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstShl = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstShl(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstShl';
{$ENDIF}
  //LLVMValueRef LLVMConstLShr(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstLShr = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstLShr(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstLShr';
{$ENDIF}
  //LLVMValueRef LLVMConstAShr(LLVMValueRef LHSConstant, LLVMValueRef RHSConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstAShr = function(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstAShr(LHSConstant: LLVMValueRef; RHSConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstAShr';
{$ENDIF}
  //LLVMValueRef LLVMConstGEP(LLVMValueRef ConstantVal,
  //                        LLVMValueRef *ConstantIndices, unsigned NumIndices);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstGEP = function(ConstantVal: LLVMValueRef; {var} ConstantIndices: Pointer{LLVMValueRef}; NumIndices: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstGEP(ConstantVal: LLVMValueRef; {var} ConstantIndices: Pointer{LLVMValueRef}; NumIndices: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstGEP';
{$ENDIF}
  //LLVMValueRef LLVMConstInBoundsGEP(LLVMValueRef ConstantVal,
  //                                LLVMValueRef *ConstantIndices,
  //                                unsigned NumIndices);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstInBoundsGEP = function(ConstantVal: LLVMValueRef; {var} ConstantIndices: Pointer{LLVMValueRef}; NumIndices: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstInBoundsGEP(ConstantVal: LLVMValueRef; {var} ConstantIndices: Pointer{LLVMValueRef}; NumIndices: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstInBoundsGEP';
{$ENDIF}
  //LLVMValueRef LLVMConstTrunc(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstTrunc = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstTrunc(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstTrunc';
{$ENDIF}
  //LLVMValueRef LLVMConstSExt(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSExt = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSExt(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSExt';
{$ENDIF}
  //LLVMValueRef LLVMConstZExt(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstZExt = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstZExt(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstZExt';
{$ENDIF}
  //LLVMValueRef LLVMConstFPTrunc(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFPTrunc = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFPTrunc(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFPTrunc';
{$ENDIF}
  //LLVMValueRef LLVMConstFPExt(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFPExt = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFPExt(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFPExt';
{$ENDIF}
  //LLVMValueRef LLVMConstUIToFP(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstUIToFP = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstUIToFP(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstUIToFP';
{$ENDIF}
  //LLVMValueRef LLVMConstSIToFP(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSIToFP = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSIToFP(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSIToFP';
{$ENDIF}
  //LLVMValueRef LLVMConstFPToUI(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFPToUI = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFPToUI(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFPToUI';
{$ENDIF}
  //LLVMValueRef LLVMConstFPToSI(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFPToSI = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFPToSI(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFPToSI';
{$ENDIF}
  //LLVMValueRef LLVMConstPtrToInt(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstPtrToInt = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstPtrToInt(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstPtrToInt';
{$ENDIF}
  //LLVMValueRef LLVMConstIntToPtr(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntToPtr = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstIntToPtr(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstIntToPtr';
{$ENDIF}
  //LLVMValueRef LLVMConstBitCast(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstBitCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstBitCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstBitCast';
{$ENDIF}
  //LLVMValueRef LLVMConstZExtOrBitCast(LLVMValueRef ConstantVal,
  //                                  LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstZExtOrBitCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstZExtOrBitCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstZExtOrBitCast';
{$ENDIF}
  //LLVMValueRef LLVMConstSExtOrBitCast(LLVMValueRef ConstantVal,
  //                                  LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSExtOrBitCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSExtOrBitCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSExtOrBitCast';
{$ENDIF}
  //LLVMValueRef LLVMConstTruncOrBitCast(LLVMValueRef ConstantVal,
  //                                   LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstTruncOrBitCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstTruncOrBitCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstTruncOrBitCast';
{$ENDIF}
  //LLVMValueRef LLVMConstPointerCast(LLVMValueRef ConstantVal,
  //                                LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstPointerCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstPointerCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstPointerCast';
{$ENDIF}
  //LLVMValueRef LLVMConstIntCast(LLVMValueRef ConstantVal, LLVMTypeRef ToType,
  //                            LLVMBool isSigned);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstIntCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef; isSigned: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstIntCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef; isSigned: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstIntCast';
{$ENDIF}
  //LLVMValueRef LLVMConstFPCast(LLVMValueRef ConstantVal, LLVMTypeRef ToType);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstFPCast = function(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstFPCast(ConstantVal: LLVMValueRef; ToType: LLVMTypeRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstFPCast';
{$ENDIF}
  //LLVMValueRef LLVMConstSelect(LLVMValueRef ConstantCondition,
  //                           LLVMValueRef ConstantIfTrue,
  //                           LLVMValueRef ConstantIfFalse);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstSelect = function(ConstantCondition: LLVMValueRef; ConstantIfTrue: LLVMValueRef; ConstantIfFalse: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstSelect(ConstantCondition: LLVMValueRef; ConstantIfTrue: LLVMValueRef; ConstantIfFalse: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstSelect';
{$ENDIF}
  //LLVMValueRef LLVMConstExtractElement(LLVMValueRef VectorConstant,
  //                                   LLVMValueRef IndexConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstExtractElement = function(VectorConstant: LLVMValueRef; IndexConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstExtractElement(VectorConstant: LLVMValueRef; IndexConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstExtractElement';
{$ENDIF}
  //LLVMValueRef LLVMConstInsertElement(LLVMValueRef VectorConstant,
  //                                  LLVMValueRef ElementValueConstant,
  //                                  LLVMValueRef IndexConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstInsertElement = function(VectorConstant: LLVMValueRef; ElementValueConstant: LLVMValueRef; IndexConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstInsertElement(VectorConstant: LLVMValueRef; ElementValueConstant: LLVMValueRef; IndexConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstInsertElement';
{$ENDIF}
  //LLVMValueRef LLVMConstShuffleVector(LLVMValueRef VectorAConstant,
  //                                  LLVMValueRef VectorBConstant,
  //                                  LLVMValueRef MaskConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstShuffleVector = function(VectorAConstant: LLVMValueRef; VectorBConstant: LLVMValueRef; MaskConstant: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstShuffleVector(VectorAConstant: LLVMValueRef; VectorBConstant: LLVMValueRef; MaskConstant: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstShuffleVector';
{$ENDIF}
  //LLVMValueRef LLVMConstExtractValue(LLVMValueRef AggConstant, unsigned *IdxList,
  //                                 unsigned NumIdx);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstExtractValue = function(AggConstant: LLVMValueRef; IdxList: PCardinal; NumIdx: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstExtractValue(AggConstant: LLVMValueRef; IdxList: PCardinal; NumIdx: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstExtractValue';
{$ENDIF}
  //LLVMValueRef LLVMConstInsertValue(LLVMValueRef AggConstant,
  //                                LLVMValueRef ElementValueConstant,
  //                                unsigned *IdxList, unsigned NumIdx);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstInsertValue = function(AggConstant: LLVMValueRef; ElementValueConstant: LLVMValueRef; IdxList: PCardinal; NumIdx: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstInsertValue(AggConstant: LLVMValueRef; ElementValueConstant: LLVMValueRef; IdxList: PCardinal; NumIdx: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstInsertValue';
{$ENDIF}
  //LLVMValueRef LLVMConstInlineAsm(LLVMTypeRef Ty,
  //                              const char *AsmString, const char *Constraints,
  //                              LLVMBool HasSideEffects, LLVMBool IsAlignStack);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMConstInlineAsm = function(Ty: LLVMTypeRef; AsmString: PAnsiChar; Constraints: PAnsiChar; HasSideEffects: LLVMBool; IsAlignStack: LLVMBool): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMConstInlineAsm(Ty: LLVMTypeRef; AsmString: PAnsiChar; Constraints: PAnsiChar; HasSideEffects: LLVMBool; IsAlignStack: LLVMBool): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMConstInlineAsm';
{$ENDIF}
  //LLVMValueRef LLVMBlockAddress(LLVMValueRef F, LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBlockAddress = function(F: LLVMValueRef; BB: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBlockAddress(F: LLVMValueRef; BB: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBlockAddress';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueConstantGlobals Global Values
 *
 * This group contains functions that operate on global values. Functions in
 * this group relate to functions in the llvm::GlobalValue class tree.
 *
 * @see llvm::GlobalValue
 *
 * @{
 *)

  //LLVMModuleRef LLVMGetGlobalParent(LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetGlobalParent = function(Global: LLVMValueRef): LLVMModuleRef; cdecl;
{$ELSE}
  function LLVMGetGlobalParent(Global: LLVMValueRef): LLVMModuleRef; cdecl; external LLVMLibrary name 'LLVMGetGlobalParent';
{$ENDIF}
  //LLVMBool LLVMIsDeclaration(LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsDeclaration = function(Global: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsDeclaration(Global: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsDeclaration';
{$ENDIF}
  //LLVMLinkage LLVMGetLinkage(LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetLinkage = function(Global: LLVMValueRef): LLVMLinkage; cdecl;
{$ELSE}
  function LLVMGetLinkage(Global: LLVMValueRef): LLVMLinkage; cdecl; external LLVMLibrary name 'LLVMGetLinkage';
{$ENDIF}
  //void LLVMSetLinkage(LLVMValueRef Global, LLVMLinkage Linkage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetLinkage = procedure(Global: LLVMValueRef; Linkage: LLVMLinkage); cdecl;
{$ELSE}
  procedure LLVMSetLinkage(Global: LLVMValueRef; Linkage: LLVMLinkage); cdecl; external LLVMLibrary name 'LLVMSetLinkage';
{$ENDIF}
  //const char *LLVMGetSection(LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSection = function(Global: LLVMValueRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetSection(Global: LLVMValueRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetSection';
{$ENDIF}
  //void LLVMSetSection(LLVMValueRef Global, const char *Section);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetSection = procedure(Global: LLVMValueRef; Section: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMSetSection(Global: LLVMValueRef; Section: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMSetSection';
{$ENDIF}
  //LLVMVisibility LLVMGetVisibility(LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetVisibility = function(Global: LLVMValueRef): LLVMVisibility; cdecl;
{$ELSE}
  function LLVMGetVisibility(Global: LLVMValueRef): LLVMVisibility; cdecl; external LLVMLibrary name 'LLVMGetVisibility';
{$ENDIF}
  //void LLVMSetVisibility(LLVMValueRef Global, LLVMVisibility Viz);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetVisibility = procedure(Global: LLVMValueRef; Viz: LLVMVisibility); cdecl;
{$ELSE}
  procedure LLVMSetVisibility(Global: LLVMValueRef; Viz: LLVMVisibility); cdecl; external LLVMLibrary name 'LLVMSetVisibility';
{$ENDIF}
  //unsigned LLVMGetAlignment(LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetAlignment = function(Global: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetAlignment(Global: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetAlignment';
{$ENDIF}
  //void LLVMSetAlignment(LLVMValueRef Global, unsigned Bytes);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetAlignment = procedure(Global: LLVMValueRef; Bytes: Cardinal); cdecl;
{$ELSE}
  procedure LLVMSetAlignment(Global: LLVMValueRef; Bytes: Cardinal); cdecl; external LLVMLibrary name 'LLVMSetAlignment';
{$ENDIF}

(*
 * @defgroup LLVMCoreValueConstantGlobalVariable Global Variables
 *
 * This group contains functions that operate on global variable values.
 *
 * @see llvm::GlobalVariable
 *
 * @{
 *)
  //LLVMValueRef LLVMAddGlobal(LLVMModuleRef M, LLVMTypeRef Ty, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddGlobal = function(M: LLVMModuleRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMAddGlobal(M: LLVMModuleRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMAddGlobal';
{$ENDIF}
  //LLVMValueRef LLVMAddGlobalInAddressSpace(LLVMModuleRef M, LLVMTypeRef Ty,
  //                                       const char *Name,
  //                                       unsigned AddressSpace);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddGlobalInAddressSpace = function(M: LLVMModuleRef; Ty: LLVMTypeRef; Name: PAnsiChar; AddressSpace: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMAddGlobalInAddressSpace(M: LLVMModuleRef; Ty: LLVMTypeRef; Name: PAnsiChar; AddressSpace: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMAddGlobalInAddressSpace';
{$ENDIF}
  //LLVMValueRef LLVMGetNamedGlobal(LLVMModuleRef M, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNamedGlobal = function(M: LLVMModuleRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetNamedGlobal(M: LLVMModuleRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetNamedGlobal';
{$ENDIF}
  //LLVMValueRef LLVMGetFirstGlobal(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstGlobal = function(M: LLVMModuleRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetFirstGlobal(M: LLVMModuleRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetFirstGlobal';
{$ENDIF}
  //LLVMValueRef LLVMGetLastGlobal(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetLastGlobal = function(M: LLVMModuleRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetLastGlobal(M: LLVMModuleRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetLastGlobal';
{$ENDIF}
  //LLVMValueRef LLVMGetNextGlobal(LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextGlobal = function(GlobalVar: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetNextGlobal(GlobalVar: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetNextGlobal';
{$ENDIF}
  //LLVMValueRef LLVMGetPreviousGlobal(LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPreviousGlobal = function(GlobalVar: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetPreviousGlobal(GlobalVar: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetPreviousGlobal';
{$ENDIF}
  //void LLVMDeleteGlobal(LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDeleteGlobal = procedure(GlobalVar: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMDeleteGlobal(GlobalVar: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMDeleteGlobal';
{$ENDIF}
  //LLVMValueRef LLVMGetInitializer(LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetInitializer = function(GlobalVar: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetInitializer(GlobalVar: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetInitializer';
{$ENDIF}
  //void LLVMSetInitializer(LLVMValueRef GlobalVar, LLVMValueRef ConstantVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetInitializer = procedure(GlobalVar: LLVMValueRef; ConstantVal: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMSetInitializer(GlobalVar: LLVMValueRef; ConstantVal: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMSetInitializer';
{$ENDIF}
  //LLVMBool LLVMIsThreadLocal(LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsThreadLocal = function(GlobalVar: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsThreadLocal(GlobalVar: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsThreadLocal';
{$ENDIF}
  //void LLVMSetThreadLocal(LLVMValueRef GlobalVar, LLVMBool IsThreadLocal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetThreadLocal = procedure(GlobalVar: LLVMValueRef; IsThreadLocal: LLVMBool); cdecl;
{$ELSE}
  procedure LLVMSetThreadLocal(GlobalVar: LLVMValueRef; IsThreadLocal: LLVMBool); cdecl; external LLVMLibrary name 'LLVMSetThreadLocal';
{$ENDIF}
  //LLVMBool LLVMIsGlobalConstant(LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsGlobalConstant = function(GlobalVar: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsGlobalConstant(GlobalVar: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsGlobalConstant';
{$ENDIF}
  //void LLVMSetGlobalConstant(LLVMValueRef GlobalVar, LLVMBool IsConstant);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetGlobalConstant = procedure(GlobalVar: LLVMValueRef; IsConstant: LLVMBool); cdecl;
{$ELSE}
  procedure LLVMSetGlobalConstant(GlobalVar: LLVMValueRef; IsConstant: LLVMBool); cdecl; external LLVMLibrary name 'LLVMSetGlobalConstant';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCoreValueConstantGlobalAlias Global Aliases
 *
 * This group contains function that operate on global alias values.
 *
 * @see llvm::GlobalAlias
 *
 * @{
 *)
  //LLVMValueRef LLVMAddAlias(LLVMModuleRef M, LLVMTypeRef Ty, LLVMValueRef Aliasee,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddAlias = function(M: LLVMModuleRef; Ty: LLVMTypeRef; Aliasee: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMAddAlias(M: LLVMModuleRef; Ty: LLVMTypeRef; Aliasee: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMAddAlias';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueFunction Function values
 *
 * Functions in this group operate on LLVMValueRef instances that
 * correspond to llvm::Function instances.
 *
 * @see llvm::Function
 *
 * @{
 *)

(*
 * Remove a function from its containing module and deletes it.
 *
 * @see llvm::Function::eraseFromParent()
 *)
  //void LLVMDeleteFunction(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDeleteFunction = procedure(Fn: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMDeleteFunction(Fn: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMDeleteFunction';
{$ENDIF}

(*
 * Obtain the ID number from a function instance.
 *
 * @see llvm::Function::getIntrinsicID()
 *)
  //unsigned LLVMGetIntrinsicID(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetIntrinsicID = function(Fn: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetIntrinsicID(Fn: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetIntrinsicID';
{$ENDIF}

(*
 * Obtain the calling function of a function.
 *
 * The returned value corresponds to the LLVMCallConv enumeration.
 *
 * @see llvm::Function::getCallingConv()
 *)
  //unsigned LLVMGetFunctionCallConv(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFunctionCallConv = function(Fn: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetFunctionCallConv(Fn: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetFunctionCallConv';
{$ENDIF}

(*
 * Set the calling convention of a function.
 *
 * @see llvm::Function::setCallingConv()
 *
 * @param Fn Function to operate on
 * @param CC LLVMCallConv to set calling convention to
 *)
  //void LLVMSetFunctionCallConv(LLVMValueRef Fn, unsigned CC);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetFunctionCallConv = procedure(Fn: LLVMValueRef; CC: Cardinal); cdecl;
{$ELSE}
  procedure LLVMSetFunctionCallConv(Fn: LLVMValueRef; CC: Cardinal); cdecl; external LLVMLibrary name 'LLVMSetFunctionCallConv';
{$ENDIF}

(*
 * Obtain the name of the garbage collector to use during code
 * generation.
 *
 * @see llvm::Function::getGC()
 *)
  //const char *LLVMGetGC(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetGC = function(Fn: LLVMValueRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetGC(Fn: LLVMValueRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetGC';
{$ENDIF}

(*
 * Define the garbage collector to use during code generation.
 *
 * @see llvm::Function::setGC()
 *)
  //void LLVMSetGC(LLVMValueRef Fn, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetGC = procedure(Fn: LLVMValueRef; Name: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMSetGC(Fn: LLVMValueRef; Name: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMSetGC';
{$ENDIF}

(*
 * Add an attribute to a function.
 *
 * @see llvm::Function::addAttribute()
 *)
  //void LLVMAddFunctionAttr(LLVMValueRef Fn, LLVMAttribute PA);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddFunctionAttr = procedure(Fn: LLVMValueRef; PA: LLVMAttribute); cdecl;
{$ELSE}
  procedure LLVMAddFunctionAttr(Fn: LLVMValueRef; PA: LLVMAttribute); cdecl; external LLVMLibrary name 'LLVMAddFunctionAttr';
{$ENDIF}

(*
 * Obtain an attribute from a function.
 *
 * @see llvm::Function::getAttributes()
 *)
  //LLVMAttribute LLVMGetFunctionAttr(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFunctionAttr = function(Fn: LLVMValueRef): LLVMAttribute; cdecl;
{$ELSE}
  function LLVMGetFunctionAttr(Fn: LLVMValueRef): LLVMAttribute; cdecl; external LLVMLibrary name 'LLVMGetFunctionAttr';
{$ENDIF}

(*
 * Remove an attribute from a function.
 *)
  //void LLVMRemoveFunctionAttr(LLVMValueRef Fn, LLVMAttribute PA);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRemoveFunctionAttr = procedure(Fn: LLVMValueRef; PA: LLVMAttribute); cdecl;
{$ELSE}
  procedure LLVMRemoveFunctionAttr(Fn: LLVMValueRef; PA: LLVMAttribute); cdecl; external LLVMLibrary name 'LLVMRemoveFunctionAttr';
{$ENDIF}

(*
 * @defgroup LLVMCCoreValueFunctionParameters Function Parameters
 *
 * Functions in this group relate to arguments/parameters on functions.
 *
 * Functions in this group expect LLVMValueRef instances that correspond
 * to llvm::Function instances.
 *
 * @{
 *)

(*
 * Obtain the number of parameters in a function.
 *
 * @see llvm::Function::arg_size()
 *)
  //unsigned LLVMCountParams(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCountParams = function(Fn: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMCountParams(Fn: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMCountParams';
{$ENDIF}

(*
 * Obtain the parameters in a function.
 *
 * The takes a pointer to a pre-allocated array of LLVMValueRef that is
 * at least LLVMCountParams() long. This array will be filled with
 * LLVMValueRef instances which correspond to the parameters the
 * function receives. Each LLVMValueRef corresponds to a llvm::Argument
 * instance.
 *
 * @see llvm::Function::arg_begin()
 *)
  //void LLVMGetParams(LLVMValueRef Fn, LLVMValueRef *Params);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetParams = procedure(Fn: LLVMValueRef; var Params: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMGetParams(Fn: LLVMValueRef; var Params: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMGetParams';
{$ENDIF}

(*
 * Obtain the parameter at the specified index.
 *
 * Parameters are indexed from 0.
 *
 * @see llvm::Function::arg_begin()
 *)
  //LLVMValueRef LLVMGetParam(LLVMValueRef Fn, unsigned Index);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetParam = function(Fn: LLVMValueRef; Index: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetParam(Fn: LLVMValueRef; Index: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetParam';
{$ENDIF}

(*
 * Obtain the function to which this argument belongs.
 *
 * Unlike other functions in this group, this one takes a LLVMValueRef
 * that corresponds to a llvm::Attribute.
 *
 * The returned LLVMValueRef is the llvm::Function to which this
 * argument belongs.
 *)
  //LLVMValueRef LLVMGetParamParent(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetParamParent = function(Inst: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetParamParent(Inst: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetParamParent';
{$ENDIF}

(*
 * Obtain the first parameter to a function.
 *
 * @see llvm::Function::arg_begin()
 *)
  //LLVMValueRef LLVMGetFirstParam(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstParam = function(Fn: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetFirstParam(Fn: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetFirstParam';
{$ENDIF}

(*
 * Obtain the last parameter to a function.
 *
 * @see llvm::Function::arg_end()
 *)
  //LLVMValueRef LLVMGetLastParam(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetLastParam = function(Fn: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetLastParam(Fn: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetLastParam';
{$ENDIF}

(*
 * Obtain the next parameter to a function.
 *
 * This takes a LLVMValueRef obtained from LLVMGetFirstParam() (which is
 * actually a wrapped iterator) and obtains the next parameter from the
 * underlying iterator.
 *)
  //LLVMValueRef LLVMGetNextParam(LLVMValueRef Arg);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextParam = function(Arg: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetNextParam(Arg: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetNextParam';
{$ENDIF}

(*
 * Obtain the previous parameter to a function.
 *
 * This is the opposite of LLVMGetNextParam().
 *)
  //LLVMValueRef LLVMGetPreviousParam(LLVMValueRef Arg);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPreviousParam = function(Arg: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetPreviousParam(Arg: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetPreviousParam';
{$ENDIF}

(*
 * Add an attribute to a function argument.
 *
 * @see llvm::Argument::addAttr()
 *)
  //void LLVMAddAttribute(LLVMValueRef Arg, LLVMAttribute PA);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddAttribute = procedure(Arg: LLVMValueRef; PA: LLVMAttribute); cdecl;
{$ELSE}
  procedure LLVMAddAttribute(Arg: LLVMValueRef; PA: LLVMAttribute); cdecl; external LLVMLibrary name 'LLVMAddAttribute';
{$ENDIF}

(*
 * Remove an attribute from a function argument.
 *
 * @see llvm::Argument::removeAttr()
 *)
  //void LLVMRemoveAttribute(LLVMValueRef Arg, LLVMAttribute PA);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRemoveAttribute = procedure(Arg: LLVMValueRef; PA: LLVMAttribute); cdecl;
{$ELSE}
  procedure LLVMRemoveAttribute(Arg: LLVMValueRef; PA: LLVMAttribute); cdecl; external LLVMLibrary name 'LLVMRemoveAttribute';
{$ENDIF}

(*
 * Get an attribute from a function argument.
 *)
  //LLVMAttribute LLVMGetAttribute(LLVMValueRef Arg);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetAttribute = function(Arg: LLVMValueRef): LLVMAttribute; cdecl;
{$ELSE}
  function LLVMGetAttribute(Arg: LLVMValueRef): LLVMAttribute; cdecl; external LLVMLibrary name 'LLVMGetAttribute';
{$ENDIF}

(*
 * Set the alignment for a function parameter.
 *
 * @see llvm::Argument::addAttr()
 * @see llvm::Attribute::constructAlignmentFromInt()
 *)
  //void LLVMSetParamAlignment(LLVMValueRef Arg, unsigned align);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetParamAlignment = procedure(Arg: LLVMValueRef; align: Cardinal); cdecl;
{$ELSE}
  procedure LLVMSetParamAlignment(Arg: LLVMValueRef; align: Cardinal); cdecl; external LLVMLibrary name 'LLVMSetParamAlignment';
{$ENDIF}

(*
 * @}
 *)

(*
 * @}
 *)

(*
 * @}
 *)

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueMetadata Metadata
 *
 * @{
 *)

(*
 * Obtain a MDString value from a context.
 *
 * The returned instance corresponds to the llvm::MDString class.
 *
 * The instance is specified by string data of a specified length. The
 * string content is copied, so the backing memory can be freed after
 * this function returns.
 *)
  //LLVMValueRef LLVMMDStringInContext(LLVMContextRef C, const char *Str,
  //                                 unsigned SLen);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMDStringInContext = function(C: LLVMContextRef; Str: PAnsiChar; SLen: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMMDStringInContext(C: LLVMContextRef; Str: PAnsiChar; SLen: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMMDStringInContext';
{$ENDIF}

(*
 * Obtain a MDString value from the global context.
 *)
  //LLVMValueRef LLVMMDString(const char *Str, unsigned SLen);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMDString = function(Str: PAnsiChar; SLen: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMMDString(Str: PAnsiChar; SLen: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMMDString';
{$ENDIF}

(*
 * Obtain a MDNode value from a context.
 *
 * The returned value corresponds to the llvm::MDNode class.
 *)
  //LLVMValueRef LLVMMDNodeInContext(LLVMContextRef C, LLVMValueRef *Vals,
  //                               unsigned Count);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMDNodeInContext = function(C: LLVMContextRef; {var} Vals: Pointer{LLVMValueRef}; Count: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMMDNodeInContext(C: LLVMContextRef; {var} Vals: Pointer{LLVMValueRef}; Count: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMMDNodeInContext';
{$ENDIF}

(*
 * Obtain a MDNode value from the global context.
 *)
  //LLVMValueRef LLVMMDNode(LLVMValueRef *Vals, unsigned Count);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMDNode = function({var} Vals: Pointer{LLVMValueRef}; Count: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMMDNode({var} Vals: Pointer{LLVMValueRef}; Count: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMMDNode';
{$ENDIF}

(*
 * Obtain the underlying string from a MDString value.
 *
 * @param V Instance to obtain string from.
 * @param Len Memory address which will hold length of returned string.
 * @return String data in MDString.
 *)
  //const char  *LLVMGetMDString(LLVMValueRef V, unsigned* Len);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetMDString = function(V: LLVMValueRef; Len: PCardinal): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetMDString(V: LLVMValueRef; Len: PCardinal): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetMDString';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueBasicBlock Basic Block
 *
 * A basic block represents a single entry single exit section of code.
 * Basic blocks contain a list of instructions which form the body of
 * the block.
 *
 * Basic blocks belong to functions. They have the type of label.
 *
 * Basic blocks are themselves values. However, the C API models them as
 * LLVMBasicBlockRef.
 *
 * @see llvm::BasicBlock
 *
 * @{
 *)

(*
 * Convert a basic block instance to a value type.
 *)
  //LLVMValueRef LLVMBasicBlockAsValue(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBasicBlockAsValue = function(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBasicBlockAsValue(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBasicBlockAsValue';
{$ENDIF}

(*
 * Determine whether a LLVMValueRef is itself a basic block.
 *)
  //LLVMBool LLVMValueIsBasicBlock(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMValueIsBasicBlock = function(Val: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMValueIsBasicBlock(Val: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMValueIsBasicBlock';
{$ENDIF}

(*
 * Convert a LLVMValueRef to a LLVMBasicBlockRef instance.
 *)
  //LLVMBasicBlockRef LLVMValueAsBasicBlock(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMValueAsBasicBlock = function(Val: LLVMValueRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMValueAsBasicBlock(Val: LLVMValueRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMValueAsBasicBlock';
{$ENDIF}

(*
 * Obtain the function to which a basic block belongs.
 *
 * @see llvm::BasicBlock::getParent()
 *)
  //LLVMValueRef LLVMGetBasicBlockParent(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBasicBlockParent = function(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetBasicBlockParent(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetBasicBlockParent';
{$ENDIF}

(*
 * Obtain the terminator instruction for a basic block.
 *
 * If the basic block does not have a terminator (it is not well-formed
 * if it doesn't), then NULL is returned.
 *
 * The returned LLVMValueRef corresponds to a llvm::TerminatorInst.
 *
 * @see llvm::BasicBlock::getTerminator()
 *)
  //LLVMValueRef LLVMGetBasicBlockTerminator(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBasicBlockTerminator = function(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetBasicBlockTerminator(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetBasicBlockTerminator';
{$ENDIF}

(*
 * Obtain the number of basic blocks in a function.
 *
 * @param Fn Function value to operate on.
 *)
  //unsigned LLVMCountBasicBlocks(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCountBasicBlocks = function(Fn: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMCountBasicBlocks(Fn: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMCountBasicBlocks';
{$ENDIF}

(*
 * Obtain all of the basic blocks in a function.
 *
 * This operates on a function value. The BasicBlocks parameter is a
 * pointer to a pre-allocated array of LLVMBasicBlockRef of at least
 * LLVMCountBasicBlocks() in length. This array is populated with
 * LLVMBasicBlockRef instances.
 *)
  //void LLVMGetBasicBlocks(LLVMValueRef Fn, LLVMBasicBlockRef *BasicBlocks);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBasicBlocks = procedure(Fn: LLVMValueRef; var BasicBlocks: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMGetBasicBlocks(Fn: LLVMValueRef; var BasicBlocks: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMGetBasicBlocks';
{$ENDIF}

(*
 * Obtain the first basic block in a function.
 *
 * The returned basic block can be used as an iterator. You will likely
 * eventually call into LLVMGetNextBasicBlock() with it.
 *
 * @see llvm::Function::begin()
 *)
  //LLVMBasicBlockRef LLVMGetFirstBasicBlock(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstBasicBlock = function(Fn: LLVMValueRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetFirstBasicBlock(Fn: LLVMValueRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetFirstBasicBlock';
{$ENDIF}

(*
 * Obtain the last basic block in a function.
 *
 * @see llvm::Function::end()
 *)
  //LLVMBasicBlockRef LLVMGetLastBasicBlock(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetLastBasicBlock = function(Fn: LLVMValueRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetLastBasicBlock(Fn: LLVMValueRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetLastBasicBlock';
{$ENDIF}

(*
 * Advance a basic block iterator.
 *)
  //LLVMBasicBlockRef LLVMGetNextBasicBlock(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextBasicBlock = function(BB: LLVMBasicBlockRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetNextBasicBlock(BB: LLVMBasicBlockRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetNextBasicBlock';
{$ENDIF}

(*
 * Go backwards in a basic block iterator.
 *)
  //LLVMBasicBlockRef LLVMGetPreviousBasicBlock(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPreviousBasicBlock = function(BB: LLVMBasicBlockRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetPreviousBasicBlock(BB: LLVMBasicBlockRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetPreviousBasicBlock';
{$ENDIF}

(*
 * Obtain the basic block that corresponds to the entry point of a
 * function.
 *
 * @see llvm::Function::getEntryBlock()
 *)
  //LLVMBasicBlockRef LLVMGetEntryBasicBlock(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetEntryBasicBlock = function(Fn: LLVMValueRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetEntryBasicBlock(Fn: LLVMValueRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetEntryBasicBlock';
{$ENDIF}

(*
 * Append a basic block to the end of a function.
 *
 * @see llvm::BasicBlock::Create()
 *)
  //LLVMBasicBlockRef LLVMAppendBasicBlockInContext(LLVMContextRef C,
  //                                              LLVMValueRef Fn,
  //                                              const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAppendBasicBlockInContext = function(C: LLVMContextRef; Fn: LLVMValueRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMAppendBasicBlockInContext(C: LLVMContextRef; Fn: LLVMValueRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMAppendBasicBlockInContext';
{$ENDIF}

(*
 * Append a basic block to the end of a function using the global
 * context.
 *
 * @see llvm::BasicBlock::Create()
 *)
  //LLVMBasicBlockRef LLVMAppendBasicBlock(LLVMValueRef Fn, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAppendBasicBlock = function(Fn: LLVMValueRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMAppendBasicBlock(Fn: LLVMValueRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMAppendBasicBlock';
{$ENDIF}

(*
 * Insert a basic block in a function before another basic block.
 *
 * The function to add to is determined by the function of the
 * passed basic block.
 *
 * @see llvm::BasicBlock::Create()
 *)
  //LLVMBasicBlockRef LLVMInsertBasicBlockInContext(LLVMContextRef C,
  //                                              LLVMBasicBlockRef BB,
  //                                              const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInsertBasicBlockInContext = function(C: LLVMContextRef; BB: LLVMBasicBlockRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMInsertBasicBlockInContext(C: LLVMContextRef; BB: LLVMBasicBlockRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMInsertBasicBlockInContext';
{$ENDIF}

(*
 * Insert a basic block in a function using the global context.
 *
 * @see llvm::BasicBlock::Create()
 *)
  //LLVMBasicBlockRef LLVMInsertBasicBlock(LLVMBasicBlockRef InsertBeforeBB,
  //                                     const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInsertBasicBlock = function(InsertBeforeBB: LLVMBasicBlockRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMInsertBasicBlock(InsertBeforeBB: LLVMBasicBlockRef; Name: PAnsiChar): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMInsertBasicBlock';
{$ENDIF}

(*
 * Remove a basic block from a function and delete it.
 *
 * This deletes the basic block from its containing function and deletes
 * the basic block itself.
 *
 * @see llvm::BasicBlock::eraseFromParent()
 *)
  //void LLVMDeleteBasicBlock(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDeleteBasicBlock = procedure(BB: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMDeleteBasicBlock(BB: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMDeleteBasicBlock';
{$ENDIF}

(*
 * Remove a basic block from a function.
 *
 * This deletes the basic block from its containing function but keep
 * the basic block alive.
 *
 * @see llvm::BasicBlock::removeFromParent()
 *)
  //void LLVMRemoveBasicBlockFromParent(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRemoveBasicBlockFromParent = procedure(BB: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMRemoveBasicBlockFromParent(BB: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMRemoveBasicBlockFromParent';
{$ENDIF}

(*
 * Move a basic block to before another one.
 *
 * @see llvm::BasicBlock::moveBefore()
 *)
  //void LLVMMoveBasicBlockBefore(LLVMBasicBlockRef BB, LLVMBasicBlockRef MovePos);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMoveBasicBlockBefore = procedure(BB: LLVMBasicBlockRef; MovePos: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMMoveBasicBlockBefore(BB: LLVMBasicBlockRef; MovePos: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMMoveBasicBlockBefore';
{$ENDIF}

(*
 * Move a basic block to after another one.
 *
 * @see llvm::BasicBlock::moveAfter()
 *)
  //void LLVMMoveBasicBlockAfter(LLVMBasicBlockRef BB, LLVMBasicBlockRef MovePos);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMoveBasicBlockAfter = procedure(BB: LLVMBasicBlockRef; MovePos: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMMoveBasicBlockAfter(BB: LLVMBasicBlockRef; MovePos: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMMoveBasicBlockAfter';
{$ENDIF}

(*
 * Obtain the first instruction in a basic block.
 *
 * The returned LLVMValueRef corresponds to a llvm::Instruction
 * instance.
 *)
  //LLVMValueRef LLVMGetFirstInstruction(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstInstruction = function(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetFirstInstruction(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetFirstInstruction';
{$ENDIF}

(*
 * Obtain the last instruction in a basic block.
 *
 * The returned LLVMValueRef corresponds to a LLVM:Instruction.
 *)
  //LLVMValueRef LLVMGetLastInstruction(LLVMBasicBlockRef BB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetLastInstruction = function(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetLastInstruction(BB: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetLastInstruction';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreValueInstruction Instructions
 *
 * Functions in this group relate to the inspection and manipulation of
 * individual instructions.
 *
 * In the C++ API, an instruction is modeled by llvm::Instruction. This
 * class has a large number of descendents. llvm::Instruction is a
 * llvm::Value and in the C API, instructions are modeled by
 * LLVMValueRef.
 *
 * This group also contains sub-groups which operate on specific
 * llvm::Instruction types, e.g. llvm::CallInst.
 *
 * @{
 *)

(*
 * Determine whether an instruction has any metadata attached.
 *)
  //int LLVMHasMetadata(LLVMValueRef Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMHasMetadata = function(Val: LLVMValueRef): Integer; cdecl;
{$ELSE}
  function LLVMHasMetadata(Val: LLVMValueRef): Integer; cdecl; external LLVMLibrary name 'LLVMHasMetadata';
{$ENDIF}

(*
 * Return metadata associated with an instruction value.
 *)
  //LLVMValueRef LLVMGetMetadata(LLVMValueRef Val, unsigned KindID);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetMetadata = function(Val: LLVMValueRef; KindID: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetMetadata(Val: LLVMValueRef; KindID: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetMetadata';
{$ENDIF}

(*
 * Set metadata associated with an instruction value.
 *)
  //void LLVMSetMetadata(LLVMValueRef Val, unsigned KindID, LLVMValueRef Node);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetMetadata = procedure(Val: LLVMValueRef; KindID: Cardinal; Node: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMSetMetadata(Val: LLVMValueRef; KindID: Cardinal; Node: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMSetMetadata';
{$ENDIF}

(*
 * Obtain the basic block to which an instruction belongs.
 *
 * @see llvm::Instruction::getParent()
 *)
  //LLVMBasicBlockRef LLVMGetInstructionParent(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetInstructionParent = function(Inst: LLVMValueRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetInstructionParent(Inst: LLVMValueRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetInstructionParent';
{$ENDIF}

(*
 * Obtain the instruction that occurs after the one specified.
 *
 * The next instruction will be from the same basic block.
 *
 * If this is the last instruction in a basic block, NULL will be
 * returned.
 *)
  //LLVMValueRef LLVMGetNextInstruction(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextInstruction = function(Inst: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetNextInstruction(Inst: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetNextInstruction';
{$ENDIF}

(*
 * Obtain the instruction that occured before this one.
 *
 * If the instruction is the first instruction in a basic block, NULL
 * will be returned.
 *)
  //LLVMValueRef LLVMGetPreviousInstruction(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPreviousInstruction = function(Inst: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetPreviousInstruction(Inst: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetPreviousInstruction';
{$ENDIF}

(*
 * Remove and delete an instruction.
 *
 * The instruction specified is removed from its containing building
 * block and then deleted.
 *
 * @see llvm::Instruction::eraseFromParent()
 *)
  //void LLVMInstructionEraseFromParent(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInstructionEraseFromParent = procedure(Inst: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMInstructionEraseFromParent(Inst: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMInstructionEraseFromParent';
{$ENDIF}

(*
 * Obtain the code opcode for an individual instruction.
 *
 * @see llvm::Instruction::getOpCode()
 *)
  //LLVMOpcode   LLVMGetInstructionOpcode(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetInstructionOpcode = function(Inst: LLVMValueRef): LLVMOpcode; cdecl;
{$ELSE}
  function LLVMGetInstructionOpcode(Inst: LLVMValueRef): LLVMOpcode; cdecl; external LLVMLibrary name 'LLVMGetInstructionOpcode';
{$ENDIF}

(*
 * Obtain the predicate of an instruction.
 *
 * This is only valid for instructions that correspond to llvm::ICmpInst
 * or llvm::ConstantExpr whose opcode is llvm::Instruction::ICmp.
 *
 * @see llvm::ICmpInst::getPredicate()
 *)
  //LLVMIntPredicate LLVMGetICmpPredicate(LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetICmpPredicate = function(Inst: LLVMValueRef): LLVMIntPredicate; cdecl;
{$ELSE}
  function LLVMGetICmpPredicate(Inst: LLVMValueRef): LLVMIntPredicate; cdecl; external LLVMLibrary name 'LLVMGetICmpPredicate';
{$ENDIF}

(*
 * @defgroup LLVMCCoreValueInstructionCall Call Sites and Invocations
 *
 * Functions in this group apply to instructions that refer to call
 * sites and invocations. These correspond to C++ types in the
 * llvm::CallInst class tree.
 *
 * @{
 *)

(*
 * Set the calling convention for a call instruction.
 *
 * This expects an LLVMValueRef that corresponds to a llvm::CallInst or
 * llvm::InvokeInst.
 *
 * @see llvm::CallInst::setCallingConv()
 * @see llvm::InvokeInst::setCallingConv()
 *)
  //void LLVMSetInstructionCallConv(LLVMValueRef Instr, unsigned CC);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetInstructionCallConv = procedure(Instr: LLVMValueRef; CC: Cardinal); cdecl;
{$ELSE}
  procedure LLVMSetInstructionCallConv(Instr: LLVMValueRef; CC: Cardinal); cdecl; external LLVMLibrary name 'LLVMSetInstructionCallConv';
{$ENDIF}

(*
 * Obtain the calling convention for a call instruction.
 *
 * This is the opposite of LLVMSetInstructionCallConv(). Reads its
 * usage.
 *
 * @see LLVMSetInstructionCallConv()
 *)
  //unsigned LLVMGetInstructionCallConv(LLVMValueRef Instr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetInstructionCallConv = function(Instr: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMGetInstructionCallConv(Instr: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMGetInstructionCallConv';
{$ENDIF}


  //void LLVMAddInstrAttribute(LLVMValueRef Instr, unsigned index, LLVMAttribute);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddInstrAttribute = procedure(Instr: LLVMValueRef; index: Cardinal; Unknown: LLVMAttribute); cdecl;
{$ELSE}
  procedure LLVMAddInstrAttribute(Instr: LLVMValueRef; index: Cardinal; Unknown: LLVMAttribute); cdecl; external LLVMLibrary name 'LLVMAddInstrAttribute';
{$ENDIF}
  //void LLVMRemoveInstrAttribute(LLVMValueRef Instr, unsigned index,
  //                            LLVMAttribute);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRemoveInstrAttribute = procedure(Instr: LLVMValueRef; index: Cardinal; Unknown: LLVMAttribute); cdecl;
{$ELSE}
  procedure LLVMRemoveInstrAttribute(Instr: LLVMValueRef; index: Cardinal; Unknown: LLVMAttribute); cdecl; external LLVMLibrary name 'LLVMRemoveInstrAttribute';
{$ENDIF}
  //void LLVMSetInstrParamAlignment(LLVMValueRef Instr, unsigned index,
  //                              unsigned align);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetInstrParamAlignment = procedure(Instr: LLVMValueRef; index: Cardinal; align: Cardinal); cdecl;
{$ELSE}
  procedure LLVMSetInstrParamAlignment(Instr: LLVMValueRef; index: Cardinal; align: Cardinal); cdecl; external LLVMLibrary name 'LLVMSetInstrParamAlignment';
{$ENDIF}

(*
 * Obtain whether a call instruction is a tail call.
 *
 * This only works on llvm::CallInst instructions.
 *
 * @see llvm::CallInst::isTailCall()
 *)
  //LLVMBool LLVMIsTailCall(LLVMValueRef CallInst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsTailCall = function(CallInst: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsTailCall(CallInst: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsTailCall';
{$ENDIF}

(*
 * Set whether a call instruction is a tail call.
 *
 * This only works on llvm::CallInst instructions.
 *
 * @see llvm::CallInst::setTailCall()
 *)
  //void LLVMSetTailCall(LLVMValueRef CallInst, LLVMBool IsTailCall);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetTailCall = procedure(CallInst: LLVMValueRef; IsTailCall: LLVMBool); cdecl;
{$ELSE}
  procedure LLVMSetTailCall(CallInst: LLVMValueRef; IsTailCall: LLVMBool); cdecl; external LLVMLibrary name 'LLVMSetTailCall';
{$ENDIF}

(*
 * @}
 *)

(*
 * Obtain the default destination basic block of a switch instruction.
 *
 * This only works on llvm::SwitchInst instructions.
 *
 * @see llvm::SwitchInst::getDefaultDest()
 *)
  //LLVMBasicBlockRef LLVMGetSwitchDefaultDest(LLVMValueRef SwitchInstr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSwitchDefaultDest = function(SwitchInstr: LLVMValueRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetSwitchDefaultDest(SwitchInstr: LLVMValueRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetSwitchDefaultDest';
{$ENDIF}

(*
 * @defgroup LLVMCCoreValueInstructionPHINode PHI Nodes
 *
 * Functions in this group only apply to instructions that map to
 * llvm::PHINode instances.
 *
 * @{
 *)

(*
 * Add an incoming value to the end of a PHI list.
 *)
  //void LLVMAddIncoming(LLVMValueRef PhiNode, LLVMValueRef *IncomingValues,
  //                   LLVMBasicBlockRef *IncomingBlocks, unsigned Count);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddIncoming = procedure(PhiNode: LLVMValueRef; var IncomingValues: LLVMValueRef; var IncomingBlocks: LLVMBasicBlockRef; Count: Cardinal); cdecl;
{$ELSE}
  procedure LLVMAddIncoming(PhiNode: LLVMValueRef; var IncomingValues: LLVMValueRef; var IncomingBlocks: LLVMBasicBlockRef; Count: Cardinal); cdecl; external LLVMLibrary name 'LLVMAddIncoming';
{$ENDIF}

(*
 * Obtain the number of incoming basic blocks to a PHI node.
 *)
  //unsigned LLVMCountIncoming(LLVMValueRef PhiNode);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCountIncoming = function(PhiNode: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMCountIncoming(PhiNode: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMCountIncoming';
{$ENDIF}

(*
 * Obtain an incoming value to a PHI node as a LLVMValueRef.
 *)
  //LLVMValueRef LLVMGetIncomingValue(LLVMValueRef PhiNode, unsigned Index);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetIncomingValue = function(PhiNode: LLVMValueRef; Index: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetIncomingValue(PhiNode: LLVMValueRef; Index: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetIncomingValue';
{$ENDIF}

(*
 * Obtain an incoming value to a PHI node as a LLVMBasicBlockRef.
 *)
  //LLVMBasicBlockRef LLVMGetIncomingBlock(LLVMValueRef PhiNode, unsigned Index);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetIncomingBlock = function(PhiNode: LLVMValueRef; Index: Cardinal): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetIncomingBlock(PhiNode: LLVMValueRef; Index: Cardinal): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetIncomingBlock';
{$ENDIF}

(*
 * @}
 *)

(*
 * @}
 *)

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreInstructionBuilder Instruction Builders
 *
 * An instruction builder represents a point within a basic block and is
 * the exclusive means of building instructions using the C interface.
 *
 * @{
 *)

  //LLVMBuilderRef LLVMCreateBuilderInContext(LLVMContextRef C);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateBuilderInContext = function(C: LLVMContextRef): LLVMBuilderRef; cdecl;
{$ELSE}
  function LLVMCreateBuilderInContext(C: LLVMContextRef): LLVMBuilderRef; cdecl; external LLVMLibrary name 'LLVMCreateBuilderInContext';
{$ENDIF}
  //LLVMBuilderRef LLVMCreateBuilder(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateBuilder = function(): LLVMBuilderRef; cdecl;
{$ELSE}
  function LLVMCreateBuilder(): LLVMBuilderRef; cdecl; external LLVMLibrary name 'LLVMCreateBuilder';
{$ENDIF}
  //void LLVMPositionBuilder(LLVMBuilderRef Builder, LLVMBasicBlockRef Block,
  //                       LLVMValueRef Instr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPositionBuilder = procedure(Builder: LLVMBuilderRef; Block: LLVMBasicBlockRef; Instr: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMPositionBuilder(Builder: LLVMBuilderRef; Block: LLVMBasicBlockRef; Instr: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMPositionBuilder';
{$ENDIF}
  //void LLVMPositionBuilderBefore(LLVMBuilderRef Builder, LLVMValueRef Instr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPositionBuilderBefore = procedure(Builder: LLVMBuilderRef; Instr: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMPositionBuilderBefore(Builder: LLVMBuilderRef; Instr: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMPositionBuilderBefore';
{$ENDIF}
  //void LLVMPositionBuilderAtEnd(LLVMBuilderRef Builder, LLVMBasicBlockRef Block);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPositionBuilderAtEnd = procedure(Builder: LLVMBuilderRef; Block: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMPositionBuilderAtEnd(Builder: LLVMBuilderRef; Block: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMPositionBuilderAtEnd';
{$ENDIF}
  //LLVMBasicBlockRef LLVMGetInsertBlock(LLVMBuilderRef Builder);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetInsertBlock = function(Builder: LLVMBuilderRef): LLVMBasicBlockRef; cdecl;
{$ELSE}
  function LLVMGetInsertBlock(Builder: LLVMBuilderRef): LLVMBasicBlockRef; cdecl; external LLVMLibrary name 'LLVMGetInsertBlock';
{$ENDIF}
  //void LLVMClearInsertionPosition(LLVMBuilderRef Builder);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMClearInsertionPosition = procedure(Builder: LLVMBuilderRef); cdecl;
{$ELSE}
  procedure LLVMClearInsertionPosition(Builder: LLVMBuilderRef); cdecl; external LLVMLibrary name 'LLVMClearInsertionPosition';
{$ENDIF}
  //void LLVMInsertIntoBuilder(LLVMBuilderRef Builder, LLVMValueRef Instr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInsertIntoBuilder = procedure(Builder: LLVMBuilderRef; Instr: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMInsertIntoBuilder(Builder: LLVMBuilderRef; Instr: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMInsertIntoBuilder';
{$ENDIF}
  //void LLVMInsertIntoBuilderWithName(LLVMBuilderRef Builder, LLVMValueRef Instr,
  //                                 const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInsertIntoBuilderWithName = procedure(Builder: LLVMBuilderRef; Instr: LLVMValueRef; Name: PAnsiChar); cdecl;
{$ELSE}
  procedure LLVMInsertIntoBuilderWithName(Builder: LLVMBuilderRef; Instr: LLVMValueRef; Name: PAnsiChar); cdecl; external LLVMLibrary name 'LLVMInsertIntoBuilderWithName';
{$ENDIF}
  //void LLVMDisposeBuilder(LLVMBuilderRef Builder);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeBuilder = procedure(Builder: LLVMBuilderRef); cdecl;
{$ELSE}
  procedure LLVMDisposeBuilder(Builder: LLVMBuilderRef); cdecl; external LLVMLibrary name 'LLVMDisposeBuilder';
{$ENDIF}

(* Metadata *)
  //void LLVMSetCurrentDebugLocation(LLVMBuilderRef Builder, LLVMValueRef L);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetCurrentDebugLocation = procedure(Builder: LLVMBuilderRef; L: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMSetCurrentDebugLocation(Builder: LLVMBuilderRef; L: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMSetCurrentDebugLocation';
{$ENDIF}
  //LLVMValueRef LLVMGetCurrentDebugLocation(LLVMBuilderRef Builder);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetCurrentDebugLocation = function(Builder: LLVMBuilderRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetCurrentDebugLocation(Builder: LLVMBuilderRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetCurrentDebugLocation';
{$ENDIF}
  //void LLVMSetInstDebugLocation(LLVMBuilderRef Builder, LLVMValueRef Inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetInstDebugLocation = procedure(Builder: LLVMBuilderRef; Instr: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMSetInstDebugLocation(Builder: LLVMBuilderRef; Instr: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMSetInstDebugLocation';
{$ENDIF}

(* Terminators *)
  //LLVMValueRef LLVMBuildRetVoid(LLVMBuilderRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildRetVoid = function(Unknown: LLVMBuilderRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildRetVoid(Unknown: LLVMBuilderRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildRetVoid';
{$ENDIF}
  //LLVMValueRef LLVMBuildRet(LLVMBuilderRef, LLVMValueRef V);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildRet = function(Unknown: LLVMBuilderRef; V: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildRet(Unknown: LLVMBuilderRef; V: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildRet';
{$ENDIF}
  //LLVMValueRef LLVMBuildAggregateRet(LLVMBuilderRef, LLVMValueRef *RetVals,
  //                                 unsigned N);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildAggregateRet = function(Unknown: LLVMBuilderRef; var RetVals: LLVMValueRef; N: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildAggregateRet(Unknown: LLVMBuilderRef; var RetVals: LLVMValueRef; N: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildAggregateRet';
{$ENDIF}
  //LLVMValueRef LLVMBuildBr(LLVMBuilderRef, LLVMBasicBlockRef Dest);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildBr = function(Unknown: LLVMBuilderRef; Dest: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildBr(Unknown: LLVMBuilderRef; Dest: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildBr';
{$ENDIF}
  //LLVMValueRef LLVMBuildCondBr(LLVMBuilderRef, LLVMValueRef If,
  //                           LLVMBasicBlockRef Then, LLVMBasicBlockRef Else);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildCondBr = function(Unknown: LLVMBuilderRef; _If: LLVMValueRef; _Then: LLVMBasicBlockRef; _Else: LLVMBasicBlockRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildCondBr(Unknown: LLVMBuilderRef; _If: LLVMValueRef; _Then: LLVMBasicBlockRef; _Else: LLVMBasicBlockRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildCondBr';
{$ENDIF}
  //LLVMValueRef LLVMBuildSwitch(LLVMBuilderRef, LLVMValueRef V,
  //                           LLVMBasicBlockRef Else, unsigned NumCases);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSwitch = function(Unknown: LLVMBuilderRef; V: LLVMValueRef; _Else: LLVMBasicBlockRef; NumCases: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSwitch(Unknown: LLVMBuilderRef; V: LLVMValueRef; _Else: LLVMBasicBlockRef; NumCases: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSwitch';
{$ENDIF}
  //LLVMValueRef LLVMBuildIndirectBr(LLVMBuilderRef B, LLVMValueRef Addr,
  //                               unsigned NumDests);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildIndirectBr = function(B: LLVMBuilderRef; Addr: LLVMValueRef; NumDests: Cardinal): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildIndirectBr(B: LLVMBuilderRef; Addr: LLVMValueRef; NumDests: Cardinal): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildIndirectBr';
{$ENDIF}
  //LLVMValueRef LLVMBuildInvoke(LLVMBuilderRef, LLVMValueRef Fn,
  //                           LLVMValueRef *Args, unsigned NumArgs,
  //                           LLVMBasicBlockRef Then, LLVMBasicBlockRef Catch,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildInvoke = function(Unknown: LLVMBuilderRef; Fn: LLVMValueRef; var Args: LLVMValueRef; NumArgs: Cardinal; _Then: LLVMBasicBlockRef; Catch: LLVMBasicBlockRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildInvoke(Unknown: LLVMBuilderRef; Fn: LLVMValueRef; var Args: LLVMValueRef; NumArgs: Cardinal; _Then: LLVMBasicBlockRef; Catch: LLVMBasicBlockRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildInvoke';
{$ENDIF}

  //LLVMValueRef LLVMBuildLandingPad(LLVMBuilderRef B, LLVMTypeRef Ty,
  //                               LLVMValueRef PersFn, unsigned NumClauses,
  //                               const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildLandingPad = function(B: LLVMBuilderRef; Ty: LLVMTypeRef; PersFn: LLVMValueRef; NumClauses: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildLandingPad(B: LLVMBuilderRef; Ty: LLVMTypeRef; PersFn: LLVMValueRef; NumClauses: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildLandingPad';
{$ENDIF}
  //LLVMValueRef LLVMBuildResume(LLVMBuilderRef B, LLVMValueRef Exn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildResume = function(B: LLVMBuilderRef; Exn: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildResume(B: LLVMBuilderRef; Exn: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildResume';
{$ENDIF}
  //LLVMValueRef LLVMBuildUnreachable(LLVMBuilderRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildUnreachable = function(Unknown: LLVMBuilderRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildUnreachable(Unknown: LLVMBuilderRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildUnreachable';
{$ENDIF}

(* Add a case to the switch instruction *)
  //void LLVMAddCase(LLVMValueRef Switch, LLVMValueRef OnVal,
  //               LLVMBasicBlockRef Dest);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddCase = procedure(Switch: LLVMValueRef; OnVal: LLVMValueRef; Dest: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMAddCase(Switch: LLVMValueRef; OnVal: LLVMValueRef; Dest: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMAddCase';
{$ENDIF}

(* Add a destination to the indirectbr instruction *)
  //void LLVMAddDestination(LLVMValueRef IndirectBr, LLVMBasicBlockRef Dest);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddDestination = procedure(IndirectBr: LLVMValueRef; Dest: LLVMBasicBlockRef); cdecl;
{$ELSE}
  procedure LLVMAddDestination(IndirectBr: LLVMValueRef; Dest: LLVMBasicBlockRef); cdecl; external LLVMLibrary name 'LLVMAddDestination';
{$ENDIF}

(* Add a catch or filter clause to the landingpad instruction *)
  //void LLVMAddClause(LLVMValueRef LandingPad, LLVMValueRef ClauseVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddClause = procedure(LandingPad: LLVMValueRef; ClauseVal: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMAddClause(LandingPad: LLVMValueRef; ClauseVal: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMAddClause';
{$ENDIF}

(* Set the 'cleanup' flag in the landingpad instruction *)
  //void LLVMSetCleanup(LLVMValueRef LandingPad, LLVMBool Val);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetCleanup = procedure(LandingPad: LLVMValueRef; Val: LLVMBool); cdecl;
{$ELSE}
  procedure LLVMSetCleanup(LandingPad: LLVMValueRef; Val: LLVMBool); cdecl; external LLVMLibrary name 'LLVMSetCleanup';
{$ENDIF}

(* Arithmetic *)
  //LLVMValueRef LLVMBuildAdd(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildAdd = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildAdd(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildAdd';
{$ENDIF}
  //LLVMValueRef LLVMBuildNSWAdd(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNSWAdd = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNSWAdd(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNSWAdd';
{$ENDIF}
  //LLVMValueRef LLVMBuildNUWAdd(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNUWAdd = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNUWAdd(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNUWAdd';
{$ENDIF}
  //LLVMValueRef LLVMBuildFAdd(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFAdd = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFAdd(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFAdd';
{$ENDIF}
  //LLVMValueRef LLVMBuildSub(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSub = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSub(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSub';
{$ENDIF}
  //LLVMValueRef LLVMBuildNSWSub(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNSWSub = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNSWSub(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNSWSub';
{$ENDIF}
  //LLVMValueRef LLVMBuildNUWSub(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNUWSub = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNUWSub(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNUWSub';
{$ENDIF}
  //LLVMValueRef LLVMBuildFSub(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFSub = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFSub(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFSub';
{$ENDIF}
  //LLVMValueRef LLVMBuildMul(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildMul = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildMul(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildMul';
{$ENDIF}
  //LLVMValueRef LLVMBuildNSWMul(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNSWMul = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNSWMul(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNSWMul';
{$ENDIF}
  //LLVMValueRef LLVMBuildNUWMul(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNUWMul = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNUWMul(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNUWMul';
{$ENDIF}
  //LLVMValueRef LLVMBuildFMul(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFMul = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFMul(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFMul';
{$ENDIF}
  //LLVMValueRef LLVMBuildUDiv(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildUDiv = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildUDiv(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildUDiv';
{$ENDIF}
  //LLVMValueRef LLVMBuildSDiv(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSDiv = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSDiv(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSDiv';
{$ENDIF}
  //LLVMValueRef LLVMBuildExactSDiv(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                              const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildExactSDiv = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildExactSDiv(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildExactSDiv';
{$ENDIF}
  //LLVMValueRef LLVMBuildFDiv(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFDiv = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFDiv(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFDiv';
{$ENDIF}
  //LLVMValueRef LLVMBuildURem(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildURem = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildURem(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildURem';
{$ENDIF}
  //LLVMValueRef LLVMBuildSRem(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSRem = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSRem(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSRem';
{$ENDIF}
  //LLVMValueRef LLVMBuildFRem(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFRem = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFRem(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFRem';
{$ENDIF}
  //LLVMValueRef LLVMBuildShl(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildShl = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildShl(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildShl';
{$ENDIF}
  //LLVMValueRef LLVMBuildLShr(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildLShr = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildLShr(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildLShr';
{$ENDIF}
  //LLVMValueRef LLVMBuildAShr(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildAShr = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildAShr(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildAShr';
{$ENDIF}
  //LLVMValueRef LLVMBuildAnd(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildAnd = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildAnd(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildAnd';
{$ENDIF}
  //LLVMValueRef LLVMBuildOr(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildOr = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildOr(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildOr';
{$ENDIF}
  //LLVMValueRef LLVMBuildXor(LLVMBuilderRef, LLVMValueRef LHS, LLVMValueRef RHS,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildXor = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildXor(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildXor';
{$ENDIF}
  //LLVMValueRef LLVMBuildBinOp(LLVMBuilderRef B, LLVMOpcode Op,
  //                          LLVMValueRef LHS, LLVMValueRef RHS,
  //                          const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildBinOp = function(B: LLVMBuilderRef; Op: LLVMOpcode; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildBinOp(B: LLVMBuilderRef; Op: LLVMOpcode; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildBinOp';
{$ENDIF}
  //LLVMValueRef LLVMBuildNeg(LLVMBuilderRef, LLVMValueRef V, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNeg = function(Unknown: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNeg(Unknown: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNeg';
{$ENDIF}
  //LLVMValueRef LLVMBuildNSWNeg(LLVMBuilderRef B, LLVMValueRef V,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNSWNeg = function(B: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNSWNeg(B: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNSWNeg';
{$ENDIF}
  //LLVMValueRef LLVMBuildNUWNeg(LLVMBuilderRef B, LLVMValueRef V,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNUWNeg = function(B: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNUWNeg(B: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNUWNeg';
{$ENDIF}
  //LLVMValueRef LLVMBuildFNeg(LLVMBuilderRef, LLVMValueRef V, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFNeg = function(Unknown: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFNeg(Unknown: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFNeg';
{$ENDIF}
  //LLVMValueRef LLVMBuildNot(LLVMBuilderRef, LLVMValueRef V, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildNot = function(Unknown: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildNot(Unknown: LLVMBuilderRef; V: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildNot';
{$ENDIF}

(* Memory *)
  //LLVMValueRef LLVMBuildMalloc(LLVMBuilderRef, LLVMTypeRef Ty, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildMalloc = function(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildMalloc(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildMalloc';
{$ENDIF}
  //LLVMValueRef LLVMBuildArrayMalloc(LLVMBuilderRef, LLVMTypeRef Ty,
  //                                LLVMValueRef Val, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildArrayMalloc = function(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildArrayMalloc(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildArrayMalloc';
{$ENDIF}
  //LLVMValueRef LLVMBuildAlloca(LLVMBuilderRef, LLVMTypeRef Ty, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildAlloca = function(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildAlloca(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildAlloca';
{$ENDIF}
  //LLVMValueRef LLVMBuildArrayAlloca(LLVMBuilderRef, LLVMTypeRef Ty,
  //                                LLVMValueRef Val, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildArrayAlloca = function(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildArrayAlloca(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildArrayAlloca';
{$ENDIF}
  //LLVMValueRef LLVMBuildFree(LLVMBuilderRef, LLVMValueRef PointerVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFree = function(Unknown: LLVMBuilderRef; PointerVal: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFree(Unknown: LLVMBuilderRef; PointerVal: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFree';
{$ENDIF}
  //LLVMValueRef LLVMBuildLoad(LLVMBuilderRef, LLVMValueRef PointerVal,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildLoad = function(Unknown: LLVMBuilderRef; PointerVal: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildLoad(Unknown: LLVMBuilderRef; PointerVal: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildLoad';
{$ENDIF}
  //LLVMValueRef LLVMBuildStore(LLVMBuilderRef, LLVMValueRef Val, LLVMValueRef Ptr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildStore = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; Ptr: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildStore(Unknown: LLVMBuilderRef; Val: LLVMValueRef; Ptr: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildStore';
{$ENDIF}
  //LLVMValueRef LLVMBuildGEP(LLVMBuilderRef B, LLVMValueRef Pointer,
  //                        LLVMValueRef *Indices, unsigned NumIndices,
  //                        const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildGEP = function(B: LLVMBuilderRef; Pointer: LLVMValueRef; var Indices: LLVMValueRef; NumIndices: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildGEP(B: LLVMBuilderRef; Pointer: LLVMValueRef; var Indices: LLVMValueRef; NumIndices: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildGEP';
{$ENDIF}
  //LLVMValueRef LLVMBuildInBoundsGEP(LLVMBuilderRef B, LLVMValueRef Pointer,
  //                                LLVMValueRef *Indices, unsigned NumIndices,
  //                                const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildInBoundsGEP = function(B: LLVMBuilderRef; Pointer: LLVMValueRef; var Indices: LLVMValueRef; NumIndices: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildInBoundsGEP(B: LLVMBuilderRef; Pointer: LLVMValueRef; var Indices: LLVMValueRef; NumIndices: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildInBoundsGEP';
{$ENDIF}
  //LLVMValueRef LLVMBuildStructGEP(LLVMBuilderRef B, LLVMValueRef Pointer,
  //                              unsigned Idx, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildStructGEP = function(B: LLVMBuilderRef; Pointer: LLVMValueRef; Idx: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildStructGEP(B: LLVMBuilderRef; Pointer: LLVMValueRef; Idx: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildStructGEP';
{$ENDIF}
  //LLVMValueRef LLVMBuildGlobalString(LLVMBuilderRef B, const char *Str,
  //                                 const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildGlobalString = function(B: LLVMBuilderRef; Str: PAnsiChar; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildGlobalString(B: LLVMBuilderRef; Str: PAnsiChar; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildGlobalString';
{$ENDIF}
  //LLVMValueRef LLVMBuildGlobalStringPtr(LLVMBuilderRef B, const char *Str,
  //                                    const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildGlobalStringPtr = function(B: LLVMBuilderRef; Str: PAnsiChar; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildGlobalStringPtr(B: LLVMBuilderRef; Str: PAnsiChar; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildGlobalStringPtr';
{$ENDIF}
  //LLVMBool LLVMGetVolatile(LLVMValueRef MemoryAccessInst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetVolatile = function(MemoryAccessInst: LLVMValueRef): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMGetVolatile(MemoryAccessInst: LLVMValueRef): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMGetVolatile';
{$ENDIF}
  //void LLVMSetVolatile(LLVMValueRef MemoryAccessInst, LLVMBool IsVolatile);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSetVolatile = procedure(MemoryAccessInst: LLVMValueRef; IsVolatile: LLVMBool); cdecl;
{$ELSE}
  procedure LLVMSetVolatile(MemoryAccessInst: LLVMValueRef; IsVolatile: LLVMBool); cdecl; external LLVMLibrary name 'LLVMSetVolatile';
{$ENDIF}

(* Casts *)
  //LLVMValueRef LLVMBuildTrunc(LLVMBuilderRef, LLVMValueRef Val,
  //                          LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildTrunc = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildTrunc(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildTrunc';
{$ENDIF}
  //LLVMValueRef LLVMBuildZExt(LLVMBuilderRef, LLVMValueRef Val,
  //                         LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildZExt = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildZExt(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildZExt';
{$ENDIF}
  //LLVMValueRef LLVMBuildSExt(LLVMBuilderRef, LLVMValueRef Val,
  //                         LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSExt = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSExt(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSExt';
{$ENDIF}
  //LLVMValueRef LLVMBuildFPToUI(LLVMBuilderRef, LLVMValueRef Val,
  //                           LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFPToUI = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFPToUI(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFPToUI';
{$ENDIF}
  //LLVMValueRef LLVMBuildFPToSI(LLVMBuilderRef, LLVMValueRef Val,
  //                           LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFPToSI = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFPToSI(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFPToSI';
{$ENDIF}
  //LLVMValueRef LLVMBuildUIToFP(LLVMBuilderRef, LLVMValueRef Val,
  //                           LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildUIToFP = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildUIToFP(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildUIToFP';
{$ENDIF}
  //LLVMValueRef LLVMBuildSIToFP(LLVMBuilderRef, LLVMValueRef Val,
  //                           LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSIToFP = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSIToFP(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSIToFP';
{$ENDIF}
  //LLVMValueRef LLVMBuildFPTrunc(LLVMBuilderRef, LLVMValueRef Val,
  //                            LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFPTrunc = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFPTrunc(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFPTrunc';
{$ENDIF}
  //LLVMValueRef LLVMBuildFPExt(LLVMBuilderRef, LLVMValueRef Val,
  //                          LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFPExt = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFPExt(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFPExt';
{$ENDIF}
  //LLVMValueRef LLVMBuildPtrToInt(LLVMBuilderRef, LLVMValueRef Val,
  //                             LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildPtrToInt = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildPtrToInt(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildPtrToInt';
{$ENDIF}
  //LLVMValueRef LLVMBuildIntToPtr(LLVMBuilderRef, LLVMValueRef Val,
  //                             LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildIntToPtr = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildIntToPtr(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildIntToPtr';
{$ENDIF}
  //LLVMValueRef LLVMBuildBitCast(LLVMBuilderRef, LLVMValueRef Val,
  //                            LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildBitCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildBitCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildBitCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildZExtOrBitCast(LLVMBuilderRef, LLVMValueRef Val,
  //                                  LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildZExtOrBitCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildZExtOrBitCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildZExtOrBitCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildSExtOrBitCast(LLVMBuilderRef, LLVMValueRef Val,
  //                                  LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSExtOrBitCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSExtOrBitCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSExtOrBitCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildTruncOrBitCast(LLVMBuilderRef, LLVMValueRef Val,
  //                                   LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildTruncOrBitCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildTruncOrBitCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildTruncOrBitCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildCast(LLVMBuilderRef B, LLVMOpcode Op, LLVMValueRef Val,
  //                         LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildPointerCast(LLVMBuilderRef, LLVMValueRef Val,
  //                                LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildPointerCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildPointerCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildPointerCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildIntCast(LLVMBuilderRef, LLVMValueRef Val, (*Signed cast!*)
  //                            LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildIntCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildIntCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildIntCast';
{$ENDIF}
  //LLVMValueRef LLVMBuildFPCast(LLVMBuilderRef, LLVMValueRef Val,
  //                           LLVMTypeRef DestTy, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFPCast = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFPCast(Unknown: LLVMBuilderRef; Val: LLVMValueRef; DestTy: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFPCast';
{$ENDIF}

(* Comparisons *)
  //LLVMValueRef LLVMBuildICmp(LLVMBuilderRef, LLVMIntPredicate Op,
  //                         LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildICmp = function(Unknown: LLVMBuilderRef; Op: LLVMIntPredicate; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildICmp(Unknown: LLVMBuilderRef; Op: LLVMIntPredicate; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildICmp';
{$ENDIF}
  //LLVMValueRef LLVMBuildFCmp(LLVMBuilderRef, LLVMRealPredicate Op,
  //                         LLVMValueRef LHS, LLVMValueRef RHS,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildFCmp = function(Unknown: LLVMBuilderRef; Op: LLVMRealPredicate; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildFCmp(Unknown: LLVMBuilderRef; Op: LLVMRealPredicate; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildFCmp';
{$ENDIF}

(* Miscellaneous instructions *)
  //LLVMValueRef LLVMBuildPhi(LLVMBuilderRef, LLVMTypeRef Ty, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildPhi = function(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildPhi(Unknown: LLVMBuilderRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildPhi';
{$ENDIF}
  //LLVMValueRef LLVMBuildCall(LLVMBuilderRef, LLVMValueRef Fn,
  //                         LLVMValueRef *Args, unsigned NumArgs,
  //                         const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildCall = function(Unknown: LLVMBuilderRef; Fn: LLVMValueRef; var Args: LLVMValueRef; NumArgs: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildCall(Unknown: LLVMBuilderRef; Fn: LLVMValueRef; var Args: LLVMValueRef; NumArgs: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildCall';
{$ENDIF}
  //LLVMValueRef LLVMBuildSelect(LLVMBuilderRef, LLVMValueRef If,
  //                           LLVMValueRef Then, LLVMValueRef Else,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildSelect = function(Unknown: LLVMBuilderRef; _If: LLVMValueRef; _Then: LLVMValueRef; _Else: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildSelect(Unknown: LLVMBuilderRef; _If: LLVMValueRef; _Then: LLVMValueRef; _Else: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildSelect';
{$ENDIF}
  //LLVMValueRef LLVMBuildVAArg(LLVMBuilderRef, LLVMValueRef List, LLVMTypeRef Ty,
  //                          const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildVAArg = function(Unknown: LLVMBuilderRef; List: LLVMValueRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildVAArg(Unknown: LLVMBuilderRef; List: LLVMValueRef; Ty: LLVMTypeRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildVAArg';
{$ENDIF}
  //LLVMValueRef LLVMBuildExtractElement(LLVMBuilderRef, LLVMValueRef VecVal,
  //                                   LLVMValueRef Index, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildExtractElement = function(Unknown: LLVMBuilderRef; VecVal: LLVMValueRef; Index: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildExtractElement(Unknown: LLVMBuilderRef; VecVal: LLVMValueRef; Index: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildExtractElement';
{$ENDIF}
  //LLVMValueRef LLVMBuildInsertElement(LLVMBuilderRef, LLVMValueRef VecVal,
  //                                  LLVMValueRef EltVal, LLVMValueRef Index,
  //                                  const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildInsertElement = function(Unknown: LLVMBuilderRef; VecVal: LLVMValueRef; EltVal: LLVMValueRef; Index: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildInsertElement(Unknown: LLVMBuilderRef; VecVal: LLVMValueRef; EltVal: LLVMValueRef; Index: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildInsertElement';
{$ENDIF}
  //LLVMValueRef LLVMBuildShuffleVector(LLVMBuilderRef, LLVMValueRef V1,
  //                                  LLVMValueRef V2, LLVMValueRef Mask,
  //                                  const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildShuffleVector = function(Unknown: LLVMBuilderRef; V1: LLVMValueRef; V2: LLVMValueRef; Mask: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildShuffleVector(Unknown: LLVMBuilderRef; V1: LLVMValueRef; V2: LLVMValueRef; Mask: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildShuffleVector';
{$ENDIF}
  //LLVMValueRef LLVMBuildExtractValue(LLVMBuilderRef, LLVMValueRef AggVal,
  //                                 unsigned Index, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildExtractValue = function(Unknown: LLVMBuilderRef; AggVal: LLVMValueRef; Index: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildExtractValue(Unknown: LLVMBuilderRef; AggVal: LLVMValueRef; Index: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildExtractValue';
{$ENDIF}
  //LLVMValueRef LLVMBuildInsertValue(LLVMBuilderRef, LLVMValueRef AggVal,
  //                                LLVMValueRef EltVal, unsigned Index,
  //                                const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildInsertValue = function(Unknown: LLVMBuilderRef; AggVal: LLVMValueRef; EltVal: LLVMValueRef; Index: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildInsertValue(Unknown: LLVMBuilderRef; AggVal: LLVMValueRef; EltVal: LLVMValueRef; Index: Cardinal; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildInsertValue';
{$ENDIF}

  //LLVMValueRef LLVMBuildIsNull(LLVMBuilderRef, LLVMValueRef Val,
  //                           const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildIsNull = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildIsNull(Unknown: LLVMBuilderRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildIsNull';
{$ENDIF}
  //LLVMValueRef LLVMBuildIsNotNull(LLVMBuilderRef, LLVMValueRef Val,
  //                              const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildIsNotNull = function(Unknown: LLVMBuilderRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildIsNotNull(Unknown: LLVMBuilderRef; Val: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildIsNotNull';
{$ENDIF}
  //LLVMValueRef LLVMBuildPtrDiff(LLVMBuilderRef, LLVMValueRef LHS,
  //                            LLVMValueRef RHS, const char *Name);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMBuildPtrDiff = function(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl;
{$ELSE}
  function LLVMBuildPtrDiff(Unknown: LLVMBuilderRef; LHS: LLVMValueRef; RHS: LLVMValueRef; Name: PAnsiChar): LLVMValueRef; cdecl; external LLVMLibrary name 'LLVMBuildPtrDiff';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreModuleProvider Module Providers
 *
 * @{
 *)

(*
 * Changes the type of M so it can be passed to FunctionPassManagers and the
 * JIT.  They take ModuleProviders for historical reasons.
 *)
  //LLVMModuleProviderRef
  //LLVMCreateModuleProviderForExistingModule(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateModuleProviderForExistingModule = function(M: LLVMModuleRef): LLVMModuleProviderRef; cdecl;
{$ELSE}
  function LLVMCreateModuleProviderForExistingModule(M: LLVMModuleRef): LLVMModuleProviderRef; cdecl; external LLVMLibrary name 'LLVMCreateModuleProviderForExistingModule';
{$ENDIF}
  
(*
 * Destroys the module M.
 *)
  //void LLVMDisposeModuleProvider(LLVMModuleProviderRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeModuleProvider = procedure(M: LLVMModuleProviderRef); cdecl;
{$ELSE}
  procedure LLVMDisposeModuleProvider(M: LLVMModuleProviderRef); cdecl; external LLVMLibrary name 'LLVMDisposeModuleProvider';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCoreMemoryBuffers Memory Buffers
 *
 * @{
 *)

  //LLVMBool LLVMCreateMemoryBufferWithContentsOfFile(const char *Path,
  //                                                LLVMMemoryBufferRef *OutMemBuf,
  //                                                char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateMemoryBufferWithContentsOfFile = function(Path: PAnsiChar; var OutMemBuf: LLVMMemoryBufferRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateMemoryBufferWithContentsOfFile(Path: PAnsiChar; var OutMemBuf: LLVMMemoryBufferRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMCreateMemoryBufferWithContentsOfFile';
{$ENDIF}
  //LLVMBool LLVMCreateMemoryBufferWithSTDIN(LLVMMemoryBufferRef *OutMemBuf,
  //                                       char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateMemoryBufferWithSTDIN = function(var OutMemBuf: LLVMMemoryBufferRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateMemoryBufferWithSTDIN(var OutMemBuf: LLVMMemoryBufferRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMCreateMemoryBufferWithSTDIN';
{$ENDIF}
  //void LLVMDisposeMemoryBuffer(LLVMMemoryBufferRef MemBuf);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeMemoryBuffer = procedure(MemBuf: LLVMMemoryBufferRef); cdecl;
{$ELSE}
  procedure LLVMDisposeMemoryBuffer(MemBuf: LLVMMemoryBufferRef); cdecl; external LLVMLibrary name 'LLVMDisposeMemoryBuffer';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCorePassRegistry Pass Registry
 *
 * @{
 *)

(* Return the global pass registry, for use with initialization functions.
    @see llvm::PassRegistry::getPassRegistry *)
  //LLVMPassRegistryRef LLVMGetGlobalPassRegistry(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetGlobalPassRegistry = function(): LLVMPassRegistryRef; cdecl;
{$ELSE}
  function LLVMGetGlobalPassRegistry(): LLVMPassRegistryRef; cdecl; external LLVMLibrary name 'LLVMGetGlobalPassRegistry';
{$ENDIF}

(*
 * @}
 *)

(*
 * @defgroup LLVMCCorePassManagers Pass Managers
 *
 * @{
 *)

(* Constructs a new whole-module pass pipeline. This type of pipeline is
    suitable for link-time optimization and whole-module transformations.
    @see llvm::PassManager::PassManager *)
  //LLVMPassManagerRef LLVMCreatePassManager(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreatePassManager = function(): LLVMPassManagerRef; cdecl;
{$ELSE}
  function LLVMCreatePassManager(): LLVMPassManagerRef; cdecl; external LLVMLibrary name 'LLVMCreatePassManager';
{$ENDIF}

(* Constructs a new function-by-function pass pipeline over the module
    provider. It does not take ownership of the module provider. This type of
    pipeline is suitable for code generation and JIT compilation tasks.
    @see llvm::FunctionPassManager::FunctionPassManager *)
  //LLVMPassManagerRef LLVMCreateFunctionPassManagerForModule(LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateFunctionPassManagerForModule = function(M: LLVMModuleRef): LLVMPassManagerRef; cdecl;
{$ELSE}
  function LLVMCreateFunctionPassManagerForModule(M: LLVMModuleRef): LLVMPassManagerRef; cdecl; external LLVMLibrary name 'LLVMCreateFunctionPassManagerForModule';
{$ENDIF}

(* Deprecated: Use LLVMCreateFunctionPassManagerForModule instead. *)
  //LLVMPassManagerRef LLVMCreateFunctionPassManager(LLVMModuleProviderRef MP);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateFunctionPassManager = function(MP: LLVMModuleProviderRef): LLVMPassManagerRef; cdecl;
{$ELSE}
  function LLVMCreateFunctionPassManager(MP: LLVMModuleProviderRef): LLVMPassManagerRef; cdecl; external LLVMLibrary name 'LLVMCreateFunctionPassManager';
{$ENDIF}

(* Initializes, executes on the provided module, and finalizes all of the
    passes scheduled in the pass manager. Returns 1 if any of the passes
    modified the module, 0 otherwise.
    @see llvm::PassManager::run(Module&) *)
  //LLVMBool LLVMRunPassManager(LLVMPassManagerRef PM, LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRunPassManager = function(FPM: LLVMPassManagerRef; M: LLVMModuleRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMRunPassManager(FPM: LLVMPassManagerRef; M: LLVMModuleRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMRunPassManager';
{$ENDIF}

(* Initializes all of the function passes scheduled in the function pass
    manager. Returns 1 if any of the passes modified the module, 0 otherwise.
    @see llvm::FunctionPassManager::doInitialization *)
  //LLVMBool LLVMInitializeFunctionPassManager(LLVMPassManagerRef FPM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeFunctionPassManager = function(FPM: LLVMPassManagerRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMInitializeFunctionPassManager(FPM: LLVMPassManagerRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMInitializeFunctionPassManager';
{$ENDIF}

(* Executes all of the function passes scheduled in the function pass manager
    on the provided function. Returns 1 if any of the passes modified the
    function, false otherwise.
    @see llvm::FunctionPassManager::run(Function&) *)
  //LLVMBool LLVMRunFunctionPassManager(LLVMPassManagerRef FPM, LLVMValueRef F);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRunFunctionPassManager = function(FPM: LLVMPassManagerRef; F: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMRunFunctionPassManager(FPM: LLVMPassManagerRef; F: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMRunFunctionPassManager';
{$ENDIF}

(* Finalizes all of the function passes scheduled in in the function pass
    manager. Returns 1 if any of the passes modified the module, 0 otherwise.
    @see llvm::FunctionPassManager::doFinalization *)
  //LLVMBool LLVMFinalizeFunctionPassManager(LLVMPassManagerRef FPM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFinalizeFunctionPassManager = function(FPM: LLVMPassManagerRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMFinalizeFunctionPassManager(FPM: LLVMPassManagerRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMFinalizeFunctionPassManager';
{$ENDIF}

(* Frees the memory of a pass pipeline. For function pipelines, does not free
    the module provider.
    @see llvm::PassManagerBase::~PassManagerBase. *)
  //void LLVMDisposePassManager(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposePassManager = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMDisposePassManager(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMDisposePassManager';
{$ENDIF}

(*
namespace llvm {
  class MemoryBuffer;
  class PassManagerBase;
  
  #define DEFINE_SIMPLE_CONVERSION_FUNCTIONS(ty, ref)   \
    inline ty *unwrap(ref P) {                          \
      return reinterpret_cast<ty*>(P);                  \
    }                                                   \
                                                        \
    inline ref wrap(const ty *P) {                      \
      return reinterpret_cast<ref>(const_cast<ty*>(P)); \
    }
  
  #define DEFINE_ISA_CONVERSION_FUNCTIONS(ty, ref)  \
    DEFINE_SIMPLE_CONVERSION_FUNCTIONS(ty, ref)         \
                                                        \
    template<typename T>                                \
    inline T *unwrap(ref P) {                           \
      return cast<T>(unwrap(P));                        \
    }
  
  #define DEFINE_STDCXX_CONVERSION_FUNCTIONS(ty, ref)   \
    DEFINE_SIMPLE_CONVERSION_FUNCTIONS(ty, ref)         \
                                                        \
    template<typename T>                                \
    inline T *unwrap(ref P) {                           \
      T*Q = (T.)unwrap(P);                             \
      assert(Q && "Invalid cast!");                     \
      return Q;                                         \
    }
  
  DEFINE_ISA_CONVERSION_FUNCTIONS   (Type,               LLVMTypeRef          )
  DEFINE_ISA_CONVERSION_FUNCTIONS   (Value,              LLVMValueRef         )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(Module,             LLVMModuleRef        )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(BasicBlock,         LLVMBasicBlockRef    )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(IRBuilder<>,        LLVMBuilderRef       )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(MemoryBuffer,       LLVMMemoryBufferRef  )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(LLVMContext,        LLVMContextRef       )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(Use,                LLVMUseRef           )
  DEFINE_STDCXX_CONVERSION_FUNCTIONS(PassManagerBase,    LLVMPassManagerRef   )
  DEFINE_STDCXX_CONVERSION_FUNCTIONS(PassRegistry,       LLVMPassRegistryRef  )
  // LLVMModuleProviderRef exists for historical reasons, but now just holds a Module.
  inline Module *unwrap(LLVMModuleProviderRef MP) {
    return reinterpret_cast<Module*>(MP);
  }
  
  #undef DEFINE_STDCXX_CONVERSION_FUNCTIONS
  #undef DEFINE_ISA_CONVERSION_FUNCTIONS
  #undef DEFINE_SIMPLE_CONVERSION_FUNCTIONS

  // Specialized opaque context conversions.
  inline LLVMContext **unwrap(LLVMContextRef* Tys) {
    return reinterpret_cast<LLVMContext**>(Tys);
  }
  
  inline LLVMContextRef *wrap(const LLVMContext **Tys) {
    return reinterpret_cast<LLVMContextRef*>(const_cast<LLVMContext**>(Tys));
  }
  
  // Specialized opaque type conversions.
  inline Type **unwrap(LLVMTypeRef* Tys) {
    return reinterpret_cast<Type**>(Tys);
  }
  
  inline LLVMTypeRef *wrap(Type **Tys) {
    return reinterpret_cast<LLVMTypeRef*>(const_cast<Type**>(Tys));
  }
  
  // Specialized opaque value conversions.
  inline Value **unwrap(LLVMValueRef *Vals) {
    return reinterpret_cast<Value**>(Vals);
  }
  
  template<typename T>
  inline T **unwrap(LLVMValueRef *Vals, unsigned Length) {
    #if DEBUG
    for (LLVMValueRef *I = Vals, *E = Vals + Length; I != E; ++I)
      cast<T>(*I);
    #endif
    (void)Length;
    return reinterpret_cast<T**>(Vals);
  }
  
  inline LLVMValueRef *wrap(const Value **Vals) {
    return reinterpret_cast<LLVMValueRef*>(const_cast<Value**>(Vals));
  }
}
*)

{$ENDIF}
//*------------------------------------------------- END of Core.h -------------------------------------------------*//

//*================================================= START of Analysis.h =================================================*//
{$IFDEF LLVM_API_ANALYSIS}

type
(*
typedef enum {
  LLVMAbortProcessAction, /* verifier will print to stderr and abort() */
  LLVMPrintMessageAction, /* verifier will print to stderr and return 1 */
  LLVMReturnStatusAction  /* verifier will just return 1 */
} LLVMVerifierFailureAction;
*)
  LLVMVerifierFailureAction = (
    LLVMAbortProcessAction, (* verifier will print to stderr and abort() *)
    LLVMPrintMessageAction, (* verifier will print to stderr and return 1 *)
    LLVMReturnStatusAction  (* verifier will just return 1 *)
  );

(* Verifies that a module is valid, taking the specified action if not.
   Optionally returns a human-readable description of any invalid constructs.
   OutMessage must be disposed with LLVMDisposeMessage. *)
  //LLVMBool LLVMVerifyModule(LLVMModuleRef M, LLVMVerifierFailureAction Action, char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMVerifyModule = function(M: LLVMModuleRef; Action: LLVMVerifierFailureAction; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMVerifyModule(M: LLVMModuleRef; Action: LLVMVerifierFailureAction; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMVerifyModule';
{$ENDIF}

(* Verifies that a single function is valid, taking the specified action. Useful
   for debugging. *)
  //LLVMBool LLVMVerifyFunction(LLVMValueRef Fn, LLVMVerifierFailureAction Action);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMVerifyFunction = function(Fn: LLVMValueRef; Action: LLVMVerifierFailureAction): LLVMBool; cdecl;
{$ELSE}
  function LLVMVerifyFunction(Fn: LLVMValueRef; Action: LLVMVerifierFailureAction): LLVMBool; cdecl; external LLVMLibrary name 'LLVMVerifyFunction';
{$ENDIF}

(* Open up a ghostview window that displays the CFG of the current function.
   Useful for debugging. *)
  //void LLVMViewFunctionCFG(LLVMValueRef Fn);
  //void LLVMViewFunctionCFGOnly(LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMViewFunctionCFG = procedure(Fn: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMViewFunctionCFG(Fn: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMViewFunctionCFG';
{$ENDIF}
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMViewFunctionCFGOnly = procedure(Fn: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMViewFunctionCFGOnly(Fn: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMViewFunctionCFGOnly';
{$ENDIF}
 
{$ENDIF}
//*------------------------------------------------- END of Analysis.h -------------------------------------------------*//


//*================================================= START of BitReader.h =================================================*//
{$IFDEF LLVM_API_BITREADER}

(* Builds a module from the bitcode in the specified memory buffer, returning a
   reference to the module via the OutModule parameter. Returns 0 on success.
   Optionally returns a human-readable error message via OutMessage. *)
  //LLVMBool LLVMParseBitcode(LLVMMemoryBufferRef MemBuf, LLVMModuleRef *OutModule, char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMParseBitcode = function(MemBuf: LLVMMemoryBufferRef; var OutModule: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMParseBitcode(MemBuf: LLVMMemoryBufferRef; var OutModule: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMParseBitcode';
{$ENDIF}

  //LLVMBool LLVMParseBitcodeInContext(LLVMContextRef ContextRef,
  //                                 LLVMMemoryBufferRef MemBuf,
  //                                 LLVMModuleRef *OutModule, char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMParseBitcodeInContext = function(ContextRef: LLVMContextRef; MemBuf: LLVMMemoryBufferRef; var OutModule: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMParseBitcodeInContext(ContextRef: LLVMContextRef; MemBuf: LLVMMemoryBufferRef; var OutModule: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMParseBitcodeInContext';
{$ENDIF}
  

(* Reads a module from the specified path, returning via the OutMP parameter
   a module provider which performs lazy deserialization. Returns 0 on success.
   Optionally returns a human-readable error message via OutMessage. *)
  //LLVMBool LLVMGetBitcodeModuleInContext(LLVMContextRef ContextRef,
  //                                     LLVMMemoryBufferRef MemBuf,
  //                                     LLVMModuleRef *OutM,
  //                                     char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBitcodeModuleInContext = function(ContextRef: LLVMContextRef; MemBuf: LLVMMemoryBufferRef; var OutM: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMGetBitcodeModuleInContext(ContextRef: LLVMContextRef; MemBuf: LLVMMemoryBufferRef; var OutM: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMGetBitcodeModuleInContext';
{$ENDIF}

  //LLVMBool LLVMGetBitcodeModule(LLVMMemoryBufferRef MemBuf, LLVMModuleRef *OutM, char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBitcodeModule = function(MemBuf: LLVMMemoryBufferRef; var OutM: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMGetBitcodeModule(MemBuf: LLVMMemoryBufferRef; var OutM: LLVMModuleRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMGetBitcodeModule';
{$ENDIF}

(* Deprecated: Use LLVMGetBitcodeModuleInContext instead. *)
  //LLVMBool LLVMGetBitcodeModuleProviderInContext(LLVMContextRef ContextRef,
  //                                             LLVMMemoryBufferRef MemBuf,
  //                                             LLVMModuleProviderRef *OutMP,
  //                                             char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBitcodeModuleProviderInContext = function(ContextRef: LLVMContextRef; MemBuf: LLVMMemoryBufferRef; var OutMP: LLVMModuleProviderRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMGetBitcodeModuleProviderInContext(ContextRef: LLVMContextRef; MemBuf: LLVMMemoryBufferRef; var OutMP: LLVMModuleProviderRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMGetBitcodeModuleProviderInContext';
{$ENDIF}

(* Deprecated: Use LLVMGetBitcodeModule instead. *)
  //LLVMBool LLVMGetBitcodeModuleProvider(LLVMMemoryBufferRef MemBuf,
  //                                    LLVMModuleProviderRef *OutMP,
  //                                    char **OutMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetBitcodeModuleProvider = function(MemBuf: LLVMMemoryBufferRef; var OutMP: LLVMModuleProviderRef; var OutMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMGetBitcodeModuleProvider(MemBuf: LLVMMemoryBufferRef; var OutMP: LLVMModuleProviderRef; var OutMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMGetBitcodeModuleProvider';
{$ENDIF}
  
{$ENDIF}
//*------------------------------------------------- END of BitReader.h -------------------------------------------------*//


//*================================================= START of BitWriter.h =================================================*//
{$IFDEF LLVM_API_BITWRITER}

(* Writes a module to the specified path. Returns 0 on success. *)
  //int LLVMWriteBitcodeToFile(LLVMModuleRef M, const char *Path);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMWriteBitcodeToFile = function(M: LLVMModuleRef; Path: PAnsiChar): Integer; cdecl;
{$ELSE}
  function LLVMWriteBitcodeToFile(M: LLVMModuleRef; Path: PAnsiChar): Integer; cdecl; external LLVMLibrary name 'LLVMWriteBitcodeToFile';
{$ENDIF}

(* Writes a module to an open file descriptor. Returns 0 on success. *)
  //int LLVMWriteBitcodeToFD(LLVMModuleRef M, int FD, int ShouldClose,
  //                       int Unbuffered);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMWriteBitcodeToFD = function(M: LLVMModuleRef; FD: Integer; ShouldClose: Integer; Unbuffered: Integer): Integer; cdecl;
{$ELSE}
  function LLVMWriteBitcodeToFD(M: LLVMModuleRef; FD: Integer; ShouldClose: Integer; Unbuffered: Integer): Integer; cdecl; external LLVMLibrary name 'LLVMWriteBitcodeToFD';
{$ENDIF}

(* Deprecated for LLVMWriteBitcodeToFD. Writes a module to an open file
   descriptor. Returns 0 on success. Closes the Handle. *)
  //int LLVMWriteBitcodeToFileHandle(LLVMModuleRef M, int Handle);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMWriteBitcodeToFileHandle = function(M: LLVMModuleRef; Handle: Integer): Integer;
{$ELSE}
  function LLVMWriteBitcodeToFileHandle(M: LLVMModuleRef; Handle: Integer): Integer; external LLVMLibrary name 'LLVMWriteBitcodeToFileHandle';
{$ENDIF}

{$ENDIF}
//*------------------------------------------------- END of BitWriter.h -------------------------------------------------*//


//*================================================= START of Initialization.h =================================================*//
{$IFDEF LLVM_API_INITIALIZATION}

  //void LLVMInitializeCore(LLVMPassRegistryRef R);
  // #WARNING: Redeclaration! Renamed to TLLVMInitializeCore_
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeCore_ = procedure(R: LLVMPassRegistryRef); cdecl;
{$ELSE}
  procedure LLVMInitializeCore_(R: LLVMPassRegistryRef); cdecl; external LLVMLibrary name 'LLVMInitializeCore';
{$ENDIF}

  //void LLVMInitializeTransformUtils(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeTransformUtils = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeTransformUtils(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeTransformUtils';
{$ENDIF}

  //void LLVMInitializeScalarOpts(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeScalarOpts = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeScalarOpts(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeScalarOpts';
{$ENDIF}

  //void LLVMInitializeVectorization(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeVectorization = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeVectorization(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeVectorization';
{$ENDIF}

  //void LLVMInitializeInstCombine(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeInstCombine = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeInstCombine(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeInstCombine';
{$ENDIF}

  //void LLVMInitializeIPO(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeIPO = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeIPO(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeIPO';
{$ENDIF}

  //void LLVMInitializeInstrumentation(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeInstrumentation = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeInstrumentation(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeInstrumentation';
{$ENDIF}

  //void LLVMInitializeAnalysis(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAnalysis = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeAnalysis(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeAnalysis';
{$ENDIF}

  //void LLVMInitializeIPA(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeIPA = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeIPA(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeIPA';
{$ENDIF}

  //void LLVMInitializeCodeGen(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeCodeGen = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeCodeGen(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeCodeGen';
{$ENDIF}

  //void LLVMInitializeTarget(LLVMPassRegistryRef R);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeTarget = procedure(R: LLVMPassRegistryRef); cdecl; 
{$ELSE}
  procedure LLVMInitializeTarget(R: LLVMPassRegistryRef); cdecl;  external LLVMLibrary name 'LLVMInitializeTarget';
{$ENDIF}

{$ENDIF}
//*------------------------------------------------- END of Initialization.h -------------------------------------------------*//
  
  
//*================================================= START of LinkTimeOptimizer.h =================================================*//
{$IFDEF LLVM_API_LINKTIMEOPTIMIZER}

type
  (* This provides a dummy type for pointers to the LTO object. *)
  //typedef void* llvm_lto_t;
  llvm_lto_t = Pointer;

  (* This provides a C-visible enumerator to manage status codes.
     This should map exactly onto the C++ enumerator LTOStatus. *)
  (*
  typedef enum llvm_lto_status {
    LLVM_LTO_UNKNOWN,
    LLVM_LTO_OPT_SUCCESS,
    LLVM_LTO_READ_SUCCESS,
    LLVM_LTO_READ_FAILURE,
    LLVM_LTO_WRITE_FAILURE,
    LLVM_LTO_NO_TARGET,
    LLVM_LTO_NO_WORK,
    LLVM_LTO_MODULE_MERGE_FAILURE,
    LLVM_LTO_ASM_FAILURE,
    LLVM_LTO_NULL_OBJECT
  } llvm_lto_status_t; *)
  llvm_lto_status_t = (
    LLVM_LTO_UNKNOWN,
    LLVM_LTO_OPT_SUCCESS,
    LLVM_LTO_READ_SUCCESS,
    LLVM_LTO_READ_FAILURE,
    LLVM_LTO_WRITE_FAILURE,
    LLVM_LTO_NO_TARGET,
    LLVM_LTO_NO_WORK,
    LLVM_LTO_MODULE_MERGE_FAILURE,
    LLVM_LTO_ASM_FAILURE,
    //  Added C-specific error codes
    LLVM_LTO_NULL_OBJECT
  );
 
  (* This provides C interface to initialize link time optimizer. This allows
     linker to use dlopen() interface to dynamically load LinkTimeOptimizer.
     extern "C" helps, because dlopen() interface uses name to find the symbol. *)
  //extern llvm_lto_t llvm_create_optimizer(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tllvm_create_optimizer = function: llvm_lto_t; cdecl;
{$ELSE}
  function llvm_create_optimizer: llvm_lto_t; cdecl; external LLVMLibrary name 'llvm_create_optimizer';
{$ENDIF}
  
  //extern void llvm_destroy_optimizer(llvm_lto_t lto);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tllvm_destroy_optimizer = procedure(lto: llvm_lto_t); cdecl;
{$ELSE}
  procedure llvm_destroy_optimizer(lto: llvm_lto_t); cdecl; external LLVMLibrary name 'llvm_destroy_optimizer';
{$ENDIF}

  //extern llvm_lto_status_t llvm_read_object_file
  //  (llvm_lto_t lto, const char* input_filename);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tllvm_read_object_file = function(lto: llvm_lto_t; const input_filename: PAnsiChar): llvm_lto_status_t; cdecl;
{$ELSE}
  function llvm_read_object_file(lto: llvm_lto_t; const input_filename: PAnsiChar): llvm_lto_status_t; cdecl; external LLVMLibrary name 'llvm_read_object_file';
{$ENDIF}
  
  //extern llvm_lto_status_t llvm_optimize_modules
  //  (llvm_lto_t lto, const char* output_filename);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tllvm_optimize_modules = function(lto: llvm_lto_t; const input_filename: PAnsiChar): llvm_lto_status_t; cdecl;
{$ELSE}
  function llvm_optimize_modules(lto: llvm_lto_t; const input_filename: PAnsiChar): llvm_lto_status_t; cdecl; external LLVMLibrary name 'llvm_optimize_modules';
{$ENDIF}
  
{$ENDIF}
//*------------------------------------------------- END of LinkTimeOptimizer.h -------------------------------------------------*//


//*================================================= START of Target.h =================================================*//
{$IFDEF LLVM_API_TARGET}

type
//enum LLVMByteOrdering { LLVMBigEndian, LLVMLittleEndian };
  LLVMByteOrdering = (
    LLVMBigEndian,
	LLVMLittleEndian
  );

//typedef struct LLVMOpaqueTargetData *LLVMTargetDataRef;
  LLVMOpaqueTargetData = packed record
  end;
  LLVMTargetDataRef = ^LLVMOpaqueTargetData;
//typedef struct LLVMOpaqueTargetLibraryInfotData *LLVMTargetLibraryInfoRef;
  LLVMOpaqueTargetLibraryInfotData = packed record
  end;
  LLVMTargetLibraryInfoRef = ^LLVMOpaqueTargetLibraryInfotData;
//typedef struct LLVMStructLayout *LLVMStructLayoutRef;
  LLVMStructLayout = packed record
  end;
  LLVMStructLayoutRef = ^LLVMStructLayout;

(*
// Declare all of the target-initialization functions that are available. 
#define LLVM_TARGET(TargetName) \
  void LLVMInitialize##TargetName##TargetInfo(void);
#include "llvm/Config/Targets.def"
#undef LLVM_TARGET  // Explicit undef to make SWIG happier 
  
#define LLVM_TARGET(TargetName) void LLVMInitialize##TargetName##Target(void);
#include "llvm/Config/Targets.def"
#undef LLVM_TARGET  // Explicit undef to make SWIG happier 

#define LLVM_TARGET(TargetName) \
  void LLVMInitialize##TargetName##TargetMC(void);
#include "llvm/Config/Targets.def"
#undef LLVM_TARGET  // Explicit undef to make SWIG happier 
  
// Declare all of the available assembly printer initialization functions. 
#define LLVM_ASM_PRINTER(TargetName) \
  void LLVMInitialize##TargetName##AsmPrinter();
#include "llvm/Config/AsmPrinters.def"
#undef LLVM_ASM_PRINTER  // Explicit undef to make SWIG happier 

// Declare all of the available assembly parser initialization functions. 
#define LLVM_ASM_PARSER(TargetName) \
  void LLVMInitialize##TargetName##AsmParser();
#include "llvm/Config/AsmParsers.def"
#undef LLVM_ASM_PARSER  // Explicit undef to make SWIG happier 

// Declare all of the available disassembler initialization functions. 
#define LLVM_DISASSEMBLER(TargetName) \
  void LLVMInitialize##TargetName##Disassembler();
#include "llvm/Config/Disassemblers.def"
#undef LLVM_DISASSEMBLER  // Explicit undef to make SWIG happier 
*)
  
(** LLVMInitializeAllTargetInfos - The main program should call this function if
    it wants access to all available targets that LLVM is configured to
    support. *)
  //static inline void LLVMInitializeAllTargetInfos(void) {
  //#define LLVM_TARGET(TargetName) LLVMInitialize##TargetName##TargetInfo();
  //#include "llvm/Config/Targets.def"
  //#undef LLVM_TARGET  // Explicit undef to make SWIG happier 
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAllTargetInfos = procedure(); cdecl;
{$ELSE}
  procedure LLVMInitializeAllTargetInfos(); cdecl; external LLVMLibrary name 'LLVMInitializeAllTargetInfosDL';
{$ENDIF}

(** LLVMInitializeAllTargets - The main program should call this function if it
    wants to link in all available targets that LLVM is configured to
    support. *)
  //static inline void LLVMInitializeAllTargets(void) {
  //#define LLVM_TARGET(TargetName) LLVMInitialize##TargetName##Target();
  //#include "llvm/Config/Targets.def"
  //#undef LLVM_TARGET  // Explicit undef to make SWIG happier 
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAllTargets = procedure(); cdecl;
{$ELSE}
  procedure LLVMInitializeAllTargets(); cdecl; external LLVMLibrary name 'LLVMInitializeAllTargetsDL';
{$ENDIF}

(** LLVMInitializeAllTargetMCs - The main program should call this function if
    it wants access to all available target MC that LLVM is configured to
    support. *)
  //static inline void LLVMInitializeAllTargetMCs(void) {
  //#define LLVM_TARGET(TargetName) LLVMInitialize##TargetName##TargetMC();
  //#include "llvm/Config/Targets.def"
  //#undef LLVM_TARGET  // Explicit undef to make SWIG happier
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAllTargetMCs = procedure(); cdecl;
{$ELSE}
  procedure LLVMInitializeAllTargetMCs(); cdecl; external LLVMLibrary name 'LLVMInitializeAllTargetMCsDL';
{$ENDIF}

(** LLVMInitializeAllAsmPrinters - The main program should call this function if
    it wants all asm printers that LLVM is configured to support, to make them
    available via the TargetRegistry. *)
  //static inline void LLVMInitializeAllAsmPrinters() {
  //#define LLVM_ASM_PRINTER(TargetName) LLVMInitialize##TargetName##AsmPrinter();
  //#include "llvm/Config/AsmPrinters.def"
  //#undef LLVM_ASM_PRINTER  // Explicit undef to make SWIG happier 
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAllAsmPrinters = procedure(); cdecl;
{$ELSE}
  procedure LLVMInitializeAllAsmPrinters(); cdecl; external LLVMLibrary name 'LLVMInitializeAllAsmPrintersDL';
{$ENDIF}

(** LLVMInitializeAllAsmParsers - The main program should call this function if
    it wants all asm parsers that LLVM is configured to support, to make them
    available via the TargetRegistry. *)
  //static inline void LLVMInitializeAllAsmParsers() {
  //#define LLVM_ASM_PARSER(TargetName) LLVMInitialize##TargetName##AsmParser();
  //#include "llvm/Config/AsmParsers.def"
  //#undef LLVM_ASM_PARSER  // Explicit undef to make SWIG happier 
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAllAsmParsers = procedure(); cdecl;
{$ELSE}
  procedure LLVMInitializeAllAsmParsers(); cdecl; external LLVMLibrary name 'LLVMInitializeAllAsmParsersDL';
{$ENDIF}

(** LLVMInitializeAllDisassemblers - The main program should call this function
    if it wants all disassemblers that LLVM is configured to support, to make
    them available via the TargetRegistry. *)
  //static inline void LLVMInitializeAllDisassemblers() {
  //#define LLVM_DISASSEMBLER(TargetName) \
  //LLVMInitialize##TargetName##Disassembler();
  //#include "llvm/Config/Disassemblers.def"
  //#undef LLVM_DISASSEMBLER  // Explicit undef to make SWIG happier 
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeAllDisassemblers = procedure(); cdecl;
{$ELSE}
  procedure LLVMInitializeAllDisassemblers(); cdecl; external LLVMLibrary name 'LLVMInitializeAllDisassemblersDL';
{$ENDIF}

(** LLVMInitializeNativeTarget - The main program should call this function to
    initialize the native target corresponding to the host.  This is useful
    for JIT applications to ensure that the target gets linked in correctly. *)
  //static inline LLVMBool LLVMInitializeNativeTarget(void) {
  // If we have a native target, initialize it to ensure it is linked in.
  //#ifdef LLVM_NATIVE_TARGET
  //  LLVM_NATIVE_TARGETINFO();
  //  LLVM_NATIVE_TARGET();
  //  LLVM_NATIVE_TARGETMC();
  //  return 0;
  //#else
  //  return 1;
  //#endif
  //}
  // #ATTENTION: DL postfix - wrapper in library side
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMInitializeNativeTarget = function(): LLVMBool; cdecl;
{$ELSE}
  function LLVMInitializeNativeTarget(): LLVMBool; cdecl; external LLVMLibrary name 'LLVMInitializeNativeTargetDL';
{$ENDIF}

(*===-- Target Data -------------------------------------------------------===*)

(** Creates target data from a target layout string.
    See the constructor llvm::TargetData::TargetData. *)
  //LLVMTargetDataRef LLVMCreateTargetData(const char *StringRep);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateTargetData = function(StringRep: PAnsiChar): LLVMTargetDataRef; cdecl;
{$ELSE}
  function LLVMCreateTargetData(StringRep: PAnsiChar): LLVMTargetDataRef; cdecl; external LLVMLibrary name 'LLVMCreateTargetData';
{$ENDIF}

(** Adds target data information to a pass manager. This does not take ownership
    of the target data.
    See the method llvm::PassManagerBase::add. *)
  //void LLVMAddTargetData(LLVMTargetDataRef, LLVMPassManagerRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddTargetData = procedure(Unknown: LLVMTargetDataRef; Unknown_: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddTargetData(Unknown: LLVMTargetDataRef; Unknown_: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddTargetData';
{$ENDIF}

(** Adds target library information to a pass manager. This does not take
    ownership of the target library info.
    See the method llvm::PassManagerBase::add. *)
  //void LLVMAddTargetLibraryInfo(LLVMTargetLibraryInfoRef, LLVMPassManagerRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddTargetLibraryInfo = procedure(Unknown: LLVMTargetLibraryInfoRef; Unknown_: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddTargetLibraryInfo(Unknown: LLVMTargetLibraryInfoRef; Unknown_: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddTargetLibraryInfo';
{$ENDIF}

(** Converts target data to a target layout string. The string must be disposed
    with LLVMDisposeMessage.
    See the constructor llvm::TargetData::TargetData. *)
  //char *LLVMCopyStringRepOfTargetData(LLVMTargetDataRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCopyStringRepOfTargetData = function(Unknown: LLVMTargetDataRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMCopyStringRepOfTargetData(Unknown: LLVMTargetDataRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMCopyStringRepOfTargetData';
{$ENDIF}

(** Returns the byte order of a target, either LLVMBigEndian or
    LLVMLittleEndian.
    See the method llvm::TargetData::isLittleEndian. *)
  //enum LLVMByteOrdering LLVMByteOrder(LLVMTargetDataRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMByteOrder = function(Unknown: LLVMTargetDataRef): LLVMByteOrdering; cdecl;
{$ELSE}
  function LLVMByteOrder(Unknown: LLVMTargetDataRef): LLVMByteOrdering; cdecl; external LLVMLibrary name 'LLVMByteOrder';
{$ENDIF}

(** Returns the pointer size in bytes for a target.
    See the method llvm::TargetData::getPointerSize. *)
  //unsigned LLVMPointerSize(LLVMTargetDataRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPointerSize = function(Unknown: LLVMTargetDataRef): Cardinal; cdecl;
{$ELSE}
  function LLVMPointerSize(Unknown: LLVMTargetDataRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMPointerSize';
{$ENDIF}

(** Returns the integer type that is the same size as a pointer on a target.
    See the method llvm::TargetData::getIntPtrType. *)
  //LLVMTypeRef LLVMIntPtrType(LLVMTargetDataRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIntPtrType = function(Unknown: LLVMTargetDataRef): LLVMTypeRef; cdecl;
{$ELSE}
  function LLVMIntPtrType(Unknown: LLVMTargetDataRef): LLVMTypeRef; cdecl; external LLVMLibrary name 'LLVMIntPtrType';
{$ENDIF}

(** Computes the size of a type in bytes for a target.
    See the method llvm::TargetData::getTypeSizeInBits. *)
  //unsigned long long LLVMSizeOfTypeInBits(LLVMTargetDataRef, LLVMTypeRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMSizeOfTypeInBits = function(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): UInt64; cdecl;
{$ELSE}
  function LLVMSizeOfTypeInBits(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): UInt64; cdecl; external LLVMLibrary name 'LLVMSizeOfTypeInBits';
{$ENDIF}

(** Computes the storage size of a type in bytes for a target.
    See the method llvm::TargetData::getTypeStoreSize. *)
  //unsigned long long LLVMStoreSizeOfType(LLVMTargetDataRef, LLVMTypeRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMStoreSizeOfType = function(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): UInt64; cdecl;
{$ELSE}
  function LLVMStoreSizeOfType(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): UInt64; cdecl; external LLVMLibrary name 'LLVMStoreSizeOfType';
{$ENDIF}

(** Computes the ABI size of a type in bytes for a target.
    See the method llvm::TargetData::getTypeAllocSize. *)
  //unsigned long long LLVMABISizeOfType(LLVMTargetDataRef, LLVMTypeRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMABISizeOfType = function(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): UInt64; cdecl;
{$ELSE}
  function LLVMABISizeOfType(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): UInt64; cdecl; external LLVMLibrary name 'LLVMABISizeOfType';
{$ENDIF}

(** Computes the ABI alignment of a type in bytes for a target.
    See the method llvm::TargetData::getTypeABISize. *)
  //unsigned LLVMABIAlignmentOfType(LLVMTargetDataRef, LLVMTypeRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMABIAlignmentOfType = function(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMABIAlignmentOfType(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMABIAlignmentOfType';
{$ENDIF}

(** Computes the call frame alignment of a type in bytes for a target.
    See the method llvm::TargetData::getTypeABISize. *)
  //unsigned LLVMCallFrameAlignmentOfType(LLVMTargetDataRef, LLVMTypeRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCallFrameAlignmentOfType = function(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMCallFrameAlignmentOfType(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMCallFrameAlignmentOfType';
{$ENDIF}

(** Computes the preferred alignment of a type in bytes for a target.
    See the method llvm::TargetData::getTypeABISize. *)
  //unsigned LLVMPreferredAlignmentOfType(LLVMTargetDataRef, LLVMTypeRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPreferredAlignmentOfType = function(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): Cardinal; cdecl;
{$ELSE}
  function LLVMPreferredAlignmentOfType(Unknown: LLVMTargetDataRef; Unknown_: LLVMTypeRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMPreferredAlignmentOfType';
{$ENDIF}

(** Computes the preferred alignment of a global variable in bytes for a target.
    See the method llvm::TargetData::getPreferredAlignment. *)
  //unsigned LLVMPreferredAlignmentOfGlobal(LLVMTargetDataRef,
  //                                      LLVMValueRef GlobalVar);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPreferredAlignmentOfGlobal = function(Unknown: LLVMTargetDataRef; GlobalVar: LLVMValueRef): Cardinal; cdecl;
{$ELSE}
  function LLVMPreferredAlignmentOfGlobal(Unknown: LLVMTargetDataRef; GlobalVar: LLVMValueRef): Cardinal; cdecl; external LLVMLibrary name 'LLVMPreferredAlignmentOfGlobal';
{$ENDIF}

(** Computes the structure element that contains the byte offset for a target.
    See the method llvm::StructLayout::getElementContainingOffset. *)
  //unsigned LLVMElementAtOffset(LLVMTargetDataRef, LLVMTypeRef StructTy,
  //                           unsigned long long Offset);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMElementAtOffset = function(Unknown: LLVMTargetDataRef; StructTy: LLVMTypeRef; Offset: UInt64): Cardinal; cdecl;
{$ELSE}
  function LLVMElementAtOffset(Unknown: LLVMTargetDataRef; StructTy: LLVMTypeRef; Offset: UInt64): Cardinal; cdecl; external LLVMLibrary name 'LLVMElementAtOffset';
{$ENDIF}

(** Computes the byte offset of the indexed struct element for a target.
    See the method llvm::StructLayout::getElementContainingOffset. *)
  //unsigned long long LLVMOffsetOfElement(LLVMTargetDataRef, LLVMTypeRef StructTy,
  //                                     unsigned Element);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMOffsetOfElement = function(Unknown: LLVMTargetDataRef; StructTy: LLVMTypeRef; Element: Cardinal): UInt64; cdecl;
{$ELSE}
  function LLVMOffsetOfElement(Unknown: LLVMTargetDataRef; StructTy: LLVMTypeRef; Element: Cardinal): UInt64; cdecl; external LLVMLibrary name 'LLVMOffsetOfElement';
{$ENDIF}

(** Deallocates a TargetData.
    See the destructor llvm::TargetData::~TargetData. *)
  //void LLVMDisposeTargetData(LLVMTargetDataRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeTargetData = procedure(Unknown: LLVMTargetDataRef); cdecl;
{$ELSE}
  procedure LLVMDisposeTargetData(Unknown: LLVMTargetDataRef); cdecl; external LLVMLibrary name 'LLVMDisposeTargetData';
{$ENDIF}

(*
namespace llvm {
  class TargetData;
  class TargetLibraryInfo;

  inline TargetData *unwrap(LLVMTargetDataRef P) {
    return reinterpret_cast<TargetData*>(P);
  }
  
  inline LLVMTargetDataRef wrap(const TargetData *P) {
    return reinterpret_cast<LLVMTargetDataRef>(const_cast<TargetData*>(P));
  }

  inline TargetLibraryInfo *unwrap(LLVMTargetLibraryInfoRef P) {
    return reinterpret_cast<TargetLibraryInfo*>(P);
  }

  inline LLVMTargetLibraryInfoRef wrap(const TargetLibraryInfo *P) {
    TargetLibraryInfo *X = const_cast<TargetLibraryInfo*>(P);
    return reinterpret_cast<LLVMTargetLibraryInfoRef>(X);
  }
}
*)
{$ENDIF}
//*------------------------------------------------- END of Target.h -------------------------------------------------*//


//*================================================= START of TargetMachine.h =================================================*//
{$IFDEF LLVM_API_TARGETMACHINE}

  //typedef struct LLVMTargetMachine *LLVMTargetMachineRef;
  LLVMTargetMachine = packed record
  end;
  LLVMTargetMachineRef = ^LLVMTargetMachine;
  //typedef struct LLVMTarget *LLVMTargetRef;
  LLVMTarget = packed record
  end;
  LLVMTargetRef = ^LLVMTarget;

(*
typedef enum {
    LLVMCodeGenLevelNone,
    LLVMCodeGenLevelLess,
    LLVMCodeGenLevelDefault,
    LLVMCodeGenLevelAggressive
} LLVMCodeGenOptLevel;
*)
  LLVMCodeGenOptLevel = (
    LLVMCodeGenLevelNone,
    LLVMCodeGenLevelLess,
    LLVMCodeGenLevelDefault,
    LLVMCodeGenLevelAggressive
  );

(*
typedef enum {
    LLVMRelocDefault,
    LLVMRelocStatic,
    LLVMRelocPIC,
    LLVMRelocDynamicNoPic
} LLVMRelocMode;
*)
  LLVMRelocMode = (
    LLVMRelocDefault,
    LLVMRelocStatic,
    LLVMRelocPIC,
    LLVMRelocDynamicNoPic
  );

(*
typedef enum {
    LLVMCodeModelDefault,
    LLVMCodeModelJITDefault,
    LLVMCodeModelSmall,
    LLVMCodeModelKernel,
    LLVMCodeModelMedium,
    LLVMCodeModelLarge
} LLVMCodeModel;
*)
  LLVMCodeModel = (
    LLVMCodeModelDefault,
    LLVMCodeModelJITDefault,
    LLVMCodeModelSmall,
    LLVMCodeModelKernel,
    LLVMCodeModelMedium,
    LLVMCodeModelLarge
  );

(*
typedef enum {
    LLVMAssemblyFile,
    LLVMObjectFile
} LLVMCodeGenFileType;
*)
  LLVMCodeGenFileType = (
    LLVMAssemblyFile,
    LLVMObjectFile
  );

(* Returns the first llvm::Target in the registered targets list. *)
  //LLVMTargetRef LLVMGetFirstTarget();
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetFirstTarget = function(): LLVMTargetRef; cdecl;
{$ELSE}
  function LLVMGetFirstTarget(): LLVMTargetRef; cdecl; external LLVMLibrary name 'LLVMGetFirstTarget';
{$ENDIF}

(* Returns the next llvm::Target given a previous one (or null if there's none) *)
  //LLVMTargetRef LLVMGetNextTarget(LLVMTargetRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetNextTarget = function(T: LLVMTargetRef): LLVMTargetRef; cdecl;
{$ELSE}
  function LLVMGetNextTarget(T: LLVMTargetRef): LLVMTargetRef; cdecl; external LLVMLibrary name 'LLVMGetNextTarget';
{$ENDIF}

(*===-- Target ------------------------------------------------------------===*)
(* Returns the name of a target. See llvm::Target::getName *)
  //const char *LLVMGetTargetName(LLVMTargetRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetName = function(T: LLVMTargetRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetTargetName(T: LLVMTargetRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetTargetName';
{$ENDIF}

(* Returns the description  of a target. See llvm::Target::getDescription *)
  //const char *LLVMGetTargetDescription(LLVMTargetRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetDescription = function(T: LLVMTargetRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetTargetDescription(T: LLVMTargetRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetTargetDescription';
{$ENDIF}

(* Returns if the target has a JIT *)
  //LLVMBool LLVMTargetHasJIT(LLVMTargetRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMTargetHasJIT = function(T: LLVMTargetRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMTargetHasJIT(T: LLVMTargetRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMTargetHasJIT';
{$ENDIF}

(* Returns if the target has a TargetMachine associated *)
  //LLVMBool LLVMTargetHasTargetMachine(LLVMTargetRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMTargetHasTargetMachine = function(T: LLVMTargetRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMTargetHasTargetMachine(T: LLVMTargetRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMTargetHasTargetMachine';
{$ENDIF}

(* Returns if the target as an ASM backend (required for emitting output) *)
  //LLVMBool LLVMTargetHasAsmBackend(LLVMTargetRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMTargetHasAsmBackend = function(T: LLVMTargetRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMTargetHasAsmBackend(T: LLVMTargetRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMTargetHasAsmBackend';
{$ENDIF}

(*===-- Target Machine ----------------------------------------------------===*)
(* Creates a new llvm::TargetMachine. See llvm::Target::createTargetMachine *)
  //LLVMTargetMachineRef LLVMCreateTargetMachine(LLVMTargetRef T, char *Triple,
  //  char *CPU, char *Features, LLVMCodeGenOptLevel Level, LLVMRelocMode Reloc,
  //  LLVMCodeModel CodeModel);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateTargetMachine = function(T: LLVMTargetRef; Triple: PAnsiChar; CPU: PAnsiChar; Features: PAnsiChar; Level: LLVMCodeGenOptLevel; Reloc: LLVMRelocMode; CodeModel: LLVMCodeModel): LLVMTargetMachineRef; cdecl;
{$ELSE}
  function LLVMCreateTargetMachine(T: LLVMTargetRef; Triple: PAnsiChar; CPU: PAnsiChar; Features: PAnsiChar; Level: LLVMCodeGenOptLevel; Reloc: LLVMRelocMode; CodeModel: LLVMCodeModel): LLVMTargetMachineRef; cdecl; external LLVMLibrary name 'LLVMCreateTargetMachine';
{$ENDIF}

(* Dispose the LLVMTargetMachineRef instance generated by
  LLVMCreateTargetMachine. *)
  //void LLVMDisposeTargetMachine(LLVMTargetMachineRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeTargetMachine = procedure(T: LLVMTargetMachineRef); cdecl;
{$ELSE}
  procedure LLVMDisposeTargetMachine(T: LLVMTargetMachineRef); cdecl; external LLVMLibrary name 'LLVMDisposeTargetMachine';
{$ENDIF}

(* Returns the Target used in a TargetMachine *)
  //LLVMTargetRef LLVMGetTargetMachineTarget(LLVMTargetMachineRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetMachineTarget = function(T: LLVMTargetMachineRef): LLVMTargetRef; cdecl; 
{$ELSE}
  function LLVMGetTargetMachineTarget(T: LLVMTargetMachineRef): LLVMTargetRef; cdecl;  external LLVMLibrary name 'LLVMGetTargetMachineTarget';
{$ENDIF}

(* Returns the triple used creating this target machine. See
  llvm::TargetMachine::getTriple. The result needs to be disposed with
  LLVMDisposeMessage. *)
  //char *LLVMGetTargetMachineTriple(LLVMTargetMachineRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetMachineTriple = function(T: LLVMTargetMachineRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetTargetMachineTriple(T: LLVMTargetMachineRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetTargetMachineTriple';
{$ENDIF}

(* Returns the cpu used creating this target machine. See
  llvm::TargetMachine::getCPU. The result needs to be disposed with
  LLVMDisposeMessage. *)
  //char *LLVMGetTargetMachineCPU(LLVMTargetMachineRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetMachineCPU = function(T: LLVMTargetMachineRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetTargetMachineCPU(T: LLVMTargetMachineRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetTargetMachineCPU';
{$ENDIF}

(* Returns the feature string used creating this target machine. See
  llvm::TargetMachine::getFeatureString. The result needs to be disposed with
  LLVMDisposeMessage. *)
  //char *LLVMGetTargetMachineFeatureString(LLVMTargetMachineRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetMachineFeatureString = function(T: LLVMTargetMachineRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetTargetMachineFeatureString(T: LLVMTargetMachineRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetTargetMachineFeatureString';
{$ENDIF}

(* Returns the llvm::TargetData used for this llvm:TargetMachine. *)
  //LLVMTargetDataRef LLVMGetTargetMachineData(LLVMTargetMachineRef T);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetTargetMachineData = function(T: LLVMTargetMachineRef): LLVMTargetDataRef; 
{$ELSE}
  function LLVMGetTargetMachineData(T: LLVMTargetMachineRef): LLVMTargetDataRef;  external LLVMLibrary name 'LLVMGetTargetMachineData';
{$ENDIF}

(* Emits an asm or object file for the given module to the filename. This
  wraps several c++ only classes (among them a file stream). Returns any
  error in ErrorMessage. Use LLVMDisposeMessage to dispose the message. *)
  //LLVMBool LLVMTargetMachineEmitToFile(LLVMTargetMachineRef T, LLVMModuleRef M,
  //  char *Filename, LLVMCodeGenFileType codegen, char **ErrorMessage);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMTargetMachineEmitToFile = function(T: LLVMTargetMachineRef; M: LLVMModuleRef; Filename: PAnsiChar; codegen: LLVMCodeGenFileType; var ErrorMessage: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMTargetMachineEmitToFile(T: LLVMTargetMachineRef; M: LLVMModuleRef; Filename: PAnsiChar; codegen: LLVMCodeGenFileType; var ErrorMessage: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMTargetMachineEmitToFile';
{$ENDIF}

(*
namespace llvm {
  class TargetMachine;
  class Target;

  inline TargetMachine *unwrap(LLVMTargetMachineRef P) {
    return reinterpret_cast<TargetMachine*>(P);
  }
  inline Target *unwrap(LLVMTargetRef P) {
    return reinterpret_cast<Target*>(P);
  }
  inline LLVMTargetMachineRef wrap(const TargetMachine *P) {
    return reinterpret_cast<LLVMTargetMachineRef>(
      const_cast<TargetMachine*>(P));
  }
  inline LLVMTargetRef wrap(const Target * P) {
    return reinterpret_cast<LLVMTargetRef>(const_cast<Target*>(P));
  }
}
*)

{$ENDIF}
//*------------------------------------------------- END of TargetMachine.h -------------------------------------------------*//


//*================================================= START of Object.h =================================================*//
{$IFDEF LLVM_API_OBJECT}

type
(* Opaque type wrappers *)
  //typedef struct LLVMOpaqueObjectFile *LLVMObjectFileRef;
  LLVMOpaqueObjectFile = packed record
  end;
  LLVMObjectFileRef = ^LLVMOpaqueObjectFile;
  //typedef struct LLVMOpaqueSectionIterator *LLVMSectionIteratorRef;
  LLVMOpaqueSectionIterator = packed record
  end;
  LLVMSectionIteratorRef = ^LLVMOpaqueSectionIterator;
  //typedef struct LLVMOpaqueSymbolIterator *LLVMSymbolIteratorRef;
  LLVMOpaqueSymbolIterator = packed record
  end;
  LLVMSymbolIteratorRef = ^LLVMOpaqueSymbolIterator;
  //typedef struct LLVMOpaqueRelocationIterator *LLVMRelocationIteratorRef;
  LLVMOpaqueRelocationIterator = packed record
  end;
  LLVMRelocationIteratorRef = ^LLVMOpaqueRelocationIterator;

(* ObjectFile creation *)
  //LLVMObjectFileRef LLVMCreateObjectFile(LLVMMemoryBufferRef MemBuf);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateObjectFile = function(MemBuf: LLVMMemoryBufferRef): LLVMObjectFileRef; cdecl;
{$ELSE}
  function LLVMCreateObjectFile(MemBuf: LLVMMemoryBufferRef): LLVMObjectFileRef; cdecl; external LLVMLibrary name 'LLVMCreateObjectFile';
{$ENDIF}
  
  //void LLVMDisposeObjectFile(LLVMObjectFileRef ObjectFile);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeObjectFile = procedure(ObjectFile: LLVMObjectFileRef); cdecl;
{$ELSE}
  procedure LLVMDisposeObjectFile(ObjectFile: LLVMObjectFileRef); cdecl; external LLVMLibrary name 'LLVMDisposeObjectFile';
{$ENDIF}

(* ObjectFile Section iterators *)
  //LLVMSectionIteratorRef LLVMGetSections(LLVMObjectFileRef ObjectFile);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSections = function(ObjectFile: LLVMObjectFileRef): LLVMSectionIteratorRef; cdecl; 
{$ELSE}
  function LLVMGetSections(ObjectFile: LLVMObjectFileRef): LLVMSectionIteratorRef; cdecl;  external LLVMLibrary name 'LLVMGetSections';
{$ENDIF}
  
  //void LLVMDisposeSectionIterator(LLVMSectionIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeSectionIterator = procedure(SI: LLVMSectionIteratorRef); cdecl;
{$ELSE}
  procedure LLVMDisposeSectionIterator(SI: LLVMSectionIteratorRef); cdecl; external LLVMLibrary name 'LLVMDisposeSectionIterator';
{$ENDIF}
  
  //LLVMBool LLVMIsSectionIteratorAtEnd(LLVMObjectFileRef ObjectFile, LLVMSectionIteratorRef SI);  
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsSectionIteratorAtEnd = function(ObjectFile: LLVMObjectFileRef; SI: LLVMSectionIteratorRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsSectionIteratorAtEnd(ObjectFile: LLVMObjectFileRef; SI: LLVMSectionIteratorRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsSectionIteratorAtEnd';
{$ENDIF}
  
  //void LLVMMoveToNextSection(LLVMSectionIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMoveToNextSection = procedure(SI: LLVMSectionIteratorRef); cdecl;
{$ELSE}
  procedure LLVMMoveToNextSection(SI: LLVMSectionIteratorRef); cdecl; external LLVMLibrary name 'LLVMMoveToNextSection';
{$ENDIF}
  
  //void LLVMMoveToContainingSection(LLVMSectionIteratorRef Sect, LLVMSymbolIteratorRef Sym);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMoveToContainingSection = procedure(Sect: LLVMSectionIteratorRef; Sym: LLVMSymbolIteratorRef); cdecl;
{$ELSE}
  procedure LLVMMoveToContainingSection(Sect: LLVMSectionIteratorRef; Sym: LLVMSymbolIteratorRef); cdecl; external LLVMLibrary name 'LLVMMoveToContainingSection';
{$ENDIF}

(* ObjectFile Symbol iterators *)
  //LLVMSymbolIteratorRef LLVMGetSymbols(LLVMObjectFileRef ObjectFile);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSymbols = function(ObjectFile: LLVMObjectFileRef): LLVMSymbolIteratorRef; cdecl;
{$ELSE}
  function LLVMGetSymbols(ObjectFile: LLVMObjectFileRef): LLVMSymbolIteratorRef; cdecl; external LLVMLibrary name 'LLVMGetSymbols';
{$ENDIF}
  
  //void LLVMDisposeSymbolIterator(LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeSymbolIterator = procedure(SI: LLVMSymbolIteratorRef); cdecl;
{$ELSE}
  procedure LLVMDisposeSymbolIterator(SI: LLVMSymbolIteratorRef); cdecl; external LLVMLibrary name 'LLVMDisposeSymbolIterator';
{$ENDIF}
  
  //LLVMBool LLVMIsSymbolIteratorAtEnd(LLVMObjectFileRef ObjectFile, LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsSymbolIteratorAtEnd = function(ObjectFile: LLVMObjectFileRef; SI: LLVMSymbolIteratorRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsSymbolIteratorAtEnd(ObjectFile: LLVMObjectFileRef; SI: LLVMSymbolIteratorRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsSymbolIteratorAtEnd';
{$ENDIF}
  
  //void LLVMMoveToNextSymbol(LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMoveToNextSymbol = procedure(SI: LLVMSymbolIteratorRef); cdecl;
{$ELSE}
  procedure LLVMMoveToNextSymbol(SI: LLVMSymbolIteratorRef); cdecl; external LLVMLibrary name 'LLVMMoveToNextSymbol';
{$ENDIF}

(* SectionRef accessors *)
  //const char *LLVMGetSectionName(LLVMSectionIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSectionName = function(SI: LLVMSectionIteratorRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetSectionName(SI: LLVMSectionIteratorRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetSectionName';
{$ENDIF}
  
  //uint64_t LLVMGetSectionSize(LLVMSectionIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSectionSize = function(SI: LLVMSectionIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetSectionSize(SI: LLVMSectionIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetSectionSize';
{$ENDIF}
  
  //const char *LLVMGetSectionContents(LLVMSectionIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSectionContents = function(SI: LLVMSectionIteratorRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetSectionContents(SI: LLVMSectionIteratorRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetSectionContents';
{$ENDIF}
  
  //uint64_t LLVMGetSectionAddress(LLVMSectionIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSectionAddress = function(SI: LLVMSectionIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetSectionAddress(SI: LLVMSectionIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetSectionAddress';
{$ENDIF}
  
  //LLVMBool LLVMGetSectionContainsSymbol(LLVMSectionIteratorRef SI, LLVMSymbolIteratorRef Sym);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSectionContainsSymbol = function(SI: LLVMSectionIteratorRef; Sym: LLVMSymbolIteratorRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMGetSectionContainsSymbol(SI: LLVMSectionIteratorRef; Sym: LLVMSymbolIteratorRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMGetSectionContainsSymbol';
{$ENDIF}

(* Section Relocation iterators *)
  //LLVMRelocationIteratorRef LLVMGetRelocations(LLVMSectionIteratorRef Section);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocations = function(Section: LLVMSectionIteratorRef): LLVMRelocationIteratorRef; cdecl;
{$ELSE}
  function LLVMGetRelocations(Section: LLVMSectionIteratorRef): LLVMRelocationIteratorRef; cdecl; external LLVMLibrary name 'LLVMGetRelocations';
{$ENDIF}
  
  //void LLVMDisposeRelocationIterator(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeRelocationIterator = procedure(RI: LLVMRelocationIteratorRef); cdecl;
{$ELSE}
  procedure LLVMDisposeRelocationIterator(RI: LLVMRelocationIteratorRef); cdecl; external LLVMLibrary name 'LLVMDisposeRelocationIterator';
{$ENDIF}
  
  //LLVMBool LLVMIsRelocationIteratorAtEnd(LLVMSectionIteratorRef Section, LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMIsRelocationIteratorAtEnd = function(Section: LLVMSectionIteratorRef; RI: LLVMRelocationIteratorRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMIsRelocationIteratorAtEnd(Section: LLVMSectionIteratorRef; RI: LLVMRelocationIteratorRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMIsRelocationIteratorAtEnd';
{$ENDIF}
  
  //void LLVMMoveToNextRelocation(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMMoveToNextRelocation = procedure(RI: LLVMRelocationIteratorRef); cdecl;
{$ELSE}
  procedure LLVMMoveToNextRelocation(RI: LLVMRelocationIteratorRef); cdecl; external LLVMLibrary name 'LLVMMoveToNextRelocation';
{$ENDIF}

(* SymbolRef accessors *)
  //const char *LLVMGetSymbolName(LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSymbolName = function(SI: LLVMSymbolIteratorRef): PAnsiChar; cdecl;
{$ELSE}
  function LLVMGetSymbolName(SI: LLVMSymbolIteratorRef): PAnsiChar; cdecl; external LLVMLibrary name 'LLVMGetSymbolName';
{$ENDIF}
  
  //uint64_t LLVMGetSymbolAddress(LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSymbolAddress = function(SI: LLVMSymbolIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetSymbolAddress(SI: LLVMSymbolIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetSymbolAddress';
{$ENDIF}
  
  //uint64_t LLVMGetSymbolFileOffset(LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSymbolFileOffset = function(SI: LLVMSymbolIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetSymbolFileOffset(SI: LLVMSymbolIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetSymbolFileOffset';
{$ENDIF}
  
  //uint64_t LLVMGetSymbolSize(LLVMSymbolIteratorRef SI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetSymbolSize = function(SI: LLVMSymbolIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetSymbolSize(SI: LLVMSymbolIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetSymbolSize';
{$ENDIF}

(* RelocationRef accessors *)
  //uint64_t LLVMGetRelocationAddress(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocationAddress = function(RI: LLVMRelocationIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetRelocationAddress(RI: LLVMRelocationIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetRelocationAddress';
{$ENDIF}
  
  //uint64_t LLVMGetRelocationOffset(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocationOffset = function(RI: LLVMRelocationIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetRelocationOffset(RI: LLVMRelocationIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetRelocationOffset';
{$ENDIF}
  
  //LLVMSymbolIteratorRef LLVMGetRelocationSymbol(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocationSymbol = function(RI: LLVMRelocationIteratorRef): LLVMSymbolIteratorRef; cdecl;
{$ELSE}
  function LLVMGetRelocationSymbol(RI: LLVMRelocationIteratorRef): LLVMSymbolIteratorRef; cdecl; external LLVMLibrary name 'LLVMGetRelocationSymbol';
{$ENDIF}
  
  //uint64_t LLVMGetRelocationType(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocationType = function(RI: LLVMRelocationIteratorRef): uint64_t; cdecl;
{$ELSE}
  function LLVMGetRelocationType(RI: LLVMRelocationIteratorRef): uint64_t; cdecl; external LLVMLibrary name 'LLVMGetRelocationType';
{$ENDIF}
  
(* NOTE: Caller takes ownership of returned string of the two
   following functions. *)
  //const char *LLVMGetRelocationTypeName(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocationTypeName = function(RI: LLVMRelocationIteratorRef): PAnsiChar;
{$ELSE}
  function LLVMGetRelocationTypeName(RI: LLVMRelocationIteratorRef): PAnsiChar; external LLVMLibrary name 'LLVMGetRelocationTypeName';
{$ENDIF}
  
  //const char *LLVMGetRelocationValueString(LLVMRelocationIteratorRef RI);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetRelocationValueString = function(RI: LLVMRelocationIteratorRef): PAnsiChar;
{$ELSE}
  function LLVMGetRelocationValueString(RI: LLVMRelocationIteratorRef): PAnsiChar; external LLVMLibrary name 'LLVMGetRelocationValueString';
{$ENDIF}

//namespace llvm {
//  namespace object {
//    inline ObjectFile *unwrap(LLVMObjectFileRef OF) {
//      return reinterpret_cast<ObjectFile*>(OF);
//    }
//
//    inline LLVMObjectFileRef wrap(const ObjectFile *OF) {
//      return reinterpret_cast<LLVMObjectFileRef>(const_cast<ObjectFile*>(OF));
//    }
//
//    inline section_iterator *unwrap(LLVMSectionIteratorRef SI) {
//      return reinterpret_cast<section_iterator*>(SI);
//    }
//
//    inline LLVMSectionIteratorRef
//    wrap(const section_iterator *SI) {
//      return reinterpret_cast<LLVMSectionIteratorRef>
//        (const_cast<section_iterator*>(SI));
//    }
//
//    inline symbol_iterator *unwrap(LLVMSymbolIteratorRef SI) {
//      return reinterpret_cast<symbol_iterator*>(SI);
//    }
//
//    inline LLVMSymbolIteratorRef
//    wrap(const symbol_iterator *SI) {
//      return reinterpret_cast<LLVMSymbolIteratorRef>
//        (const_cast<symbol_iterator*>(SI));
//    }
//
//    inline relocation_iterator *unwrap(LLVMRelocationIteratorRef SI) {
//      return reinterpret_cast<relocation_iterator*>(SI);
//    }
//
//    inline LLVMRelocationIteratorRef
//    wrap(const relocation_iterator *SI) {
//      return reinterpret_cast<LLVMRelocationIteratorRef>
//        (const_cast<relocation_iterator*>(SI));
//    }
//
//  }
//}

{$ENDIF}
//*------------------------------------------------- END of Object.h -------------------------------------------------*//


//*================================================= START of ExecutionEngine.h =================================================*//
{$IFDEF LLVM_API_EXECUTIONENGINE}

  //void LLVMLinkInJIT(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMLinkInJIT = procedure(); cdecl;
{$ELSE}
  procedure LLVMLinkInJIT(); cdecl; external LLVMLibrary name 'LLVMLinkInJIT';
{$ENDIF}
  //void LLVMLinkInInterpreter(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMLinkInInterpreter = procedure(); cdecl;
{$ELSE}
  procedure LLVMLinkInInterpreter(); cdecl; external LLVMLibrary name 'LLVMLinkInInterpreter';
{$ENDIF}

type
  //typedef struct LLVMOpaqueGenericValue *LLVMGenericValueRef;
  LLVMOpaqueGenericValue = packed record
  end;
  LLVMGenericValueRef = ^LLVMOpaqueGenericValue;
  //typedef struct LLVMOpaqueExecutionEngine *LLVMExecutionEngineRef;
  LLVMOpaqueExecutionEngine = packed record
  end;
  LLVMExecutionEngineRef = ^LLVMOpaqueExecutionEngine;

(*===-- Operations on generic values --------------------------------------===*)

  //LLVMGenericValueRef LLVMCreateGenericValueOfInt(LLVMTypeRef Ty, unsigned long long N, LLVMBool IsSigned);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateGenericValueOfInt = function(Ty: LLVMTypeRef; N: UInt64; IsSigned: LLVMBool): LLVMGenericValueRef; cdecl;
{$ELSE}
  function LLVMCreateGenericValueOfInt(Ty: LLVMTypeRef; N: UInt64; IsSigned: LLVMBool): LLVMGenericValueRef; cdecl; external LLVMLibrary name 'LLVMCreateGenericValueOfInt';
{$ENDIF}

  //LLVMGenericValueRef LLVMCreateGenericValueOfPointer(void *P);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateGenericValueOfPointer = function(P: Pointer): LLVMGenericValueRef; cdecl;
{$ELSE}
  function LLVMCreateGenericValueOfPointer(P: Pointer): LLVMGenericValueRef; cdecl; external LLVMLibrary name 'LLVMCreateGenericValueOfPointer';
{$ENDIF}

  //LLVMGenericValueRef LLVMCreateGenericValueOfFloat(LLVMTypeRef Ty, double N);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateGenericValueOfFloat = function(Ty: LLVMTypeRef; N: Double): LLVMGenericValueRef; cdecl;
{$ELSE}
  function LLVMCreateGenericValueOfFloat(Ty: LLVMTypeRef; N: Double): LLVMGenericValueRef; cdecl; external LLVMLibrary name 'LLVMCreateGenericValueOfFloat';
{$ENDIF}

  //unsigned LLVMGenericValueIntWidth(LLVMGenericValueRef GenValRef);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGenericValueIntWidth = function(GenValRef: LLVMGenericValueRef): LLVMGenericValueRef; cdecl;
{$ELSE}
  function LLVMGenericValueIntWidth(GenValRef: LLVMGenericValueRef): LLVMGenericValueRef; cdecl; external LLVMLibrary name 'LLVMGenericValueIntWidth';
{$ENDIF}

  //unsigned long long LLVMGenericValueToInt(LLVMGenericValueRef GenVal, LLVMBool IsSigned);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGenericValueToInt = function(GenVal: LLVMGenericValueRef; IsSigned: LLVMBool): LLVMGenericValueRef; cdecl;
{$ELSE}
  function LLVMGenericValueToInt(GenVal: LLVMGenericValueRef; IsSigned: LLVMBool): LLVMGenericValueRef; cdecl; external LLVMLibrary name 'LLVMGenericValueToInt';
{$ENDIF}

  //void *LLVMGenericValueToPointer(LLVMGenericValueRef GenVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGenericValueToPointer = function(GenVal: LLVMGenericValueRef): Pointer; cdecl;
{$ELSE}
  function LLVMGenericValueToPointer(GenVal: LLVMGenericValueRef): Pointer; cdecl; external LLVMLibrary name 'LLVMGenericValueToPointer';
{$ENDIF}

  //double LLVMGenericValueToFloat(LLVMTypeRef TyRef, LLVMGenericValueRef GenVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGenericValueToFloat = function(TyRef: LLVMTypeRef; GenVal: LLVMGenericValueRef): Double; cdecl;
{$ELSE}
  function LLVMGenericValueToFloat(TyRef: LLVMTypeRef; GenVal: LLVMGenericValueRef): Double; cdecl; external LLVMLibrary name 'LLVMGenericValueToFloat';
{$ENDIF}

  //void LLVMDisposeGenericValue(LLVMGenericValueRef GenVal);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeGenericValue = procedure(GenVal: LLVMGenericValueRef); cdecl;
{$ELSE}
  procedure LLVMDisposeGenericValue(GenVal: LLVMGenericValueRef); cdecl; external LLVMLibrary name 'LLVMDisposeGenericValue';
{$ENDIF}

(*===-- Operations on execution engines -----------------------------------===*)

  //LLVMBool LLVMCreateExecutionEngineForModule(LLVMExecutionEngineRef *OutEE,
  //                                          LLVMModuleRef M,
  //                                          char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateExecutionEngineForModule = function(var OutEE: LLVMExecutionEngineRef; M: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateExecutionEngineForModule(var OutEE: LLVMExecutionEngineRef; M: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMCreateExecutionEngineForModule';
{$ENDIF}

  //LLVMBool LLVMCreateInterpreterForModule(LLVMExecutionEngineRef *OutInterp,
  //                                      LLVMModuleRef M,
  //                                      char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateInterpreterForModule = function(var OutInterp: LLVMExecutionEngineRef; M: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateInterpreterForModule(var OutInterp: LLVMExecutionEngineRef; M: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMCreateInterpreterForModule';
{$ENDIF}

  //LLVMBool LLVMCreateJITCompilerForModule(LLVMExecutionEngineRef *OutJIT,
  //                                      LLVMModuleRef M,
  //                                      unsigned OptLevel,
  //                                      char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateJITCompilerForModule = function(var OutJIT: LLVMExecutionEngineRef; M: LLVMModuleRef; OptLevel: Cardinal; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateJITCompilerForModule(var OutJIT: LLVMExecutionEngineRef; M: LLVMModuleRef; OptLevel: Cardinal; var OutError: PAnsiChar): LLVMBool; cdecl;  external LLVMLibrary name 'LLVMCreateJITCompilerForModule';
{$ENDIF}

(* Deprecated: Use LLVMCreateExecutionEngineForModule instead. *)
  //LLVMBool LLVMCreateExecutionEngine(LLVMExecutionEngineRef *OutEE,
  //                                 LLVMModuleProviderRef MP,
  //                                 char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateExecutionEngine = function(var OutEE: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateExecutionEngine(var OutEE: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; var OutError: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMCreateExecutionEngine';
{$ENDIF}

(* Deprecated: Use LLVMCreateInterpreterForModule instead. *)
  //LLVMBool LLVMCreateInterpreter(LLVMExecutionEngineRef *OutInterp,
  //                             LLVMModuleProviderRef MP,
  //                             char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateInterpreter = function(var OutInterp: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateInterpreter(var OutInterp: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; var OutError: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMCreateInterpreter';
{$ENDIF}

(* Deprecated: Use LLVMCreateJITCompilerForModule instead. *)
  //LLVMBool LLVMCreateJITCompiler(LLVMExecutionEngineRef *OutJIT,
  //                             LLVMModuleProviderRef MP,
  //                             unsigned OptLevel,
  //                             char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMCreateJITCompiler = function(var OutJIT: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; OptLevel: Cardinal; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMCreateJITCompiler(var OutJIT: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; OptLevel: Cardinal; var OutError: PAnsiChar): LLVMBool; cdecl;  external LLVMLibrary name 'LLVMCreateJITCompiler';
{$ENDIF}

  //void LLVMDisposeExecutionEngine(LLVMExecutionEngineRef EE);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisposeExecutionEngine = procedure(EE: LLVMExecutionEngineRef); cdecl;
{$ELSE}
  procedure LLVMDisposeExecutionEngine(EE: LLVMExecutionEngineRef); cdecl; external LLVMLibrary name 'LLVMDisposeExecutionEngine';
{$ENDIF}

  //void LLVMRunStaticConstructors(LLVMExecutionEngineRef EE);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRunStaticConstructors = procedure(EE: LLVMExecutionEngineRef); cdecl;
{$ELSE}
  procedure LLVMRunStaticConstructors(EE: LLVMExecutionEngineRef); cdecl; external LLVMLibrary name 'LLVMRunStaticConstructors';
{$ENDIF}

  //void LLVMRunStaticDestructors(LLVMExecutionEngineRef EE);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRunStaticDestructors = procedure(EE: LLVMExecutionEngineRef); cdecl;
{$ELSE}
  procedure LLVMRunStaticDestructors(EE: LLVMExecutionEngineRef); cdecl; external LLVMLibrary name 'LLVMRunStaticDestructors';
{$ENDIF}

  //int LLVMRunFunctionAsMain(LLVMExecutionEngineRef EE, LLVMValueRef F,
  //                        unsigned ArgC, const char * const *ArgV,
  //                        const char * const *EnvP);
  // #WARNING: I forgot so complex types as const char * const *EnvP :)
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRunFunctionAsMain = function(EE: LLVMExecutionEngineRef; F: LLVMValueRef; ArgC: Cardinal; var ArgV: PAnsiChar; var EnvP: PAnsiChar): Integer; cdecl;
{$ELSE}
  function LLVMRunFunctionAsMain(EE: LLVMExecutionEngineRef; F: LLVMValueRef; ArgC: Cardinal; var ArgV: PAnsiChar; var EnvP: PAnsiChar): Integer; cdecl; external LLVMLibrary name 'LLVMRunFunctionAsMain';
{$ENDIF}

  //LLVMGenericValueRef LLVMRunFunction(LLVMExecutionEngineRef EE, LLVMValueRef F,
  //                                  unsigned NumArgs,
  //                                  LLVMGenericValueRef *Args);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRunFunction = function(EE: LLVMExecutionEngineRef; F: LLVMValueRef; NumArgs: Cardinal; var Args: LLVMGenericValueRef): LLVMGenericValueRef; cdecl;
{$ELSE}
  function LLVMRunFunction(EE: LLVMExecutionEngineRef; F: LLVMValueRef; NumArgs: Cardinal; var Args: LLVMGenericValueRef): LLVMGenericValueRef; cdecl; external LLVMLibrary name 'LLVMRunFunction';
{$ENDIF}

  //void LLVMFreeMachineCodeForFunction(LLVMExecutionEngineRef EE, LLVMValueRef F);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFreeMachineCodeForFunction = procedure(EE: LLVMExecutionEngineRef; F: LLVMValueRef); cdecl;
{$ELSE}
  procedure LLVMFreeMachineCodeForFunction(EE: LLVMExecutionEngineRef; F: LLVMValueRef); cdecl; external LLVMLibrary name 'LLVMFreeMachineCodeForFunction';
{$ENDIF}

  //void LLVMAddModule(LLVMExecutionEngineRef EE, LLVMModuleRef M);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddModule = procedure(EE: LLVMExecutionEngineRef; M: LLVMModuleRef); cdecl;
{$ELSE}
  procedure LLVMAddModule(EE: LLVMExecutionEngineRef; M: LLVMModuleRef); cdecl; external LLVMLibrary name 'LLVMAddModule';
{$ENDIF}

(* Deprecated: Use LLVMAddModule instead. *)
  //void LLVMAddModuleProvider(LLVMExecutionEngineRef EE, LLVMModuleProviderRef MP);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddModuleProvider = procedure(EE: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef); cdecl;
{$ELSE}
  procedure LLVMAddModuleProvider(EE: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef); cdecl; external LLVMLibrary name 'LLVMAddModuleProvider';
{$ENDIF}

  //LLVMBool LLVMRemoveModule(LLVMExecutionEngineRef EE, LLVMModuleRef M,
  //                        LLVMModuleRef *OutMod, char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRemoveModule = function(EE: LLVMExecutionEngineRef; M: LLVMModuleRef; var OutMod: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMRemoveModule(EE: LLVMExecutionEngineRef; M: LLVMModuleRef; var OutMod: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMRemoveModule';
{$ENDIF}

(* Deprecated: Use LLVMRemoveModule instead. *)
  //LLVMBool LLVMRemoveModuleProvider(LLVMExecutionEngineRef EE,
  //                                LLVMModuleProviderRef MP,
  //                                LLVMModuleRef *OutMod, char **OutError);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRemoveModuleProvider = function(EE: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; var OutMod: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl;
{$ELSE}
  function LLVMRemoveModuleProvider(EE: LLVMExecutionEngineRef; MP: LLVMModuleProviderRef; var OutMod: LLVMModuleRef; var OutError: PAnsiChar): LLVMBool; cdecl; external LLVMLibrary name 'LLVMRemoveModuleProvider';
{$ENDIF}

  //LLVMBool LLVMFindFunction(LLVMExecutionEngineRef EE, const char *Name, LLVMValueRef *OutFn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMFindFunction = function(EE: LLVMExecutionEngineRef; Name: PAnsiChar; var OutFn: LLVMValueRef): LLVMBool; cdecl;
{$ELSE}
  function LLVMFindFunction(EE: LLVMExecutionEngineRef; Name: PAnsiChar; var OutFn: LLVMValueRef): LLVMBool; cdecl; external LLVMLibrary name 'LLVMFindFunction';
{$ENDIF}

  //void *LLVMRecompileAndRelinkFunction(LLVMExecutionEngineRef EE, LLVMValueRef Fn);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMRecompileAndRelinkFunction = function(EE: LLVMExecutionEngineRef; Fn: LLVMValueRef): Pointer; cdecl;
{$ELSE}
  function LLVMRecompileAndRelinkFunction(EE: LLVMExecutionEngineRef; Fn: LLVMValueRef): Pointer; cdecl; external LLVMLibrary name 'LLVMRecompileAndRelinkFunction';
{$ENDIF}

  //LLVMTargetDataRef LLVMGetExecutionEngineTargetData(LLVMExecutionEngineRef EE);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetExecutionEngineTargetData = function(EE: LLVMExecutionEngineRef): LLVMTargetDataRef; cdecl; 
{$ELSE}
  function LLVMGetExecutionEngineTargetData(EE: LLVMExecutionEngineRef): LLVMTargetDataRef; cdecl;  external LLVMLibrary name 'LLVMGetExecutionEngineTargetData';
{$ENDIF}

  //void LLVMAddGlobalMapping(LLVMExecutionEngineRef EE, LLVMValueRef Global,
  //                        void* Addr);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddGlobalMapping = procedure(EE: LLVMExecutionEngineRef; Global: LLVMValueRef; Addr: Pointer); cdecl;
{$ELSE}
  procedure LLVMAddGlobalMapping(EE: LLVMExecutionEngineRef; Global: LLVMValueRef; Addr: Pointer); cdecl; external LLVMLibrary name 'LLVMAddGlobalMapping';
{$ENDIF}

  //void *LLVMGetPointerToGlobal(LLVMExecutionEngineRef EE, LLVMValueRef Global);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMGetPointerToGlobal = function(EE: LLVMExecutionEngineRef; Global: LLVMValueRef): Pointer; cdecl;
{$ELSE}
  function LLVMGetPointerToGlobal(EE: LLVMExecutionEngineRef; Global: LLVMValueRef): Pointer; cdecl; external LLVMLibrary name 'LLVMGetPointerToGlobal';
{$ENDIF}

(*
namespace llvm {
  struct GenericValue;
  class ExecutionEngine;
  
  #define DEFINE_SIMPLE_CONVERSION_FUNCTIONS(ty, ref)   \
    inline ty *unwrap(ref P) {                          \
      return reinterpret_cast<ty*>(P);                  \
    }                                                   \
                                                        \
    inline ref wrap(const ty *P) {                      \
      return reinterpret_cast<ref>(const_cast<ty*>(P)); \
    }
  
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(GenericValue,    LLVMGenericValueRef   )
  DEFINE_SIMPLE_CONVERSION_FUNCTIONS(ExecutionEngine, LLVMExecutionEngineRef)
  
  #undef DEFINE_SIMPLE_CONVERSION_FUNCTIONS
}
*)

{$ENDIF}
//*------------------------------------------------- END of ExecutionEngine.h -------------------------------------------------*//


//*================================================= START of Disassembler.h =================================================*//
{$IFDEF LLVM_API_DISASSEMBLER}

type
(*
 * An opaque reference to a disassembler context.
 *)
  //typedef void *LLVMDisasmContextRef;
  LLVMDisasmContextRef = Pointer;

(*
 * The type for the operand information call back function.  This is called to
 * get the symbolic information for an operand of an instruction.  Typically
 * this is from the relocation information, symbol table, etc.  That block of
 * information is saved when the disassembler context is created and passed to
 * the call back in the DisInfo parameter.  The instruction containing operand
 * is at the PC parameter.  For some instruction sets, there can be more than
 * one operand with symbolic information.  To determine the symbolic operand
 * information for each operand, the bytes for the specific operand in the
 * instruction are specified by the Offset parameter and its byte widith is the
 * size parameter.  For instructions sets with fixed widths and one symbolic
 * operand per instruction, the Offset parameter will be zero and Size parameter
 * will be the instruction width.  The information is returned in TagBuf and is 
 * Triple specific with its specific information defined by the value of
 * TagType for that Triple.  If symbolic information is returned the function
 * returns 1, otherwise it returns 0.
 *)
  //typedef int (*LLVMOpInfoCallback)(void *DisInfo, uint64_t PC,
  //                                uint64_t Offset, uint64_t Size,
  //                                int TagType, void *TagBuf);
  // #ATTENTION: Not extern!
  LLVMOpInfoCallback = function(DisInfo: Pointer; PC: uint64_t; Offset: uint64_t; Size: uint64_t; TagType: Integer; TagBuf: Pointer): Integer; cdecl;

(*
 * The initial support in LLVM MC for the most general form of a relocatable
 * expression is "AddSymbol - SubtractSymbol + Offset".  For some Darwin targets
 * this full form is encoded in the relocation information so that AddSymbol and
 * SubtractSymbol can be link edited independent of each other.  Many other
 * platforms only allow a relocatable expression of the form AddSymbol + Offset
 * to be encoded.
 * 
 * The LLVMOpInfoCallback() for the TagType value of 1 uses the struct
 * LLVMOpInfo1.  The value of the relocatable expression for the operand,
 * including any PC adjustment, is passed in to the call back in the Value
 * field.  The symbolic information about the operand is returned using all
 * the fields of the structure with the Offset of the relocatable expression
 * returned in the Value field.  It is possible that some symbols in the
 * relocatable expression were assembly temporary symbols, for example
 * "Ldata - LpicBase + constant", and only the Values of the symbols without
 * symbol names are present in the relocation information.  The VariantKind
 * type is one of the Target specific #defines below and is used to print
 * operands like "_foo@GOT", ":lower16:_foo", etc.
 *)
(*
struct LLVMOpInfoSymbol1 {
  uint64_t Present;  /* 1 if this symbol is present */
  const char *Name;  /* symbol name if not NULL */
  uint64_t Value;    /* symbol value if name is NULL */
};
*)
  LLVMOpInfoSymbol1 = packed record
    Present: uint64_t;  (* 1 if this symbol is present *)
	Name: PAnsiChar;        (* symbol name if not NULL *)
	Value: uint64_t;    (* symbol value if name is NULL *)
  end;

(*
struct LLVMOpInfo1 {
  struct LLVMOpInfoSymbol1 AddSymbol;
  struct LLVMOpInfoSymbol1 SubtractSymbol;
  uint64_t Value;
  uint64_t VariantKind;
};
*)
  LLVMOpInfo1 = packed record
    AddSymbol: LLVMOpInfoSymbol1;
	SubtractSymbol: LLVMOpInfoSymbol1;
	Value: uint64_t;
	VariantKind: uint64_t;
  end;

(*
 * The operand VariantKinds for symbolic disassembly.
 *)
  //#define LLVMDisassembler_VariantKind_None 0 /* all targets */
const
  LLVMDisassembler_VariantKind_None = 0;

(*
 * The ARM target VariantKinds.
 *)
  //#define LLVMDisassembler_VariantKind_ARM_HI16 1 /* :upper16: */
  LLVMDisassembler_VariantKind_ARM_HI16 = 1;
  //#define LLVMDisassembler_VariantKind_ARM_LO16 2 /* :lower16: */
  LLVMDisassembler_VariantKind_ARM_LO16 = 2;

type
(*
 * The type for the symbol lookup function.  This may be called by the
 * disassembler for things like adding a comment for a PC plus a constant
 * offset load instruction to use a symbol name instead of a load address value.
 * It is passed the block information is saved when the disassembler context is
 * created and the ReferenceValue to look up as a symbol.  If no symbol is found
 * for the ReferenceValue NULL is returned.  The ReferenceType of the
 * instruction is passed indirectly as is the PC of the instruction in
 * ReferencePC.  If the output reference can be determined its type is returned
 * indirectly in ReferenceType along with ReferenceName if any, or that is set
 * to NULL.
 *)
  //typedef const char *(*LLVMSymbolLookupCallback)(void *DisInfo,
  //                                              uint64_t ReferenceValue,
  //						uint64_t *ReferenceType,
  //  					    uint64_t ReferencePC,
  //						const char **ReferenceName);
  // #ATTENTION: Not extern!
  LLVMSymbolLookupCallback = function(DisInfo: Pointer; ReferenceValue: uint64_t; ReferenceType: puint64_t; ReferencePC: uint64_t; var ReferenceName: PAnsiChar): PAnsiChar; cdecl;
						
(*
 * The reference types on input and output.
 *)
(* No input reference type or no output reference type. *)
  //#define LLVMDisassembler_ReferenceType_InOut_None 0
const
  LLVMDisassembler_ReferenceType_InOut_None = 0;

(* The input reference is from a branch instruction. *)
  //#define LLVMDisassembler_ReferenceType_In_Branch 1
  LLVMDisassembler_ReferenceType_In_Branch = 1;
(* The input reference is from a PC relative load instruction. *)
  //#define LLVMDisassembler_ReferenceType_In_PCrel_Load 2
  LLVMDisassembler_ReferenceType_In_PCrel_Load = 2;

(* The output reference is to as symbol stub. *)
  //#define LLVMDisassembler_ReferenceType_Out_SymbolStub 1
  LLVMDisassembler_ReferenceType_Out_SymbolStub = 1;
(* The output reference is to a symbol address in a literal pool. *)
  //#define LLVMDisassembler_ReferenceType_Out_LitPool_SymAddr 2
  LLVMDisassembler_ReferenceType_Out_LitPool_SymAddr = 2;
(* The output reference is to a cstring address in a literal pool. *)
  //#define LLVMDisassembler_ReferenceType_Out_LitPool_CstrAddr 3
  LLVMDisassembler_ReferenceType_Out_LitPool_CstrAddr = 3;

(*
 * Create a disassembler for the TripleName.  Symbolic disassembly is supported
 * by passing a block of information in the DisInfo parameter and specifying the
 * TagType and callback functions as described above.  These can all be passed
 * as NULL.  If successful, this returns a disassembler context.  If not, it
 * returns NULL.
 *)
  //LLVMDisasmContextRef LLVMCreateDisasm(const char *TripleName, void *DisInfo,
  //                                    int TagType, LLVMOpInfoCallback GetOpInfo,
  //                                    LLVMSymbolLookupCallback SymbolLookUp);
{$IFDEF LLVM_DYNAMIC_LINK}
type
  TLLVMCreateDisasm = function(TripleName: PAnsiChar; DisInfo: Pointer; TagType: Integer; GetOpInfo: LLVMOpInfoCallback; SymbolLookUp: LLVMSymbolLookupCallback): LLVMDisasmContextRef; cdecl;
{$ELSE}
  function LLVMCreateDisasm(TripleName: PAnsiChar; DisInfo: Pointer; TagType: Integer; GetOpInfo: LLVMOpInfoCallback; SymbolLookUp: LLVMSymbolLookupCallback): LLVMDisasmContextRef; cdecl; external LLVMLibrary name 'LLVMCreateDisasm';
{$ENDIF}

(*
 * Dispose of a disassembler context.
 *)
  //void LLVMDisasmDispose(LLVMDisasmContextRef DC);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisasmDispose = procedure(DC: LLVMDisasmContextRef); cdecl;
{$ELSE}
  procedure LLVMDisasmDispose(DC: LLVMDisasmContextRef); cdecl; external LLVMLibrary name 'LLVMDisasmDispose';
{$ENDIF}

(*
 * Disassemble a single instruction using the disassembler context specified in
 * the parameter DC.  The bytes of the instruction are specified in the
 * parameter Bytes, and contains at least BytesSize number of bytes.  The
 * instruction is at the address specified by the PC parameter.  If a valid
 * instruction can be disassembled, its string is returned indirectly in
 * OutString whose size is specified in the parameter OutStringSize.  This
 * function returns the number of bytes in the instruction or zero if there was
 * no valid instruction.
 *)
  //size_t LLVMDisasmInstruction(LLVMDisasmContextRef DC, uint8_t *Bytes,
  //                           uint64_t BytesSize, uint64_t PC,
  //                           char *OutString, size_t OutStringSize);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMDisasmInstruction = function(DC: LLVMDisasmContextRef; Bytes: PByte; BytesSize: uint64_t; PC: uint64_t; OutString: PAnsiChar; OutStringSize: size_t): size_t;
{$ELSE}
  function LLVMDisasmInstruction(DC: LLVMDisasmContextRef; Bytes: PByte; BytesSize: uint64_t; PC: uint64_t; OutString: PAnsiChar; OutStringSize: size_t): size_t; external LLVMLibrary name 'LLVMDisasmInstruction';
{$ENDIF}
  
{$ENDIF}
//*------------------------------------------------- END of Disassembler.h -------------------------------------------------*//
  
  
//*================================================= START of lto.h =================================================*//
{$IFDEF LLVM_API_LTO}

  //#define LTO_API_VERSION 4
const
  LTO_API_VERSION = 4;

type
(*
typedef enum {
    LTO_SYMBOL_ALIGNMENT_MASK              = 0x0000001F, /* log2 of alignment */
    LTO_SYMBOL_PERMISSIONS_MASK            = 0x000000E0,
    LTO_SYMBOL_PERMISSIONS_CODE            = 0x000000A0,
    LTO_SYMBOL_PERMISSIONS_DATA            = 0x000000C0,
    LTO_SYMBOL_PERMISSIONS_RODATA          = 0x00000080,
    LTO_SYMBOL_DEFINITION_MASK             = 0x00000700,
    LTO_SYMBOL_DEFINITION_REGULAR          = 0x00000100,
    LTO_SYMBOL_DEFINITION_TENTATIVE        = 0x00000200,
    LTO_SYMBOL_DEFINITION_WEAK             = 0x00000300,
    LTO_SYMBOL_DEFINITION_UNDEFINED        = 0x00000400,
    LTO_SYMBOL_DEFINITION_WEAKUNDEF        = 0x00000500,
    LTO_SYMBOL_SCOPE_MASK                  = 0x00003800,
    LTO_SYMBOL_SCOPE_INTERNAL              = 0x00000800,
    LTO_SYMBOL_SCOPE_HIDDEN                = 0x00001000,
    LTO_SYMBOL_SCOPE_PROTECTED             = 0x00002000,
    LTO_SYMBOL_SCOPE_DEFAULT               = 0x00001800,
    LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN = 0x00002800
} lto_symbol_attributes;
*)
  lto_symbol_attributes = (
    LTO_SYMBOL_ALIGNMENT_MASK              = $0000001F, (* log2 of alignment *)
    LTO_SYMBOL_PERMISSIONS_MASK            = $000000E0,
    LTO_SYMBOL_PERMISSIONS_CODE            = $000000A0,
    LTO_SYMBOL_PERMISSIONS_DATA            = $000000C0,
    LTO_SYMBOL_PERMISSIONS_RODATA          = $00000080,
    LTO_SYMBOL_DEFINITION_MASK             = $00000700,
    LTO_SYMBOL_DEFINITION_REGULAR          = $00000100,
    LTO_SYMBOL_DEFINITION_TENTATIVE        = $00000200,
    LTO_SYMBOL_DEFINITION_WEAK             = $00000300,
    LTO_SYMBOL_DEFINITION_UNDEFINED        = $00000400,
    LTO_SYMBOL_DEFINITION_WEAKUNDEF        = $00000500,
    LTO_SYMBOL_SCOPE_MASK                  = $00003800,
    LTO_SYMBOL_SCOPE_INTERNAL              = $00000800,
    LTO_SYMBOL_SCOPE_HIDDEN                = $00001000,
    LTO_SYMBOL_SCOPE_PROTECTED             = $00002000,
    LTO_SYMBOL_SCOPE_DEFAULT               = $00001800,
    LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN = $00002800
  );  

(*
typedef enum {
    LTO_DEBUG_MODEL_NONE         = 0,
    LTO_DEBUG_MODEL_DWARF        = 1
} lto_debug_model;
*)
  lto_debug_model = (
    LTO_DEBUG_MODEL_NONE         = 0,
    LTO_DEBUG_MODEL_DWARF        = 1
  );

(*
typedef enum {
    LTO_CODEGEN_PIC_MODEL_STATIC         = 0,
    LTO_CODEGEN_PIC_MODEL_DYNAMIC        = 1,
    LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC = 2
} lto_codegen_model;
*)
  lto_codegen_model = (
    LTO_CODEGEN_PIC_MODEL_STATIC         = 0,
    LTO_CODEGEN_PIC_MODEL_DYNAMIC        = 1,
    LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC = 2
  );

(* opaque reference to a loaded object module *)
  //typedef struct LTOModule*         lto_module_t;
  LTOModule = packed record
  end;
  lto_module_t = ^LTOModule;

(* opaque reference to a code generator *)
  //typedef struct LTOCodeGenerator*  lto_code_gen_t;
  LTOCodeGenerator = packed record
  end;
  lto_code_gen_t = ^LTOCodeGenerator;

(*
 * Returns a printable string.
 *)
  //extern const char*
  //lto_get_version(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_get_version = function(): PAnsiChar;
{$ELSE}
  function lto_get_version(): PAnsiChar; external LLVMLibrary name 'lto_get_version';
{$ENDIF}

(*
 * Returns the last error string or NULL if last operation was successful.
 *)
  //extern const char*
  //lto_get_error_message(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_get_error_message = function(): PAnsiChar;
{$ELSE}
  function lto_get_error_message(): PAnsiChar; external LLVMLibrary name 'lto_get_error_message';
{$ENDIF}

(*
 * Checks if a file is a loadable object file.
 *)
  //extern bool
  //lto_module_is_object_file(const char* path);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_is_object_file = function(path: PAnsiChar): Boolean; cdecl;
{$ELSE}
  function lto_module_is_object_file(path: PAnsiChar): Boolean; cdecl; external LLVMLibrary name 'lto_module_is_object_file';
{$ENDIF}

(*
 * Checks if a file is a loadable object compiled for requested target.
 *)
  //extern bool
  //lto_module_is_object_file_for_target(const char* path,
  //                                   const char* target_triple_prefix);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_is_object_file_for_target = function(path: PAnsiChar; target_triple_prefix: PAnsiChar): Boolean; cdecl;
{$ELSE}
  function lto_module_is_object_file_for_target(path: PAnsiChar; target_triple_prefix: PAnsiChar): Boolean; cdecl; external LLVMLibrary name 'lto_module_is_object_file_for_target';
{$ENDIF}

(*
 * Checks if a buffer is a loadable object file.
 *)
  //extern bool
  //lto_module_is_object_file_in_memory(const void* mem, size_t length);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_is_object_file_in_memory = function(mem: Pointer; length: size_t): Boolean; cdecl;
{$ELSE}
  function lto_module_is_object_file_in_memory(mem: Pointer; length: size_t): Boolean; cdecl; external LLVMLibrary name 'lto_module_is_object_file_in_memory';
{$ENDIF}

(*
 * Checks if a buffer is a loadable object compiled for requested target.
 *)
  //extern bool
  //lto_module_is_object_file_in_memory_for_target(const void* mem, size_t length,
  //                                            const char* target_triple_prefix);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_is_object_file_in_memory_for_target = function(mem: Pointer; length: size_t; target_triple_prefix: PAnsiChar): Boolean; cdecl;
{$ELSE}
  function lto_module_is_object_file_in_memory_for_target(mem: Pointer; length: size_t; target_triple_prefix: PAnsiChar): Boolean; cdecl; external LLVMLibrary name 'lto_module_is_object_file_in_memory_for_target';
{$ENDIF}

(*
 * Loads an object file from disk.
 * Returns NULL on error (check lto_get_error_message() for details).
 *)
  //extern lto_module_t
  //lto_module_create(const char* path);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_create = function(path: PAnsiChar): lto_module_t; cdecl;
{$ELSE}
  function lto_module_create(path: PAnsiChar): lto_module_t; cdecl; external LLVMLibrary name 'lto_module_create';
{$ENDIF}

(*
 * Loads an object file from memory.
 * Returns NULL on error (check lto_get_error_message() for details).
 *)
  //extern lto_module_t
  //lto_module_create_from_memory(const void* mem, size_t length);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_create_from_memory = function(mem: Pointer; length: size_t): lto_module_t; cdecl;
{$ELSE}
  function lto_module_create_from_memory(mem: Pointer; length: size_t): lto_module_t; cdecl; external LLVMLibrary name 'lto_module_create_from_memory';
{$ENDIF}

(*
 * Loads an object file from disk. The seek point of fd is not preserved.
 * Returns NULL on error (check lto_get_error_message() for details).
 *)
  //extern lto_module_t
  //lto_module_create_from_fd(int fd, const char *path, size_t file_size);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_create_from_fd = function(fd: Integer; path: PAnsiChar; file_size: size_t): lto_module_t; cdecl;
{$ELSE}
  function lto_module_create_from_fd(fd: Integer; path: PAnsiChar; file_size: size_t): lto_module_t; cdecl; external LLVMLibrary name 'lto_module_create_from_fd';
{$ENDIF}

(*
 * Loads an object file from disk. The seek point of fd is not preserved.
 * Returns NULL on error (check lto_get_error_message() for details).
 *)
  //extern lto_module_t
  //lto_module_create_from_fd_at_offset(int fd, const char *path, size_t file_size,
  //                                  size_t map_size, off_t offset);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_create_from_fd_at_offset = function(fd: Integer; path: PAnsiChar; file_size: size_t; map_size: size_t; offset: off_t): lto_module_t; cdecl;
{$ELSE}
  function lto_module_create_from_fd_at_offset(fd: Integer; path: PAnsiChar; file_size: size_t; map_size: size_t; offset: off_t): lto_module_t; cdecl;  external LLVMLibrary name 'lto_module_create_from_fd_at_offset';
{$ENDIF}

(*
 * Frees all memory internally allocated by the module.
 * Upon return the lto_module_t is no longer valid.
 *)
  //extern void
  //lto_module_dispose(lto_module_t mod);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_dispose = procedure(_mod: lto_module_t); cdecl;
{$ELSE}
  procedure lto_module_dispose(_mod: lto_module_t); cdecl; external LLVMLibrary name 'lto_module_dispose';
{$ENDIF}

(*
 * Returns triple string which the object module was compiled under.
 *)
  //extern const char*
  //lto_module_get_target_triple(lto_module_t mod);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_get_target_triple = function(_mod: lto_module_t): PAnsiChar; cdecl;
{$ELSE}
  function lto_module_get_target_triple(_mod: lto_module_t): PAnsiChar; cdecl; external LLVMLibrary name 'lto_module_get_target_triple';
{$ENDIF}

(*
 * Sets triple string with which the object will be codegened.
 *)
  //extern void
  //lto_module_set_target_triple(lto_module_t mod, const char *triple);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_set_target_triple = procedure(_mod: lto_module_t; triple: PAnsiChar); cdecl;
{$ELSE}
  procedure lto_module_set_target_triple(_mod: lto_module_t; triple: PAnsiChar); cdecl; external LLVMLibrary name 'lto_module_set_target_triple';
{$ENDIF}

(*
 * Returns the number of symbols in the object module.
 *)
  //extern unsigned int
  //lto_module_get_num_symbols(lto_module_t mod);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_get_num_symbols = function(_mod: lto_module_t): Integer; cdecl;
{$ELSE}
  function lto_module_get_num_symbols(_mod: lto_module_t): Integer; cdecl; external LLVMLibrary name 'lto_module_get_num_symbols';
{$ENDIF}

(*
 * Returns the name of the ith symbol in the object module.
 *)
  //extern const char*
  //lto_module_get_symbol_name(lto_module_t mod, unsigned int index);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_get_symbol_name = function(_mod: lto_module_t; index: Cardinal): PAnsiChar; cdecl;
{$ELSE}
  function lto_module_get_symbol_name(_mod: lto_module_t; index: Cardinal): PAnsiChar; cdecl; external LLVMLibrary name 'lto_module_get_symbol_name';
{$ENDIF}

(*
 * Returns the attributes of the ith symbol in the object module.
 *)
  //extern lto_symbol_attributes
  //lto_module_get_symbol_attribute(lto_module_t mod, unsigned int index);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_module_get_symbol_attribute = function(_mod: lto_module_t; index: Cardinal): lto_symbol_attributes; cdecl;
{$ELSE}
  function lto_module_get_symbol_attribute(_mod: lto_module_t; index: Cardinal): lto_symbol_attributes; cdecl; external LLVMLibrary name 'lto_module_get_symbol_attribute';
{$ENDIF}

(*
 * Instantiates a code generator.
 * Returns NULL on error (check lto_get_error_message() for details).
 *)
  //extern lto_code_gen_t
  //lto_codegen_create(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_create = function(): lto_code_gen_t; cdecl;
{$ELSE}
  function lto_codegen_create(): lto_code_gen_t; cdecl; external LLVMLibrary name 'lto_codegen_create';
{$ENDIF}

(*
 * Frees all code generator and all memory it internally allocated.
 * Upon return the lto_code_gen_t is no longer valid.
 *)
  //extern void
  //lto_codegen_dispose(lto_code_gen_t);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_dispose = procedure(Unknown: lto_code_gen_t); cdecl;
{$ELSE}
  procedure lto_codegen_dispose(Unknown: lto_code_gen_t); cdecl; external LLVMLibrary name 'lto_codegen_dispose';
{$ENDIF}

(*
 * Add an object module to the set of modules for which code will be generated.
 * Returns true on error (check lto_get_error_message() for details).
 *)
  //extern bool
  //lto_codegen_add_module(lto_code_gen_t cg, lto_module_t mod);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_add_module = function(cg: lto_code_gen_t; _mod: lto_module_t): Boolean; cdecl;
{$ELSE}
  function lto_codegen_add_module(cg: lto_code_gen_t; _mod: lto_module_t): Boolean; cdecl; external LLVMLibrary name 'lto_codegen_add_module';
{$ENDIF}

(*
 * Sets if debug info should be generated.
 * Returns true on error (check lto_get_error_message() for details).
 *)
  //extern bool
  //lto_codegen_set_debug_model(lto_code_gen_t cg, lto_debug_model);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_set_debug_model = function(cg: lto_code_gen_t; Unknown: lto_debug_model): Boolean; cdecl;
{$ELSE}
  function lto_codegen_set_debug_model(cg: lto_code_gen_t; Unknown: lto_debug_model): Boolean; cdecl; external LLVMLibrary name 'lto_codegen_set_debug_model';
{$ENDIF}

(*
 * Sets which PIC code model to generated.
 * Returns true on error (check lto_get_error_message() for details).
 *)
  //extern bool
  //lto_codegen_set_pic_model(lto_code_gen_t cg, lto_codegen_model);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_set_pic_model = function(cg: lto_code_gen_t; Unknown: lto_codegen_model): Boolean; cdecl;
{$ELSE}
  function lto_codegen_set_pic_model(cg: lto_code_gen_t; Unknown: lto_codegen_model): Boolean; cdecl; external LLVMLibrary name 'lto_codegen_set_pic_model';
{$ENDIF}

(*
 * Sets the cpu to generate code for.
 *)
  //extern void
  //lto_codegen_set_cpu(lto_code_gen_t cg, const char *cpu);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_set_cpu = procedure(cg: lto_code_gen_t; cpu: PAnsiChar); cdecl;
{$ELSE}
  procedure lto_codegen_set_cpu(cg: lto_code_gen_t; cpu: PAnsiChar); cdecl; external LLVMLibrary name 'lto_codegen_set_cpu';
{$ENDIF}

(*
 * Sets the location of the assembler tool to run. If not set, libLTO
 * will use gcc to invoke the assembler.
 *)
  //extern void
  //lto_codegen_set_assembler_path(lto_code_gen_t cg, const char* path);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_set_assembler_path = procedure(cg: lto_code_gen_t; path: PAnsiChar); cdecl;
{$ELSE}
  procedure lto_codegen_set_assembler_path(cg: lto_code_gen_t; path: PAnsiChar); cdecl; external LLVMLibrary name 'lto_codegen_set_assembler_path';
{$ENDIF}

(*
 * Sets extra arguments that libLTO should pass to the assembler.
 *)
  //extern void
  //lto_codegen_set_assembler_args(lto_code_gen_t cg, const char **args,
  //                             int nargs);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_set_assembler_args = procedure(cg: lto_code_gen_t; var args: PAnsiChar; nargs: Integer); cdecl;
{$ELSE}
  procedure lto_codegen_set_assembler_args(cg: lto_code_gen_t; var args: PAnsiChar; nargs: Integer); cdecl; external LLVMLibrary name 'lto_codegen_set_assembler_args';
{$ENDIF}

(*
 * Adds to a list of all global symbols that must exist in the final
 * generated code.  If a function is not listed, it might be
 * inlined into every usage and optimized away.
 *)
  //extern void
  //lto_codegen_add_must_preserve_symbol(lto_code_gen_t cg, const char* symbol);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_add_must_preserve_symbol = procedure(cg: lto_code_gen_t; symbol: PAnsiChar); cdecl;
{$ELSE}
  procedure lto_codegen_add_must_preserve_symbol(cg: lto_code_gen_t; symbol: PAnsiChar); cdecl; external LLVMLibrary name 'lto_codegen_add_must_preserve_symbol';
{$ENDIF}

(*
 * Writes a new object file at the specified path that contains the
 * merged contents of all modules added so far.
 * Returns true on error (check lto_get_error_message() for details).
 *)
  //extern bool
  //lto_codegen_write_merged_modules(lto_code_gen_t cg, const char* path);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_write_merged_modules = function(cg: lto_code_gen_t; path: PAnsiChar): Boolean; cdecl;
{$ELSE}
  function lto_codegen_write_merged_modules(cg: lto_code_gen_t; path: PAnsiChar): Boolean; cdecl; external LLVMLibrary name 'lto_codegen_write_merged_modules';
{$ENDIF}

(*
 * Generates code for all added modules into one native object file.
 * On success returns a pointer to a generated mach-o/ELF buffer and
 * length set to the buffer size.  The buffer is owned by the
 * lto_code_gen_t and will be freed when lto_codegen_dispose()
 * is called, or lto_codegen_compile() is called again.
 * On failure, returns NULL (check lto_get_error_message() for details).
 *)
  //extern const void*
  //lto_codegen_compile(lto_code_gen_t cg, size_t* length);
  // #WARNING
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_compile = function(cg: lto_code_gen_t; length: psize_t): Pointer; cdecl;
{$ELSE}
  function lto_codegen_compile(cg: lto_code_gen_t; length: psize_t): Pointer; cdecl; external LLVMLibrary name 'lto_codegen_compile';
{$ENDIF}

(*
 * Generates code for all added modules into one native object file.
 * The name of the file is written to name. Returns true on error.
 *)
  //extern bool
  //lto_codegen_compile_to_file(lto_code_gen_t cg, const char** name);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_compile_to_file = function(cg: lto_code_gen_t; var name: PAnsiChar): Boolean; cdecl;
{$ELSE}
  function lto_codegen_compile_to_file(cg: lto_code_gen_t; var name: PAnsiChar): Boolean; cdecl; external LLVMLibrary name 'lto_codegen_compile_to_file';
{$ENDIF}

(*
 * Sets options to help debug codegen bugs.
 *)
  //extern void
  //lto_codegen_debug_options(lto_code_gen_t cg, const char *);
{$IFDEF LLVM_DYNAMIC_LINK}
  Tlto_codegen_debug_options = procedure(cg: lto_code_gen_t; unknown: PAnsiChar); cdecl;
{$ELSE}
  procedure lto_codegen_debug_options(cg: lto_code_gen_t; unknown: PAnsiChar); cdecl; external LLVMLibrary name 'lto_codegen_debug_options';
{$ENDIF}

{$ENDIF}
//*------------------------------------------------- END of lto.h -------------------------------------------------*//


//*================================================= START of EnhancedDisassembly.h =================================================*//
{$IFDEF LLVM_API_ENHANCEDDISASSEMBLY}

type
(*
 * @defgroup LLVMCEnhancedDisassembly Enhanced Disassembly
 * @ingroup LLVMC
 * @deprecated
 *
 * This module contains an interface to the Enhanced Disassembly (edis)
 * library. The edis library is deprecated and will likely disappear in
 * the near future. You should use the @ref LLVMCDisassembler interface
 * instead.
 *
 * @{
 *)

(*!
 @typedef EDByteReaderCallback
 Interface to memory from which instructions may be read.
 @param byte A pointer whose target should be filled in with the data returned.
 @param address The address of the byte to be read.
 @param arg An anonymous argument for client use.
 @result 0 on success; -1 otherwise.
 *)
  //typedef int (*EDByteReaderCallback)(uint8_t *byte, uint64_t address, void *arg);
  // #ATTENTION: Not extern!
  EDByteReaderCallback = function(_byte: PByte; address: uint64_t; arg: Pointer): Integer; cdecl;

(*!
 @typedef EDRegisterReaderCallback
 Interface to registers from which registers may be read.
 @param value A pointer whose target should be filled in with the value of the
   register.
 @param regID The LLVM register identifier for the register to read.
 @param arg An anonymous argument for client use.
 @result 0 if the register could be read; -1 otherwise.
 *)
  //typedef int (*EDRegisterReaderCallback)(uint64_t *value, unsigned regID,
  //                                      void* arg);
  // #ATTENTION: Not extern!
  EDRegisterReaderCallback = function(value: puint64_t; regID: Cardinal; arg: Pointer): Integer; cdecl;

(*!
 @typedef EDAssemblySyntax_t
 An assembly syntax for use in tokenizing instructions.
 *)
 (*
enum {
//! @constant kEDAssemblySyntaxX86Intel Intel syntax for i386 and x86_64.
  kEDAssemblySyntaxX86Intel  = 0,
//! @constant kEDAssemblySyntaxX86ATT AT&T syntax for i386 and x86_64.
  kEDAssemblySyntaxX86ATT    = 1,
  kEDAssemblySyntaxARMUAL    = 2
};
*)
  _EDAssemblySyntax = (
    //! @constant kEDAssemblySyntaxX86Intel Intel syntax for i386 and x86_64.
    kEDAssemblySyntaxX86Intel  = 0,
    //! @constant kEDAssemblySyntaxX86ATT AT&T syntax for i386 and x86_64.
    kEDAssemblySyntaxX86ATT    = 1,
    kEDAssemblySyntaxARMUAL    = 2
  );
  //typedef unsigned EDAssemblySyntax_t;
  EDAssemblySyntax_t = Cardinal;
  // #ATTENTION: May be merge types?

(*!
 @typedef EDDisassemblerRef
 Encapsulates a disassembler for a single CPU architecture.
 *)
  //typedef void *EDDisassemblerRef;
  EDDisassemblerRef = Pointer;

(*!
 @typedef EDInstRef
 Encapsulates a single disassembled instruction in one assembly syntax.
 *)
  //typedef void *EDInstRef;
  EDInstRef = Pointer;

(*!
 @typedef EDTokenRef
 Encapsulates a token from the disassembly of an instruction.
 *)
  //typedef void *EDTokenRef;
  EDTokenRef = Pointer;

(*!
 @typedef EDOperandRef
 Encapsulates an operand of an instruction.
 *)
  //typedef void *EDOperandRef;
  EDOperandRef = Pointer;

(*!
 @functiongroup Getting a disassembler
 *)

(*!
 @function EDGetDisassembler
 Gets the disassembler for a given target.
 @param disassembler A pointer whose target will be filled in with the
   disassembler.
 @param triple Identifies the target.  Example: "x86_64-apple-darwin10"
 @param syntax The assembly syntax to use when decoding instructions.
 @result 0 on success; -1 otherwise.
 *)
  //int EDGetDisassembler(EDDisassemblerRef *disassembler,
  //                    const char *triple,
  //                    EDAssemblySyntax_t syntax);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDGetDisassembler = function(var disassembler: EDDisassemblerRef; triple: PAnsiChar; syntax: EDAssemblySyntax_t): Integer; cdecl;
{$ELSE}
  function EDGetDisassembler(var disassembler: EDDisassemblerRef; triple: PAnsiChar; syntax: EDAssemblySyntax_t): Integer; cdecl; external LLVMLibrary name 'EDGetDisassembler';
{$ENDIF}
  
(*!
 @functiongroup Generic architectural queries
 *)

(*!
 @function EDGetRegisterName
 Gets the human-readable name for a given register.
 @param regName A pointer whose target will be pointed at the name of the
   register.  The name does not need to be deallocated and will be
 @param disassembler The disassembler to query for the name.
 @param regID The register identifier, as returned by EDRegisterTokenValue.
 @result 0 on success; -1 otherwise.
 *)
  //int EDGetRegisterName(const char** regName,
  //                    EDDisassemblerRef disassembler,
  //                    unsigned regID);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDGetRegisterName = function(var regName: PAnsiChar; disassembler: EDDisassemblerRef; regID: Cardinal): Integer; cdecl;
{$ELSE}
  function EDGetRegisterName(var regName: PAnsiChar; disassembler: EDDisassemblerRef; regID: Cardinal): Integer; cdecl; external LLVMLibrary name 'EDGetRegisterName';
{$ENDIF}

(*!
 @function EDRegisterIsStackPointer
 Determines if a register is one of the platform's stack-pointer registers.
 @param disassembler The disassembler to query.
 @param regID The register identifier, as returned by EDRegisterTokenValue.
 @result 1 if true; 0 otherwise.
 *)
  //int EDRegisterIsStackPointer(EDDisassemblerRef disassembler,
  //                           unsigned regID);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDRegisterIsStackPointer = function(disassembler: EDDisassemblerRef; regID: Cardinal): Integer; cdecl;
{$ELSE}
  function EDRegisterIsStackPointer(disassembler: EDDisassemblerRef; regID: Cardinal): Integer; cdecl; external LLVMLibrary name 'EDRegisterIsStackPointer';
{$ENDIF}

(*!
 @function EDRegisterIsProgramCounter
 Determines if a register is one of the platform's stack-pointer registers.
 @param disassembler The disassembler to query.
 @param regID The register identifier, as returned by EDRegisterTokenValue.
 @result 1 if true; 0 otherwise.
 *)
  //int EDRegisterIsProgramCounter(EDDisassemblerRef disassembler,
  //                             unsigned regID);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDRegisterIsProgramCounter = function(disassembler: EDDisassemblerRef; regID: Cardinal): Integer; cdecl;
{$ELSE}
  function EDRegisterIsProgramCounter(disassembler: EDDisassemblerRef; regID: Cardinal): Integer; cdecl; external LLVMLibrary name 'EDRegisterIsProgramCounter';
{$ENDIF}

(*!
 @functiongroup Creating and querying instructions
 *)

(*!
 @function EDCreateInst
 Gets a set of contiguous instructions from a disassembler.
 @param insts A pointer to an array that will be filled in with the
   instructions.  Must have at least count entries.  Entries not filled in will
   be set to NULL.
 @param count The maximum number of instructions to fill in.
 @param disassembler The disassembler to use when decoding the instructions.
 @param byteReader The function to use when reading the instruction's machine
   code.
 @param address The address of the first byte of the instruction.
 @param arg An anonymous argument to be passed to byteReader.
 @result The number of instructions read on success; 0 otherwise.
 *)
  //unsigned int EDCreateInsts(EDInstRef *insts,
  //                         unsigned int count,
  //                         EDDisassemblerRef disassembler,
  //                         EDByteReaderCallback byteReader,
  //                         uint64_t address,
  //                         void *arg);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDCreateInsts = function(var insts: EDInstRef; count: Cardinal; disassembler: EDDisassemblerRef; byteReader: EDByteReaderCallback; address: uint64_t; arg: Pointer): Cardinal; cdecl;
{$ELSE}
  function EDCreateInsts(var insts: EDInstRef; count: Cardinal; disassembler: EDDisassemblerRef; byteReader: EDByteReaderCallback; address: uint64_t; arg: Pointer): Cardinal; cdecl; external LLVMLibrary name 'EDCreateInsts';
{$ENDIF}

(*!
 @function EDReleaseInst
 Frees the memory for an instruction.  The instruction can no longer be accessed
 after this call.
 @param inst The instruction to be freed.
 *)
  //void EDReleaseInst(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDReleaseInst = procedure(inst: EDInstRef); cdecl;
{$ELSE}
  procedure EDReleaseInst(inst: EDInstRef); cdecl; external LLVMLibrary name 'EDReleaseInst';
{$ENDIF}

(*!
 @function EDInstByteSize
 @param inst The instruction to be queried.
 @result The number of bytes in the instruction's machine-code representation.
 *)
  //int EDInstByteSize(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDInstByteSize = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDInstByteSize(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDInstByteSize';
{$ENDIF}

(*!
 @function EDGetInstString
 Gets the disassembled text equivalent of the instruction.
 @param buf A pointer whose target will be filled in with a pointer to the
   string.  (The string becomes invalid when the instruction is released.)
 @param inst The instruction to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDGetInstString(const char **buf,
  //                  EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDGetInstString = function(var buf: PAnsiChar; inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDGetInstString(var buf: PAnsiChar; inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDGetInstString';
{$ENDIF}

(*!
 @function EDInstID
 @param instID A pointer whose target will be filled in with the LLVM identifier
   for the instruction.
 @param inst The instruction to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDInstID(unsigned *instID, EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDInstID = function(var instID: Cardinal; inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDInstID(var instID: Cardinal; inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDInstID';
{$ENDIF}

(*!
 @function EDInstIsBranch
 @param inst The instruction to be queried.
 @result 1 if the instruction is a branch instruction; 0 if it is some other
   type of instruction; -1 if there was an error.
 *)
  //int EDInstIsBranch(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDInstIsBranch = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDInstIsBranch(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDInstIsBranch';
{$ENDIF}

(*!
 @function EDInstIsMove
 @param inst The instruction to be queried.
 @result 1 if the instruction is a move instruction; 0 if it is some other
   type of instruction; -1 if there was an error.
 *)
  //int EDInstIsMove(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDInstIsMove = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDInstIsMove(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDInstIsMove';
{$ENDIF}

(*!
 @function EDBranchTargetID
 @param inst The instruction to be queried.
 @result The ID of the branch target operand, suitable for use with
   EDCopyOperand.  -1 if no such operand exists.
 *)
  //int EDBranchTargetID(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDBranchTargetID = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDBranchTargetID(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDBranchTargetID';
{$ENDIF}

(*!
 @function EDMoveSourceID
 @param inst The instruction to be queried.
 @result The ID of the move source operand, suitable for use with
   EDCopyOperand.  -1 if no such operand exists.
 *)
  //int EDMoveSourceID(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDMoveSourceID = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDMoveSourceID(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDMoveSourceID';
{$ENDIF}

(*!
 @function EDMoveTargetID
 @param inst The instruction to be queried.
 @result The ID of the move source operand, suitable for use with
   EDCopyOperand.  -1 if no such operand exists.
 *)
  //int EDMoveTargetID(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDMoveTargetID = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDMoveTargetID(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDMoveTargetID';
{$ENDIF}

(*!
 @functiongroup Creating and querying tokens
 *)

(*!
 @function EDNumTokens
 @param inst The instruction to be queried.
 @result The number of tokens in the instruction, or -1 on error.
 *)
  //int EDNumTokens(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDNumTokens = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDNumTokens(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDNumTokens';
{$ENDIF}

(*!
 @function EDGetToken
 Retrieves a token from an instruction.  The token is valid until the
 instruction is released.
 @param token A pointer to be filled in with the token.
 @param inst The instruction to be queried.
 @param index The index of the token in the instruction.
 @result 0 on success; -1 otherwise.
 *)
  //int EDGetToken(EDTokenRef *token,
  //             EDInstRef inst,
  //             int index);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDGetToken = function(var token: EDTokenRef; inst: EDInstRef; index: Integer): Integer; cdecl;
{$ELSE}
  function EDGetToken(var token: EDTokenRef; inst: EDInstRef; index: Integer): Integer; cdecl; external LLVMLibrary name 'EDGetToken';
{$ENDIF}

(*!
 @function EDGetTokenString
 Gets the disassembled text for a token.
 @param buf A pointer whose target will be filled in with a pointer to the
   string.  (The string becomes invalid when the token is released.)
 @param token The token to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDGetTokenString(const char **buf,
  //                   EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDGetTokenString = function(var buf: PAnsiChar; token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDGetTokenString(var buf: PAnsiChar; token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDGetTokenString';
{$ENDIF}

(*!
 @function EDOperandIndexForToken
 Returns the index of the operand to which a token belongs.
 @param token The token to be queried.
 @result The operand index on success; -1 otherwise
 *)
  //int EDOperandIndexForToken(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDOperandIndexForToken = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDOperandIndexForToken(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDOperandIndexForToken';
{$ENDIF}

(*!
 @function EDTokenIsWhitespace
 @param token The token to be queried.
 @result 1 if the token is whitespace; 0 if not; -1 on error.
 *)
  //int EDTokenIsWhitespace(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDTokenIsWhitespace = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDTokenIsWhitespace(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDTokenIsWhitespace';
{$ENDIF}

(*!
 @function EDTokenIsPunctuation
 @param token The token to be queried.
 @result 1 if the token is punctuation; 0 if not; -1 on error.
 *)
  //int EDTokenIsPunctuation(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDTokenIsPunctuation = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDTokenIsPunctuation(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDTokenIsPunctuation';
{$ENDIF}

(*!
 @function EDTokenIsOpcode
 @param token The token to be queried.
 @result 1 if the token is opcode; 0 if not; -1 on error.
 *)
  //int EDTokenIsOpcode(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDTokenIsOpcode = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDTokenIsOpcode(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDTokenIsOpcode';
{$ENDIF}

(*!
 @function EDTokenIsLiteral
 @param token The token to be queried.
 @result 1 if the token is a numeric literal; 0 if not; -1 on error.
 *)
  //int EDTokenIsLiteral(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDTokenIsLiteral = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDTokenIsLiteral(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDTokenIsLiteral';
{$ENDIF}

(*!
 @function EDTokenIsRegister
 @param token The token to be queried.
 @result 1 if the token identifies a register; 0 if not; -1 on error.
 *)
  //int EDTokenIsRegister(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDTokenIsRegister = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDTokenIsRegister(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDTokenIsRegister';
{$ENDIF}

(*!
 @function EDTokenIsNegativeLiteral
 @param token The token to be queried.
 @result 1 if the token is a negative signed literal; 0 if not; -1 on error.
 *)
  //int EDTokenIsNegativeLiteral(EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDTokenIsNegativeLiteral = function(token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDTokenIsNegativeLiteral(token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDTokenIsNegativeLiteral';
{$ENDIF}

(*!
 @function EDLiteralTokenAbsoluteValue
 @param value A pointer whose target will be filled in with the absolute value
   of the literal.
 @param token The token to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDLiteralTokenAbsoluteValue(uint64_t *value,
  //                              EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDLiteralTokenAbsoluteValue = function(value: puint64_t; token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDLiteralTokenAbsoluteValue(value: puint64_t; token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDLiteralTokenAbsoluteValue';
{$ENDIF}

(*!
 @function EDRegisterTokenValue
 @param registerID A pointer whose target will be filled in with the LLVM
   register identifier for the token.
 @param token The token to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDRegisterTokenValue(unsigned *registerID,
  //                       EDTokenRef token);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDRegisterTokenValue = function(registerID: PCardinal; token: EDTokenRef): Integer; cdecl;
{$ELSE}
  function EDRegisterTokenValue(registerID: PCardinal; token: EDTokenRef): Integer; cdecl; external LLVMLibrary name 'EDRegisterTokenValue';
{$ENDIF}

(*!
 @functiongroup Creating and querying operands
 *)

(*!
 @function EDNumOperands
 @param inst The instruction to be queried.
 @result The number of operands in the instruction, or -1 on error.
 *)
  //int EDNumOperands(EDInstRef inst);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDNumOperands = function(inst: EDInstRef): Integer; cdecl;
{$ELSE}
  function EDNumOperands(inst: EDInstRef): Integer; cdecl; external LLVMLibrary name 'EDNumOperands';
{$ENDIF}

(*!
 @function EDGetOperand
 Retrieves an operand from an instruction.  The operand is valid until the
 instruction is released.
 @param operand A pointer to be filled in with the operand.
 @param inst The instruction to be queried.
 @param index The index of the operand in the instruction.
 @result 0 on success; -1 otherwise.
 *)
  //int EDGetOperand(EDOperandRef *operand,
  //               EDInstRef inst,
  //               int index);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDGetOperand = function(var operand: EDOperandRef; inst: EDInstRef; index: Integer): Integer; cdecl;
{$ELSE}
  function EDGetOperand(var operand: EDOperandRef; inst: EDInstRef; index: Integer): Integer; cdecl; external LLVMLibrary name 'EDGetOperand';
{$ENDIF}

(*!
 @function EDOperandIsRegister
 @param operand The operand to be queried.
 @result 1 if the operand names a register; 0 if not; -1 on error.
 *)
  //int EDOperandIsRegister(EDOperandRef operand);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDOperandIsRegister = function(operand: EDOperandRef): Integer; cdecl;
{$ELSE}
  function EDOperandIsRegister(operand: EDOperandRef): Integer; cdecl; external LLVMLibrary name 'EDOperandIsRegister';
{$ENDIF}

(*!
 @function EDOperandIsImmediate
 @param operand The operand to be queried.
 @result 1 if the operand specifies an immediate value; 0 if not; -1 on error.
 *)
  //int EDOperandIsImmediate(EDOperandRef operand);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDOperandIsImmediate = function(operand: EDOperandRef): Integer; cdecl;
{$ELSE}
  function EDOperandIsImmediate(operand: EDOperandRef): Integer; cdecl; external LLVMLibrary name 'EDOperandIsImmediate';
{$ENDIF}

(*!
 @function EDOperandIsMemory
 @param operand The operand to be queried.
 @result 1 if the operand specifies a location in memory; 0 if not; -1 on error.
 *)
  //int EDOperandIsMemory(EDOperandRef operand);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDOperandIsMemory = function(operand: EDOperandRef): Integer; cdecl;
{$ELSE}
  function EDOperandIsMemory(operand: EDOperandRef): Integer; cdecl; external LLVMLibrary name 'EDOperandIsMemory';
{$ENDIF}

(*!
 @function EDRegisterOperandValue
 @param value A pointer whose target will be filled in with the LLVM register ID
   of the register named by the operand.
 @param operand The operand to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDRegisterOperandValue(unsigned *value,
  //                         EDOperandRef operand);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDRegisterOperandValue = function(value: PCardinal; operand: EDOperandRef): Integer; cdecl;
{$ELSE}
  function EDRegisterOperandValue(value: PCardinal; operand: EDOperandRef): Integer; cdecl; external LLVMLibrary name 'EDRegisterOperandValue';
{$ENDIF}

(*!
 @function EDImmediateOperandValue
 @param value A pointer whose target will be filled in with the value of the
   immediate.
 @param operand The operand to be queried.
 @result 0 on success; -1 otherwise.
 *)
  //int EDImmediateOperandValue(uint64_t *value,
  //                          EDOperandRef operand);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDImmediateOperandValue = function(value: puint64_t; operand: EDOperandRef): Integer; cdecl;
{$ELSE}
  function EDImmediateOperandValue(value: puint64_t; operand: EDOperandRef): Integer; cdecl; external LLVMLibrary name 'EDImmediateOperandValue';
{$ENDIF}

(*!
 @function EDEvaluateOperand
 Evaluates an operand using a client-supplied register state accessor.  Register
 operands are evaluated by reading the value of the register; immediate operands
 are evaluated by reporting the immediate value; memory operands are evaluated
 by computing the target address (with only those relocations applied that were
 already applied to the original bytes).
 @param result A pointer whose target is to be filled with the result of
   evaluating the operand.
 @param operand The operand to be evaluated.
 @param regReader The function to use when reading registers from the register
   state.
 @param arg An anonymous argument for client use.
 @result 0 if the operand could be evaluated; -1 otherwise.
 *)
  //int EDEvaluateOperand(uint64_t *result,
  //                    EDOperandRef operand,
  //                    EDRegisterReaderCallback regReader,
  //                    void *arg);
{$IFDEF LLVM_DYNAMIC_LINK}
  TEDEvaluateOperand = function(result: puint64_t; operand: EDOperandRef; regReader: EDRegisterReaderCallback; arg: Pointer): Integer; cdecl;
{$ELSE}
  function EDEvaluateOperand(result: puint64_t; operand: EDOperandRef; regReader: EDRegisterReaderCallback; arg: Pointer): Integer; cdecl; external LLVMLibrary name 'EDEvaluateOperand';
{$ENDIF}

{$IFDEF __BLOCKS__}

(*!
 @typedef EDByteBlock_t
 Block-based interface to memory from which instructions may be read.
 @param byte A pointer whose target should be filled in with the data returned.
 @param address The address of the byte to be read.
 @result 0 on success; -1 otherwise.
 *)
  //typedef int (^EDByteBlock_t)(uint8_t *byte, uint64_t address);


(*!
 @typedef EDRegisterBlock_t
 Block-based interface to registers from which registers may be read.
 @param value A pointer whose target should be filled in with the value of the
   register.
 @param regID The LLVM register identifier for the register to read.
 @result 0 if the register could be read; -1 otherwise.
 *)
  //typedef int (^EDRegisterBlock_t)(uint64_t *value, unsigned regID);

(*!
 @typedef EDTokenVisitor_t
 Block-based handler for individual tokens.
 @param token The current token being read.
 @result 0 to continue; 1 to stop normally; -1 on error.
 *)
  //typedef int (^EDTokenVisitor_t)(EDTokenRef token);

(*! @functiongroup Block-based interfaces *)

(*!
 @function EDBlockCreateInsts
 Gets a set of contiguous instructions from a disassembler, using a block to
 read memory.
 @param insts A pointer to an array that will be filled in with the
   instructions.  Must have at least count entries.  Entries not filled in will
   be set to NULL.
 @param count The maximum number of instructions to fill in.
 @param disassembler The disassembler to use when decoding the instructions.
 @param byteBlock The block to use when reading the instruction's machine
   code.
 @param address The address of the first byte of the instruction.
 @result The number of instructions read on success; 0 otherwise.
 *)
  //unsigned int EDBlockCreateInsts(EDInstRef *insts,
  //                              int count,
  //                              EDDisassemblerRef disassembler,
  //                              EDByteBlock_t byteBlock,
  //                              uint64_t address);

(*!
 @function EDBlockEvaluateOperand
 Evaluates an operand using a block to read registers.
 @param result A pointer whose target is to be filled with the result of
   evaluating the operand.
 @param operand The operand to be evaluated.
 @param regBlock The block to use when reading registers from the register
   state.
 @result 0 if the operand could be evaluated; -1 otherwise.
 *)
  //int EDBlockEvaluateOperand(uint64_t *result,
  //                         EDOperandRef operand,
  //                         EDRegisterBlock_t regBlock);

(*!
 @function EDBlockVisitTokens
 Visits every token with a visitor.
 @param inst The instruction with the tokens to be visited.
 @param visitor The visitor.
 @result 0 if the visit ended normally; -1 if the visitor encountered an error
   or there was some other error.
 *)
  //int EDBlockVisitTokens(EDInstRef inst,
  //                     EDTokenVisitor_t visitor);
					   
{$ENDIF}

{$ENDIF}
//*------------------------------------------------- END of EnhancedDisassembly.h -------------------------------------------------*//


//*================================================= START of IPO.h =================================================*//
{$IFDEF LLVM_API_IPO}

  // See llvm::createArgumentPromotionPass function.
  //void LLVMAddArgumentPromotionPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddArgumentPromotionPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddArgumentPromotionPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddArgumentPromotionPass';
{$ENDIF}

  // See llvm::createConstantMergePass function.
  //void LLVMAddConstantMergePass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddConstantMergePass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddConstantMergePass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddConstantMergePass';
{$ENDIF}

  // See llvm::createDeadArgEliminationPass function.
  //void LLVMAddDeadArgEliminationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddDeadArgEliminationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddDeadArgEliminationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddDeadArgEliminationPass';
{$ENDIF}

  // See llvm::createFunctionAttrsPass function.
  //void LLVMAddFunctionAttrsPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddFunctionAttrsPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddFunctionAttrsPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddFunctionAttrsPass';
{$ENDIF}

  // See llvm::createFunctionInliningPass function.
  //void LLVMAddFunctionInliningPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddFunctionInliningPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddFunctionInliningPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddFunctionInliningPass';
{$ENDIF}

  // See llvm::createAlwaysInlinerPass function.
  //void LLVMAddAlwaysInlinerPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddAlwaysInlinerPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddAlwaysInlinerPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddAlwaysInlinerPass';
{$ENDIF}

  // See llvm::createGlobalDCEPass function.
  //void LLVMAddGlobalDCEPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddGlobalDCEPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddGlobalDCEPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddGlobalDCEPass';
{$ENDIF}

  // See llvm::createGlobalOptimizerPass function.
  //void LLVMAddGlobalOptimizerPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddGlobalOptimizerPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddGlobalOptimizerPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddGlobalOptimizerPass';
{$ENDIF}

  // See llvm::createIPConstantPropagationPass function.
  //void LLVMAddIPConstantPropagationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddIPConstantPropagationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddIPConstantPropagationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddIPConstantPropagationPass';
{$ENDIF}

  // See llvm::createPruneEHPass function.
  //void LLVMAddPruneEHPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddPruneEHPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddPruneEHPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddPruneEHPass';
{$ENDIF}

  // See llvm::createIPSCCPPass function.
  //void LLVMAddIPSCCPPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddIPSCCPPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddIPSCCPPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddIPSCCPPass';
{$ENDIF}

  // See llvm::createInternalizePass function.
  //void LLVMAddInternalizePass(LLVMPassManagerRef, unsigned AllButMain);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddInternalizePass = procedure(Unknown: LLVMPassManagerRef; AllButMain: Cardinal); cdecl;
{$ELSE}
  procedure LLVMAddInternalizePass(Unknown: LLVMPassManagerRef; AllButMain: Cardinal); cdecl; external LLVMLibrary name 'LLVMAddInternalizePass';
{$ENDIF}

  // See llvm::createStripDeadPrototypesPass function.
  //void LLVMAddStripDeadPrototypesPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddStripDeadPrototypesPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddStripDeadPrototypesPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddStripDeadPrototypesPass';
{$ENDIF}

  // See llvm::createStripSymbolsPass function.
  //void LLVMAddStripSymbolsPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddStripSymbolsPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddStripSymbolsPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddStripSymbolsPass';
{$ENDIF}

{$ENDIF}
//*------------------------------------------------- END of IPO.h -------------------------------------------------*//


//*================================================= START of PassManagerBuilder.h =================================================*//
{$IFDEF LLVM_API_PASSMANAGERBUILDER}

type
  //typedef struct LLVMOpaquePassManagerBuilder *LLVMPassManagerBuilderRef;
  LLVMOpaquePassManagerBuilder = packed record
  end;
  LLVMPassManagerBuilderRef = ^LLVMOpaquePassManagerBuilder;

  // See llvm::PassManagerBuilder.
  //LLVMPassManagerBuilderRef LLVMPassManagerBuilderCreate(void);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderCreate = function(): LLVMPassManagerBuilderRef; cdecl; 
{$ELSE}
  function LLVMPassManagerBuilderCreate(): LLVMPassManagerBuilderRef; cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderCreate';
{$ENDIF}
  //void LLVMPassManagerBuilderDispose(LLVMPassManagerBuilderRef PMB);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderDispose = procedure(PMB: LLVMPassManagerBuilderRef); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderDispose(PMB: LLVMPassManagerBuilderRef); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderDispose';
{$ENDIF}

  // See llvm::PassManagerBuilder::OptLevel.
  //void
  //LLVMPassManagerBuilderSetOptLevel(LLVMPassManagerBuilderRef PMB,
  //                                unsigned OptLevel);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderSetOptLevel = procedure(PMB: LLVMPassManagerBuilderRef; OptLevel: Cardinal); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderSetOptLevel(PMB: LLVMPassManagerBuilderRef; OptLevel: Cardinal); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderSetOptLevel';
{$ENDIF}

  // See llvm::PassManagerBuilder::SizeLevel.
  //void
  //LLVMPassManagerBuilderSetSizeLevel(LLVMPassManagerBuilderRef PMB,
  //                                 unsigned SizeLevel);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderSetSizeLevel = procedure(PMB: LLVMPassManagerBuilderRef; SizeLevel: Cardinal); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderSetSizeLevel(PMB: LLVMPassManagerBuilderRef; SizeLevel: Cardinal); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderSetSizeLevel';
{$ENDIF}

  // See llvm::PassManagerBuilder::DisableUnitAtATime.
  //void
  //LLVMPassManagerBuilderSetDisableUnitAtATime(LLVMPassManagerBuilderRef PMB,
  //                                          LLVMBool Value);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderSetDisableUnitAtATime = procedure(PMB: LLVMPassManagerBuilderRef; Value: LLVMBool); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderSetDisableUnitAtATime(PMB: LLVMPassManagerBuilderRef; Value: LLVMBool); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderSetDisableUnitAtATime';
{$ENDIF}

  // See llvm::PassManagerBuilder::DisableUnrollLoops.
  //void
  //LLVMPassManagerBuilderSetDisableUnrollLoops(LLVMPassManagerBuilderRef PMB,
  //                                          LLVMBool Value);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderSetDisableUnrollLoops = procedure(PMB: LLVMPassManagerBuilderRef; Value: LLVMBool); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderSetDisableUnrollLoops(PMB: LLVMPassManagerBuilderRef; Value: LLVMBool); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderSetDisableUnrollLoops';
{$ENDIF}

  // See llvm::PassManagerBuilder::DisableSimplifyLibCalls
  //void
  //LLVMPassManagerBuilderSetDisableSimplifyLibCalls(LLVMPassManagerBuilderRef PMB,
  //                                               LLVMBool Value);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderSetDisableSimplifyLibCalls = procedure(PMB: LLVMPassManagerBuilderRef; Value: LLVMBool); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderSetDisableSimplifyLibCalls(PMB: LLVMPassManagerBuilderRef; Value: LLVMBool); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderSetDisableSimplifyLibCalls';
{$ENDIF}

  // See llvm::PassManagerBuilder::Inliner.
  //void
  //LLVMPassManagerBuilderUseInlinerWithThreshold(LLVMPassManagerBuilderRef PMB,
  //                                            unsigned Threshold);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderUseInlinerWithThreshold = procedure(PMB: LLVMPassManagerBuilderRef; Threshold: Cardinal); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderUseInlinerWithThreshold(PMB: LLVMPassManagerBuilderRef; Threshold: Cardinal); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderUseInlinerWithThreshold';
{$ENDIF}

  // See llvm::PassManagerBuilder::populateFunctionPassManager.
  //void
  //LLVMPassManagerBuilderPopulateFunctionPassManager(LLVMPassManagerBuilderRef PMB,
  //                                                LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderPopulateFunctionPassManager = procedure(PMB: LLVMPassManagerBuilderRef; PM: LLVMPassManagerRef); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderPopulateFunctionPassManager(PMB: LLVMPassManagerBuilderRef; PM: LLVMPassManagerRef); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderPopulateFunctionPassManager';
{$ENDIF}

  // See llvm::PassManagerBuilder::populateModulePassManager.
  //void
  //LLVMPassManagerBuilderPopulateModulePassManager(LLVMPassManagerBuilderRef PMB,
  //                                              LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderPopulateModulePassManager = procedure(PMB: LLVMPassManagerBuilderRef; PM: LLVMPassManagerRef); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderPopulateModulePassManager(PMB: LLVMPassManagerBuilderRef; PM: LLVMPassManagerRef); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderPopulateModulePassManager';
{$ENDIF}

  // See llvm::PassManagerBuilder::populateLTOPassManager.
  //void LLVMPassManagerBuilderPopulateLTOPassManager(LLVMPassManagerBuilderRef PMB,
  //                                                LLVMPassManagerRef PM,
  //                                                bool Internalize,
  //                                                bool RunInliner);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMPassManagerBuilderPopulateLTOPassManager = procedure(PMB: LLVMPassManagerBuilderRef; PM: LLVMPassManagerRef; Internalize: Boolean; RunInliner: Boolean); cdecl; 
{$ELSE}
  procedure LLVMPassManagerBuilderPopulateLTOPassManager(PMB: LLVMPassManagerBuilderRef; PM: LLVMPassManagerRef; Internalize: Boolean; RunInliner: Boolean); cdecl;  external LLVMLibrary name 'LLVMPassManagerBuilderPopulateLTOPassManager';
{$ENDIF}

(*
namespace llvm {
  inline PassManagerBuilder *unwrap(LLVMPassManagerBuilderRef P) {
    return reinterpret_cast<PassManagerBuilder*>(P);
  }

  inline LLVMPassManagerBuilderRef wrap(PassManagerBuilder *P) {
    return reinterpret_cast<LLVMPassManagerBuilderRef>(P);
  }
}
*)
{$ENDIF}
//*------------------------------------------------- END of PassManagerBuilder.h -------------------------------------------------*//


//*================================================= START of Scalar.h =================================================*//
{$IFDEF LLVM_API_SCALAR}

  // See llvm::createAggressiveDCEPass function. 
  //void LLVMAddAggressiveDCEPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddAggressiveDCEPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddAggressiveDCEPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddAggressiveDCEPass';
{$ENDIF}

  // See llvm::createCFGSimplificationPass function. 
  //void LLVMAddCFGSimplificationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddCFGSimplificationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddCFGSimplificationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddCFGSimplificationPass';
{$ENDIF}

  // See llvm::createDeadStoreEliminationPass function. 
  //void LLVMAddDeadStoreEliminationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddDeadStoreEliminationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddDeadStoreEliminationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddDeadStoreEliminationPass';
{$ENDIF}

  // See llvm::createGVNPass function. 
  //void LLVMAddGVNPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddGVNPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddGVNPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddGVNPass';
{$ENDIF}

  // See llvm::createIndVarSimplifyPass function. 
  //void LLVMAddIndVarSimplifyPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddIndVarSimplifyPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddIndVarSimplifyPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddIndVarSimplifyPass';
{$ENDIF}

  // See llvm::createInstructionCombiningPass function. 
  //void LLVMAddInstructionCombiningPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddInstructionCombiningPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddInstructionCombiningPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddInstructionCombiningPass';
{$ENDIF}

  // See llvm::createJumpThreadingPass function. 
  //void LLVMAddJumpThreadingPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddJumpThreadingPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddJumpThreadingPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddJumpThreadingPass';
{$ENDIF}

  // See llvm::createLICMPass function. 
  //void LLVMAddLICMPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLICMPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLICMPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLICMPass';
{$ENDIF}

  // See llvm::createLoopDeletionPass function. 
  //void LLVMAddLoopDeletionPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLoopDeletionPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLoopDeletionPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLoopDeletionPass';
{$ENDIF}

  // See llvm::createLoopIdiomPass function 
  //void LLVMAddLoopIdiomPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLoopIdiomPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLoopIdiomPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLoopIdiomPass';
{$ENDIF}

  // See llvm::createLoopRotatePass function. 
  //void LLVMAddLoopRotatePass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLoopRotatePass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLoopRotatePass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLoopRotatePass';
{$ENDIF}

  // See llvm::createLoopUnrollPass function. 
  //void LLVMAddLoopUnrollPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLoopUnrollPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLoopUnrollPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLoopUnrollPass';
{$ENDIF}

  // See llvm::createLoopUnswitchPass function. 
  //void LLVMAddLoopUnswitchPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLoopUnswitchPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLoopUnswitchPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLoopUnswitchPass';
{$ENDIF}

  // See llvm::createMemCpyOptPass function. 
  //void LLVMAddMemCpyOptPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddMemCpyOptPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddMemCpyOptPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddMemCpyOptPass';
{$ENDIF}

  // See llvm::createPromoteMemoryToRegisterPass function. 
  //void LLVMAddPromoteMemoryToRegisterPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddPromoteMemoryToRegisterPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddPromoteMemoryToRegisterPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddPromoteMemoryToRegisterPass';
{$ENDIF}

  // See llvm::createReassociatePass function. 
  //void LLVMAddReassociatePass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddReassociatePass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddReassociatePass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddReassociatePass';
{$ENDIF}

  // See llvm::createSCCPPass function. 
  //void LLVMAddSCCPPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddSCCPPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddSCCPPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddSCCPPass';
{$ENDIF}

  // See llvm::createScalarReplAggregatesPass function. 
  //void LLVMAddScalarReplAggregatesPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddScalarReplAggregatesPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddScalarReplAggregatesPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddScalarReplAggregatesPass';
{$ENDIF}

  // See llvm::createScalarReplAggregatesPass function. 
  //void LLVMAddScalarReplAggregatesPassSSA(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddScalarReplAggregatesPassSSA = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddScalarReplAggregatesPassSSA(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddScalarReplAggregatesPassSSA';
{$ENDIF}

  // See llvm::createScalarReplAggregatesPass function. 
  //void LLVMAddScalarReplAggregatesPassWithThreshold(LLVMPassManagerRef PM,
  //                                                int Threshold);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddScalarReplAggregatesPassWithThreshold = procedure(PM: LLVMPassManagerRef; Threshold: Integer); cdecl;
{$ELSE}
  procedure LLVMAddScalarReplAggregatesPassWithThreshold(PM: LLVMPassManagerRef; Threshold: Integer); cdecl; external LLVMLibrary name 'LLVMAddScalarReplAggregatesPassWithThreshold';
{$ENDIF}

  // See llvm::createSimplifyLibCallsPass function. 
  //void LLVMAddSimplifyLibCallsPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddSimplifyLibCallsPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddSimplifyLibCallsPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddSimplifyLibCallsPass';
{$ENDIF}

  // See llvm::createTailCallEliminationPass function. 
  //void LLVMAddTailCallEliminationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddTailCallEliminationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddTailCallEliminationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddTailCallEliminationPass';
{$ENDIF}

  // See llvm::createConstantPropagationPass function. 
  //void LLVMAddConstantPropagationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddConstantPropagationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddConstantPropagationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddConstantPropagationPass';
{$ENDIF}

  // See llvm::demotePromoteMemoryToRegisterPass function. 
  //void LLVMAddDemoteMemoryToRegisterPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddDemoteMemoryToRegisterPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddDemoteMemoryToRegisterPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddDemoteMemoryToRegisterPass';
{$ENDIF}

  // See llvm::createVerifierPass function. 
  //void LLVMAddVerifierPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddVerifierPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddVerifierPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddVerifierPass';
{$ENDIF}

  // See llvm::createCorrelatedValuePropagationPass function 
  //void LLVMAddCorrelatedValuePropagationPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddCorrelatedValuePropagationPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddCorrelatedValuePropagationPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddCorrelatedValuePropagationPass';
{$ENDIF}

  // See llvm::createEarlyCSEPass function 
  //void LLVMAddEarlyCSEPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddEarlyCSEPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddEarlyCSEPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddEarlyCSEPass';
{$ENDIF}

  // See llvm::createLowerExpectIntrinsicPass function 
  //void LLVMAddLowerExpectIntrinsicPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddLowerExpectIntrinsicPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddLowerExpectIntrinsicPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddLowerExpectIntrinsicPass';
{$ENDIF}

  // See llvm::createTypeBasedAliasAnalysisPass function 
  //void LLVMAddTypeBasedAliasAnalysisPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddTypeBasedAliasAnalysisPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddTypeBasedAliasAnalysisPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddTypeBasedAliasAnalysisPass';
{$ENDIF}

  // See llvm::createBasicAliasAnalysisPass function 
  //void LLVMAddBasicAliasAnalysisPass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddBasicAliasAnalysisPass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddBasicAliasAnalysisPass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddBasicAliasAnalysisPass';
{$ENDIF}
  
{$ENDIF}
//*------------------------------------------------- END of Scalar.h -------------------------------------------------*//


//*================================================= START of Vectorize.h =================================================*//
{$IFDEF LLVM_API_VECTORIZE}

  // See llvm::createBBVectorizePass function. 
  //void LLVMAddBBVectorizePass(LLVMPassManagerRef PM);
{$IFDEF LLVM_DYNAMIC_LINK}
  TLLVMAddBBVectorizePass = procedure(PM: LLVMPassManagerRef); cdecl;
{$ELSE}
  procedure LLVMAddBBVectorizePass(PM: LLVMPassManagerRef); cdecl; external LLVMLibrary name 'LLVMAddBBVectorizePass';
{$ENDIF}

{$ENDIF}
//*------------------------------------------------- END of Vectorize.h -------------------------------------------------*//

{$IFDEF LLVM_DYNAMIC_LINK}
var
{$IFDEF LLVM_API_CORE}
  LLVMInitializeCore: TLLVMInitializeCore;
  LLVMDisposeMessage: TLLVMDisposeMessage;
  LLVMContextCreate: TLLVMContextCreate;
  LLVMGetGlobalContext: TLLVMGetGlobalContext;
  LLVMContextDispose: TLLVMContextDispose;
  LLVMGetMDKindIDInContext: TLLVMGetMDKindIDInContext;
  LLVMGetMDKindID: TLLVMGetMDKindID;
  LLVMModuleCreateWithName: TLLVMModuleCreateWithName;
  LLVMModuleCreateWithNameInContext: TLLVMModuleCreateWithNameInContext;
  LLVMDisposeModule: TLLVMDisposeModule;
  LLVMGetDataLayout: TLLVMGetDataLayout;
  LLVMSetDataLayout: TLLVMSetDataLayout;
  LLVMGetTarget: TLLVMGetTarget;
  LLVMSetTarget: TLLVMSetTarget;
  LLVMDumpModule: TLLVMDumpModule;
  LLVMSetModuleInlineAsm: TLLVMSetModuleInlineAsm;
  LLVMGetModuleContext: TLLVMGetModuleContext;
  LLVMGetTypeByName: TLLVMGetTypeByName;
  LLVMGetNamedMetadataNumOperands: TLLVMGetNamedMetadataNumOperands;
  LLVMGetNamedMetadataOperands: TLLVMGetNamedMetadataOperands;
  LLVMAddNamedMetadataOperand: TLLVMAddNamedMetadataOperand;
  LLVMAddFunction: TLLVMAddFunction;
  LLVMGetNamedFunction: TLLVMGetNamedFunction;
  LLVMGetFirstFunction: TLLVMGetFirstFunction;
  LLVMGetLastFunction: TLLVMGetLastFunction;
  LLVMGetNextFunction: TLLVMGetNextFunction;
  LLVMGetPreviousFunction: TLLVMGetPreviousFunction;
  LLVMGetTypeKind: TLLVMGetTypeKind;
  LLVMTypeIsSized: TLLVMTypeIsSized;
  LLVMGetTypeContext: TLLVMGetTypeContext;
  LLVMInt1TypeInContext: TLLVMInt1TypeInContext;
  LLVMInt8TypeInContext: TLLVMInt8TypeInContext;
  LLVMInt16TypeInContext: TLLVMInt16TypeInContext;
  LLVMInt32TypeInContext: TLLVMInt32TypeInContext;
  LLVMInt64TypeInContext: TLLVMInt64TypeInContext;
  LLVMIntTypeInContext: TLLVMIntTypeInContext;
  LLVMInt1Type: TLLVMInt1Type;
  LLVMInt8Type: TLLVMInt8Type;
  LLVMInt16Type: TLLVMInt16Type;
  LLVMInt32Type: TLLVMInt32Type;
  LLVMInt64Type: TLLVMInt64Type;
  LLVMIntType: TLLVMIntType;
  LLVMGetIntTypeWidth: TLLVMGetIntTypeWidth;
  LLVMHalfTypeInContext: TLLVMHalfTypeInContext;
  LLVMFloatTypeInContext: TLLVMFloatTypeInContext;
  LLVMDoubleTypeInContext: TLLVMDoubleTypeInContext;
  LLVMX86FP80TypeInContext: TLLVMX86FP80TypeInContext;
  LLVMFP128TypeInContext: TLLVMFP128TypeInContext;
  LLVMPPCFP128TypeInContext: TLLVMPPCFP128TypeInContext;
  LLVMHalfType: TLLVMHalfType;
  LLVMFloatType: TLLVMFloatType;
  LLVMDoubleType: TLLVMDoubleType;
  LLVMX86FP80Type: TLLVMX86FP80Type;
  LLVMFP128Type: TLLVMFP128Type;
  LLVMPPCFP128Type: TLLVMPPCFP128Type;
  LLVMFunctionType: TLLVMFunctionType;
  LLVMIsFunctionVarArg: TLLVMIsFunctionVarArg;
  LLVMGetReturnType: TLLVMGetReturnType;
  LLVMCountParamTypes: TLLVMCountParamTypes;
  LLVMGetParamTypes: TLLVMGetParamTypes;
  LLVMStructTypeInContext: TLLVMStructTypeInContext;
  LLVMStructType: TLLVMStructType;
  LLVMStructCreateNamed: TLLVMStructCreateNamed;
  LLVMGetStructName: TLLVMGetStructName;
  LLVMStructSetBody: TLLVMStructSetBody;
  LLVMCountStructElementTypes: TLLVMCountStructElementTypes;
  LLVMGetStructElementTypes: TLLVMGetStructElementTypes;
  LLVMIsPackedStruct: TLLVMIsPackedStruct;
  LLVMIsOpaqueStruct: TLLVMIsOpaqueStruct;
  LLVMGetElementType: TLLVMGetElementType;
  LLVMArrayType: TLLVMArrayType;
  LLVMGetArrayLength: TLLVMGetArrayLength;
  LLVMPointerType: TLLVMPointerType;
  LLVMGetPointerAddressSpace: TLLVMGetPointerAddressSpace;
  LLVMVectorType: TLLVMVectorType;
  LLVMGetVectorSize: TLLVMGetVectorSize;
  LLVMVoidTypeInContext: TLLVMVoidTypeInContext;
  LLVMLabelTypeInContext: TLLVMLabelTypeInContext;
  LLVMX86MMXTypeInContext: TLLVMX86MMXTypeInContext;
  LLVMVoidType: TLLVMVoidType;
  LLVMLabelType: TLLVMLabelType;
  LLVMX86MMXType: TLLVMX86MMXType;
  LLVMTypeOf: TLLVMTypeOf;
  LLVMGetValueName: TLLVMGetValueName;
  LLVMSetValueName: TLLVMSetValueName;
  LLVMDumpValue: TLLVMDumpValue;
  LLVMReplaceAllUsesWith: TLLVMReplaceAllUsesWith;
  LLVMIsConstant: TLLVMIsConstant;
  LLVMIsUndef: TLLVMIsUndef;
  LLVMIsAArgument: TLLVMIsAArgument;
  LLVMIsABasicBlock: TLLVMIsABasicBlock;
  LLVMIsAInlineAsm: TLLVMIsAInlineAsm;
  LLVMIsAMDNode: TLLVMIsAMDNode;
  LLVMIsAMDString: TLLVMIsAMDString;
  LLVMIsAUser: TLLVMIsAUser;
  LLVMIsAConstant: TLLVMIsAConstant;
  LLVMIsABlockAddress: TLLVMIsABlockAddress;
  LLVMIsAConstantAggregateZero: TLLVMIsAConstantAggregateZero;
  LLVMIsAConstantArray: TLLVMIsAConstantArray;
  LLVMIsAConstantExpr: TLLVMIsAConstantExpr;
  LLVMIsAConstantFP: TLLVMIsAConstantFP;
  LLVMIsAConstantInt: TLLVMIsAConstantInt;
  LLVMIsAConstantPointerNull: TLLVMIsAConstantPointerNull;
  LLVMIsAConstantStruct: TLLVMIsAConstantStruct;
  LLVMIsAConstantVector: TLLVMIsAConstantVector;
  LLVMIsAGlobalValue: TLLVMIsAGlobalValue;
  LLVMIsAFunction: TLLVMIsAFunction;
  LLVMIsAGlobalAlias: TLLVMIsAGlobalAlias;
  LLVMIsAGlobalVariable: TLLVMIsAGlobalVariable;
  LLVMIsAUndefValue: TLLVMIsAUndefValue;
  LLVMIsAInstruction: TLLVMIsAInstruction;
  LLVMIsABinaryOperator: TLLVMIsABinaryOperator;
  LLVMIsACallInst: TLLVMIsACallInst;
  LLVMIsAIntrinsicInst: TLLVMIsAIntrinsicInst;
  LLVMIsADbgInfoIntrinsic: TLLVMIsADbgInfoIntrinsic;
  LLVMIsADbgDeclareInst: TLLVMIsADbgDeclareInst;
  LLVMIsAMemIntrinsic: TLLVMIsAMemIntrinsic;
  LLVMIsAMemCpyInst: TLLVMIsAMemCpyInst;
  LLVMIsAMemMoveInst: TLLVMIsAMemMoveInst;
  LLVMIsAMemSetInst: TLLVMIsAMemSetInst;
  LLVMIsACmpInst: TLLVMIsACmpInst;
  LLVMIsAFCmpInst: TLLVMIsAFCmpInst;
  LLVMIsAICmpInst: TLLVMIsAICmpInst;
  LLVMIsAExtractElementInst: TLLVMIsAExtractElementInst;
  LLVMIsAGetElementPtrInst: TLLVMIsAGetElementPtrInst;
  LLVMIsAInsertElementInst: TLLVMIsAInsertElementInst;
  LLVMIsAInsertValueInst: TLLVMIsAInsertValueInst;
  LLVMIsALandingPadInst: TLLVMIsALandingPadInst;
  LLVMIsAPHINode: TLLVMIsAPHINode;
  LLVMIsASelectInst: TLLVMIsASelectInst;
  LLVMIsAShuffleVectorInst: TLLVMIsAShuffleVectorInst;
  LLVMIsAStoreInst: TLLVMIsAStoreInst;
  LLVMIsATerminatorInst: TLLVMIsATerminatorInst;
  LLVMIsABranchInst: TLLVMIsABranchInst;
  LLVMIsAIndirectBrInst: TLLVMIsAIndirectBrInst;
  LLVMIsAInvokeInst: TLLVMIsAInvokeInst;
  LLVMIsAReturnInst: TLLVMIsAReturnInst;
  LLVMIsASwitchInst: TLLVMIsASwitchInst;
  LLVMIsAUnreachableInst: TLLVMIsAUnreachableInst;
  LLVMIsAResumeInst: TLLVMIsAResumeInst;
  LLVMIsAUnaryInstruction: TLLVMIsAUnaryInstruction;
  LLVMIsAAllocaInst: TLLVMIsAAllocaInst;
  LLVMIsACastInst: TLLVMIsACastInst;
  LLVMIsABitCastInst: TLLVMIsABitCastInst;
  LLVMIsAFPExtInst: TLLVMIsAFPExtInst;
  LLVMIsAFPToSIInst: TLLVMIsAFPToSIInst;
  LLVMIsAFPToUIInst: TLLVMIsAFPToUIInst;
  LLVMIsAFPTruncInst: TLLVMIsAFPTruncInst;
  LLVMIsAIntToPtrInst: TLLVMIsAIntToPtrInst;
  LLVMIsAPtrToIntInst: TLLVMIsAPtrToIntInst;
  LLVMIsASExtInst: TLLVMIsASExtInst;
  LLVMIsASIToFPInst: TLLVMIsASIToFPInst;
  LLVMIsATruncInst: TLLVMIsATruncInst;
  LLVMIsAUIToFPInst: TLLVMIsAUIToFPInst;
  LLVMIsAZExtInst: TLLVMIsAZExtInst;
  LLVMIsAExtractValueInst: TLLVMIsAExtractValueInst;
  LLVMIsALoadInst: TLLVMIsALoadInst;
  LLVMIsAVAArgInst: TLLVMIsAVAArgInst;
  LLVMGetFirstUse: TLLVMGetFirstUse;
  LLVMGetNextUse: TLLVMGetNextUse;
  LLVMGetUser: TLLVMGetUser;
  LLVMGetUsedValue: TLLVMGetUsedValue;
  LLVMGetOperand: TLLVMGetOperand;
  LLVMSetOperand: TLLVMSetOperand;
  LLVMGetNumOperands: TLLVMGetNumOperands;
  LLVMConstNull: TLLVMConstNull;
  LLVMConstAllOnes: TLLVMConstAllOnes;
  LLVMGetUndef: TLLVMGetUndef;
  LLVMIsNull: TLLVMIsNull;
  LLVMConstPointerNull: TLLVMConstPointerNull;
  LLVMConstInt: TLLVMConstInt;
  LLVMConstIntOfArbitraryPrecision: TLLVMConstIntOfArbitraryPrecision;
  LLVMConstIntOfString: TLLVMConstIntOfString;
  LLVMConstIntOfStringAndSize: TLLVMConstIntOfStringAndSize;
  LLVMConstReal: TLLVMConstReal;
  LLVMConstRealOfString: TLLVMConstRealOfString;
  LLVMConstRealOfStringAndSize: TLLVMConstRealOfStringAndSize;
  LLVMConstIntGetZExtValue: TLLVMConstIntGetZExtValue;
  LLVMConstIntGetSExtValue: TLLVMConstIntGetSExtValue;
  LLVMConstStringInContext: TLLVMConstStringInContext;
  LLVMConstString: TLLVMConstString;
  LLVMConstStructInContext: TLLVMConstStructInContext;
  LLVMConstStruct: TLLVMConstStruct;
  LLVMConstArray: TLLVMConstArray;
  LLVMConstNamedStruct: TLLVMConstNamedStruct;
  LLVMConstVector: TLLVMConstVector;
  LLVMGetConstOpcode: TLLVMGetConstOpcode;
  LLVMAlignOf: TLLVMAlignOf;
  LLVMSizeOf: TLLVMSizeOf;
  LLVMConstNeg: TLLVMConstNeg;
  LLVMConstNSWNeg: TLLVMConstNSWNeg;
  LLVMConstNUWNeg: TLLVMConstNUWNeg;
  LLVMConstFNeg: TLLVMConstFNeg;
  LLVMConstNot: TLLVMConstNot;
  LLVMConstAdd: TLLVMConstAdd;
  LLVMConstNSWAdd: TLLVMConstNSWAdd;
  LLVMConstNUWAdd: TLLVMConstNUWAdd;
  LLVMConstFAdd: TLLVMConstFAdd;
  LLVMConstSub: TLLVMConstSub;
  LLVMConstNSWSub: TLLVMConstNSWSub;
  LLVMConstNUWSub: TLLVMConstNUWSub;
  LLVMConstFSub: TLLVMConstFSub;
  LLVMConstMul: TLLVMConstMul;
  LLVMConstNSWMul: TLLVMConstNSWMul;
  LLVMConstNUWMul: TLLVMConstNUWMul;
  LLVMConstFMul: TLLVMConstFMul;
  LLVMConstUDiv: TLLVMConstUDiv;
  LLVMConstSDiv: TLLVMConstSDiv;
  LLVMConstExactSDiv: TLLVMConstExactSDiv;
  LLVMConstFDiv: TLLVMConstFDiv;
  LLVMConstURem: TLLVMConstURem;
  LLVMConstSRem: TLLVMConstSRem;
  LLVMConstFRem: TLLVMConstFRem;
  LLVMConstAnd: TLLVMConstAnd;
  LLVMConstOr: TLLVMConstOr;
  LLVMConstXor: TLLVMConstXor;
  LLVMConstICmp: TLLVMConstICmp;
  LLVMConstFCmp: TLLVMConstFCmp;
  LLVMConstShl: TLLVMConstShl;
  LLVMConstLShr: TLLVMConstLShr;
  LLVMConstAShr: TLLVMConstAShr;
  LLVMConstGEP: TLLVMConstGEP;
  LLVMConstInBoundsGEP: TLLVMConstInBoundsGEP;
  LLVMConstTrunc: TLLVMConstTrunc;
  LLVMConstSExt: TLLVMConstSExt;
  LLVMConstZExt: TLLVMConstZExt;
  LLVMConstFPTrunc: TLLVMConstFPTrunc;
  LLVMConstFPExt: TLLVMConstFPExt;
  LLVMConstUIToFP: TLLVMConstUIToFP;
  LLVMConstSIToFP: TLLVMConstSIToFP;
  LLVMConstFPToUI: TLLVMConstFPToUI;
  LLVMConstFPToSI: TLLVMConstFPToSI;
  LLVMConstPtrToInt: TLLVMConstPtrToInt;
  LLVMConstIntToPtr: TLLVMConstIntToPtr;
  LLVMConstBitCast: TLLVMConstBitCast;
  LLVMConstZExtOrBitCast: TLLVMConstZExtOrBitCast;
  LLVMConstSExtOrBitCast: TLLVMConstSExtOrBitCast;
  LLVMConstTruncOrBitCast: TLLVMConstTruncOrBitCast;
  LLVMConstPointerCast: TLLVMConstPointerCast;
  LLVMConstIntCast: TLLVMConstIntCast;
  LLVMConstFPCast: TLLVMConstFPCast;
  LLVMConstSelect: TLLVMConstSelect;
  LLVMConstExtractElement: TLLVMConstExtractElement;
  LLVMConstInsertElement: TLLVMConstInsertElement;
  LLVMConstShuffleVector: TLLVMConstShuffleVector;
  LLVMConstExtractValue: TLLVMConstExtractValue;
  LLVMConstInsertValue: TLLVMConstInsertValue;
  LLVMConstInlineAsm: TLLVMConstInlineAsm;
  LLVMBlockAddress: TLLVMBlockAddress;
  LLVMGetGlobalParent: TLLVMGetGlobalParent;
  LLVMIsDeclaration: TLLVMIsDeclaration;
  LLVMGetLinkage: TLLVMGetLinkage;
  LLVMSetLinkage: TLLVMSetLinkage;
  LLVMGetSection: TLLVMGetSection;
  LLVMSetSection: TLLVMSetSection;
  LLVMGetVisibility: TLLVMGetVisibility;
  LLVMSetVisibility: TLLVMSetVisibility;
  LLVMGetAlignment: TLLVMGetAlignment;
  LLVMSetAlignment: TLLVMSetAlignment;
  LLVMAddGlobal: TLLVMAddGlobal;
  LLVMAddGlobalInAddressSpace: TLLVMAddGlobalInAddressSpace;
  LLVMGetNamedGlobal: TLLVMGetNamedGlobal;
  LLVMGetFirstGlobal: TLLVMGetFirstGlobal;
  LLVMGetLastGlobal: TLLVMGetLastGlobal;
  LLVMGetNextGlobal: TLLVMGetNextGlobal;
  LLVMGetPreviousGlobal: TLLVMGetPreviousGlobal;
  LLVMDeleteGlobal: TLLVMDeleteGlobal;
  LLVMGetInitializer: TLLVMGetInitializer;
  LLVMSetInitializer: TLLVMSetInitializer;
  LLVMIsThreadLocal: TLLVMIsThreadLocal;
  LLVMSetThreadLocal: TLLVMSetThreadLocal;
  LLVMIsGlobalConstant: TLLVMIsGlobalConstant;
  LLVMSetGlobalConstant: TLLVMSetGlobalConstant;
  LLVMAddAlias: TLLVMAddAlias;
  LLVMDeleteFunction: TLLVMDeleteFunction;
  LLVMGetIntrinsicID: TLLVMGetIntrinsicID;
  LLVMGetFunctionCallConv: TLLVMGetFunctionCallConv;
  LLVMSetFunctionCallConv: TLLVMSetFunctionCallConv;
  LLVMGetGC: TLLVMGetGC;
  LLVMSetGC: TLLVMSetGC;
  LLVMAddFunctionAttr: TLLVMAddFunctionAttr;
  LLVMGetFunctionAttr: TLLVMGetFunctionAttr;
  LLVMRemoveFunctionAttr: TLLVMRemoveFunctionAttr;
  LLVMCountParams: TLLVMCountParams;
  LLVMGetParams: TLLVMGetParams;
  LLVMGetParam: TLLVMGetParam;
  LLVMGetParamParent: TLLVMGetParamParent;
  LLVMGetFirstParam: TLLVMGetFirstParam;
  LLVMGetLastParam: TLLVMGetLastParam;
  LLVMGetNextParam: TLLVMGetNextParam;
  LLVMGetPreviousParam: TLLVMGetPreviousParam;
  LLVMAddAttribute: TLLVMAddAttribute;
  LLVMRemoveAttribute: TLLVMRemoveAttribute;
  LLVMGetAttribute: TLLVMGetAttribute;
  LLVMSetParamAlignment: TLLVMSetParamAlignment;
  LLVMMDStringInContext: TLLVMMDStringInContext;
  LLVMMDString: TLLVMMDString;
  LLVMMDNodeInContext: TLLVMMDNodeInContext;
  LLVMMDNode: TLLVMMDNode;
  LLVMGetMDString: TLLVMGetMDString;
  LLVMBasicBlockAsValue: TLLVMBasicBlockAsValue;
  LLVMValueIsBasicBlock: TLLVMValueIsBasicBlock;
  LLVMValueAsBasicBlock: TLLVMValueAsBasicBlock;
  LLVMGetBasicBlockParent: TLLVMGetBasicBlockParent;
  LLVMGetBasicBlockTerminator: TLLVMGetBasicBlockTerminator;
  LLVMCountBasicBlocks: TLLVMCountBasicBlocks;
  LLVMGetBasicBlocks: TLLVMGetBasicBlocks;
  LLVMGetFirstBasicBlock: TLLVMGetFirstBasicBlock;
  LLVMGetLastBasicBlock: TLLVMGetLastBasicBlock;
  LLVMGetNextBasicBlock: TLLVMGetNextBasicBlock;
  LLVMGetPreviousBasicBlock: TLLVMGetPreviousBasicBlock;
  LLVMGetEntryBasicBlock: TLLVMGetEntryBasicBlock;
  LLVMAppendBasicBlockInContext: TLLVMAppendBasicBlockInContext;
  LLVMAppendBasicBlock: TLLVMAppendBasicBlock;
  LLVMInsertBasicBlockInContext: TLLVMInsertBasicBlockInContext;
  LLVMInsertBasicBlock: TLLVMInsertBasicBlock;
  LLVMDeleteBasicBlock: TLLVMDeleteBasicBlock;
  LLVMRemoveBasicBlockFromParent: TLLVMRemoveBasicBlockFromParent;
  LLVMMoveBasicBlockBefore: TLLVMMoveBasicBlockBefore;
  LLVMMoveBasicBlockAfter: TLLVMMoveBasicBlockAfter;
  LLVMGetFirstInstruction: TLLVMGetFirstInstruction;
  LLVMGetLastInstruction: TLLVMGetLastInstruction;
  LLVMHasMetadata: TLLVMHasMetadata;
  LLVMGetMetadata: TLLVMGetMetadata;
  LLVMSetMetadata: TLLVMSetMetadata;
  LLVMGetInstructionParent: TLLVMGetInstructionParent;
  LLVMGetNextInstruction: TLLVMGetNextInstruction;
  LLVMGetPreviousInstruction: TLLVMGetPreviousInstruction;
  LLVMInstructionEraseFromParent: TLLVMInstructionEraseFromParent;
  LLVMGetInstructionOpcode: TLLVMGetInstructionOpcode;
  LLVMGetICmpPredicate: TLLVMGetICmpPredicate;
  LLVMSetInstructionCallConv: TLLVMSetInstructionCallConv;
  LLVMGetInstructionCallConv: TLLVMGetInstructionCallConv;
  LLVMAddInstrAttribute: TLLVMAddInstrAttribute;
  LLVMRemoveInstrAttribute: TLLVMRemoveInstrAttribute;
  LLVMSetInstrParamAlignment: TLLVMSetInstrParamAlignment;
  LLVMIsTailCall: TLLVMIsTailCall;
  LLVMSetTailCall: TLLVMSetTailCall;
  LLVMGetSwitchDefaultDest: TLLVMGetSwitchDefaultDest;
  LLVMAddIncoming: TLLVMAddIncoming;
  LLVMCountIncoming: TLLVMCountIncoming;
  LLVMGetIncomingValue: TLLVMGetIncomingValue;
  LLVMGetIncomingBlock: TLLVMGetIncomingBlock;
  LLVMCreateBuilderInContext: TLLVMCreateBuilderInContext;
  LLVMCreateBuilder: TLLVMCreateBuilder;
  LLVMPositionBuilder: TLLVMPositionBuilder;
  LLVMPositionBuilderBefore: TLLVMPositionBuilderBefore;
  LLVMPositionBuilderAtEnd: TLLVMPositionBuilderAtEnd;
  LLVMGetInsertBlock: TLLVMGetInsertBlock;
  LLVMClearInsertionPosition: TLLVMClearInsertionPosition;
  LLVMInsertIntoBuilder: TLLVMInsertIntoBuilder;
  LLVMInsertIntoBuilderWithName: TLLVMInsertIntoBuilderWithName;
  LLVMDisposeBuilder: TLLVMDisposeBuilder;
  LLVMSetCurrentDebugLocation: TLLVMSetCurrentDebugLocation;
  LLVMGetCurrentDebugLocation: TLLVMGetCurrentDebugLocation;
  LLVMSetInstDebugLocation: TLLVMSetInstDebugLocation;
  LLVMBuildRetVoid: TLLVMBuildRetVoid;
  LLVMBuildRet: TLLVMBuildRet;
  LLVMBuildAggregateRet: TLLVMBuildAggregateRet;
  LLVMBuildBr: TLLVMBuildBr;
  LLVMBuildCondBr: TLLVMBuildCondBr;
  LLVMBuildSwitch: TLLVMBuildSwitch;
  LLVMBuildIndirectBr: TLLVMBuildIndirectBr;
  LLVMBuildInvoke: TLLVMBuildInvoke;
  LLVMBuildLandingPad: TLLVMBuildLandingPad;
  LLVMBuildResume: TLLVMBuildResume;
  LLVMBuildUnreachable: TLLVMBuildUnreachable;
  LLVMAddCase: TLLVMAddCase;
  LLVMAddDestination: TLLVMAddDestination;
  LLVMAddClause: TLLVMAddClause;
  LLVMSetCleanup: TLLVMSetCleanup;
  LLVMBuildAdd: TLLVMBuildAdd;
  LLVMBuildNSWAdd: TLLVMBuildNSWAdd;
  LLVMBuildNUWAdd: TLLVMBuildNUWAdd;
  LLVMBuildFAdd: TLLVMBuildFAdd;
  LLVMBuildSub: TLLVMBuildSub;
  LLVMBuildNSWSub: TLLVMBuildNSWSub;
  LLVMBuildNUWSub: TLLVMBuildNUWSub;
  LLVMBuildFSub: TLLVMBuildFSub;
  LLVMBuildMul: TLLVMBuildMul;
  LLVMBuildNSWMul: TLLVMBuildNSWMul;
  LLVMBuildNUWMul: TLLVMBuildNUWMul;
  LLVMBuildFMul: TLLVMBuildFMul;
  LLVMBuildUDiv: TLLVMBuildUDiv;
  LLVMBuildSDiv: TLLVMBuildSDiv;
  LLVMBuildExactSDiv: TLLVMBuildExactSDiv;
  LLVMBuildFDiv: TLLVMBuildFDiv;
  LLVMBuildURem: TLLVMBuildURem;
  LLVMBuildSRem: TLLVMBuildSRem;
  LLVMBuildFRem: TLLVMBuildFRem;
  LLVMBuildShl: TLLVMBuildShl;
  LLVMBuildLShr: TLLVMBuildLShr;
  LLVMBuildAShr: TLLVMBuildAShr;
  LLVMBuildAnd: TLLVMBuildAnd;
  LLVMBuildOr: TLLVMBuildOr;
  LLVMBuildXor: TLLVMBuildXor;
  LLVMBuildBinOp: TLLVMBuildBinOp;
  LLVMBuildNeg: TLLVMBuildNeg;
  LLVMBuildNSWNeg: TLLVMBuildNSWNeg;
  LLVMBuildNUWNeg: TLLVMBuildNUWNeg;
  LLVMBuildFNeg: TLLVMBuildFNeg;
  LLVMBuildNot: TLLVMBuildNot;
  LLVMBuildMalloc: TLLVMBuildMalloc;
  LLVMBuildArrayMalloc: TLLVMBuildArrayMalloc;
  LLVMBuildAlloca: TLLVMBuildAlloca;
  LLVMBuildArrayAlloca: TLLVMBuildArrayAlloca;
  LLVMBuildFree: TLLVMBuildFree;
  LLVMBuildLoad: TLLVMBuildLoad;
  LLVMBuildStore: TLLVMBuildStore;
  LLVMBuildGEP: TLLVMBuildGEP;
  LLVMBuildInBoundsGEP: TLLVMBuildInBoundsGEP;
  LLVMBuildStructGEP: TLLVMBuildStructGEP;
  LLVMBuildGlobalString: TLLVMBuildGlobalString;
  LLVMBuildGlobalStringPtr: TLLVMBuildGlobalStringPtr;
  LLVMGetVolatile: TLLVMGetVolatile;
  LLVMSetVolatile: TLLVMSetVolatile;
  LLVMBuildTrunc: TLLVMBuildTrunc;
  LLVMBuildZExt: TLLVMBuildZExt;
  LLVMBuildSExt: TLLVMBuildSExt;
  LLVMBuildFPToUI: TLLVMBuildFPToUI;
  LLVMBuildFPToSI: TLLVMBuildFPToSI;
  LLVMBuildUIToFP: TLLVMBuildUIToFP;
  LLVMBuildSIToFP: TLLVMBuildSIToFP;
  LLVMBuildFPTrunc: TLLVMBuildFPTrunc;
  LLVMBuildFPExt: TLLVMBuildFPExt;
  LLVMBuildPtrToInt: TLLVMBuildPtrToInt;
  LLVMBuildIntToPtr: TLLVMBuildIntToPtr;
  LLVMBuildBitCast: TLLVMBuildBitCast;
  LLVMBuildZExtOrBitCast: TLLVMBuildZExtOrBitCast;
  LLVMBuildSExtOrBitCast: TLLVMBuildSExtOrBitCast;
  LLVMBuildTruncOrBitCast: TLLVMBuildTruncOrBitCast;
  LLVMBuildCast: TLLVMBuildCast;
  LLVMBuildPointerCast: TLLVMBuildPointerCast;
  LLVMBuildIntCast: TLLVMBuildIntCast;
  LLVMBuildFPCast: TLLVMBuildFPCast;
  LLVMBuildICmp: TLLVMBuildICmp;
  LLVMBuildFCmp: TLLVMBuildFCmp;
  LLVMBuildPhi: TLLVMBuildPhi;
  LLVMBuildCall: TLLVMBuildCall;
  LLVMBuildSelect: TLLVMBuildSelect;
  LLVMBuildVAArg: TLLVMBuildVAArg;
  LLVMBuildExtractElement: TLLVMBuildExtractElement;
  LLVMBuildInsertElement: TLLVMBuildInsertElement;
  LLVMBuildShuffleVector: TLLVMBuildShuffleVector;
  LLVMBuildExtractValue: TLLVMBuildExtractValue;
  LLVMBuildInsertValue: TLLVMBuildInsertValue;
  LLVMBuildIsNull: TLLVMBuildIsNull;
  LLVMBuildIsNotNull: TLLVMBuildIsNotNull;
  LLVMBuildPtrDiff: TLLVMBuildPtrDiff;
  LLVMCreateModuleProviderForExistingModule: TLLVMCreateModuleProviderForExistingModule;
  LLVMDisposeModuleProvider: TLLVMDisposeModuleProvider;
  LLVMCreateMemoryBufferWithContentsOfFile: TLLVMCreateMemoryBufferWithContentsOfFile;
  LLVMCreateMemoryBufferWithSTDIN: TLLVMCreateMemoryBufferWithSTDIN;
  LLVMDisposeMemoryBuffer: TLLVMDisposeMemoryBuffer;
  LLVMGetGlobalPassRegistry: TLLVMGetGlobalPassRegistry;
  LLVMCreatePassManager: TLLVMCreatePassManager;
  LLVMCreateFunctionPassManagerForModule: TLLVMCreateFunctionPassManagerForModule;
  LLVMCreateFunctionPassManager: TLLVMCreateFunctionPassManager;
  LLVMRunPassManager: TLLVMRunPassManager;
  LLVMInitializeFunctionPassManager: TLLVMInitializeFunctionPassManager;
  LLVMRunFunctionPassManager: TLLVMRunFunctionPassManager;
  LLVMFinalizeFunctionPassManager: TLLVMFinalizeFunctionPassManager;
  LLVMDisposePassManager: TLLVMDisposePassManager;
{$ENDIF}
{$IFDEF LLVM_API_ANALYSIS}
  LLVMVerifyModule: TLLVMVerifyModule;
  LLVMVerifyFunction: TLLVMVerifyFunction;
  LLVMViewFunctionCFG: TLLVMViewFunctionCFG;
  LLVMViewFunctionCFGOnly: TLLVMViewFunctionCFGOnly;
{$ENDIF}
{$IFDEF LLVM_API_BITREADER}
  LLVMParseBitcode: TLLVMParseBitcode;
  LLVMParseBitcodeInContext: TLLVMParseBitcodeInContext;
  LLVMGetBitcodeModuleInContext: TLLVMGetBitcodeModuleInContext;
  LLVMGetBitcodeModule: TLLVMGetBitcodeModule;
  LLVMGetBitcodeModuleProviderInContext: TLLVMGetBitcodeModuleProviderInContext;
  LLVMGetBitcodeModuleProvider: TLLVMGetBitcodeModuleProvider;
{$ENDIF}
{$IFDEF LLVM_API_BITWRITER}
  LLVMWriteBitcodeToFile: TLLVMWriteBitcodeToFile;
  LLVMWriteBitcodeToFD: TLLVMWriteBitcodeToFD;
  LLVMWriteBitcodeToFileHandle: TLLVMWriteBitcodeToFileHandle;
{$ENDIF}
{$IFDEF LLVM_API_INITIALIZATION}
  LLVMInitializeCore_: TLLVMInitializeCore_;
  LLVMInitializeTransformUtils: TLLVMInitializeTransformUtils;
  LLVMInitializeScalarOpts: TLLVMInitializeScalarOpts;
  LLVMInitializeVectorization: TLLVMInitializeVectorization;
  LLVMInitializeInstCombine: TLLVMInitializeInstCombine;
  LLVMInitializeIPO: TLLVMInitializeIPO;
  LLVMInitializeInstrumentation: TLLVMInitializeInstrumentation;
  LLVMInitializeAnalysis: TLLVMInitializeAnalysis;
  LLVMInitializeIPA: TLLVMInitializeIPA;
  LLVMInitializeCodeGen: TLLVMInitializeCodeGen;
  LLVMInitializeTarget: TLLVMInitializeTarget;
{$ENDIF}
{$IFDEF LLVM_API_LINKTIMEOPTIMIZER}
  llvm_create_optimizer: Tllvm_create_optimizer;
  llvm_destroy_optimizer: Tllvm_destroy_optimizer;
  llvm_read_object_file: Tllvm_read_object_file;
  llvm_optimize_modules: Tllvm_optimize_modules;
{$ENDIF}
{$IFDEF LLVM_API_TARGET}
  LLVMInitializeAllTargetInfos: TLLVMInitializeAllTargetInfos;
  LLVMInitializeAllTargets: TLLVMInitializeAllTargets;
  LLVMInitializeAllTargetMCs: TLLVMInitializeAllTargetMCs;
  LLVMInitializeAllAsmPrinters: TLLVMInitializeAllAsmPrinters;
  LLVMInitializeAllAsmParsers: TLLVMInitializeAllAsmParsers;
  LLVMInitializeAllDisassemblers: TLLVMInitializeAllDisassemblers;
  LLVMInitializeNativeTarget: TLLVMInitializeNativeTarget;
  LLVMCreateTargetData: TLLVMCreateTargetData;
  LLVMAddTargetData: TLLVMAddTargetData;
  LLVMAddTargetLibraryInfo: TLLVMAddTargetLibraryInfo;
  LLVMCopyStringRepOfTargetData: TLLVMCopyStringRepOfTargetData;
  LLVMByteOrder: TLLVMByteOrder;
  LLVMPointerSize: TLLVMPointerSize;
  LLVMIntPtrType: TLLVMIntPtrType;
  LLVMSizeOfTypeInBits: TLLVMSizeOfTypeInBits;
  LLVMStoreSizeOfType: TLLVMStoreSizeOfType;
  LLVMABISizeOfType: TLLVMABISizeOfType;
  LLVMABIAlignmentOfType: TLLVMABIAlignmentOfType;
  LLVMCallFrameAlignmentOfType: TLLVMCallFrameAlignmentOfType;
  LLVMPreferredAlignmentOfType: TLLVMPreferredAlignmentOfType;
  LLVMPreferredAlignmentOfGlobal: TLLVMPreferredAlignmentOfGlobal;
  LLVMElementAtOffset: TLLVMElementAtOffset;
  LLVMOffsetOfElement: TLLVMOffsetOfElement;
  LLVMDisposeTargetData: TLLVMDisposeTargetData;
{$ENDIF}
{$IFDEF LLVM_API_TARGETMACHINE}
  LLVMGetFirstTarget: TLLVMGetFirstTarget;
  LLVMGetNextTarget: TLLVMGetNextTarget;
  LLVMGetTargetName: TLLVMGetTargetName;
  LLVMGetTargetDescription: TLLVMGetTargetDescription;
  LLVMTargetHasJIT: TLLVMTargetHasJIT;
  LLVMTargetHasTargetMachine: TLLVMTargetHasTargetMachine;
  LLVMTargetHasAsmBackend: TLLVMTargetHasAsmBackend;
  LLVMCreateTargetMachine: TLLVMCreateTargetMachine;
  LLVMDisposeTargetMachine: TLLVMDisposeTargetMachine;
  LLVMGetTargetMachineTarget: TLLVMGetTargetMachineTarget;
  LLVMGetTargetMachineTriple: TLLVMGetTargetMachineTriple;
  LLVMGetTargetMachineCPU: TLLVMGetTargetMachineCPU;
  LLVMGetTargetMachineFeatureString: TLLVMGetTargetMachineFeatureString;
  LLVMGetTargetMachineData: TLLVMGetTargetMachineData;
  LLVMTargetMachineEmitToFile: TLLVMTargetMachineEmitToFile;
{$ENDIF}
{$IFDEF LLVM_API_OBJECT}
  LLVMCreateObjectFile: TLLVMCreateObjectFile;
  LLVMDisposeObjectFile: TLLVMDisposeObjectFile;
  LLVMGetSections: TLLVMGetSections;
  LLVMDisposeSectionIterator: TLLVMDisposeSectionIterator;
  LLVMIsSectionIteratorAtEnd: TLLVMIsSectionIteratorAtEnd;
  LLVMMoveToNextSection: TLLVMMoveToNextSection;
  LLVMMoveToContainingSection: TLLVMMoveToContainingSection;
  LLVMGetSymbols: TLLVMGetSymbols;
  LLVMDisposeSymbolIterator: TLLVMDisposeSymbolIterator;
  LLVMIsSymbolIteratorAtEnd: TLLVMIsSymbolIteratorAtEnd;
  LLVMMoveToNextSymbol: TLLVMMoveToNextSymbol;
  LLVMGetSectionName: TLLVMGetSectionName;
  LLVMGetSectionSize: TLLVMGetSectionSize;
  LLVMGetSectionContents: TLLVMGetSectionContents;
  LLVMGetSectionAddress: TLLVMGetSectionAddress;
  LLVMGetSectionContainsSymbol: TLLVMGetSectionContainsSymbol;
  LLVMGetRelocations: TLLVMGetRelocations;
  LLVMDisposeRelocationIterator: TLLVMDisposeRelocationIterator;
  LLVMIsRelocationIteratorAtEnd: TLLVMIsRelocationIteratorAtEnd;
  LLVMMoveToNextRelocation: TLLVMMoveToNextRelocation;
  LLVMGetSymbolName: TLLVMGetSymbolName;
  LLVMGetSymbolAddress: TLLVMGetSymbolAddress;
  LLVMGetSymbolFileOffset: TLLVMGetSymbolFileOffset;
  LLVMGetSymbolSize: TLLVMGetSymbolSize;
  LLVMGetRelocationAddress: TLLVMGetRelocationAddress;
  LLVMGetRelocationOffset: TLLVMGetRelocationOffset;
  LLVMGetRelocationSymbol: TLLVMGetRelocationSymbol;
  LLVMGetRelocationType: TLLVMGetRelocationType;
  LLVMGetRelocationTypeName: TLLVMGetRelocationTypeName;
  LLVMGetRelocationValueString: TLLVMGetRelocationValueString;
{$ENDIF}
{$IFDEF LLVM_API_EXECUTIONENGINE}
  LLVMLinkInJIT: TLLVMLinkInJIT;
  LLVMLinkInInterpreter: TLLVMLinkInInterpreter;
  LLVMCreateGenericValueOfInt: TLLVMCreateGenericValueOfInt;
  LLVMCreateGenericValueOfPointer: TLLVMCreateGenericValueOfPointer;
  LLVMCreateGenericValueOfFloat: TLLVMCreateGenericValueOfFloat;
  LLVMGenericValueIntWidth: TLLVMGenericValueIntWidth;
  LLVMGenericValueToInt: TLLVMGenericValueToInt;
  LLVMGenericValueToPointer: TLLVMGenericValueToPointer;
  LLVMGenericValueToFloat: TLLVMGenericValueToFloat;
  LLVMDisposeGenericValue: TLLVMDisposeGenericValue;
  LLVMCreateExecutionEngineForModule: TLLVMCreateExecutionEngineForModule;
  LLVMCreateInterpreterForModule: TLLVMCreateInterpreterForModule;
  LLVMCreateJITCompilerForModule: TLLVMCreateJITCompilerForModule;
  LLVMCreateExecutionEngine: TLLVMCreateExecutionEngine;
  LLVMCreateInterpreter: TLLVMCreateInterpreter;
  LLVMCreateJITCompiler: TLLVMCreateJITCompiler;
  LLVMDisposeExecutionEngine: TLLVMDisposeExecutionEngine;
  LLVMRunStaticConstructors: TLLVMRunStaticConstructors;
  LLVMRunStaticDestructors: TLLVMRunStaticDestructors;
  LLVMRunFunctionAsMain: TLLVMRunFunctionAsMain;
  LLVMRunFunction: TLLVMRunFunction;
  LLVMFreeMachineCodeForFunction: TLLVMFreeMachineCodeForFunction;
  LLVMAddModule: TLLVMAddModule;
  LLVMAddModuleProvider: TLLVMAddModuleProvider;
  LLVMRemoveModule: TLLVMRemoveModule;
  LLVMRemoveModuleProvider: TLLVMRemoveModuleProvider;
  LLVMFindFunction: TLLVMFindFunction;
  LLVMRecompileAndRelinkFunction: TLLVMRecompileAndRelinkFunction;
  LLVMGetExecutionEngineTargetData: TLLVMGetExecutionEngineTargetData;
  LLVMAddGlobalMapping: TLLVMAddGlobalMapping;
  LLVMGetPointerToGlobal: TLLVMGetPointerToGlobal;
{$ENDIF}
{$IFDEF LLVM_API_DISASSEMBLER}
  LLVMCreateDisasm: TLLVMCreateDisasm;
  LLVMDisasmDispose: TLLVMDisasmDispose;
  LLVMDisasmInstruction: TLLVMDisasmInstruction;
{$ENDIF}
{$IFDEF LLVM_API_LTO}
  lto_get_version: Tlto_get_version;
  lto_get_error_message: Tlto_get_error_message;
  lto_module_is_object_file: Tlto_module_is_object_file;
  lto_module_is_object_file_for_target: Tlto_module_is_object_file_for_target;
  lto_module_is_object_file_in_memory: Tlto_module_is_object_file_in_memory;
  lto_module_is_object_file_in_memory_for_target: Tlto_module_is_object_file_in_memory_for_target;
  lto_module_create: Tlto_module_create;
  lto_module_create_from_memory: Tlto_module_create_from_memory;
  lto_module_create_from_fd: Tlto_module_create_from_fd;
  lto_module_create_from_fd_at_offset: Tlto_module_create_from_fd_at_offset;
  lto_module_dispose: Tlto_module_dispose;
  lto_module_get_target_triple: Tlto_module_get_target_triple;
  lto_module_set_target_triple: Tlto_module_set_target_triple;
  lto_module_get_num_symbols: Tlto_module_get_num_symbols;
  lto_module_get_symbol_name: Tlto_module_get_symbol_name;
  lto_module_get_symbol_attribute: Tlto_module_get_symbol_attribute;
  lto_codegen_create: Tlto_codegen_create;
  lto_codegen_dispose: Tlto_codegen_dispose;
  lto_codegen_add_module: Tlto_codegen_add_module;
  lto_codegen_set_debug_model: Tlto_codegen_set_debug_model;
  lto_codegen_set_pic_model: Tlto_codegen_set_pic_model;
  lto_codegen_set_cpu: Tlto_codegen_set_cpu;
  lto_codegen_set_assembler_path: Tlto_codegen_set_assembler_path;
  lto_codegen_set_assembler_args: Tlto_codegen_set_assembler_args;
  lto_codegen_add_must_preserve_symbol: Tlto_codegen_add_must_preserve_symbol;
  lto_codegen_write_merged_modules: Tlto_codegen_write_merged_modules;
  lto_codegen_compile: Tlto_codegen_compile;
  lto_codegen_compile_to_file: Tlto_codegen_compile_to_file;
  lto_codegen_debug_options: Tlto_codegen_debug_options;
{$ENDIF}
{$IFDEF LLVM_API_ENHANCEDDISASSEMBLY}
  EDGetDisassembler: TEDGetDisassembler;
  EDGetRegisterName: TEDGetRegisterName;
  EDRegisterIsStackPointer: TEDRegisterIsStackPointer;
  EDRegisterIsProgramCounter: TEDRegisterIsProgramCounter;
  EDCreateInsts: TEDCreateInsts;
  EDReleaseInst: TEDReleaseInst;
  EDInstByteSize: TEDInstByteSize;
  EDGetInstString: TEDGetInstString;
  EDInstID: TEDInstID;
  EDInstIsBranch: TEDInstIsBranch;
  EDInstIsMove: TEDInstIsMove;
  EDBranchTargetID: TEDBranchTargetID;
  EDMoveSourceID: TEDMoveSourceID;
  EDMoveTargetID: TEDMoveTargetID;
  EDNumTokens: TEDNumTokens;
  EDGetToken: TEDGetToken;
  EDGetTokenString: TEDGetTokenString;
  EDOperandIndexForToken: TEDOperandIndexForToken;
  EDTokenIsWhitespace: TEDTokenIsWhitespace;
  EDTokenIsPunctuation: TEDTokenIsPunctuation;
  EDTokenIsOpcode: TEDTokenIsOpcode;
  EDTokenIsLiteral: TEDTokenIsLiteral;
  EDTokenIsRegister: TEDTokenIsRegister;
  EDTokenIsNegativeLiteral: TEDTokenIsNegativeLiteral;
  EDLiteralTokenAbsoluteValue: TEDLiteralTokenAbsoluteValue;
  EDRegisterTokenValue: TEDRegisterTokenValue;
  EDNumOperands: TEDNumOperands;
  EDGetOperand: TEDGetOperand;
  EDOperandIsRegister: TEDOperandIsRegister;
  EDOperandIsImmediate: TEDOperandIsImmediate;
  EDOperandIsMemory: TEDOperandIsMemory;
  EDRegisterOperandValue: TEDRegisterOperandValue;
  EDImmediateOperandValue: TEDImmediateOperandValue;
  EDEvaluateOperand: TEDEvaluateOperand;
{$ENDIF}
{$IFDEF LLVM_API_IPO}
  LLVMAddArgumentPromotionPass: TLLVMAddArgumentPromotionPass;
  LLVMAddConstantMergePass: TLLVMAddConstantMergePass;
  LLVMAddDeadArgEliminationPass: TLLVMAddDeadArgEliminationPass;
  LLVMAddFunctionAttrsPass: TLLVMAddFunctionAttrsPass;
  LLVMAddFunctionInliningPass: TLLVMAddFunctionInliningPass;
  LLVMAddAlwaysInlinerPass: TLLVMAddAlwaysInlinerPass;
  LLVMAddGlobalDCEPass: TLLVMAddGlobalDCEPass;
  LLVMAddGlobalOptimizerPass: TLLVMAddGlobalOptimizerPass;
  LLVMAddIPConstantPropagationPass: TLLVMAddIPConstantPropagationPass;
  LLVMAddPruneEHPass: TLLVMAddPruneEHPass;
  LLVMAddIPSCCPPass: TLLVMAddIPSCCPPass;
  LLVMAddInternalizePass: TLLVMAddInternalizePass;
  LLVMAddStripDeadPrototypesPass: TLLVMAddStripDeadPrototypesPass;
  LLVMAddStripSymbolsPass: TLLVMAddStripSymbolsPass;
{$ENDIF}
{$IFDEF LLVM_API_PASSMANAGERBUILDER}
  LLVMPassManagerBuilderCreate: TLLVMPassManagerBuilderCreate;
  LLVMPassManagerBuilderDispose: TLLVMPassManagerBuilderDispose;
  LLVMPassManagerBuilderSetOptLevel: TLLVMPassManagerBuilderSetOptLevel;
  LLVMPassManagerBuilderSetSizeLevel: TLLVMPassManagerBuilderSetSizeLevel;
  LLVMPassManagerBuilderSetDisableUnitAtATime: TLLVMPassManagerBuilderSetDisableUnitAtATime;
  LLVMPassManagerBuilderSetDisableUnrollLoops: TLLVMPassManagerBuilderSetDisableUnrollLoops;
  LLVMPassManagerBuilderSetDisableSimplifyLibCalls: TLLVMPassManagerBuilderSetDisableSimplifyLibCalls;
  LLVMPassManagerBuilderUseInlinerWithThreshold: TLLVMPassManagerBuilderUseInlinerWithThreshold;
  LLVMPassManagerBuilderPopulateFunctionPassManager: TLLVMPassManagerBuilderPopulateFunctionPassManager;
  LLVMPassManagerBuilderPopulateModulePassManager: TLLVMPassManagerBuilderPopulateModulePassManager;
  LLVMPassManagerBuilderPopulateLTOPassManager: TLLVMPassManagerBuilderPopulateLTOPassManager;
{$ENDIF}
{$IFDEF LLVM_API_SCALAR}
  LLVMAddAggressiveDCEPass: TLLVMAddAggressiveDCEPass;
  LLVMAddCFGSimplificationPass: TLLVMAddCFGSimplificationPass;
  LLVMAddDeadStoreEliminationPass: TLLVMAddDeadStoreEliminationPass;
  LLVMAddGVNPass: TLLVMAddGVNPass;
  LLVMAddIndVarSimplifyPass: TLLVMAddIndVarSimplifyPass;
  LLVMAddInstructionCombiningPass: TLLVMAddInstructionCombiningPass;
  LLVMAddJumpThreadingPass: TLLVMAddJumpThreadingPass;
  LLVMAddLICMPass: TLLVMAddLICMPass;
  LLVMAddLoopDeletionPass: TLLVMAddLoopDeletionPass;
  LLVMAddLoopIdiomPass: TLLVMAddLoopIdiomPass;
  LLVMAddLoopRotatePass: TLLVMAddLoopRotatePass;
  LLVMAddLoopUnrollPass: TLLVMAddLoopUnrollPass;
  LLVMAddLoopUnswitchPass: TLLVMAddLoopUnswitchPass;
  LLVMAddMemCpyOptPass: TLLVMAddMemCpyOptPass;
  LLVMAddPromoteMemoryToRegisterPass: TLLVMAddPromoteMemoryToRegisterPass;
  LLVMAddReassociatePass: TLLVMAddReassociatePass;
  LLVMAddSCCPPass: TLLVMAddSCCPPass;
  LLVMAddScalarReplAggregatesPass: TLLVMAddScalarReplAggregatesPass;
  LLVMAddScalarReplAggregatesPassSSA: TLLVMAddScalarReplAggregatesPassSSA;
  LLVMAddScalarReplAggregatesPassWithThreshold: TLLVMAddScalarReplAggregatesPassWithThreshold;
  LLVMAddSimplifyLibCallsPass: TLLVMAddSimplifyLibCallsPass;
  LLVMAddTailCallEliminationPass: TLLVMAddTailCallEliminationPass;
  LLVMAddConstantPropagationPass: TLLVMAddConstantPropagationPass;
  LLVMAddDemoteMemoryToRegisterPass: TLLVMAddDemoteMemoryToRegisterPass;
  LLVMAddVerifierPass: TLLVMAddVerifierPass;
  LLVMAddCorrelatedValuePropagationPass: TLLVMAddCorrelatedValuePropagationPass;
  LLVMAddEarlyCSEPass: TLLVMAddEarlyCSEPass;
  LLVMAddLowerExpectIntrinsicPass: TLLVMAddLowerExpectIntrinsicPass;
  LLVMAddTypeBasedAliasAnalysisPass: TLLVMAddTypeBasedAliasAnalysisPass;
  LLVMAddBasicAliasAnalysisPass: TLLVMAddBasicAliasAnalysisPass;
{$ENDIF}
{$IFDEF LLVM_API_VECTORIZE}
  LLVMAddBBVectorizePass: TLLVMAddBBVectorizePass;
{$ENDIF}

var
  hLibrary: THandle = 0;

function IsLLVMLoaded: Boolean;
function LoadLLVM: Boolean;
procedure UnloadLLVM;
{$ENDIF}

implementation

procedure LLVMTraceLog(const AMessage: String; ACRLF: Boolean = False); overload;
begin
{$IFDEF LLVM_TRACE}
  Log(AMessage, ACRLF);
{$ENDIF}
end;

procedure LLVMTraceLog(const AMessage: String; AArgs: array of const; ACRLF: Boolean = False); overload;
begin
{$IFDEF LLVM_TRACE}
  Log(AMessage, AArgs, ACRLF);
{$ENDIF}
end;

procedure LLVMDebugLog(const AMessage: String; ACRLF: Boolean = False); overload;
begin
{$IFDEF LLVM_DEBUG}
  Log(AMessage, ACRLF);
{$ENDIF}
end;

procedure LLVMDebugLog(const AMessage: String; AArgs: array of const; ACRLF: Boolean = False); overload;
begin
{$IFDEF LLVM_DEBUG}
  Log(AMessage, AArgs, ACRLF);
{$ENDIF}
end;

{$IFDEF LLVM_DYNAMIC_LINK}
function GetLLVMProc(const AProcName: String): Pointer;
begin
  Result := GetProcAddress(hLibrary, PAnsiChar(AnsiString(AProcName)));
  LLVMTraceLog('%s', [AProcName]);
  if (Result = nil) then
{$IFNDEF LLVM_DEBUG}
    raise Exception.CreateFmt('[GetLLVMProc] Function "%s" not founded in LLVM Library!', [AProcName]);
{$ELSE}
    LLVMDebugLog('[-] Function "%s" not founded in LLVM Library!', [AProcName]);
{$ENDIF}
end;

function IsLLVMLoaded: Boolean;
begin
  Result := (hLibrary <> 0);
end;

function LoadLLVM: Boolean;
begin
  if IsLLVMLoaded then
    UnloadLLVM;

  Result := False;
  try
    hLibrary := LoadLibrary(LLVMLibrary);
    if (hLibrary <> 0) then
    begin
{$IFDEF LLVM_API_CORE}
      LLVMTraceLog(';Core.h');
      @LLVMInitializeCore := GetLLVMProc('LLVMInitializeCore');
      @LLVMDisposeMessage := GetLLVMProc('LLVMDisposeMessage');
      @LLVMContextCreate := GetLLVMProc('LLVMContextCreate');
      @LLVMGetGlobalContext := GetLLVMProc('LLVMGetGlobalContext');
      @LLVMContextDispose := GetLLVMProc('LLVMContextDispose');
      @LLVMGetMDKindIDInContext := GetLLVMProc('LLVMGetMDKindIDInContext');
      @LLVMGetMDKindID := GetLLVMProc('LLVMGetMDKindID');
      @LLVMModuleCreateWithName := GetLLVMProc('LLVMModuleCreateWithName');
      @LLVMModuleCreateWithNameInContext := GetLLVMProc('LLVMModuleCreateWithNameInContext');
      @LLVMDisposeModule := GetLLVMProc('LLVMDisposeModule');
      @LLVMGetDataLayout := GetLLVMProc('LLVMGetDataLayout');
      @LLVMSetDataLayout := GetLLVMProc('LLVMSetDataLayout');
      @LLVMGetTarget := GetLLVMProc('LLVMGetTarget');
      @LLVMSetTarget := GetLLVMProc('LLVMSetTarget');
      @LLVMDumpModule := GetLLVMProc('LLVMDumpModule');
      @LLVMSetModuleInlineAsm := GetLLVMProc('LLVMSetModuleInlineAsm');
      @LLVMGetModuleContext := GetLLVMProc('LLVMGetModuleContext');
      @LLVMGetTypeByName := GetLLVMProc('LLVMGetTypeByName');
      @LLVMGetNamedMetadataNumOperands := GetLLVMProc('LLVMGetNamedMetadataNumOperands');
      @LLVMGetNamedMetadataOperands := GetLLVMProc('LLVMGetNamedMetadataOperands');
      @LLVMAddNamedMetadataOperand := GetLLVMProc('LLVMAddNamedMetadataOperand');
      @LLVMAddFunction := GetLLVMProc('LLVMAddFunction');
      @LLVMGetNamedFunction := GetLLVMProc('LLVMGetNamedFunction');
      @LLVMGetFirstFunction := GetLLVMProc('LLVMGetFirstFunction');
      @LLVMGetLastFunction := GetLLVMProc('LLVMGetLastFunction');
      @LLVMGetNextFunction := GetLLVMProc('LLVMGetNextFunction');
      @LLVMGetPreviousFunction := GetLLVMProc('LLVMGetPreviousFunction');
      @LLVMGetTypeKind := GetLLVMProc('LLVMGetTypeKind');
      @LLVMTypeIsSized := GetLLVMProc('LLVMTypeIsSized');
      @LLVMGetTypeContext := GetLLVMProc('LLVMGetTypeContext');
      @LLVMInt1TypeInContext := GetLLVMProc('LLVMInt1TypeInContext');
      @LLVMInt8TypeInContext := GetLLVMProc('LLVMInt8TypeInContext');
      @LLVMInt16TypeInContext := GetLLVMProc('LLVMInt16TypeInContext');
      @LLVMInt32TypeInContext := GetLLVMProc('LLVMInt32TypeInContext');
      @LLVMInt64TypeInContext := GetLLVMProc('LLVMInt64TypeInContext');
      @LLVMIntTypeInContext := GetLLVMProc('LLVMIntTypeInContext');
      @LLVMInt1Type := GetLLVMProc('LLVMInt1Type');
      @LLVMInt8Type := GetLLVMProc('LLVMInt8Type');
      @LLVMInt16Type := GetLLVMProc('LLVMInt16Type');
      @LLVMInt32Type := GetLLVMProc('LLVMInt32Type');
      @LLVMInt64Type := GetLLVMProc('LLVMInt64Type');
      @LLVMIntType := GetLLVMProc('LLVMIntType');
      @LLVMGetIntTypeWidth := GetLLVMProc('LLVMGetIntTypeWidth');
      @LLVMHalfTypeInContext := GetLLVMProc('LLVMHalfTypeInContext');
      @LLVMFloatTypeInContext := GetLLVMProc('LLVMFloatTypeInContext');
      @LLVMDoubleTypeInContext := GetLLVMProc('LLVMDoubleTypeInContext');
      @LLVMX86FP80TypeInContext := GetLLVMProc('LLVMX86FP80TypeInContext');
      @LLVMFP128TypeInContext := GetLLVMProc('LLVMFP128TypeInContext');
      @LLVMPPCFP128TypeInContext := GetLLVMProc('LLVMPPCFP128TypeInContext');
      @LLVMHalfType := GetLLVMProc('LLVMHalfType');
      @LLVMFloatType := GetLLVMProc('LLVMFloatType');
      @LLVMDoubleType := GetLLVMProc('LLVMDoubleType');
      @LLVMX86FP80Type := GetLLVMProc('LLVMX86FP80Type');
      @LLVMFP128Type := GetLLVMProc('LLVMFP128Type');
      @LLVMPPCFP128Type := GetLLVMProc('LLVMPPCFP128Type');
      @LLVMFunctionType := GetLLVMProc('LLVMFunctionType');
      @LLVMIsFunctionVarArg := GetLLVMProc('LLVMIsFunctionVarArg');
      @LLVMGetReturnType := GetLLVMProc('LLVMGetReturnType');
      @LLVMCountParamTypes := GetLLVMProc('LLVMCountParamTypes');
      @LLVMGetParamTypes := GetLLVMProc('LLVMGetParamTypes');
      @LLVMStructTypeInContext := GetLLVMProc('LLVMStructTypeInContext');
      @LLVMStructType := GetLLVMProc('LLVMStructType');
      @LLVMStructCreateNamed := GetLLVMProc('LLVMStructCreateNamed');
      @LLVMGetStructName := GetLLVMProc('LLVMGetStructName');
      @LLVMStructSetBody := GetLLVMProc('LLVMStructSetBody');
      @LLVMCountStructElementTypes := GetLLVMProc('LLVMCountStructElementTypes');
      @LLVMGetStructElementTypes := GetLLVMProc('LLVMGetStructElementTypes');
      @LLVMIsPackedStruct := GetLLVMProc('LLVMIsPackedStruct');
      @LLVMIsOpaqueStruct := GetLLVMProc('LLVMIsOpaqueStruct');
      @LLVMGetElementType := GetLLVMProc('LLVMGetElementType');
      @LLVMArrayType := GetLLVMProc('LLVMArrayType');
      @LLVMGetArrayLength := GetLLVMProc('LLVMGetArrayLength');
      @LLVMPointerType := GetLLVMProc('LLVMPointerType');
      @LLVMGetPointerAddressSpace := GetLLVMProc('LLVMGetPointerAddressSpace');
      @LLVMVectorType := GetLLVMProc('LLVMVectorType');
      @LLVMGetVectorSize := GetLLVMProc('LLVMGetVectorSize');
      @LLVMVoidTypeInContext := GetLLVMProc('LLVMVoidTypeInContext');
      @LLVMLabelTypeInContext := GetLLVMProc('LLVMLabelTypeInContext');
      @LLVMX86MMXTypeInContext := GetLLVMProc('LLVMX86MMXTypeInContext');
      @LLVMVoidType := GetLLVMProc('LLVMVoidType');
      @LLVMLabelType := GetLLVMProc('LLVMLabelType');
      @LLVMX86MMXType := GetLLVMProc('LLVMX86MMXType');
      @LLVMTypeOf := GetLLVMProc('LLVMTypeOf');
      @LLVMGetValueName := GetLLVMProc('LLVMGetValueName');
      @LLVMSetValueName := GetLLVMProc('LLVMSetValueName');
      @LLVMDumpValue := GetLLVMProc('LLVMDumpValue');
      @LLVMReplaceAllUsesWith := GetLLVMProc('LLVMReplaceAllUsesWith');
      @LLVMIsConstant := GetLLVMProc('LLVMIsConstant');
      @LLVMIsUndef := GetLLVMProc('LLVMIsUndef');
      @LLVMIsAArgument := GetLLVMProc('LLVMIsAArgument');
      @LLVMIsABasicBlock := GetLLVMProc('LLVMIsABasicBlock');
      @LLVMIsAInlineAsm := GetLLVMProc('LLVMIsAInlineAsm');
      @LLVMIsAMDNode := GetLLVMProc('LLVMIsAMDNode');
      @LLVMIsAMDString := GetLLVMProc('LLVMIsAMDString');
      @LLVMIsAUser := GetLLVMProc('LLVMIsAUser');
      @LLVMIsAConstant := GetLLVMProc('LLVMIsAConstant');
      @LLVMIsABlockAddress := GetLLVMProc('LLVMIsABlockAddress');
      @LLVMIsAConstantAggregateZero := GetLLVMProc('LLVMIsAConstantAggregateZero');
      @LLVMIsAConstantArray := GetLLVMProc('LLVMIsAConstantArray');
      @LLVMIsAConstantExpr := GetLLVMProc('LLVMIsAConstantExpr');
      @LLVMIsAConstantFP := GetLLVMProc('LLVMIsAConstantFP');
      @LLVMIsAConstantInt := GetLLVMProc('LLVMIsAConstantInt');
      @LLVMIsAConstantPointerNull := GetLLVMProc('LLVMIsAConstantPointerNull');
      @LLVMIsAConstantStruct := GetLLVMProc('LLVMIsAConstantStruct');
      @LLVMIsAConstantVector := GetLLVMProc('LLVMIsAConstantVector');
      @LLVMIsAGlobalValue := GetLLVMProc('LLVMIsAGlobalValue');
      @LLVMIsAFunction := GetLLVMProc('LLVMIsAFunction');
      @LLVMIsAGlobalAlias := GetLLVMProc('LLVMIsAGlobalAlias');
      @LLVMIsAGlobalVariable := GetLLVMProc('LLVMIsAGlobalVariable');
      @LLVMIsAUndefValue := GetLLVMProc('LLVMIsAUndefValue');
      @LLVMIsAInstruction := GetLLVMProc('LLVMIsAInstruction');
      @LLVMIsABinaryOperator := GetLLVMProc('LLVMIsABinaryOperator');
      @LLVMIsACallInst := GetLLVMProc('LLVMIsACallInst');
      @LLVMIsAIntrinsicInst := GetLLVMProc('LLVMIsAIntrinsicInst');
      @LLVMIsADbgInfoIntrinsic := GetLLVMProc('LLVMIsADbgInfoIntrinsic');
      @LLVMIsADbgDeclareInst := GetLLVMProc('LLVMIsADbgDeclareInst');
      @LLVMIsAMemIntrinsic := GetLLVMProc('LLVMIsAMemIntrinsic');
      @LLVMIsAMemCpyInst := GetLLVMProc('LLVMIsAMemCpyInst');
      @LLVMIsAMemMoveInst := GetLLVMProc('LLVMIsAMemMoveInst');
      @LLVMIsAMemSetInst := GetLLVMProc('LLVMIsAMemSetInst');
      @LLVMIsACmpInst := GetLLVMProc('LLVMIsACmpInst');
      @LLVMIsAFCmpInst := GetLLVMProc('LLVMIsAFCmpInst');
      @LLVMIsAICmpInst := GetLLVMProc('LLVMIsAICmpInst');
      @LLVMIsAExtractElementInst := GetLLVMProc('LLVMIsAExtractElementInst');
      @LLVMIsAGetElementPtrInst := GetLLVMProc('LLVMIsAGetElementPtrInst');
      @LLVMIsAInsertElementInst := GetLLVMProc('LLVMIsAInsertElementInst');
      @LLVMIsAInsertValueInst := GetLLVMProc('LLVMIsAInsertValueInst');
      @LLVMIsALandingPadInst := GetLLVMProc('LLVMIsALandingPadInst');
      @LLVMIsAPHINode := GetLLVMProc('LLVMIsAPHINode');
      @LLVMIsASelectInst := GetLLVMProc('LLVMIsASelectInst');
      @LLVMIsAShuffleVectorInst := GetLLVMProc('LLVMIsAShuffleVectorInst');
      @LLVMIsAStoreInst := GetLLVMProc('LLVMIsAStoreInst');
      @LLVMIsATerminatorInst := GetLLVMProc('LLVMIsATerminatorInst');
      @LLVMIsABranchInst := GetLLVMProc('LLVMIsABranchInst');
      @LLVMIsAIndirectBrInst := GetLLVMProc('LLVMIsAIndirectBrInst');
      @LLVMIsAInvokeInst := GetLLVMProc('LLVMIsAInvokeInst');
      @LLVMIsAReturnInst := GetLLVMProc('LLVMIsAReturnInst');
      @LLVMIsASwitchInst := GetLLVMProc('LLVMIsASwitchInst');
      @LLVMIsAUnreachableInst := GetLLVMProc('LLVMIsAUnreachableInst');
      @LLVMIsAResumeInst := GetLLVMProc('LLVMIsAResumeInst');
      @LLVMIsAUnaryInstruction := GetLLVMProc('LLVMIsAUnaryInstruction');
      @LLVMIsAAllocaInst := GetLLVMProc('LLVMIsAAllocaInst');
      @LLVMIsACastInst := GetLLVMProc('LLVMIsACastInst');
      @LLVMIsABitCastInst := GetLLVMProc('LLVMIsABitCastInst');
      @LLVMIsAFPExtInst := GetLLVMProc('LLVMIsAFPExtInst');
      @LLVMIsAFPToSIInst := GetLLVMProc('LLVMIsAFPToSIInst');
      @LLVMIsAFPToUIInst := GetLLVMProc('LLVMIsAFPToUIInst');
      @LLVMIsAFPTruncInst := GetLLVMProc('LLVMIsAFPTruncInst');
      @LLVMIsAIntToPtrInst := GetLLVMProc('LLVMIsAIntToPtrInst');
      @LLVMIsAPtrToIntInst := GetLLVMProc('LLVMIsAPtrToIntInst');
      @LLVMIsASExtInst := GetLLVMProc('LLVMIsASExtInst');
      @LLVMIsASIToFPInst := GetLLVMProc('LLVMIsASIToFPInst');
      @LLVMIsATruncInst := GetLLVMProc('LLVMIsATruncInst');
      @LLVMIsAUIToFPInst := GetLLVMProc('LLVMIsAUIToFPInst');
      @LLVMIsAZExtInst := GetLLVMProc('LLVMIsAZExtInst');
      @LLVMIsAExtractValueInst := GetLLVMProc('LLVMIsAExtractValueInst');
      @LLVMIsALoadInst := GetLLVMProc('LLVMIsALoadInst');
      @LLVMIsAVAArgInst := GetLLVMProc('LLVMIsAVAArgInst');
      @LLVMGetFirstUse := GetLLVMProc('LLVMGetFirstUse');
      @LLVMGetNextUse := GetLLVMProc('LLVMGetNextUse');
      @LLVMGetUser := GetLLVMProc('LLVMGetUser');
      @LLVMGetUsedValue := GetLLVMProc('LLVMGetUsedValue');
      @LLVMGetOperand := GetLLVMProc('LLVMGetOperand');
      @LLVMSetOperand := GetLLVMProc('LLVMSetOperand');
      @LLVMGetNumOperands := GetLLVMProc('LLVMGetNumOperands');
      @LLVMConstNull := GetLLVMProc('LLVMConstNull');
      @LLVMConstAllOnes := GetLLVMProc('LLVMConstAllOnes');
      @LLVMGetUndef := GetLLVMProc('LLVMGetUndef');
      @LLVMIsNull := GetLLVMProc('LLVMIsNull');
      @LLVMConstPointerNull := GetLLVMProc('LLVMConstPointerNull');
      @LLVMConstInt := GetLLVMProc('LLVMConstInt');
      @LLVMConstIntOfArbitraryPrecision := GetLLVMProc('LLVMConstIntOfArbitraryPrecision');
      @LLVMConstIntOfString := GetLLVMProc('LLVMConstIntOfString');
      @LLVMConstIntOfStringAndSize := GetLLVMProc('LLVMConstIntOfStringAndSize');
      @LLVMConstReal := GetLLVMProc('LLVMConstReal');
      @LLVMConstRealOfString := GetLLVMProc('LLVMConstRealOfString');
      @LLVMConstRealOfStringAndSize := GetLLVMProc('LLVMConstRealOfStringAndSize');
      @LLVMConstIntGetZExtValue := GetLLVMProc('LLVMConstIntGetZExtValue');
      @LLVMConstIntGetSExtValue := GetLLVMProc('LLVMConstIntGetSExtValue');
      @LLVMConstStringInContext := GetLLVMProc('LLVMConstStringInContext');
      @LLVMConstString := GetLLVMProc('LLVMConstString');
      @LLVMConstStructInContext := GetLLVMProc('LLVMConstStructInContext');
      @LLVMConstStruct := GetLLVMProc('LLVMConstStruct');
      @LLVMConstArray := GetLLVMProc('LLVMConstArray');
      @LLVMConstNamedStruct := GetLLVMProc('LLVMConstNamedStruct');
      @LLVMConstVector := GetLLVMProc('LLVMConstVector');
      @LLVMGetConstOpcode := GetLLVMProc('LLVMGetConstOpcode');
      @LLVMAlignOf := GetLLVMProc('LLVMAlignOf');
      @LLVMSizeOf := GetLLVMProc('LLVMSizeOf');
      @LLVMConstNeg := GetLLVMProc('LLVMConstNeg');
      @LLVMConstNSWNeg := GetLLVMProc('LLVMConstNSWNeg');
      @LLVMConstNUWNeg := GetLLVMProc('LLVMConstNUWNeg');
      @LLVMConstFNeg := GetLLVMProc('LLVMConstFNeg');
      @LLVMConstNot := GetLLVMProc('LLVMConstNot');
      @LLVMConstAdd := GetLLVMProc('LLVMConstAdd');
      @LLVMConstNSWAdd := GetLLVMProc('LLVMConstNSWAdd');
      @LLVMConstNUWAdd := GetLLVMProc('LLVMConstNUWAdd');
      @LLVMConstFAdd := GetLLVMProc('LLVMConstFAdd');
      @LLVMConstSub := GetLLVMProc('LLVMConstSub');
      @LLVMConstNSWSub := GetLLVMProc('LLVMConstNSWSub');
      @LLVMConstNUWSub := GetLLVMProc('LLVMConstNUWSub');
      @LLVMConstFSub := GetLLVMProc('LLVMConstFSub');
      @LLVMConstMul := GetLLVMProc('LLVMConstMul');
      @LLVMConstNSWMul := GetLLVMProc('LLVMConstNSWMul');
      @LLVMConstNUWMul := GetLLVMProc('LLVMConstNUWMul');
      @LLVMConstFMul := GetLLVMProc('LLVMConstFMul');
      @LLVMConstUDiv := GetLLVMProc('LLVMConstUDiv');
      @LLVMConstSDiv := GetLLVMProc('LLVMConstSDiv');
      @LLVMConstExactSDiv := GetLLVMProc('LLVMConstExactSDiv');
      @LLVMConstFDiv := GetLLVMProc('LLVMConstFDiv');
      @LLVMConstURem := GetLLVMProc('LLVMConstURem');
      @LLVMConstSRem := GetLLVMProc('LLVMConstSRem');
      @LLVMConstFRem := GetLLVMProc('LLVMConstFRem');
      @LLVMConstAnd := GetLLVMProc('LLVMConstAnd');
      @LLVMConstOr := GetLLVMProc('LLVMConstOr');
      @LLVMConstXor := GetLLVMProc('LLVMConstXor');
      @LLVMConstICmp := GetLLVMProc('LLVMConstICmp');
      @LLVMConstFCmp := GetLLVMProc('LLVMConstFCmp');
      @LLVMConstShl := GetLLVMProc('LLVMConstShl');
      @LLVMConstLShr := GetLLVMProc('LLVMConstLShr');
      @LLVMConstAShr := GetLLVMProc('LLVMConstAShr');
      @LLVMConstGEP := GetLLVMProc('LLVMConstGEP');
      @LLVMConstInBoundsGEP := GetLLVMProc('LLVMConstInBoundsGEP');
      @LLVMConstTrunc := GetLLVMProc('LLVMConstTrunc');
      @LLVMConstSExt := GetLLVMProc('LLVMConstSExt');
      @LLVMConstZExt := GetLLVMProc('LLVMConstZExt');
      @LLVMConstFPTrunc := GetLLVMProc('LLVMConstFPTrunc');
      @LLVMConstFPExt := GetLLVMProc('LLVMConstFPExt');
      @LLVMConstUIToFP := GetLLVMProc('LLVMConstUIToFP');
      @LLVMConstSIToFP := GetLLVMProc('LLVMConstSIToFP');
      @LLVMConstFPToUI := GetLLVMProc('LLVMConstFPToUI');
      @LLVMConstFPToSI := GetLLVMProc('LLVMConstFPToSI');
      @LLVMConstPtrToInt := GetLLVMProc('LLVMConstPtrToInt');
      @LLVMConstIntToPtr := GetLLVMProc('LLVMConstIntToPtr');
      @LLVMConstBitCast := GetLLVMProc('LLVMConstBitCast');
      @LLVMConstZExtOrBitCast := GetLLVMProc('LLVMConstZExtOrBitCast');
      @LLVMConstSExtOrBitCast := GetLLVMProc('LLVMConstSExtOrBitCast');
      @LLVMConstTruncOrBitCast := GetLLVMProc('LLVMConstTruncOrBitCast');
      @LLVMConstPointerCast := GetLLVMProc('LLVMConstPointerCast');
      @LLVMConstIntCast := GetLLVMProc('LLVMConstIntCast');
      @LLVMConstFPCast := GetLLVMProc('LLVMConstFPCast');
      @LLVMConstSelect := GetLLVMProc('LLVMConstSelect');
      @LLVMConstExtractElement := GetLLVMProc('LLVMConstExtractElement');
      @LLVMConstInsertElement := GetLLVMProc('LLVMConstInsertElement');
      @LLVMConstShuffleVector := GetLLVMProc('LLVMConstShuffleVector');
      @LLVMConstExtractValue := GetLLVMProc('LLVMConstExtractValue');
      @LLVMConstInsertValue := GetLLVMProc('LLVMConstInsertValue');
      @LLVMConstInlineAsm := GetLLVMProc('LLVMConstInlineAsm');
      @LLVMBlockAddress := GetLLVMProc('LLVMBlockAddress');
      @LLVMGetGlobalParent := GetLLVMProc('LLVMGetGlobalParent');
      @LLVMIsDeclaration := GetLLVMProc('LLVMIsDeclaration');
      @LLVMGetLinkage := GetLLVMProc('LLVMGetLinkage');
      @LLVMSetLinkage := GetLLVMProc('LLVMSetLinkage');
      @LLVMGetSection := GetLLVMProc('LLVMGetSection');
      @LLVMSetSection := GetLLVMProc('LLVMSetSection');
      @LLVMGetVisibility := GetLLVMProc('LLVMGetVisibility');
      @LLVMSetVisibility := GetLLVMProc('LLVMSetVisibility');
      @LLVMGetAlignment := GetLLVMProc('LLVMGetAlignment');
      @LLVMSetAlignment := GetLLVMProc('LLVMSetAlignment');
      @LLVMAddGlobal := GetLLVMProc('LLVMAddGlobal');
      @LLVMAddGlobalInAddressSpace := GetLLVMProc('LLVMAddGlobalInAddressSpace');
      @LLVMGetNamedGlobal := GetLLVMProc('LLVMGetNamedGlobal');
      @LLVMGetFirstGlobal := GetLLVMProc('LLVMGetFirstGlobal');
      @LLVMGetLastGlobal := GetLLVMProc('LLVMGetLastGlobal');
      @LLVMGetNextGlobal := GetLLVMProc('LLVMGetNextGlobal');
      @LLVMGetPreviousGlobal := GetLLVMProc('LLVMGetPreviousGlobal');
      @LLVMDeleteGlobal := GetLLVMProc('LLVMDeleteGlobal');
      @LLVMGetInitializer := GetLLVMProc('LLVMGetInitializer');
      @LLVMSetInitializer := GetLLVMProc('LLVMSetInitializer');
      @LLVMIsThreadLocal := GetLLVMProc('LLVMIsThreadLocal');
      @LLVMSetThreadLocal := GetLLVMProc('LLVMSetThreadLocal');
      @LLVMIsGlobalConstant := GetLLVMProc('LLVMIsGlobalConstant');
      @LLVMSetGlobalConstant := GetLLVMProc('LLVMSetGlobalConstant');
      @LLVMAddAlias := GetLLVMProc('LLVMAddAlias');
      @LLVMDeleteFunction := GetLLVMProc('LLVMDeleteFunction');
      @LLVMGetIntrinsicID := GetLLVMProc('LLVMGetIntrinsicID');
      @LLVMGetFunctionCallConv := GetLLVMProc('LLVMGetFunctionCallConv');
      @LLVMSetFunctionCallConv := GetLLVMProc('LLVMSetFunctionCallConv');
      @LLVMGetGC := GetLLVMProc('LLVMGetGC');
      @LLVMSetGC := GetLLVMProc('LLVMSetGC');
      @LLVMAddFunctionAttr := GetLLVMProc('LLVMAddFunctionAttr');
      @LLVMGetFunctionAttr := GetLLVMProc('LLVMGetFunctionAttr');
      @LLVMRemoveFunctionAttr := GetLLVMProc('LLVMRemoveFunctionAttr');
      @LLVMCountParams := GetLLVMProc('LLVMCountParams');
      @LLVMGetParams := GetLLVMProc('LLVMGetParams');
      @LLVMGetParam := GetLLVMProc('LLVMGetParam');
      @LLVMGetParamParent := GetLLVMProc('LLVMGetParamParent');
      @LLVMGetFirstParam := GetLLVMProc('LLVMGetFirstParam');
      @LLVMGetLastParam := GetLLVMProc('LLVMGetLastParam');
      @LLVMGetNextParam := GetLLVMProc('LLVMGetNextParam');
      @LLVMGetPreviousParam := GetLLVMProc('LLVMGetPreviousParam');
      @LLVMAddAttribute := GetLLVMProc('LLVMAddAttribute');
      @LLVMRemoveAttribute := GetLLVMProc('LLVMRemoveAttribute');
      @LLVMGetAttribute := GetLLVMProc('LLVMGetAttribute');
      @LLVMSetParamAlignment := GetLLVMProc('LLVMSetParamAlignment');
      @LLVMMDStringInContext := GetLLVMProc('LLVMMDStringInContext');
      @LLVMMDString := GetLLVMProc('LLVMMDString');
      @LLVMMDNodeInContext := GetLLVMProc('LLVMMDNodeInContext');
      @LLVMMDNode := GetLLVMProc('LLVMMDNode');
      @LLVMGetMDString := GetLLVMProc('LLVMGetMDString');
      @LLVMBasicBlockAsValue := GetLLVMProc('LLVMBasicBlockAsValue');
      @LLVMValueIsBasicBlock := GetLLVMProc('LLVMValueIsBasicBlock');
      @LLVMValueAsBasicBlock := GetLLVMProc('LLVMValueAsBasicBlock');
      @LLVMGetBasicBlockParent := GetLLVMProc('LLVMGetBasicBlockParent');
      @LLVMGetBasicBlockTerminator := GetLLVMProc('LLVMGetBasicBlockTerminator');
      @LLVMCountBasicBlocks := GetLLVMProc('LLVMCountBasicBlocks');
      @LLVMGetBasicBlocks := GetLLVMProc('LLVMGetBasicBlocks');
      @LLVMGetFirstBasicBlock := GetLLVMProc('LLVMGetFirstBasicBlock');
      @LLVMGetLastBasicBlock := GetLLVMProc('LLVMGetLastBasicBlock');
      @LLVMGetNextBasicBlock := GetLLVMProc('LLVMGetNextBasicBlock');
      @LLVMGetPreviousBasicBlock := GetLLVMProc('LLVMGetPreviousBasicBlock');
      @LLVMGetEntryBasicBlock := GetLLVMProc('LLVMGetEntryBasicBlock');
      @LLVMAppendBasicBlockInContext := GetLLVMProc('LLVMAppendBasicBlockInContext');
      @LLVMAppendBasicBlock := GetLLVMProc('LLVMAppendBasicBlock');
      @LLVMInsertBasicBlockInContext := GetLLVMProc('LLVMInsertBasicBlockInContext');
      @LLVMInsertBasicBlock := GetLLVMProc('LLVMInsertBasicBlock');
      @LLVMDeleteBasicBlock := GetLLVMProc('LLVMDeleteBasicBlock');
      @LLVMRemoveBasicBlockFromParent := GetLLVMProc('LLVMRemoveBasicBlockFromParent');
      @LLVMMoveBasicBlockBefore := GetLLVMProc('LLVMMoveBasicBlockBefore');
      @LLVMMoveBasicBlockAfter := GetLLVMProc('LLVMMoveBasicBlockAfter');
      @LLVMGetFirstInstruction := GetLLVMProc('LLVMGetFirstInstruction');
      @LLVMGetLastInstruction := GetLLVMProc('LLVMGetLastInstruction');
      @LLVMHasMetadata := GetLLVMProc('LLVMHasMetadata');
      @LLVMGetMetadata := GetLLVMProc('LLVMGetMetadata');
      @LLVMSetMetadata := GetLLVMProc('LLVMSetMetadata');
      @LLVMGetInstructionParent := GetLLVMProc('LLVMGetInstructionParent');
      @LLVMGetNextInstruction := GetLLVMProc('LLVMGetNextInstruction');
      @LLVMGetPreviousInstruction := GetLLVMProc('LLVMGetPreviousInstruction');
      @LLVMInstructionEraseFromParent := GetLLVMProc('LLVMInstructionEraseFromParent');
      @LLVMGetInstructionOpcode := GetLLVMProc('LLVMGetInstructionOpcode');
      @LLVMGetICmpPredicate := GetLLVMProc('LLVMGetICmpPredicate');
      @LLVMSetInstructionCallConv := GetLLVMProc('LLVMSetInstructionCallConv');
      @LLVMGetInstructionCallConv := GetLLVMProc('LLVMGetInstructionCallConv');
      @LLVMAddInstrAttribute := GetLLVMProc('LLVMAddInstrAttribute');
      @LLVMRemoveInstrAttribute := GetLLVMProc('LLVMRemoveInstrAttribute');
      @LLVMSetInstrParamAlignment := GetLLVMProc('LLVMSetInstrParamAlignment');
      @LLVMIsTailCall := GetLLVMProc('LLVMIsTailCall');
      @LLVMSetTailCall := GetLLVMProc('LLVMSetTailCall');
      @LLVMGetSwitchDefaultDest := GetLLVMProc('LLVMGetSwitchDefaultDest');
      @LLVMAddIncoming := GetLLVMProc('LLVMAddIncoming');
      @LLVMCountIncoming := GetLLVMProc('LLVMCountIncoming');
      @LLVMGetIncomingValue := GetLLVMProc('LLVMGetIncomingValue');
      @LLVMGetIncomingBlock := GetLLVMProc('LLVMGetIncomingBlock');
      @LLVMCreateBuilderInContext := GetLLVMProc('LLVMCreateBuilderInContext');
      @LLVMCreateBuilder := GetLLVMProc('LLVMCreateBuilder');
      @LLVMPositionBuilder := GetLLVMProc('LLVMPositionBuilder');
      @LLVMPositionBuilderBefore := GetLLVMProc('LLVMPositionBuilderBefore');
      @LLVMPositionBuilderAtEnd := GetLLVMProc('LLVMPositionBuilderAtEnd');
      @LLVMGetInsertBlock := GetLLVMProc('LLVMGetInsertBlock');
      @LLVMClearInsertionPosition := GetLLVMProc('LLVMClearInsertionPosition');
      @LLVMInsertIntoBuilder := GetLLVMProc('LLVMInsertIntoBuilder');
      @LLVMInsertIntoBuilderWithName := GetLLVMProc('LLVMInsertIntoBuilderWithName');
      @LLVMDisposeBuilder := GetLLVMProc('LLVMDisposeBuilder');
      @LLVMSetCurrentDebugLocation := GetLLVMProc('LLVMSetCurrentDebugLocation');
      @LLVMGetCurrentDebugLocation := GetLLVMProc('LLVMGetCurrentDebugLocation');
      @LLVMSetInstDebugLocation := GetLLVMProc('LLVMSetInstDebugLocation');
      @LLVMBuildRetVoid := GetLLVMProc('LLVMBuildRetVoid');
      @LLVMBuildRet := GetLLVMProc('LLVMBuildRet');
      @LLVMBuildAggregateRet := GetLLVMProc('LLVMBuildAggregateRet');
      @LLVMBuildBr := GetLLVMProc('LLVMBuildBr');
      @LLVMBuildCondBr := GetLLVMProc('LLVMBuildCondBr');
      @LLVMBuildSwitch := GetLLVMProc('LLVMBuildSwitch');
      @LLVMBuildIndirectBr := GetLLVMProc('LLVMBuildIndirectBr');
      @LLVMBuildInvoke := GetLLVMProc('LLVMBuildInvoke');
      @LLVMBuildLandingPad := GetLLVMProc('LLVMBuildLandingPad');
      @LLVMBuildResume := GetLLVMProc('LLVMBuildResume');
      @LLVMBuildUnreachable := GetLLVMProc('LLVMBuildUnreachable');
      @LLVMAddCase := GetLLVMProc('LLVMAddCase');
      @LLVMAddDestination := GetLLVMProc('LLVMAddDestination');
      @LLVMAddClause := GetLLVMProc('LLVMAddClause');
      @LLVMSetCleanup := GetLLVMProc('LLVMSetCleanup');
      @LLVMBuildAdd := GetLLVMProc('LLVMBuildAdd');
      @LLVMBuildNSWAdd := GetLLVMProc('LLVMBuildNSWAdd');
      @LLVMBuildNUWAdd := GetLLVMProc('LLVMBuildNUWAdd');
      @LLVMBuildFAdd := GetLLVMProc('LLVMBuildFAdd');
      @LLVMBuildSub := GetLLVMProc('LLVMBuildSub');
      @LLVMBuildNSWSub := GetLLVMProc('LLVMBuildNSWSub');
      @LLVMBuildNUWSub := GetLLVMProc('LLVMBuildNUWSub');
      @LLVMBuildFSub := GetLLVMProc('LLVMBuildFSub');
      @LLVMBuildMul := GetLLVMProc('LLVMBuildMul');
      @LLVMBuildNSWMul := GetLLVMProc('LLVMBuildNSWMul');
      @LLVMBuildNUWMul := GetLLVMProc('LLVMBuildNUWMul');
      @LLVMBuildFMul := GetLLVMProc('LLVMBuildFMul');
      @LLVMBuildUDiv := GetLLVMProc('LLVMBuildUDiv');
      @LLVMBuildSDiv := GetLLVMProc('LLVMBuildSDiv');
      @LLVMBuildExactSDiv := GetLLVMProc('LLVMBuildExactSDiv');
      @LLVMBuildFDiv := GetLLVMProc('LLVMBuildFDiv');
      @LLVMBuildURem := GetLLVMProc('LLVMBuildURem');
      @LLVMBuildSRem := GetLLVMProc('LLVMBuildSRem');
      @LLVMBuildFRem := GetLLVMProc('LLVMBuildFRem');
      @LLVMBuildShl := GetLLVMProc('LLVMBuildShl');
      @LLVMBuildLShr := GetLLVMProc('LLVMBuildLShr');
      @LLVMBuildAShr := GetLLVMProc('LLVMBuildAShr');
      @LLVMBuildAnd := GetLLVMProc('LLVMBuildAnd');
      @LLVMBuildOr := GetLLVMProc('LLVMBuildOr');
      @LLVMBuildXor := GetLLVMProc('LLVMBuildXor');
      @LLVMBuildBinOp := GetLLVMProc('LLVMBuildBinOp');
      @LLVMBuildNeg := GetLLVMProc('LLVMBuildNeg');
      @LLVMBuildNSWNeg := GetLLVMProc('LLVMBuildNSWNeg');
      @LLVMBuildNUWNeg := GetLLVMProc('LLVMBuildNUWNeg');
      @LLVMBuildFNeg := GetLLVMProc('LLVMBuildFNeg');
      @LLVMBuildNot := GetLLVMProc('LLVMBuildNot');
      @LLVMBuildMalloc := GetLLVMProc('LLVMBuildMalloc');
      @LLVMBuildArrayMalloc := GetLLVMProc('LLVMBuildArrayMalloc');
      @LLVMBuildAlloca := GetLLVMProc('LLVMBuildAlloca');
      @LLVMBuildArrayAlloca := GetLLVMProc('LLVMBuildArrayAlloca');
      @LLVMBuildFree := GetLLVMProc('LLVMBuildFree');
      @LLVMBuildLoad := GetLLVMProc('LLVMBuildLoad');
      @LLVMBuildStore := GetLLVMProc('LLVMBuildStore');
      @LLVMBuildGEP := GetLLVMProc('LLVMBuildGEP');
      @LLVMBuildInBoundsGEP := GetLLVMProc('LLVMBuildInBoundsGEP');
      @LLVMBuildStructGEP := GetLLVMProc('LLVMBuildStructGEP');
      @LLVMBuildGlobalString := GetLLVMProc('LLVMBuildGlobalString');
      @LLVMBuildGlobalStringPtr := GetLLVMProc('LLVMBuildGlobalStringPtr');
      @LLVMGetVolatile := GetLLVMProc('LLVMGetVolatile');
      @LLVMSetVolatile := GetLLVMProc('LLVMSetVolatile');
      @LLVMBuildTrunc := GetLLVMProc('LLVMBuildTrunc');
      @LLVMBuildZExt := GetLLVMProc('LLVMBuildZExt');
      @LLVMBuildSExt := GetLLVMProc('LLVMBuildSExt');
      @LLVMBuildFPToUI := GetLLVMProc('LLVMBuildFPToUI');
      @LLVMBuildFPToSI := GetLLVMProc('LLVMBuildFPToSI');
      @LLVMBuildUIToFP := GetLLVMProc('LLVMBuildUIToFP');
      @LLVMBuildSIToFP := GetLLVMProc('LLVMBuildSIToFP');
      @LLVMBuildFPTrunc := GetLLVMProc('LLVMBuildFPTrunc');
      @LLVMBuildFPExt := GetLLVMProc('LLVMBuildFPExt');
      @LLVMBuildPtrToInt := GetLLVMProc('LLVMBuildPtrToInt');
      @LLVMBuildIntToPtr := GetLLVMProc('LLVMBuildIntToPtr');
      @LLVMBuildBitCast := GetLLVMProc('LLVMBuildBitCast');
      @LLVMBuildZExtOrBitCast := GetLLVMProc('LLVMBuildZExtOrBitCast');
      @LLVMBuildSExtOrBitCast := GetLLVMProc('LLVMBuildSExtOrBitCast');
      @LLVMBuildTruncOrBitCast := GetLLVMProc('LLVMBuildTruncOrBitCast');
      @LLVMBuildCast := GetLLVMProc('LLVMBuildCast');
      @LLVMBuildPointerCast := GetLLVMProc('LLVMBuildPointerCast');
      @LLVMBuildIntCast := GetLLVMProc('LLVMBuildIntCast');
      @LLVMBuildFPCast := GetLLVMProc('LLVMBuildFPCast');
      @LLVMBuildICmp := GetLLVMProc('LLVMBuildICmp');
      @LLVMBuildFCmp := GetLLVMProc('LLVMBuildFCmp');
      @LLVMBuildPhi := GetLLVMProc('LLVMBuildPhi');
      @LLVMBuildCall := GetLLVMProc('LLVMBuildCall');
      @LLVMBuildSelect := GetLLVMProc('LLVMBuildSelect');
      @LLVMBuildVAArg := GetLLVMProc('LLVMBuildVAArg');
      @LLVMBuildExtractElement := GetLLVMProc('LLVMBuildExtractElement');
      @LLVMBuildInsertElement := GetLLVMProc('LLVMBuildInsertElement');
      @LLVMBuildShuffleVector := GetLLVMProc('LLVMBuildShuffleVector');
      @LLVMBuildExtractValue := GetLLVMProc('LLVMBuildExtractValue');
      @LLVMBuildInsertValue := GetLLVMProc('LLVMBuildInsertValue');
      @LLVMBuildIsNull := GetLLVMProc('LLVMBuildIsNull');
      @LLVMBuildIsNotNull := GetLLVMProc('LLVMBuildIsNotNull');
      @LLVMBuildPtrDiff := GetLLVMProc('LLVMBuildPtrDiff');
      @LLVMCreateModuleProviderForExistingModule := GetLLVMProc('LLVMCreateModuleProviderForExistingModule');
      @LLVMDisposeModuleProvider := GetLLVMProc('LLVMDisposeModuleProvider');
      @LLVMCreateMemoryBufferWithContentsOfFile := GetLLVMProc('LLVMCreateMemoryBufferWithContentsOfFile');
      @LLVMCreateMemoryBufferWithSTDIN := GetLLVMProc('LLVMCreateMemoryBufferWithSTDIN');
      @LLVMDisposeMemoryBuffer := GetLLVMProc('LLVMDisposeMemoryBuffer');
      @LLVMGetGlobalPassRegistry := GetLLVMProc('LLVMGetGlobalPassRegistry');
      @LLVMCreatePassManager := GetLLVMProc('LLVMCreatePassManager');
      @LLVMCreateFunctionPassManagerForModule := GetLLVMProc('LLVMCreateFunctionPassManagerForModule');
      @LLVMCreateFunctionPassManager := GetLLVMProc('LLVMCreateFunctionPassManager');
      @LLVMRunPassManager := GetLLVMProc('LLVMRunPassManager');
      @LLVMInitializeFunctionPassManager := GetLLVMProc('LLVMInitializeFunctionPassManager');
      @LLVMRunFunctionPassManager := GetLLVMProc('LLVMRunFunctionPassManager');
      @LLVMFinalizeFunctionPassManager := GetLLVMProc('LLVMFinalizeFunctionPassManager');
      @LLVMDisposePassManager := GetLLVMProc('LLVMDisposePassManager');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_ANALYSIS}
      LLVMTraceLog(';Analysis.h');
      @LLVMVerifyModule := GetLLVMProc('LLVMVerifyModule');
      @LLVMVerifyFunction := GetLLVMProc('LLVMVerifyFunction');
      @LLVMViewFunctionCFG := GetLLVMProc('LLVMViewFunctionCFG');
      @LLVMViewFunctionCFGOnly := GetLLVMProc('LLVMViewFunctionCFGOnly');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_BITREADER}
      LLVMTraceLog(';BitReader.h');
      @LLVMParseBitcode := GetLLVMProc('LLVMParseBitcode');
      @LLVMParseBitcodeInContext := GetLLVMProc('LLVMParseBitcodeInContext');
      @LLVMGetBitcodeModuleInContext := GetLLVMProc('LLVMGetBitcodeModuleInContext');
      @LLVMGetBitcodeModule := GetLLVMProc('LLVMGetBitcodeModule');
      @LLVMGetBitcodeModuleProviderInContext := GetLLVMProc('LLVMGetBitcodeModuleProviderInContext');
      @LLVMGetBitcodeModuleProvider := GetLLVMProc('LLVMGetBitcodeModuleProvider');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_BITWRITER}
      LLVMTraceLog(';BitWriter.h');
      @LLVMWriteBitcodeToFile := GetLLVMProc('LLVMWriteBitcodeToFile');
      @LLVMWriteBitcodeToFD := GetLLVMProc('LLVMWriteBitcodeToFD');
      @LLVMWriteBitcodeToFileHandle := GetLLVMProc('LLVMWriteBitcodeToFileHandle');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_INITIALIZATION}
      LLVMTraceLog(';Initialization.h');
      @LLVMInitializeCore_ := GetLLVMProc('LLVMInitializeCore');
      @LLVMInitializeTransformUtils := GetLLVMProc('LLVMInitializeTransformUtils');
      @LLVMInitializeScalarOpts := GetLLVMProc('LLVMInitializeScalarOpts');
      @LLVMInitializeVectorization := GetLLVMProc('LLVMInitializeVectorization');
      @LLVMInitializeInstCombine := GetLLVMProc('LLVMInitializeInstCombine');
      @LLVMInitializeIPO := GetLLVMProc('LLVMInitializeIPO');
      @LLVMInitializeInstrumentation := GetLLVMProc('LLVMInitializeInstrumentation');
      @LLVMInitializeAnalysis := GetLLVMProc('LLVMInitializeAnalysis');
      @LLVMInitializeIPA := GetLLVMProc('LLVMInitializeIPA');
      @LLVMInitializeCodeGen := GetLLVMProc('LLVMInitializeCodeGen');
      @LLVMInitializeTarget := GetLLVMProc('LLVMInitializeTarget');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_LINKTIMEOPTIMIZER}
      LLVMTraceLog(';LinkTimeOptimizer.h');
      @llvm_create_optimizer := GetLLVMProc('llvm_create_optimizer');
      @llvm_destroy_optimizer := GetLLVMProc('llvm_destroy_optimizer');
      @llvm_read_object_file := GetLLVMProc('llvm_read_object_file');
      @llvm_optimize_modules := GetLLVMProc('llvm_optimize_modules');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_TARGET}
      LLVMTraceLog(';Target.h');
      @LLVMInitializeAllTargetInfos := GetLLVMProc('LLVMInitializeAllTargetInfosDL');      // This function need wrapper
      @LLVMInitializeAllTargets := GetLLVMProc('LLVMInitializeAllTargetsDL');              // This function need wrapper
      @LLVMInitializeAllTargetMCs := GetLLVMProc('LLVMInitializeAllTargetMCsDL');          // This function need wrapper
      @LLVMInitializeAllAsmPrinters := GetLLVMProc('LLVMInitializeAllAsmPrintersDL');      // This function need wrapper
      @LLVMInitializeAllAsmParsers := GetLLVMProc('LLVMInitializeAllAsmParsersDL');        // This function need wrapper
      @LLVMInitializeAllDisassemblers := GetLLVMProc('LLVMInitializeAllDisassemblersDL');  // This function need wrapper
      @LLVMInitializeNativeTarget := GetLLVMProc('LLVMInitializeNativeTargetDL');          // This function need wrapper
      @LLVMCreateTargetData := GetLLVMProc('LLVMCreateTargetData');
      @LLVMAddTargetData := GetLLVMProc('LLVMAddTargetData');
      @LLVMAddTargetLibraryInfo := GetLLVMProc('LLVMAddTargetLibraryInfo');
      @LLVMCopyStringRepOfTargetData := GetLLVMProc('LLVMCopyStringRepOfTargetData');
      @LLVMByteOrder := GetLLVMProc('LLVMByteOrder');
      @LLVMPointerSize := GetLLVMProc('LLVMPointerSize');
      @LLVMIntPtrType := GetLLVMProc('LLVMIntPtrType');
      @LLVMSizeOfTypeInBits := GetLLVMProc('LLVMSizeOfTypeInBits');
      @LLVMStoreSizeOfType := GetLLVMProc('LLVMStoreSizeOfType');
      @LLVMABISizeOfType := GetLLVMProc('LLVMABISizeOfType');
      @LLVMABIAlignmentOfType := GetLLVMProc('LLVMABIAlignmentOfType');
      @LLVMCallFrameAlignmentOfType := GetLLVMProc('LLVMCallFrameAlignmentOfType');
      @LLVMPreferredAlignmentOfType := GetLLVMProc('LLVMPreferredAlignmentOfType');
      @LLVMPreferredAlignmentOfGlobal := GetLLVMProc('LLVMPreferredAlignmentOfGlobal');
      @LLVMElementAtOffset := GetLLVMProc('LLVMElementAtOffset');
      @LLVMOffsetOfElement := GetLLVMProc('LLVMOffsetOfElement');
      @LLVMDisposeTargetData := GetLLVMProc('LLVMDisposeTargetData');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_TARGETMACHINE}
      LLVMTraceLog(';TargetMachine.h');
      @LLVMGetFirstTarget := GetLLVMProc('LLVMGetFirstTarget');
      @LLVMGetNextTarget := GetLLVMProc('LLVMGetNextTarget');
      @LLVMGetTargetName := GetLLVMProc('LLVMGetTargetName');
      @LLVMGetTargetDescription := GetLLVMProc('LLVMGetTargetDescription');
      @LLVMTargetHasJIT := GetLLVMProc('LLVMTargetHasJIT');
      @LLVMTargetHasTargetMachine := GetLLVMProc('LLVMTargetHasTargetMachine');
      @LLVMTargetHasAsmBackend := GetLLVMProc('LLVMTargetHasAsmBackend');
      @LLVMCreateTargetMachine := GetLLVMProc('LLVMCreateTargetMachine');
      @LLVMDisposeTargetMachine := GetLLVMProc('LLVMDisposeTargetMachine');
      @LLVMGetTargetMachineTarget := GetLLVMProc('LLVMGetTargetMachineTarget');
      @LLVMGetTargetMachineTriple := GetLLVMProc('LLVMGetTargetMachineTriple');
      @LLVMGetTargetMachineCPU := GetLLVMProc('LLVMGetTargetMachineCPU');
      @LLVMGetTargetMachineFeatureString := GetLLVMProc('LLVMGetTargetMachineFeatureString');
      @LLVMGetTargetMachineData := GetLLVMProc('LLVMGetTargetMachineData');
      @LLVMTargetMachineEmitToFile := GetLLVMProc('LLVMTargetMachineEmitToFile');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_OBJECT}
      LLVMTraceLog(';Object.h');
      @LLVMCreateObjectFile := GetLLVMProc('LLVMCreateObjectFile');
      @LLVMDisposeObjectFile := GetLLVMProc('LLVMDisposeObjectFile');
      @LLVMGetSections := GetLLVMProc('LLVMGetSections');
      @LLVMDisposeSectionIterator := GetLLVMProc('LLVMDisposeSectionIterator');
      @LLVMIsSectionIteratorAtEnd := GetLLVMProc('LLVMIsSectionIteratorAtEnd');
      @LLVMMoveToNextSection := GetLLVMProc('LLVMMoveToNextSection');
      @LLVMMoveToContainingSection := GetLLVMProc('LLVMMoveToContainingSection');
      @LLVMGetSymbols := GetLLVMProc('LLVMGetSymbols');
      @LLVMDisposeSymbolIterator := GetLLVMProc('LLVMDisposeSymbolIterator');
      @LLVMIsSymbolIteratorAtEnd := GetLLVMProc('LLVMIsSymbolIteratorAtEnd');
      @LLVMMoveToNextSymbol := GetLLVMProc('LLVMMoveToNextSymbol');
      @LLVMGetSectionName := GetLLVMProc('LLVMGetSectionName');
      @LLVMGetSectionSize := GetLLVMProc('LLVMGetSectionSize');
      @LLVMGetSectionContents := GetLLVMProc('LLVMGetSectionContents');
      @LLVMGetSectionAddress := GetLLVMProc('LLVMGetSectionAddress');
      @LLVMGetSectionContainsSymbol := GetLLVMProc('LLVMGetSectionContainsSymbol');
      @LLVMGetRelocations := GetLLVMProc('LLVMGetRelocations');
      @LLVMDisposeRelocationIterator := GetLLVMProc('LLVMDisposeRelocationIterator');
      @LLVMIsRelocationIteratorAtEnd := GetLLVMProc('LLVMIsRelocationIteratorAtEnd');
      @LLVMMoveToNextRelocation := GetLLVMProc('LLVMMoveToNextRelocation');
      @LLVMGetSymbolName := GetLLVMProc('LLVMGetSymbolName');
      @LLVMGetSymbolAddress := GetLLVMProc('LLVMGetSymbolAddress');
      @LLVMGetSymbolFileOffset := GetLLVMProc('LLVMGetSymbolFileOffset');
      @LLVMGetSymbolSize := GetLLVMProc('LLVMGetSymbolSize');
      @LLVMGetRelocationAddress := GetLLVMProc('LLVMGetRelocationAddress');
      @LLVMGetRelocationOffset := GetLLVMProc('LLVMGetRelocationOffset');
      @LLVMGetRelocationSymbol := GetLLVMProc('LLVMGetRelocationSymbol');
      @LLVMGetRelocationType := GetLLVMProc('LLVMGetRelocationType');
      @LLVMGetRelocationTypeName := GetLLVMProc('LLVMGetRelocationTypeName');
      @LLVMGetRelocationValueString := GetLLVMProc('LLVMGetRelocationValueString');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_EXECUTIONENGINE}
      LLVMTraceLog(';ExecutionEngine.h');
      @LLVMLinkInJIT := GetLLVMProc('LLVMLinkInJIT');
      @LLVMLinkInInterpreter := GetLLVMProc('LLVMLinkInInterpreter');
      @LLVMCreateGenericValueOfInt := GetLLVMProc('LLVMCreateGenericValueOfInt');
      @LLVMCreateGenericValueOfPointer := GetLLVMProc('LLVMCreateGenericValueOfPointer');
      @LLVMCreateGenericValueOfFloat := GetLLVMProc('LLVMCreateGenericValueOfFloat');
      @LLVMGenericValueIntWidth := GetLLVMProc('LLVMGenericValueIntWidth');
      @LLVMGenericValueToInt := GetLLVMProc('LLVMGenericValueToInt');
      @LLVMGenericValueToPointer := GetLLVMProc('LLVMGenericValueToPointer');
      @LLVMGenericValueToFloat := GetLLVMProc('LLVMGenericValueToFloat');
      @LLVMDisposeGenericValue := GetLLVMProc('LLVMDisposeGenericValue');
      @LLVMCreateExecutionEngineForModule := GetLLVMProc('LLVMCreateExecutionEngineForModule');
      @LLVMCreateInterpreterForModule := GetLLVMProc('LLVMCreateInterpreterForModule');
      @LLVMCreateJITCompilerForModule := GetLLVMProc('LLVMCreateJITCompilerForModule');
      @LLVMCreateExecutionEngine := GetLLVMProc('LLVMCreateExecutionEngine');
      @LLVMCreateInterpreter := GetLLVMProc('LLVMCreateInterpreter');
      @LLVMCreateJITCompiler := GetLLVMProc('LLVMCreateJITCompiler');
      @LLVMDisposeExecutionEngine := GetLLVMProc('LLVMDisposeExecutionEngine');
      @LLVMRunStaticConstructors := GetLLVMProc('LLVMRunStaticConstructors');
      @LLVMRunStaticDestructors := GetLLVMProc('LLVMRunStaticDestructors');
      @LLVMRunFunctionAsMain := GetLLVMProc('LLVMRunFunctionAsMain');
      @LLVMRunFunction := GetLLVMProc('LLVMRunFunction');
      @LLVMFreeMachineCodeForFunction := GetLLVMProc('LLVMFreeMachineCodeForFunction');
      @LLVMAddModule := GetLLVMProc('LLVMAddModule');
      @LLVMAddModuleProvider := GetLLVMProc('LLVMAddModuleProvider');
      @LLVMRemoveModule := GetLLVMProc('LLVMRemoveModule');
      @LLVMRemoveModuleProvider := GetLLVMProc('LLVMRemoveModuleProvider');
      @LLVMFindFunction := GetLLVMProc('LLVMFindFunction');
      @LLVMRecompileAndRelinkFunction := GetLLVMProc('LLVMRecompileAndRelinkFunction');
      @LLVMGetExecutionEngineTargetData := GetLLVMProc('LLVMGetExecutionEngineTargetData');
      @LLVMAddGlobalMapping := GetLLVMProc('LLVMAddGlobalMapping');
      @LLVMGetPointerToGlobal := GetLLVMProc('LLVMGetPointerToGlobal');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_DISASSEMBLER}
      LLVMTraceLog('Disassembler.h');
      @LLVMCreateDisasm := GetLLVMProc('LLVMCreateDisasm');
      @LLVMDisasmDispose := GetLLVMProc('LLVMDisasmDispose');
      @LLVMDisasmInstruction := GetLLVMProc('LLVMDisasmInstruction');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_LTO}
      LLVMTraceLog(';lto.h');
      @lto_get_version := GetLLVMProc('lto_get_version');
      @lto_get_error_message := GetLLVMProc('lto_get_error_message');
      @lto_module_is_object_file := GetLLVMProc('lto_module_is_object_file');
      @lto_module_is_object_file_for_target := GetLLVMProc('lto_module_is_object_file_for_target');
      @lto_module_is_object_file_in_memory := GetLLVMProc('lto_module_is_object_file_in_memory');
      @lto_module_is_object_file_in_memory_for_target := GetLLVMProc('lto_module_is_object_file_in_memory_for_target');
      @lto_module_create := GetLLVMProc('lto_module_create');
      @lto_module_create_from_memory := GetLLVMProc('lto_module_create_from_memory');
      @lto_module_create_from_fd := GetLLVMProc('lto_module_create_from_fd');
      @lto_module_create_from_fd_at_offset := GetLLVMProc('lto_module_create_from_fd_at_offset');
      @lto_module_dispose := GetLLVMProc('lto_module_dispose');
      @lto_module_get_target_triple := GetLLVMProc('lto_module_get_target_triple');
      @lto_module_set_target_triple := GetLLVMProc('lto_module_set_target_triple');
      @lto_module_get_num_symbols := GetLLVMProc('lto_module_get_num_symbols');
      @lto_module_get_symbol_name := GetLLVMProc('lto_module_get_symbol_name');
      @lto_module_get_symbol_attribute := GetLLVMProc('lto_module_get_symbol_attribute');
      @lto_codegen_create := GetLLVMProc('lto_codegen_create');
      @lto_codegen_dispose := GetLLVMProc('lto_codegen_dispose');
      @lto_codegen_add_module := GetLLVMProc('lto_codegen_add_module');
      @lto_codegen_set_debug_model := GetLLVMProc('lto_codegen_set_debug_model');
      @lto_codegen_set_pic_model := GetLLVMProc('lto_codegen_set_pic_model');
      @lto_codegen_set_cpu := GetLLVMProc('lto_codegen_set_cpu');
      @lto_codegen_set_assembler_path := GetLLVMProc('lto_codegen_set_assembler_path');
      @lto_codegen_set_assembler_args := GetLLVMProc('lto_codegen_set_assembler_args');
      @lto_codegen_add_must_preserve_symbol := GetLLVMProc('lto_codegen_add_must_preserve_symbol');
      @lto_codegen_write_merged_modules := GetLLVMProc('lto_codegen_write_merged_modules');
      @lto_codegen_compile := GetLLVMProc('lto_codegen_compile');
      @lto_codegen_compile_to_file := GetLLVMProc('lto_codegen_compile_to_file');
      @lto_codegen_debug_options := GetLLVMProc('lto_codegen_debug_options');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_ENHANCEDDISASSEMBLY}
      LLVMTraceLog(';EnhancedDisassembly.h');
      @EDGetDisassembler := GetLLVMProc('EDGetDisassembler');
      @EDGetRegisterName := GetLLVMProc('EDGetRegisterName');
      @EDRegisterIsStackPointer := GetLLVMProc('EDRegisterIsStackPointer');
      @EDRegisterIsProgramCounter := GetLLVMProc('EDRegisterIsProgramCounter');
      @EDCreateInsts := GetLLVMProc('EDCreateInsts');
      @EDReleaseInst := GetLLVMProc('EDReleaseInst');
      @EDInstByteSize := GetLLVMProc('EDInstByteSize');
      @EDGetInstString := GetLLVMProc('EDGetInstString');
      @EDInstID := GetLLVMProc('EDInstID');
      @EDInstIsBranch := GetLLVMProc('EDInstIsBranch');
      @EDInstIsMove := GetLLVMProc('EDInstIsMove');
      @EDBranchTargetID := GetLLVMProc('EDBranchTargetID');
      @EDMoveSourceID := GetLLVMProc('EDMoveSourceID');
      @EDMoveTargetID := GetLLVMProc('EDMoveTargetID');
      @EDNumTokens := GetLLVMProc('EDNumTokens');
      @EDGetToken := GetLLVMProc('EDGetToken');
      @EDGetTokenString := GetLLVMProc('EDGetTokenString');
      @EDOperandIndexForToken := GetLLVMProc('EDOperandIndexForToken');
      @EDTokenIsWhitespace := GetLLVMProc('EDTokenIsWhitespace');
      @EDTokenIsPunctuation := GetLLVMProc('EDTokenIsPunctuation');
      @EDTokenIsOpcode := GetLLVMProc('EDTokenIsOpcode');
      @EDTokenIsLiteral := GetLLVMProc('EDTokenIsLiteral');
      @EDTokenIsRegister := GetLLVMProc('EDTokenIsRegister');
      @EDTokenIsNegativeLiteral := GetLLVMProc('EDTokenIsNegativeLiteral');
      @EDLiteralTokenAbsoluteValue := GetLLVMProc('EDLiteralTokenAbsoluteValue');
      @EDRegisterTokenValue := GetLLVMProc('EDRegisterTokenValue');
      @EDNumOperands := GetLLVMProc('EDNumOperands');
      @EDGetOperand := GetLLVMProc('EDGetOperand');
      @EDOperandIsRegister := GetLLVMProc('EDOperandIsRegister');
      @EDOperandIsImmediate := GetLLVMProc('EDOperandIsImmediate');
      @EDOperandIsMemory := GetLLVMProc('EDOperandIsMemory');
      @EDRegisterOperandValue := GetLLVMProc('EDRegisterOperandValue');
      @EDImmediateOperandValue := GetLLVMProc('EDImmediateOperandValue');
      @EDEvaluateOperand := GetLLVMProc('EDEvaluateOperand');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_IPO}
      LLVMTraceLog(';Ipo.h');
      @LLVMAddArgumentPromotionPass := GetLLVMProc('LLVMAddArgumentPromotionPass');
      @LLVMAddConstantMergePass := GetLLVMProc('LLVMAddConstantMergePass');
      @LLVMAddDeadArgEliminationPass := GetLLVMProc('LLVMAddDeadArgEliminationPass');
      @LLVMAddFunctionAttrsPass := GetLLVMProc('LLVMAddFunctionAttrsPass');
      @LLVMAddFunctionInliningPass := GetLLVMProc('LLVMAddFunctionInliningPass');
      @LLVMAddAlwaysInlinerPass := GetLLVMProc('LLVMAddAlwaysInlinerPass');
      @LLVMAddGlobalDCEPass := GetLLVMProc('LLVMAddGlobalDCEPass');
      @LLVMAddGlobalOptimizerPass := GetLLVMProc('LLVMAddGlobalOptimizerPass');
      @LLVMAddIPConstantPropagationPass := GetLLVMProc('LLVMAddIPConstantPropagationPass');
      @LLVMAddPruneEHPass := GetLLVMProc('LLVMAddPruneEHPass');
      @LLVMAddIPSCCPPass := GetLLVMProc('LLVMAddIPSCCPPass');
      @LLVMAddInternalizePass := GetLLVMProc('LLVMAddInternalizePass');
      @LLVMAddStripDeadPrototypesPass := GetLLVMProc('LLVMAddStripDeadPrototypesPass');
      @LLVMAddStripSymbolsPass := GetLLVMProc('LLVMAddStripSymbolsPass');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_PASSMANAGERBUILDER}
      LLVMTraceLog(';PassManagerBuilder.h');
      @LLVMPassManagerBuilderCreate := GetLLVMProc('LLVMPassManagerBuilderCreate');
      @LLVMPassManagerBuilderDispose := GetLLVMProc('LLVMPassManagerBuilderDispose');
      @LLVMPassManagerBuilderSetOptLevel := GetLLVMProc('LLVMPassManagerBuilderSetOptLevel');
      @LLVMPassManagerBuilderSetSizeLevel := GetLLVMProc('LLVMPassManagerBuilderSetSizeLevel');
      @LLVMPassManagerBuilderSetDisableUnitAtATime := GetLLVMProc('LLVMPassManagerBuilderSetDisableUnitAtATime');
      @LLVMPassManagerBuilderSetDisableUnrollLoops := GetLLVMProc('LLVMPassManagerBuilderSetDisableUnrollLoops');
      @LLVMPassManagerBuilderSetDisableSimplifyLibCalls := GetLLVMProc('LLVMPassManagerBuilderSetDisableSimplifyLibCalls');
      @LLVMPassManagerBuilderUseInlinerWithThreshold := GetLLVMProc('LLVMPassManagerBuilderUseInlinerWithThreshold');
      @LLVMPassManagerBuilderPopulateFunctionPassManager := GetLLVMProc('LLVMPassManagerBuilderPopulateFunctionPassManager');
      @LLVMPassManagerBuilderPopulateModulePassManager := GetLLVMProc('LLVMPassManagerBuilderPopulateModulePassManager');
      @LLVMPassManagerBuilderPopulateLTOPassManager := GetLLVMProc('LLVMPassManagerBuilderPopulateLTOPassManager');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_SCALAR}
      LLVMTraceLog(';Scalar.h');
      @LLVMAddAggressiveDCEPass := GetLLVMProc('LLVMAddAggressiveDCEPass');
      @LLVMAddCFGSimplificationPass := GetLLVMProc('LLVMAddCFGSimplificationPass');
      @LLVMAddDeadStoreEliminationPass := GetLLVMProc('LLVMAddDeadStoreEliminationPass');
      @LLVMAddGVNPass := GetLLVMProc('LLVMAddGVNPass');
      @LLVMAddIndVarSimplifyPass := GetLLVMProc('LLVMAddIndVarSimplifyPass');
      @LLVMAddInstructionCombiningPass := GetLLVMProc('LLVMAddInstructionCombiningPass');
      @LLVMAddJumpThreadingPass := GetLLVMProc('LLVMAddJumpThreadingPass');
      @LLVMAddLICMPass := GetLLVMProc('LLVMAddLICMPass');
      @LLVMAddLoopDeletionPass := GetLLVMProc('LLVMAddLoopDeletionPass');
      @LLVMAddLoopIdiomPass := GetLLVMProc('LLVMAddLoopIdiomPass');
      @LLVMAddLoopRotatePass := GetLLVMProc('LLVMAddLoopRotatePass');
      @LLVMAddLoopUnrollPass := GetLLVMProc('LLVMAddLoopUnrollPass');
      @LLVMAddLoopUnswitchPass := GetLLVMProc('LLVMAddLoopUnswitchPass');
      @LLVMAddMemCpyOptPass := GetLLVMProc('LLVMAddMemCpyOptPass');
      @LLVMAddPromoteMemoryToRegisterPass := GetLLVMProc('LLVMAddPromoteMemoryToRegisterPass');
      @LLVMAddReassociatePass := GetLLVMProc('LLVMAddReassociatePass');
      @LLVMAddSCCPPass := GetLLVMProc('LLVMAddSCCPPass');
      @LLVMAddScalarReplAggregatesPass := GetLLVMProc('LLVMAddScalarReplAggregatesPass');
      @LLVMAddScalarReplAggregatesPassSSA := GetLLVMProc('LLVMAddScalarReplAggregatesPassSSA');
      @LLVMAddScalarReplAggregatesPassWithThreshold := GetLLVMProc('LLVMAddScalarReplAggregatesPassWithThreshold');
      @LLVMAddSimplifyLibCallsPass := GetLLVMProc('LLVMAddSimplifyLibCallsPass');
      @LLVMAddTailCallEliminationPass := GetLLVMProc('LLVMAddTailCallEliminationPass');
      @LLVMAddConstantPropagationPass := GetLLVMProc('LLVMAddConstantPropagationPass');
      @LLVMAddDemoteMemoryToRegisterPass := GetLLVMProc('LLVMAddDemoteMemoryToRegisterPass');
      @LLVMAddVerifierPass := GetLLVMProc('LLVMAddVerifierPass');
      @LLVMAddCorrelatedValuePropagationPass := GetLLVMProc('LLVMAddCorrelatedValuePropagationPass');
      @LLVMAddEarlyCSEPass := GetLLVMProc('LLVMAddEarlyCSEPass');
      @LLVMAddLowerExpectIntrinsicPass := GetLLVMProc('LLVMAddLowerExpectIntrinsicPass');
      @LLVMAddTypeBasedAliasAnalysisPass := GetLLVMProc('LLVMAddTypeBasedAliasAnalysisPass');
      @LLVMAddBasicAliasAnalysisPass := GetLLVMProc('LLVMAddBasicAliasAnalysisPass');
      LLVMTraceLog('');
{$ENDIF}
{$IFDEF LLVM_API_VECTORIZE}
      LLVMTraceLog(';Vectorize.h');
      @LLVMAddBBVectorizePass := GetLLVMProc('LLVMAddBBVectorizePass');
      LLVMTraceLog('');
{$ENDIF}
    end else
      raise Exception.CreateFmt('Cannot load "%s" library!', [LLVMLibrary]);
  except
    on E:Exception do
    begin
      if (hLibrary <> 0) then
      begin
        FreeLibrary(hLibrary);
        hLibrary := 0;
      end;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure UnloadLLVM;
begin
  if (hLibrary <> 0) then
  begin
    FreeLibrary(hLibrary);
    hLibrary := 0;
  end;
end;
{$ENDIF}

end.
