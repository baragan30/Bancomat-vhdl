library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Introducere_bancnote is
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
end Introducere_bancnote;

architecture Behavioral of Introducere_bancnote is
signal bancnota_urmatoare:number;
signal bancnota_curenta:number;
begin
    process(ok,reset,clk,bancnota_curenta,numar)
    variable suma:integer:=0;
    begin 
		if(reset='1')then 
			suma:=0;
			bancnota_urmatoare<=500;
		end if;
		if((suma+bancnota_curenta*numar<10000 )or reset='1') then 
		corect<='1';
		else 
		corect<='0';	
		end if;
		suma_finala<=suma;
		
		if(clk='1'and clk'event)then	
			if(ok='1' )then
				if(suma+bancnota_curenta*numar<10000) then 
					suma:=suma+bancnota_curenta*numar;
	                if(bancnota_curenta=500) then
	                    bancnote_curente(8)<=bancnote_initiale(8)+numar;
	                    bancnota_urmatoare<=200;
	                elsif(bancnota_curenta=200) then
	                    bancnote_curente(7)<=bancnote_initiale(7)+numar;
	                    bancnota_urmatoare<=100;
	                elsif(bancnota_curenta=100) then
	                   bancnote_curente(6)<=bancnote_initiale(6)+numar;
	                    bancnota_urmatoare<=50;
	                elsif(bancnota_curenta=50) then
	                    bancnote_curente(5)<=bancnote_initiale(5)+numar;
	                    bancnota_urmatoare<=20;
					 elsif(bancnota_curenta=20) then
	                    bancnote_curente(4)<=bancnote_initiale(4)+numar;
	                    bancnota_urmatoare<=10;
	                elsif(bancnota_curenta=10) then
	                    bancnote_curente(3)<=bancnote_initiale(3)+numar;
	                    bancnota_urmatoare<=5;
	                elsif(bancnota_curenta=5) then
	                    bancnote_curente(2)<=bancnote_initiale(2)+numar;
	                    bancnota_urmatoare<=2;
					elsif(bancnota_curenta=2) then
	                    bancnote_curente(1)<=bancnote_initiale(1)+numar;
	                    bancnota_urmatoare<=1;
	                elsif(bancnota_curenta=1) then
	                    bancnote_curente(0)<=bancnote_initiale(0)+numar;
	                    bancnota_urmatoare<=1;
					else 
						bancnota_urmatoare<=0;
	                end if;
				end if;
				
			end if; 
        end if;
    end process;
		
	stare<=bancnota_curenta;

    process(clk,ok,reset)
    begin 
		if(clk'event and clk='1') then
           	bancnota_curenta<=bancnota_urmatoare;
		end if;
    end process;
end Behavioral;
