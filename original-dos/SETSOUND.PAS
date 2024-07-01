program setsound;

uses crt,dos;

type screendev = record
               x,y   : integer;
               name  : string;
               atr   : byte;
               dev   : byte;
               adress: word;
               end;

const nr_dev = 8;
      xi = 10;
      yi = 5;
      xf = 70;
      yf = 20;
      center = 1;
      fw = (yf-yi) div 2;
      fname='sound.cfg';
      devices : array [1..nr_dev] of screendev=(
                (x:(xi+xf) div 2;y:fw+1;name:'No sound';atr:center;dev:255;adress:0),
                (x:(xi+xf) div 2;y:fw+2;name:'SoundBlaster DSP or compatible';atr:center;dev:7;adress:$220),
                (x:(xi+xf) div 2;y:fw+3;name:'DAC on LPT 1';atr:center;dev:1;adress:0),
                (x:(xi+xf) div 2;y:fw+4;name:'DAC on LPT 2';atr:center;dev:2;adress:0),
                (x:(xi+xf) div 2;y:fw+5;name:'PC Speaker';atr:center;dev:0;adress:0),
                (x:(xi+xf) div 2;y:fw+6;name:'Disney sound on LPT1';atr:center;dev:11;adress:0),
                (x:(xi+xf) div 2;y:fw+7;name:'LPT1 and LPT2 stereo';atr:center;dev:4;adress:0),
                (x:(xi+xf) div 2;y:fw+8;name:'Stereo-on-1 card';atr:center;dev:10;adress:0)
                );
const
      msg : array[1..5] of string=(
      'Select sound type',
      'Esc to exit',
      'Enter to select&save',
      ' move ',
      '');

{	0	PC Speaker
	1	D/A converter on LPT1
	2	D/A converter on LPT2
	3	D/A converter on LPT3
	4	D/A converters on LPT1 and LPT2 (stereo)
	5	D/A converters on LPT1 and LPT2 (mono)
	7	Soundblaster card
	10	Stereo-on-1 card
	11	Disney Sound Source on LPT1
	12	Disney Sound Source on LPT2
	13	Disney Sound Source on LPT3
	255	No sound
}

type soundrec = record
              device : byte;
              adress : byte;{sb only}
              end;

var key         : byte;
    option      : byte;
    s           : searchrec;
    f           : file of soundrec;
    tofile      : soundrec;
    find_device : boolean;
    i           : integer;
    msg_time,wm : integer;
    mnv         : string;

function fval(str : string) : integer;
var err : integer;
    v   : integer;
begin
val(str,v,err);
fval:=v;
end;

procedure Menu;

var i,j:integer;

begin
{ ¡¢£¤¥¦§¨ª«¬­®¯°°¯±²³´µ¶·¸¹ º » ¼ ½Æ¿ÀÁÊÃÄÅÆÇ È É Ê Ë É ÊËÌ Í}
textcolor(white);textbackground(green);
gotoxy(xi,yi);write('É');for i:=xi+1 to xf-1 do begin gotoxy(i,yi);write('Í');end;gotoxy(xf,yi);write('»');
for i:=yi+1 to yf-1 do
    begin
    gotoxy(xi,i);write('º');
    for j:=xi+1 to xf-1 do begin gotoxy(j,i);write(' ');end;
    gotoxy(xf,i);write('º');
    end;
gotoxy(xi,yf);write('È');for i:=xi+1 to xf-1 do begin gotoxy(i,yf);write('Í');end;gotoxy(xf,yf);write('¼');
gotoxy((xi+xf) div 2-length(msg[1]) div 2,yi);write(msg[1]);
dec(msg_time);
if msg_time<=0
   then begin
        msg_time:=3;
        inc(wm);if wm>4 then wm:=2;
        end;

if option=2 then begin wm:=5;msg_time:=0; end;
gotoxy((xi+xf) div 2-length(msg[wm]) div 2,yf);write(msg[wm]);

for i:=1 to nr_dev do
    with devices[i] do
         case atr of
         center : begin gotoxy(x-length(name) div 2,y);write(name);end;
         end;

textbackground(white);textcolor(yellow);
with devices[option] do
     begin
     gotoxy(x-length(name) div 2,y);
     write(name);
     end;

end;

begin

textbackground(black);
clrscr;

findfirst('sound.cfg',$3f,s);
if doserror<>0
   then begin
        writeln('Error opening sound configuration file . The file may not exist . ');
        writeln('I will creat it .');
        assign(f,'sound.cfg');rewrite(f);option:=1;close(f);
        end
   else begin
        assign(f,'sound.cfg');reset(f);
        read(f,tofile);
        find_device:=false;
        for i:=1 to nr_dev do
            if devices[i].dev=tofile.device then begin option:=i;find_device:=true;end;
        if not find_device
           then begin
                writeln('Sound configuration file is corrupted .');
                option:=1;
                end;
        close(f);
        end;
msg[5]:=getenv('BLASTER');
delay(1000);
msg_time:=3;wm:=2;

textbackground(black);
clrscr;

menu;

repeat

key:=port[$60];
asm mov ax,$0c02
    int $21
end;

case key of
72 : begin
     if option>1 then dec(option);
     menu;
     end;
80 : begin
     if option<nr_dev then inc(option);
     menu;
     end;
28 : begin
     assign(f,'sound.cfg');reset(f);
     with tofile do
          begin
          device:=devices[option].dev;
          if option=2
             then begin
                  mnv:=copy(msg[5],2,3);
                  adress:=fval(mnv[2]);
                  end;
     end;
     seek(f,0);write(f,tofile);close(f);
     end;
end;

until key=1;

textbackground(black);textcolor(white);
clrscr;
end.