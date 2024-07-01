program decompress;
uses graph;
var fs:file of byte;
    gd,gm,i,j,min,cnt,x,y:integer;
    k:longint;
    b1,b2,b3,mask,nr:byte;
    pal:array[1..256,1..3] of byte;

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
         setrgbpalette(i,pal[i+1,1],pal[i+1,2],pal[i+1,3]);
    end;
close(fs);
assign(fs,'arm5.cpr');
reset(fs);
read(fs,mask);
x:=0;y:=0;
repeat
      read(fs,b1);
      if b1=mask then begin
                      read(fs,b2);
                      read(fs,b3);
                      for i:=1 to b3 do
                          begin
                               putpixel(x,y,b2);
                               inc(x);
                               if x>319 then begin
                                             x:=0;
                                             inc(y);
                                             end;
                          end;
                      end
                 else begin
                      putpixel(x,y,b1);
                      inc(x);
                      if x>319 then begin
                                    x:=0;
                                    inc(y);
                                    end;
                      end;

until eof(fs);
readln;
end.