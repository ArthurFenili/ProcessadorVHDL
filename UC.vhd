library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port (
        instruction : in unsigned(15 downto 0);
        jump_en : out std_logic
    );
end entity;

architecture a_UC of UC is
    signal opcode : unsigned(3 downto 0);
begin
    opcode <= instruction(15 downto 12);
    jump_en <= '1' when opcode = "1111" else '0';

end architecture;