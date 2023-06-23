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
    0 => "1000001000000011", -- r1 <- 3
    1 => "1000010000000100", -- r2 <- 4
    2 => "0111001010000000", -- endereço 3 (r1) <- 4
    3 => "0101100001000000", -- r4 <- 4 (valor do endereço 3)
    4 => "0000000000000000", -- 
    5 => "0000000000000000", -- 
    6 => "0000000000000000", -- 
    7 => "0000000000000000", -- 
    8 => "0000000000000000", -- 
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