

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Greedy is
  Port (
  pret: inout number:=800;
  bancnota: out arraybancnota
   );
end Greedy;

architecture Behavioral of Greedy is
signal t:std_logic:='0';
begin
    process(t)
    variable valoare:number:=pret;
    variable cant_500: number:=20;
    variable  cant_200:number:=20;
    variable  cant_100:number:=20;
    variable  cant_50:number:=20;
    variable  cant_10:number:=20;
    variable  cant_5:number:=20;
    variable  cant_1:number:=20;
    variable  f_500: number:=0;
    variable  f_200:number:=0;
    variable  f_100:number:=0;
    variable  f_50:number:=0;
    variable  f_10:number:=0;
    variable  f_5:number:=0;
    variable  f_1:number:=0;
    begin
    if (t'event and t='1') or t='0' then
        if valoare=800 and cant_200>0 then
            valoare:=valoare-200;
            cant_200:=cant_200-1;
            f_200:=f_200+1;
            t<=not t;
        elsif valoare=600 and cant_200>0 then
            valoare:=valoare-200;
            cant_200:=cant_200-1;
            f_200:=f_200+1;
            t<=not t;
        elsif valoare>=500 and cant_500>0 then
            valoare:=valoare-500;
            cant_500:=cant_500-1;
            f_500:=f_500+1;
            t<=not t;
        elsif valoare>=200 and cant_200>0 then
            valoare:=valoare-200;
            cant_200:=cant_200-1;
            f_200:=f_200+1;
            t<=not t;
        elsif valoare>=100 and cant_100>0 then
            valoare:=valoare-100;
            cant_100:=cant_100-1;
            f_100:=f_100+1;
            t<=not t;
        elsif valoare>=50 and cant_50>0 then
            valoare:=valoare-50;
            cant_50:=cant_50-1;
            f_50:=f_50+1; 
            t<=not t;
        elsif valoare>=10 and cant_10>0 then
            valoare:=valoare-10;
            cant_10:=cant_10-1;
            f_10:=f_10+1;
            t<=not t;
        elsif valoare>=5 and cant_5>0 then
            valoare:=valoare-5;
            cant_5:=cant_5-1;
            f_5:=f_5+1;
            t<=not t;
        elsif valoare>=1 and cant_1>0 then
            valoare:=valoare-1;
            cant_1:=cant_1-1;
            f_1:=f_1+1;
            t<=not t;
        end if;
    end if;
    bancnota(6)<=f_500;
    bancnota(5)<=f_200;
    bancnota(4)<=f_100;
    bancnota(3)<=f_50;
    bancnota(2)<=f_10;
    bancnota(1)<=f_5;
    bancnota(0)<=f_1;      
    if(valoare>0) then
    --eroare
    end if;
    end process;
end Behavioral;
