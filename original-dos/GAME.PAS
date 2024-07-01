unit game;
{$F+}
interface
uses graph,crt,dos,mouse,wav,sbdsp;
const path='';
      vol:byte=187;
var fil:file;
    player1,player2:boolean;
    key:char;
    endcod:integer;
    sbbase : word;

procedure LEVELS;
procedure INITSPRITES;
implementation
type longbuf=array[1..1024] of byte;
     longbuf1=array[1..1664] of byte;
		 vlongbuf=array[1..2048] of byte;
		 shortbuf=array[1..512] of byte;
		 shortbuf1=array[1..384] of byte;
		 vshortbuf=array[1..128] of byte;
		 lb=^longbuf;
       lb1=^longbuf1;
		 sb=^shortbuf;
		 sb1=^shortbuf1;
		 vsb=^vshortbuf;
		 vlb=^vlongbuf;
const pfire=4;
      pexpl=20;
      pbase=4;
      pplane=6;
      plaser=12;
      plaserc=8;
      BASES:array[1..pbase,1..5] of integer=( (0,30,405,50,0) , (1,120,415,50,0),
                                              (1,320,400,50,0), (0,410,410,50,0));
      LASERCOLOR:array[1..plaserc] of integer=(lightcyan,white,lightgreen,lightblue,lightred,yellow,magenta,brown);
      texty:integer=300;

var rd:integer;
    ox,oy:integer;
    score:longint;
    base:lb;
    bomb1,bomb2,bomb3,target,tarspc:vsb;
    plane1,plane2,plane3,plane1r,plane2r,plane3r:sb1;
    rplane1,rplane2,rplane3,rplane1r,rplane2r,rplane3r:sb1;
    gplane1,gplane2,gplane3,gplane1r,gplane2r,gplane3r:sb1;
    heli1,heli2,heli3,heli1r,heli2r,heli3r:sb;
    face1,face2,face3,face4,face5,face6,faced1,par1,par2,par3,par4,par5,par6:lb1;
    help1,help2,help3,help4,help5:sb;
    f1,f2,f3,f4,f5:sb;
    hdd1,hdd2,hdd3,hdd4,hdd5,hdd6,hdd7:sb;
    satelit:sb;
    planespc:sb;
    keyboard,mousespr,atomic1,atomic2,atomic3:vlb;
    BOMB:array[1..pfire,1..8] of integer;
    EXPL:array[1..pexpl,1..5] of integer;
    PLANE:array[1..pplane,1..7] of integer;
    LASER:array[1..plaser,1..7] of integer;
    HELP:array[1..4] of integer;
    FOLLOW:array[1..4] of integer;
    HDD:array[1..4] of integer;
    fireask,kybd:boolean;
    baseremain,r1,r2:integer;{ramuri care se formeaza}
    planum:array[1..2] of integer;
    laserc:integer;
    seq,sprite:byte;
    is_hdd,is_help,is_follow:boolean;
    explode,aargh,bine,lasere:psnd;
    le,la,lbine,ll,cryf,expf,binef,laseref:word;


procedure SCOREWRI(val1,val2:longint);
var s:string;
begin
settextstyle(0,0,0);
setcolor(white);
outtextxy(505,100,'score:');
str(val1,s);
setcolor(black);
outtextxy(505,120,s);
str(val2,s);
setcolor(lightblue);
outtextxy(505,120,s);
end;
procedure INITSPRITES;
begin
cleardevice;

init;{init ,mouse drv}
re.a.x:=15;re.a.y:=15;
re.b.x:=485;re.b.y:=380;
setrange(re);

setlinestyle(0,0,1);
new(tarspc);
getimage(0,0,14,14,tarspc^);
new(planespc);
getimage(0,0,36,20,planespc^);
assign(fil,'armaged.arm');
reset(fil,1);
seek(fil,17920);
new(base);
blockread(fil,base^,1024,rd);
new(bomb1);new(bomb2);new(bomb3);new(target);
blockread(fil,bomb1^,128,rd);
blockread(fil,bomb2^,128,rd);
blockread(fil,bomb3^,128,rd);
blockread(fil,target^,128,rd);
new(plane1);new(plane2);new(plane3);new(plane1r);new(plane2r);new(plane3r);new(satelit);
blockread(fil,plane1^,384,rd);blockread(fil,plane2^,384,rd);blockread(fil,plane3^,384,rd);
blockread(fil,plane1r^,384,rd);blockread(fil,plane2r^,384,rd);blockread(fil,plane3r^,384,rd);
blockread(fil,satelit^,512,rd);
new(rplane1);new(rplane2);new(rplane3);new(rplane1r);new(rplane2r);new(rplane3r);
blockread(fil,rplane1^,384,rd);blockread(fil,rplane2^,384,rd);blockread(fil,rplane3^,384,rd);
blockread(fil,rplane1r^,384,rd);blockread(fil,rplane2r^,384,rd);blockread(fil,rplane3r^,384,rd);
new(gplane1);new(gplane2);new(gplane3);new(gplane1r);new(gplane2r);new(gplane3r);
blockread(fil,gplane1^,384,rd);blockread(fil,gplane2^,384,rd);blockread(fil,gplane3^,384,rd);
blockread(fil,gplane1r^,384,rd);blockread(fil,gplane2r^,384,rd);blockread(fil,gplane3r^,384,rd);
new(heli1);new(heli2);new(heli3);new(heli1r);new(heli2r);new(heli3r);
blockread(fil,heli1^,512,rd);blockread(fil,heli2^,512,rd);blockread(fil,heli3^,512,rd);
blockread(fil,heli1r^,512,rd);blockread(fil,heli2r^,512,rd);blockread(fil,heli3r^,512,rd);
new(face1);new(face2);new(face3);new(face4);new(face5);new(face6);new(faced1);
new(par1);new(par2);new(par3);new(par4);new(par5);new(par6);
blockread(fil,face1^,1664,rd);blockread(fil,face2^,1664,rd);blockread(fil,face3^,1664,rd);blockread(fil,face4^,1664,rd);
blockread(fil,face5^,1664,rd);blockread(fil,face6^,1664,rd);blockread(fil,faced1^,1664,rd);
blockread(fil,par1^,1664,rd);blockread(fil,par2^,1664,rd);blockread(fil,par3^,1664,rd);blockread(fil,par4^,1664,rd);
blockread(fil,par5^,1664,rd);blockread(fil,par6^,1664,rd);
new(keyboard);new(mousespr);
blockread(fil,keyboard^,2048,rd);
blockread(fil,mousespr^,2048,rd);
new(atomic1);new(atomic2);new(atomic3);
blockread(fil,atomic1^,2048,rd);
blockread(fil,atomic2^,2048,rd);
blockread(fil,atomic3^,2048,rd);
new(help1);new(help2);new(help3);new(help4);new(help5);
blockread(fil,help1^,512);
blockread(fil,help2^,512);
blockread(fil,help3^,512);
blockread(fil,help4^,512);
blockread(fil,help5^,512);
new(f1);new(f2);new(f3);new(f4);new(f5);
blockread(fil,f1^,512);
blockread(fil,f2^,512);
blockread(fil,f3^,512);
blockread(fil,f4^,512);
blockread(fil,f5^,512);
new(hdd1);new(hdd2);new(hdd3);new(hdd4);new(hdd5);new(hdd6);new(hdd7);
blockread(fil,hdd1^,512);
blockread(fil,hdd2^,512);
blockread(fil,hdd3^,512);
blockread(fil,hdd4^,512);
blockread(fil,hdd5^,512);
blockread(fil,hdd6^,512);
blockread(fil,hdd7^,512);
close(fil);

