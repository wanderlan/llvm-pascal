unit Scanner;
{
Author: Wanderlan Santos dos Anjos, wanderlan.anjos@gmail.com
Date: jan-2010
License: <extlink http://www.opensource.org/licenses/bsd-license.php>BSD</extlink>
}
interface

uses
  Classes, Token;

const
  MaxIncludeLevel = 32;
  Version   = '2012.5 Alpha I semantics';
  TargetCPU = 'x86_64'; // 'arm'; 'cellspu'; 'hexagon'; 'mips'; 'mipsel'; 'mips64'; 'mips64el'; 'msp430'; 'powerpc64'; 'powerpc';
                        // 'r600'; 'sparc'; 'sparcv9'; 'tce'; 'thumb'; 'i386'; 'xcore'; 'mblaze'; 'ptx32'; 'ptx64'; 'le32'; 'amdil';
  TargetOS  = 'win32'; // 'auroraux'; 'cygwin'; 'darwin'; 'dragonfly'; 'freebsd'; 'ios'; 'kfreebsd'; 'linux'; 'lv2'; 'macosx';
                       // 'mingw32'; 'netbsd'; 'openbsd'; 'solaris'; 'haiku'; 'minix'; 'rtems'; 'nacl'; 'cnk';

type
  {$IFDEF UNICODE}
  Char = AnsiChar;
  {$ENDIF}
  TSetChar = set of char;
  TScanner = class
  private
    Arq       : array[0..MaxIncludeLevel] of text;
    FToken    : TToken;
    Include,
    LenLine   : integer;
    FInitTime : TDateTime;
    Macros    : TStringList;
    Line      : AnsiString;
    Buffer    : array[1..8 * 1024] of byte;
    FSourceName   : array[0..MaxIncludeLevel] of ShortString;
    FStartComment : string[10];
    FEndComment   : string[100];
    Procedure GetCompilerInfo;  // Compiler Info and Environment Variable
    procedure SetDelphiMode;
    function TokenIn(const S : AnsiString) : boolean; inline;
    function GetFLineNumber : integer;
    function GetFSourceName : AnsiString;
    function TestIncludePaths : boolean;
    procedure NextChar(C : TSetChar);
    procedure FindEndComment(const StartComment, EndComment : AnsiString);
    procedure SetFSourceName(const Value : AnsiString);
    procedure DoDirective(DollarInc : integer);
    procedure SkipBlank; inline;
    procedure NextString;
    procedure DoIf(Condition : boolean);
    procedure CreateMacro;
    procedure OpenInclude;
    procedure SetFLineNumber(const Value : integer);
    procedure EmitMessage;
    procedure GotoEndComment;
  protected
    FEndSource, FPCMode, DoNextToken : boolean;
    FLineNumber : array[0..MaxIncludeLevel] of integer;
    FTotalLines, First, FErrors, FMaxErrors, Top, LastGoodTop, FAnt, LineComment, FSilentMode : integer;
    LastLexeme, ErrorCode, NestedIf : ShortString;
    IncludePath, FNotShow, ReservedWords : TStringList;
    function CharToTokenKind(N : char) : TTokenKind;
    function TokenKindToChar(T : TTokenKind) : char;
    function StringToTokenKind(S : string; Default : TTokenKind = tkUndefined) : TTokenKind;
    function GetNonTerminalName(N : char) : AnsiString;
    procedure ScanChars(const Chars: array of TSetChar; const Tam : array of integer; Optional : boolean = false);
    procedure NextToken(Skip : boolean = false);
    procedure RecoverFromError(const Expected, Found : AnsiString); virtual;
    procedure ChangeLanguageMode(FPC : boolean);
  public
    constructor Create(MaxErrors : integer = 10 ; Includes : AnsiString = ''; SilentMode : integer = 2 ;
                       LanguageMode : AnsiString = ''; NotShow : AnsiString = '');
    destructor Destroy; override;
    procedure MatchTerminal(KindExpected : TTokenKind); //inline;
    procedure ShowMessage(Kind, Msg : ShortString);
    procedure Error(const Msg : AnsiString); virtual;
    procedure MatchToken(const TokenExpected : AnsiString); //inline;
    property SourceName : AnsiString read GetFSourceName write SetFSourceName;
    property LineNumber : integer    read GetFLineNumber write SetFLineNumber;
    property TotalLines : integer    read FTotalLines;
    property ColNumber  : integer    read First;
    property Token      : TToken     read FToken write FToken;
    property EndSource  : boolean    read FEndSource;
    property Errors     : integer    read FErrors;
    property InitTime   : TDateTime  read FInitTime;
    property SilentMode : integer    read FSilentMode;
  end;

