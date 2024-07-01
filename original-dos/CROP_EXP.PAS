program crop;
var f:file;
begin
assign(f,'explsion.wav');
reset(f,1);
seek(f,filesize(f)-320);
truncate(f);
close(f);
end.