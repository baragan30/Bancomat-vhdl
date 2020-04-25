
library IEEE;
use IEEE.STD_LOGIC_1164.all; 

use work.my_types.all;

entity number_to_digits is  
	port (
	numar:in number;
	digits:out array4digits
	);
end number_to_digits;
	

architecture Display_number of number_to_digits is 
begin
	
	process(numar)
	variable x :number;
	begin
		x:=numar;
		for I in 0 to 3 loop
			digits(I)<=(x rem 10);
			x:=x/10;
		end loop;
	end process; 

end Display_number;
