unit wav;
{$F+}
interface

uses dos;

type sound=array[1..55000] of byte;
     psnd=^sound;

const SPEAKER_PORT = $61;
      PIT_CONTROL = $43;
      PIT_CHANNEL_2 = $42;
      PIT_FREQ = $1234DD;
      TIMERINTR = 8;


var q,clock_ticks,counter:longint;
    count_values:array[0..255] of byte;
    BIOSTimerHandler:procedure;
    i,j:longint;
    lsound:word;
    table:psnd;
    note:longint;
    freq:word;



procedure init_intr(tab:psnd;ls:word;freq:word);
procedure init_play(tab:psnd;ls:word;freq:word);
procedure load(name:string;var tab:psnd;posit:longint;lung:longint;var freq:word);
procedure wav_play;
procedure stop;

implementation

procedure load;
var f:file;
begin
assign(f,name);
reset(f,1);
seek(f,posit+24);
blockread(f,freq,2);
seek(f,posit+44);
blockread(f,tab^,lung);
close(f);
end;

procedure stop;
begin
Port[$43] := $34;
Port[$40] := 0;
Port[$40] := 0;
SetIntVec(TIMERINTR, @BIOSTimerHandler);
Port[SPEAKER_PORT]:=Port[SPEAKER_PORT] and $FC;
Port[PIT_CONTROL]:=$B6;
end;


procedure init_play(tab:psnd;ls:word;freq:word);
begin
table:=tab;
lsound:=ls;
q:=pit_freq div (2*freq);
for i := 0 to 255 do count_values[i] := round((3*i*q)/255);
Port[PIT_CONTROL] := $90;
Port[SPEAKER_PORT] := Port[SPEAKER_PORT] or 3;
end;


procedure wav_intr;interrupt;

begin

{asm cli end;}
Port[PIT_CHANNEL_2] := count_values[table^[note]];
{asm sti end;}
inc(note);
if note>lsound then begin
                 note:=1;
                 stop;
                 end;

clock_ticks := clock_ticks + counter;

if clock_ticks >= $10000 then
    begin
      clock_ticks :=clock_ticks - $10000;
      asm pushf end;
      BIOSTimerHandler;
    end
  else
    Port[$20] := $20;
end;


procedure init_intr(tab:psnd;ls:word;freq:word);
begin
table:=tab;
lsound:=ls;
q:=pit_freq div (2*freq);
for i := 0 to 255 do count_values[i] := byte((3*i*q) div 255);
clock_ticks := 0;
counter:=q;{pit_freq div (44000);}
{GetIntVec(TIMERINTR, @BIOSTimerHandler);}
SetIntVec(TIMERINTR, @wav_intr);
Port[$43] := $34;
Port[$40] := (pit_freq div 11000) mod 255;
Port[$40] := (pit_freq div 11000) div 255;
note:=1;
Port[PIT_CONTROL] := $90;
Port[SPEAKER_PORT] := Port[SPEAKER_PORT] or 3;

end;


procedure wav_play;
var b1:byte;
begin

asm
cli
end;

for i:=1 to lsound do
    begin
    Port[PIT_CHANNEL_2] := count_values[table^[i]];
    for j:=1 to q-20 do begin end;
    end;
asm
sti
end;
Port[SPEAKER_PORT]:=Port[SPEAKER_PORT] and $FC;
Port[PIT_CONTROL]:=$B6;

end;


{$F-}
begin
new(table);
end.
