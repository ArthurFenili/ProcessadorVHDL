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
    0 => "0000000000000000", 
    1 => "0000000000000000",
    2 => "1000001000000110", -- addi r1 6
    3 => "1000010000000001", -- addi r2 1
    4 => "0000000000000000", 
    5 => "0100011010000000", -- move r3 r2
    6 => "0001011001000000", -- add r3 r1
    7 => "0000000000000000", 
    8 => "0000000000000000",
    9 => "1000100000001010", -- addi r4 10
    10 => "1000101000000110", -- addi r5 6
    11 => "0100110100000000", -- move r6 r4
    12 => "0010110101000000", -- sub r6 r5
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