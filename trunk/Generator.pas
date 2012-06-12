unit Generator;

interface

uses
  Analyser, Token;

type
  TGenerator = class helper for TAnalyser
  protected
//    procedure Generate(Symbol : char); override;
  public
    procedure MakeModule(Token : TToken);
  end;

implementation

uses
  Scanner, llvmAPI;

(*const
  GeneratorAction : array[#0..#1] of pointer = (@TGenerator.Generate, nil);

procedure TGenerator.Generate(Symbol : char); begin
  Call(GeneratorAction, Symbol);
end;
*)
procedure TGenerator.MakeModule(Token : TToken);
var
  Module: LLVMModuleRef;
  ArrayTy_0, PointerTy_1, FuncTy_2, PointerTy_3, FuncTy_5, PointerTy_4: LLVMTypeRef;
  FyncTy_2_Args: array [0..0] of LLVMTypeRef;
  FyncTy_5_Args: array [0..0] of LLVMTypeRef;
  func_main, func_puts, gvar_array_str, const_array_6, int32_puts,
  const_ptr_7, const_int32_9, const_int64_8: LLVMValueRef;
  const_ptr_7_indices: array [0..1] of LLVMValueRef;
  label_10: LLVMBasicBlockRef;
  Builder: LLVMBuilderRef;
  Context: LLVMContextRef;
begin
  Module := LLVMModuleCreateWithName(PChar((*Path*)Token.Lexeme + '.bc'));
  LLVMSetDataLayout(Module,
    'e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128');
  LLVMSetTarget(Module, TargetCPU + '-unknown-' + TargetOS);
  Context := LLVMGetModuleContext(Module);
  // Type Definitions
  ArrayTy_0 := LLVMArrayType(LLVMInt8TypeInContext(Context), 12);
  PointerTy_1 := LLVMPointerType(ArrayTy_0, 0);
  FuncTy_2 := LLVMFunctionType(LLVMInt32TypeInContext(Context), @FyncTy_2_Args[0], 0, LLVMFalse);
  PointerTy_3 := LLVMPointerType(LLVMInt8TypeInContext(Context), 0);
  FyncTy_5_Args[0] := PointerTy_3;
  FuncTy_5 := LLVMFunctionType(LLVMInt32TypeInContext(Context), @FyncTy_5_Args[0], 1, LLVMFalse);
  PointerTy_4 := LLVMPointerType(FuncTy_5, 0);

  func_main := LLVMGetNamedFunction(Module, 'main');
  if func_main = nil then begin
    func_main := LLVMAddFunction(Module, 'main', FuncTy_2);
    LLVMSetLinkage(func_main, LLVMExternalLinkage);
    LLVMSetFunctionCallConv(func_main, Ord(LLVMCCallConv)); { BAD IDEA }
  end;
  LLVMAddFunctionAttr(func_main, LLVMNoUnwindAttribute);
  LLVMAddFunctionAttr(func_main, LLVMUWTable);

  func_puts := LLVMGetNamedFunction(Module, 'puts');
  if func_puts = nil then begin
    func_puts := LLVMAddFunction(Module, 'puts', FuncTy_5);
    LLVMSetLinkage(func_puts, LLVMExternalLinkage);
    LLVMSetFunctionCallConv(func_puts, Ord(LLVMCCallConv));
  end;
  LLVMAddFunctionAttr(func_puts, LLVMNoUnwindAttribute);

  // Global Variable Declarations
  gvar_array_str := LLVMAddGlobal(Module, ArrayTy_0, 'str');
  LLVMSetLinkage(gvar_array_str, LLVMInternalLinkage);
  LLVMSetGlobalConstant(gvar_array_str, LLVMTrue);
  // Constant Definitions
  const_array_6 := LLVMConstStringInContext(Context, 'Hello World'#0, 12, LLVMTrue); {?}
  const_int64_8 := LLVMConstIntOfString(LLVMInt64TypeInContext(Context), '0', 10); //LLVMConstIntOfArbitraryPrecision(LLVMInt64TypeInContext(Context), 10, nil);
  const_ptr_7_indices[0] := const_int64_8;
  const_ptr_7_indices[1] := const_int64_8;
  const_ptr_7 := LLVMConstGEP(gvar_array_str, @const_ptr_7_indices[0], 2);
  const_int32_9 := LLVMConstIntOfString(LLVMInt32TypeInContext(Context), '0', 10); //LLVMConstIntOfArbitraryPrecision(LLVMInt32TypeInContext(Context), 10, nil);

  // Global Variable Definitions
  LLVMSetInitializer(gvar_array_str, const_array_6);

  // Function Definitions
  label_10 := LLVMAppendBasicBlockInContext(Context, func_main, '');
  Builder := LLVMCreateBuilder();
  LLVMPositionBuilderAtEnd(Builder, label_10);
  int32_puts := LLVMBuildCall(Builder, func_puts, const_ptr_7, 1, 'puts');
  LLVMSetInstructionCallConv(int32_puts, Ord(LLVMCCallConv));
  LLVMSetTailCall(int32_puts, LLVMTrue);
  LLVMBuildRet(Builder, const_int32_9);
end;

end.

