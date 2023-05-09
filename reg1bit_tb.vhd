library ieee;
use ieee.std_logic_1164.all;

entity reg1bit_tb is
end;

architecture a_reg1bit_tb of reg1bit_tb is
    component reg1bit
    port (  clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_out: out std_logic
    );
    end component;

    constant period_time : time       := 100 ns;
    signal finished      : std_logic  := '0';
    signal clk, reset, wr_en, data_out : std_logic;

begin
    uut: reg1bit port map (  
        clk => clk,
        rst => reset,
        wr_en => wr_en,
        data_out => data_out
    );


    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2;
        reset <= '0';
        wait;
    end process;

    process
    begin
        wr_en <= '0';
        clk <= '0';
        wait for 200 ns;
        wr_en <= '1';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait for 100 ns;
        clk <= '1';
        wait for 100 ns;
        clk <= '0';
        wait;


    end process;

end architecture;