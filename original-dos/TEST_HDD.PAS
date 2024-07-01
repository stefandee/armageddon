program testhdd;
uses dos,graph,crt;
type sprite=array[1..512] of byte;
     buf=^sprite;

var i,spr:integer;
    gd,gm:integer;
    hdd1,hdd2,hdd3,hdd4,hdd5,hdd6,hdd7:buf;
    f:file;

begin

gd:=detect;
initgraph(gd,gm,'c:\bin\tp7\bgi');

new(hdd1);new(hdd2);new(hdd3);new(hdd4);new(hdd5);new(hdd6);new(hdd7);
assign(f,'hdd1.zpx');
reset(f,512);
blockread(f,hdd1^,1);
close(f);
assign(f,'hdd2.zpx');
reset(f,512);
blockread(f,hdd2^,1);
close(f);
assign(f,'hdd3.zpx');
reset(f,512);
blockread(f,hdd3^,1);
close(f);
assign(f,'hdd4.zpx');
reset(f,512);
blockread(f,hdd4^,1);
close(f);
assign(f,'hdd5.zpx');
reset(f,512);
blockread(f,hdd5^,1);
close(f);
assign(f,'hdd6.zpx');
reset(f,512);
blockread(f,hdd6^,1);
close(f);
assign(f,'hdd7.zpx');
reset(f,512);
blockread(f,hdd7^,1);
close(f);



spr:=0;
for i:=400 downto 400-20 do
    begin
    inc(spr);
    case spr of
    1,2,3:putimage(i,100,hdd1^,0);
    4,5,6:putimage(i,100,hdd2^,0);
    7,8,9:putimage(i,100,hdd3^,0);
    10,11,12:putimage(i,100,hdd4^,0);
    13,14,15:putimage(i,100,hdd5^,0);
    16,17,18:putimage(i,100,hdd6^,0);
    19,20,21:putimage(i,100,hdd7^,0);
    end;
    delay(30);
    if spr>20 then spr:=0;
    end;
repeat until readkey=#13;
end.
