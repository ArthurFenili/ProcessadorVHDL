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

    signal saidain : unsigned(15 downto 0);

    begin
    saidain <=  x+y when op = "0001" else  -- soma
                x-y when op = "0010" else -- subtração
                "0000000000000001" when op = "0100" and x>=y else -- maior ou igual
                "0000000000000001" when op = "1000" and x<y else -- menor
                "0000000000000000";


    -- quando o último bit da saida for negativo
    
    n_flag <=   saidain(15);

    -- quando as entradas forem positivas e a saida positiva, não há overflow (0)
    -- quando as entradas forem positivas e a saida negativa, há overflow (1)

    v_flag <=   '0' when x(15) = '0' and y(15) = '0' and saidain(15) = '1' and op = "0010" and y>x else
                '1' when x(15) = '0' and y(15) = '0' and saidain(15) = '1' else
                '1' when x(15) = '1' and y(15) = '1' and saidain(15) = '0' else
                '0';

    saida <=    saidain;

    end architecture;
