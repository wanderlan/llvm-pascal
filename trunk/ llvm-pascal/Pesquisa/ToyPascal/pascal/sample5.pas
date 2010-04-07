program sample5;

var i : integer;
var c : char;

procedure my_proc();
var b : boolean;
begin
    b := true;
    printchar('t')
end;

function blah(c : char) : char;
begin
    blah := 'z';
    for i := 0 to 100 do
    begin
        printchar(c)
    end
end;

function getint() : integer;
begin
    biz := 22;
    getint := 33
end;

function incr(i : integer) : integer;
begin
    incr := i + 1
end;

function three(a : integer, b : integer, c : integer) : integer;
begin
    three := a + b + getint()
end;

Begin
    i := getint();
    printint(i);
    printint(getint());

    i := incr(getint());

    i := three(3, getint(), i);
    i := three(i, getint(), 55);

    printint(i);
    println();

    blah('c');
    blah(c);
    blah(blah());
    blah(c);

    printchar(c);
    printchar('y');
    printchar(blah(' '));
    printint(three(3, i, getint()));

    println()
End.


