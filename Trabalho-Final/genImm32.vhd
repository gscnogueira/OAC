-- Autor     : Gabriel da Silva Corvino Nogueira
-- Email     : gab.nog94@gmail.com
-- Matricula : 180113330
-- Descrição : Gerador de Imediatos de 32 bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genImm32 is

  port (
    instr : in  std_logic_vector(31 downto 0);
    imm32 : out signed (31 downto 0));

end genImm32;

architecture rtl of genImm32 is
  signal opCode : std_logic_vector(6 downto 0);

begin

  opCode <= instr(6 downto 0);

  with opCode select imm32 <=
    -- R-Type:
    resize("0", imm32'length)
    when "0110011",
    -- I-Type:
    resize(signed(instr(31 downto 20)), imm32'length)
    when "0000011" | "0010011" | "1100111",
    -- S-Type:
    resize(signed(instr(31 downto 25) & instr(11 downto 7)), imm32'length)
    when "0100011",
    -- SB-Type:
    resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), imm32'length)
    when "1100011",
    -- U-Type:
    resize(signed(instr(31 downto 12) & x"000"), imm32'length)
    when "0110111" |"0010111" ,
    -- UJ-Type:
    resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), imm32'length)
    when "1101111",
    -- Unknown:
    resize("0", imm32'length) when others;



end architecture rtl;



