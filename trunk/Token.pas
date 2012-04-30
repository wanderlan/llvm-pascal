unit Token;

interface

type
	 TTokenKind = (tkUndefined, tkIdentifier, tkStringConstant, tkCharConstant, tkIntegerConstant, tkRealConstant,
                tkConstantExpression, tkLabelIdentifier, tkTypeIdentifier, tkClassIdentifier, tkReservedWord, tkSpecialSymbol,
                tkParameter);
	 PToken = ^TToken;
	 TToken = class
	   Lexeme       : AnsiString;
	   Kind         : TTokenKind;
    Type_        : PToken;
	   RealValue    : Extended;
	   IntegerValue : Int64;
	   Address			   : pointer;
	   NextScope    : PToken;
	   Scope				    : word;
	 public
	   destructor Destroy; override;
	 end;

implementation

destructor TToken.Destroy; begin
  if NextScope <> nil then NextScope.Free;
  inherited;
end;

end.

