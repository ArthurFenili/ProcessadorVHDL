library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_tb is
end;

architecture a_RAM_tb of RAM_tb is
    component RAM is 
        port (
            clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            wr_en : in std_logic;
            dado_in : in unsigned(15 downto 0);
            dado_out : out unsigned(15 downto 0)
        );
    end component;

    constant period_time : time       := 100 ns;
    signal finished      : std_logic  := '0';
    signal clk, rst, wr_en : std_logic;
    signal endereco_s : unsigned(6 downto 0);
    signal dadoin_s, dadoout_s : unsigned(15 downto 0);

begin
    uut: RAM port map (
        clk => clk,
        wr_en => wr_en,
        endereco => endereco_s,
        dado_in => dadoin_s,
        dado_out => dadoout_s
    );

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
        endereco_s <= "0000100";
        dadoin_s <= "0001000000101101";
        wait for 200 ns;
        wr_en <= '1';
        endereco_s <= "0001100";
        dadoin_s <= "0001001110010101";
        wait for 200 ns;
        wr_en <= '1';
        endereco_s <= "0000111";
        dadoin_s <= "0001110111111101";
        wait for 200 ns;
        wr_en <= '1';
        endereco_s <= "0000001";
        dadoin_s <= "0011100001000101";
        wait for 200 ns;
        wr_en <= '0';
        endereco_s <= "0001101";
        dadoin_s <= "1110110101010111";
        wait for 200 ns;
        endereco_s <= "0001100";
        wait for 200 ns;
        endereco_s <= "0001101";
        wait;
    end process;

end architecture;