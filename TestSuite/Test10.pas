unit Test10;

interface

implementation

procedure PrTest10A(a: string = '');
begin

end;

procedure PrTest10B;
begin
  PrTest10A('', ); //seems like a delphi parser bug
end;

end.
