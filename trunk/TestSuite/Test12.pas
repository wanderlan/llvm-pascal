unit Test12;

interface

implementation

procedure PrTest12;
var
  lArray: array[0..1]  of Integer;
begin
  lArray[$] := 0; // Bug no compilador Delphi. O LLVM-Pascal irá acusar erro aqui!
end;

end.
