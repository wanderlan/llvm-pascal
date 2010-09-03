unit Test10;

interface

implementation

procedure PrTest10A(a: string = '');
begin

end;

procedure PrTest10B;
begin
  PrTest10A('', ); // Erro no compilador Delphi. LLVM-Pascal pega este erro.
end;

end.
