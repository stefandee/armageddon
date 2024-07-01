program armag;
{$M 32767,0,655360}
{$F+}

uses graph,crt,game,vga256,wav,sbdsp,dos;
const       pal:array[1..16,1..4] of integer=(
                                         {black}      (0,0,0,0),
                                         {blue}       (1,0,0,31),
                                         {green}      (2,0,31,0),
                                         {cyan}       (3,0,31,31),
                                         {red}        (4,31,0,0),
                                         {magenta}    (5,31,0,31),
                                         {brown}      (6,31,15,0),
                                         {lightgray}  (7,31,31,31),
                                         {darkgray}   (56,15,15,15),
                                         {lightblue}  (57,0,0,63),
                                         {lightgreen} (58,0,63,0),
                                         {lightcyan}  (59,0,63,63),
                                         {lightred}   (60,63,0,0),
                                         {lightmagenta}(61,63,0,63),
                                         {yellow}      (62,63,63,0),
		                         {white}       (63,63,63,63));
type bbuffer=array[1..23296] of byte;
     bbuf=^bbuffer;
     lbuffer=array[1..2048] of byte;
     lbuf=^lbuffer;
var gd,gm,rd:integer;
    workp:bbuf;
    mnv,blast_env : string;
    sb_digit : byte;


procedure egavga;external;
{$L c:\bin\bp\bgi\egavga.obj}
procedure sans;external;
{$L c:\bin\bp\bgi\sans.obj}
procedure tscr;external;
{$L c:\bin\bp\bgi\tscr.obj}


procedure WAITKEY;
begin
repeat
until readkey=#13;
end;
procedure FONDU;
var wp:array[1..16,1..4] of integer;
    i,j:integer;
begin
for i:=1 to 16 do begin
wp[i,1]:=pal[i,1];
wp[i,2]:=pal[i,2];
wp[i,3]:=pal[i,3];
wp[i,4]:=pal[i,4];
end;
for j:=0 to 13 do begin
for i:=2 to 16 do begin
if wp[i,2]>5 then dec(wp[i,2],6);
if wp[i,3]>5 then dec(wp[i,3],6);
if wp[i,4]>5 then dec(wp[i,4],6);
setrgbpalette(wp[i,1],wp[i,2],wp[i,3],wp[i,4]);
end;
end;
cleardevice;
end;
procedure PALREC;
var i:integer;
begin
for i:=1 to 16 do begin
setpalette(i-1,pal[i,1]);
setrgbpalette(pal[i,1],pal[i,2],pal[i,3],pal[i,4]);
end;
end;
procedure BFWSHOW;
var t:psnd;
    l,introf:word;
begin

new(t);
l:=52192-44;
load('armaged.arm',t,122692,l,introf);
cleardevice;
assign(fil,'armaged.ARM');
reset(fil);
new(workp);
blockread(fil,workp^,160,rd);
putimage(getmaxx div 2-160,getmaxy div 2-80,workp^,0);
close(fil);
{init_play(t,l,introf);}
{wav_play;}
if device=blaster
   then begin
        speakeron;
        setmixerreg(sbbase,$04,vol);
        setmixerreg(sbbase,$22,vol);
        playback(t,l,introf);
        end;
