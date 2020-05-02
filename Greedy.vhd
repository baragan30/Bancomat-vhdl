

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Greedy is
  Port (
  pret: inout number;
  clk:in std_logic;
  bancnote_ramase: inout arraybancnota;
  bancnote_extrase: inout arraybancnota;
  corect:out std_logic:='0'
   );
end Greedy;

architecture Behavioral of Greedy is

begin
    process(clk)
    variable valoare:number:=pret;
    variable cant:arraybancnota;
    variable  f:arraybancnota;
    begin
    cant:=bancnote_ramase;
    if (clk'event and clk='1')then
        if valoare=800 and cant(5)>0 then
            valoare:=valoare-200;
            cant(5):=cant(5)-1;
            f(5):=f(5)+1;
        elsif valoare=600 and cant(5)>0 then
            valoare:=valoare-200;
            cant(5):=cant(5)-1;
            f(5):=f(5)+1;
        elsif valoare>=500 and cant(6)>0 then
            valoare:=valoare-500;
            cant(6):=cant(6)-1;
            f(6):=f(6)+1;
        elsif valoare>=200 and cant(5)>0 then
            valoare:=valoare-200;
            cant(5):=cant(5)-1;
            f(5):=f(5)+1;
        elsif valoare>=100 and cant(4)>0 then
            valoare:=valoare-100;
            cant(4):=cant(4)-1;
            f(4):=f(4)+1;
        elsif valoare>=50 and cant(3)>0 then
            valoare:=valoare-50;
            cant(3):=cant(3)-1;
            f(3):=f(3)+1;
        elsif valoare>=10 and cant(2)>0 then
            valoare:=valoare-10;
            cant(2):=cant(2)-1;
            f(2):=f(2)+1;
        elsif valoare>=5 and cant(1)>0 then
            valoare:=valoare-5;
            cant(1):=cant(1)-1;
            f(1):=f(1)+1;
        elsif valoare>=1 and cant(0)>0 then
            valoare:=valoare-1;
            cant(0):=cant(0)-1;
            f(0):=f(0)+1;
        end if;
    end if;
    bancnote_extrase<=f;
    bancnote_ramase<=cant;
    if(valoare>0) then
    --eroare
    else
        corect<='1';
    end if;
    end process;
end Behavioral;
