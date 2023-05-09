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
    -- 111=opcode 001=reg1 010=reg2 011=reg3 0010=dado
    0 => "0001101010001000",
    1 => "0111110100011110",
    2 => "1111001011010010",
    3 => "1100011100011111",
    4 => "1001111111111111",
    5 => "0000000000000001",
    6 => "1110000011110000",
    7 => "0101010101010101",
    8 => "1010101010101010",
    9 => "0011001100110011",
    10 => "0110101001010110",
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