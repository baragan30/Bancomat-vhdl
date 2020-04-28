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
----------------------------------------------RAM-uri----------------------------------
 component Memorie_RAM is
     Port ( 
	 clk :in std_logic;
     codin: in number;
     PINin: in number;
     sumin: in number;
     sumout: out number;
	 codout: out number;
     t : in digit;   --0-afisare, 1-schimbare pin 2-adaug bani 3-scot bani
     corect: out std_logic:='0'
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
signal sumin: number;
signal sumout: number;
signal codout: number;
signal corect:std_logic;--daca pinul e corect
signal semnalRAM:digit:=4;


begin 	   
	process(clk02s)
	variable stare :number :=0;
	begin 
		if(clk02s'event and clk02s='1')	 then  
			if(stare < 12)then
			stare:=stare+1;	
			else stare:=0;
			end if ;
		end if ; 
		case stare is 
			when 0=>
			pin<=1234;
			semnalRAM<=0;
			when 1=> 
			pin<=2345 ;
			semnalRAM<=0;
			when 2=>
			semnalRAM<=1;
			pin<=2345;
			when 3=>
			pin<=1234;
			semnalRAM<=0;
			when 4=> 
			semnalRAM<=1;
			pin<=1234; 
			when 5=>
			semnalRAM<=0;
			pin<=1234;
			when 6=>
			semnalRAM<=4;
			pin<=2345  ; 
			when 7=>
			sumin<=100;
			semnalRAM<=2; 
			when 8=>
			sumin<=100;
			semnalRAM<=2;
			when 9=>
			semnalRAM<=0;
			when 10=> 
			sumin<=25;
			semnalRAM<=3;
			when 11=>
			SEMNALRAM<=0;
			when 12=> 
			semnalRAM<=3;
			sumin<=5;
			when others => 
			stare:=stare; 
		end case;
	end process; 
	cod<=0;
	numar2<=sumout;
	numar1<=codout;
	afisor1<=cifre1;
	afisor2<= cifre2;

	c1:clock02sec       port map(clk,clk02s); 
	c2:Clock1khz        port map (clk,clk1khz);
	G1:read_integer     port map (clk02s,sw,numar);
	G2:number_to_digits port map(numar1,cifre1); 
	G3:number_to_digits port map(numar2,cifre2); 
	G4: Memorie_RAM     port map(clk1khz,cod,pin,sumin,sumout,codout,semnalRAM,corect);
	
	Af1:master_display port	map(clk1khz,afisor2,afisor1,afisor,segments);	

end master;
