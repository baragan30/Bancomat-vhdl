library IEEE;
use IEEE.STD_LOGIC_1164.all;  

use work.my_types.all;

----------------se introduce clock-ul (viteza la care se doreste sa se afiseze-------------
-----------------------------------cifrele-------------------------------------------------	
-------------------------------De preferabil 1khz------------------------------------------------
entity master_display is
	port (
	CLK :in std_logic;
	cifre1:in array4digits;
	cifre2:in array4digits;
	afisor:out BCD;
	segments:out std_logic_vector(7 downto 0)
	);
end master_display;

architecture master_display of master_display is 
component Digit_to_BCD is
  Port ( 
  sw:in digit;
  afisor:out BCD);
end component;

signal BCDs :array8BCD; 
begin  
	G1: Digit_to_BCD port map(cifre1(0),BCDs(0));
	G2: Digit_to_BCD port map(cifre1(1),BCDs(1));
	G3: Digit_to_BCD port map(cifre1(2),BCDs(2));
	G4: Digit_to_BCD port map(cifre1(3),BCDs(3));
	G5: Digit_to_BCD port map(cifre2(0),BCDs(4));
	G6: Digit_to_BCD port map(cifre2(1),BCDs(5));
	G7: Digit_to_BCD port map(cifre2(2),BCDs(6));
	G8: Digit_to_BCD port map(cifre2(3),BCDs(7)); 
	
	process (CLK)
	variable numarator : integer range 0 to 8;
	begin	
		if (CLK='1' and CLK'event) then 
			if(numarator=7)then 
				numarator:=0;
			else
				numarator:=numarator+1;
			end if;
			afisor<=BCDs(numarator);
			segments<= (others =>'1');
			segments(numarator)<='0' ;
				
		end if;		
		
	end process;

end master_display;
