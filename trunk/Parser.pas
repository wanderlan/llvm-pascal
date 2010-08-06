unit Parser;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Date: jan-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
}
interface

uses
  Scanner;

type
  TSymbol = string[20];
  TStack  = array[1..100] of TSymbol;
  TParser = class(TScanner)
  private
    Symbol     : TSymbol;
    Symbols    : TStack;
    Production : string;
    function GetProductionName(P : string) : string;
    procedure ExpandProduction(T : string);
    procedure PopSymbol; inline;
  protected
    Top : integer;
    procedure RecoverFromError(Expected, Found : string); override;
  public
    procedure Compile(Source : string);
    procedure Error(Msg : string); override;
  end;

implementation

uses
  SysUtils, StrUtils, Math, Grammar;

procedure TParser.PopSymbol; begin
  dec(Top);
  if Top >= 1 then begin
    Symbol := Symbols[Top];
    case Symbol[1] of
      Mark, Require : PopSymbol;
      Pop : begin
        repeat
          dec(Top);
        until (Symbols[Top] = Mark) or (Top <= 2);
        dec(Top);
        Symbol := Symbols[Top];
      end;
      Skip : begin
        dec(Top);
        Symbol := Symbols[Top];
        while UpperCase(Token.Lexeme) <> Symbol do NextToken;
      end;
    end;
  end
end;

procedure TParser.RecoverFromError(Expected, Found : string); begin
  inherited;
  if Top = 1 then
    FEndSource := true
  else begin
    while (Symbol <> ';') and (Top > 1) do
      if ((Symbol[1] in [Start..CallConv]) and (pos('|;|', Productions[Symbol[1]]) <> 0)) then
        break
      else
        PopSymbol;
    inc(Top);
  end;
end;

procedure TParser.Compile(Source : string); begin
  try
    SourceName := Source;
    Symbols[1] := Start;
    Symbol     := Start;
    Top        := 1;
    repeat
      case Symbol[1] of
        #0..#127        : MatchToken(Symbol); // Terminal
        Start..CallConv : ExpandProduction(Token.Lexeme) // Production
      else // Other Terminal
        MatchTerminal(CharToTokenKind(Symbol[1]));
      end;
      PopSymbol;
    until EndSource or (Top < 1);
  except
    on E : EAbort do exit;
    on E : Exception do Error(E.Message);
  end;
end;

procedure TParser.Error(Msg : string);
var
  I : integer;
begin
  inherited;
  exit; // Comment this line to debug the compiler
  for I := min(Top, high(Symbols)) downto 2 do
    case Symbols[I][1] of
      #0..#127        : writeln(I, ': ', Symbols[I]); // Terminal
      Start..CallConv : writeln(I, ': #', Ord(Symbols[I][1]), ', ', GetProductionName(Productions[Symbols[I][1]])); // Production
      Skip    : writeln(I, ': Skip');
      Require : writeln(I, ': Require');
      Mark    : writeln(I, ': Mark');
      Pop     : writeln(I, ': Pop');
    else
      writeln(I, ': ', Symbols[I], ': TRASH');
    end;
end;

procedure TParser.ExpandProduction(T : string);
var
  P, TopAux : integer;
  Aux  : TStack;
  LenT : integer;
begin
  Production := Productions[Symbol[1]];
  if (T <> '') and not(Token.Kind in [tkStringConstant, tkCharConstant]) then
    P := pos('|' + UpperCase(T) + '|', Production) // find FIRST or FOLLOW terminal
  else
    P := 0;
  if (P = 0) and (Token.Kind <> tkUndefined) then begin
    P := pos('|' + TokenKindToChar(Token.Kind) + '|', Production);
    LenT := 1
  end
  else
    LenT := length(T);
  if P <> 0 then begin
    dec(Top);
    TopAux := 1;
    Aux[1] := copy(Production, P + 1, LenT);
    inc(P, LenT + 2);
    for P := P to length(Production) do
      case Production[P] of
        Start..#255 : begin // Nonterminal
          inc(TopAux);
          Aux[TopAux] := Production[P];
        end;
        '|' : break; // End production
      else
        if (Aux[TopAux] <> '') and (Aux[TopAux][1] >= Start) then begin // begin terminal
          inc(TopAux);
          Aux[TopAux] := Production[P]
        end
        else begin // Terminal
          if Production[P-1] = '|' then begin
            inc(TopAux);
            Aux[TopAux] := '';
          end;
          Aux[TopAux] := Aux[TopAux] + Production[P]
        end;
      end;
    for TopAux := TopAux downto 1 do begin // push at reverse order
      inc(Top);
      Symbols[Top] := Aux[TopAux];
    end;
    inc(Top);
  end
  else
    if (Top = 1) or (Symbols[Top+1] = Require) then
      RecoverFromError(GetProductionName(Production), Token.Lexeme);
end;

function TParser.GetProductionName(P : string) : string;
var
  I, J : integer;
  S : string;
begin
  Result := '';
  if P[1] = '|' then begin
    I := 2;
    repeat
      J := posex('|', P, I);
      S := copy(P, I, J-I);
      if S[1] > Start then
        S := GetNonTerminalName(S[1])
      else
        S := '''' + S + '''';
      if Result = '' then
        Result := S
      else
        Result := Result + ', ' + S;
      I := posex('|', P, J+1)+1;
    until I = 1;
    I := LastDelimiter(',', Result);
    if I <> 0 then begin
      delete(Result, I, 2);
      insert(' or ', Result, I);
    end;
  end
  else
    Result := copy(P, 1, pos('|', P)-1);
end;

end.
