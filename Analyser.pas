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
  end;

implementation

const
  SemanticOperation : array[#0..#1] of pointer = (@TAnalyser.PushScope, @TAnalyser.PopScope);

procedure TAnalyser.Analyse(Symbol : char); begin
  Call(SemanticOperation, Symbol);
end;

procedure TAnalyser.PushScope; begin
  SymbolTable.PushScope;
end;

procedure TAnalyser.PopScope; begin
  SymbolTable.PopScope;
end;

end.

