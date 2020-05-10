

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Memorie_RAM_bancnote is
  Port ( 
  t: in std_logic;
  cantitate_bancnote_in: in arraybancnota;	
  cantitate_bancnote_out: out arraybancnota);
end Memorie_RAM_bancnote;

architecture Behavioral of Memorie_RAM_bancnote is

begin
    process(t,cantitate_bancnote_in)
	variable cant: arraybancnota:=(20,20,20,20,20,20,20);
    begin
    if(t='1') then
   		cant:=cantitate_bancnote_in;  
    end if;	  
	cantitate_bancnote_out<=cant;
    end process;
end Behavioral;
