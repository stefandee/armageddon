program top;
type hiscr=array[1..10] of string[23];
const hs:hiscr=( 'PHANE            90000',
                 'ALECSEI          80000',
	              'BLUEFLOWER       70000',
	              'MANOWAR          60000',
	              'MASTER           55000',
	              'GUILE            50000',
	              'SONIC            45000',
	              'VEGA             40000',
	              'RYU&KEN          30000',
	              'BLANKA           25000');
VAR fil:file of hiscr;
begin
assign(fil,'DEfender.arm');
rewrite(fil);
write(fil,hs);
end.
