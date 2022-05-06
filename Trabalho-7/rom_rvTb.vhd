-- Autor: Gabriel da Silva Corvino Nogueira
-- Email: gab.nog94@gmail.com
-- Matricula: 180113330
-- Descricao: Testbench para memória ROM do RISC-V
-- Language Syntax: VHDL 1076-2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity rom_rvTb is
end rom_rvTb;

architecture sim of rom_rvTb is

  component rom_rv is
    port (
      address : in  std_logic_vector;
      dataout : out std_logic_vector
      );
  end component rom_rv;

  signal address : std_logic_vector(7 downto 0) := (others => '0');
  signal dataout : std_logic_vector(31 downto 0);

begin

  rom : rom_rv port map(
    address => address,
    dataout => dataout);

  process is
  begin
    for i in 0 to 255 loop
      address <= std_logic_vector(to_unsigned(i, 8));
      wait for 1 ns;
      report to_hstring(dataout);
    end loop;

    wait;

  end process;

end architecture;
