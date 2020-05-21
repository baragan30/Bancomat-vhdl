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
	x<=(500,200,100,50,20,10,5,2,1);
	
    process(clk,reset,x)
	variable numarator1: number;
	begin 	  
		if (clk ='1')and (clk'event)  then
			if(reset='0')then 
				if numarator1 =0 then
					numarator1:=8; 
				else
					numarator1:=numarator1-1;
				end if;
			end if;
		end if;
		pozitie_bancnota<=numarator1;
		tip_bancnota<=x(numarator1);
	end process	 ;

end Behavioral;