GetIntVec(TIMERINTR, @BIOSTimerHandler);

new(aargh);
la:=35006-44;
load('armaged.arm',aargh,72568,la,cryf);

new(explode);
le:=15118-44;
load('armaged.arm',explode,107574,le,expf);

new(bine);lbine:=27882;binef:=22050;
assign(fil,'bine.raw');reset(fil,1);blockread(fil,bine^,lbine);close(fil);

new(lasere);ll:=12827;laseref:=11025;
assign(fil,'lasere.raw');reset(fil,1);blockread(fil,lasere^,ll);close(fil);

end;

procedure SHEETINIT;
type scene = record
           base:array[1..4,1..5] of integer;
           peisaj:array[1..60,1..2] of integer;
           maxp:integer;
           color:integer;
           maxenemy:integer;
           end;

var curent:scene;
    i:integer;
begin
setfillstyle(1,darkgray);
bar(0,0,640,480);
setfillstyle(1,black);
bar(15,15,625,465);
setcolor(lightgray);

{setcolor(brown);
moveto(15,450);
lineto(30,435);
lineto(85,435);
lineto(100,445);lineto(300,445);readln;
lineto(320,430);lineto(380,430);lineto(400,440);readln;
lineto(500,440);lineto(500,465);lineto(15,465);lineto(15,450);readln;
setfillstyle(1,brown);
floodfill(16,451,brown);
for i:=1 to pbase do begin
                 bases[i,4]:=50;
                 bases[i,5]:=0;
                 if bases[i,1]=1 then begin
                                      putimage(bases[i,2],bases[i,3],base^,0);
                                      setfillstyle(1,lightblue);
                                      bar(505+10*(i-1),160+50-bases[i,4],510+10*(i-1),160+50);
                                      end;
                 end;}
assign(fil,'armaged.arm');
reset(fil,1);
if 3<laserc then begin
                 seek(fil,filesize(fil)-858);
                 blockread(fil,curent,sizeof(scene))
                 end
            else begin
                 seek(fil,filesize(fil)-858+(laserc-1)*286);
                 blockread(fil,curent,sizeof(scene));
                 end;
close(fil);
setcolor(brown);
moveto(curent.peisaj[1,1],curent.peisaj[1,2]);
for i:=2 to curent.maxp do
    begin
        lineto(curent.peisaj[i,1],curent.peisaj[i,2]);
    end;
if laserc=1 then begin
                 for i:=1 to 4 do bases[i,1]:=1;
                 end;
setfillstyle(1,brown);
floodfill(499,464,brown);
for i:=1 to 4 do
    begin
         bases[i,2]:=curent.base[i,2];
         bases[i,3]:=curent.base[i,3];
         bases[i,4]:=curent.base[i,4];
         bases[i,5]:=curent.base[i,5];
         if bases[i,1]=1 then
         begin
         putimage(bases[i,2],bases[i,3],base^,0);
         setfillstyle(1,lightblue);
         bar(505+10*(i-1),160+50-bases[i,4],510+10*(i-1),160+50);
         end;
    end;
scorewri(score,score);
setcolor(white);
settextstyle(0,0,0);
outtextxy(505,20,'using now:');
putimage(505,30,mousespr^,0);
outtextxy(505,140,'shields:');
settextstyle(7,0,0);
for i:=1 to 6 do begin
setcolor(white);
outtextxy(50,getmaxy div 2,'DEFEND YOUR CITIES !');
delay(100);
setcolor(black);
outtextxy(50,getmaxy div 2,'DEFEND YOUR CITIES !');
delay(50);
end;
kybd:=false;
end;
procedure TOPSCORE;
type hiscr=array[1..10] of string[23];
     zbase=array[0..29,0..59] of byte;
const msg:array[1..7] of string=('Great !','New high score','Please type your name commander',
                                 'The Defenders','Your memory','is','unforgetable');
var
    c,posn,i,j,k:integer;
    hs:hiscr;
    zb:zbase;
    v:longint;
    s,s1:string;
