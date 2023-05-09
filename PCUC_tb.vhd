library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCUC_tb is
end;

architecture a_PCUC_tb of PCUC_tb is
    component PCUC is 
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            d_out : out unsigned (6 downto 0)
        );
    end component;

    constant period_time : time       := 100 ns;
    signal finished      : std_logic  := '0';
    signal clk, rst, wr_en : std_logic;

begin
    uut: PCUC port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en
    );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process;

    process 
    begin
        wr_en <= '1';
        wait;
    end process;

end architecture;