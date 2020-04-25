

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Memorie_RAM is
     Port ( 
     codin: in number;
     PINin: in number;
     PINout: out number;
     sumin: in number;
     sumout: out number;
     t : in digit;   --0-afisare, 1-schimbare pin 2-adaug bani 3-scot bani
     corect: inout std_logic:='0'
     );
end Memorie_RAM;

architecture Behavioral of Memorie_RAM is

signal suma: pin:=(0,0,0,0);
signal PIN : pin:=(1234,6969,0000,420);
begin
    PINout<=PIN(codin);
    sumout<=suma(codin);
    process(t)
    begin
        if t'event then
        if(t=0) then
            if(PIN(codin)=PINin) then
                corect<='1';
            else
                corect<='0';
            end if;
        elsif t=1 then
            PIN(codin)<=PINin;
        elsif t=2 then
            suma(codin)<= suma(codin)+sumin;
        elsif t=3 then
            if(suma(codin)>=sumin) then
                suma(codin)<= suma(codin)-sumin;
           -- else
                -- Mesaj de eroare
            end if;
        end if;
    end if;
    end process;

end Behavioral;
