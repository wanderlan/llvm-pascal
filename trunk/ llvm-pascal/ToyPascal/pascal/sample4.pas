program simple4;

var a : integer;

function test(i : integer) : integer;
var t : integer;
begin
    printint(i);
    println();
    t := i;
    printint(t);
    test := 7;
    println()
end;

Begin
    {a := (3 < 2) and (b = 4) or (c > 3)}
    a := 250;
    printint(a);
    println();

    a := test(13);

    println()
End.
