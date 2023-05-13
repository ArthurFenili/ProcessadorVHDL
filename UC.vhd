library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port (
        clk, rst : in std_logic;
        instruction : in unsigned(15 downto 0);
        jump_en : out std_logic;
        ula_op : out unsigned(3 downto 0);
        ula_src : out std_logic;
        reg_write : out std_logic;
        pc_wr_en : out std_logic;
        estado_maq : out unsigned(1 downto 0)
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

begin
    maquinaestado: maq_estados port map (
        clk => clk,
        rst => rst,
        estado => estado_s
    );


    opcode <= instruction(15 downto 12);
    jump_en <= '1' when opcode = "1111" else '0';
    pc_wr_en <= '1' when estado_s = "00" else '0';
    estado_maq <= estado_s;

    ula_op <= "0001" when (opcode = "1000" or opcode = "0100" or opcode = "0001") else 
              "0010" when (opcode = "0010") else 
              "0000";

    ula_src <= '1' when opcode = "1000" else '0'; -- quando addi o mux vai mandar a entr1 (constante)

    reg_write <= '1' when estado_s = "01" and (opcode = "0100" or opcode = "1000" or opcode = "0001" or opcode = "0010") else '0';

end architecture;