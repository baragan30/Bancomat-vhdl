

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Memorie_RAM is
     Port ( 
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

begin
    process(t,codin) 
	variable suma: pin:=(0,0,0,0,0);
	variable PIN : pin:=(1234,1234,0,0,0);
	variable tcopy:digit:=4;
    begin	 
        if not(t=tcopy) then
        if(t=0) then
            if(PIN(codin)=PINin) then
                corect<='1';
            else
                corect<='0';
            end if;
        elsif t=1 then
            PIN(codin):=PINin;
        elsif t=2 then	
			if(suma(codin) < (9999-sumin) ) then
            suma(codin):= suma(codin)+sumin; 
			end if;
        elsif t=3 then
            if(suma(codin)>=sumin) then
                suma(codin):= suma(codin)-sumin;
            end if;
        end if;
   end if;	
   sumout<=suma(codin);
   codout<=PIN(codin)  ;
    end process;

end Behavioral;
