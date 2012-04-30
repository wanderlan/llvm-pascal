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
  GeneratorOperation : array[#0..#1] of pointer = (@TGenerator.Generate, nil);

procedure TGenerator.Generate(Symbol : char); begin
  Call(GeneratorOperation, Symbol);
end;

end.

