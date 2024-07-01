program testhelp;
uses dos,graph,crt;
type sprite=array[1..512] of byte;
     buf=^sprite;

var i,spr:integer;
    gd,gm:integer;
    f1,f2,f3,f4,f5:buf;
    f:file;

begin

gd:=detect;
initgraph(gd,gm,'c:\bin\tp7\bgi');

new(f1);new(f2);new(f3);new(f4);new(f5);
assign(f,'f1.zpx');
reset(f,512);
blockread(f,f1^,1);
close(f);
assign(f,'f2.zpx');
reset(f,512);
blockread(f,f2^,1);
close(f);
assign(f,'f3.zpx');
reset(f,512);
blockread(f,f3^,1);
close(f);
assign(f,'f4.zpx');
reset(f,512);
blockread(f,f4^,1);
close(f);
assign(f,'f5.zpx');
reset(f,512);
blockread(f,f5^,1);
close(f);



spr:=0;
for i:=400 downto 100 do
    begin
    inc(spr);
    case spr of
    1,2,3:putimage(i,100,f1^,0);
    4,5,6:putimage(i,100,f2^,0);
    7,8,9:putimage(i,100,f3^,0);
    10,11,12:putimage(i,100,f4^,0);
    13,14,15:putimage(i,100,f5^,0);
    end;
    delay(30);
    if spr>14 then spr:=0;
    end;
end.
