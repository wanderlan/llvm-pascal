program LLVM_Pascal;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Author: Barbara A.B. dos Anjos, barbara.ab.anjos@gmail.com
Author: Paulo Guilherme Freire, freire.brasilia@gmail.com
Date: apr-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
Based on Dragon Book
}
{$APPTYPE CONSOLE}

uses
  SysUtils, Parser;

var
  F : TSearchrec;
begin
  writeln('LLVM-Pascal Version 2010.7 - scanner/parser');
  writeln('(c)2010 by'^M^J,
          'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos and Paulo Guilherme Freire'^M^J,
          'New BSD license'^M^J,
          'http://llvm-pascal.googlecode.com');
  with TParser.Create(30) do
    try
      if FindFirst(ParamStr(1), faAnyFile, F) = 0 then
        repeat
          Compile(ExtractFilePath(ParamStr(1)) + F.Name);
        until FindNext(F) <> 0;
    finally
      FindClose(F);
      Free;
      readln;
    end;
end.
