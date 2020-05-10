library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types.all;

entity Introducere_bancnote is
  Port ( 
  ok:in std_logic;
  back:in std_logic;
  reset:in std_logic;
  bancnote_initiale:in arraybancnota;
  numar:in number;
  bancnota_curenta_i: in number;
  suma_finala: out number;
  corect: out std_logic;
  bancnota_curenta_o: out number;
  bancnote_finale: out arraybancnota
  );
end Introducere_bancnote;

architecture Behavioral of Introducere_bancnote is
signal bancnota_urmatoare:number;
signal bancnota_anterioara:number;
begin
    process(ok,back,reset)
    variable bancnote_curente: arraybancnota;
    variable suma:number:=0;
    variable aux:number;
    begin
        corect<='1';
        bancnote_curente:=bancnote_initiale;
        if(reset='1') then
        suma:=0;
        suma_finala<=0;
        bancnote_finale<=bancnote_initiale;
        elsif(back='1') then
        bancnote_finale<=bancnote_initiale;
        bancnota_curenta_o<=bancnota_urmatoare;
        else
            if(ok='1') then
                if(bancnota_curenta_i=0) then
                    bancnota_curenta<=500;
                    suma:=0;
                end if;
                aux:=bancnota_curenta*numar;
                suma:=suma+aux;
                if(suma>9999) then
                    corect<='0';
                else
                    suma_finala<=suma;
                end if;
                aux:=numar;
                if(bancnota_curenta=500) then
                    bancnote_curente(6):=bancnote_curente(6)+aux;
                    bancnota_curenta<=200;
                elsif(bancnota_curenta=200) then
                    bancnote_curente(5):=bancnote_curente(5)+aux;
                    bancnota_curenta<=100;
                elsif(bancnota_curenta=100) then
                    bancnote_curente(4):=bancnote_curente(4)+aux;
                    bancnota_curenta<=50;
                elsif(bancnota_curenta=50) then
                    bancnote_curente(3):=bancnote_curente(3)+aux;
                    bancnota_curenta<=10;
                elsif(bancnota_curenta=10) then
                    bancnote_curente(2):=bancnote_curente(2)+aux;
                    bancnota_curenta<=5;
                elsif(bancnota_curenta=5) then
                    bancnote_curente(1):=bancnote_curente(1)+aux;
                    bancnota_curenta<=1;
                elsif(bancnota_curenta=1) then
                    bancnote_curente(0):=bancnote_curente(0)+aux;
                    bancnota_curenta<=0;
                end if;
                bancnote_finale<=bancnote_curente;
            end if;
       end if; 
    end process;

    --pentru bancnota urmatoare
    process(ok,back,reset)
    begin
            if(bancnota_curenta_i=0) then
                bancnota_urmatoare<=1;
            elsif(bancnota_curenta_i=1) then
                bancnota_urmatoare<=5;
            elsif(bancnota_curenta_i=5) then
                bancnota_urmatoare<=10;
            elsif(bancnota_curenta_i=10) then
                bancnota_urmatoare<=50;
            elsif(bancnota_curenta_i=50) then
                bancnota_urmatoare<=100;
            elsif(bancnota_curenta_i=100) then
                bancnota_urmatoare<=200;
            elsif(bancnota_curenta_i=200) then
                bancnota_urmatoare<=500;
            end if;
    end process;
end Behavioral;
