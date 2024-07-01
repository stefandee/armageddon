program link_present;
type buf=array[1..65000] of byte;
     pbuf=^buf;

var fs,fd:file;
    p:pbuf;

begin

new(p);
assign(fd,'first.arm');rewrite(fd,1);

assign(fs,'arm5.1');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'arm5.2');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'arm6.1');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'arm6.2');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'arm7.1');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'arm7.2');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);

close(fd);
end.