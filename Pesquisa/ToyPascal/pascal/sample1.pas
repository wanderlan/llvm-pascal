program simple1;

var a, b, c : integer;
var n : boolean;

FunCtion func2 () : Boolean;
Begin
    func2 := true;
End;

FunCtion soma (a : integer, b : integer) : integer;
Begin
    soma := a + b;
End;

Procedure proc2 ();
var z : char;
Begin
    z := 'Y';
End;

Begin
    n := false;

    if n then
        begin
            a := soma(17, 3) * 70;
        end

    if n = true then
        begin
            c := (30 * a + 9 / 3) * n;
        end
    else
        begin
            d := func2();
        end
End.
