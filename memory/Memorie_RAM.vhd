

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Memorie_RAM is
	Port (   
	 clk :in std_logic;
     codin: in number;
     PINin: in number;
     sumin: in number;
     sumout: out number;
     PINout: out number;
     t : in digit;   --0-afisare, 1-schimbare pin 2-adaug bani 3-scot bani
     corect: out std_logic
     );
end Memorie_RAM;

architecture Behavioral of Memorie_RAM is
signal t1 :std_logic;
signal x: std_logic_vector(1 downto 0):="00"  ;
signal numarator: std_logic_vector(1 downto 0):="00"  ; 





begin
    process(clk,t,codin,numarator,sumin,PINin) 
     variable suma: pin:=(100,200,100,300,0);
     variable PIN1 : pin:=(1234,5678,0,0,0); 
     variable sum :number; 
           begin	
            if(clk='1' and clk'event) then
			if(numarator ="01")then
				if(t=2)then
				    sum:=suma(codin)+sumin;	
				elsif(t=3) then	
					sum:=suma(codin)-sumin;	
				end if;
			elsif(numarator="10")then
				suma(codin):=sum;
			end if;
			
			if(t=1)then 
				PIN1(codin):=PINin;
			end if ;
	  		sumout<=sum;
	   		PINout<=PIN1(codin);
			   
			if(PIN1(codin)=pinin)then
				corect<='1';
			else
				corect<='0';
			end if;
			end if;
    end process;
    
    --numaratorul
    process(clk,t1,x) 
    begin
		if(clk'event and clk='1')then  
			x(0)<=numarator(0);
			x(1)<=numarator(1);
			numarator(0)<=t1 and (x(1) or (not x(0)));
			numarator(1)<=t1 and (x(0) or x(1) );
		end if;
    end process;
t1<= '1' when (t=2 or t=3)else '0';

end Behavioral;
