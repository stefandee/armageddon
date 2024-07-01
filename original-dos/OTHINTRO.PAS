program EXTRO;
uses crt,dos,graph;
type arr=array[0..199,0..319] of byte;
var adrp:word;
    chiu:string;
    ff:file of byte;
    me:array[0..199,0..319] of byte absolute $0a000:0;
    rrr:array[0..26,0..187] of byte;
    rr:array[0..31,0..217] of byte;
    r:array[0..111,0..88] of byte;
    cc:array[0..255,1..3] of byte;
    k,i,j:integer;
procedure moveo(var sursa, dest; count:word);
begin
asm
mov dx,ds;
lds si,sursa;
les di,dest;
mov cx,count;
shr cx,1;
cld;
rep movsw;
jnc @sfarsit;
movsb;
@sfarsit:
mov ds,dx;
end;
end;
procedure initg;
begin
asm
mov ax,13h
int 10h
mov ax,0a000h
mov es,ax
end;
end;
procedure xsetcolor(cul:byte;re,gr,blu:byte);
var
igr,iblu,ire:byte;
begin
igr:=gr;
ire:=re;
iblu:=blu;
asm
mov ah,$10
mov al,$10
mov bh,0
mov bl,cul
mov ch,igr
mov cl,iblu
mov dh,ire
int 10h
end;
end;
begin
assign(ff,'arm5.pcx');
reset(ff);
seek(ff,filesize(ff)-768);
initg;
for i:=0 to 255 do begin
read(ff,cc[i,1]);
end;
for i:=0 to 255 do begin
read(ff,cc[i,2]);
end;
for i:=0 to 255 do begin
read(ff,cc[i,3]);
end;
for i:=0 to 255 do xsetcolor(i,cc[i,1],cc[i,2],cc[i,3]);
for j:=1 to 199 do
for i:=1 to 319 do
me[j,i]:=j;
readln;
end.