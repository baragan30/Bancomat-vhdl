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
signal semnal_valoare: number:=0;
signal semnal_cant:arraybancnota;
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
	f<=(0,0,0,0,0,0,0,0,0);
    end if;		 
	
	
    if(clk='1' and clk'event) then 
	    if (gata='0')then
	    if(start='1') then
	    
	        if semnal_valoare>=600and semnal_cant(7)>0 and (semnal_cant(8)=1 or semnal_valoare<1000)  
				and semnal_cant(6)=0 and ((semnal_valoare/100) rem 2 =0)  then	 
				
	            valoare<=valoare-200;
	            cant(7)<=cant(7)-1;
	            f(7)<=f(7)+1;
			
	        elsif semnal_valoare>=500 and semnal_cant(8)>0 then
	            valoare<=valoare-500;
	            cant(8)<=cant(8)-1;
	            f(8)<=f(8)+1;
	        elsif semnal_valoare>=200 and semnal_cant(7)>0 then
	            valoare<=valoare-200;
	            cant(7)<=cant(7)-1;
	            f(7)<=f(7)+1;
	        elsif semnal_valoare>=100 and semnal_cant(6)>0 then
	            valoare<=valoare-100;
	            cant(6)<=cant(6)-1;
	            f(6)<=f(6)+1;	   
				
			elsif semnal_valoare>=60 and semnal_cant(4)>0 and (semnal_cant(5)=1 or semnal_valoare<100)  
				and semnal_cant(3)=0 and ((semnal_valoare/10) rem 2 =0)  then	 
	            valoare<=valoare-20;
	            cant(4)<=cant(4)-1;
	            f(4)<=f(4)+1; 
				
	        elsif semnal_valoare>=50 and semnal_cant(5)>0 then
	            valoare<=valoare-50;
	            cant(5)<=cant(5)-1;
	            f(5)<=f(5)+1;
			elsif semnal_valoare>=20 and semnal_cant(4)>0 then
	            valoare<=valoare-20;
	            cant(4)<=cant(4)-1;
	            f(4)<=f(4)+1;
	        elsif semnal_valoare>=10 and semnal_cant(3)>0 then
	            valoare<=valoare-10;
	            cant(3)<=cant(3)-1;
	            f(3)<=f(3)+1; 
			
			elsif semnal_valoare>=6 and semnal_cant(1)>0 and (semnal_cant(2)=1 or semnal_valoare<10)  
				and semnal_cant(0)=0 and ((semnal_valoare) rem 2 =0)  then	 
	            valoare<=valoare-2;
	            cant(1)<=cant(1)-1;
	            f(1)<=f(1)+1; 
				
	        elsif semnal_valoare>=5 and semnal_cant(2)>0 then
	            valoare<=valoare-5;
	            cant(2)<=cant(2)-1;
	            f(2)<=f(2)+1;
			elsif semnal_valoare>=2 and semnal_cant(1)>0 then
	            valoare<=valoare-2;
	            cant(1)<=cant(1)-1;
	            f(1)<=f(1)+1;
	        elsif semnal_valoare>=1 and semnal_cant(0)>0 then
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
	
	semnal_cant<=cant;
    semnal_valoare<=valoare;
    bancnote_extrase<=f;
    bancnote_ramase<=cant; 
    
    process(clk)
    begin
    if(clk='1' and clk'event) then
	final<=gata; 
    end if;
    
    end process;
end Behavioral;
