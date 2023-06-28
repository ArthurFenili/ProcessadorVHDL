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
    0 => B"1000_001_000000000", -- 
    1 => B"1000_010_000100000", -- 
    2 => B"1000_011_000000001", -- 
    3 => B"0001_001_011_000000", -- 
    4 => B"0111_001_001_000000", -- 
    5 => B"1011_001_010_000000", -- 
    6 => B"0110_1101_11111100", -- 
    7 => B"1000_001_000000010", -- 
    8 => B"1000_011_000000010", -- 
    9 => B"0001_001_011_000000",
    10 => B"0111_001_000_000000", 
    11 => B"1011_001_010_000000", 
    12 => B"0110_1101_11111100",
    13 => B"1000_001_000000000",
    14 => B"0001_001_011_000000",
    15 => B"1000_100_000000001",
    16 => B"0001_001_100_000000",
    17 => B"0101_101_001_000000",
    18 => B"1011_101_100_000000",
    19 => B"0110_1101_11111100",
    20 => B"1000_011_000000000",
    21 => B"0001_011_001_000000",
    22 => B"1111_000000001001",
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