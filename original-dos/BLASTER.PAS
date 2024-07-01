blast_env:=getenv('BLASTER');
if blast_env='' then begin
                     writeln('No SoundBlaster environment string found.');
                     writeln('Searching manually for SB...
                     writeln('Possibly you have one hidden in your computer.');
                     for i:=1 to 9 do if resetdsp(i)
                         then begin
                              sbbase:=2*256+i*16+0;
                              device:=blaster;
                              break;
                              end;
                     if sbbase=0
                        then begin
                             writeln('I really can''t find a blaster');
                             writeln('I will run with quitely.');
                             device:=speaker;
                             end;
                    end
               else begin
                    sb_digit:=fval(blast_env[3]);
                    resetdsp(sb_digit);
                       {then begin
                            writeln('SoundBlaster not responding at BLASTER environment settings.');
                            halt;
                            end;}
                    device:=blaster;
                    sbbase:=2*256+sb_digit*16;
                    end;
