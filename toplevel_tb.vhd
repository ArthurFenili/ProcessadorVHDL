library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end;

architecture a_toplevel_tb of toplevel_tb is
    component toplevel is
        port(
            wr_en : in std_logic;
            rst : in std_logic;
            clk : in std_logic;
            constant_mux1_i : in unsigned(15 downto 0);
            ula_o : out unsigned(15 downto 0);
            ula_operation : in unsigned(3 downto 0);
            mux1_selection : in std_logic;
            br_readReg1 : in unsigned(2 downto 0);
            br_readReg2 : in unsigned(2 downto 0);
            br_writeReg : in unsigned(2 downto 0)
        );
    end component;

    ---------------------------------------------------------
    -- sinais para todas as portas do toplevel
    constant period_time            : time       := 100 ns;
    signal finished                 : std_logic  := '0';
    signal wr_en_s, rst_s, clk_s    : std_logic;
    signal constant_mux1_i_s        : unsigned(15 downto 0);
    signal ula_o_s                  : unsigned(15 downto 0);
    signal ula_operation_s          : unsigned(3 downto 0);
    signal mux1_selection_s         : std_logic;
    signal br_readReg1_s            : unsigned(2 downto 0);
    signal br_readReg2_s            : unsigned(2 downto 0);
    signal br_writeReg_s            : unsigned(2 downto 0);

    ---------------------------------------------------------

begin
    uut: toplevel port map (
        wr_en => wr_en_s,
        rst => rst_s,
        clk => clk_s,
        constant_mux1_i => constant_mux1_i_s,
        ula_o => ula_o_s,
        ula_operation => ula_operation_s,
        mux1_selection => mux1_selection_s,
        br_readReg1 => br_readReg1_s,
        br_readReg2 => br_readReg2_s,
        br_writeReg => br_writeReg_s
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
        wait for 10 us;
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
        wr_en_s <= '1';
        wait for 200 ns;
        ula_operation_s <= "0001";
        br_readReg1_s <= "000";
        br_readReg2_s <= "001";
        mux1_selection_s <= '1';
        br_writeReg_s <= "010";
        constant_mux1_i_s <= "1101110100100111";
        wait for 200 ns;
        br_readReg1_s <= "000";
        br_readReg2_s <= "001";
        mux1_selection_s <= '1';
        br_writeReg_s <= "011";
        constant_mux1_i_s <= "1101110101011011";
        wait for 200 ns;
        mux1_selection_s <= '0';
        br_readReg1_s <= "010";
        br_readReg2_s <= "011";
        br_writeReg_s <= "100";
        wait;
    end process;
    ---------------------------------------------------------

end architecture;