unit Test12;

interface

implementation

procedure PrTest12;
var
  lArray: array[0..1]  of Integer;
begin
  lArray[$] := 0; // bug compilador delphi?
end;

end.
