unit SymbolTable;

interface

uses
  Contnrs, Token, Scanner;

const
  TABLE_SIZE = 98317; // 49157; 6151; 196613; 393241

type
  TSymbolTable = class
  private
    Table   : array[0..TABLE_SIZE - 1] of TToken;
    Stack   : TStack;
    Current : Integer;
    Scope   : Word;
    function Hash(const S : string) : Cardinal;
  public
    constructor Create;
    destructor Destroy; override;
    function GetHash(Name : string) : Cardinal;
    function Get(Name : string) : TToken;
    function Count : Integer;
    procedure Add(Token : TToken);
    procedure Delete(Token : TToken);
    procedure PushScope;
    procedure PopScope;
    function Last : TToken;
    function Previous : TToken;
    property Tokens[Name : string] : TToken read Get; default;
  end;

implementation

uses
  CompilerUtils;

{$R-,O-}
function TSymbolTable.Hash(const S : string) : Cardinal;
var // Jenkins
  I : Cardinal;
begin
  Result := 0;
  for I := 1 to Length(S) do begin
    inc(Result, (Result + ord(UpCase(S[I]))) shl 10);
    Result := Result xor (Result shr 6);
  end;
  inc(Result, Result shl 3);
  Result := Result xor (Result shr 11);
  Result := ((Result + (Result shl 15)) + ord(S[length(S)]) * 2) mod TABLE_SIZE;
end;
{$R+,O+}

function TSymbolTable.GetHash(Name : string) : Cardinal; begin
  Result := Hash(Name);
  while (Table[Result] <> nil) and (LowerCase(Table[Result].Lexeme) <> LowerCase(Name)) do
    Result := (Result + 1) mod TABLE_SIZE;
end;

function TSymbolTable.Get(Name : string) : TToken; begin
  Result := Table[GetHash(Name)];
end;

function TSymbolTable.Count : Integer; begin
  Result := Stack.Count - 1 - Scope;
end;

constructor TSymbolTable.Create; begin
  Stack := TStack.Create;
  Stack.Push(nil);
end;

destructor TSymbolTable.Destroy; begin
  while Stack.Count <> 0 do TToken(Stack.Pop).Free;
  Stack.Free;
	inherited;
end;

{$R-,O-}
procedure TSymbolTable.Add(Token : TToken);
var
  H : Cardinal;
begin
  if Count >= TABLE_SIZE then raise EFatal.Create('Symbol table is full');
  H := Hash(Token.Lexeme);
  Token.Scope := Scope;
  while Table[H] <> nil do
    if LowerCase(Table[H].Lexeme) = LowerCase(Token.Lexeme) then begin
      if Table[H].Scope = Token.Scope then
        raise EError.CreateFmt('Identifier redeclared "%s"', [Token.Lexeme])
      else
        Token.NextScope := Table[H];
      break;
    end
    else
      H := (H + 1) mod TABLE_SIZE;
  Token.Hash := H;
  Table[H] := Token;
  Stack.Push(Token);
end;
{$R+,O+}

procedure TSymbolTable.Delete(Token : TToken);
var
  H : Cardinal;
begin
  H := Token.Hash;
  if (H >= TABLE_SIZE) or (Table[H] = nil) or
     (LowerCase(Table[H].Lexeme) <> LowerCase(Token.Lexeme)) then
    raise EFatal.CreateFmt('Trying to delete invalid token "%s", possibly data corruption', [Token.Lexeme])
  else
    Table[H] := Table[H].NextScope;
  Token.Free;
end;

procedure TSymbolTable.PushScope; begin
  inc(Scope);
  Stack.Push(nil);
end;

procedure TSymbolTable.PopScope; begin
  while Stack.Peek <> nil do Delete(TToken(Stack.Pop));
  Stack.Pop;
  if Scope > 0 then dec(Scope);
end;

function TSymbolTable.Last : TToken; begin
  Current := Stack.Count - 1;
  Result  := Stack.Peek;
end;

type
  THackStack = class(TStack);

function TSymbolTable.Previous : TToken; begin
  if Current >= 0 then begin
    if THackStack(Stack).List[Current] <> nil then dec(Current);
    Result := THackStack(Stack).List[Current];
  end
  else
    Result := nil;
end;

end.
