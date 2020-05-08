library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Display_conturi is
  Port ( 
  clk:in std_logic;
  numaratorul:out std_logic_vector(2 downto 0));
end Display_conturi;

architecture Behavioral of Display_conturi is
begin

process(clk) 
	variable numarator: std_logic_vector(2 downto 0):="100"  ;
    begin
		if(clk'event and clk='1')then  
			if(numarator="000") then
			     numarator:="001";
			elsif (numarator="001") then
			     numarator:="010";
			elsif (numarator="010") then
			     numarator:="011";
			elsif (numarator="011") then
			     numarator:="100";
			elsif (numarator="100") then
			     numarator:="000";
			end if;
			numaratorul<=numarator;
		end if;
    end process;
  
end Behavioral;
