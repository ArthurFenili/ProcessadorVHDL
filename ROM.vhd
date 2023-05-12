library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port( 
        clk : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado : out unsigned(15 downto 0)
    );
end entity;


architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    constant conteudo_rom : mem := (
    -- caso endereco => conteudo
    -- endereço da inst => inst de 16 bits tipo 
    -- 1110010100110010
    -- 1111=opcode 001=reg1 010=reg2 011=reg3 010=dado
    0 => "0011101010000000", --
    1 => "0111110100011110", --
    2 => "1000001010000111", -- 1000 001 010000111 | addi r1 87
    3 => "1100011100011111", --
    4 => "0100011001110000", -- 0100 011 001 110000 | movem r3 r1 ----
    5 => "1000010000000001", -- 1000 010 000000001 | addi r2 1
    6 => "0101010101010101", --
    7 => "0001111001011011", -- 0001 111 001 011 011 | add r7 r1 r3 ---
    8 => "0110101001010110", --
    9 => "0010110111010101", -- 0010 110 111 010 101 | sub r6 r7 r2 ---
    10 => "0011001100110011", -- 
    -- abaixo: casos omissos => (zero em todos os bits)
    others => (others=>'0')
    );

    begin
    process(clk)
        begin
        if(rising_edge(clk)) then
        dado <= conteudo_rom(to_integer(endereco));
    end if;
    end process;
end architecture;