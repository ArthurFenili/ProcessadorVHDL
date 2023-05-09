library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg is
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
end entity;

architecture a_bancoreg of bancoreg is
    component reg16bits is 
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    type regs_array is array (7 downto 0) of unsigned(15 downto 0);

    signal outData1, outData2 : unsigned(15 downto 0);
    signal wr_enables : unsigned (7 downto 0);
    signal data_regs_array : regs_array;
    
    begin
        -- componente => geral
        reg0: reg16bits port map (
            data_in => X"0000",
            data_out => data_regs_array(0),
            clk => clk,
            rst => rst, 
            wr_en => wr_enables(0)
        );
        
        reg1: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(1),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(1)
        );

        reg2: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(2),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(2)
        );

        reg3: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(3),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(3)
        );

        reg4: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(4),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(4)
        );

        reg5: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(5),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(5)
        );

        reg6: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(6),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(6)
        );

        reg7: reg16bits port map (
            data_in => data,
            data_out => data_regs_array(7),
            clk => clk,
            rst => rst,
            wr_en => wr_enables(7)
        );

        process(clk, rst)
        begin
            if rst='1' then
                outData1 <= X"0000";
                outData2 <= X"0000";
            else
                if rising_edge(clk) then
                    outData1 <= data_regs_array(to_integer(readReg1));
                    outData2 <= data_regs_array(to_integer(readReg2));
                end if;
            end if;
            
        end process;

        wr_enables(0) <= '0';
        wr_enables(1) <= wr_en when to_integer(writeReg)= 1 else '0';
        wr_enables(2) <= wr_en when to_integer(writeReg)= 2 else '0';
        wr_enables(3) <= wr_en when to_integer(writeReg)= 3 else '0';
        wr_enables(4) <= wr_en when to_integer(writeReg)= 4 else '0';
        wr_enables(5) <= wr_en when to_integer(writeReg)= 5 else '0';
        wr_enables(6) <= wr_en when to_integer(writeReg)= 6 else '0';
        wr_enables(7) <= wr_en when to_integer(writeReg)= 7 else '0';

        readData1 <= outData1;
        readData2 <= outData2;
    

end architecture;