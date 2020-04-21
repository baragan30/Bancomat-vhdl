
library IEEE;
use IEEE.STD_LOGIC_1164.all; 

use work.my_types.all;

entity Display_number is  
	port (
	numar:in number;
	signals:out array4BCD
	);
end Display_number;
	

architecture Display_number of Display_number is 
signal cifre:array4digits;
begin
	
	process(numar)
	variable x :number;
	begin
		x:=numar;
		for I in 0 to 3 loop
			cifre(I)<=(x rem 10);
			x:=x/10;
		end loop;
	end process;


end Display_number;
