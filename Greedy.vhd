library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Greedy is
  Port (
  pret: in number;
  clk:in std_logic;	
  bancnote_initiale:in arraybancnota;
  bancnote_ramase: out arraybancnota;
  bancnote_extrase: out arraybancnota;
  corect:out std_logic
   );
end Greedy;

architecture Behavioral of Greedy is
signal semnal_valoare: number:=pret;
begin
    process(clk)
    variable valoare:number:=pret;
    variable cant:arraybancnota;
    variable  f:arraybancnota;
    begin
    cant:=bancnote_initiale;
    if (clk'event and clk='1')then
        if semnal_valoare=800 and bancnote_initiale(5)>0 then
            valoare:=valoare-200;
            cant(5):=cant(5)-1;
            f(5):=f(5)+1;
        elsif semnal_valoare=600 and bancnote_initiale(5)>0 then
            valoare:=valoare-200;
            cant(5):=cant(5)-1;
            f(5):=f(5)+1;
        elsif semnal_valoare>=500 and bancnote_initiale(6)>0 then
            valoare:=valoare-500;
            cant(6):=cant(6)-1;
            f(6):=f(6)+1;
        elsif semnal_valoare>=200 and bancnote_initiale(5)>0 then
            valoare:=valoare-200;
            cant(5):=cant(5)-1;
            f(5):=f(5)+1;
        elsif semnal_valoare>=100 and bancnote_initiale(4)>0 then
            valoare:=valoare-100;
            cant(4):=cant(4)-1;
            f(4):=f(4)+1;
        elsif semnal_valoare>=50 and bancnote_initiale(3)>0 then
            valoare:=valoare-50;
            cant(3):=cant(3)-1;
            f(3):=f(3)+1;
        elsif semnal_valoare>=10 and bancnote_initiale(2)>0 then
            valoare:=valoare-10;
            cant(2):=cant(2)-1;
            f(2):=f(2)+1;
        elsif semnal_valoare>=5 and bancnote_initiale(1)>0 then
            valoare:=valoare-5;
            cant(1):=cant(1)-1;
            f(1):=f(1)+1;
        elsif semnal_valoare>=1 and bancnote_initiale(0)>0 then
            valoare:=valoare-1;
            cant(0):=cant(0)-1;
            f(0):=f(0)+1;
        end if;
    end if;
    semnal_valoare<=valoare;
    bancnote_extrase<=f;
    bancnote_ramase<=cant;
    if(valoare>0) then
    	corect<='0';
    else
        corect<='1';
    end if;
    end process;
end Behavioral;
