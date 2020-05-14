library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.my_types.all;

entity registru is
	 port(
	 clk : in STD_LOGIC;
	 datein:in number;
	 dateout:out number
	     );
end registru;


architecture \register\ of registru is
begin	 
	process(datein,clk)
	begin
	    if(clk='1' and clk'event) then
			if(datein<10000)then
				dateout<=datein;
			end if;
		end if;
	end process;
	

end \register\;
