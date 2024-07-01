i:=1;

  while resetdsp(i)<>true do
        begin
        inc(i);
        if i>=10 then begin
                      writeln('SBlaster not available.');
                      writeln('Better try asm_ide for evaluation');
                      halt;
                      end;
        end;

base:=2*256+i*16+0;
