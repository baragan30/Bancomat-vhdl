library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.my_types.all;

entity master is
	port (
	sw :in switch;
	test_clock:in std_logic;	
	afisor:out BCD  ;
	segments:out std_logic_vector(7 downto 0)
	);
end master;

architecture master of master is 
 component clock02sec is 
	port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end component;
component read_integer is
  Port ( 
  clk: in std_logic;
  sw: in switch;
  numar: out number);
end component;	

component Display_to_BCD is
	port (
	CLK :in std_logic;
	intreg1:in number;
	intreg2:in number;
	afisor:out BCD;
	segments:out std_logic_vector(7 downto 0)
	);
end component;

signal clock02s :std_logic;
signal number1:number:=0;
signal number2:number:=0;
begin 	
	
	G1:clock02sec port map(test_clock,clock02s); 
	G2:read_integer port map (clock02s,sw,number1);
	G3:Display_to_BCD port map (test_clock,number1,number2,afisor,segments);

end master;
