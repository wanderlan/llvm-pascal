unit Token;

interface

type
  TTokenKind = (tkUndefined, tkIdentifier, tkStringConstant, tkCharConstant, tkIntegerConstant, tkRealConstant,
                tkConstantExpression, tkLabelIdentifier, tkTypeIdentifier, tkClassIdentifier, tkReservedWord, tkSpecialSymbol,
                tkParameter, tkProgram, tkUnit, tkLibrary, tkPackage,
                tkInteger, tkBoolean, tkByte, tkWord, tkCardinal, tkLongInt, tkInt64, tkUInt64, tkChar,
                tkWideChar, tkWideString, tkLongWord, tkShortInt, tkSmallInt, tkPChar, tkPointer,
                tkReal, tkSingle, tkDouble, tkExtended, tkCurrency, tkComp, tkByteBool, tkWordBool, tkLongBool);

const
  Kinds : array[TTokenKind] of AnsiString = (
     'Undefined', 'Identifier', 'String Constant', 'Char Constant', 'Integer Constant',
     'Real Constant', 'Constant Expression', 'Label Identifier', 'Type Identifier', 'Class Identifier', 'Reserved Word',
     'Special Symbol', 'Parameter', 'Program', 'Unit', 'Library', 'Package',
     'Integer', 'Boolean', 'Byte', 'Word', 'Cardinal', 'LongInt', 'Int64', 'UInt64', 'Char',
     'WideChar', 'WideString', 'LongWord', 'ShortInt', 'SmallInt', 'PChar', 'Pointer',
     'Real', 'Single', 'Double', 'Extended', 'Currency', 'Comp', 'ByteBool', 'WordBool', 'LongBool');

type
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
