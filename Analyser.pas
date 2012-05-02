unit Analyser;

interface

uses
  Parser;

type
  TAnalyser = class(TParser)
  protected
    procedure Analyse(Symbol : char); override;
    procedure PushScope;
    procedure PopScope;
    procedure AddModule;
    procedure AddSymbol;
    procedure SetType;
  end;

implementation

uses
  Token;

const
  SemanticAction : array[#0..#4] of pointer = (@TAnalyser.PushScope, @TAnalyser.PopScope, @TAnalyser.AddModule, @TAnalyser.AddSymbol,
                                               @TAnalyser.SetType);

procedure TAnalyser.Analyse(Symbol : char); begin
  Call(SemanticAction, Symbol);
end;

procedure TAnalyser.PushScope; begin
  SymbolTable.PushScope;
end;

procedure TAnalyser.PopScope; begin
  SymbolTable.PopScope;
end;

procedure TAnalyser.AddModule; begin
  Token.Kind := StringToTokenKind(LastLexeme);
  AddSymbol;
end;

procedure TAnalyser.AddSymbol; begin
  SymbolTable.Add(Token);
  Token := TToken.Create;
end;

procedure TAnalyser.SetType;
var
  T : TToken;
begin
  T := SymbolTable.Last;
  while T <> nil do begin
    T.StringValue := LastLexeme;
    T := SymbolTable.Previous;
  end;
end;

end.

