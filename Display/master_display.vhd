library IEEE;
use IEEE.STD_LOGIC_1164.all;  

use work.my_types.all;

entity Display_to_BCD is
	port (
	CLK :in std_logic;
	intreg1:in number;
	intreg2:in number;
	afisor:out BCD;
	segments:out std_logic_vector(7 downto 0)
	);
end Display_to_BCD;

architecture Display_to_BCD of Display_to_BCD is 
component Display_number is  
	port (
	numar:in number;
	signals:out array4BCD
	);
end component;

component Clock1khz is	
		port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end component;

signal BCDs :array8BCD; 
signal BCDs1 :array4BCD;
signal BCDs2 :array4BCD;
signal CLK1khz : std_logic := '0';
begin  
	G1: Display_number port map(intreg1,BCDs1);	 
	G3: Display_number port map(intreg2,BCDs2);
	G2:Clock1khz port map (CLK,CLK1khz);
	BCDs(0)<=BCDs1(0);
	BCDs(1)<=BCDs1(1);
	BCDs(2)<=BCDs1(2);
	BCDs(3)<=BCDs1(3);
	BCDs(4)<=BCDs2(0);
	BCDs(5)<=BCDs2(1);
	BCDs(6)<=BCDs2(2);
	BCDs(7)<=BCDs2(3);
	
	process (CLK1khz)
	variable numarator : integer range 0 to 8;
	begin	
		if (CLK1khz='1' and CLK1khz'event) then 
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

end Display_to_BCD;
