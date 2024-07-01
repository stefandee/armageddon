program megalink;

type buf=array[1..60000] of byte;
     pbuf=^buf;

var fs,fd:file;
    p:pbuf;

begin

new(p);
assign(fd,'armaged.arm');rewrite(fd,1);

assign(fs,'bfw.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'base.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'tb.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'planes.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'planes1.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'planes2.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'heli.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'faces.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'keybord.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'mouse.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'atomic.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'help1.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'help2.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'help3.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'help4.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'help5.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'f1.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'f2.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'f3.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'f4.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'f5.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd1.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd2.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd3.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd4.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd5.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd6.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'hdd7.zpx');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'defender.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'zbase.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'aargh!.wav');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'explode.wav');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'intro2.wav');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
assign(fs,'scenery.arm');reset(fs,1);blockread(fs,p^,filesize(fs));blockwrite(fd,p^,filesize(fs));close(fs);
close(fd);
end.