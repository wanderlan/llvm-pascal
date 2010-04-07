program sample2;

var b: boolean;
var c: char;
var i, j: Integer;

Procedure myproc ();
var mp : boolean;
Begin
  b := false;
  mp := not b;
  {
  printint(i);
  printchar(c);
  }
  printbool(mp);
  println()
End;

function myfunc (a : integer, b : integer) : integer;
var mf1, mf2 : boolean;
var mf3 : boolean;
Begin
    mf1 := true;
    myfunc := a + b
End;

Begin
    c := 'z';
    i := 13;
    j := 0;
    b := not false or (13 <> j);

    {
    while j <= 10 do
    begin
        printint(i);
        printchar(c);
        printbool(b);
        println()
    end;

    if b then
        printchar('v')
    else
        printchar('f');

    for i := 2 * 3 to 10 + 1 do
        printint(i);
    }

    myproc();
    j := myfunc(false, i);
    printint(j);

    i := 70 + 80 * 5 + 3;
    i := 1 * 2 + 3 * 4
End.
