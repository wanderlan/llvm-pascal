unit Grammar;

interface

const
  // Non-terminal types
  Syntatic = #128; Semantic = #129; Generator = #130;

  // Productions id
  Start        = Syntatic + #000; ParIdentList = Syntatic + #001; IdentList    = Syntatic + #002; UsesClause   = Syntatic + #003; ExportsList  = Syntatic + #004;
  DeclSection  = Syntatic + #005; VarDecl      = Syntatic + #006; VarList      = Syntatic + #007; VarInit      = Syntatic + #008; Type_        = Syntatic + #009;
  EnumList     = Syntatic + #010; CompoundStmt = Syntatic + #011; Statement    = Syntatic + #012; StmtList     = Syntatic + #013; Expression   = Syntatic + #014;
  ToOrDownto   = Syntatic + #015; WithList     = Syntatic + #016; IntSection   = Syntatic + #017; ImplSection  = Syntatic + #018; InitSection  = Syntatic + #019;
  TypeDecl     = Syntatic + #020; StringLength = Syntatic + #021; ArrayDim     = Syntatic + #022; ClassDecl    = Syntatic + #023; QualId       = Syntatic + #024;
  LabelAssign  = Syntatic + #025; LabelList    = Syntatic + #026; ClassHerit   = Syntatic + #027; FieldDecl    = Syntatic + #028; MethodDecl   = Syntatic + #029;
  FormalParams = Syntatic + #030; FormalList   = Syntatic + #031; FormalParam  = Syntatic + #032; ParamInit    = Syntatic + #033; ParamSpec    = Syntatic + #034;
  ConstDecl    = Syntatic + #035; ConstType    = Syntatic + #036; StaticDecl   = Syntatic + #037; OrdinalType  = Syntatic + #038; ArrayOfType  = Syntatic + #039;
  TypeId       = Syntatic + #040; ParamType    = Syntatic + #041; PropInterf   = Syntatic + #042; PropIndex    = Syntatic + #043; PropRead     = Syntatic + #044;
  PropWrite    = Syntatic + #045; PropStored   = Syntatic + #046; PropDefault  = Syntatic + #047; PropImplem   = Syntatic + #048; RelOp        = Syntatic + #049;
  MetId        = Syntatic + #050; AssignStmt   = Syntatic + #051; ElseBranch   = Syntatic + #052; ExprList     = Syntatic + #053; CaseList     = Syntatic + #054;
  EndCaseList  = Syntatic + #055; SetList      = Syntatic + #056; InterDecl    = Syntatic + #057; LabelId      = Syntatic + #058; SubRange     = Syntatic + #059;
  FileOf       = Syntatic + #060; ForStmt      = Syntatic + #061; PropParams   = Syntatic + #062; IdentDir     = Syntatic + #063; NameDir      = Syntatic + #064;
  GUID         = Syntatic + #065; ExceptFin    = Syntatic + #066; ExceptHand   = Syntatic + #067; IdentType    = Syntatic + #068; ExceptList   = Syntatic + #069;
  InterfMet    = Syntatic + #070; InterDir     = Syntatic + #071; ProcedType   = Syntatic + #072; FinSection   = Syntatic + #073; RaiseStmt    = Syntatic + #074;
  RaiseAt      = Syntatic + #075; PackedDecl   = Syntatic + #076; ObjHerit     = Syntatic + #077; ObjDecl      = Syntatic + #078; ForwardClass = Syntatic + #079;
  RsrcDecl     = Syntatic + #080; OfObject     = Syntatic + #081; Directives   = Syntatic + #082; ExternalDir  = Syntatic + #083; MetCall      = Syntatic + #084;
  DefProp      = Syntatic + #085; WarnDir      = Syntatic + #086; StrictDecl   = Syntatic + #087; Delegation   = Syntatic + #088; ClassMet     = Syntatic + #089;
  InternalDecl = Syntatic + #090; RecordConst  = Syntatic + #091; CteFieldList = Syntatic + #092; StringExpr   = Syntatic + #093; RecordCase   = Syntatic + #094;
  CallConvType = Syntatic + #095; WarnDir2     = Syntatic + #096; RecFieldList = Syntatic + #097; RecCaseList  = Syntatic + #098; RecEndCase   = Syntatic + #099;
  FieldList    = Syntatic + #100; Operators    = Syntatic + #101; CteField     = Syntatic + #102; DispId       = Syntatic + #103; AbsoluteAddr = Syntatic + #104;
  IdentOpc     = Syntatic + #105; UsesList     = Syntatic + #106; UnitIn       = Syntatic + #107; EnumInit     = Syntatic + #108; ArithExpr    = Syntatic + #109;
  ArithOp      = Syntatic + #110; ClassDir     = Syntatic + #111; Generics     = Syntatic + #112; ReferTo      = Syntatic + #113; HelperFor    = Syntatic + #114;
  GenConstr    = Syntatic + #115; GenTypConstr = Syntatic + #116; Delayed      = Syntatic + #117; CallConv     = Syntatic + #118; ParamsBody   = Syntatic + #119;

  // Semantic operations
  PushScope    = Semantic + #000; PopScope     = Semantic + #001; AddModule    = Semantic + #002; AddSymbol    = Semantic + #003;
  SetType      = Semantic + #004;

  // Terminals
  Ident = #246; StringConst = #247; CharConst = #248; IntConst = #249; RealConst = #250;
  // Grammar commands
  InsertSemi = #251; Skip = #252; Require = #253; Mark = #254; Pop = #255;

  SIMPLE_TYPE =
    'Type' + '{' + Ident + '}' + Generics + QualId + Generics + SubRange + '{INTEGER}{BOOLEAN}{BYTE}{WORD}{CARDINAL}{LONGINT}' +
    '{INT64}{UINT64}{CHAR}{WIDECHAR}{WIDESTRING}{LONGWORD}{SHORTINT}{SMALLINT}' +
    '{PCHAR}{POINTER}{REAL}{SINGLE}{DOUBLE}{EXTENDED}{CURRENCY}{COMP}{BYTEBOOL}{WORDBOOL}{LONGBOOL}';
  PROCEDURAL_TYPE =
    '{PROCEDURE}' + FormalParams + OfObject + CallConvType +
    '{FUNCTION}'  + FormalParams + ':' + Ident + QualId + OfObject + CallConvType;
  METHODS_BODY =
    '{PROCEDURE}'   + Ident + MetId + PushScope + ParamsBody + CallConvType + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + PopScope + DeclSection +
    '{FUNCTION}'    + Ident + MetId + PushScope + ParamsBody + IdentType + CallConvType + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + PopScope + DeclSection +
    '{CONSTRUCTOR}' + Ident + MetId + PushScope + ParamsBody + ';' + Directives + CallConv + WarnDir + InternalDecl + Require + CompoundStmt + ';' + PopScope + DeclSection +
    '{DESTRUCTOR}'  + Ident + MetId + PushScope + ParamsBody + ';' + Directives + CallConv + WarnDir + InternalDecl + Require + CompoundStmt + ';' + PopScope + DeclSection +
    '{OPERATOR}'    + Require + Operators + PushScope + Require + ParamsBody + IdentOpc + ':' + Ident + CallConvType + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + PopScope + DeclSection;

  Productions : array[#0..#119] of AnsiString = (
// Start
  '{PROGRAM}' + PushScope + Ident + AddModule + ParIdentList + ';' + UsesClause + DeclSection + Require + CompoundStmt + '.' + PopScope +
  '{UNIT}'    + PushScope + Ident + AddModule + QualId + WarnDir2 + ';' + Require + IntSection + Require + ImplSection + Require + InitSection + '.' + PopScope +
  '{LIBRARY}' + PushScope + Ident + AddModule + QualId + WarnDir2 + ';' + UsesClause + DeclSection + InterDecl + Require + InitSection + '.' + PopScope +
  '{PACKAGE}' + PushScope + Ident + AddModule + QualId + WarnDir2 + ';' + 'REQUIRES' + Ident + QualId + IdentList + ';' + Mark + 'CONTAINS' + Ident + QualId + IdentList + 'END.' + PopScope,
// ParIdentList
  '{(}' + Ident + Generics + QualId + Generics + IdentList + ')',
// IdentList
  '{,}' + Ident + Generics + QualId + Generics + IdentList,
// UsesClause
  '{USES}' + Ident + QualId + UnitIn + UsesList + ';',
// ExportsList
  '{,}' + Ident + QualId + FormalParams + PropIndex + NameDir + Mark + ExportsList,
// DeclSection
  'Declaration Section' +
  '{VAR}'         + Require + VarDecl + DeclSection +
  '{CONST}'       + Require + ConstDecl + DeclSection +
  '{TYPE}'        + Require + TypeDecl + DeclSection +
  METHODS_BODY    +
  '{CLASS}'       + Require + ClassMet +
  '{THREADVAR}'   + Require + VarDecl + DeclSection +
  '{LABEL}'       + Require + LabelId + LabelList + DeclSection +
  '{RESOURCESTRING}' + Require + RsrcDecl + DeclSection +
  '{[}' + Ident + QualId + IdentList + ']' + DeclSection,
// VarDecl
  '{' + Ident + '}' + AddSymbol + VarList + ':' + Require + Type_ + SetType + WarnDir2 + VarInit + ';' + ExternalDir + Mark + VarDecl,
// VarList
  '{,}' + Ident + AddSymbol + VarList,
// VarInit
  '{=}' + Require + Expression +
  '{ABSOLUTE}' + AbsoluteAddr,
// Type_
  SIMPLE_TYPE +
  '{STRING}' + StringLength +
  '{ARRAY}'  + ArrayDim + 'OF' + Require + Type_ +
  '{'+ IntConst + '}' + Require + SubRange +
  '{'+ CharConst + '}' + Require + SubRange +
  '{(}' + Ident + EnumInit + EnumList + ')' +
  '{+}' + ArithExpr + Require + SubRange +
  '{-}' + ArithExpr + Require + SubRange +
  '{^}' + Ident +
  '{RECORD}' + HelperFor + PushScope + FieldDecl + MethodDecl + ClassDecl + RecordCase + 'END' + Mark + PopScope +
  '{CLASS}' + ForwardClass + ClassDir + ClassHerit + HelperFor + ForwardClass + PushScope + FieldDecl + MethodDecl + ClassDecl + 'END' + PopScope +
  '{OBJECT}' + ObjHerit + PushScope + FieldDecl + MethodDecl + ObjDecl + 'END' + PopScope +
  '{SET}' + 'OF' + Require + OrdinalType +
  PROCEDURAL_TYPE +
  '{PACKED}' + PackedDecl +
  '{FILE}' + FileOf +
  '{TEXT}' +
  '{INTERFACE}' + ForwardClass + ParIdentList + GUID + InterfMet + 'END' +
  '{DISPINTERFACE}' + ForwardClass + ParIdentList + GUID + InterfMet + 'END' +
  '{TYPE}' + Ident + QualId,
// EnumList
  '{,}' + Ident + EnumInit + EnumList,
// CompoundStmt
  '{BEGIN}' + Statement + StmtList + 'END',
//  '{ASM}' + Skip + 'END',
// Statement
  'Statement' +
  '{' + Ident + '}' + LabelAssign + AssignStmt + Mark +
  '{BEGIN}' + Statement + StmtList + 'END' +
  '{IF}' + Require + Expression + 'THEN' + Statement + ElseBranch +
  '{REPEAT}' + Statement + StmtList + 'UNTIL' + Require + Expression +
  '{WHILE}' + Require + Expression + 'DO' + Statement +
  '{FOR}' + Ident + QualId + Require + ForStmt + 'DO' + Statement +
  '{WITH}' + Expression + WithList + 'DO' + Statement +
  '{CASE}' + Require + Expression + 'OF' + Require + Expression + SetList + ':' + Statement + CaseList + Mark +
  '{TRY}' + Statement + StmtList + Require + ExceptFin +
  '{INHERITED}' + MetCall + AssignStmt +
  '{RAISE}' + RaiseStmt +
  '{' + IntConst + '}' + ':' + Statement +
  '{@}' + Ident + QualId + AssignStmt +
  '{(}' + Expression + ')' + QualId + AssignStmt +
  '{GOTO}' + Require + LabelId +
  '{ASM}' + Skip + 'END',
// StmtList
  '{;}' + Statement + StmtList,
// Expression
  'Expression' +
  '{' + Ident + '}' + QualId + RelOp +
  '{' + IntConst + '}' + RelOp +
  '{' + StringConst + '}' + RelOp +
  '{' + CharConst + '}' + RelOp +
  '{' + RealConst + '}' + RelOp +
  '{+}' + Expression +
  '{-}' + Expression +
  '{NOT}' + Expression +
  '{(}' + Expression + RecordConst + ExprList + Mark + ')' + QualId + RelOp +
  '{NIL}' +
  '{@}' + Expression +
  '{[}' + Expression + SetList + ']' + RelOp +
  '{INHERITED}' + Expression +
  '{PROCEDURE}' + PushScope + ParamsBody + InternalDecl + CompoundStmt + PopScope + // Anonymous methods
  '{FUNCTION}'  + PushScope + ParamsBody + ':' + Ident + QualId + InternalDecl + CompoundStmt + PopScope,
// ToOrDownto
  '{TO}{DOWNTO}',
// WithList
  '{,}' + Expression + WithList,
// IntSection
  '{INTERFACE}' + UsesClause + InterDecl,
// ImplSection
  '{IMPLEMENTATION}'+ UsesClause + DeclSection,
// InitSection
  '{BEGIN}' + Statement + StmtList + 'END' +
  '{INITIALIZATION}' + Statement + StmtList + FinSection +
  '{FINALIZATION}' + Statement + StmtList + 'END' +
  '{END}',
// TypeDecl
  '{' + Ident + '}' + Generics + '=' + ReferTo + Require + Type_ + WarnDir2 + ';' + Mark + TypeDecl +
  '{[}' + Ident + QualId + IdentList + ']' + TypeDecl,
// StringLength
  '{[}' + Require + IntConst + ']',
// ArrayDim
  '{[}' + Require + Expression + SetList + ']',
// ClassDecl
  '{PRIVATE}'   + FieldDecl + MethodDecl + ClassDecl +
  '{PROTECTED}' + FieldDecl + MethodDecl + ClassDecl +
  '{PUBLIC}'    + FieldDecl + MethodDecl + ClassDecl +
  '{PUBLISHED}' + FieldDecl + MethodDecl + ClassDecl +
  '{STRICT}'    + StrictDecl + ClassDecl +
  '{CLASS}'     + StaticDecl + FieldDecl + MethodDecl + ClassDecl +
  '{AUTOMATED}' + FieldDecl + MethodDecl + ClassDecl,
// QualId
  '{.}' + Ident + QualId +
  '{(}' + Expression + ExprList + ')' + QualId +
  '{[}' + Require + Expression + ExprList + ']' + QualId +
  '{^}' + QualId,
// LabelAssign
  '{.}' + Ident + QualId +
  '{(}' + Expression + ExprList + ')' + QualId +
  '{[}' + Require + Expression + ExprList + ']' + QualId +
  '{^}' + QualId +
  '{:}' + Statement + Pop +
  '{<}' + Ident + VarList + '>' + QualId,
// LabelList
  '{,}' + Require + LabelId + LabelList,
// ClassHerit
  '{(}'  + Ident + Generics + QualId + Generics + IdentList + ')' +
  '{OF}' + Ident + Pop,
// FieldDecl
  '{' + Ident + '}' + AddSymbol + VarList + ':' + Require + Type_ + WarnDir2 + FieldList +
  '{VAR}'   + FieldDecl +
  '{CONST}' + Require + ConstDecl + FieldDecl +
  '{TYPE}'  + Require + TypeDecl + FieldDecl +
  '{[}' + Ident + QualId + IdentList + ']' + FieldDecl,
// MethodDecl
  '{PROCEDURE}'   + Ident + Generics + Delegation + FormalParams + ';' + Directives + CallConv + WarnDir + Mark + MethodDecl +
  '{FUNCTION}'    + Ident + Generics + Delegation + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir + Mark + MethodDecl +
  '{CONSTRUCTOR}' + Ident + Generics + FormalParams + ';' + Directives + CallConv + WarnDir + MethodDecl +
  '{DESTRUCTOR}'  + Ident + Generics + FormalParams + ';' + Directives + CallConv + WarnDir + MethodDecl +
  '{PROPERTY}'    + Ident + Generics + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropStored + PropDefault + PropImplem + ';' + DefProp + WarnDir + MethodDecl +
  '{VAR}'   + Require + MethodDecl +
  '{CONST}' + Require + ConstDecl + MethodDecl +
  '{TYPE}'  + Require + TypeDecl + MethodDecl +
  '{[}' + Ident + QualId + IdentList + ']' + MethodDecl,
// FormalParams
  '{(}' + PushScope + FormalParam + FormalList + ')' + PopScope,
// FormalList
  '{;}' + FormalParam + FormalList,
// FormalParam
  '{' + Ident + '}' + AddSymbol + VarList + Require + ParamSpec + ParamInit +
  '{VAR}' + Ident + AddSymbol + VarList + ParamSpec +
  '{CONST}' + Ident + AddSymbol + VarList + ParamSpec + ParamInit +
  '{OUT}' + Ident + AddSymbol + VarList + ParamSpec,
// ParamInit
  '{=}' + Expression,
// ParamSpec
  '{:}' + Require + ParamType,
// ConstDecl
  '{' + Ident + '}' + ConstType + '=' + Require + Expression + WarnDir2 + ';' + ConstDecl,
// ConstType
  '{:}' + Require + Type_,
// StaticDecl
  '{VAR}' + FieldDecl +
  '{PROCEDURE}' + Ident + Generics + FormalParams + ';' + Directives + CallConv + WarnDir +
  '{FUNCTION}'  + Ident + Generics + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir +
  '{PROPERTY}'  + Ident + Generics + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropStored + PropDefault + PropImplem + ';' + DefProp +
  '{OPERATOR}'  + Ident + Generics + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir +
  '{THREADVAR}' + FieldDecl,
// OrdinalType
  '{' + Ident + '}' + QualId + SubRange +
  '{' + IntConst + '}' + Require + SubRange +
  '{' + CharConst + '}' + Require + SubRange +
  '{(}' + Ident + EnumList + ')',
// ArrayOfType
  SIMPLE_TYPE +
  '{CONST}',
// TypeId
  SIMPLE_TYPE,
// ParamType
  SIMPLE_TYPE +
  '{STRING}{FILE}{TEXT}' +
  '{ARRAY}' + 'OF' + Require + ArrayOfType,
// PropInterf
  '{:}' + Require + TypeId,
// PropIndex
  '{INDEX}' + Expression,
// PropRead
  '{READ}' + Ident + QualId + Mark,
// PropWrite
  '{WRITE}' + Ident + QualId + Mark,
// PropStored
  '{STORED}' + Ident,
// PropDefault
  '{DEFAULT}' + Expression +
  '{NODEFAULT}',
// PropImplem
  '{IMPLEMENTS}' + Ident + QualId + IdentList,
// RelOp
  '{>}'  + Require + Expression + '{<}'  + Require + Expression + '{>=}' + Require + Expression + '{<=}' + Require + Expression +
  '{<>}' + Require + Expression + '{=}'  + Require + Expression + '{IN}' + Require + Expression + '{IS}' + Require + Expression +
  '{AS}' + Require + Expression + '{+}'  + Require + Expression + '{-}'  + Require + Expression + '{AND}'+ Require + Expression +
  '{OR}' + Require + Expression + '{XOR}'+ Require + Expression + '{SHR}'+ Require + Expression + '{SHL}'+ Require + Expression +
  '{*}'  + Require + Expression + '{/}'  + Require + Expression + '{DIV}'+ Require + Expression + '{MOD}'+ Require + Expression +
  '{**}' + Require + Expression,
// MetId
  '{.}' + Ident + MetId +
  '{<}' + Ident + AddSymbol + VarList + '>' + MetId,
// AssignStmt
  '{:=}' + Require + Expression +
  '{+=}' + Require + Expression + '{-=}' + Require + Expression + '{*=}' + Require + Expression + '{/=}' + Require + Expression,
// ElseBranch
  '{ELSE}' + Statement,
// ExprList
  '{,}' + Require + Expression + ExprList +
  '{:}' + Expression + ExprList +
  '{^}' + ExprList,
// CaseList
  '{;}' + EndCaseList + Require + Expression + SetList + ':' + Statement + CaseList +
  '{ELSE}' + Statement + StmtList + 'END' +
  '{END}',
// EndCaseList
  '{ELSE}' + Statement + StmtList + 'END' + Pop +
  '{END}' + Pop,
// SetList
  '{,}' + Require + Expression + SetList +
  '{..}' + Require + Expression + SetList,
// InterDecl
  'Declaration Section for Interface' +
  '{VAR}' + Require + VarDecl + InterDecl +
  '{CONST}' + Require + ConstDecl + InterDecl +
  '{TYPE}' + Require + TypeDecl + InterDecl +
  '{PROCEDURE}' + Ident + FormalParams + CallConvType + ';' + Mark + Directives + CallConv + WarnDir + ExternalDir + Mark + InterDecl +
  '{FUNCTION}'  + Ident + FormalParams + ':' + Ident + QualId + CallConvType + ';' + Mark + Directives + CallConv + WarnDir + ExternalDir + Mark + InterDecl +
  '{THREADVAR}' + Require + VarDecl + InterDecl +
  '{LABEL}' + Require + LabelId + LabelList + ';' + InterDecl +
  '{EXPORTS}' + Ident + QualId + FormalParams + PropIndex + NameDir + Mark + ExportsList + ';' + InterDecl +
  '{OPERATOR}' + Require + Operators + Require + FormalParams + IdentOpc + ':' + Ident + CallConvType + ';' + Mark + Directives + CallConv + WarnDir + ExternalDir + Mark + InterDecl +
  '{RESOURCESTRING}' + Require + RsrcDecl + InterDecl,
// LabelId
  '{' + Ident + '}' +
  '{' + IntConst + '}',
// SubRange
  '{..}' + Require + ArithExpr,
// FileOf
  '{OF}' + Require + TypeId,
// ForStmt
  '{:=}' + Require + Expression + Require + ToOrDownto + Require + Expression +
  '{IN}' + Require + Expression,
// PropParams
  '{[}' + PushScope + Require + FormalParam + FormalList + ']' + PopScope,
// IdentDir
  '{' + Ident + '}' + QualId +
  '{' + StringConst + '}' +
  '{' + CharConst + '}',
// NameDir
  '{NAME}' + Require + IdentDir + StringExpr + Delayed + Pop,
// GUID
  '{[}' + IdentDir + ']',
// ExceptFin
  '{EXCEPT}' + ExceptHand + Statement + StmtList + 'END' + Mark +
  '{FINALLY}' + Statement + StmtList + 'END',
// ExceptHand
  '{ON}' + Ident + QualId + IdentType + 'DO' + Statement + ExceptList + EndCaseList + Pop,
// IdentType
  '{:}' + Ident + Generics + QualId + Generics,
// ExceptList
  '{;}' + ExceptHand,
// InterfMet
  '{PROCEDURE}' + Ident + FormalParams + DispId + ';' + InterDir + WarnDir + InterfMet +
  '{FUNCTION}'  + Ident + FormalParams + ':' + Ident + Generics + QualId + Generics + DispId + ';' + InterDir + WarnDir + InterfMet +
  '{PROPERTY}'  + Ident + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropDefault + DispId + ';' + InterDir + WarnDir + Mark + DefProp + InterfMet +
  '{[}' + Ident + QualId + IdentList + ']' + InterfMet,
// InterDir
  '{DISPID}' + Expression + ';' + InterDir +
  '{OVERLOAD};' + InterDir + '{CDECL};' + InterDir + '{SAFECALL};' + InterDir + '{STDCALL};' + InterDir + '{REGISTER};' + InterDir + '{PASCAL};' + InterDir,
// ProcedType
  PROCEDURAL_TYPE,
// FinSection
  '{FINALIZATION}' + Statement + StmtList + 'END' +
  '{END}',
// RaiseStmt
  '{' + Ident + '}' + QualId + RaiseAt,
// RaiseAt
  '{AT}' + Require + Expression,
// PackedDecl
  '{ARRAY}' + ArrayDim + 'OF' + Require + Type_ +
  '{RECORD}' + HelperFor + PushScope + FieldDecl + MethodDecl + ClassDecl + RecordCase + 'END' + Mark + PopScope +
  '{CLASS}' + ForwardClass + ClassDir + ClassHerit + HelperFor + ForwardClass + PushScope + FieldDecl + MethodDecl + ClassDecl + 'END' + Mark + PopScope +
  '{OBJECT}' + ObjHerit + PushScope + FieldDecl + MethodDecl + ObjDecl + 'END' + PopScope +
  '{SET}' + 'OF' + Require + OrdinalType +
  '{FILE}' + FileOf,
// ObjHerit
  '{(}' + Ident + ')',
// ObjDecl
  '{PRIVATE}' + FieldDecl + MethodDecl + ObjDecl +
  '{PROTECTED}' + FieldDecl + MethodDecl + ObjDecl +
  '{PUBLIC}' + FieldDecl + MethodDecl + ObjDecl,
// ForwardClass
  '{;}' + Pop +
  '{OF}' + Ident + ';' + Pop,
// RsrcDecl
  '{' + Ident + '}' + '=' + IdentDir + StringExpr + WarnDir2 + ';' + RsrcDecl,
// OfObject
  '{OF}' + 'OBJECT',
// Directives
  '{OVERRIDE};' + Directives + '{OVERLOAD};' + Directives + '{VIRTUAL};' + Directives + '{REINTRODUCE};' + Directives +
  '{MESSAGE}' + Require + IdentDir + ';' + '{ABSTRACT};{FINAL};{STATIC};{DYNAMIC};' + Directives,
// ExternalDir
  '{EXTERNAL}' + NameDir + IdentDir + NameDir + Mark + PropIndex + ';' + Directives + CallConv + Pop +
  '{ASSEMBLER};' + Directives + CallConv,
// MetCall
  '{' + Ident + '}' + QualId,
// DefProp
  '{DEFAULT};',
// WarnDir
  '{PLATFORM}' + IdentDir + ';' + WarnDir + Directives + CallConv + '{DEPRECATED}' + IdentDir + ';' + WarnDir + Directives + CallConv +
  '{LIBRARY}' + IdentDir + ';' + WarnDir + Directives + CallConv + '{EXPERIMENTAL}' + IdentDir + ';' + WarnDir + Directives + CallConv +
  '{UNIMPLEMENTED}' + IdentDir + ';' + WarnDir + Directives + CallConv,
// StrictDecl
  '{PRIVATE}' + FieldDecl + MethodDecl + ClassDecl +
  '{PROTECTED}' + FieldDecl + MethodDecl + ClassDecl,
// Delegation
  '{.}' + Ident + '=' + Ident + ';' + Pop,
// ClassMet
  METHODS_BODY,
// InternalDecl
  'Internal Declaration Section' +
  '{VAR}' + Require + VarDecl + InternalDecl +
  '{CONST}' + Require + ConstDecl + InternalDecl +
  '{TYPE}' + Require + TypeDecl + InternalDecl +
  '{LABEL}' + Require + LabelId + LabelList + ';' + InternalDecl +
  '{PROCEDURE}' + Ident + PushScope + ParamsBody + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + PopScope + InternalDecl +
  '{FUNCTION}'  + Ident + PushScope + ParamsBody + ':' + Ident + QualId + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + PopScope + InternalDecl +
  '{RESOURCESTRING}' + Require + RsrcDecl + InterDecl,
// RecordConst
  '{:}' + Expression + CteFieldList + Pop,
// CteFieldList
  '{;}' + CteField +
  '{^}' + CteFieldList,
// StringExpr
  '{+}' + IdentDir + StringExpr,
// RecordCase
  '{CASE}' + Ident + PropInterf + 'OF' + Require + Expression + SetList + ':' + Require + RecFieldList + RecCaseList,
// CallConvType
  '{;}' + CallConv + InsertSemi +
  '{STDCALL}{CDECL}{SAFECALL}{REGISTER}{PASCAL}',
// WarnDir2
  '{PLATFORM}' + IdentDir + WarnDir2 + '{DEPRECATED}' + IdentDir + WarnDir2 + '{LIBRARY}' + IdentDir + WarnDir2 +
  '{EXPERIMENTAL}' + IdentDir + WarnDir2 + '{UNIMPLEMENTED}' + IdentDir + WarnDir2,
// RecFieldList
  '{(}' + FieldDecl + RecordCase + ')' + Mark,
// RecCaseList
  '{;}' + RecEndCase + Require + Expression + SetList + ':' + RecFieldList + RecCaseList,
//RecEndCase
  '{)}' + Pop +
  '{END}' + Pop,
// FieldList
  '{;}' + FieldDecl,
// Operators
  'Operator{:=}{>}{<}{>=}{<=}{<>}{=}{IN}{IS}{AS}{+}{-}{AND}{OR}{XOR}{SHR}{SHL}{*}{/}{DIV}{MOD}{+=}{-=}{*=}{/=}{**}',
// CteField
  '{' + Ident + '}' + ':' + Expression + CteFieldList,
// DispId
  '{READONLY}' + DispId + '{WRITEONLY}' + DispId + '{DISPID}' + Expression,
// AbsoluteAddr
  '{' + Ident + '}' + QualId +
  '{' + IntConst + '}',
// IdentOpc
  '{' + Ident + '}',
// UsesList
  '{,}' + Ident + QualId + UnitIn + UsesList,
// UnitIn
  '{IN}' + IdentDir + StringExpr,
// EnumInit
  '{=}' + Expression + '{:=}' + Expression,
// ArithExpr
  'Arithmetic Expression' +
  '{' + Ident + '}' + QualId + ArithOp +
  '{' + IntConst + '}' + ArithOp +
  '{+}' + ArithExpr + '{-}' + ArithExpr +
  '{(}' + ArithExpr + ')' + QualId + RelOp,
// ArithOp
  '{+}'  + Require + ArithExpr + '{-}'  + Require + ArithExpr + '{AND}'+ Require + ArithExpr + '{OR}' + Require + ArithExpr +
  '{XOR}'+ Require + ArithExpr + '{SHR}'+ Require + ArithExpr + '{SHL}'+ Require + ArithExpr + '{*}'  + Require + ArithExpr +
  '{/}'  + Require + ArithExpr + '{DIV}'+ Require + ArithExpr + '{MOD}'+ Require + ArithExpr + '{**}'  + Require + ArithExpr,
// ClassDir
  '{ABSTRACT}{SEALED}',
// Generics
  '{<}' + Ident + AddSymbol + Generics + GenConstr + VarList + '>',
// ReferTo
  '{REFERENCE}' + 'TO' + Require + ProcedType + ';' + Pop,
// HelperFor
  '{HELPER}FOR' + Ident,
// GenConstr
  '{:}' + Require + GenTypConstr,
// GenTypeConstr
  '{' + Ident + '}{CLASS}{RECORD}{CONSTRUCTOR}',
// Delayed
  '{DELAYED}',
// CallConv
  '{STDCALL};' + Directives + '{CDECL};'+ CallConv + Directives + '{SAFECALL};' + Directives + '{INLINE};' + Directives +
  '{REGISTER};{PASCAL};{FORWARD};' + Pop + '{VARARGS};' +
  '{FAR};{NEAR};{EXPORT};' + CallConv + '{LOCAL};' + // Deprecateds
  '{ALIAS}:' + StringConst + ';' + '{NOSTACKFRAME};{MWPASCAL};{COMPILERPROC};', // FPC only
// ParamsBody
  '{(}' + FormalParam + FormalList + ')'
  );

var
  OrigExternalDir, OrigDirectives : AnsiString;

implementation

begin
  OrigExternalDir := Productions[ExternalDir[2]];
  OrigDirectives  := Productions[Directives[2]];
end.
