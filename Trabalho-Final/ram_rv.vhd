-- Autor: Gabriel da Silva Corvino Nogueira
-- Email: gab.nog94@gmail.com
-- Matricula: 180113330
-- Descricao: Memória RAM do RISC-V
-- Language Syntax: VHDL 1076-2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_rv is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector;
    datain  : in  std_logic_vector;
    dataout : out std_logic_vector
    );
end entity ram_rv;

architecture rtl of ram_rv is
  type mem_type is array (0 to (2**address'length)-1) of std_logic_vector(datain'range);
  signal ram          : mem_type;
  signal read_address : std_logic_vector(address'range) := (others => '0');
begin

  Write : process(clock)
  begin
    if we = '1' then
      ram(to_integer(unsigned(address))) <= datain;
    end if;
    read_address <= address;
  end process;

  dataout <= ram(to_integer(unsigned(read_address)));

end architecture rtl;
