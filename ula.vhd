library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port( 
        x,y : in unsigned(15 downto 0);
        op : in unsigned(3 downto 0);
        saida : out unsigned(15 downto 0);
        n_flag, v_flag : out std_logic
    );
   end entity;
architecture a_ula of ula is
    signal saida17b : unsigned(16 downto 0);

    begin
    saida <=    x+y when op = "0001" else  -- soma
                x-y when op = "0010" else -- subtração
                "0000000000000001" when op = "0100" and x>=y else -- maior ou igual
                "0000000000000001" when op = "1000" and x<y else -- menor
                "0000000000000000";

    saida17b <= ('0' & x) + ('0' & y) when op = "0001" else  -- soma
                ('0' & x) - ('0' & y) when op = "0010" else -- subtração
                "00000000000000001" when op = "0100" and x>=y else -- maior ou igual
                "00000000000000001" when op = "1000" and x<y else -- menor
                "00000000000000000";

    n_flag <= saida17b(15);
    v_flag <= '1' when saida17b(15) = '0' and saida17b(16) = '1' else
              '0';
    end architecture;
