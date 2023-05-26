library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end;

architecture a_processador_tb of processador_tb is
    component processador is
        port(
            rst : in std_logic;
            clk : in std_logic;
            ula_o : out unsigned(15 downto 0);
            inst_o : out unsigned(15 downto 0);
            pc_o : out unsigned(6 downto 0);
            reg1_o : out unsigned(15 downto 0);
            reg2_o : out unsigned(15 downto 0);
            estado_o : out unsigned(1 downto 0)
        );
    end component;

    ---------------------------------------------------------
    -- sinais para todas as portas do toplevel
    constant period_time            : time       := 100 ns;
    signal finished                 : std_logic  := '0';
    signal wr_en_s, rst_s, clk_s    : std_logic;
    signal ula_o_s                  : unsigned(15 downto 0);
    signal inst_o_s                 : unsigned(15 downto 0);
    signal pc_o_s                   : unsigned(6 downto 0);
    signal reg1_o_s                 : unsigned(15 downto 0);
    signal reg2_o_s                 : unsigned(15 downto 0);
    signal estado_maq_s             : unsigned(1 downto 0);

    ---------------------------------------------------------

begin
    uut: processador port map (
        rst => rst_s,
        clk => clk_s,
        ula_o => ula_o_s,
        inst_o => inst_o_s,
        pc_o => pc_o_s,
        reg1_o => reg1_o_s,
        reg2_o => reg2_o_s,
        estado_o => estado_maq_s
    );

    ---------------------------------------------------------
    -- reset global / simulation time / clock
    reset_global: process
    begin
        rst_s <= '1';
        wait for period_time*2;
        rst_s <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 100 us;
        finished <= '1';
        wait;
    end process;

    clk_proc: process
    begin
        while finished /= '1' loop
            clk_s <= '0';
            wait for period_time/2;
            clk_s <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process;
    ---------------------------------------------------------

    ---------------------------------------------------------
    -- tudo que a simulação vai fazer (usar os signal)
    process
    begin
        wait;
    end process;
    ---------------------------------------------------------

end architecture;