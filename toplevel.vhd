library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
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
end entity;

architecture a_toplevel of toplevel is
    ---------------------------------------------------------
    -- declara os componentes que serão utilizados
    component ula is 
        port( 
            x,y : in unsigned(15 downto 0);
            op : in unsigned(3 downto 0);
            saida : out unsigned(15 downto 0)
        );
    end component;

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

    component mux2x1 is
        port(
            sel : in std_logic;
            entr0, entr1 : in unsigned (15 downto 0);
            saida : out unsigned (15 downto 0)
        );
    end component;
    ---------------------------------------------------------

    ---------------------------------------------------------
    -- sinais (fios) pra ligar um componente ao outro
    signal br_to_ula : unsigned(15 downto 0);
    signal br_to_mux : unsigned(15 downto 0);
    signal mux_to_ula : unsigned(15 downto 0);
    signal ula_to_br : unsigned(15 downto 0);
    ---------------------------------------------------------

begin
    ---------------------------------------------------------
    -- cria os componentes dentro do toplevel
    ula1: ula port map (
        x => br_to_ula,
        y => mux_to_ula,
        op => ula_operation,
        saida => ula_to_br
    );

    bancoreg1: bancoreg port map (
        readReg1 => br_readReg1,
        readReg2 => br_readReg2,
        writeReg => br_writeReg,
        wr_en => wr_en,
        rst => rst,
        clk => clk,
        data => ula_to_br,
        readData1 => br_to_ula,
        readData2 => br_to_mux
    );

    mux2x1_1: mux2x1 port map (
        sel => mux1_selection,
        entr0 => br_to_mux,
        entr1 => constant_mux1_i,
        saida => mux_to_ula 
    );
    ---------------------------------------------------------

    ula_o <= ula_to_br;

end architecture;