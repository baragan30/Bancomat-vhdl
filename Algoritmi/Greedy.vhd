library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Greedy is
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
end Greedy;

architecture Behavioral of Greedy is
signal semnal_valoare: number:=pret;
signal pret_modif:number:=0;
signal valoare:number;
signal cant:arraybancnota;
signal  f:arraybancnota;
signal gata:std_logic:='0';
signal inventiv:std_logic:='0';
begin
    process(clk,start,pret,bancnote_initiale)
    begin
    
    if(start='0')then
    inventiv<='0';
    valoare<=pret;
    cant<=bancnote_initiale;
    end if;		 
	
	
    if(clk='1' and clk'event) then 
	    if (gata='0')then
	    if(start='1') then
	    
	        if semnal_valoare=800 and bancnote_initiale(5)>0 then
	            valoare<=valoare-200;
	            cant(5)<=cant(5)-1;
	            f(5)<=f(5)+1;
	        elsif semnal_valoare=600 and bancnote_initiale(5)>0 then
	            valoare<=valoare-200;
	            cant(5)<=cant(5)-1;
	            f(5)<=f(5)+1;
	        elsif semnal_valoare>=500 and bancnote_initiale(6)>0 then
	            valoare<=valoare-500;
	            cant(6)<=cant(6)-1;
	            f(6)<=f(6)+1;
	        elsif semnal_valoare>=200 and bancnote_initiale(5)>0 then
	            valoare<=valoare-200;
	            cant(5)<=cant(5)-1;
	            f(5)<=f(5)+1;
	        elsif semnal_valoare>=100 and bancnote_initiale(4)>0 then
	            valoare<=valoare-100;
	            cant(4)<=cant(4)-1;
	            f(4)<=f(4)+1;
	        elsif semnal_valoare>=50 and bancnote_initiale(3)>0 then
	            valoare<=valoare-50;
	            cant(3)<=cant(3)-1;
	            f(3)<=f(3)+1;
	        elsif semnal_valoare>=10 and bancnote_initiale(2)>0 then
	            valoare<=valoare-10;
	            cant(2)<=cant(2)-1;
	            f(2)<=f(2)+1;
	        elsif semnal_valoare>=5 and bancnote_initiale(1)>0 then
	            valoare<=valoare-5;
	            cant(1)<=cant(1)-1;
	            f(1)<=f(1)+1;
	        elsif semnal_valoare>=1 and bancnote_initiale(0)>0 then
	            valoare<=valoare-1;
	            cant(0)<=cant(0)-1;
	            f(0)<=f(0)+1;
	        else
	            inventiv<='1';
	        end if;
    end if;
    end if;
    end if;
    end process;
	corect<='0' when (valoare>0) else 
		'1';
	gata<='1' when (valoare<=0 or inventiv='1') else
		'0';
	final<=gata;
    semnal_valoare<=valoare;
    
    process(clk)
    begin
    if(clk='1' and clk'event) then
    
    bancnote_extrase<=f;
    bancnote_ramase<=cant;
    end if;
    
    end process;
end Behavioral;
