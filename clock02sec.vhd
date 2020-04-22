
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clock02sec is 
	port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end clock02sec;


architecture clock02sec of clock02sec is
begin
	process(clockin)
	variable numarator1: integer range 0 to 1_000_000;
	variable numarator2: integer range 0 to 45;
	begin 	  
		if not(clockout='0'or clockout ='1') then
			clockout<='0';
		end if;
		if (clockin ='1')  then
			numarator1:=numarator1+1;
			if numarator1 =1_000_000 then
				numarator1:=0;
				clockout<=(not clockout);
			end if;
		end if ;
		
		
		
	end process	; 
		

end clock02sec;
