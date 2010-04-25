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
  Parser;

begin
  writeln('LLVM-Pascal Version 0.1.1 - alpha');
  writeln('(c)2010 by'^M^J,
          'Wanderlan Santos dos Anjos, Barbara A.B. dos Anjos and Paulo Guilherme Freire'^M^J,
          'New BSD license'^M^J,
          'http://llvm-pascal.googlecode.com/'^M^J);
  try
    with TParser.Create(ParamStr(1), 10) do Compile;
  finally
    readln;
  end;
end.