implementation

uses
  SysUtils, StrUtils, IniFiles, Math, Grammar {$IFDEF UNICODE}, AnsiStrings{$ENDIF};

const
  DelphiReservedWords = 'and.array.as.asm.automated.begin.case.class.const.constructor.destructor.dispinterface.div.do.downto.' +
    'else.end.except.exports.file.finalization.finally.for.function.goto.if.implementation.in.inherited.initialization.inline.' +
    'interface.is.label.library.mod.nil.not.object.of.or.out.packed.private.procedure.program.property.protected.public.' +
    'published.raise.record.repeat.resourcestring.set.shl.shr.strict.then.threadvar.to.try.type.unit.until.uses.var.while.with.xor';
  FPCReservedWords = '.operator';
  ConditionalSymbols : AnsiString = '.llvm.ver2010.mswindows.win32.cpu386.conditionalexpressions.purepascal.';

constructor TScanner.Create(MaxErrors : integer = 10; Includes : AnsiString = ''; SilentMode : integer = 2;
                            LanguageMode : AnsiString = ''; NotShow : AnsiString = ''); begin
  FInitTime  := Now;
  FMaxErrors := MaxErrors;
  DecimalSeparator  := '.';
  ThousandSeparator := ',';
  FSilentMode := SilentMode;
  IncludePath := TStringList.Create;
  IncludePath.Delimiter := ';';
  IncludePath.StrictDelimiter := true;
  IncludePath.DelimitedText := ';' + Includes;
  FNotShow := TStringList.Create;
  FNotShow.DelimitedText := NotShow;
  ReservedWords := THashedStringList.Create;
  ReservedWords.Delimiter := '.';
  ReservedWords.CaseSensitive := false;
  SetDelphiMode;
  ChangeLanguageMode(pos('FPC', UpperCase(LanguageMode)) <> 0);
end;

destructor TScanner.Destroy;
var
  Elapsed : TDateTime;
begin
  Elapsed := Now - InitTime;
  if Elapsed = 0 then Elapsed := 3E-9;
  if FileExists(SourceName) then close(Arq[Include]);
  writeln;
  if Errors <> 0 then writeln(Errors, ' error(s).');
  writeln(TotalLines, ' lines, ', IfThen(FormatDateTime('n', Elapsed) = '0', '', FormatDateTime('n ', Elapsed) + 'minute(s) and '),
    FormatDateTime('s.z ', Elapsed), 'seconds, ', TotalLines/1000.0/(Elapsed*24*60*60):0:1, ' klps.');
  inherited;
  FToken.Free;
  IncludePath.Free;
  FNotShow.Free;
  ReservedWords.Free;
  FreeAndNil(Macros);
end;

procedure TScanner.ScanChars(const Chars : array of TSetChar; const Tam : array of integer; Optional : boolean = false);
var
  I, T, Last : integer;
begin
  FToken.Lexeme := '';
  FToken.Kind   := tkUndefined;
  for I := 0 to high(Chars) do begin
    Last := First;
    T    := 1;
    while (Last <= LenLine) and (T <= Tam[I]) and (Line[Last] in Chars[I]) do begin
      inc(Last);
      inc(T);
    end;
    if Last > First then begin
      FToken.Lexeme := FToken.Lexeme + copy(Line, First, Last - First);
      First := Last;
    end
    else
      if Optional then exit;
  end;
end;

procedure TScanner.SetFLineNumber(const Value : integer); begin
  FLineNumber[Include] := Value
end;

