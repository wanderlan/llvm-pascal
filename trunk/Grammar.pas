unit Grammar;

interface

const
  // Productions id
  Start        = #128; ParIdentList = #129; IdentList    = #130; UsesClause   = #131; ExportsList  = #132;
  DeclSection  = #133; VarDecl      = #134; VarList      = #135; VarInit      = #136; Type_        = #137;
  EnumList     = #138; CompoundStmt = #139; Statement    = #140; StmtList     = #141; Expression   = #142;
  ToOrDownto   = #143; WithList     = #144; IntSection   = #145; ImplSection  = #146; InitSection  = #147;
  TypeDecl     = #148; StringLength = #149; ArrayDim     = #150; ClassDecl    = #151; QualId       = #152;
  LabelAssign  = #153; LabelList    = #154; ClassHerit   = #155; FieldDecl    = #156; MethodDecl   = #157;
  FormalParams = #158; FormalList   = #159; FormalParam  = #160; ParamInit    = #161; ParamSpec    = #162;
  ConstDecl    = #163; ConstType    = #164; StaticDecl   = #165; OrdinalType  = #166; ArrayOfType  = #167;
  TypeId       = #168; ParamType    = #169; PropInterf   = #170; PropIndex    = #171; PropRead     = #172;
  PropWrite    = #173; PropStored   = #174; PropDefault  = #175; PropImplem   = #176; RelOp        = #177;
  MetId        = #178; AssignStmt   = #179; ElseBranch   = #180; ExprList     = #181; CaseList     = #182;
  EndCaseList  = #183; SetList      = #184; InterDecl    = #185; LabelId      = #186; SubRange     = #187;
  FileOf       = #188; ForStmt      = #189; PropParams   = #190; IdentDir     = #191; NameDir      = #192;
  GUID         = #193; ExceptFin    = #194; ExceptHand   = #195; IdentType    = #196; ExceptList   = #197;
  InterfMet    = #198; InterDir     = #199; ProcedType   = #200; FinSection   = #201; RaiseStmt    = #202;
  RaiseAt      = #203; PackedDecl   = #204; ObjHerit     = #205; ObjDecl      = #206; ForwardClass = #207;
  RsrcDecl     = #208; OfObject     = #209; Directives   = #210; ExternalDir  = #211; MetCall      = #212;
  DefProp      = #213; WarnDir      = #214; StrictDecl   = #215; Delegation   = #216; ClassMet     = #217;
  InternalDecl = #218; RecordConst  = #219; CteFieldList = #220; StringExpr   = #221; RecordCase   = #222;
  CallConvType = #223; WarnDir2     = #224; RecFieldList = #225; RecCaseList  = #226; RecEndCase   = #227;
  FieldList    = #228; Operators    = #229; CteField     = #230; DispId       = #231; AbsoluteAddr = #232;
  IdentOpc     = #233; UsesList     = #234; UnitIn       = #235; EnumInit     = #236; ArithExpr    = #237;
  ArithOp      = #238; ClassDir     = #239; Generics     = #240; CallConv     = #241;

  // Other non terminals
  Ident = #246; StringConst = #247; CharConst = #248; IntConst = #249; RealConst = #250;
  // Grammar commands
  InsertSemi = #251; Skip = #252; Require = #253; Mark = #254; Pop = #255;

  SimpleType = 'Type' + '{' + Ident + '}' + Generics + QualId + Generics + SubRange + '{INTEGER}{BOOLEAN}{BYTE}{WORD}{CARDINAL}{LONGINT}' +
    '{INT64}{UINT64}{CHAR}{WIDECHAR}{WIDESTRING}{LONGWORD}{SHORTINT}{SMALLINT}' +
    '{PCHAR}{POINTER}{REAL}{SINGLE}{DOUBLE}{EXTENDED}{CURRENCY}{COMP}{BYTEBOOL}{WORDBOOL}{LONGBOOL}';
  ProceduralType = '{PROCEDURE}' + FormalParams + OfObject + CallConvType +
    '{FUNCTION}' + FormalParams + ':' + Ident + QualId + OfObject + CallConvType;
    
  Productions : array[Start..CallConv] of string = (
// Start
  '{PROGRAM}' + Ident + ParIdentList + ';' + UsesClause + DeclSection + Require + CompoundStmt  + '.' +
  '{UNIT}'    + Ident + QualId + WarnDir2 + ';' + Require + IntSection + Require + ImplSection + Require + InitSection + '.' +
  '{LIBRARY}' + Ident + QualId + WarnDir2 + ';' + UsesClause + DeclSection + InterDecl + Require + InitSection  + '.' +
  '{PACKAGE}' + Ident + QualId + WarnDir2 + ';' + 'REQUIRES' + Ident + QualId + IdentList + ';' + Mark + 'CONTAINS' + Ident + QualId + IdentList + 'END.',
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
  '{PROCEDURE}'   + Ident + MetId + FormalParams + CallConvType + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + DeclSection +
  '{FUNCTION}'    + Ident + MetId + FormalParams + IdentType + CallConvType + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + DeclSection +
  '{CONSTRUCTOR}' + Ident + MetId + FormalParams + ';' + Directives + CallConv + WarnDir + InternalDecl + Require + CompoundStmt + ';' + DeclSection +
  '{DESTRUCTOR}'  + Ident + MetId + FormalParams + ';' + Directives + CallConv + WarnDir + InternalDecl + Require + CompoundStmt + ';' + DeclSection +
  '{OPERATOR}'    + Require + Operators + Require + FormalParams + IdentOpc + ':' + Ident + CallConvType + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + DeclSection +
  '{CLASS}'       + ClassMet +
  '{THREADVAR}'   + Require + VarDecl + DeclSection +
  '{LABEL}'       + Require + LabelId + LabelList + DeclSection +
  '{RESOURCESTRING}' + Require + RsrcDecl + DeclSection,
// VarDecl
  '{' + Ident + '}' + VarList + ':' + Require + Type_ + WarnDir2 + VarInit + ';' + Mark + VarDecl,
// VarList
  '{,}' + Ident + VarList,
// VarInit
  '{=}' + Require + Expression +
  '{ABSOLUTE}' + AbsoluteAddr,
// Type_
  SimpleType +
  '{STRING}' + StringLength +
  '{ARRAY}'  + ArrayDim + 'OF' + Require + Type_ +
  '{'+ IntConst + '}' + Require + SubRange +
  '{'+ CharConst + '}' + Require + SubRange +
  '{(}' + Ident + EnumInit + EnumList + ')' +
  '{+}' + ArithExpr + Require + SubRange +
  '{-}' + ArithExpr + Require + SubRange +
  '{^}' + Ident +
  '{RECORD}' + FieldDecl + MethodDecl + ClassDecl + RecordCase + 'END' + Mark +
  '{CLASS}' + ForwardClass + ClassDir + ClassHerit + ForwardClass + FieldDecl + MethodDecl + ClassDecl + 'END' +
  '{OBJECT}' + ObjHerit + FieldDecl + MethodDecl + ObjDecl + 'END' +
  '{SET}' + 'OF' + Require + OrdinalType +
  ProceduralType +
  '{PACKED}' + PackedDecl +
  '{FILE}' + FileOf +
  '{TEXT}' +
  '{INTERFACE}' + ForwardClass + ParIdentList + GUID + InterfMet + 'END' +
  '{DISPINTERFACE}' + ForwardClass + ParIdentList + GUID + InterfMet + 'END' +
  '{TYPE}' + Ident + QualId +
  '{REFERENCE}' + 'TO' + ProcedType,
// EnumList
  '{,}' + Ident + EnumInit + EnumList,
// CompoundStmt
  '{BEGIN}' + Statement + StmtList + 'END' +
  '{ASM}' + Skip + 'END',
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
  '{INHERITED}' + Expression,
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
  '{' + Ident + '}' + Generics + '=' + Require + Type_ + WarnDir2 + ';' + Mark + TypeDecl +
  '{[}' + Ident + QualId + ']' + TypeDecl,
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
  '{' + Ident + '}' + VarList + ':' + Require + Type_ + WarnDir2 + FieldList +
  '{VAR}'   + Require + FieldDecl +
  '{CONST}' + Require + ConstDecl + FieldDecl +
  '{TYPE}'  + Require + TypeDecl + FieldDecl +
  '{[}' + Ident + QualId + ']' + FieldDecl,
// MethodDecl
  '{PROCEDURE}'   + Ident + Generics + Delegation + FormalParams + ';' + Directives + CallConv + WarnDir + Mark + MethodDecl +
  '{FUNCTION}'    + Ident + Generics + Delegation + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir + Mark + MethodDecl +
  '{CONSTRUCTOR}' + Ident + Generics + FormalParams + ';' + Directives + CallConv + WarnDir + MethodDecl +
  '{DESTRUCTOR}'  + Ident + Generics + FormalParams + ';' + Directives + CallConv + WarnDir + MethodDecl +
  '{PROPERTY}'    + Ident + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropStored + PropDefault + PropImplem + ';' + DefProp + WarnDir + MethodDecl +
  '{[}' + Ident + QualId + ']' + MethodDecl,
// FormalParams
  '{(}' + FormalParam + FormalList + ')',
// FormalList
  '{;}' + FormalParam + FormalList,
// FormalParam
  '{' + Ident + '}' + VarList + Require + ParamSpec + ParamInit +
  '{VAR}' + Ident + VarList + ParamSpec +
  '{CONST}' + Ident + VarList + ParamSpec + ParamInit +
  '{OUT}' + Ident + VarList + ParamSpec,
// ParamInit
  '{=}' + Expression,
// ParamSpec
  '{:}' + Require + ParamType,
// ConstDecl
  '{' + Ident + '}' + ConstType + '=' + Require + Expression + WarnDir2 + ';' + ConstDecl,
// ConstType
  '{:}' + Require + Type_,
// StaticDecl
  '{VAR}' + Require + FieldDecl +
  '{PROCEDURE}' + Ident + FormalParams + ';' + Directives + CallConv + WarnDir +
  '{FUNCTION}'  + Ident + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir +
  '{PROPERTY}'  + Ident + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropStored + PropDefault + PropImplem + ';' + DefProp,
// OrdinalType
  '{' + Ident + '}' + QualId + SubRange +
  '{' + IntConst + '}' + Require + SubRange +
  '{' + CharConst + '}' + Require + SubRange +
  '{(}' + Ident + EnumList + ')',
// ArrayOfType
  SimpleType +
  '{CONST}',
// TypeId
  SimpleType,
// ParamType
  SimpleType +
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
  '{*}'  + Require + Expression + '{/}'  + Require + Expression + '{DIV}'+ Require + Expression + '{MOD}'+ Require + Expression,
// MetId
  '{.}' + Ident + MetId +
  '{<}' + Ident + VarList + '>' + MetId,
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
  '{[}' + Require + FormalParam + FormalList + ']',
// IdentDir
  '{' + Ident + '}' + QualId +
  '{' + StringConst + '}' +
  '{' + CharConst + '}',
// NameDir
  '{NAME}' + Require + IdentDir + StringExpr + Pop,
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
  '{PROPERTY}'  + Ident + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropDefault + DispId + ';' + InterDir + WarnDir + Mark + DefProp + InterfMet,
// InterDir
  '{DISPID}' + Expression + ';' + InterDir +
  '{OVERLOAD};' + InterDir + '{CDECL};' + InterDir + '{SAFECALL};' + InterDir + '{STDCALL};' + InterDir + '{REGISTER};' + InterDir + '{PASCAL};' + InterDir,
// ProcedType
  ProceduralType,
// FinSection
  '{FINALIZATION}' + Statement + StmtList + 'END' +
  '{END}',
// RaiseStmt
  '{' + Ident + '}' + QualId + RaiseAt,
// RaiseAt
  '{AT}' + Require + Expression,
// PackedDecl
  '{ARRAY}' + ArrayDim + 'OF' + Require + Type_ +
  '{RECORD}' + FieldDecl + MethodDecl + ClassDecl + RecordCase + 'END' + Mark +
  '{CLASS}' + ForwardClass + ClassDir + ClassHerit + ForwardClass + FieldDecl + MethodDecl + ClassDecl + 'END' + Mark +
  '{OBJECT}' + ObjHerit + FieldDecl + MethodDecl + ObjDecl + 'END' +
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
  '{OVERRIDE};{OVERLOAD};' + Directives + '{VIRTUAL};' + Directives + '{REINTRODUCE};' + Directives +
  '{MESSAGE}' + Require + IdentDir + ';' + '{ABSTRACT};{FINAL};{STATIC};{DYNAMIC};' + Directives + '{[}' + Skip + ']' + Mark + ';',
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
  '{PROCEDURE}' + Ident + MetId + FormalParams + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + DeclSection +
  '{FUNCTION}'  + Ident + MetId + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + DeclSection +
  '{CONSTRUCTOR}' + Ident + MetId + FormalParams + ';' + Directives + CallConv + WarnDir + InternalDecl + Require + CompoundStmt + ';' + DeclSection +
  '{DESTRUCTOR}'  + Ident + MetId + FormalParams + ';' + Directives + CallConv + WarnDir + InternalDecl + Require + CompoundStmt + ';' + DeclSection,
// InternalDecl
  'Internal Declaration Section' +
  '{VAR}' + Require + VarDecl + InternalDecl +
  '{CONST}' + Require + ConstDecl + InternalDecl +
  '{TYPE}' + Require + TypeDecl + InternalDecl +
  '{LABEL}' + Require + LabelId + LabelList + ';' + InternalDecl +
  '{PROCEDURE}' + Ident + FormalParams + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + InternalDecl +
  '{FUNCTION}'  + Ident + FormalParams + ':' + Ident + QualId + ';' + Directives + CallConv + WarnDir + ExternalDir + InternalDecl + CompoundStmt + ';' + Mark + InternalDecl +
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
  'Operator{:=}{>}{<}{>=}{<=}{<>}{=}{IN}{IS}{AS}{+}{-}{AND}{OR}{XOR}{SHR}{SHL}{*}{/}{DIV}{MOD}{+=}{-=}{*=}{/=}',
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
  '{/}'  + Require + ArithExpr + '{DIV}'+ Require + ArithExpr + '{MOD}'+ Require + ArithExpr,
// ClassDir
  '{ABSTRACT}{SEALED}',
// Generics
  '{<}' + Ident + VarList + '>',
// CallConv
  '{STDCALL};' + Directives + '{CDECL};'+ CallConv + Directives + '{SAFECALL};' + Directives + '{INLINE};' + Directives +
  '{REGISTER};{PASCAL};{FORWARD};' + Pop + '{VARARGS};' +
  '{FAR};{NEAR};{EXPORT};' + CallConv + '{LOCAL};' + // Deprecateds
  '{ALIAS}:' + StringConst + ';' + '{NOSTACKFRAME};{MWPASCAL};{COMPILERPROC};' // FPC only
  );
implementation
end.
