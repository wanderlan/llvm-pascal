program Test06;
var
  S : string;
begin
  S := '''ABC''abcd''asas';
  S := #13#10'''';
  S := #39'ABC'#39;
  S := #39+'ABC'#39;
  S := #39'ABC'+#39;
  S := 'A'#13#10'B'#13#10'C';
  S := 'A'#$A'B';
end.