label 1;{daca s-a gasit o intrare in top,se scrie numele si se iese}
begin
cleardevice;
assign(fil,'armaged.arm');
reset(fil,1);
seek(fil,70528);
blockread(fil,hs,sizeof(hs));
blockread(fil,zb,sizeof(zbase));
posn:=0;
for i:=1 to 10 do begin
val(copy(hs[i],16,7),v,c);
if v<=score then begin
        for j:=0 to 29 do
        for k:=0 to 59 do begin
        setfillstyle(1,zb[j,k]);
        bar(k*10+20,j*16,k*10+10+20,j*16+16);
        end;
	     settextstyle(7,0,0);
	     setcolor(white);
	     outtextxy(getmaxx div 2-textwidth(msg[1]) div 2,50,msg[1]);
	     outtextxy(getmaxx div 2-textwidth(msg[2]) div 2,100,msg[2]);
	     setcolor(lightblue);
	     outtextxy(getmaxx div 2-textwidth(msg[3]) div 2,150,msg[3]);
	     for j:=10 downto i do hs[j]:=hs[j-1];
	     setcolor(red);
	     s:='';
	     repeat
	     if keypressed then begin
		        key:=readkey;
		        if (upcase(key)<='Z') and (upcase(key)>=' ') then begin
				       inc(posn);
				       s:=s+upcase(key);
				       outtextxy(getmaxx div 2-100+20*posn,200,upcase(key));
				       end;
              if key=#13 then begin
                              for j:=posn to 9 do s:=s+' ';
                              posn:=10;
                              end;
		        end
		   else key:=#0;
	     until posn>9;
	     str(score,s1);
	     s:=s+'      '+s1;
	     hs[i]:=s;
        goto 1;
	     end;
end;
1:delay(300);
cleardevice;
for j:=0 to 29 do
for k:=0 to 59 do begin
setfillstyle(1,zb[j,k]);
bar(k*10+20,j*16,k*10+10+20,j*16+16);
end;
setcolor(white);
settextstyle(7,0,0);
setusercharsize(1,1,3,2);
outtextxy(getmaxx div 2-textwidth(msg[4]) div 2,0,msg[4]);
settextstyle(3,0,0);
setusercharsize(1,1,1,1);
outtextxy(getmaxx div 2-textwidth(msg[5]) div 2,getmaxy-90,msg[5]);
outtextxy(getmaxx div 2-textwidth(msg[6]) div 2,getmaxy-70,msg[6]);
outtextxy(getmaxx div 2-textwidth(msg[7]) div 2,getmaxy-50,msg[7]);
for i:=1 to 10 do begin
setcolor(black);
outtextxy(getmaxx div 2-textwidth(hs[i]) div 2+3,70+(i-1)*25+3,hs[i]);
setcolor(lightcyan);
outtextxy(getmaxx div 2-textwidth(hs[i]) div 2,70+(i-1)*25,hs[i]);
end;
seek(fil,70528);
blockwrite(fil,hs,sizeof(hiscr));
repeat
until readkey=#13;
close(fil);
cleardevice;
end;
procedure CHOSEMSG(importance:byte);
begin
setfillstyle(1,black);
bar(505,texty,625,texty+30);
settextstyle(0,0,0);
setcolor(red);
sprite:=0;
{dc imporatance este 0-mesaje normale
 dc ----------- este 1-oras lovit din hitcity
 dc ----------- este 2-shield lovit din hitcity
 dc ----------- este 3-laser lovit din hitlaser
 dc ----------- este 4-paraziti
 dc ----------- este 5-plane lovit din hitplane}
if importance=0 then begin
	     case random(6) of
	     0:begin
	       outtextxy(505,texty,'we''re fighting');
	       outtextxy(505,texty+10,'well !');
	       end;
	     1:outtextxy(505,texty,'keep on moving');
	     2:begin
	       outtextxy(505,texty,'let''s get''em');
	       outtextxy(505,texty+10,'all');
	       end;
	     3:begin
	       outtextxy(505,texty,'show no mercy');
	       outtextxy(505,texty+10,'commander');
	       end;
	     4:outtextxy(505,texty,'destroy them !');
             5:begin
               outtextxy(505,texty,'we''re under ');
               outtextxy(505,texty+10,'laser attack');
	     end;
	     end;
             end;
if importance=1 then begin
	     outtextxy(505,texty,'we were hit !');
	     outtextxy(505,texty+10,'HEELLPP !');
	     end;
if importance=2 then begin
	     outtextxy(505,texty,'the shield was');
	     outtextxy(505,texty+10,'hit ');
	     end;
if importance=3 then begin
	     outtextxy(505,texty,'nice hit');
	     outtextxy(505,texty+10,'commander !');
	     end;
if importance=5 then begin
	     outtextxy(505,texty,'that plane fall');
	     outtextxy(505,texty+10,'in thousand');
	     outtextxy(505,texty+20,'pieces !');
             end;
if importance=4 then begin
	     outtextxy(505,texty,'zzz...crack');
	     outtextxy(505,texty+10,'plop...blop');
	     end;
end;
procedure VERIFY;
begin
if ox<15 then ox:=15;
if ox+15>500 then ox:=484;
if oy<15 then oy:=15;
if oy+15>370 then oy:=355;
putimage(ox,oy,target^,0);
end;
procedure PUTBOMB(posn:integer);
begin
if bomb[posn,2]=1 then putimage(bomb[posn,7],bomb[posn,8],bomb1^,0);
if bomb[posn,2]=2 then putimage(bomb[posn,7],bomb[posn,8],bomb2^,0);
if bomb[posn,2]=3 then putimage(bomb[posn,7],bomb[posn,8],bomb2^,0);
if bomb[posn,2]=4 then putimage(bomb[posn,7],bomb[posn,8],bomb1^,0);
end;
procedure COORDINIT(posn:integer);
var min,calc:integer;
    s:string;
    var j:integer;
begin
min:=4000;
for j:=1 to pbase do begin
calc:=abs(bases[j,2]-bomb[posn,5]);
{calc:=round(sqrt(abs((sqr(-bomb[posn,5]+bases[j,2])+sqr(-bomb[posn,6]+bases[j,3])))));}
if (calc<=min) and (bases[j,1]=1) then begin
                 min:=calc;
                 bomb[posn,3]:=bases[j,2];
                 bomb[posn,4]:=bases[j,3]-20;
                 end;

end;
end;

procedure helpplane;
begin
inc(help[4]);
if help[4]>14 then help[4]:=1;
help[1]:=help[1]+help[3];
case help[4] of
1,2,3:putimage(help[1],help[2],help1^,0);
3,4,5:putimage(help[1],help[2],help2^,0);
6,7,8:putimage(help[1],help[2],help3^,0);
9,10,11:putimage(help[1],help[2],help4^,0);
12,13,14:putimage(help[1],help[2],help5^,0);
end;
end;

