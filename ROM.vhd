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
    -- endereço da inst => inst de 16 bits
    0 => "1000011000000000", -- addi r3 0
    1 => "1000100000000000", -- addi r4 0
    2 => "1000111000011110", -- addi r7 30
    3 => "1000110000000001", -- addi r6 1
    4 => "0001100011000000", -- add r4, r3
    5 => "0001011110000000", -- add r3, r6
    6 => "1011011111000000", -- cmp r3, r7
    7 => "0110110111111100", -- blt 3
    8 => "0100101100000000", -- move r5, r4
    9 => "0000000000000000",
    10 => "0000000000000000", 
    11 => "0000000000000000", 
    12 => "0000000000000000",
    13 => "0000000000000000",
    14 => "0000000000000000",
    15 => "0000000000000000",
    16 => "0000000000000000",
    17 => "0000000000000000",
    18 => "0000000000000000",
    19 => "0000000000000000",
    20 => "0000000000000000",
    21 => "0000000000000000",
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