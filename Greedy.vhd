

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Greedy is
  Port (
  pret: inout number:=9999
   );
end Greedy;

architecture Behavioral of Greedy is
signal nr_500: number;
signal  nr_200:number;
signal  nr_100:number;
signal  nr_50:number;
signal  nr_10:number;
signal  nr_5:number;
signal  nr_1:number;
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
        if valoare>=500 and cant_500>0 then
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
    nr_500<=f_500;
    nr_200<=f_200;
    nr_100<=f_100;
    nr_50<=f_50;
    nr_10<=f_10;
    nr_5<=f_5;
    nr_1<=f_1;      
    if(valoare>0) then
    --eroare
    end if;
    end process;
end Behavioral;
