type x=array[1..50000] of byte;
     px=^x;
var p:px;
    i:integer;
begin
new(p);
for i:=1 to 20 do p^[i]:=2*i;
writeln;
for i:=1 to 20 do writeln(p^[i]);
end.