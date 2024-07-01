program scenary_ed;
uses graph,crt;
type scene = record
           base:array[1..4,1..5] of integer;
           peisaj:array[1..60,1..2] of integer;
           maxp:integer;
           color:integer;
           maxenemy:integer;
           end;
var x,y,oldx,oldy:integer;
    ch:char;
    xb,yb,gd,gm:integer;
    cnt:integer;
    f:file of scene;
    edit:scene;
    pcnt,bcnt:integer;

procedure outintxy(x,y:integer;z:integer);
var mnv:string;
begin
str(z,mnv);
outtextxy(x,y,mnv);
end;
begin
gd:=detect;
initgraph(gd,gm,'c:\bin\tp7\bgi');
x:=100;oldx:=15;
cnt:=0;pcnt:=1;bcnt:=0;
y:=100;oldy:=450;
edit.peisaj[pcnt,1]:=oldx;
edit.peisaj[pcnt,2]:=oldy;
assign(f,'scenery.arm');
reset(f);
seek(f,filesize(f));
setfillstyle(1,darkgray);
bar(0,0,640,480);
setfillstyle(1,black);
bar(15,15,625,465);
setcolor(lightgray);

repeat
if keypressed then ch:=readkey
              else ch:=#0;
case ch of
'o': begin
     setcolor(black);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     dec(x,2);
     if x<15 then x:=15;
     setcolor(yellow);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     end;
'p': begin
     setcolor(black);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     inc(x,2);
     if x>500 then x:=500;
     setcolor(yellow);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     end;
'z': begin
     setcolor(black);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     inc(y,2);
     if y>465 then y:=465;
     setcolor(yellow);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     end;
'q': begin
     setcolor(black);
     outintxy(0,0,x);
     outintxy(100,0,y);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     dec(y,2);
     if y<15 then y:=15;
     setcolor(yellow);
     outintxy(0,0,x);
     outintxy(100,0,y);
     line(x,y,oldx,oldy);
     end;
'e': begin
     inc(pcnt);
     edit.peisaj[pcnt,1]:=edit.peisaj[1,1];
     edit.peisaj[pcnt,2]:=edit.peisaj[1,2];
     ch:=#27;
     end;
' ': begin
     inc(pcnt);
     edit.peisaj[pcnt,1]:=x;
     edit.peisaj[pcnt,2]:=y;
     oldx:=x;
     oldy:=y;
     end;
end;
until ch=#27;
edit.maxp:=pcnt;
edit.color:=brown;
{baze}
bcnt:=0;
setfillstyle(1,yellow);
setcolor(yellow);
setwritemode(xorput);
rectangle(x,y,x+60,y+30);
repeat
if keypressed then ch:=readkey
              else ch:=#0;
case ch of
'o': begin
     rectangle(x,y,x+60,y+30);
     dec(x);
     if x<15 then x:=15;
     rectangle(x,y,x+60,y+30);
     end;
'p': begin
     rectangle(x,y,x+60,y+30);
     inc(x);
     if x>500 then x:=500;
     rectangle(x,y,x+60,y+30);
     end;
'z': begin
     rectangle(x,y,x+60,y+30);
     inc(y);
     if y>465 then y:=465;
     rectangle(x,y,x+60,y+30);
     end;
'q': begin
     rectangle(x,y,x+60,y+30);
     dec(y);
     if y<15 then y:=15;
     rectangle(x,y,x+60,y+30);
     end;
'e': begin
     ch:=#27;
     end;
' ': begin
     inc(bcnt);
     edit.base[bcnt,2]:=x;
     edit.base[bcnt,3]:=y;
     edit.base[bcnt,1]:=1;
     edit.base[bcnt,4]:=50;
     edit.base[bcnt,5]:=0;
     bar(x,y,x+60,y+30);
     end;
end;
until (ch=#27) or (bcnt=4);

if bcnt=4 then write(f,edit);

close(f);

end.


