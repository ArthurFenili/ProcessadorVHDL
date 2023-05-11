library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port (
        instruction : in unsigned(15 downto 0);
        jump_en : out std_logic;
        ula_op : out unsigned(3 downto 0);
        ula_src : out std_logic
    );
end entity;

architecture a_UC of UC is
    signal opcode : unsigned(3 downto 0);
begin
    opcode <= instruction(15 downto 12);
    jump_en <= '1' when opcode = "1111" else '0';

    ula_op <= "0001" when opcode = "1000" else "0000"; -- quando addi seleciona op de soma

    ula_src <= '1' when opcode = "1000" else '0'; -- quando addi o mux vai mandar a entr1 (constante)

end architecture;