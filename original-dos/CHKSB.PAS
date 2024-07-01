uses sbdsp;
var i : integer;
    sbbase : integer;
begin
sbbase:=0;
for i:=1 to 9 do
    begin
    writeln('Checking $2',i,'0');
    if resetdsp(i)
    then begin
         sbbase:=2*256+i*16+0;
         break;
         end
    end;
if sbbase<>0 then writeln('SB on $2',i,'0');
end.
