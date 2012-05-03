unit Generator;

interface

uses
  Analyser;

type
  TGenerator = class(TAnalyser)
  protected
    procedure Generate(Symbol : char); override;
  end;

implementation

const
  GeneratorAction : array[#0..#1] of pointer = (@TGenerator.Generate, nil);

procedure TGenerator.Generate(Symbol : char); begin
  Call(GeneratorAction, Symbol);
end;

end.

