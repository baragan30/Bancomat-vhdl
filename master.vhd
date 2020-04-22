library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.my_types.all;

entity master is
	port (
	sw :in switch;
	ok :in std_logic;
	clock:in std_logic;
	segments1:out array4BCD;
	segments2:out array4BCD
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


signal change :std_logic; 
signal clock2s :std_logic;
signal number1:number;
signal number2:number;	 
signal number3:number;
begin 
	process(clock)	 --initializare
	begin 
		if not(change='1'or change='0')then 
			change<='0';	
		elsif(clock2s='1' and ok ='1')then
			change<=not change ;
		end if;	
	end process	;
	
	process(clock)
	begin	
		if(change='0'and change'event )then
			number1<=number2;
			number2<=0;	
		elsif (change ='1') then
			number2<=number3;
		end if;
	end process;
G1:clock02sec port map(clock,clock2s); 
G2:Display_number port map(number1,segments1);
G3:Display_number port map(number2,segments2);
G4:read_integer port map (clock2s,sw,number3);

end master;
