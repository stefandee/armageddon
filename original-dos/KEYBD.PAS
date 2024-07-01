program keybd;
uses crt;
var old,c:byte;
begin
clrscr;
repeat
c:=port[$60];
if c=172 then begin
              delay(100);
              c:=port[$60];
              if c=152 then begin
                            gotoxy(20,20);
                            write('diag pressed');
                            delay(1000);
                            gotoxy(20,20);
                            write('            ');
                            end;
              end;
if c=152 then begin
              delay(100);
              c:=port[$60];
              if c=172 then begin
                            gotoxy(20,20);
                            write('diag pressed');
                            delay(1000);
                            gotoxy(20,20);
                            write('            ');
                            end;
              end;


until false;
end.