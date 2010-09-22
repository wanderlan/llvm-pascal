program Test15;

const
  X = %date;
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

type
  TPair<Tkey,TValue> = class   // TKey and TValue are type parameters
    FKey: TKey;
    FValue: TValue;
    function GetValue: TValue;
  end;

  function TPair<TKey,TValue>.GetValue: TValue;
    begin
      Result := FValue;
    end;

type
  TFoo<T> = class
    FData: T;
  end;

  var
    F: TFoo<Integer>; // 'Integer' is the type argument of TFoo<T>

type
  TMyProc2<Y> = procedure(Param1, Param2: Y) of object;

  TFoo = class
    procedure Test;
    procedure MyProc2<T>(X, Y: T);
  end;

type
  TFoo<T> = class
    type
      TBar = class
        X: Integer;
          // ...
       end;
     // ...
     TBaz = class
     type
       TQux<T> = class
         X: Integer;
         // ...
        end;
      // ...
    end;
  end;
var
      N: TFoo<Double>.TBar;

type
  TOuter = class
    type
      TData<T> = class
        FFoo1: TFoo<Integer>;         // declared with closed constructed type
        FFoo2: TFoo<T>;               // declared with open constructed type
        FFooBar1: TFoo<Integer>.TBar; // declared with closed constructed type
        FFooBar2: TFoo<T>.TBar;       // declared with open constructed type
        FBazQux1: TBaz.TQux<Integer>; // declared with closed constructed type
        FBazQux2: TBaz.TQux<T>;       // declared with open constructed type
      end;
    var
      FIntegerData: TData<Integer>;
      FStringData: TData<String>;
    end;

type
   TFoo1<T> = class(TBar)            // Actual type
     end;

   TFoo2<T> =  class(TBar2<T>)       // Open constructed type
     end;
   TFoo3<T> = class(TBar3<Integer>)  // Closed constructed type
      end;

type
  TRecord<T> = record
    FData: T;
    end;

type
  IAncestor<T> = interface
    function GetRecord: TRecord<T>;
    end;

  IFoo<T> = interface(IAncestor<T>)
    procedure AMethod(Param: T);
    end;

type
  TFoo<T> = class(TObject, IFoo<T>)
    FField: TRecord<T>;
      procedure AMethod(Param: T);
      function GetRecord: TRecord<T>;
    end;

type
  TMyProc<T> = procedure(Param: T);
    TMyProc2<Y> = procedure(Param1, Param2: Y) of object;
    type
      TFoo = class
        procedure Test;
        procedure MyProc(X, Y: Integer);
      end;

      procedure Sample(Param: Integer);
        begin
         Writeln(Param);
        end;

      procedure TFoo.MyProc(X, Y: Integer);
        begin
          Writeln('X:', X, ', Y:', Y);
        end;

       procedure TFoo.Test;
        var
          X: TMyProc<Integer>;
          Y: TMyProc2<Integer>;
          begin
            X := Sample;
            X(10);
            Y := MyProc;
            Y(20, 30);
          end;

      var
        F: TFoo;

type
  TMyProc2<Y> = procedure(Param1, Param2: Y) of object;
    TFoo<T> = class
      procedure Test;
      procedure MyProc2<T>(X, Y: T);
    end;

    procedure TFoo.MyProc2<T>(X, Y: T);
      begin
        Write('MyProc2<T>');
        {$IFDEF CIL}
          Write(X.ToString);
          Write(', ');
          Writeln(Y.ToString);
        {$ENDIF}
        WR
      end;

      procedure TFoo.Test;
        var
          P : TMyProc2<Integer>;
          X: TFoo<Integer>;
          begin
            MyProc2<String>('Hello', 'World');    //type specified
            MyProc2('Hello', 'World');            //inferred from argument type
            MyProc2<Integer>(10, 20);
            MyProc2(10, 20);
            P := X.MyProc2;
            P(40, 50);
          end;

      var
        F: TFoo;

type
  TFoo<T> = class
    X: T;
    end;

  TBar<S> = class(TFoo<S>)
    Y: T;  // error!  unknown identifier "T"
    end;

    var
      F: TFoo<Integer>;


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