procedure FIREMOVE;
var j:integer;
      procedure ENDOFWAY(posn:integer);
      var k:integer;
      label 1,2;{2-daca a fost gasita cel putin o intrare folosita bomb}
                {1-daca a fost gasita o intrare nefolosita la expl}
      begin
      if {((bomb[posn,7]<=bomb[posn,5]) or (bomb[posn,7]<=bomb[posn,5])) and} (bomb[posn,8]<=bomb[posn,6]) then begin
                                                                    if device=blaster then playback(explode,le,expf);
                                                                    {init_intr(explode,le,expf);}

                                                                    for k:=1 to pexpl do
                                                                    if expl[k,1]=0 then begin
                                                                                   putimage(bomb[posn,7],bomb[posn,8],
                                                                                            tarspc^,0);
                                                                                   expl[k,2]:=bomb[posn,5]; {ox}
                                                                                   expl[k,3]:=bomb[posn,6]; {oy}
                                                                                        expl[k,1]:=1; {intrare ocupata}
                                                                                        expl[k,5]:=1; {directie-crestere}
                                                                                        expl[k,4]:=0; {raza initiala}
                                                                                        goto 1;
                                                                                        end;
                                                                    1:bomb[posn,1]:=0;
                                                                    for k:=1 to pfire do
                                                                    if bomb[k,1]=1 then goto 2;
                                                                    fireask:=false;
                                                                    end;
      2:end;
begin
for j:=1 to pfire do begin
if bomb[j,1]=1 then begin
                    putimage(bomb[j,7],bomb[j,8],tarspc^,0);
                    inc(bomb[j,2]);
                    if bomb[j,2]>4 then bomb[j,2]:=1;
                    dec(bomb[j,8],4);
                    bomb[j,7]:=round(((bomb[j,8]-bomb[j,4])/(bomb[j,6]-bomb[j,4]))*(bomb[j,5]-bomb[j,3]))+bomb[j,3];
                    putbomb(j);
                    endofway(j);
                    end;
end;
end;
procedure PLANEMOVE;
var rnd:integer;
    i:integer;
		 procedure PUTPLANE(posn:integer);
		 begin
		 if plane[posn,2]=0 then begin
		                         if plane[posn,6]=0 then
                                         case  plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],plane1^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],plane2^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],plane3^,0);
                                         end;{case}
					 if plane[posn,6]=1 then
                                         case  plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],plane1r^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],plane2r^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],plane3r^,0);
                                         end;{case}
                                         end;
                 if plane[posn,2]=3 then begin
		                         if plane[posn,6]=0 then
                                         case plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],rplane1^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],rplane2^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],rplane3^,0);
                                         end;{case}
					 if plane[posn,6]=1 then
                                         case plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],rplane1r^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],rplane2r^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],rplane3r^,0);
                                         end;{case}
					 end;
                 if plane[posn,2]=4 then begin
		                         if plane[posn,6]=0 then
                                         case  plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],gplane1^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],gplane2^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],gplane3^,0);
                                         end;{case}
					 if plane[posn,6]=1 then
                                         case  plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],gplane1r^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],gplane2r^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],gplane3r^,0);
                                         end;{case}
					 end;
		 if plane[posn,2]=1 then putimage(plane[posn,4],plane[posn,5],satelit^,0);
                 if plane[posn,2]=2 then begin
		                         if plane[posn,6]=0 then
                                         case  plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],heli1^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],heli2^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],heli3^,0);
                                         end;{case}
					 if plane[posn,6]=1 then
                                         case  plane[posn,3] of
                                         1,2,3:putimage(plane[posn,4],plane[posn,5],heli1r^,0);
                                         4,5,6:putimage(plane[posn,4],plane[posn,5],heli2r^,0);
                                         7,8,9:putimage(plane[posn,4],plane[posn,5],heli3r^,0);
                                         end;{case}
					 end;

		 end;
		 procedure ENDOFWAY(posn:integer);
		 begin
		 if (plane[posn,4]>500-33-4) or (plane[posn,4]<16+4) then begin
		                                                      plane[posn,1]:=0;
                                                                      putimage(plane[posn,4],plane[posn,5],planespc^,0);
								      end;
		 end;
		 procedure LASERINI(posn:integer);
                 var j:integer;
		 label 1;
		 begin
		 for j:=1 to plaser do begin
		 if laser[j,1]=0 then begin
		                      laser[j,1]:=1;
				      laser[j,2]:=r2; {ramuri care se formeaza}
				      laser[j,3]:=plane[posn,4];  {ox initial}
				      laser[j,4]:=plane[posn,5]+15; {oy final}
				      laser[j,5]:=laser[j,3];  {ox curent}
				      laser[j,6]:=laser[j,4];  {oy curent}
				      if plane[posn,6]=1    then laser[j,7]:=-random(2)-1;
				      if plane[posn,6]=0    then laser[j,7]:=random(2)+1;
				      dec(plane[posn,7]);
				      goto 1;
				      end;
		end;
		1:end;
label 1,2;
begin
for i:=1 to pplane do begin
if plane[i,1]=0 then begin
                     plane[i,1]:=1;{intrare folosita}
		     plane[i,2]:=round(random(5));{tip de plane}
                     plane[i,3]:=1;{sprite-uri}
                     plane[i,6]:=round(random(2));{orientare}
                     if plane[i,6]=0 then plane[i,4]:=500-33-4;
                     if plane[i,6]=1 then plane[i,4]:=16+4;
                     plane[i,5]:=round(random(220))+15;
                     plane[i,7]:=1;
		     putplane(i);
		     end;
