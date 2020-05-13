
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.my_types.all ;

entity registru_digit is
	 port(
	 clk : in STD_LOGIC;
	 
	 datein:in digit;
	 dateout:out digit
	     );
end registru_digit;

--}} End of automatically maintained section

architecture registru_digit of registru_digit is
begin
	process(datein,clk)
	begin
	    if(clk='1' and clk'event) then
			if(datein<15)then
				dateout<=datein;
			end if;
		end if;
	end process;
end registru_digit;
