unit mouse;

interface

uses dos,graph,crt;

type TShape = record
                  HotX, HotY: Byte;
		  Data: array[1..64] of byte;
         end;
     TPOINT = record
            x,y:integer;
            end;
     TRECT = record
           a,b:tpoint;
           end;

var R: Registers;
    P: TPoint;
    Shape: TShape;
    gd,gm:integer;
    s1,s2:string;
    re:trect;

procedure Init;
function X: Word;
function Y: Word;
procedure Show;
function LeftButtonPressed: Boolean;
function RightButtonPressed: Boolean;
function CenterButtonPressed: Boolean;
function Buttonreleased(button:byte): Boolean;
function LeftButtonStroked: Boolean;
function RightButtonStroked: Boolean;
function CenterButtonStroked: Boolean;
procedure LoadShape(NumeFisier: string);
procedure SetShape;
procedure SetPos(Point: TPoint);
procedure SetRange(Rect: TRect);
procedure CopyCoord;
procedure Hide;
procedure Done;


implementation

procedure Init;
begin
	R.AX := 0;
    Intr($33, R);
    if R.AX = 0
    then begin
			WriteLn('error: mouse not instaled');
			Halt(1);
		 end;
end;

function X: Word;
begin
	R.AX := 3;
	Intr($33, R);
	X := R.CX;
end;

function Y: Word;
begin
	R.AX := 3;
	Intr($33, R);
	Y := R.DX;
end;

function LeftButtonPressed: Boolean;
begin
	R.AX := 3;
	Intr($33, R);
	LeftButtonPressed := R.BX mod 2 = 1;
end;

function RightButtonPressed: Boolean;
begin
	R.AX := 3;
	Intr($33, R);
	RightButtonPressed := (R.BX div 2) mod 2 = 1;
end;

function CenterButtonPressed: Boolean;
begin
	R.AX := 3;
	Intr($33, R);
	CenterButtonPressed := (R.BX div 4) mod 2 = 1;
end;

function Buttonreleased(button:byte): Boolean;
begin
	R.AX := $6;
    R.BX := Button;
    Intr($33, R);
    ButtonReleased := R.BX <> 0;
end;

function LeftButtonStroked: Boolean;
var Bool: Boolean;
begin
    Bool := ButtonReleased(0);
    if LeftButtonPressed
    then begin
			repeat until ButtonReleased(0);
			LeftButtonStroked := True;
		 end
	else LeftButtonStroked := False;
end;

function RightButtonStroked: Boolean;
var Bool: Boolean;
begin
    Bool := ButtonReleased(1);
    if LeftButtonPressed
    then begin
			repeat until ButtonReleased(1);
			RightButtonStroked := True;
		 end
	else RightButtonStroked := False;
end;

function CenterButtonStroked: Boolean;
var Bool: Boolean;
begin
    Bool := ButtonReleased(2);
    if LeftButtonPressed
    then begin
			repeat until ButtonReleased(2);
			CenterButtonStroked := True;
		 end
	else CenterButtonStroked := False;
end;

procedure Show;
begin
	R.AX := $0001;
	Intr($33, R);
end;

procedure Hide;
begin
	R.AX := $0002;
    Intr($33, R);
end;

procedure LoadShape(NumeFisier: string);
var f: file;
begin
    Assign(f, NumeFisier);
	Reset(f, 1);
    BlockRead(f, Shape, 66);
	Close(f);
end;

procedure SetShape;
begin
    with Shape do
    	begin
        	R.BX := HotX;
            R.CX := HotY;
            R.ES := Seg(Data);
            R.DX := Ofs(Data);
            R.AX := 9;
            Intr($33, R);
        end
end;

procedure SetRange(Rect: TRect);
begin
	R.AX := 7;
 	R.CX := Rect.A.X;
	R.DX := Rect.B.X;
    Intr($33, R);
	R.AX := 8;
 	R.CX := Rect.A.Y;
	R.DX := Rect.B.Y;
    Intr($33, R);
end;

procedure SetPos(Point: TPoint);
begin
	R.AX := 4;
 	R.CX := Point.X;
    R.DX := Point.Y;
	Intr($33, R);
end;

procedure CopyCoord;
begin
  P.X := X;
  P.Y := Y;
end;

procedure Done;
begin
	Hide;
end;

end.
