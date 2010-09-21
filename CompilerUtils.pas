unit CompilerUtils;

interface

uses
  Parser;

function ReadSwitch(Switches : array of AnsiString) : AnsiString; overload;
function ReadSwitch(Switches : array of AnsiString; Default : integer) : integer; overload;
procedure CompilePath(Compiler : TParser; Path : AnsiString);
procedure CompileTree(Compiler : TParser; Tree : AnsiString);

implementation

uses
  SysUtils;

function ReadSwitch(Switches : array of AnsiString) : AnsiString;
var
  I, J : integer;
begin
  for I := 0 to high(Switches) do
    for J := 2 to ParamCount do
      if pos('-' + UpperCase(Switches[I]), UpperCase(ParamStr(J))) = 1 then begin
        Result := copy(ParamStr(J), length(Switches[I]) + 2, 100);
        exit;
      end;
  Result := '';
end;

function ReadSwitch(Switches : array of AnsiString; Default : integer) : integer;
var
  I, J : integer;
begin
  for I := 0 to high(Switches) do
    for J := 2 to ParamCount do
      if pos('-' + UpperCase(Switches[I]), UpperCase(ParamStr(J))) = 1 then begin
        Result := StrToIntDef(copy(ParamStr(J), length(Switches[I]) + 2, 100), Default);
        exit;
      end;
  Result := Default;
end;

procedure CompilePath(Compiler : TParser; Path : AnsiString);
var
  F : TSearchrec;
begin
  try
    if FindFirst(Path, faAnyFile, F) = 0 then
      repeat
        Compiler.Compile(ExtractFilePath(Path) + F.Name);
      until FindNext(F) <> 0;
  finally
    FindClose(F)
  end;
end;

procedure CompileTree(Compiler : TParser; Tree : AnsiString);
var
  Path, Ext : AnsiString;
  F : TSearchrec;
begin
  if pos('*', Tree) <> 0 then begin
    Path := ExtractFilePath(Tree);
    Ext  := ExtractFileName(Tree);
    if Compiler.SilentMode >= 2 then writeln(Path);
  end;
  CompilePath(Compiler, Tree);
  if pos('*', Tree) <> 0 then begin
    try
      if FindFirst(Path + '*', faDirectory, F) = 0 then begin
        while pos('.', F.Name) <> 0 do
          if FindNext(F) <> 0 then exit;
        repeat
          if pos('.', F.Name) = 0 then CompileTree(Compiler, Path + F.Name + PathDelim + Ext);
        until FindNext(F) <> 0;
      end;
    finally
      FindClose(F)
    end;
  end;
end;

end.

