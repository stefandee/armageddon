unit VGA256;

INTERFACE

uses dos;
procedure INITVGA;
procedure SCRSHOW(filename:string;posit:longint);
procedure CEL22(filename:string);
procedure CLOSEVGA;
procedure CLS;
IMPLEMENTATION

type buffer=array[1..800] of byte;
     buf=^buffer;

var screen:array[1..200,1..320] of byte absolute $a000:$0;
    rd,i,j:integer;
    color:array[0..255,1..3] of byte;
    fils,fild:file;
    pass:buf;

procedure xsetcolor(cul:byte;re,gr,blu:byte);

begin

port[$3c8]:=cul;
port[$3c9]:=re;
port[$3c9]:=blu;
port[$3c9]:=gr;

end;

procedure INITVGA;

begin
asm
mov ax,13h
int 10h
mov ax,0a000h
mov es,ax
end;
end;

procedure SCRSHOW;

VAR
   r:registers;

begin

assign(fils,filename);
reset(fils,1);
seek(fils,posit);
blockread(fils,color,768,rd);
     r.ax:=$1012;
     r.es:=seg(color);
     r.dx:=ofs(color);
     r.bx:=0;
     r.cx:=256;
     intr($10,r);

blockread(fils,screen,64000,rd);
close(fils);

end;

procedure CLOSEVGA;

begin
asm
mov ax,3
int 10h
end;
end;

procedure CEL22;

begin
assign(fild,filename+'.2');
assign(fils,filename+'.cel');
rewrite(fild,800);
reset(fils,800);
blockread(fils,pass^,1,rd);
for i:=1 to 80 do begin
blockread(fils,pass^,1,rd);
blockwrite(fild,pass^,1,rd);
end;
close(fils);
close(fild);
assign(fils,filename+'.col');
rename(fils,filename+'.1');
end;

procedure CLS;

begin
xsetcolor(0,0,0,0);
for i:=1 to 200 do
for j:=1 to 320 do
screen[i,j]:=0;
for i:=0 to 255 do xsetcolor(i,0,0,0);
end;
end.
