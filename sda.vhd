
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sda is  
	port(
	clk:in std_logic;
	load:in std_logic;	
	reset:in std_logic;
	date_in:in std_logic_vector(7 downto 0);
	serial_in:in std_logic ;
	deplasare:in std_logic;
	date_out:out std_logic_vector(7 downto 0)
	);
	
end sda;

architecture sda of sda is
signal inventiv:std_logic_vector(7 downto 0);
begin
	process(clk,load,reset,date_in,serial_in,deplasare,inventiv)
	begin 
	    
		if(clk'event and clk='1')then
			if(load='1')then 
				inventiv <=date_in;
			elsif(reset='1')then
				inventiv<="00000000";
			elsif(deplasare='1')then
				for I in 7 downto 1 loop
					inventiv(I)<=inventiv(I-1);
				end loop ;
				inventiv(0)<=serial_in;
			end if ;
		end if;
		date_out<=inventiv;
	end process	;

	 

end sda;
