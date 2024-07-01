program mt;
uses crt,mouse,graph;
var gd,gm:integer;
    m:string;
begin
gd:=detect;
initgraph(gd,gm,'c:\bin\tp7\bgi');
init;
setfillstyle(1,black);
repeat
bar(0,0,100,100);
str(x,m);
outtextxy(0,0,m);
str(y,m);
outtextxy(0,50,m);
until keypressed;
end.