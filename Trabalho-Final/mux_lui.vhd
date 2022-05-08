library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_lui_auipc is
  port (
    lui, auipc    : in  std_logic;
    imm, pc, data : in  std_logic_vector(31 downto 0);  -- imediato, pc ou data
    m_out         : out std_logic_vector(31 downto 0)
    );
end mux_lui_auipc;

architecture rtl of mux_lui_auipc is
  signal shifted_imm : std_logic_vector(31 downto 0);
begin
  process (lui, auipc, imm, pc, data)
  begin
    if(lui = '1') then
      m_out <= imm;
    elsif(auipc = '1')then
      m_out <= std_logic_vector(unsigned(imm) + unsigned(pc));
    else
      m_out <= data;
    end if;
  end process;
end rtl;
