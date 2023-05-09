library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end;

architecture a_ula_tb of ula_tb is
    component ula
    port(
        x,y : in unsigned(15 downto 0);
        op : in unsigned(3 downto 0);
        saida : out unsigned(15 downto 0)
    );
    end component;

    signal x, y, saida : unsigned(15 downto 0);
    signal op : unsigned(3 downto 0);
    begin
        uut: ula port map (
            x => x,
            y => y,
            op => op,
            saida => saida
        );
        process
        begin
            x <= "0101010010010000"; --21648
            y <= "0001111011001111"; --7887
            op <= "0001";
            wait for 50 ns;
            op <= "0010";
            wait for 50 ns;
            op <= "0100";
            wait for 50 ns;
            op <= "1000";
            wait for 50 ns;
            wait;
        end process;
end architecture;