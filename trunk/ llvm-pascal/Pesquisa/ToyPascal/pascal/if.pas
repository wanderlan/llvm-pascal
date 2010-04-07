program ifprog;

Var i, k: integer;
var bar : Boolean;

procedure test ();
var j : integer;
var foo : boolean;
begin
    i := 10;
    j := 3;

    printint(j);

    j := 77;

    printint(j);

    j := j * 77;

    printint(j);

    foo := false;{ and false;}

    if foo then
        printchar('t');

    foo := true;

    if foo then
        printchar('t');

    foo := false and true;{ and false;}

    if foo then
        printchar('t');


    foo := true and false;
    foo := true or foo;
    foo := j > 2 * 2;
    foo := 3 < 4;
    foo := 5 >= 6;
    foo := 7 <= 8;
    foo := j = i;
    foo := j <> i
end;

begin
    bar := true;
    i := 17;

    if ((1 = 1) or (2 = 3)) and (bar = false) then
    begin
        printchar('t');
        if bar then
            printchar ('B')
    end;

    if i > 3 * 6 then
    begin
        printchar('1');
        if false then
            printchar('1')
    end
    else
        printchar('2');

    test();

    if (i = k) then if false then
        printint(i);

    test();

    if bar then
        printchar('b');

    println()
end.
