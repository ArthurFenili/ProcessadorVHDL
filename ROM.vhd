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
    1 => "1000011000000101", 
    2 => "1000100000001000", 
    3 => "0001101011100000", 
    4 => "1000001000000001", 
    5 => "0010101101001000", 
    6 => "1111000000010100", 
    7 => "0000000000000000", 
    8 => "0000000000000000",
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
    20 => "0100011101000000",
    21 => "1111000000000011",
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