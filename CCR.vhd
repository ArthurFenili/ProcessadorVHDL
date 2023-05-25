library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CCR is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        n_in, v_in : in std_logic;
        n_out, v_out : out std_logic
    );
end entity;

architecture a_CCR of CCR is
    signal n_s, v_s: std_logic;
begin
    process(clk, rst, wr_en)
    begin
        if rst='1' then
            n_s <= '0';
            v_s <= '0';
        elsif wr_en='1' then
            if rising_edge(clk) then
                n_s <= n_in;
                v_s <= v_in;
            end if;
        end if;
    end process;

    n_out <= n_s;
    v_out <= v_s;
end architecture;