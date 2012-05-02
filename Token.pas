unit Token;

interface

type
	 TTokenKind = (tkUndefined, tkIdentifier, tkStringConstant, tkCharConstant, tkIntegerConstant, tkRealConstant,
                tkConstantExpression, tkLabelIdentifier, tkTypeIdentifier, tkClassIdentifier, tkReservedWord, tkSpecialSymbol,
                tkParameter, tkProgram, tkUnit, tkLibrary, tkPackage);
	 TToken = class
	   Lexeme       : string;
    Type_        : TToken;
	   NextScope    : TToken;
	   Scope				    : Word;
	   Kind         : TTokenKind;
	   RealValue    : Extended;
	   IntegerValue : Int64;
    StringValue  : string;
	 public
	   destructor Destroy; override;
	 end;

implementation

destructor TToken.Destroy; begin
  if NextScope <> nil then NextScope.Free;
  inherited;
end;

end.

