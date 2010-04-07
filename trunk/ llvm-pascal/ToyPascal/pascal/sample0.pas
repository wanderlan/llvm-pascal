program sample0;

Var x : Integer;
var b: Boolean;
var c: char;

FunCtion myfunc (i : integer, b : boolean) : integer;
Begin
    {x := i + myfunc;}
    myfunc := i * 539
    {x := 300 + (3 + 2) * 7;
    i := 3;
    x := i * 5;
    i := x;
    x := 9 + 9;
    x := i;
    printint(i);
    i := 13 + 500;
    x := i - 1;
    i := i + 77;
    x := i + 1;
    x := 69;
    i := 17;}
    { := i + myfunc{FIXME: load i32* @myfunc, align 4}
    {myfunc := x}{FIXME}
End;

function getchar() : char;
begin
    getchar := 'Z'
end;

function getbool() : boolean;
begin
    getbool := true
end;

Procedure myproc (i : integer);
{var ck, n : integer;
var m : boolean;}
var itsatrap : integer;
var myhumps : integer;
var myfunc : integer;
Begin
    i := 4;
    myfunc := 3;
    myhumps := 250;

    itsatrap := x;
    itsatrap := myhumps;
    itsatrap := myfunc;
    myfunc := myfunc + 111;
    itsatrap := itsatrap + 1;
    itsatrap := myfunc(5, true);
    printbool(false);
    printchar('W');
    printchar('\n');
    printint(itsatrap);
    println();
    itsatrap := myfunc(3, true);

    {ck := 5;
    ck := i * 2 + 3;
    ck := 11 + 22;
    {ck := 33 - ck;
    {ck := 44 * myfunc(55);}
    {m := false and true;
    x := ck;
    printint(ck);
    println();
    printint(3 * 5);
    println();
    printint(3);
    m := true or m;
    x := 5 + 5;
    println();
    printint(i)}
    println()
End;

{FunCtion otherfunc (fint : Integer, fchar: Char) : Integer;
var myvar : Boolean;
var c : Char;
Begin
    myvar := 34;
    c := '{';
End;
}

Begin
    x := 2 + 3;
    x := 2;
    {x := 2 + 3 * 5 + 9;}
    printint(x + 3 * 5 + 2);
    println();
    myproc(7);
    x := 3 + myfunc(5, true);
    printint(x);
    x := 5 + myfunc(2, false);
    printint(x);
    {k := 30;
    {x := myfunc(65);
    {printbool(false);
    printchar('\n');
    printchar('W');
    println();
    printint(137);
    println();
    printint(x);}

    printint(myfunc(10, true));

    c := getchar();
    printchar(c);
    printchar(getchar());

    b := getbool();
    printbool(b);
    printbool(getbool());
    printbool(true);

    println()
End.