if plane[i,1]=1 then begin
                     putplane(i);
		     if plane[i,2]=0 then begin
			          if plane[i,6]=0 then dec(plane[i,4],2);
			          if plane[i,6]=1 then inc(plane[i,4],2);
			          end;
		     if plane[i,2]=1 then begin
		          if plane[i,6]=0 then dec(plane[i,4],3);
		          if plane[i,6]=1 then inc(plane[i,4],3);
			          end;
                     if plane[i,2]=4 then begin
			          if plane[i,6]=0 then dec(plane[i,4],2);
			          if plane[i,6]=1 then inc(plane[i,4],2);
			          end;
		     if plane[i,2]=3 then begin
		          if plane[i,6]=0 then dec(plane[i,4],2);
		          if plane[i,6]=1 then inc(plane[i,4],2);
			          end;
                     if plane[i,2]=2 then begin
		          if plane[i,6]=0 then dec(plane[i,4],1);
		          if plane[i,6]=1 then inc(plane[i,4],1);
			          end;

                     inc(plane[i,3]);
		     if plane[i,3]>9 then plane[i,3]:=1;
		     rnd:=round(random(10));
		     if (plane[i,2]=1) and (rnd=2) and (plane[i,7]>0) then begin
                                                                           if device=blaster then playback(lasere,ll,laseref);
		                                                           laserini(i);
		                                                           end;
                     endofway(i);
                     end;
end;
end;
procedure LASERMOVE;
var rnd:integer;
    i:integer;
		 procedure LASERINI(posn:integer);
                 var j:integer;
		 label 1;
		 begin
		 for j:=1 to plaser do
		 if laser[j,1]=0 then begin
		                      laser[j,1]:=1;
				      laser[j,2]:=r1; {ramuri care se formeaza din laser}
				      laser[j,3]:=laser[posn,5];  {ox initial}
				      laser[j,4]:=laser[posn,6]; {oy final}
                                      laser[j,5]:=laser[j,3];  {ox curent}
			              laser[j,6]:=laser[j,4];  {oy curent}
				      if laser[posn,7]=-1 then laser[j,7]:=1;
				      if laser[posn,7]=1  then laser[j,7]:=-1;
				      dec(laser[posn,2]);
				      goto 1;
				      end;
		 1:end;
                 procedure HITCITY(posn:integer);
                 var j,k:integer;
                 begin
                 for j:=1 to pbase do
                 if bases[j,1]=1 then {doar daca orasul nu a mai fost lovit}
		     if (bases[j,2]+60>laser[posn,5]) and (bases[j,2]<laser[posn,5])
		        and (bases[j,3]<laser[posn,6]) then begin
                                                         setcolor(black);
                                                         setlinestyle(0,0,1);
                                                         line(laser[posn,3],laser[posn,4],laser[posn,5],laser[posn,6]);
			         laser[posn,1]:=0;
	             if bases[j,5]=1 then begin  dec(bases[j,4],6);
                                                         setfillstyle(1,black);
			         bar(505+10*(j-1),160,510+10*(j-1),160+50-bases[j,4]);
			         seq:=1;
			         chosemsg(2);
                                                  end;
                             {daca nu mai are shield sau daca shield-ul nu e activ,baza va fi distrusa}
                             if (bases[j,4]<0) or (bases[j,5]=0) then begin
                                                        {init_intr(aargh,la,cryf);}
                                                        if device=blaster then playback(aargh,la,cryf);
                                                        setcolor(black);
                                                        setlinestyle(0,0,3);
                                                        ellipse(bases[j,2]+30,bases[j,3]+30,60,120,60,35);
			        dec(baseremain);
			        {putimage(bases[j,2],bases[j,3]-40,atomic1^,0);
			        putimage(bases[j,2],bases[j,3]-40,atomic2^,0);
			        putimage(bases[j,2],bases[j,3]-40,atomic3^,0);
			        putimage(bases[j,2],bases[j,3]-40,atomic2^,0);
			        putimage(bases[j,2],bases[j,3]-40,atomic1^,0);
			        putimage(bases[j,2],bases[j,3]-40,atomic1^,xorput);}
			        setfillstyle(1,black);
			        fillellipse(laser[posn,5],laser[posn,6],20,20);
			        seq:=0;
			        chosemsg(1);
			        if baseremain=0 then begin
                                                                              settextstyle(7,0,0);
                                                                              for k:=1 to 6 do begin
                                                                              setcolor(white);
                                                                              outtextxy(200,getmaxy div 2,'GAME OVER');
                                                                              delay(100);
                                                                              setcolor(black);
                                                                              outtextxy(200,getmaxy div 2,'GAME OVER');
                                                                              delay(50);
                                                                              end;
                                                                              endcod:=1;
                                                                              end;
                                                        bases[j,1]:=0;
			        end;
			   end;{end main if}
                     end;
begin
for i:=1 to plaser do begin
if laser[i,1]=1 then begin
                     rnd:=round(random(15));
		     if (rnd=2) and (laser[i,2]>0) then begin
		                                        laserini(i);
							end;

		     if laser[i,5]>499 then begin
		                            setcolor(black);
                                            setlinestyle(0,0,1);
					    line(laser[i,3],laser[i,4],laser[i,5],laser[i,6]);
					    laser[i,3]:=16;
					    laser[i,4]:=laser[i,6];
	                                    laser[i,5]:=laser[i,3];
					    end;
		     if laser[i,5]<16 then begin
		                           setcolor(black);
                                           setlinestyle(0,0,1);
					   line(laser[i,3],laser[i,4],laser[i,5],laser[i,6]);
					   laser[i,3]:=499;
					   laser[i,4]:=laser[i,6];
					   laser[i,5]:=laser[i,3];
					   end;
		     setcolor(lasercolor[laserc]);
                     setlinestyle(0,0,1);
		     line(laser[i,3],laser[i,4],laser[i,5],laser[i,6]);
		     laser[i,5]:=laser[i,5]+laser[i,7];
		     laser[i,6]:=laser[i,6]+1;
                     hitcity(i);
                     if laser[i,6]>464 then begin
                                            setcolor(black);
                                            setlinestyle(0,0,1);
					    line(laser[i,3],laser[i,4],laser[i,5],laser[i,6]);
					    laser[i,1]:=0;
                                            end;
		     if getpixel(laser[i,5],laser[i,6])=brown then begin
		                                                   setcolor(black);
                                                                   setlinestyle(0,0,1);
								   line(laser[i,3],laser[i,4],laser[i,5],laser[i,6]);
								   laser[i,1]:=0;
								   setfillstyle(1,black);
								   fillellipse(laser[i,5],laser[i,6],3,3);
                                                                   end;
                     end;
