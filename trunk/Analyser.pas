unit Analyser;

interface

uses
  Parser, SymbolTable, Token;

type
  TAnalyser = class(TParser)
  public
    constructor Create(MaxErrors : integer = 10 ; Includes : AnsiString = ''; SilentMode : integer = 2 ;
                       LanguageMode : AnsiString = ''; NotShow : AnsiString = '');
  protected
    SymbolTable : TSymbolTable;
    Operand : TToken;
    procedure Analyse(Symbol : char); override;
    procedure PushScope;
    procedure PopScope;
    procedure AddModule;
    procedure AddSymbol;
    procedure SetType;
    procedure GetSymbol;
  end;

implementation

uses
  CompilerUtils, Generator;

const
  SemanticAction : array[#0..#5] of pointer = (
    @TAnalyser.PushScope, @TAnalyser.PopScope, @TAnalyser.AddModule, @TAnalyser.AddSymbol,
    @TAnalyser.SetType, @TAnalyser.GetSymbol);

constructor TAnalyser.Create(MaxErrors : integer; Includes : AnsiString; SilentMode : integer; LanguageMode : AnsiString;
                             NotShow : AnsiString);
begin
  inherited;
  SymbolTable := TSymbolTable.Create;
end;

procedure TAnalyser.Analyse(Symbol : char); begin
  Call(SemanticAction, Symbol);
end;

procedure TAnalyser.PushScope; begin
  SymbolTable.PushScope;
end;

procedure TAnalyser.PopScope; begin
  try
    SymbolTable.PopScope;
  except
    on E : EFatal do ShowMessage('Fatal', E.Message);
  end;
end;

procedure TAnalyser.AddModule; begin
  Token.Kind := StringToTokenKind(LastLexeme);
  MakeModule(Token);
  AddSymbol;
end;

procedure TAnalyser.AddSymbol; begin
  try
    SymbolTable.Add(Token);
    Token := TToken.Create;
  except
    on E : EFatal do ShowMessage('Fatal', E.Message);
    on E : EError do Error(E.Message);
  end;
end;

procedure TAnalyser.SetType;
var
  T : TToken;
  L : string;
begin
  L := Token.Lexeme;
  T := SymbolTable.Last;
  while (T <> nil) and (T.Kind = tkIdentifier) do begin
    T.Type_ := SymbolTable.Get(L);
    if T.Type_ = nil then T.Kind := StringToTokenKind(L, tkIdentifier);
    T := SymbolTable.Previous;
  end;
end;

procedure TAnalyser.GetSymbol; begin
  Operand := SymbolTable.Get(Token.Lexeme);
  if Operand = nil then Error('Undeclared Identifier "' + Token.Lexeme + '"');
end;

end.
