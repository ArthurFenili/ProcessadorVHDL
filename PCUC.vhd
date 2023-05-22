library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCUC is
    port (
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        d_out : out unsigned(6 downto 0);
        jump : in unsigned(1 downto 0);
        end_jump : in unsigned(6 downto 0);
        end_branch : in unsigned(6 downto 0)
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

    component mux3x1_7bits is
        port(
            sel : in unsigned(1 downto 0);
            entr0, entr1, entr2 : in unsigned (6 downto 0);
            saida : out unsigned (6 downto 0)
        );
    end component;

    signal outpc, inpc, jump_pc : unsigned(6 downto 0);

    begin
        pc1: PC port map (
            clk => clk,
            wr_en => wr_en,
            rst => rst,
            data_in => jump_pc,
            data_out => outpc
        );

        uc1: protoUC port map (
            data_in => outpc,
            data_out => inpc
        );

        mux1: mux3x1_7bits port map (
            sel => jump,
            entr0 => inpc,
            entr1 => end_jump,
            entr2 => end_branch,
            saida => jump_pc
        );

        d_out <= outpc;

end architecture;