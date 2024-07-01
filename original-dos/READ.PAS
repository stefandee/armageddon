program read;
uses graph,crt;
var i,j,ox,oxi,oyi,s,oy,gd,gm,rd:integer;
label other;
begin
gd:=detect;
initgraph(gd,gm,'c:\tp60');
setfillstyle(1,brown);
bar(0,getmaxy-50,getmaxx,getmaxy);
repeat
setcolor(15);
ox:=random(getmaxx);
oxi:=ox;
oy:=0;
oyi:=oy;
for i:=1 to 480 do begin
setcolor(15);
            dec(ox);
            if ox<0 then begin
                         setcolor(0);
                         line(oxi,oyi,ox,i);
                         ox:=getmaxx;
                         oxi:=ox;
                         oyi:=i;
                         end;
            inc(oy);
            line(oxi,oyi,ox,i);
{if s=0 then begin
            inc(ox);
            if ox>getmaxx then begin
                               setcolor(0);
                               line(oxi,oyi,ox,oy);
                               ox:=0;
                               oxi:=ox;
                               oyi:=i;
                               end;
            inc(i);
            line(oxi,oyi,ox,i);
            end;}
if getpixel(ox-1,i+1)=brown then begin
                              setcolor(0);
                              line(oxi,oyi,ox,i);
                              setfillstyle(1,0);
                              fillellipse(ox,i,15,15);
                              goto other;
                              end;
end;
other:until 1=0;
end.