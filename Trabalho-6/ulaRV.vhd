-- Autor: Gabriel da Silva Corvino Nogueira
-- Email: gab.nog94@gmail.com
-- Matricula: 180113330
-- Descricao: ULA RISC-V
-- Language Syntax: VHDL 1076-2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ulaRV is
  generic (WSIZE : natural := 32);
  port (
    opcode : in  std_logic_vector(3 downto 0);
    A, B   : in  std_logic_vector(WSIZE-1 downto 0);
    Z      : out std_logic_vector(WSIZE-1 downto 0);
    zero   : out std_logic);
end ulaRV;

architecture rtl of ulaRV is
  signal result : std_logic_vector(31 downto 0);
begin
  Z <= result;
  proc_ula :
  process (A, B, opcode, result)
  begin
    if(result = x"00000000") then
      zero <= '1';
    else
      zero <= '0';
    end if;
    case opcode is
      when x"0"   => result <= std_logic_vector(signed(A) + signed(B));
      when x"1"   => result <= std_logic_vector(signed(A) - signed(B));
      when x"2"   => result <= A and B;
      when x"3"   => result <= A or B;
      when x"4"   => result <= A xor B;
      when x"5"   => result <= std_logic_vector(shift_left(signed(A), to_integer(unsigned(B(4 downto 0)))));
      when x"6"   => result <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(4 downto 0)))));
      when x"7"   => result <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B(4 downto 0)))));
      when x"8"   => result <= x"00000001" when (signed(A) < signed(B))      else x"00000000";
      when x"9"   => result <= x"00000001" when (unsigned(A) < unsigned(B))  else x"00000000";
      when x"A"   => result <= x"00000001" when (signed(A) >= signed(b))     else x"00000000";
      when x"B"   => result <= x"00000001" when (unsigned(A) >= unsigned(b)) else x"00000000";
      when x"C"   => result <= x"00000001" when (unsigned(A) = unsigned(b))  else x"00000000";
      when x"D"   => result <= x"00000001" when (unsigned(A) /= unsigned(b)) else x"00000000";
      when others => result <= x"00000000";
    end case;
  end process;

end architecture rtl;
