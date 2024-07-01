program view_compress;
uses graph;
var fs,fd:file of byte;
    gd,gm,i,j,min,cnt:integer;
    k,s:longint;
    b1,b2,b3,mask,nr:byte;
    pal:array[1..256,1..3] of byte;
    hist:array[1..256] of integer;
    s1,s2:string;

label x;
begin
assign(fs,'arm5.1');
reset(fs);
gd:=installuserdriver('vga256',nil);
initgraph(gd,gm,'c:\bin\tp7\bgi');
for i:=0 to 255 do
    begin
         read(fs,pal[i+1,1]);
         read(fs,pal[i+1,2]);
         read(fs,pal[i+1,3]);
    end;
assign(fs,'arm5.2');
reset(fs);
{for j:=0 to 199 do
    for i:=0 to 319 do
        begin
             read(f,b1);
             setcolor(b1);
             putpixel(i,j,b1);
        end;}

{compress begins here}
{making histogram}
setcolor(100);
outtextxy(100,100,'making histogram...');
for i:=1 to 256 do hist[i]:=0;
for k:=0 to 63999 do
    begin
         read(fs,b1);
         inc(hist[b1+1]);
    end;
outtextxy(100,110,'chosing mask...');
min:=30000;
for i:=1 to 256 do
    if hist[i]<=min then begin
                         min:=hist[i];
                         mask:=i-1;
                         end;
str(mask,s1);
str(min,s2);
outtextxy(100,120,'mask is '+s1+'X'+s2);
outtextxy(100,130,'compressing...');
assign(fd,'arm5.cpr');
rewrite(fd);
write(fd,mask);
reset(fs);
setcolor(red);
rectangle(50,151,250,161);
repeat
read(fs,b1);
if eof(fs) then goto x;
nr:=1;
read(fs,b2);
if eof(fs) then goto x;
while (b2=b1) and (not eof(fs)) and (nr<255) do
begin
inc(nr);
read(fs,b2);
if eof(fs) then goto x;
end;
setfillstyle(1,black);
str(nr,s2);
str(b1,s1);
bar(110,141,180,150);
outtextxy(110,141,s1+' X '+s2);
setfillstyle(1,red);
bar(50,151,50+round(filepos(fs)*200/filesize(fs)),161);
if nr=1 then begin
             write(fd,b1);
             s:=filepos(fs)-1;
             seek(fs,s);
             end
        else begin
             write(fd,mask);
             write(fd,b1);
             write(fd,nr);
             s:=filepos(fs)-1;
             seek(fs,s);
             end;
until eof(fs);

x:close(fs);close(fd);
setcolor(100);
outtextxy(100,161,'task ended.');
readln;
closegraph;
end.

