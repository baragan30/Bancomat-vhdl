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
  reset:in std_logic;
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

component Interogare_bancnote is
     Port ( 
	 		clk:in std_logic;
	 		reset:in std_logic;
            pozitie_bancnota:out number;
            tip_bancnota:out number
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
	 PINout: out number;
     t : in digit;   --0-afisare, 1-schimbare pin 2-adaug bani 3-scot bani
     corect: out std_logic:='0'
     );
end component;

component Memorie_RAM_bancnote is
  Port ( 
  clk:in std_logic;
  t: in std_logic;
  cantitate_bancnote_in: in arraybancnota;	
  cantitate_bancnote_out: out arraybancnota);
end component;	

component registru is
	 port(
	 clk : in STD_LOGIC;
	 datein:in number;
	 dateout:out number
	     );
end component; 
------------------------------------Algoritmi------------------------------------------
component Greedy is
   Port (
  start: in std_logic;
  pret: in number;
  clk:in std_logic;	
  bancnote_initiale:in arraybancnota;
  bancnote_ramase: out arraybancnota;
  bancnote_extrase: out arraybancnota;
  corect:out std_logic;
  final: out std_logic
   );
end component; 

component Introducere_bancnote is
  Port ( 
  	clk:in std_logic;
  	ok:in std_logic;
  	reset:in std_logic;
  	bancnote_initiale:in arraybancnota;
  	numar:in number;
  	corect: out std_logic;
  	suma_finala: out number;
  	stare: out number;
  	bancnote_curente: out arraybancnota
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
signal numar:number;
signal reset_numar:std_logic:='1';
signal numar1:number;
signal numar2:number; 

------------------RAM
signal pin:number; 
signal cod:number;
signal sumin: number;
signal sumout: number;
signal pinout: number;
signal corect:std_logic;--daca pinul e corect
signal semnalRAM:digit;	

-----------------RAM_bancnote 
signal semnalRAM_bancnote:std_logic:='0';
signal cantitate_bancnote_in:arraybancnota;	
signal cantitate_bancnote_out: arraybancnota;
signal cantitate_bancnote:arraybancnota; 

----------------------Introducere bancnote
signal reset_int_banc:std_logic:='1';
signal corect_int_banc:std_logic;
signal suma_int_banc: number;
signal stare_int_banc: number;
signal bancnote_introduse:arraybancnota;  

--------------------------Greedy
signal bancnote_ramase: arraybancnota;
signal bancnote_extrase: arraybancnota;
signal corect_greedy: std_logic:='0';
signal start_greedy: std_logic:='0';
signal final_greedy: std_logic:='0';

-------------------------Registri
signal sum:number;
signal codcopy:number;
signal coddestin:number;
signal coddestout:number;
signal codsursain:number;
signal codsursaout:number; 

-----------------------Interogare_bancnote
signal pozitie_bancnota: number;
signal tip_bancnota: number;

---------------------diverse
signal stare:number:=0;
signal backstare:number;
signal nextstare:number;
signal sari :std_logic;
signal numara:std_logic;
signal numarator: number:=4;

begin 

	
	process(clk1khz,stare,cifre1,cifre2,sw,numar,corect,sumin,sumout,coddestin,coddestout,codsursain,codsursaout,cod)
	begin 	  
		
		if(clk1khz='1'and clk1khz'event)then
		case stare is

----------------------------------------------------------Start---------------------------------------------------
			when 0=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			
			sari<='0';
			case sw is 
				when "0010" =>nextstare<=1;
				when "0001" =>nextstare<=2;	
				when others => nextstare<=0;
			end case; 
			backstare<=0;
--------------------------------------------------------Admin-------------------------------------------------
          when 1=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=0; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			
			sari<='0';
			if corect='1'then
				nextstare<=3;
			else 
				nextstare<=1;
			end if;
			backstare<=0;
--------------------------------------------------------Selector Admin------------------------------------------------
			when 3=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=cod;
			afisor1<=cifre1;
			
			sum<=10000; 
			semnalRAM<=0;
			semnalRAM_bancnote<='0';
			codcopy<=0; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			reset_numar<='1';
			start_greedy<='0';
			
			sari<='0';
			case sw is 
				when "0001" =>nextstare<=31;
				when "0010" =>nextstare<=32;	
				when "0100" =>nextstare<=33;
				when "1000" =>nextstare<=34;
				when others => nextstare<=3;
			end case; 
			backstare<=1; 
			
-----------------------------------------------------------Introducere bancnote---------------------------------------------
			when 31=>
			numar2<=stare_int_banc;
			afisor2<=cifre2; 
			numar1<=numar; 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			reset_numar<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='0';
			if corect_int_banc='1'then
				if(stare_int_banc=1)then
					nextstare<=311;	 
				else 
					nextstare<=3111;
				end if;
			else 
				nextstare<=398;
			end if;	 
			backstare<=3;
-----------------------------------------------------------resetare numar---------------------------------------------
			when 3111=>
			numar2<=stare_int_banc;
			afisor2<=cifre2; 
			numar1<=numar; 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			reset_numar<='1';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=31; 
			nextstare<=31;
---------------------------------------------------Introducere bancnote-verificare suma admin---------------------------------------------------
			when 311=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=suma_int_banc;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=cod;
			codsursain<=10000;
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			
			sari<='1';
			backstare<=398;
			if(suma_int_banc+sumout<10000)then
				nextstare<=312;	
			else 
				nextstare<=398;
			end if;	 
---------------------------------------------------Introducere bancnote-stare tranzitorie---------------------------------------------------
			when 312=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=0; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=398;
			nextstare<=313;
---------------------------------------------------Introducere bancnote-verificare suma bancomat---------------------------------------------------
			when 313=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			semnalRAM_bancnote<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=398;
			if(suma_int_banc+sumout<10000)then
				nextstare<=314;	
			else 
				nextstare<=398;
			end if ;

---------------------------------------Introducere bancnote---adaugare suma admin si resetare introducere bancnote---------------------------------------------------
			when 314=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=2; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			semnalRAM_bancnote<='1';
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=398;
			nextstare<=315;
---------------------------------------Introducere bancnote---afisare suma---------------------------------------------------
			when 315=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=suma_int_banc; 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			semnalRAM_bancnote<='0';
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=3;
			nextstare<=3;

----------------------------------------------------------Retragere numerar-introducere suma--------------------------------------------
			when 32=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=numar; 
			afisor1<=cifre1;
			
			sum<=numar;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			reset_numar<='0';
			cantitate_bancnote_in<=bancnote_ramase;
			start_greedy<='0';
			
			sari<='0';
			backstare<=3;
			if(sumout>=numar)then
				nextstare<=321;  
			else 
				nextstare<=398;
			end if;	 
----------------------------------------------------------Retragere numerar-greedy--------------------------------------------
			when 321=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			cantitate_bancnote_in<=bancnote_ramase;
			start_greedy<='1';
			semnalRAM_bancnote<='0';
			
			sari<='1';
			backstare<=398;
			if(final_greedy='1')then
				if(corect_greedy='1')then
					nextstare<=322;
				else 
					nextstare<=398;
				end if;
			else 
				nextstare<=321;
			end if;

----------------------------------------------------------Retragere numerar-scoatere bani bancomat------------------------------------------
			when 322=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=3; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			start_greedy<='1';
			semnalRAM_bancnote<='1';
			
			sari<='1';
			backstare<=398;
			nextstare<=323;	 
----------------------------------------------------------Retragere numerar-afisare bancnote------------------------------------------
			when 323=>
			numar2<=tip_bancnota;
			afisor2<=cifre2; 
			numar1<=bancnote_extrase(pozitie_bancnota); 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			start_greedy<='1';
			semnalRAM_bancnote<='0';
			reset_int_banc<=not (sw(0));
			
			sari<='0';
			backstare<=3;
			nextstare<=3;
			
			
			
----------------------------------------------------------Interogare Bancnote Admin -------------------------------------
			when 33=>
			numar2<=tip_bancnota;
			afisor2<=cifre2;
			numar1<=cantitate_bancnote_out(pozitie_bancnota);
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			reset_int_banc<=not sw(0);
			
			sari<='0';
			nextstare<=3;
			backstare<=3;
----------------------------------------------------------Display conturi---------------------------------------------
            when 34=>
            numar2<=numarator;
            afisor2<=cifre2;
			if(sw(1)='1')then 
				numar1<=pinout;
			else 
				numar1<=sumout;
			end if;
			afisor1<=cifre1; 
			
            sum<=10000;
			semnalRAM<=0; 
			codcopy<=numarator; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			numara<=not sw(0);
			
			sari<='0';
			nextstare<=3;
			backstare<=3;
----------------------------------------------------Client card-------------------------------------
			when 2=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=numar;   
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			
			 sari<='0';
			if(numar>0 and numar <5)	 then
				nextstare<=21;
			else 
				nextstare<=2;
			end if;
			backstare<=0;  
----------------------------------------------------Client card- resetare numar-------------------------------------
			when 21=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000;   
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			
			 sari<='1';
			nextstare<=4;
			backstare<=0;
--------------------------------------------------------Client PIN------------------------------------------------
			when 4=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;

			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			
			
			sari<='0';
			if corect='1'then
				nextstare<=5;
			else
			    nextstare<=4;
			end if;
			backstare<=2;
-------------------------------------------------------------Selector client-----------------------------------------
			when 5=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=cod;
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			start_greedy<='0';
			semnalRAM_bancnote<='0';
			reset_numar<='1';
			reset_int_banc<='1';
			
			backstare<=2; 
			sari<='0';
			case sw is 
				when "0001" =>nextstare<=51;
				when "0010" =>nextstare<=52;	
				when "0100" =>nextstare<=53;	
				when "0110" =>nextstare<=54;
				when "1000" =>nextstare<=55;
				when others => nextstare<=5;
			end case;
-----------------------------------------------------------Introducere bancnote---------------------------------------------
			when 51=>
			numar2<=stare_int_banc;
			afisor2<=cifre2; 
			numar1<=numar; 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			reset_numar<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='0';
			backstare<=5; 
			if corect_int_banc='1'then
				if(stare_int_banc=1)then
					nextstare<=511;	 
				else 
					nextstare<=5111;
				end if;
			else 
				nextstare<=598;
			end if;
-----------------------------------------------Introducere bancnote-resetare numar---------------------------------------------
			when 5111=>
			numar2<=stare_int_banc;
			afisor2<=cifre2; 
			numar1<=numar; 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			reset_numar<='1';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=51; 
			nextstare<=51;
---------------------------------------------------Introducere bancnote-verificare suma client---------------------------------------------------
			when 511=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=suma_int_banc;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=cod;
			codsursain<=10000;
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			
			sari<='1';
			backstare<=598;
			if(suma_int_banc+sumout<10000)then
				nextstare<=512;	
			else 
				nextstare<=598;
			end if;	 
---------------------------------------------------Introducere bancnote-stare tranzitorie---------------------------------------------------
			when 512=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=0; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=598;
			nextstare<=513;
---------------------------------------------------Introducere bancnote-verificare suma bancomat---------------------------------------------------
			when 513=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			semnalRAM_bancnote<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=598;
			if(suma_int_banc+sumout<10000)then
				nextstare<=514;	
			else 
				nextstare<=598;
			end if ;
--------------------------------------------------Introducere bancnote--adaugare bani bancomat---------------------------------------------------
			when 514=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=2; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			semnalRAM_bancnote<='1';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=598;
			nextstare<=515;
--------------------------------------------------Introducere bancnote--stare tranzitorie---------------------------------------------------
			when 515=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=coddestout; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			semnalRAM_bancnote<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=598;
			nextstare<=516;
-------------------------------------------------Introducere bancnote---adaugare suma client --------------------------------------------------
			when 516=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=2; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='1';
			backstare<=598;
			nextstare<=517;	 
-------------------------------------------------Introducere bancnote---adaugare suma client --------------------------------------------------
			when 517=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=suma_int_banc; 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=2; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='0';
			cantitate_bancnote_in<=bancnote_introduse;
			
			sari<='0';
			backstare<=5;
			nextstare<=5;

			
----------------------------------------------------------Retragere numerar-introducere suma--------------------------------------------
			when 52=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=numar; 
			afisor1<=cifre1;
			
			sum<=numar;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			cantitate_bancnote_in<=bancnote_ramase;
			start_greedy<='0';
			
			sari<='0';
			backstare<=5;
			if(sumout>=numar)then
				nextstare<=521;  
			else 
				nextstare<=598;
			end if;	 
----------------------------------------------------------Retragere numerar-greedy--------------------------------------------
			when 521=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			cantitate_bancnote_in<=bancnote_ramase;
			start_greedy<='1';
			semnalRAM_bancnote<='0';
			
			sari<='1';
			backstare<=598;
			if(final_greedy='1')then
				if(corect_greedy='1')then
					nextstare<=522;
				else 
					nextstare<=598;
				end if;
			else 
				nextstare<=521;
			end if;
----------------------------------------------------------Retragere numerar-scoatere bani-client------------------------------------------
			when 522=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=3; 
			codcopy<=10000; 
			coddestin<=cod;
			codsursain<=10000;
			reset_numar<='1';
			start_greedy<='1';
			semnalRAM_bancnote<='0';
			
			sari<='1';
			backstare<=598;
			nextstare<=523;
----------------------------------------------------------Retragere numerar-stare tranzitorie------------------------------------------
			when 523=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=0; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			start_greedy<='1';
			semnalRAM_bancnote<='0';
			
			sari<='1';
			backstare<=598;
			nextstare<=524;
----------------------------------------------------------Retragere numerar-scoatere bani bancomat------------------------------------------
			when 524=>
			numar2<=stare;
			afisor2<=cifre2; 
			numar1<=0; 
			afisor1<=(10,10,10,10);
			
			sum<=10000;
			semnalRAM<=3; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			start_greedy<='1';
			semnalRAM_bancnote<='1';
			
			sari<='1';
			backstare<=598;
			nextstare<=525;	 
----------------------------------------------------------Retragere numerar-afisare numerar------------------------------------------
			when 525=>
			numar2<=tip_bancnota;
			afisor2<=cifre2; 
			numar1<=bancnote_extrase(pozitie_bancnota); 
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=coddestout; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			start_greedy<='1';
			semnalRAM_bancnote<='0';
			reset_int_banc<=not (sw(0));
			
			sari<='0';
			backstare<=5;
			nextstare<=5;
			

			

----------------------------------------------------------Interogare Sold Client -------------------------------------
			when 53=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=sumout;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			
			sari<='0';
			nextstare<=5;
			backstare<=5;	
----------------------------------------------------------Transfer-introducere cod -------------------------------------
			when 54=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=numar;
			codsursain<=cod; 
			reset_numar<='0';
			
			sari<='0';
			if(numar>0 and numar<5 and (not(cod=numar)))then
				nextstare<=540;
			else
				nextstare<=598;
			end if ;   
			backstare<=5;  
----------------------------------------------------------Transfer-stare trnzitorie -------------------------------------
			when 540=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000; 
			reset_numar<='1';
			
			sari<='1';
			nextstare<=541;
			backstare<=5; 
----------------------------------------------------------Transfer-introducere suma -------------------------------------
			when 541=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			reset_numar<='0';
			sum<=numar;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			
			sari<='0';
			nextstare<=542;
			backstare<=54;
-------------------------------------------------------verificare suma cont sursa  -------------------------------------
			when 542=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='1';
			
			if(sumout>sumin)then 
				nextstare<=543; 
			else 
				nextstare<=598;
			end if;
			sari<='1';
			backstare<=598;	
----------------------------------------------------------verificare suma cod destinatie -------------------------------------
			when 543=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=coddestout; 
			coddestin<=10000;
			codsursain<=10000;
			
			if((sumout+sumin<10000))then 
				nextstare<=544; 
			else 
				nextstare<=598;
			end if;
			sari<='1';
			backstare<=598;
----------------------------------------------------------Transfer-adaugare suma -------------------------------------
			when 544=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=2;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			
			nextstare<=545;
			sari<='1';
			backstare<=545;	
----------------------------------------------------------Transfer-stabilizare-------------------------------------
			when 545=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=codsursaout; 
			coddestin<=10000;
			codsursain<=10000;
			
			nextstare<=546;
			sari<='1';
			backstare<=546;	
----------------------------------------------------------Transfer-scoatere bani-------------------------------------
			when 546=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1;
			
			sum<=10000;
			semnalRAM<=3;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			
			nextstare<=599;
			sari<='1';
			backstare<=599;
			
----------------------------------------------------------------Schimbare PIN 1-------------------------------------
			when 55=> 
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_numar<='0';
			
			sari<='0';
			nextstare<=551;	
			backstare<=5;
			
			
------------------------------------------------------------Schimbare PIN 2-------------------------------------
			when 551=> 
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=numar;
			afisor1<=cifre1; 
			
			sum<=10000;
			semnalRAM<=1;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			
			sari<='1';
			nextstare<=599;	
			backstare<=5; 
--------------------------------------------------------Client afisare ok-----------------------------------------------
			when 599=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=0;
			afisor1<=(10,10,0,13); 
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			semnalRAM_bancnote<='0'; 
			reset_numar<='0';
			
			nextstare<=5;
			sari<='0';
			backstare<=5;
--------------------------------------------------------Client afisare eroare-----------------------------------------------
			when 598=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=0;
			afisor1<=(11,12,14,12); 
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			semnalRAM_bancnote<='0';
			reset_numar<='0';
			
			nextstare<=5;
			sari<='0';
			backstare<=5;
			
			
--------------------------------------------------------Admin afisare ok-----------------------------------------------
			when 399=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=0;
			afisor1<=(10,10,0,13); 
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			semnalRAM_bancnote<='0'; 
			reset_numar<='1';
			
			nextstare<=3;
			sari<='0';
			backstare<=3;
--------------------------------------------------------Admin afisare eroare-----------------------------------------------
			when 398=>
			numar2<=stare;
			afisor2<=cifre2;
			numar1<=0;
			afisor1<=(11,12,14,12); 
			
			sum<=10000;
			semnalRAM<=0; 
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			semnalRAM_bancnote<='0';
			reset_numar<='1';
			
			nextstare<=3;
			sari<='0';
			backstare<=3;
			
			
			when others => 
			numar2<=0;
			afisor2<=(10,10,10,10);
			numar1<=0;
			afisor1<=(10,10,10,10);	
			
			sum<=10000;
			semnalRAM<=0;
			codcopy<=10000; 
			coddestin<=10000;
			codsursain<=10000;
			reset_int_banc<='1';
			semnalRAM_bancnote<='0';
			reset_numar<='1';
			
			nextstare<=0;
			sari<='1';
			backstare<=0;
		end case;
		end if;
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
	
	process(clk02s)
	begin
		
		if(clk02s='1' and clk02s'event) then 
			if(numara='0')then
	     if(numarator=4)then
	     numarator<=0;
	     else
	     numarator<=numarator+1;
	     end if;
		 end if;
	     end if;
	end process;
	
	pin<=numar;

	c1:clock02sec       port map(clk,clk02s); 
	c2:Clock1khz        port map (clk,clk1khz);
	c3:Clock100khz      port map (clk,clk100khz);	
	B1:button_converter port map(ok1,clk1khz,ok);
	B2:button_converter port map(back1,clk1khz,back);
	B3:button_converter port map(exi1,clk1khz,exi);
	G1:read_integer     port map (clk02s,reset_numar,sw,numar);
	G2:number_to_digits port map(numar1,cifre1); 
	G3:number_to_digits port map(numar2,cifre2); 
	R1: Memorie_RAM     port map(clk100khz,cod,pin,sumin,sumout,pinout,semnalRAM,corect);
	R2:Memorie_RAM_bancnote port map(clk,semnalRAM_bancnote,cantitate_bancnote_in,cantitate_bancnote_out);
	
	Alg1:Greedy port map (start_greedy,sumin,clk100khz,cantitate_bancnote_out,bancnote_ramase,bancnote_extrase,corect_greedy,final_greedy);
	Alg2:Introducere_bancnote port map (clk1khz,ok,reset_int_banc,cantitate_bancnote_out,numar,corect_int_banc,
									suma_int_banc,stare_int_banc,bancnote_introduse);
	
	I1:Interogare_bancnote port map(clk02s,reset_int_banc,pozitie_bancnota,tip_bancnota);
	Af1:master_display port	map(clk1khz,afisor2,afisor1,afisor,segments);	
    
    Re1:registru port map(clk100khz,sum,sumin);
	Re2:registru port map(clk100khz,codcopy,cod);
    Re3:registru port map(clk100khz,coddestin,coddestout);
    Re4:registru port map(clk100khz,codsursain,codsursaout);
end master;