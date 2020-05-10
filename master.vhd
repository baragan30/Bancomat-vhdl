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
component clock100khz is
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
component button_converter is 

	port(	

	buttonin :in std_logic ;

	clk :in std_logic   ;

	buttonout:out std_logic

	);

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
signal clk100khz:std_logic;	 
signal ok:std_logic;
signal back:std_logic;
signal exi:std_logic;
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
signal pinout: number;
signal corect:std_logic;--daca pinul e corect
signal semnalRAM:digit;
-----------------RAM_bacnote 




---------------------diverse
signal stare:number:=0;
signal backstare:number:=0;
signal nextstare:number:=0;
signal sari :std_logic:='0';
begin 	
	
	process(stare,cifre1,cifre2,sw,numar,corect,sumin,sumout)
	variable codcopy:number:=0;
	variable coddestinatie:number:=0;
	variable codsursa:number:=0;
	variable numarator :digit:=0; 
	begin 
		cod<=codcopy;
		case stare is
----------------------------------------------------------Start---------------------------------------------------
			when 0=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);	
			backstare<=0;
			case sw is 
				when "0010" =>nextstare<=1;
				when "0001" =>nextstare<=2;	
				when others => nextstare<=0;
			end case;
--------------------------------------------------------Admin-------------------------------------------------
          when 1=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			codcopy:=0;	
			if corect='1'then
				nextstare<=3;
			end if;
			backstare<=0;
--------------------------------------------------------Selector Admin------------------------------------------------
			when 3=>
			numar2<=stare;
			afisor2<=cifre2;
			afisor1<=(0,0,0,0);	 
			backstare<=1; 
			case sw is 
				when "0001" =>nextstare<=1;
				when "0010" =>nextstare<=2;	
				when "0100" =>nextstare<=1;
				when "1000" =>nextstare<=2;
				when others => nextstare<=3;
			end case;
			
----------------------------------------------------Client card-------------------------------------
			when 2=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			codcopy:=numar;
			if(numar>0and numar <5)	 then
				nextstare<=4;	
			end if;
			backstare<=0;
			
			
--------------------------------------------------------Client PIN------------------------------------------------
			when 4=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			if corect='1'then
				nextstare<=5;
			end if;
			backstare<=2;
-------------------------------------------------------------Selector client-----------------------------------------
			when 5=>
			numar2<=stare;
			afisor2<=cifre2;
			afisor1<=(0,0,0,0);
			backstare<=2; 
			case sw is 
				when "0001" =>nextstare<=51;
				when "0010" =>nextstare<=53;	
				when "0100" =>nextstare<=53;	
				when "0110" =>nextstare<=54;
				when "1000" =>nextstare<=55;
				when others => nextstare<=5;
			end case; 

----------------------------------------------------------Interogare Sold Client -------------------------------------
			when 53=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=sumout;
			afisor1<=cifre1; 
			

			
			nextstare<=5;
			backstare<=5;	
----------------------------------------------------------Transfer-introducere cod -------------------------------------
			when 54=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			coddestinatie:=numar;
			codsursa:=codcopy;
			if(numar<5)then
				nextstare<=541;
			else
				nextstare<=548;
			end if ;   
			backstare<=5;  
----------------------------------------------------------Transfer-introducere suma -------------------------------------
			when 541=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sumin<=numar;
			nextstare<=542;
			backstare<=54;
-------------------------------------------------------verificare suma cont sursa  -------------------------------------
			when 542=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			if(sumout>sumin)then 
				nextstare<=543; 
			else 
				nextstare<=598;
			end if;
			sari<='1';
			backstare<=5;	
----------------------------------------------------------verificare suma cod destinatie -------------------------------------
			when 543=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			codcopy:=coddestinatie;
			if((sumout+sumin<1000))then 
				nextstare<=544; 
			else 
				nextstare<=598;
			end if;
			sari<='1';
			backstare<=5;
----------------------------------------------------------Transfer-adaugare suma -------------------------------------
			when 544=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			semnalRAM<=2;
			nextstare<=545;
			sari<='1';
			backstare<=5;	
----------------------------------------------------------Transfer-stabilizare-------------------------------------
			when 545=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			codcopy:=codsursa;
			semnalRAM<=0;
			nextstare<=546;
			sari<='1';
			backstare<=5;	
----------------------------------------------------------Transfer-scoatere bani-------------------------------------
			when 546=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			semnalRAM<=3;
			nextstare<=599;
			sari<='1';
			backstare<=5;
			
----------------------------------------------------------------Schimbare PIN 1-------------------------------------
			when 55=> 
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			nextstare<=551;	
			backstare<=5;
			
			
------------------------------------------------------------Schimbare PIN 2-------------------------------------
			when 551=> 
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sari<='1';
			semnalRAM<=1;
			nextstare<=599;	
			backstare<=5; 
--------------------------------------------------------Client afisare ok-----------------------------------------------
			when 599=>
			numar2<=stare;
			afisor2<=cifre2;
			afisor1<=(10,10,0,13); 
			
			semnalRAM<=0;
			nextstare<=5;
			sari<='0';
			backstare<=5;
--------------------------------------------------------Client afisare eroare-----------------------------------------------
			when 598=>
			numar2<=stare;
			afisor2<=cifre2;
			afisor1<=(11,12,14,12); 
			
			semnalRAM<=0;
			nextstare<=5;
			sari<='0';
			backstare<=5;
			
			
			when others => 
			afisor2<=(10,10,10,10);
			afisor1<=(10,10,10,10);	
		end case;
	end process;
	process(clk1khz,ok,stare,sari,back,exi)
	begin	  
		if (clk1khz'event and clk1khz='1')then
			 if((ok ='1')or(sari='1'))then 
				stare<=nextstare;
			elsif(back ='1' )then 
				stare<=backstare;	
			elsif( exi ='1')then 
				stare<=0;
			end if;
		end if;
	end process;
	
	pin<=numar;

	c1:clock02sec       port map(clk,clk02s); 
	c2:Clock1khz        port map (clk,clk1khz);
	c3:Clock100khz        port map (clk,clk100khz);	
	B1:button_converter port map(ok1,clk1khz,ok);
	B2:button_converter port map(back1,clk1khz,back);
	B3:button_converter port map(exi1,clk1khz,exi);
	G1:read_integer     port map (clk02s,sw,numar);
	G2:number_to_digits port map(numar1,cifre1); 
	G3:number_to_digits port map(numar2,cifre2); 
	R1: Memorie_RAM     port map(clk100khz,cod,pin,sumin,sumout,pinout,semnalRAM,corect);
	
	Af1:master_display port	map(clk1khz,afisor2,afisor1,afisor,segments);	

end master;
