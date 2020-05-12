
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clock100khz is
		port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end clock100khz;



architecture clock100khz of clock100khz is

begin
	process(clockin)
	variable numarator1: integer range 0 to 1001:=0;
	begin 	  
		if (clockin ='1')and (clockin'event)  then
			numarator1:=numarator1+1;
			if numarator1 =1000 then
				numarator1:=0; 
				clockout<=(not clockout);
			end if;
		end if ;
	end process	; 

end clock100khz;
