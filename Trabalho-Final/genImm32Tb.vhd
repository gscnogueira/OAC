-- Autor     : Gabriel da Silva Corvino Nogueira
-- Email     : gab.nog94@gmail.com
-- Matricula : 180113330
-- Descrição : Testbench para Gerador de Imediatos de 32 bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genImm32Tb is

end entity genImm32Tb;

architecture sim of genImm32Tb is

  component genImm32 is
    port (
      instr : in  std_logic_vector(31 downto 0);
      imm32 : out signed(31 downto 0));
  end component genImm32;

  signal instr_in  : std_logic_vector(31 downto 0);
  signal imm32_out : signed(31 downto 0);

begin

  greador : genImm32 port map(instr_in, imm32_out);

  process
  begin
    instr_in <= x"000002b3";
    wait for 1 ns;
    assert(imm32_out = x"0") report "Error Teste 1" severity error;


    instr_in <= x"01002283";
    wait for 1 ns;
    assert(imm32_out = x"00000010") report "Error Teste 2" severity error;

    instr_in <= x"f9c00313";
    wait for 1 ns;
    assert(imm32_out = x"FFFFFF9C") report "Error Teste 3" severity error;

    instr_in <= x"fff2c293";
    wait for 1 ns;
    assert(imm32_out = x"FFFFFFFF") report "Error Teste 4" severity error;

    instr_in <= x"16200313";
    wait for 1 ns;
    assert(imm32_out = x"00000162") report "Error Teste 5" severity error;

    instr_in <= x"01800067";
    wait for 1 ns;
    assert(imm32_out = x"00000018") report "Error Teste 6" severity error;

    instr_in <= x"00002437";
    wait for 1 ns;
    assert(imm32_out = x"00002000") report "Error Teste 7" severity error;

    instr_in <= x"02542e23";
    wait for 1 ns;
    assert(imm32_out = x"0000003C") report "Error Teste 8" severity error;

    instr_in <= x"fe5290e3";
    wait for 1 ns;
    assert(imm32_out = x"FFFFFFE0") report "Error Teste 9" severity error;

    instr_in <= x"00c000ef";
    wait for 2 ns;
    assert(imm32_out = x"0000000C") report "Error Teste 10" severity error;

    assert false report "Test done." severity note;

    wait;

  end process;

end sim;
