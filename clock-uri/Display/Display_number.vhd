
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
component Digit_to_BCD is
  Port ( 
  sw:in digit;
  afisor:out BCD);
end component;

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
	G0:Digit_to_BCD port map (cifre(0),signals(0));
	G1:Digit_to_BCD port map (cifre(1),signals(1));
	G2:Digit_to_BCD port map (cifre(2),signals(2));
	G3:Digit_to_BCD port map (cifre(3),signals(3));


end Display_number;
