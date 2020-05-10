library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity button_converter is 
	port(	
	buttonin :in std_logic ;
	clk :in std_logic   ;
	buttonout:out std_logic
	
	);
end button_converter;


architecture button_converter of button_converter is  
	signal s:std_logic_vector (15 downto 0);
begin
	process (clk) 
	variable starebutton :std_logic_vector (15 downto 0) :="0000000000000000";
	variable numarator :integer range 0 to 15 ;
	begin  	
		if(clk'event and clk='0')then
			if ((numarator < 15)and (buttonin='1')) then
			numarator:=numarator+1;
			else numarator:=0;
			end if;
			if (buttonin='1') then
				starebutton(numarator):=buttonin; 
			else 
				starebutton:="0000000000000000";
			end if;
		end if ;
		s<=starebutton;
	end process; 
	buttonout<= (((not s(0)and s(1)) and ( s(2)and s(3))) and 
				((s(4)and s(5)) and ( s(6)and s(7))) )and
				(((s(8)and s(9)) and ( s(10)and s(11))) and
				((s(12)and s(13)) and ( s(14) and (s(15) ))) );
		
	

end button_converter;
