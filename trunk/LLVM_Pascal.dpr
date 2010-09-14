program LLVM_Pascal;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Author: Barbara A.B. dos Anjos, barbara.ab.anjos@gmail.com
Author: Paulo Guilherme Freire, freire.brasilia@gmail.com
Date: apr-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
Based on Dragon Book
Tests:
"C:\Arquivos de programas\Borland\BDS\4.0\source\*.pas" -fi"C:\Arquivos de programas\Borland\BDS\4.0\source\dunit\contrib\dunitwizard\source\common\" -v0
}
{$APPTYPE CONSOLE}

uses
  SysUtils, Parser, CompilerUtils;

var
  Compiler : TParser;

begin
  if not FindCmdLineSwitch('v0') then begin
    writeln('LLVM-Pascal Version 2010.9.13 pre-Alpha scanner/parser'^J,
            '(c)2010 by'^J,
            'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos and Paulo Guilherme Freire'^J,
            'New BSD license'^J,
            'http://llvm-pascal.googlecode.com'^J);
  end;
  if (ParamCount = 0) or FindCmdLineSwitch('h') or FindCmdLineSwitch('?') then
    writeln('Usage: LLVM_Pascal <path or source-name> [-Fi<include-paths separated by ;>] [-v0] [-Se<max number of errors, default is 10>')
  else begin
    Compiler := TParser.Create(ReadSwitch(['Se'], 10), ReadSwitch(['I', 'Fi']), FindCmdLineSwitch('v0'));
    try
      CompileTree(Compiler, ParamStr(1));
    finally
      Compiler.Free;
      readln;
    end;
  end;
end.
