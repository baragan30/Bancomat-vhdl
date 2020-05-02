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

signal pinout: number;

signal corect:std_logic;--daca pinul e corect

signal semnalRAM:digit:=4; 



signal nou :std_logic;



begin 	

	

	process(ok,exi,back,clk)

	variable stare :number :=4;

	variable codcopy:number:=3;

	begin 

		cod<=codcopy;

		case stare is

----------------------------------------------------------Start---------------------------------------------------

			when 0=>

			numar2<=stare;

			afisor2<=cifre2;

			afisor1<=(0,0,0,0);

			if(ok'event and ok ='1')then 

				case sw is 

					when "0001" =>stare:=1;

					when "0000" =>stare:=2;	

					when others => stare:=stare;

				end case;

			end if;	

----------------------------------------------------------Admin-------------------------------------------------

			when 1=>

			numar2<=stare;

			afisor2<=cifre2;

			numar1<=numar;

			afisor1<=cifre1;

			codcopy:=0;	

			pin<=numar;

			if(ok'event and ok ='1' and corect='1')then 

				stare:=3;

			end if;

			if(back'event and back ='1' )then 

				stare:=0;

			end if;	

			if(exi'event and exi ='1')then 

				stare:=0;

			end if;	

--------------------------------------------------------Selector Admin------------------------------------------------

			when 3=>

			numar2<=stare;

			afisor2<=cifre2;

			afisor1<=(0,0,0,0);

			if(ok'event and ok ='1')then 

				stare:=3;

			end if;

			if(back'event and back ='1' )then 

				stare:=1;

			end if;	

			if(exi'event and exi ='1')then 

				stare:=0;

			end if;	

----------------------------------------------------Client card-------------------------------------

			when 2=>

			numar2<=stare;

			afisor2<=cifre2;

			numar1<=numar;

			afisor1<=cifre1;

			codcopy:=numar;

			if(ok'event and ok ='1' )then 

				stare:=4;

			end if;

			if(back'event and back ='1' )then 

				stare:=0;

			end if;	

			if(exi'event and exi ='1')then 

				stare:=0;

			end if;

--------------------------------------------------------Client PIN------------------------------------------------

			when 4=>

			numar2<=stare;

			afisor2<=cifre2;

			numar1<=numar;

			afisor1<=cifre1;

			pin<=numar;

			if(ok'event and ok ='1' and corect='1')then 

				stare:=5;

			end if;

			if(back'event and back ='1' )then 

				stare:=0;

			end if;	

			if(exi'event and exi ='1')then 

				stare:=0;

			end if;	

-------------------------------------------------------------Selector client-----------------------------------------

			when 5=>

			numar2<=stare;

			afisor2<=cifre2;

			afisor1<=(0,0,0,0);

			if(ok'event and ok ='1')then 

				stare:=3;

			end if;

			if(back'event and back ='1' )then 

				stare:=1;

			end if;	

			if(exi'event and exi ='1')then 

				stare:=0;

			end if;	

			

			

			when others => 

			stare:=stare; 

		end case;

	end process; 



	c1:clock02sec       port map(clk,clk02s); 

	c2:Clock1khz        port map (clk,clk1khz);

	G1:read_integer     port map (clk02s,sw,numar);

	G2:number_to_digits port map(numar1,cifre1); 

	G3:number_to_digits port map(numar2,cifre2); 

	G4: Memorie_RAM     port map(clk1khz,cod,pin,sumin,sumout,pinout,semnalRAM,corect);

	

	Af1:master_display port	map(clk1khz,afisor2,afisor1,afisor,segments);	



end master;