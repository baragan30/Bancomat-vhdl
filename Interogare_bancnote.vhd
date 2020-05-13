

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Interogare_bancnote is
     Port ( 
            clk:in std_logic;
            codout:out number;
            tip_bancnota:out number
          );
end Interogare_bancnote;

architecture Behavioral of Interogare_bancnote is
signal numarator:number:=501;
signal pozitie:number:=6;
signal bancnota_curenta:number:=0;
begin
    process(clk)
    begin
        
         
        if(clk='1' and clk'event) then
            if(numarator=0)then
            numarator<=501;
            else
            numarator<=numarator-1;
            end if;
            if(numarator=1 or numarator=5 or numarator=10 or numarator=50 or 
               numarator=100 or numarator=200 or numarator=500) then

            pozitie<=pozitie+1;
            
            bancnota_curenta<=numarator;
            end if;
            if(pozitie=7)then
            pozitie<=0;
            end if;
            tip_bancnota<=bancnota_curenta;
            codout<=pozitie;
        end if;
        
    end process;

end Behavioral;
