library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Interogare_bancnote is
     Port ( 
	 		clk:in std_logic;
	 		reset:in std_logic;
            pozitie_bancnota:out number;
            tip_bancnota:out number
          );
end Interogare_bancnote;

architecture Behavioral of Interogare_bancnote is 
signal x :arraybancnota;
begin  
	x<=(1,5,10,50,100,200,500);
	
    process(clk,reset)
	variable numarator1: number;
	begin 	  
		if (clk ='1')and (clk'event)  then

			if numarator1 =6 or reset='1' then
				numarator1:=0; 
			else
				numarator1:=numarator1+1;
			end if;
		end if;
		pozitie_bancnota<=numarator1;
		tip_bancnota<=x(numarator1);
		
	end process	 ;

end Behavioral;
