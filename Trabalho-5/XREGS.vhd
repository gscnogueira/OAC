-- Autor     : Gabriel da Silva Corvino Nogueira
-- Email     : gab.nog94@gmail.com
-- Matricula : 180113330
-- Descrição : Banco de Registradores do RISC-V

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity XREGS is
  generic (WSIZE : natural := 32);
  port (
    clk, wren, rst : in  std_logic;
    rs1, rs2, rd   : in  std_logic_vector(4 downto 0);
    data           : in  std_logic_vector(WSIZE-1 downto 0);
    ro1, ro2       : out std_logic_vector(WSIZE-1 downto 0));
end XREGS;

architecture rtl of XREGS is

  type BREGS is array (0 to 31) of std_logic_vector(31 downto 0);
  signal R_FILE : BREGS := (others => (others => '0'));

begin

  ro1       <= R_FILE(to_integer(unsigned(rs1)));
  ro2       <= R_FILE(to_integer(unsigned(rs2)));
  R_FILE(0) <= (others => '0');

  -- with rst select R_FILE <=
  --   (others => (others => '0')) when '1',
  --   R_FILE when others;

  process(clk, rst)
  begin
    if rst = '1' then
      R_FILE <= (others => (others => '0'));
    elsif wren = '1' and clk = '1' and rd/="00000" then
      R_FILE(to_integer(unsigned(rd))) <= data;
    end if;
  end process;

end architecture rtl;





