

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
	 codout: out number;
     t : in digit;   --0-afisare, 1-schimbare pin 2-adaug bani 3-scot bani
     corect: out std_logic:='0'
     );
end Memorie_RAM;

architecture Behavioral of Memorie_RAM is
signal t1 :std_logic;
signal x: std_logic_vector(1 downto 0):="00"  ;
signal numaratorul: std_logic_vector(1 downto 0):="00"  ; 
signal suma1 :number;
signal pin2:number;

begin
    process(clk,t,codin,numaratorul,sumin,PINin) 
	variable suma: pin:=(100,200,100,300,0);
	variable PIN1 : pin:=(1234,5678,0,0,0); 
	variable sum :number;
    begin	
		case codin is 
			when 1 => 
			suma1<=suma(1);
			pin2<=pin1(1);
			when 2 => 
			suma1<=suma(2);	
			pin2<=pin1(2);
			when 3 => 
			suma1<=suma(3);	
			pin2<=pin1(3);
			when 4 => 
			suma1<=suma(4);		 
			pin2<=pin1(4);
			when others=>
			suma1<=suma(0);	
			pin2<=pin1(0);
		end case ;
		
			if(numaratorul ="01")then
				if(t=2)then
				    sum:=suma1+sumin;	
				elsif(t=3) then	
					sum:=suma1-sumin;	
				end if;
			elsif(numaratorul="10")then
				suma(codin):=sum;
			end if;
			
			if(t=1)then 
				PIN1(codin):=PINin;
			end if ;
	  		sumout<=suma1;
	   		codout<=PIN2  ;
			   
			if(PIN2=pinin)then
				corect<='1';
			else
				corect<='0';
			end if;
    end process;
    
    --numaratorul
    process(clk,t1) 
	variable numarator: std_logic_vector(1 downto 0):="00"  ;
    begin
		if(clk'event and clk='1')then  
			x(0)<=numarator(0);
			x(1)<=numarator(1);
			numarator(0):=t1 and (x(1) or (not x(0)));
			numarator(1):=t1 and (x(0) or x(1) );
			numaratorul<=numarator;
		end if;
    end process;
t1<= '1' when (t=2 or t=3)else '0';

end Behavioral;
