library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port( 
        x,y : in unsigned(31 downto 0);
        op : in unsigned(5 downto 0);
        saida : out unsigned(15 downto 0)
    );
   end entity;
   architecture a_ula of ula is
   begin
    saida <=     when op = "100011" else  -- 
                x-y when op = "0010" else
                "0000000000000001" when op = "0100" and x>=y else
                "0000000000000001" when op = "1000" and x<y else
                "0000000000000000"; 
   end architecture;