procedure TScanner.SetFSourceName(const Value : AnsiString); begin
  if FErrors >= FMaxErrors then Abort;
  if FileExists(SourceName) then close(Arq[Include]);
  Include    := 0;
  LineNumber := 0;
  LenLine    := 0;
  NestedIf   := '';
  FEndSource := false;
  FSourceName[Include] := Value;
  if FileExists(SourceName) then begin
    if FSilentMode >= 2 then writeln(ExtractFileName(SourceName));
    assign(Arq[Include], SourceName);
    SetTextBuf(Arq[Include], Buffer);
    reset(Arq[Include]);
    First  := 1;
    FToken := TToken.Create;
    FreeAndNil(Macros);
    NextToken;
  end
  else begin
    FEndSource := true;
    Error('Source file "' + SourceName + '" not found');
    Abort;
  end;
end;

procedure TScanner.NextChar(C : TSetChar); begin
  if (First < LenLine) and (Line[First + 1] in C) then begin
    FToken.Lexeme := copy(Line, First, 2);
    inc(First, 2);
  end
  else begin
    FToken.Lexeme := Line[First];
    inc(First);
  end;
  FToken.Kind := tkSpecialSymbol;
end;

procedure TScanner.DoIf(Condition : boolean); begin
  if Condition then begin
    NestedIf := NestedIf + 'T';
    FStartComment := '$';
  end
  else begin
    NestedIf := NestedIf + 'F';
    FEndComment := 'ENDIF' + FEndComment;
  end;
end;

procedure TScanner.GetCompilerInfo; begin
  ScanChars([['A'..'Z', 'a'..'z', '_', '0'..'9']], [254]);
  case AnsiIndexText(FToken.Lexeme, ['FILE', 'LINE', 'DATE', 'TIME', 'VERSION', 'FPCVERSION', 'TARGETOS', 'FPCTARGETOS',
                                     'TARGETCPU', 'FPCTARGETCPU']) of
   -1 : FToken.Lexeme := GetEnvironmentVariable(FToken.Lexeme);
    0 : FToken.Lexeme := ExtractFileName(SourceName);
    1 : FToken.Lexeme := IntToStr(LineNumber);
    2 : FToken.Lexeme := FormatDateTime('ddddd', Date);
    3 : FToken.Lexeme := FormatDateTime('tt', Now);
    4,
    5 : FToken.Lexeme := Version;
    6,
    7 : FToken.Lexeme := TargetOS;
    8,
    9 : FToken.Lexeme := TargetCPU;
  end;
  FToken.Kind := tkStringConstant;
end;

function TScanner.TestIncludePaths : boolean;
var
  F : string;
  I : integer;
begin
  Result := false;
  for I := 0 to IncludePath.Count-1 do begin
    F := AnsiReplaceStr(IfThen(I = 0, ExtractFilePath(FSourceName[0]), IncludePath[I]) + trim(FToken.Lexeme), '*', ExtractFileName(SourceName));
    Result := FileExists(F);
    if Result then begin
      FToken.Lexeme := F;
      exit;
    end;
  end;
end;

