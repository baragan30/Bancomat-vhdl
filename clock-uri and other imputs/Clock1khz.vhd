

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Clock1khz is	
		port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end Clock1khz;

--}} End of automatically maintained section

architecture Clock1khz of Clock1khz is
begin
	process(clockin)
	variable numarator1: integer range 0 to 100_001:=0;
	begin 	  
		if (clockin ='1')and (clockin'event)  then
			numarator1:=numarator1+1;
			if numarator1 =100_000 then
				numarator1:=0; 
				clockout<=(not clockout);
			end if;
		end if ;
	end process	; 
end Clock1khz;
