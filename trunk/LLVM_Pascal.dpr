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
  writeln('LLVM-Pascal Version 2010.9 pre-Alpha scanner/parser');
  writeln('(c)2010 by'^J,
          'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos and Paulo Guilherme Freire'^J,
          'New BSD license'^J,
          'http://llvm-pascal.googlecode.com'^J);
  with TParser.Create(30) do
    try
      if FindFirst(ParamStr(1), faAnyFile, F) = 0 then
        repeat
          Compile(ExtractFilePath(ParamStr(1)) + F.Name);
        until FindNext(F) <> 0;
    finally
      Free;
      FindClose(F);
      readln;
    end;
end.
