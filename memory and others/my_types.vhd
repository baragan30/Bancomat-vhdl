library IEEE;
use IEEE.STD_LOGIC_1164.all;

package	my_types is   
    type switch is array (3 downto 0) of std_logic;
	subtype	digit is integer range 0 to 15;
	type array4digits is array (3 downto 0) of digit;
	subtype BCD is std_logic_vector (6 downto 0);
	type array4BCD is array (3 downto 0) of BCD;
	type array8BCD is array (7 downto 0) of BCD;
	subtype	number is integer range 0 to 10000;
	type pin is array (4 downto 0) of number;
	type arraybancnota is array (8 downto 0) of number;
end package;