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
        br_writeReg : in unsigned(2 downto 0);
        rom_o : out unsigned(15 downto 0);
        wr_en_pc : in std_logic;
        uc_jump_o : out std_logic
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

    component ROM is
        port( 
            clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado : out unsigned(15 downto 0)
        );
    end component;

    component PCUC is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            d_out : out unsigned(6 downto 0);
            jump : in std_logic;
            end_jump : in unsigned(6 downto 0)
        );
    end component;

    component reg1bit is
        port (  clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_out: out std_logic
        );
    end component;

    component UC is
        port (
            instruction : in unsigned(15 downto 0);
            jump_en : out std_logic
        );
    end component;
    ---------------------------------------------------------

    ---------------------------------------------------------
    -- sinais (fios) pra ligar um componente ao outro
    signal br_to_ula : unsigned(15 downto 0);
    signal br_to_mux : unsigned(15 downto 0);
    signal mux_to_ula : unsigned(15 downto 0);
    signal ula_to_br : unsigned(15 downto 0);
    signal pcuc_to_rom : unsigned(6 downto 0);
    signal reg1bit_to_pc : std_logic;
    signal rom_to_uc : unsigned(15 downto 0);
    signal jump_to_pcuc : std_logic;
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

    rom1: ROM port map (
        clk => clk,
        endereco => pcuc_to_rom,
        dado => rom_to_uc
    );

    pcuc1: PCUC port map (
        clk => clk,
        rst => rst,
        wr_en => reg1bit_to_pc, 
        d_out => pcuc_to_rom,
        jump => jump_to_pcuc,
        end_jump => rom_to_uc(6 downto 0)
    );

    incr_pc: reg1bit port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en_pc, 
        data_out => reg1bit_to_pc
    );

    uc1: UC port map (
        instruction => rom_to_uc,
        jump_en => jump_to_pcuc
    );
    ---------------------------------------------------------

    ula_o <= ula_to_br;
    rom_o <= rom_to_uc;
    uc_jump_o <= jump_to_pcuc;

end architecture;