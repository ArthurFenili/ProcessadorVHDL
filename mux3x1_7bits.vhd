library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3x1_7bits is
    port(
        sel : in unsigned(1 downto 0);
        entr0, entr1, entr2 : in unsigned (6 downto 0);
        saida : out unsigned (6 downto 0)
    );
end entity;

architecture a_mux3x1_7bits of mux3x1_7bits is
begin
    saida <= entr0 when sel = "00" else
             entr1 when sel = "01" else
             entr0 + entr2 when sel = "10" else
             "0000000";

end architecture;