-- Autor     : Gabriel da Silva Corvino Nogueira
-- Email     : gab.nog94@gmail.com
-- Matricula : 180113330
-- Descrição : Testbench para Banco de Registradores do RISC-V

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity XREGSTb is
end entity XREGSTb;

architecture sim of XREGSTb is

  component XREGS is
    generic (WSIZE : natural := 32);
    port (
      clk, wren, rst : in  std_logic;
      rs1, rs2, rd   : in  std_logic_vector(4 downto 0);
      data           : in  std_logic_vector(WSIZE-1 downto 0);
      ro1, ro2       : out std_logic_vector(WSIZE-1 downto 0));
  end component XREGS;

  signal clk, wren, rst : std_logic                     := '0';
  signal rs1, rs2, rd   : std_logic_vector(4 downto 0)  := (others => '0');
  signal data           : std_logic_vector(31 downto 0) := (others => '0');
  signal ro1, ro2       : std_logic_vector(31 downto 0) := (others => '0');


begin

  i_XREGS : XREGS port map(
    clk  => clk,
    wren => wren,
    rst  => rst,
    rs1  => rs1,
    rs2  => rs2,
    rd   => rd,
    data => data,
    ro1  => ro1,
    ro2  => ro2);

  process is
  begin
    -- set values:
    wren <= '1';
    rd   <= '0' & x"3";
    data <= x"F0CAF0FA";
    wait for 1 ns;

    assert(ro1 = x"00000000") report "Falha no Teste 1 - Valor não foi lido/escrito corretamente" severity error;
    assert(ro2 = x"00000000") report "Falha no Teste 2 - Valor não foi lido/escrito corretamente" severity error;

    -- Periodo de clock:
    clk <= '1';
    wait for 1 ns;
    clk <= '0';

    wren <= '0';
    rs1  <= rd;
    wait for 1 ns;
    assert(ro1 = x"F0CAF0FA") report "Falha no Teste 3 -Valor não foi lido/armazenado corretamente" severity error;

    rs2 <= rd;
    wait for 1 ns;
    assert(ro2 = x"F0CAF0FA") report "Falha no Teste 4 -Valor não foi lido/armazenado corretamente" severity error;

    rd  <= "00000";
    rs1 <= "00000";
    wait for 1 ns;

    -- Periodo de clock:
    clk <= '1';
    wait for 1 ns;
    clk <= '0';

    assert(ro1 = x"00000000") report "Falha no Teste 5 - XREGS[0] está sendo escrito!" severity error;


    data <= x"CAFECAFE";
    rd   <= '0' & x"A";
    rs1  <= '0' & x"A";
    wait for 1 ns;

    -- Periodo de clock:
    clk <= '1';
    wait for 1 ns;
    clk <= '0';

    assert(ro1 = x"00000000") report "Falha no Teste 6 - A escrita não pode ser realizada!" severity error;

    wren <= '1';
    wait for 1 ns;

    clk  <= '1';
    wait for 1 ns;
    clk  <= '0';

    wren <= '0';

    assert(ro1 = x"CAFECAFE") report "Falha no Teste 7 - A escrita não foi realizada!" severity error;

    rst <= '1';
    wait for 1 ns;
    rst <= '0';

    assert(ro1 = x"00000000") report "Falha no Teste 8 - O banco de registradores não foi resetado!" severity error;
    assert(ro2 = x"00000000") report "Falha no Teste 9 - O banco de registradores não foi resetado!" severity error;

    wait;


  end process;
end sim;



