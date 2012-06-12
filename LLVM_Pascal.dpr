program LLVM_Pascal;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Author: Barbara A. B. dos Anjos, barbara.ab.anjos@gmail.com
Advisor: Paulo Guilherme Freire, freire.brasilia@gmail.com
Advisor: Joel Guilherme da Silva Filho, joel-iesb@joelguilherme.com
Date: apr-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
Based on Dragon Book
Tests:
"C:\Arquivos de programas\Borland\BDS\4.0\source\*.pas" -fi"C:\Arquivos de programas\Borland\BDS\4.0\source\dunit\contrib\dunitwizard\source\common\" -v0
help:
virtual site:http://lazarus-ccr.sourceforge.net/docs
}
{$APPTYPE CONSOLE}

uses
  SysUtils, CompilerUtils, Scanner, Analyser;

var
  Compiler : TAnalyser;

begin
  if not FindCmdLineSwitch('v0') then begin
    writeln('LLVM-Pascal Version ', Version, ^J,
            '(c)2012 by'^J,
            'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos, Aleksey A. Naumov and Joel Guilherme'^J,
            'New BSD license'^J,
            'http://llvm-pascal.googlecode.com'^J);
  end;
  if (ParamCount = 0) or FindCmdLineSwitch('h') or FindCmdLineSwitch('?') then
    writeln('Usage: LLVM_Pascal <path or source-name>'^J,
            '[-Fi<include-paths separated by ;>]'^J,
            '[-v<compiler verbosity: 0, 1 or 2, default is 2>]'^J,
            '[-vm<list of message codes, and/or message prefixes, which should not be shown>]'^J,
            '[-Se<max number of errors, default is 10>]'^J,
            '[-M<language mode, Delphi or OBJFPC, default is Delphi>]')
  else begin
    Compiler := TAnalyser.Create(ReadSwitch(['Se'], 10), ReadSwitch(['I', 'Fi']), ReadSwitch(['v'], 2), ReadSwitch(['M']), ReadSwitch(['vm']));
    try
      CompileTree(Compiler, ParamStr(1));
    finally
      Compiler.Free;
      readln;
    end;
  end;
end.
