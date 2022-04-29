-- Autor: Gabriel da Silva Corvino Nogueira
-- Email: gab.nog94@gmail.com
-- Matricula: 180113330
-- Descricao: Testbench para ULA RISC-V
-- Language Syntax: VHDL 1076-2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ulaRVTb is
end ulaRVTb;

architecture sim of ulaRVTb is

  component ulaRV is
    generic (WSIZE : natural := 32);
    port (
      opcode : in  std_logic_vector(3 downto 0);
      A, B   : in  std_logic_vector(WSIZE-1 downto 0);
      Z      : out std_logic_vector(WSIZE-1 downto 0);
      zero   : out std_logic);
  end component ulaRV;

  signal opcode : std_logic_vector(3 downto 0)  := (others => '0');
  signal A, B   : std_logic_vector(31 downto 0) := (others => '0');
  signal Z      : std_logic_vector(31 downto 0);
  signal zero   : std_logic;

begin

  ula : ulaRV port map(
    opcode => opcode,
    A      => A,
    B      => B,
    Z      => Z,
    zero   => zero);

  process is
  begin

    A <= x"0000F0CA";
    B <= x"0000F0FA";

    opcode <= x"0";
    wait for 1 ns;
    assert(Z = x"0001e1c4") report "Falha no Teste 1!" severity error;
    assert(zero = '0') report "Falha no Teste 2!" severity error;

    opcode <= x"1";
    wait for 1 ns;
    assert(Z = x"FFFFFFd0") report "Falha no Teste 3!" severity error;
    assert(zero = '0') report "Falha no Teste 4!" severity error;


    A <= x"FFFF0000";
    B <= x"0000FFFF";

    opcode <= x"2";
    wait for 1 ns;
    assert(Z = x"00000000") report "Falha no Teste 5!" severity error;
    assert(zero = '1') report "Falha no Teste 6!" severity error;

    opcode <= x"3";
    wait for 1 ns;
    assert(Z = x"FFFFFFFF") report "Falha no Teste 7!" severity error;
    assert(zero = '0') report "Falha no Teste 8!" severity error;

    opcode <= x"4";
    A      <= x"F0F0CA00";
    B      <= x"F0F0FAFF";

    wait for 1 ns;
    assert(Z = x"000030FF") report "Falha no Teste 9!" severity error;
    assert(zero = '0') report "Falha no Teste 10!" severity error;

    opcode <= x"5";
    A      <= x"CAFE0000";
    B      <= x"F0F0FAEC";

    wait for 1 ns;
    assert(Z = x"E0000000") report "Falha no Teste 11!" severity error;
    assert(zero = '0') report "Falha no Teste 12!" severity error;

    B <= x"F0F0FAEF";

    wait for 1 ns;
    assert(Z = x"00000000") report "Falha no Teste 13!" severity error;
    assert(zero = '1') report "Falha no Teste 14!" severity error;

    opcode <= x"6";
    B      <= x"F0F0FAF0";

    wait for 1 ns;
    assert(Z = x"0000CAFE") report "Falha no Teste 15!" severity error;
    assert(zero = '0') report "Falha no Teste 16!" severity error;

    opcode <= x"7";

    wait for 1 ns;
    assert(Z = x"FFFFCAFE") report "Falha no Teste 17!" severity error;
    assert(zero = '0') report "Falha no Teste 18!" severity error;

    opcode <= x"8";

    wait for 1 ns;
    assert(Z = x"00000001") report "Falha no Teste 19!" severity error;
    assert(zero = '0') report "Falha no Teste 20!" severity error;

    opcode <= x"9";

    wait for 1 ns;
    assert(Z = x"00000001") report "Falha no Teste 21!" severity error;
    assert(zero = '0') report "Falha no Teste 22!" severity error;

    opcode <= x"A";

    wait for 1 ns;
    assert(Z = x"00000000") report "Falha no Teste 23!" severity error;
    assert(zero = '1') report "Falha no Teste 24!" severity error;

    opcode <= x"B";

    wait for 1 ns;
    assert(Z = x"00000000") report "Falha no Teste 25!" severity error;
    assert(zero = '1') report "Falha no Teste 26!" severity error;

    opcode <= x"C";

    wait for 1 ns;
    assert(Z = x"00000000") report "Falha no Teste 27!" severity error;
    assert(zero = '1') report "Falha no Teste 28!" severity error;

    opcode <= x"D";

    wait for 1 ns;
    assert(Z = x"00000001") report "Falha no Teste 29!" severity error;
    assert(zero = '0') report "Falha no Teste 30!" severity error;

    opcode <= x"1";
    A      <= x"BABAB0BA";
    B      <= x"BABAB0BA";

    wait for 1 ns;
    assert(Z = x"00000000") report "Falha no Teste 31!" severity error;
    assert(zero = '1') report "Falha no Teste 32!" severity error;

    opcode <= x"0";
    A      <= x"7FFFFFFF";
    B      <= x"30000000";

    wait for 1 ns;
    assert(Z = x"AFFFFFFF") report "Falha no Teste 33!" severity error;
    assert(zero = '0') report "Falha no Teste 34!" severity error;

    wait;
  end process;
end architecture;

