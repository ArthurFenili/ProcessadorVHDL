library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCUC is
    port (
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        d_out : out unsigned(6 downto 0)
    );
end entity;

architecture a_PCUC of PCUC is
    component PC is
        port( 
            clk : in std_logic;
            wr_en : in std_logic;
            rst : in std_logic;
            data_in : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component;

    component protoUC is
        port (
            data_in : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component;

    signal outpc, inpc : unsigned(6 downto 0);

    begin
        pc1: PC port map (
            clk => clk,
            wr_en => wr_en,
            rst => rst,
            data_in => inpc,
            data_out => outpc
        );

        uc1: protoUC port map (
            data_in => outpc,
            data_out => inpc
        );

        d_out <= outpc;

end architecture;