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
  writeln('LLVM-Pascal Version 0.1.1 - alpha');
  writeln('(c)2010 by'^M^J,
          'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos and Paulo Guilherme Freire'^M^J,
          'New BSD license'^M^J,
          'http://llvm-pascal.googlecode.com'^M^J);
  with TParser.Create(10) do
    try
      if FindFirst(ParamStr(1), faAnyFile, F) = 0 then
        repeat
          Compile(ExtractFilePath(ParamStr(1)) + F.Name);
        until FindNext(F) <> 0;
      FindClose(F);
    finally
      Free;
      readln;
    end;
end.
