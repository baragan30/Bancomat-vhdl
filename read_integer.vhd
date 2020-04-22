

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.my_types.all;


entity read_integer is
  Port ( 
  clk: in std_logic;
  sw: in switch;
  numar: inout array4digits);
end read_integer;

architecture a_read_integer of read_integer is

begin
    process(sw)
    variable y: array4digits;
    begin
    if clk= '1' then
        for I in 0 to 3 loop
            if y(I)=9 then
                y(I):=0;
                y(I+1):=y(I+1)+1;
            end if;
            if sw(I)= '1' then 
                y(I):=y(I)+1;
            end if; 
        end loop;
    end if;
    for I in 0 to 3 loop
    numar(I)<=y(I);
    end loop;
    end process;

end a_read_integer;