dispose(t);
dispose(workp);
{repeat until readkey=#13;}
delay(3000);
fondu;
cleardevice;
palrec;
end;
procedure PRESENT;
const subtxt:string='The neverending war';
var   stars:array[1..70,1..2] of integer;
      starcount:integer;
begin
{cleardevice;
for i:=1 to 16 do setrgbpalette(pal[i,1],0,0,0);
setbkcolor(lightred);
setfillstyle(1,1);
setcolor(lightblue);
bar(0,getmaxy-150,getmaxx,getmaxy);
moveto(0,getmaxy-150);
linerel(getmaxx,0);
bar(40,getmaxy-200,140,getmaxy-120);
rectangle(40,getmaxy-200,140,getmaxy-120);
bar(50,getmaxy-220,200,getmaxy-130);
rectangle(50,getmaxy-220,200,getmaxy-130);
bar(60,getmaxy-300,105,getmaxy-100);
rectangle(60,getmaxy-300,105,getmaxy-100);
bar(70,getmaxy-380,100,getmaxy-100);
rectangle(70,getmaxy-380,100,getmaxy-100);
bar(130,getmaxy-250,170,getmaxy-110);
rectangle(130,getmaxy-250,170,getmaxy-110);
bar(110,getmaxy-170,210,getmaxy-90);
rectangle(110,getmaxy-170,210,getmaxy-90);
for i:=1 to 31 do begin
    delay(80);
    setrgbpalette(pal[13,1],0,0,i);
end;
for i:=1 to 15 do begin
    setrgbpalette(pal[10,1],0,0,i);
end;
setrgbpalette(pal[yellow+1,1],0,0,23);
setcolor(yellow);
settextstyle(7,0,0);
setusercharsize(5,2,3,1);
for i:=0 to 60 do begin
delay(10);
setrgbpalette(pal[yellow+1,1],i,i,0);
outtextxy(140,0,'ARMAGEDON');
end;
setrgbpalette(pal[lightmagenta+1,1],0,0,63);
setcolor(lightmagenta);
for i:=130 to getmaxx-20 do begin
delay(3);
moveto(i,110);
linerel(4,-4);
end;
settextstyle(2,0,0);
for i:=1 to 30 do begin
stars[i,1]:=random(getmaxx);
stars[i,2]:=random(100);
putpixel(stars[i,1],stars[i,2],yellow);
end;
for i:=30 to 70 do begin
stars[i,1]:=random(getmaxx div 2)+getmaxx div 2;
stars[i,2]:=random(getmaxy div 2);
putpixel(stars[i,1],stars[i,2],yellow);
end;
for j:=0 to 4 do begin
setcolor(yellow);
for i:=1 to length(subtxt) do begin
setusercharsize(j,2,1,1);
outtextxy(getmaxx-250+i*12,115,subtxt[i]);
end;
delay(80);
setcolor(black);
for i:=1 to length(subtxt) do begin
outtextxy(getmaxx-250+i*12,115,subtxt[i]);
end;
end;
setcolor(yellow);
for i:=1 to length(subtxt) do begin
outtextxy(getmaxx-250+i*12,115,subtxt[i]);
end;
for i:=0 to 15 do begin
if (i<>9) and (i<>12) and (i<>1) and (i<>13) then setrgbpalette(pal[i+1,1],pal[i+1,2],pal[i+1,3],pal[i+1,4]);
end;
starcount:=1;
settextstyle(9,0,0);
setusercharsize(1,2,1,3);}
repeat
{setcolor(white);
outtextxy(getmaxx div 2-80,160,'Push 1P or 2P to start');
delay(200);
setcolor(black);
outtextxy(getmaxx div 2-80,160,'Push 1P or 2P to start');}
delay(150);
if keypressed then begin
                   key:=readkey;
                   if key=#13 then player1:=true;
                   if key='2' then player2:=true;
                   end
              else key:=#0;
{inc(starcount);
if starcount>70 then starcount:=1;
putpixel(stars[starcount,1]-1,stars[starcount,2]-1,red);
putpixel(stars[starcount,1]+1,stars[starcount,2]-1,yellow);
putpixel(stars[starcount,1]-1,stars[starcount,2]+1,yellow);
putpixel(stars[starcount,1]+1,stars[starcount,2]+1,red);
delay(120);
putpixel(stars[starcount,1]-1,stars[starcount,2]-1,black);
putpixel(stars[starcount,1]+1,stars[starcount,2]-1,black);
putpixel(stars[starcount,1]-1,stars[starcount,2]+1,black);
putpixel(stars[starcount,1]+1,stars[starcount,2]+1,black);}
until (key=#13) or (key='2');
cls;
closevga;
{cleardevice;
palrec;
setusercharsize(1,1,1,1);}
end;

function fval(str : string) : integer;
var err : integer;
    v   : integer;
begin
val(str,v,err);
fval:=v;
end;


label other;

BEGIN

if registerbgidriver(@egavga)<0 then begin
                                     clrscr;
                                     gotoxy(0,0);
                                     writeln('EXE file was damaged!');
                                     halt;
                                     end;
if registerbgifont(@sans)<0 then begin
                                     clrscr;
                                     gotoxy(0,0);
                                     writeln('EXE file was damaged!');
                                     halt;
                                     end;
if registerbgifont(@tscr)<0 then begin
                                     clrscr;
                                     gotoxy(0,0);
                                     writeln('EXE file was damaged!');
                                     halt;
                                     end;
sbbase:=0;
blast_env:=getenv('BLASTER');
if blast_env='' then begin
                     writeln('No SoundBlaster environment string found.');
                     writeln('Searching manually for SB...');
                     writeln('Possibly you have one hidden in your computer.');
                     for i:=1 to 9 do if resetdsp(i)
                         then begin
                              sbbase:=2*256+i*16+0;
                              device:=blaster;
                              writeln('Found on port $2',i,'0');
                              break;
                              end;
                     if sbbase=0
                        then begin
                             writeln('I really can''t find a blaster');
                             writeln('I will run quitely.');
                             device:=speaker;
                             end;
                    end
               else begin
                    sb_digit:=fval(blast_env[3]);
                    resetdsp(sb_digit);
                    device:=blaster;
                    sbbase:=2*256+sb_digit*16;
                    end;
gd:=vga;
gm:=vgahi;
initgraph(gd,gm,'');
port[$60]:=$f3;
delay(120);
port[$60]:=0;
checkbreak:=false;
if graphresult<>0 then begin
                       closegraph;
                       clrscr;
                       gotoxy(1,1);
                       writeln('Sorry,VGA not available.You can''t run this program');
                       halt;
                       end;
{INIT ALL VARS}
player1:=false;
player2:=false;
randomize;
initsprites;
bfwshow;
closegraph;
initvga;
scrshow('first.arm',64768);
waitkey;
cls;
scrshow('first.arm',2*64768);
waitkey;
cls;

other:
initvga;
scrshow('first.arm',0);
present;
gd:=vga;
gm:=vgahi;
initgraph(gd,gm,'');
{compare hiscore with score}
levels;
goto other;
END.