settextstyle(7,0,0);
setusercharsize(5,2,5,2);
setrgbpalette(blue,0,0,0);
setcolor(blue);
outtextxy(50,30,'ARMAGEDON');
for i:=0 to 63 do
begin
delay(2);
setrgbpalette(blue,i,i,i);
end;
setcolor(lightblue);
j:=63;
for i:=20 to getmaxx-100 do
begin
moveto(i,120);
linerel(-3,3);
if (int(i/10)=i/10) and (j>0) then begin
                                    dec(j);
                                    setrgbpalette(blue,j,j,63);
                                    end;
delay(2);
end;
putimage(getmaxx-100,110,cometa^,0);
settextstyle(2,0,1);
setcolor(yellow);
for j:=0 to 3 do begin
setusercharsize(3,1,j,1);
setcolor(14);
outtextxy(getmaxx div 2-textwidth('A')*12,150-textheight('A'),'This battle never ends.');
delay(50);
setcolor(0);
outtextxy(getmaxx div 2-textwidth('A')*12,150-textheight('A'),'This battle never ends.');
end;
setcolor(14);
outtextxy(getmaxx div 2-textwidth('A')*12,150-textheight('A'),'This battle never ends.');
assign(fil,'bfw.zpx');
reset(fil);
new(workp);
blockread(fil,workp^,160,rd);
putimage(140,200,workp^,0);
setcolor(12);
settextstyle(0,0,2);
repeat
setcolor(yellow);
outtextxy(getmaxx div 2-textwidth('A')*11,200+150,'Push 1P or 2P to start');
delay(190);
setcolor(0);
outtextxy(getmaxx div 2-textwidth('A')*11,200+150,'Push 1P or 2P to start');
delay(150);
if keypressed then begin
                   key:=readkey;
                   if key='1' then player1:=true;
                   if key='2' then player2:=true;
                   end;
until (key='1') or (key='2');
END;
