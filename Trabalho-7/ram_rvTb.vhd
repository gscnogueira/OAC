-- Autor: Gabriel da Silva Corvino Nogueira
-- Email: gab.nog94@gmail.com
-- Matricula: 180113330
-- Descricao: Testbench para Memórias ROM e RAM do RISC-V
-- Language Syntax: VHDL 1076-2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_rvTb is
end ram_rvTb;

architecture sim of ram_rvTb is

  component ram_rv is
    port (
      clock   : in  std_logic;
      we      : in  std_logic;
      address : in  std_logic_vector;
      datain  : in  std_logic_vector;
      dataout : out std_logic_vector
      );
  end component ram_rv;

  signal clock   : std_logic;
  signal we      : std_logic;
  signal address : std_logic_vector(7 downto 0) := (others => '0');
  signal datain  : std_logic_vector(31 downto 0);
  signal dataout : std_logic_vector(31 downto 0);

begin

  ram : ram_rv port map(
    clock   => clock,
    we      => we,
    address => address,
    datain  => datain,
    dataout => dataout);

  clk : process is
  begin
    clock <= '1';
    wait for 0.5 ns;
    clock <= '0';
    wait for 0.5 ns;
  end process;

  process is
  begin
    we      <= '1';
    address <= x"10";
    datain  <= x"FFFFFFFF";

    wait for 1 ns;

    assert(dataout = x"FFFFFFFF") report "Falha na escrita/leitura dos dados";

    we     <= '0';
    datain <= x"F0CAF0FA";

    wait for 1 ns;

    assert(dataout = x"FFFFFFFF") report "Falha na escrita/leitura dos dados";

    we <= '1';

    wait for 1 ns;

    assert(dataout = x"F0CAF0FA") report "Falha na escrita/leitura dos dados";

    for i in 0 to 255 loop
      address <= std_logic_vector(to_unsigned(i, 8));
      datain  <= std_logic_vector(to_unsigned(i, 30)) & "00";
      wait for 1 ns;
      assert(dataout = std_logic_vector(to_unsigned(i, 30)) & "00") report "Falha na escrita/leitura dos dados";
    end loop;

    wait;

  end process;

end architecture;
