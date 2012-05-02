unit Parser;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Date: jan-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
}
interface

uses
  Scanner, SymbolTable;

type
  TSymbol = string[15];
  TStack  = array[1..100] of TSymbol;

  { TParser }

  TParser = class(TScanner)
  private
    Symbol  : TSymbol;
    Symbols : TStack;
    function GetProductionName(const P : AnsiString) : AnsiString;
    procedure ExpandProduction(const T : AnsiString); inline;
    procedure PopSymbol; //inline;
  protected
    SymbolTable : TSymbolTable;
    procedure Call(Operations : array of pointer; Op : char);
    procedure RecoverFromError(const Expected, Found : AnsiString); override;
    procedure Analyse(Symbol : char); virtual; abstract;
    procedure Generate(Symbol : char); virtual; abstract;
  public
    constructor Create(MaxErrors : integer = 10 ; Includes : AnsiString = ''; pSilentMode : integer = 2 ;
                       LanguageMode : AnsiString = ''; pNotShow : AnsiString = '');
    procedure Compile(const Source : AnsiString);
    procedure Error(const Msg : AnsiString); override;
  end;

implementation

uses
  SysUtils, Math, Grammar, StrUtils, Token {$IFDEF UNICODE}, AnsiStrings{$ENDIF};

type
  TParserMethod = procedure of object;

procedure TParser.PopSymbol; begin
  dec(Top);
  if Top >= 1 then begin
    Symbol := Symbols[Top];
    case Symbol[1] of
      Mark, Require : PopSymbol;
      Pop :
        repeat
          while (Symbols[Top] <> Mark) and (Top > 2) do dec(Top);
          dec(Top);
          Symbol := Symbols[Top];
        until Symbol[1] <> Pop;
      Skip : begin
        ShowMessage('Warning', Symbols[Top + 1] + ' construct is ignored');
        dec(Top);
        Symbol := Symbols[Top];
        while UpperCase(Token.Lexeme) <> Symbol do NextToken(true);
      end;
    end;
  end
end;

procedure TParser.Call(Operations : array of pointer; Op : char);
var
  Method : TMethod;
begin
  Method.Code := Operations[Ord(Op)];
  Method.Data := Self;
  TParserMethod(Method);
end;

procedure TParser.RecoverFromError(const Expected, Found : AnsiString); begin
  inherited;
  if Top = 1 then
    FEndSource := true
  else begin
    repeat
      Top := LastGoodTop + 1;
      Symbol := Symbols[Top];
      Token.Lexeme := UpperCase(Token.Lexeme);
      while (Symbol <> Token.Lexeme) and (Top > 1) do
        if (Symbol[1] = Syntatic) and (pos('{' + Token.Lexeme + '}', Productions[Symbol[2]]) <> 0) then
          break
        else
          PopSymbol;
        if (Top = 1) and not EndSource then NextToken;
    until (Top <> 1) or EndSource;
    inc(Top);
  end;
end;

constructor TParser.Create(MaxErrors : integer; Includes : AnsiString; pSilentMode : integer; LanguageMode : AnsiString;
                           pNotShow : AnsiString);
begin
  SymbolTable := TSymbolTable.Create;
  inherited;
end;

procedure TParser.Compile(const Source : AnsiString); begin
  try
    SourceName := Source;
    Symbols[1] := Start;
    Symbol     := Start;
    Top        := 1;
    repeat
      case Symbol[1] of
        #0..#127   : MatchToken(Symbol); // Terminal
        Syntatic   : ExpandProduction(Token.Lexeme); // Production
        Semantic   : Analyse(Symbol[2]);
        Generator  : Generate(Symbol[2]);
        InsertSemi : begin
          dec(First, length(Token.Lexeme));
          Token.Lexeme := ';';
          Token.Kind   := tkSpecialSymbol;
        end
      else // Other Terminal
        MatchTerminal(CharToTokenKind(Symbol[1]));
      end;
      PopSymbol;
    until EndSource or (Top < 1);
  except
    on E : EAbort do Raise;
    on E : Exception do Error(E.Message);
  end;
end;

procedure TParser.Error(const Msg : AnsiString);
var
  I : integer;
begin
  inherited;
  exit; // Comment this line to debug the compiler
  for I := min(Top + 5, high(Symbols)) downto 2 do
    case Symbols[I][1] of
      #0..#127 : writeln(I, ': ', Symbols[I]); // Terminal
      Syntatic : writeln(I, ': #', Ord(Symbols[I][2]), ', ', GetProductionName(Productions[Symbols[I][2]])); // Production
      Skip     : writeln(I, ': Skip');
      Require  : writeln(I, ': Require');
      Mark     : writeln(I, ': Mark');
      Pop      : writeln(I, ': Pop');
    else
      writeln(I, ': ', Symbols[I], ': TRASH');
    end;
end;

procedure TParser.ExpandProduction(const T : AnsiString);
var
  Production : AnsiString;
  P, TopAux, LenToken : integer;
  Aux : TStack;
begin
  ErrorCode  := Symbol[2];
  Production := Productions[Symbol[2]];
  LenToken   := 1;
  case Token.Kind of
    tkIdentifier : begin
      P := pos('{' + Ident, Production);
      if P = 0 then begin
        P := pos('{' + UpperCase(T) + '}', Production); // find FIRST or FOLLOW terminal
        LenToken := length(T);
      end
    end;
    tkReservedWord, tkSpecialSymbol : begin
      P := pos('{' + UpperCase(T) + '}', Production); // find FIRST or FOLLOW terminal
      LenToken := length(T);
    end;
  else // tkStringConstant..tkRealConstant
    P := pos('{' + TokenKindToChar(Token.Kind) + '}', Production);
  end;
  if P <> 0 then begin
    dec(Top);
    TopAux := 1;
    Aux[1] := copy(Production, P + 1, LenToken);
    inc(P, LenToken + 2);
    while P <= length(Production) do begin
      case Production[P] of
        Syntatic..Generator : begin // Nonterminal
          inc(TopAux);
          Aux[TopAux] := Production[P] + Production[P+1];
          inc(P);
        end;
        Ident..Pop : begin // Nonterminal
          inc(TopAux);
          Aux[TopAux] := Production[P];
        end;
        '{' : break; // End production
      else
        if (Aux[TopAux] <> '') and (Aux[TopAux][1] >= Syntatic) then begin // begin terminal
          inc(TopAux);
          Aux[TopAux] := Production[P]
        end
        else begin // Terminal
          if Production[P-1] = '}' then begin
            inc(TopAux);
            Aux[TopAux] := '';
          end;
          Aux[TopAux] := Aux[TopAux] + Production[P]
        end;
      end;
      inc(P)
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

function TParser.GetProductionName(const P : AnsiString) : AnsiString;
var
  I, J : integer;
  S : AnsiString;
begin
  Result := '';
  if P[1] = '{' then begin
    I := 2;
    repeat
      J := posex('}', P, I);
      S := copy(P, I, J-I);
      if S[1] > Start then
        S := GetNonTerminalName(S[1])
      else
        S := '''' + S + '''';
      if Result = '' then
        Result := S
      else
        Result := Result + ', ' + S;
      I := posex('{', P, J+1) + 1;
    until I = 1;
    I := LastDelimiter(',', Result);
    if I <> 0 then begin
      delete(Result, I, 2);
      insert(' or ', Result, I);
    end;
  end
  else
    Result := copy(P, 1, pos('{', P)-1);
end;

end.
