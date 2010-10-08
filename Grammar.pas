unit Grammar;

interface

const
  // Non-terminal types
  Syntatic = #128; Semantic = #129; Generator = #130;

  // Productions id
  Start        = Syntatic + #128; ParIdentList = Syntatic + #129; IdentList    = Syntatic + #130; UsesClause   = Syntatic + #131; ExportsList  = Syntatic + #132;
  DeclSection  = Syntatic + #133; VarDecl      = Syntatic + #134; VarList      = Syntatic + #135; VarInit      = Syntatic + #136; Type_        = Syntatic + #137;
  EnumList     = Syntatic + #138; CompoundStmt = Syntatic + #139; Statement    = Syntatic + #140; StmtList     = Syntatic + #141; Expression   = Syntatic + #142;
  ToOrDownto   = Syntatic + #143; WithList     = Syntatic + #144; IntSection   = Syntatic + #145; ImplSection  = Syntatic + #146; InitSection  = Syntatic + #147;
  TypeDecl     = Syntatic + #148; StringLength = Syntatic + #149; ArrayDim     = Syntatic + #150; ClassDecl    = Syntatic + #151; QualId       = Syntatic + #152;
  LabelAssign  = Syntatic + #153; LabelList    = Syntatic + #154; ClassHerit   = Syntatic + #155; FieldDecl    = Syntatic + #156; MethodDecl   = Syntatic + #157;
  FormalParams = Syntatic + #158; FormalList   = Syntatic + #159; FormalParam  = Syntatic + #160; ParamInit    = Syntatic + #161; ParamSpec    = Syntatic + #162;
  ConstDecl    = Syntatic + #163; ConstType    = Syntatic + #164; StaticDecl   = Syntatic + #165; OrdinalType  = Syntatic + #166; ArrayOfType  = Syntatic + #167;
  TypeId       = Syntatic + #168; ParamType    = Syntatic + #169; PropInterf   = Syntatic + #170; PropIndex    = Syntatic + #171; PropRead     = Syntatic + #172;
  PropWrite    = Syntatic + #173; PropStored   = Syntatic + #174; PropDefault  = Syntatic + #175; PropImplem   = Syntatic + #176; RelOp        = Syntatic + #177;
  MetId        = Syntatic + #178; AssignStmt   = Syntatic + #179; ElseBranch   = Syntatic + #180; ExprList     = Syntatic + #181; CaseList     = Syntatic + #182;
  EndCaseList  = Syntatic + #183; SetList      = Syntatic + #184; InterDecl    = Syntatic + #185; LabelId      = Syntatic + #186; SubRange     = Syntatic + #187;
  FileOf       = Syntatic + #188; ForStmt      = Syntatic + #189; PropParams   = Syntatic + #190; IdentDir     = Syntatic + #191; NameDir      = Syntatic + #192;
  GUID         = Syntatic + #193; ExceptFin    = Syntatic + #194; ExceptHand   = Syntatic + #195; IdentType    = Syntatic + #196; ExceptList   = Syntatic + #197;
  InterfMet    = Syntatic + #198; InterDir     = Syntatic + #199; ProcedType   = Syntatic + #200; FinSection   = Syntatic + #201; RaiseStmt    = Syntatic + #202;
  RaiseAt      = Syntatic + #203; PackedDecl   = Syntatic + #204; ObjHerit     = Syntatic + #205; ObjDecl      = Syntatic + #206; ForwardClass = Syntatic + #207;
  RsrcDecl     = Syntatic + #208; OfObject     = Syntatic + #209; Directives   = Syntatic + #210; ExternalDir  = Syntatic + #211; MetCall      = Syntatic + #212;
  DefProp      = Syntatic + #213; WarnDir      = Syntatic + #214; StrictDecl   = Syntatic + #215; Delegation   = Syntatic + #216; ClassMet     = Syntatic + #217;
  InternalDecl = Syntatic + #218; RecordConst  = Syntatic + #219; CteFieldList = Syntatic + #220; StringExpr   = Syntatic + #221; RecordCase   = Syntatic + #222;
  CallConvType = Syntatic + #223; WarnDir2     = Syntatic + #224; RecFieldList = Syntatic + #225; RecCaseList  = Syntatic + #226; RecEndCase   = Syntatic + #227;
  FieldList    = Syntatic + #228; Operators    = Syntatic + #229; CteField     = Syntatic + #230; DispId       = Syntatic + #231; AbsoluteAddr = Syntatic + #232;
  IdentOpc     = Syntatic + #233; UsesList     = Syntatic + #234; UnitIn       = Syntatic + #235; EnumInit     = Syntatic + #236; ArithExpr    = Syntatic + #237;
  ArithOp      = Syntatic + #238; ClassDir     = Syntatic + #239; Generics     = Syntatic + #240; ReferTo      = Syntatic + #241; HelperFor    = Syntatic + #242;
  GenConstr    = Syntatic + #243; GenTypConstr = Syntatic + #244; CallConv     = Syntatic + #245;

  // Other non terminals
  Ident = #246; StringConst = #247; CharConst = #248; IntConst = #249; RealConst = #250;
  // Grammar commands
  InsertSemi = #251; Skip = #252; Require = #253; Mark = #254; Pop = #255;

  SimpleType = 'Type' + '{' + Ident + '}' + Generics + QualId + Generics + SubRange + '{INTEGER}{BOOLEAN}{BYTE}{WORD}{CARDINAL}{LONGINT}' +
    '{INT64}{UINT64}{CHAR}{WIDECHAR}{WIDESTRING}{LONGWORD}{SHORTINT}{SMALLINT}' +
    '{PCHAR}{POINTER}{REAL}{SINGLE}{DOUBLE}{EXTENDED}{CURRENCY}{COMP}{BYTEBOOL}{WORDBOOL}{LONGBOOL}';
  ProceduralType = '{PROCEDURE}' + FormalParams + OfObject + CallConvType +
                   '{FUNCTION}'  + FormalParams + ':' + Ident + QualId + OfObject + CallConvType;

  Productions : array[#128..#245] of AnsiString = (
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
  '{RESOURCESTRING}' + Require + RsrcDecl + DeclSection +
  '{[}' + Ident + QualId + IdentList + ']' + DeclSection,
// VarDecl
  '{' + Ident + '}' + VarList + ':' + Require + Type_ + WarnDir2 + VarInit + ';' + ExternalDir + Mark + VarDecl,
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
  '{RECORD}' + HelperFor + FieldDecl + MethodDecl + ClassDecl + RecordCase + 'END' + Mark +
  '{CLASS}' + ForwardClass + ClassDir + ClassHerit + HelperFor + ForwardClass + FieldDecl + MethodDecl + ClassDecl + 'END' +
  '{OBJECT}' + ObjHerit + FieldDecl + MethodDecl + ObjDecl + 'END' +
  '{SET}' + 'OF' + Require + OrdinalType +
  ProceduralType +
  '{PACKED}' + PackedDecl +
  '{FILE}' + FileOf +
  '{TEXT}' +
  '{INTERFACE}' + ForwardClass + ParIdentList + GUID + InterfMet + 'END' +
  '{DISPINTERFACE}' + ForwardClass + ParIdentList + GUID + InterfMet + 'END' +
  '{TYPE}' + Ident + QualId,
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
  '{INHERITED}' + Expression +
  '{PROCEDURE}' + FormalParams + ';' + InternalDecl + CompoundStmt +
  '{FUNCTION}'  + FormalParams + ':' + Ident + QualId + ';' + InternalDecl + CompoundStmt,
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
  '{' + Ident + '}' + VarList + ':' + Require + Type_ + WarnDir2 + FieldList +
  '{VAR}'   + Require + FieldDecl +
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
  '{PROCEDURE}' + Ident + Generics + FormalParams + ';' + Directives + CallConv + WarnDir +
  '{FUNCTION}'  + Ident + Generics + FormalParams + ':' + Ident + Generics + QualId + Generics + ';' + Directives + CallConv + WarnDir +
  '{PROPERTY}'  + Ident + Generics + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropStored + PropDefault + PropImplem + ';' + DefProp,
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
  '{*}'  + Require + Expression + '{/}'  + Require + Expression + '{DIV}'+ Require + Expression + '{MOD}'+ Require + Expression +
  '{**}' + Require + Expression,
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
  '{PROPERTY}'  + Ident + PropParams + PropInterf + PropIndex + PropRead + PropWrite + PropDefault + DispId + ';' + InterDir + WarnDir + Mark + DefProp + InterfMet +
  '{[}' + Ident + QualId + IdentList + ']' + InterfMet,
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
  '{RECORD}' + HelperFor + FieldDecl + MethodDecl + ClassDecl + RecordCase + 'END' + Mark +
  '{CLASS}' + ForwardClass + ClassDir + ClassHerit + HelperFor + ForwardClass + FieldDecl + MethodDecl + ClassDecl + 'END' + Mark +
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
  '{/}'  + Require + ArithExpr + '{DIV}'+ Require + ArithExpr + '{MOD}'+ Require + ArithExpr,
// ClassDir
  '{ABSTRACT}{SEALED}',
// Generics
  '{<}' + Ident + Generics + GenConstr + VarList + '>',
// ReferTo
  '{REFERENCE}' + 'TO' + Require + ProcedType + ';' + Pop,
// HelperFor
  '{HELPER}FOR' + Ident,
// GenConstr
  '{:}' + Require + GenTypConstr,
// GenTypeConstr
  '{' + Ident + '}{CLASS}{RECORD}{CONSTRUCTOR}',
// CallConv
  '{STDCALL};' + Directives + '{CDECL};'+ CallConv + Directives + '{SAFECALL};' + Directives + '{INLINE};' + Directives +
  '{REGISTER};{PASCAL};{FORWARD};' + Pop + '{VARARGS};' +
  '{FAR};{NEAR};{EXPORT};' + CallConv + '{LOCAL};' + // Deprecateds
  '{ALIAS}:' + StringConst + ';' + '{NOSTACKFRAME};{MWPASCAL};{COMPILERPROC};' // FPC only
  );

var
  OrigExternalDir, OrigDirectives : AnsiString;

implementation

begin
  OrigExternalDir := Productions[ExternalDir[1]];
  OrigDirectives  := Productions[Directives[1]];
end.
