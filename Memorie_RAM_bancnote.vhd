

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Memorie_RAM_bancnote is
  Port ( 
  t: in std_logic;
  cantitate_bancnote: inout arraybancnota);
end Memorie_RAM_bancnote;

architecture Behavioral of Memorie_RAM_bancnote is
signal cant: arraybancnota:=(20,20,20,20,20,20,20);
begin
    process(t)
    begin
    if(t='0') then
    cantitate_bancnote<=cant;
    else
    cant<=cantitate_bancnote;
    end if;
    end process;
end Behavioral;
