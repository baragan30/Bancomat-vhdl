

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;


use IEEE.NUMERIC_STD.ALL;

entity Digit_to_BCD is
  Port ( 
  sw:in digit;
  afisor:out BCD);
end Digit_to_BCD;

architecture digit_to_BCD of Digit_to_BCD is
begin	  --segements1(0)(0)
     afisor<=
     "0000001" when sw=0 else --0
     "1001111" when sw=1 else --1
     "0010010" when sw=2 else --2
     "0000110" when sw=3 else --3
     "1001100" when sw=4 else --4
     "0100100" when sw=5 else --5
     "0100000" when sw=6 else --6
     "0001111" when sw=7 else --7
     "0000000" when sw=8 else --8
     "0000100" when sw=9 else --9 
	 "1111111" when sw=10 else-- nothing
     "0110000" when sw=11 else --E
     "1101010" when sw=12 else --r
	 "1001000" when sw=13 else --K
	 "1100010" when sw=14 else --0
     "1111110";                -- -

end digit_to_BCD;