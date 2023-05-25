library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
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
end entity;

architecture a_processador of processador is
    ---------------------------------------------------------
    -- declara os componentes que serão utilizados
    component ula is 
        port( 
            x,y : in unsigned(15 downto 0);
            op : in unsigned(3 downto 0);
            saida : out unsigned(15 downto 0);
            n_flag, v_flag : out std_logic
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
            jump : in unsigned(1 downto 0);
            end_jump : in unsigned(6 downto 0);
            end_branch : in unsigned(6 downto 0)
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
            clk, rst : in std_logic;
            instruction : in unsigned(15 downto 0);
            jump_en : out unsigned(1 downto 0);
            ula_op : out unsigned(3 downto 0);
            ula_src : out std_logic;
            reg_write : out std_logic;
            pc_wr_en : out std_logic;
            estado_maq : out unsigned(1 downto 0);
            ula_wr_en : out std_logic;
            n_flag_in, v_flag_in : in std_logic
        );
    end component;

    component reg16bits is
        port (  
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component CCR is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            n_in, v_in : in std_logic;
            n_out, v_out : out std_logic
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
    signal jump_to_pcuc : unsigned(1 downto 0);
    signal uc_to_ula_op : unsigned(3 downto 0);
    signal uc_to_mux_src : std_logic;
    signal instruction_const : unsigned(15 downto 0);
    signal reg_wr_en : std_logic;
    signal readReg1_s : unsigned(2 downto 0);
    signal readReg2_s : unsigned(2 downto 0);
    signal uc_to_pc : std_logic; 
    signal ccr_to_uc : unsigned(4 downto 0);
    signal ula_out_to_ccr : unsigned(15 downto 0);
    signal branch_dest : unsigned(6 downto 0);
    signal uc_to_ula : std_logic;
    signal nflag_s, vflag_s : std_logic;
    signal nflag_out_s, vflag_out_s : std_logic;
    ---------------------------------------------------------

begin
    ---------------------------------------------------------
    -- cria os componentes dentro do toplevel
    ula1: ula port map (
        x => br_to_ula,
        y => mux_to_ula,
        op => uc_to_ula_op,
        saida => ula_to_br,
        n_flag => nflag_s,
        v_flag => vflag_s 
    );

    bancoreg1: bancoreg port map (
        readReg1 => readReg1_s,
        readReg2 => readReg2_s,
        writeReg => rom_to_uc(11 downto 9),
        wr_en => reg_wr_en,
        rst => rst,
        clk => clk,
        data => ula_to_br,
        readData1 => br_to_ula,
        readData2 => br_to_mux
    );

    mux2x1_1: mux2x1 port map (
        sel => uc_to_mux_src,
        entr0 => br_to_mux,
        entr1 => instruction_const,
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
        wr_en => uc_to_pc, 
        d_out => pcuc_to_rom,
        jump => jump_to_pcuc,
        end_jump => rom_to_uc(6 downto 0),
        end_branch => branch_dest
    );

    uc1: UC port map (
        clk => clk,
        rst => rst,
        instruction => rom_to_uc,
        jump_en => jump_to_pcuc,
        ula_op => uc_to_ula_op,
        ula_src => uc_to_mux_src,
        reg_write => reg_wr_en,
        pc_wr_en => uc_to_pc,
        estado_maq => estado_o,
        ula_wr_en => uc_to_ula,
        n_flag_in => nflag_out_s, 
        v_flag_in => vflag_out_s
    );

    reg_inst: reg16bits port map (
        clk => clk,
        rst => rst,
        wr_en => '1',
        data_in => rom_to_uc,
        data_out => inst_o
    );

    ccr1: CCR port map (
        clk => clk, 
        rst => rst,
        wr_en => uc_to_ula,
        n_in => nflag_s, 
        v_in => vflag_s,
        n_out => nflag_out_s, 
        v_out => vflag_out_s
    );

    ula_result: reg16bits port map (
        clk => clk,
        rst => rst,
        wr_en => uc_to_ula,
        data_in => ula_to_br,
        data_out => ula_out_to_ccr
    );

    ---------------------------------------------------------

    ula_o <= ula_to_br;
    pc_o <= pcuc_to_rom;
    reg1_o <= br_to_ula;
    reg2_o <= br_to_mux; 
    instruction_const <= "0000000" & rom_to_uc(8 downto 0) when rom_to_uc(8) = '0' else 
                         "1111111" & rom_to_uc(8 downto 0);
    readReg1_s <= rom_to_uc(8 downto 6) when (rom_to_uc(15 downto 12) = "0100" or rom_to_uc(15 downto 12) = "0001" or rom_to_uc(15 downto 12) = "0010") else "000";
    readReg2_s <= "000" when rom_to_uc(15 downto 12) = "0100" else rom_to_uc(5 downto 3);
    branch_dest <= rom_to_uc(6 downto 0);

end architecture;