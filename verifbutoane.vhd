library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.my_types.all;

entity master is
	port (
	sw :in switch;
	ok1,back1,exi1:std_logic;
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


component button_converter is 

	port(	

	buttonin :in std_logic ;

	clk :in std_logic   ;

	buttonout:out std_logic

	

	);

end component;
----------------------------------------------RAM-uri----------------------------------
 component Memorie_RAM is
     Port ( 
     codin: in number;
     PINin: in number;
     sumin: in number;
     sumout: out number;
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
signal corect:std_logic;--daca pinul e corect
signal semnalRAM:digit:=4;
signal ok:std_logic;
signal back:std_logic;
signal exi:std_logic;

begin 	   
	numar1<=numar;
	cifre2(0)<=1 when ok='1' else 0;
	cifre2(1)<=1 when back='1' else 0;
	cifre2(2)<=1 when exi='1' else 0;
    cifre2(3)<=0;
    
	c1:clock02sec       port map(clk,clk02s); 
	c2:Clock1khz        port map(clk,clk1khz);
	B1:button_converter port map(ok1,clk1khz,ok);
	B2:button_converter port map(back1,clk1khz,back);
	B3:button_converter port map(exi1,clk1khz,exi);
	G1:read_integer     port map(clk02s,sw,numar);
	G2:number_to_digits port map(numar1,cifre1); 
	G3: Memorie_RAM     port map(cod,pin,sumin,sumout,semnalRAM,corect);
	
	Af1:master_display port	map(clk1khz,cifre2,cifre1,afisor,segments);	

end master;
