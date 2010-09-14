program Test15;

type
  [Teste]
  C = record
    var
      s:integer;//=1;
    type t = integer;
    [Teste]
    cc= class
      y:integer;
    end;
    [Teste]
    [Teste.abc(123, 'asas')]
    property X : integer;
    procedure x3; final;
  end;
    //B = class  abstract of C;

procedure TSynUNIXShellScriptSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #34, #39{!@#$#39}: fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}StringProc;
      '#': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}SlashProc;
      '{': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}BraceOpenProc;
      ';': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}PointCommaProc;
      '.': fProcTable[i] := {$IFDEF SYN_LAZARUS}@{$ENDIF}DotProc;
      #13: fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}CRProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}IdentProc;
      #10: fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}LFProc;
      #0: fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}NullProc;
      '0'..'9': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}NumberProc;
      '(': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}RoundOpenProc;
      '/': fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}SlashProc;
      '$': fProcTable[i] := {$IFDEF SYN_LAZARUS}@{$ENDIF}DollarProc;
      #1..#9, #11, #12, #14..#32: fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}SpaceProc;
      else fProcTable[I] := {$IFDEF SYN_LAZARUS}@{$ENDIF}UnknownProc;
    end;
end;

begin
end.
