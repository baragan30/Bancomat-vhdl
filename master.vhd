library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.my_types.all;

entity master is
	port (
	sw :in switch;
	clock:in std_logic;	
	afisor:out BCD  ;
	segments:out std_logic_vector(7 downto 0)
	);
end master;

--}} End of automatically maintained section

architecture master of master is 
 component clock02sec is 
	port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end component;
component Display_number is  
	port (
	numar:in number;
	signals:out array4BCD
	);
end component;
component read_integer is
  Port ( 
  clk: in std_logic;
  sw: in switch;
  numar: out number);
end component;

signal afisor1: array4BCD;
signal clock02s :std_logic;
signal number1:number;
begin 
		
	
G1:clock02sec port map(clock,clock02s); 
G2:Display_number port map(number1,afisor1);
G3:read_integer port map (clock02s,sw,number1);

end master;
