PROGRAM zba;
uses graph;
type zbase=array[0..29,0..59] of byte;
     buffer=array[1..1024] of byte;
     buf=^buffer;
var fil:file of zbase;
    zb:zbase;
    gd,gm,i,j:integer;
    f:file;
    pass:buf;
begin
gd:=detect;
initgraph(gd,gm,'c:\tp60\bgi');
assign(f,'c:\tp60\arma\base.zpx');
reset(f,1024);
new(pass);
blockread(f,pass^,1,gm);
putimage(0,0,pass^,0);
for i:=0 to 29 do
for j:=0 to 59 do
zb[i,j]:=getpixel(j,i);
assign(fil,'c:\tp60\arma\zbase.zpx');
rewrite(fil);
write(fil,zb);
readln;
end.