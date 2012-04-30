unit SymbolTable;

interface

uses
  SysUtils, Contnrs, Token;

const
  TABLE_SIZE = 196613; // 393241

type
  TSymbolTable = class
  private
    Table   : array[0..TABLE_SIZE - 1] of PToken;
    Stack   : TStack;
    Current : Integer;
    Scope   : Word;
  public
    constructor Create;
    destructor Destroy; override;
    function GetHash(Name : string) : Cardinal;
    function Get(Name : string) : PToken;
    function Count : Integer;
    procedure Add(Token : TToken);
    procedure Delete(Token : TToken);
    procedure PushScope;
    procedure PopScope;
    function Last : PToken;
    function Previous : PToken;
    property Tokens[Name : string] : PToken read Get; default;
  end;
  ESymbolTable = Exception;

implementation

function Hash(const S : string) : Cardinal;
var
  A : Cardinal;
  I : Integer;
begin
  Result := 0;
  A      := 63689;
  for I := 1 to Length(S) do begin
    Result := Result * A + Ord(UpCase(S[I]));
    A      := A * 378551;
  end;
  Result := Result mod TABLE_SIZE;
end;

function TSymbolTable.GetHash(Name : string) : Cardinal; begin
  Result := Hash(Name);
  while (Table[Result] <> nil) and (Table[Result].Lexeme <> Name) do
    Result := (Result + 1) mod TABLE_SIZE;
end;

function TSymbolTable.Get(Name : string) : PToken; begin
  Result := Table[GetHash(Name)];
end;

function TSymbolTable.Count : Integer; begin
  Result := Stack.Count - Scope;
end;

constructor TSymbolTable.Create; begin
  Stack := TStack.Create;
end;

destructor TSymbolTable.Destroy; begin
  while Stack.Count <> 0 do TToken(Stack.Pop).Free;
  Stack.Free;
	 inherited;
end;

procedure TSymbolTable.Add(Token : TToken);
var
  H : Cardinal;
begin
  if Count >= TABLE_SIZE then raise ESymbolTable.Create('Symbol table is full."');
	 H := Hash(Token.Lexeme);
  Token.Scope := Scope;
  while Table[H] <> nil do begin
    if Table[H].Lexeme = Token.Lexeme then begin
      if Table[H].Scope = Token.Scope then
        raise ESymbolTable.CreateFmt('Duplicate identifier "%s".', [Token.Lexeme])
      else
        Token.NextScope := Table[H];
      break;
    end
    else
      H := (H + 1) mod TABLE_SIZE;
  end;
  Table[H] := @Token;
  Stack.Push(@Token);
end;

procedure TSymbolTable.Delete(Token : TToken);
var
  H : Cardinal;
begin
	 H := GetHash(Token.Lexeme);
  if Table[H] = nil then
    raise ESymbolTable.CreateFmt('Trying to delete nonexistent identifier "%s".', [Token.Lexeme])
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
  dec(Scope);
end;

function TSymbolTable.Last : PToken; begin
  Current := Stack.Count - 1;
  Result  := Stack.Peek;
end;

type
  THackStack = class(TStack);

function TSymbolTable.Previous : PToken; begin
  if THackStack(Stack).List[Current] <> nil then dec(Current);
  Result := THackStack(Stack).List[Current];
end;

end.
