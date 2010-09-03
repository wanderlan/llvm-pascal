unit Test02;

interface

uses
  Messages;

type
  TTest02 = class
  public
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  end;

implementation

{ TFoo }

procedure TTest02.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
end;

end.
