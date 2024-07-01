program testhelp;
uses dos,graph,crt;
type sprite=array[1..512] of byte;
     buf=^sprite;

var i,spr:integer;
    gd,gm:integer;
    help1,help2,help3,help4,help5:buf;
    f:file;

begin

gd:=detect;
initgraph(gd,gm,'c:\bin\tp7\bgi');

new(help1);new(help2);new(help3);new(help4);new(help5);
assign(f,'help1.zpx');
reset(f,512);
blockread(f,help1^,1);
close(f);
assign(f,'help2.zpx');
reset(f,512);
blockread(f,help2^,1);
close(f);
assign(f,'help3.zpx');
reset(f,512);
blockread(f,help3^,1);
close(f);
assign(f,'help4.zpx');
reset(f,512);
blockread(f,help4^,1);
close(f);
assign(f,'help5.zpx');
reset(f,512);
blockread(f,help5^,1);
close(f);


spr:=0;
for i:=400 downto 100 do
    begin
    inc(spr);
    case spr of
    1,2:putimage(i,100,help1^,0);
    3,4:putimage(i,100,help2^,0);
    5,6:putimage(i,100,help3^,0);
    7,8:putimage(i,100,help4^,0);
    9,10:putimage(i,100,help5^,0);
    end;
    delay(50);
    if spr>9 then spr:=0;
    end;
end.
