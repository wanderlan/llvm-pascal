unit Token;

interface

type
  TTokenKind = (tkUndefined, tkIdentifier, tkStringConstant, tkCharConstant, tkIntegerConstant, tkRealConstant,
                tkConstantExpression, tkLabelIdentifier, tkTypeIdentifier, tkClassIdentifier, tkReservedWord, tkSpecialSymbol,
                tkParameter, tkProgram, tkUnit, tkLibrary, tkPackage);
	TToken = class
    Lexeme       : string;
    Hash         : Cardinal;
    Type_        : TToken;
	  NextScope    : TToken;
	  Scope				 : Word;
	  Kind         : TTokenKind;
	  RealValue    : Extended;
	  IntegerValue : Int64;
    StringValue  : string;
	end;

implementation

end.
