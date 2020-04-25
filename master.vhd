library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.my_types.all;

entity master is
	port (
	sw :in switch;
	ok,back,exi:std_logic;
	clk:in std_logic;	
	afisor:out BCD  ;
	segments:out std_logic_vector(7 downto 0)
	);
end master;

architecture master of master is 
--------------------------------------clock-uri---------------------------------------
 component clock02sec is 
	port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end component;	
component Clock1khz is	
		port (
	clockin :in std_logic;
	clockout :inout std_logic
	);
end component;

component read_integer is
  Port (
  clk: in std_logic;
  sw: in switch;
  numar: out number);
end component;	
---------------------------------------entitati display---------------------------
component number_to_digits is  
	port (
	numar:in number;
	digits:out array4digits
	);
end component;	
component master_display is
	port (
	CLK :in std_logic;
	cifre1:in array4digits;
	cifre2:in array4digits;
	afisor:out BCD;
	segments:out std_logic_vector(7 downto 0)
	);
end component;

--------------------------------------------semnale--------------------------------------
signal clk02s :std_logic;	
signal clk1khz:std_logic;
---------------Display
signal afisor1:array4digits;
signal afisor2:array4digits;
signal cifre1:array4digits;
signal cifre2:array4digits; 
signal numar:number:=0;
signal numar1:number:=0;
signal numar2:number:=0; 
------------------RAM
signal pin:number;
signal cod:number;
signal corect:std_logic;--daca pinul e corect


begin 	   

-------------------------------------------organigrama---------------------------------------
	process(clk) 
	variable stare :number:=0;
	begin 
		case stare is 
----------------------------------------START---------------------------------------------
			when 0 =>  
				if (ok= '1' and ok'event)then
					if(sw="0000")then 
						stare:=2;
					elsif(sw="0001")then 
						stare:=1;
					end if;
				end if ;
				numar1<=stare ;
				afisor1 <= cifre1;
				afisor2 <= (0,0,0,0);
--------------------------------------ADMIN-----------------------------------------------
			when 1=> 
				if (ok= '1' and ok'event)then
					if(corect='1')then 
						stare:=3;  
					end if;
				elsif (back= '1' and back'event)then
					stare:=0;  
				elsif (exi= '1' and exi'event)then
					stare:=0;
				end if ; 
				cod<=0;
				pin<=numar;
				numar2<=numar ;
				numar1<=stare ;
				afisor1 <= cifre1;
				afisor2 <= cifre2; 
------------------------------------SELECTOR ADMIN---------------------------------------
			when others =>stare:=stare ;
		end case;
		
		
	end process; 
	
	c1:clock02sec port map(clk,clk02s); 
	c2:Clock1khz port map (clk,clk1khz);
	G1:read_integer port map (clk02s,sw,numar);
	G2:number_to_digits port map(numar1,cifre1); 
	G3:number_to_digits port map(numar2,cifre2);
	
	Af1:master_display port	map(clk1khz,cifre1,cifre2,afisor,segments);

end master;
