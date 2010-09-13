unit FPCTunning;
{
Author: Aleksandr Sharahov (Fastcode)
License: http://www.mozilla.org/MPL/
}
{$R-,Q-}

interface

function Pos(const SubStr, S : string) : Integer;
function PosEx(const SubStr, S : string; Offset: Integer) : Integer;
function UpperCase(const S : string) : string;
function LowerCase(const S : string) : string;

implementation

function Pos(const SubStr, S : string): Integer; begin
  Result := PosEx(Substr, S, 1)
end;

function PosEx(const SubStr, S : string; Offset : Integer): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Loop0, Loop4,
  TestT, Test0, Test1, Test2, Test3, Test4,
  AfterTestT, AfterTest0,
  Ret, Exit;
begin;
  pSub:=pointer(SubStr);
  p:=pointer(S);
  if (p=nil) or (pSub=nil) or (Offset<1) then begin
    Result:=0;
    goto Exit;
  end;
  lenSub:=pinteger(pSub-4)^-1;
  len:=pinteger(p-4)^;
  if (len<lenSub+Offset) or (lenSub<0) then begin
    Result:=0;
    goto Exit;
  end;
  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset+3;
  ch:=pSub[0];
  lenSub:=-lenSub;
  if p<pStop then goto Loop4;
  p:=p-4;
  goto Loop0;
Loop4:
  if ch=p[-4] then goto Test4;
  if ch=p[-3] then goto Test3;
  if ch=p[-2] then goto Test2;
  if ch=p[-1] then goto Test1;
Loop0:
  if ch=p[0] then goto Test0;
AfterTest0:
  if ch=p[1] then goto TestT;
AfterTestT:
  p:=p+6;
  if p<pStop then goto Loop4;
  p:=p-4;
  if p<pStop then goto Loop0;
  Result:=0;
  goto Exit;
Test3: p:=p-2;
Test1: p:=p-2;
TestT: len:=lenSub;
  if lenSub<>0 then
    repeat
      if (psub[len]<>p[len+1]) or (psub[len+1]<>p[len+2]) then goto AfterTestT;
      len:=len+2;
    until len>=0;
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  goto Exit;
Test4: p:=p-2;
Test2: p:=p-2;
Test0: len:=lenSub;
  if lenSub<>0 then
    repeat
      if (psub[len]<>p[len]) or (psub[len+1]<>p[len+1]) then goto AfterTest0;
      len:=len+2;
    until len>=0;
  inc(p);
Ret:
  Result:=p-pStart;
Exit:
end;

function UpperCase(const s : string) : string;
var
  ch1, ch2, ch3, dist: integer;
  p, q: pInteger;
label
  Realloc, LengthOK;
begin;
  p:=pointer(@pchar(pointer(s))[-4]);
  ch1:=0;
  if integer(p)<>-4 then ch1:=p^;
  if ch1=0 then
    Result:=''
  else begin
    q:=pointer(Result);
    if q=nil then goto Realloc;
    if ch1 and 3=0 then
      if ch1 xor pInteger(pchar(q)-4)^ > 3 then
        goto Realloc
      else
    else
      if (ch1 or 2) xor pInteger(pchar(q)-4)^ > 1 then goto Realloc;
    if (pInteger(pchar(q)-8)^=1) then goto LengthOK;
Realloc:
    SetLength(Result,ch1 or 3);
    q:=pointer(Result);
LengthOK:
    pchar(q)[ch1]:=#0;                // Terminator
    dec(q); q^:=ch1;                  // Correct Result length
    dist:=(pointer(Result)-pchar(p)) shr 2;
    q:=@pchar(p)[(ch1+3) and -4];
    ch1:=q^;
    repeat;
      ch2:=ch1;
      ch1:=ch1 or integer($80808080); // $E1..$FA
      ch3:=ch1;
      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
      dec(q);
      ch1:=ch1 or integer($80808080); // $E6..$FF
      ch3:=ch3 xor ch2;               // $80
      ch1:=ch1 - $66666666;           // $80..$99
      ch3:=ch3 and ch1;               // $80
      ch1:=q^;
      ch3:=ch3 shr 2;                 // $20
      ch3:=ch3 xor ch2;               // Upper
      pIntegerArray(q)[dist]:=ch3;
    until cardinal(q)<=cardinal(p);
  end;
end;

function LowerCase(const s : string) : string;
var
  ch1, ch2, ch3, dist, term: integer;
  p: pchar;
label
  loop, last;
begin
  if s='' then begin
    Result:=''; exit;
  end;
  p:=pointer(s);
  //If need pure Pascal change the next line to term:=Length(s);
  term:=pinteger(@p[-4])^;
  SetLength(Result,term);
  if term<>0 then begin
    dist:=integer(Result);
    term:=integer(p+term);
    dist:=dist-integer(p)-4;
loop:
    ch1:=pinteger(p)^;
    ch3:=$7F7F7F7F;
    ch2:=ch1;
    ch3:=ch3 and ch1;
    ch2:=ch2 xor (-1);
    ch3:=ch3 + $25252525;
    ch2:=ch2 and $80808080;
    ch3:=ch3 and $7F7F7F7F;
    ch3:=ch3 + $1A1A1A1A;
    inc(p,4);
    ch3:=ch3 and ch2;
    if cardinal(p)>=cardinal(term) then goto last;
    ch3:=ch3 shr 2;
    ch1:=ch1 + ch3;
    pinteger(p+dist)^:=ch1;
    goto loop;
last:
    ch3:=ch3 shr 2;
    term:=term-integer(p);
    p:=p+dist;
    ch1:=ch1 + ch3;
    if term<-1 then
      pword(p)^:=word(ch1)
    else
      pinteger(p)^:=ch1;
  end;
end;

end.