end;
end;
procedure EXPLMOVE;
var i:integer;
     procedure HITPLANE(posn:integer);
     var j:integer;
     begin
     for j:=1 to pplane do
     if plane[j,1]=1 then if (expl[posn,2]-expl[posn,4]>plane[j,4]) and (plane[j,4]+30>expl[posn,2]-expl[posn,4])
	          and (expl[posn,3]-expl[posn,4]>plane[j,5]) and (plane[j,5]+30>expl[posn,3]-expl[posn,4])
	          or (expl[posn,2]+expl[posn,4]>plane[j,4]) and (plane[j,4]+30>expl[posn,2]+expl[posn,4])
	          and (expl[posn,3]+expl[posn,4]>plane[j,5]) and (plane[j,5]+30>expl[posn,3]+expl[posn,4])

                          then begin
                               if device=blaster then playback(bine,lbine,binef);
                               putimage(plane[j,4],plane[j,5],planespc^,0);
                               putimage(ox,oy,target^,0);
                               plane[j,1]:=0;
                               scorewri(score,score+150);
	                       inc(score,150);
	                       seq:=1;
	                       chosemsg(5);
                               dec(planum[2]);
                               if planum[2]<1 then endcod:=2;
                               end;
     if is_help then if (expl[posn,2]-expl[posn,4]>help[1]) and (help[1]+40>expl[posn,2]-expl[posn,4])
	          and (expl[posn,3]-expl[posn,4]>help[2]) and (help[2]+15>expl[posn,3]-expl[posn,4])
	          or (expl[posn,2]+expl[posn,4]>help[1]) and (help[1]+30>expl[posn,2]+expl[posn,4])
	          and (expl[posn,3]+expl[posn,4]>help[2]) and (help[2]+30>expl[posn,3]+expl[posn,4])
     then begin
          setfillstyle(1,black);
          bar(help[1],help[2],help[1]+41,help[2]+16);
          is_help:=false;
          end;
     if is_follow then if (expl[posn,2]-expl[posn,4]>follow[1]) and (follow[1]+40>expl[posn,2]-expl[posn,4])
	          and (expl[posn,3]-expl[posn,4]>follow[2]) and (follow[2]+15>expl[posn,3]-expl[posn,4])
	          or (expl[posn,2]+expl[posn,4]>follow[1]) and (follow[1]+30>expl[posn,2]+expl[posn,4])
	          and (expl[posn,3]+expl[posn,4]>follow[2]) and (follow[2]+30>expl[posn,3]+expl[posn,4])
     then begin
          setfillstyle(1,black);
          bar(follow[1],follow[2],follow[1]+31,follow[2]+31);
          is_follow:=false;
          end;
     end;
     procedure HITLASER(posn:integer);
     var j:integer;
     begin
     for j:=1 to plaser do
     if laser[j,1]=1 then if (expl[posn,2]-expl[posn,4]<laser[j,5]) and (laser[j,5]<expl[posn,2]+expl[posn,4])
                             and (expl[posn,3]-expl[posn,4]<laser[j,6]) and (laser[j,6]<expl[posn,3]+expl[posn,4])
                             then begin
                                  setcolor(black);
                                  setlinestyle(0,0,1);
			          line(laser[j,3],laser[j,4],laser[j,5],laser[j,6]);
			          laser[j,1]:=0;
                                  scorewri(score,score+50);
		                  inc(score,50);
		                  seq:=1;
		                  chosemsg(3);
		                  end;
     end;
begin
for i:=1 to pexpl do
if expl[i,1]=1 then begin
                    if expl[i,5]=1 then setcolor(red);
                    if expl[i,5]=-1 then setcolor(black);
                    if (expl[i,2]+expl[i,4]<500) and (expl[i,2]-expl[i,4]>15) and
                       (expl[i,3]-expl[i,4]>15) then circle(expl[i,2],expl[i,3],expl[i,4]);
                    expl[i,4]:=expl[i,4]+expl[i,5]; {raza}
                    hitlaser(i);
                    hitplane(i);
                    if expl[i,4]>13 then expl[i,5]:=-1;
                    if expl[i,4]<1 then expl[i,1]:=0;
                    putimage(ox,oy,target^,0);
                    end;
end;

procedure FOLLOWMOVE;
begin
inc(follow[4]);
if follow[4]>14 then follow[4]:=1;
case follow[4] of
    1,2,3:putimage(follow[1],follow[2],f1^,0);
    4,5,6:putimage(follow[1],follow[2],f2^,0);
    7,8,9:putimage(follow[1],follow[2],f3^,0);
    10,11,12:putimage(follow[1],follow[2],f4^,0);
    13,14,15:putimage(follow[1],follow[2],f5^,0);
    end;
follow[1]:=follow[1]+follow[3];
end;

procedure HDDMOVE;
begin
inc(hdd[4]);
case hdd[4] of
    1,2,3,4:putimage(hdd[1],hdd[2],hdd1^,0);
    5,6,7,8:putimage(hdd[1],hdd[2],hdd2^,0);
    9,10,11,12:putimage(hdd[1],hdd[2],hdd3^,0);
    13,14,15,16:putimage(hdd[1],hdd[2],hdd4^,0);
    17,18,19,20:putimage(hdd[1],hdd[2],hdd5^,0);
    21,22,23,24:putimage(hdd[1],hdd[2],hdd6^,0);
    25,26,27,28:putimage(hdd[1],hdd[2],hdd7^,0);
    end;
hdd[1]:=hdd[1]+hdd[3];
end;


procedure FACEMOVE;
begin
{seq este 0 daca orasul este lovit
 seq este 1 pt mesaje normale
 seq este 2 pt paraziti}
case seq of
0: begin
   inc(sprite);
   case sprite of
   10:putimage(505,210,faced1^,0);
   end;
   if sprite>90 then begin
	    seq:=2;{dupa ce se termina mesajul,vin parazitii}
	    chosemsg(4);
	    end;
    end;
