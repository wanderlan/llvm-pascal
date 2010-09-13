unit CompilerUtils;

interface

uses
  Parser;

function ReadSwitch(Switches : array of string) : string; overload;
function ReadSwitch(Switches : array of string; Default : integer) : integer; overload;
procedure CompilePath(Compiler : TParser; Path : string);
procedure CompileTree(Compiler : TParser; Tree : string);

implementation

uses
  SysUtils;

function ReadSwitch(Switches : array of string) : string;
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

function ReadSwitch(Switches : array of string; Default : integer) : integer;
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

procedure CompilePath(Compiler : TParser; Path : string);
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

procedure CompileTree(Compiler : TParser; Tree : string);
var
  Path, Ext : string;
  F : TSearchrec;
begin
  if pos('*', Tree) <> 0 then begin
    Path := ExtractFilePath(Tree);
    Ext  := ExtractFileName(Tree);
    if not FindCmdLineSwitch('v0') then writeln(Path);
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

