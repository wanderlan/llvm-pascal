program LLVM_Pascal;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Author: Barbara A.B. dos Anjos, barbara.ab.anjos@gmail.com
Author: Paulo Guilherme Freire, freire.brasilia@gmail.com
Date: apr-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
Based on Dragon Book
Tests:
"C:\Arquivos de programas\Borland\BDS\4.0\source\*.pas" -fi "C:\Arquivos de programas\Borland\BDS\4.0\source\dunit\contrib\dunitwizard\source\common\" -v0
}
{$APPTYPE CONSOLE}

uses
  SysUtils, Parser;

var
  Compiler : TParser;

procedure CompilePath(Path : string);
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

procedure CompileTree(Tree : string);
var
  Path, Ext : string;
  F : TSearchrec;
begin
  if pos('*', Tree) <> 0 then begin
    Path := ExtractFilePath(Tree);
    Ext  := ExtractFileName(Tree);
    if not FindCmdLineSwitch('v0') then writeln(Path);
  end;
  CompilePath(Tree);
  if pos('*', Tree) <> 0 then begin
    try
      if FindFirst(Path + '*', faDirectory, F) = 0 then begin
        while pos('.', F.Name) <> 0 do
          if FindNext(F) <> 0 then exit;
        repeat
          if pos('.', F.Name) = 0 then CompileTree(Path + F.Name + PathDelim + Ext);
        until FindNext(F) <> 0;
      end;
    finally
      FindClose(F)
    end;
  end;
end;

var
  Include : string;
begin
  writeln('LLVM-Pascal Version 2010.9.10 pre-Alpha scanner/parser');
  writeln('(c)2010 by'^J,
          'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos and Paulo Guilherme Freire'^J,
          'New BSD license'^J,
          'http://llvm-pascal.googlecode.com'^J);
  if (ParamCount = 0) or FindCmdLineSwitch('h') or FindCmdLineSwitch('?') then
    writeln('Usage: LLVM_Pascal <path or source-name> [-Fi <include-paths separated by ;>] [-v0]')
  else begin
    Include := '';
    if FindCmdLineSwitch('I') or FindCmdLineSwitch('Fi') then Include := Paramstr(3);
    Compiler := TParser.Create(3, Include, FindCmdLineSwitch('v0'));
    try
      CompileTree(ParamStr(1));
    finally
      Compiler.Free;
      readln;
    end;
  end;
end.
