
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package	my_types is   
	subtype	digit is integer range 0 to 10;
	type array4digits is array (3 downto 0) of digit;
	subtype BCD is std_logic_vector (6 downto 0);
	type array4BCD is array (3 downto 0) of BCD;
	
	
end package;