procedure TScanner.OpenInclude; begin
  if Line[First] in ['+', '-'] then exit;
  First := FAnt;
  SkipBlank;
  if Line[First] = '%' then begin
    inc(First);
    GetCompilerInfo;
    GotoEndComment;
    Abort;
  end
  else begin
	   ScanChars([['!'..#255] - ['}']], [255]);
	   FToken.Lexeme := AnsiDequotedStr(trim(FToken.Lexeme), '''');
	   if FToken.Lexeme = '' then exit;
	   if TestIncludePaths then begin
	     if length(trim(copy(Line, First, 100))) > 1 then
	       ShowMessage('Warning', 'Text after $Include directive, in the same line, is lost, break the line please.');
	     GotoEndComment;
	     inc(Include);
	     assign(Arq[Include], FToken.Lexeme);
	     reset(Arq[Include]);
	     LineNumber := 0;
	     FSourceName[Include] := FToken.Lexeme;
	     if FSilentMode >= 2 then writeln('' : Include * 2, ExtractFileName(SourceName));
	   end
	   else
	     if FSilentMode >= 2 then Error('Include file "' + FToken.Lexeme + '" not found');
  end;
end;

procedure TScanner.ShowMessage(Kind, Msg : ShortString);
  function CanShowMessage : boolean;
  var
    I : integer;
  begin
    for I := 0 to FNotShow.Count - 1 do
      if pos(FNotShow[I], Kind[1] + ErrorCode) = 1 then begin
        Result := false;
        exit;
      end;
    Result := true;
  end;
begin
  if length(ErrorCode) = 1 then ErrorCode := IntToStr(ord(ErrorCode[1]));
  Kind := UpCase(Kind[1]) + LowerCase(copy(Kind, 2, 10));
  if CanShowMessage and ((FSilentMode >= 2) or (Kind = 'Error') or (Kind = 'Fatal')) then begin
    writeln('[' + Kind + '] ' + ExtractFileName(SourceName) + '('+ IntToStr(LineNumber) + ', ' + IntToStr(ColNumber - Length(Token.Lexeme)) + '): ' +
            Kind[1] + ErrorCode + ' ' + Msg);
    if (FSilentMode >= 1) and (Line <> '') then writeln(Line, ^J, '^' : ColNumber - Length(Token.Lexeme));
  end;
  if Kind = 'Fatal' then FEndSource := true;
  readln;
end;

procedure TScanner.EmitMessage;
var
  L : AnsiString;
begin
  L := FToken.Lexeme;
  SkipBlank;
  ScanChars([[#1..#255]-['}']], [100]);
  case AnsiIndexText(L, ['HINT', 'WARN', 'ERROR', 'FATAL']) of
    0, 1 : ShowMessage(L, FToken.Lexeme);
    2 : Error(FToken.Lexeme);
    3 : ShowMessage('Fatal', FToken.Lexeme);
  else
    First := FAnt;
    SkipBlank;
    ScanChars([[#1..#255]-['}']], [100]);
    ShowMessage('Hint', FToken.Lexeme);
  end;
end;

procedure TScanner.DoDirective(DollarInc : integer);
var
  I : integer;
  L : AnsiString;
begin
  First := DollarInc + 1;
  if Line[First] in ['A'..'Z', '_', 'a'..'z'] then begin
    ScanChars([['A'..'Z', 'a'..'z', '_', '0'..'9']], [255]);
    L := FToken.Lexeme;
    FAnt := First;
    SkipBlank;
    ScanChars([['A'..'Z', 'a'..'z', '_', '0'..'9']], [255]);
    case AnsiIndexText(L, ['DEFINE', 'UNDEF', 'IFDEF', 'IFNDEF', 'IF', 'IFOPT', 'ENDIF', 'IFEND', 'ELSE', 'ELSEIF', 'MODE',
                           'I', 'INCLUDE', 'MESSAGE', 'MODESWITCH']) of
      0 : begin
        if not TokenIn(ConditionalSymbols) then ConditionalSymbols := ConditionalSymbols + LowerCase(FToken.Lexeme) + '.';
        CreateMacro;
      end;
      1 : begin
        I := pos('.' + LowerCase(FToken.Lexeme) + '.', ConditionalSymbols);
        if I <> 0 then delete(ConditionalSymbols, I, length(FToken.Lexeme) + 1);
      end;
      2 : DoIf(TokenIn(ConditionalSymbols));
      3 : DoIf(not TokenIn(ConditionalSymbols));
      4, 9 : if AnsiIndexText(FToken.Lexeme, ['DEFINED', 'DECLARED']) <> -1 then begin
        ScanChars([['(']], [1]);
        ScanChars([['A'..'Z', 'a'..'z', '_', '0'..'9']], [255]);
        DoIf(TokenIn(ConditionalSymbols));
      end;
      5 : DoIf(false);
      6, 7 : if NestedIf <> '' then SetLength(NestedIf, length(NestedIf)-1);
      8 : DoIf(not((NestedIf = '') or (NestedIf[length(NestedIf)] = 'T')));
      10 : ChangeLanguageMode(pos('FPC', UpperCase(FToken.Lexeme)) <> 0);
      11, 12 : OpenInclude;
      13 : EmitMessage;
      14 : ShowMessage('Fatal', 'Invalid directive "' + L + ' ' + FToken.Lexeme + '"');
    else
      GotoEndComment;
      exit;
    end;
    FindEndComment(FStartComment, FEndComment);
  end
  else begin
    Error('Invalid compiler directive "' + Line[First] + '"');
    inc(First);
  end;
end;

procedure TScanner.GotoEndComment;
var
  P : integer;
begin
  P := PosEx(FEndComment, UpperCase(Line), First);
  if P <> 0 then begin // End comment in same line
    First := P + length(FEndComment);
    if length(FEndComment) <= 2 then FEndComment := '';
  end
  else
    First := LenLine + 1;
end;

procedure TScanner.FindEndComment(const StartComment, EndComment : AnsiString);
  procedure DoEndIf; begin
    FEndComment := copy(FEndComment, 6, 100);
    if NestedIf <> '' then SetLength(NestedIf, length(NestedIf)-1);
    dec(First, 5);
  end;
var
  P : integer;
begin
  if FEndComment = '' then LineComment := LineNumber;
  FStartComment := StartComment;
  FEndComment   := EndComment;
  P := PosEx(FStartComment + '$', Line, First);
  if ((P - First) > 2) and (EndComment = '}') then P := 0;
  if (P <> 0) and ((NestedIf = '') or (NestedIf[length(NestedIf)] = 'T')) then
    DoDirective(P + length(FStartComment))
  else begin
    while (P <> 0) and ((NestedIf <> '') and (NestedIf[length(NestedIf)] = 'F')) do begin
      First := P + length(FStartComment) + 1;
      if Line[First] in ['A'..'Z', '_', 'a'..'z'] then begin
        ScanChars([['A'..'Z', 'a'..'z', '_', '0'..'9']], [255]);
        case AnsiIndexText(FToken.Lexeme, ['IFDEF', 'IFNDEF', 'IFOPT', 'IF', 'ENDIF', 'IFEND', 'ELSE', 'ELSEIF']) of
          0..3 : begin DoIf(false); exit; end;
          4..5 : DoEndIf;
          6, 7 : if (NestedIf = 'F') or (NestedIf[length(NestedIf)-1] = 'T') then DoEndIf;
        end;
      end;
      P := PosEx(FStartComment + '$', Line, First);
    end;
    GotoEndComment;
  end;
end;

procedure TScanner.SkipBlank; begin
  while (First <= LenLine) and (Line[First] in [' ', #9]) do inc(First);
end;

function TScanner.TokenIn(const S : AnsiString) : boolean; begin
  Result := pos('.' + LowerCase(FToken.Lexeme) + '.', S) <> 0;
end;

procedure TScanner.NextString;
var
  Str : AnsiString;
begin
  Str := '';
  repeat
    if Line[First] <> '#' then begin
      inc(First);
      repeat
        ScanChars([[#0..#255] - ['''']], [5000]);
        Str := Str + FToken.Lexeme;
        if (First < LenLine) and (Line[First + 1] = '''') then begin
          Str := Str + '''';
          inc(First, 2);
        end;
      until (First >= LenLine) or (Line[First] = '''');
      inc(First);
    end;
    repeat
      ScanChars([['^'], ['@'..'Z']], [1, 1], true);
      case length(FToken.Lexeme) of
        1 : begin
          FToken.Kind := tkSpecialSymbol;
          exit;
        end;
        2 : Str := Str + char(byte(FToken.Lexeme[2]) - ord('@'))
      end;
    until FToken.Lexeme = '';
    repeat
      ScanChars([['#'], ['0'..'9']], [1, 3], true);
      case length(FToken.Lexeme) of
        1 :
          if Line[First] = '$' then begin
            ScanChars([['$'], ['0'..'9', 'A'..'F', 'a'..'f']], [1, 4]);
            Str := Str + char(StrToIntDef(FToken.Lexeme, 0));
          end
          else begin
            FToken.Kind := tkSpecialSymbol;
            exit;
          end;
        2..3 : Str := Str + char(StrToIntDef(copy(FToken.Lexeme, 2, 3), 0));
        4..5 : Str := Str + widechar(StrToIntDef(copy(FToken.Lexeme, 2, 5), 0));
      end;
    until FToken.Lexeme = '';
  until (First >= length(Line)) or (Line[First] <> '''');
  FToken.Lexeme := Str;
  if length(FToken.Lexeme) = 1 then
    FToken.Kind := tkCharConstant
  else
    FToken.Kind := tkStringConstant;
end;

procedure TScanner.NextToken(Skip : boolean = false);
var
  Str : AnsiString;
  I   : integer;
begin
  DoNextToken := false;
  LastLexeme  := FToken.Lexeme;
  while not FEndSource do begin
    while First > LenLine do begin
      readln(Arq[Include], Line);
      LenLine := length(Line);
      if EOF(Arq[Include]) and ((LenLine = 0) or (Line = ^Z)) then begin
        if FEndComment <> '' then
          Error('Unterminated ' + IfThen(pos('ENDIF', FEndComment) <> 0, 'compiler directive', 'comment') + ' started on line ' + IntToStr(LineComment));
        FEndComment := '';
        if Include > 0 then begin
          close(Arq[Include]);
          dec(Include);
          First := LenLine + 1;
          continue;
        end
        else begin
          FEndSource := true;
          FToken.Lexeme := 'End of Source';
          exit;
        end;
      end;
      LineNumber := LineNumber + 1;
      inc(FTotalLines);
      First := 1;
      if (FEndComment = '') and (Macros <> nil) and (LenLine <> 0) and ((NestedIf = '') or (NestedIf[length(NestedIf)] = 'T')) then
        for I := 0 to Macros.Count - 1 do // Replace macros
          Line := AnsiReplaceStr(Line, Macros.Names[I], Macros.ValueFromIndex[I]);
    end;
    // End comment across many lines
    if FEndComment <> '' then begin
      FindEndComment(FStartComment, FEndComment);
      continue;
    end;
    case Line[First] of
      ' ', #9 : SkipBlank;
      'A'..'Z', 'a'..'z', '_', '&' : begin // Identifiers
        ScanChars([['A'..'Z', 'a'..'z', '_', '&', '0'..'9'], ['A'..'Z', 'a'..'z', '_', '0'..'9']], [1, 254]);
        if length(FToken.Lexeme) = 1 then
          FToken.Kind := tkIdentifier
        else
          if ReservedWords.IndexOf({$IFDEF FPC}LowerCase{$ENDIF}(FToken.Lexeme)) <> -1 then
            FToken.Kind := tkReservedWord
          else
            if (FToken.Lexeme[1] = '&') and (FToken.Lexeme[2] in ['0'..'7']) then begin // Octal
              FToken.Kind := tkIntegerConstant;
              FToken.IntegerValue := 0;
              for I := length(FToken.Lexeme) downto 2 do
                inc(FToken.IntegerValue, trunc((ord(FToken.Lexeme[I]) - 48) * Power(8, length(FToken.Lexeme) - I)));
            end
            else begin
              FToken.Kind := tkIdentifier;
              if FPCMode and TokenIn('.generic.specialize.') then NextToken;
            end;
        exit;
      end;
      ';', ',', '=', ')', '[', ']', '@' : begin
        FToken.Lexeme := Line[First];
        FToken.Kind   := tkSpecialSymbol;
        inc(First);
        exit;
      end;
      '+', '-' : begin NextChar(['=']); exit; end;
      '^' : begin
        Str  := '';
        FAnt := First;
        repeat
          ScanChars([['^'], ['@'..'Z', 'a'..'z']], [1, 2], true);
          if length(FToken.Lexeme) = 2 then
            Str := Str + char(byte(FToken.Lexeme[2]) - ord('@'));
        until length(FToken.Lexeme) <> 2;
        FToken.Lexeme := Str;
        if ErrorCode >= Generics[2] then FToken.Lexeme := '';
        case length(FToken.Lexeme) of
          0 : begin
            First         := FAnt + 1;
            FToken.Lexeme := Line[First-1];
            FToken.Kind   := tkSpecialSymbol;
          end;
          1 : FToken.Kind := tkCharConstant
        else
          FToken.Kind := tkStringConstant;
        end;
        exit;
      end;
      '''', '#': begin NextString; exit; end; // strings
      '0'..'9' : begin // Numbers
        ScanChars([['0'..'9'], ['.', 'E', 'e']], [28, 1], true);
        Str := FToken.Lexeme;
        case Str[length(Str)] of
          '.' : begin
            ScanChars([['0'..'9'], ['E', 'e'], ['+', '-'], ['0'..'9']], [27, 1, 1, 4], true);
            Str := Str + UpperCase(FToken.Lexeme);
            FToken.Lexeme := '';
            if upcase(Str[length(Str)]) = 'E' then ScanChars([['0'..'9']], [4]);
          end;
          'E', 'e' : begin
            ScanChars([['+', '-'], ['0'..'9']], [1, 4]);
            Str := Str + FToken.Lexeme;
            FToken.Lexeme := '';
          end;
        else
          FToken.Lexeme := '';
        end;
        FToken.Lexeme := Str + UpperCase(FToken.Lexeme);
        if FToken.Lexeme[length(FToken.Lexeme)] in ['.', 'E', '+', '-'] then begin
          dec(First);
          SetLength(FToken.Lexeme, length(FToken.Lexeme)-1);
        end;
        if (pos('.', FToken.Lexeme) <> 0) or (pos('E', UpperCase(FToken.Lexeme)) <> 0) then
          FToken.Kind := tkRealConstant
        else
          if length(FToken.Lexeme) > 18 then
            FToken.Kind := tkRealConstant
          else
            FToken.Kind := tkIntegerConstant;
        if FToken.Kind = tkRealConstant then
          FToken.RealValue := StrToFloat(FToken.Lexeme)
        else
          FToken.IntegerValue := StrToInt64(FToken.Lexeme);
        exit;
      end;
      '(' :
        if (LenLine > First) and (Line[First + 1] = '*') then // Comment Style (*
          FindEndComment('(*', '*)')
        else begin
          FToken.Lexeme := '(';
          FToken.Kind   := tkSpecialSymbol;
          inc(First);
          exit
        end;
      '/' :
        if (LenLine > First) and (Line[First + 1] = '/') then // Comment Style //
          First := MAXINT
        else begin
          NextChar(['=']);
          exit
        end;
      '{' :
        try
          FindEndComment('{', '}');
        except
          on EAbort do exit;
        end;
      '.' : begin NextChar(['.']); exit; end;
      '*' : begin NextChar(['*', '=']); exit; end;
      '>',
      ':' : begin NextChar(['=']); exit; end;
      '<' : begin NextChar(['=', '>']); exit; end;
      '$' : begin // Hexadecimal
        ScanChars([['$'], ['0'..'9', 'A'..'F', 'a'..'f']], [1, 16]);
        FToken.Kind := tkIntegerConstant;
        FToken.IntegerValue := StrToInt64(FToken.Lexeme);
        exit;
      end;
      '%' : begin // Binary and Compiler Info
        ScanChars([['%'], ['0', '1']], [1, 32]);
        if length(FToken.Lexeme) > 1 then begin
          FToken.Kind := tkIntegerConstant;
          FToken.IntegerValue := 0;
          for I := length(FToken.Lexeme) downto 2 do
            if FToken.Lexeme[I] = '1' then
              inc(FToken.IntegerValue, trunc(Power(2, length(FToken.Lexeme) - I)));
        end
        else
          GetCompilerInfo;
        exit;
      end;
    else
      inc(First);
      if not EOF(Arq[Include]) and not Skip then begin
        Token.Lexeme := Line[First-1];
        Error('Invalid character "' + Line[First-1] + '" ($' + IntToHex(ord(Line[First-1]), 4) + ')');
      end;
    end;
  end;
end;

procedure TScanner.Error(const Msg : AnsiString);
const
  LastColNumber  : integer = 0;
  LastLineNumber : integer = 0;
  LastSourceName : AnsiString  = '';
  LastError      : char = #0;
begin
  if ((LastColNumber = ColNumber) or (LastError = ErrorCode[1])) and
      (LastLineNumber = LineNumber) and (LastSourceName = SourceName) then
    NextToken // Prevents locks in the same error
  else begin
    ShowMessage('Error', Msg);
    inc(FErrors);
    if FErrors >= FMaxErrors then FEndSource := true;
    LastColNumber  := ColNumber;
    LastLineNumber := LineNumber;
    LastSourceName := SourceName;
    LastError      := ErrorCode[1];
  end;
end;

function ReplaceSpecialChars(const S : AnsiString) : AnsiString;
var
  I : integer;
begin
  Result := '';
  for I := 1 to length(S) do
    if S[I] >= ' ' then
      Result := Result + S[I]
    else
      Result := Result + '#' + IntToStr(byte(S[I]));
end;

procedure TScanner.RecoverFromError(const Expected, Found : AnsiString); begin
  if Expected <> '' then Error(Expected + ' not found, but "' + ReplaceSpecialChars(Found) + '" found');
end;

procedure TScanner.MatchTerminal(KindExpected : TTokenKind); begin
  if DoNextToken then NextToken;
  if KindExpected = FToken.Kind then begin
    LastGoodTop := Top;
    DoNextToken := true;
  end
  else begin
    ErrorCode := IntToStr(ord(ErrorCode[1])) + '.' + IntToStr(byte(KindExpected));
    RecoverFromError(Kinds[KindExpected], FToken.Lexeme);
  end;
end;

procedure TScanner.MatchToken(const TokenExpected : AnsiString); begin
  if DoNextToken then NextToken;
  if TokenExpected = UpperCase(FToken.Lexeme) then begin
    LastGoodTop := Top;
    DoNextToken := true;
  end
  else begin
    ErrorCode := IntToStr(ord(ErrorCode[1])) + '.' + IntToStr(byte(TokenExpected[1]));
    RecoverFromError('"' + TokenExpected + '"', FToken.Lexeme)
  end;
end;

procedure TScanner.SetDelphiMode;
var
  I : Integer;
begin
  ReservedWords.DelimitedText := DelphiReservedWords;
  I := pos('{[}', Productions[Directives[2]]);
  if I <> 0 then begin
    Productions[ExternalDir[2]] := OrigExternalDir;
    Productions[Directives[2]]  := OrigDirectives;
  end;
end;

procedure TScanner.ChangeLanguageMode(FPC : boolean); begin
  if FPCMode = FPC then exit;
  FPCMode := FPC;
  if FPC then begin
    ReservedWords.DelimitedText := DelphiReservedWords + FPCReservedWords;
    if pos('{[}', Productions[Directives[2]]) = 0 then begin
      Productions[ExternalDir[2]] := Productions[ExternalDir[2]] + '{CVAR};' + ExternalDir;
      Productions[Directives[2]]  := Productions[Directives[2]] + '{[}' + Skip + ']' + Mark + ';';
    end;
  end
  else
    SetDelphiMode;
end;

function TScanner.CharToTokenKind(N : char) : TTokenKind; begin
  Result := TTokenKind(byte(N) - byte(pred(Ident)))
end;

function TScanner.TokenKindToChar(T : TTokenKind) : char; begin
  Result := char(byte(T) + byte(pred(Ident)))
end;

function TScanner.StringToTokenKind(S : string; Default : TTokenKind = tkUndefined) : TTokenKind; begin
  Result := TTokenKind(AnsiIndexText(S, Kinds));
  if Result = TTokenKind(-1) then Result := Default;
end;

function TScanner.GetFLineNumber: integer; begin
  Result := FLineNumber[Include]
end;

function TScanner.GetFSourceName: AnsiString; begin
  Result := FSourceName[Include]
end;

function TScanner.GetNonTerminalName(N : char): AnsiString; begin
  Result := Kinds[CharToTokenKind(N)]
end;

procedure TScanner.CreateMacro;
var
  Macro : AnsiString;
begin
  Macro := FToken.Lexeme;
  SkipBlank;
  ScanChars([[':'], ['=']], [1, 1]);
  if FToken.Lexeme <> '' then begin
    SkipBlank;
    ScanChars([[#1..#255] - ['}']], [50000]);
    if Macros = nil then Macros := TStringList.Create;
    Macros.Add(Macro + '=' + FToken.Lexeme);
  end;
end;

end.

