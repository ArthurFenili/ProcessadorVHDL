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
    0 => "0001101010000000", --1A80
    1 => "0111110100011110", --7D1E
    2 => "1000001010000111", --F287
    3 => "1100011100011111", --C71F
    4 => "1001111111111111", --9FFF
    5 => "0000000000000001", --0001
    6 => "1110000011110000", --E0F0
    7 => "0101010101010101", --5555
    8 => "1111101010000110", --AAAA
    9 => "0011001100110011", --3333
    10 => "0110101001010110", --6A56
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