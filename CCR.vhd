library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CCR is
    port (
        entrada : in unsigned(15 downto 0);
        saida : out unsigned(4 downto 0) --XNZVC
    );
end entity;

architecture a_CCR of CCR is
    begin
        saida(4) <= '0';
        saida(3) <= '1' when entrada(15) = '1' else '0'; --negative
        saida(2) <= '1' when entrada = "0000000000000000" else '0'; --zero
        saida(1) <= '0';
        saida(0) <= '0';

end architecture;