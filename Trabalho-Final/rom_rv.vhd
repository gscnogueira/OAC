-- Autor: Gabriel da Silva Corvino Nogueira
-- Email: gab.nog94@gmail.com
-- Matricula: 180113330
-- Descricao: Memória ROM do RISC-V
-- Language Syntax: VHDL 1076-2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity rom_rv is
  port (
    address : in  std_logic_vector;
    dataout : out std_logic_vector
    );
end entity rom_rv;

architecture rtl of rom_rv is
  type mem_type is array (0 to (2**address'length)-1) of std_logic_vector(dataout'range);

  impure function init_ram_hex return mem_type is
    file text_file       : text open read_mode is "text";
    variable text_line   : line;
    variable rom_content : mem_type;
    variable i: integer;

  begin
    -- for i in 0 to (2**address'length)-1 loop
    --   readline(text_file, text_line);
    --   hread(text_line, rom_content(i));
    -- end loop;

    i := 0;
    while not endfile(text_file) loop
      readline(text_file, text_line);
      hread(text_line, rom_content(i));
      i := i + 1;
    end loop;

    return rom_content;
  end function;

  signal rom          : mem_type := init_ram_hex;
  signal read_address : std_logic_vector(address'range);

begin

  dataout <= rom(to_integer(unsigned(address)));

end architecture;
