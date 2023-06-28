library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
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
        n_flag_in, v_flag_in : in std_logic;
        ram_wr_en : out std_logic
    );
end entity;

architecture a_UC of UC is
    component maq_estados is
    port( 
        clk,rst: in std_logic;
        estado: out unsigned(1 downto 0)
    );
    end component;

    signal opcode : unsigned(3 downto 0);
    signal estado_s : unsigned(1 downto 0);
    signal branch_code : unsigned(3 downto 0);

begin
    maquinaestado: maq_estados port map (
        clk => clk,
        rst => rst,
        estado => estado_s
    );


    estado_maq <= estado_s;
    opcode <= instruction(15 downto 12);
    branch_code <= instruction(11 downto 8);
    
    jump_en <= "01" when opcode = "1111" else
                "10" when opcode = "0110" and branch_code = "1101" and std_logic((n_flag_in and not(v_flag_in)) or (not(n_flag_in) and v_flag_in)) = '1' else
                "10" when opcode = "0110" and branch_code = "1100" and std_logic((n_flag_in and v_flag_in) or (not(n_flag_in) and not(v_flag_in))) = '1' else
                "00";

    pc_wr_en <=   '1' when estado_s = "00" else '0';

    ula_wr_en <=  '1' when estado_s = "00" and (opcode = "0001" or opcode = "1000" or opcode = "0010" or opcode = "1011") else '0';

    ula_op <= "0001" when (opcode = "1000" or opcode = "0100" or opcode = "0001") else 
              "0010" when (opcode = "0010" or opcode = "1011") else 
              "0000";

    ula_src <= '1' when opcode = "1000" else '0'; -- quando addi o mux vai mandar a entr1 (constante)

    reg_write <= '1' when (estado_s = "01" and (opcode = "0101" or opcode = "0100" or opcode = "1000" or opcode = "0001" or opcode = "0010")) else '0';
    ram_wr_en <= '1' when estado_s = "01" and opcode = "0111" else '0';

end architecture;
