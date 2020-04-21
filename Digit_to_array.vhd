----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2020 03:40:00 PM
-- Design Name: 
-- Module Name: Digit_to_array - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library xil_defaultlib;
library digit_into_array;
library and_gate;
use work.my_types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity Digit_to_BCD is
  Port ( 
  sw:in digit;
  afisor:out BCD);
end Digit_to_BCD;

architecture a_digit_to_BCD of Digit_to_BCD is
begin
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
     "0110000";--E de la eroare

end a_digit_to_BCD;