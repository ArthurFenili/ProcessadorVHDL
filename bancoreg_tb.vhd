library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg_tb is
end;

architecture a_bancoreg_tb of bancoreg_tb is 
    component bancoreg is
        port(
            readReg1 : in unsigned (2 downto 0);
            readReg2 : in unsigned (2 downto 0);
            writeReg : in unsigned (2 downto 0);
            wr_en : in std_logic;
            rst : in std_logic;
            clk : in std_logic;
            data : in unsigned (15 downto 0);
            readData1 : out unsigned (15 downto 0);
            readData2 : out unsigned (15 downto 0)
            );
    end component;

    constant period_time : time       := 100 ns;
    signal finished      : std_logic  := '0';
    signal clk, reset, wr_en : std_logic;
    signal read1, read2, write1 : unsigned(2 downto 0);
    signal data_in1, data_out1, data_out2 : unsigned(15 downto 0);

begin
    uut: bancoreg port map (
        clk => clk,
        rst => reset,
        wr_en => wr_en,
        data => data_in1,
        readReg1 => read1,
        readReg2 => read2,
        writeReg => write1,
        readData1 => data_out1,
        readData2 => data_out2
    );

    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2;
        reset <= '0';
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
        wr_en <= '0';
        wait for 200 ns;
        wr_en <= '1';
        write1 <= "011";
        data_in1 <= "1100101100101001";
        wait for 100 ns;
        wr_en <= '1';
        write1 <= "101";
        data_in1 <= "0110110101110101";
        wait for 100 ns;
        wr_en <= '0';
        write1 <= "111";
        data_in1 <= "1111111111111111";
        wait for 100 ns;
        wr_en <= '0';
        read1 <= "011";
        read2 <= "101";
        wait for 100 ns;
        wr_en <= '1';
        write1 <= "000";
        data_in1 <= "1011101110101111";
        wait for 100 ns;
        wr_en <= '0';
        read1 <= "000";
        read2 <= "111";
        wait for 100 ns;
        wait;


    end process;


end architecture;