1: begin
   case sprite of
   10:putimage(505,210,face1^,0);
   20:putimage(505,210,face2^,0);
   30:putimage(505,210,face3^,0);
   40:putimage(505,210,face4^,0);
   50:putimage(505,210,face5^,0);
   60:putimage(505,210,face6^,0);
   end;
   inc(sprite);
   if sprite>90 then begin
	       seq:=2;{dupa ce se termina mesajul,vin parazitii}
	       chosemsg(4);
	       end;
   end;
2: begin
   case sprite of
   10:putimage(505,210,par1^,0);
   20:putimage(505,210,par2^,0);
   30:putimage(505,210,par3^,0);
   40:putimage(505,210,par4^,0);
   50:putimage(505,210,par5^,0);
   60:putimage(505,210,par6^,0);
   end;
   inc(sprite);
   if sprite>50 then begin
	     seq:=1;{{dupa ce se termina parazitii,vine mesajul}
	     chosemsg(0);
	     end;
   end;
end;
end;
procedure LEVELS;
var ch,oldch:byte;
    r:registers;
    i,j,rnd:integer;
    eddie:psnd;
    leddie,feddie:word;

label 1,again,s1,s2,s3,s4; {1-a fost gasit un loc pt a pune o bomba}
begin
baseremain:=pbase;
planum[1]:=30;
planum[2]:=planum[1];
score:=0;
laserc:=1;r1:=0;r2:=1;
for i:=1 to pbase do bases[i,1]:=1;{intrari folosite in baza}
again:for i:=1 to pexpl do begin
                           expl[i,1]:=0; {intari nefolosite in expl}
                           expl[i,4]:=1;
                           expl[i,5]:=1;
                           end;
for i:=1 to pfire do bomb[i,1]:=0; {intrari nefolosite in fire}
for i:=1 to pplane do plane[i,1]:=0; {intrari nefolosite in avioane}
for i:=1 to plaser do for j:=1 to 7 do laser[i,j]:=0;{intrari nefolosite in laser}

ox:=250;
oy:=150;
endcod:=0;
seq:=1;
sprite:=0;
fireask:=false;
is_help:=false;
is_follow:=false;
is_hdd:=false;
sheetinit;
randomize;
putimage(ox,oy,target^,1);
speakeron;
setmixerreg(sbbase,$04,vol);
setmixerreg(sbbase,$22,vol);

{intro to game-john's idea}
{new(eddie);leddie:=55495;feddie:=11025;
assign(fil,'eddie.raw');reset(fil,1);blockread(fil,eddie^,leddie);close(fil);
if device=blaster then playback(eddie,leddie,feddie);

settextstyle(0,0,0);
setcolor(red);
outtextxy(505,texty,'this is eddie');delay(270);
outtextxy(505,texty+10,'your ship com');delay(270);
outtextxy(505,texty+20,'puter.');delay(270);

for i:=1 to 5 do
begin
putimage(505,210,face1^,0);delay(140);
putimage(505,210,face2^,0);delay(140);
putimage(505,210,face3^,0);delay(140);
putimage(505,210,face4^,0);delay(140);
putimage(505,210,face5^,0);delay(140);
putimage(505,210,face6^,0);delay(140);
end;
dispose(eddie);
}

repeat
if keypressed then begin
                   KEY:=readkey;
                   if kybd=true then begin
		                if (key='m') or (key='M') then begin
		                                               for i:=1 to pfire do
						               if bomb[i,1]=0 then begin
						                                        fireask:=true;
											bomb[i,1]:=1;{intrare folosita}
											bomb[i,2]:=1;{primul tip de bomba}
											bomb[i,5]:=ox;{ox destinatie}
											bomb[i,6]:=oy;{oy destinatie}
											coordinit(i);
											bomb[i,7]:=bomb[i,3];
											bomb[i,8]:=bomb[i,4];
											putbomb(i);
											goto 1;
											end;
								    end;{endif}
				     if (upcase(key)='O') then begin
				                               putimage(ox,oy,tarspc^,0);
							       dec(ox,10);
							       verify;
							       end;
				     if (upcase(key)='P') then begin
				                               putimage(ox,oy,tarspc^,0);
							       inc(ox,10);
							       verify;
							       end;
				     if (upcase(key)='Q') then begin
				                               putimage(ox,oy,tarspc^,0);
							       dec(oy,10);
							       verify;
							       end;
				     if (upcase(key)='Z') then begin
				                               putimage(ox,oy,tarspc^,0);
							       inc(oy,10);
							       verify;
							       end;

				     end;{keybd if end}

              if key=#13 then begin
	                      kybd:=not kybd;
			      if kybd=true then begin
                                                putimage(505,30,keyboard^,0);
                                                hide;
                                                end;
			      if kybd=false then begin
                                                 putimage(505,30,mousespr^,0);
                                                 p.x:=ox;p.y:=oy;
                                                 {loadshape('target.ms');
                                                 setshape;
                                                 show;}
                                                 setpos(p);
                                                 putimage(ox,oy,target^,0);
                                                 end;
			      end;

              if key=#27 then begin
                              endcod:=3;
                              end;
              if upcase(key)='H' then begin
                                      repeat
                                      settextstyle(7,0,0);
                                      setcolor(white);
                                      outtextxy(170,getmaxy div 2,'GAME PAUSED');
                                      delay(100);
                                      setcolor(black);
                                      outtextxy(170,getmaxy div 2,'GAME PAUSED');
                                      delay(50);
                                      until keypressed;
                                      end;
                if (key='1') and (bases[1,1]=1) then begin
                                        setlinestyle(1,0,3);
                                        if bases[1,5]=1 then begin
                                                             bases[1,5]:=0;
                                                             setcolor(black);
                                                             ellipse(bases[1,2]+30,bases[1,3]+30,60,120,60,35);
                                                             goto s1;
                                                             end;
                                        if bases[1,5]=0 then begin
                                                             bases[1,5]:=1;
                                                             setcolor(lightblue);
                                                             ellipse(bases[1,2]+30,bases[1,3]+30,60,120,60,35);
                                                             end;
                                        s1:end;
                 if (key='2') and (bases[2,1]=1) then begin
                                        setlinestyle(1,0,3);
                                        if bases[2,5]=1 then begin
                                                             bases[2,5]:=0;
                                                             setcolor(black);
                                                             ellipse(bases[2,2]+30,bases[2,3]+30,60,120,60,35);
                                                             goto s2;
                                                             end;
                                        if bases[2,5]=0 then begin
                                                             bases[2,5]:=1;
                                                             setcolor(lightblue);
                                                             ellipse(bases[2,2]+30,bases[2,3]+30,60,120,60,35);
                                                             end;
                                        s2:end;

                 if (key='3') and (bases[3,1]=1) then begin
                                        setlinestyle(1,0,3);
                                        if bases[3,5]=1 then begin
                                                             bases[3,5]:=0;
                                                             setcolor(black);
                                                             ellipse(bases[3,2]+30,bases[3,3]+30,60,120,60,35);
                                                             goto s3;
                                                             end;
                                        if bases[3,5]=0 then begin
                                                             bases[3,5]:=1;
                                                             setcolor(lightblue);
                                                             ellipse(bases[3,2]+30,bases[3,3]+30,60,120,60,35);
                                                             end;
                                        s3:end;
                 if (key='4') and (bases[4,1]=1) then begin
                                        setlinestyle(1,0,3);
                                        if bases[4,5]=1 then begin
                                                             bases[4,5]:=0;
                                                             setcolor(black);
                                                             ellipse(bases[4,2]+30,bases[4,3]+30,60,120,60,35);
                                                             goto s4;
                                                             end;
                                        if bases[4,5]=0 then begin
                                                             bases[4,5]:=1;
                                                             setcolor(lightblue);
                                                             ellipse(bases[4,2]+30,bases[4,3]+30,60,120,60,35);
                                                             end;
                                        s4:end;

		   end  {if read controls}
              else key:=#0;
if kybd=false then begin
                   putimage(ox,oy,tarspc^,0);
                   ox:=x;
                   oy:=y;
                   verify;
                   if buttonreleased(0)
                      then for i:=1 to pfire do
		               if bomb[i,1]=0 then begin
			                           fireask:=true;
						   bomb[i,1]:=1;{intrare folosita}
						   bomb[i,2]:=1;{primul tip de bomba}
						   bomb[i,5]:=ox;{ox destinatie}
						   bomb[i,6]:=oy;{oy destinatie}
						   coordinit(i);
						   bomb[i,7]:=bomb[i,3];
						   bomb[i,8]:=bomb[i,4];
						   putbomb(i);
						   goto 1;
						   end;

                   end;

1:if fireask=true then begin
                       firemove;
	               end;
explmove;
planemove;
lasermove;
facemove;
if not is_help
   then begin
        rnd:=random(laserc*300);
        if rnd=10 then begin
                      help[1]:=500-41;
                      help[2]:=15+random(200);
                      help[3]:=-1;
                      help[4]:=0;
                      is_help:=not is_help;
                      end;
        end
   else begin
        helpplane;
        if help[1]<17 then begin
                   setfillstyle(1,black);
                   bar(help[1],help[2],help[1]+41,help[2]+16);
                   is_help:=false;
                   setfillstyle(1,lightblue);
                   for i:=1 to 4 do
                       begin
                       if bases[i,1]=1
                       then begin
                            if bases[i,4]<42 then inc(bases[i,4],8)
                                             else bases[i,4]:=50;
                            bar(505+10*(i-1),160+50-bases[i,4],510+10*(i-1),160+50);
                            end;
                       end;
                   end;

        end;
if is_follow then begin
                  followmove;
                  if ((help[1]>follow[1]) and (help[1]+40>follow[1]))
                     and (((help[2]<follow[2]) and (help[2]+15>follow[2]))
                     or ((help[2]<follow[2]+30) and (help[2]+15>follow[2]+30)))
                     then begin
                          is_hdd:=true;
                          is_follow:=false;
                          is_help:=false;
                          bar(follow[1],follow[2],follow[1]+31,follow[2]+31);
                          bar(help[1],help[2],help[1]+41,help[2]+16);
                          hdd[1]:=help[1];
                          hdd[2]:=help[2];
                          hdd[3]:=help[3];
                          hdd[4]:=0;
                          end;
                  if follow[1]<17 then begin
                                       setfillstyle(1,black);
                                       bar(follow[1],follow[2],follow[1]+31,follow[2]+31);
                                       is_follow:=false;
                                       end;
                  end
             else begin
                  if (random(100)=1) and (is_help)
                     then begin
                          follow[1]:=500-41;
                          follow[2]:=15+random(200);
                          follow[3]:=-3;
                          follow[4]:=0;
                          is_follow:=true;
                          end;
                          end;
if is_hdd then begin
               hddmove;
               if (hdd[1]<17) or (hdd[4]>26)
                  then begin
                       setfillstyle(1,black);
                       bar(hdd[1],hdd[2],hdd[1]+41,hdd[2]+16);
                       is_hdd:=false;
                       end;
               end;


until endcod<>0;{1-all bases destroyed,2-all planes destroyed}
if endcod=2 then begin {se reia jocul,cu mai multe avioane}
                 inc(planum[1],10);
                 planum[2]:=planum[1];
                 inc(laserc);
                 case laserc of
                 1,2,3 : begin
                       r1:=1;
                       r2:=1;
                       end;
                 4,5 : begin
                       r1:=2;
                       r2:=1;
                       end;
                 6,7 : begin
                       r1:=2;
                       r2:=2;
                       end;
                 end;
                 if laserc>plaserc then laserc:=1;
                 settextstyle(7,0,0);
                 for i:=1 to 14 do begin
                 setcolor(white);
                 outtextxy(50,getmaxy div 2-50,'DEFEND SUCCESFULLY !');
                 outtextxy(50,getmaxy div 2,'BUT THEY COME AGAIN');
                 delay(100);
                 setcolor(black);
                 outtextxy(50,getmaxy div 2-50,'DEFEND SUCCESFULLY !');
                 outtextxy(50,getmaxy div 2,'BUT THEY COME AGAIN');
                 delay(50);
                 END;
                 goto again;
                 end;
if endcod=3 then begin
                 stop;
                 speakeroff;
                 closegraph;
                 gotoxy(0,0);
                 writeln('See you in hell !');
                 halt(0);
	         end;
topscore;
stop;
closegraph;
end;
END.