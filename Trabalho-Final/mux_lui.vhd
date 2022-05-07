library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_lui is
  port (
    sel      : in  std_logic;
    in0, in1 : in  std_logic_vector(31 downto 0); -- imediato ou data
    m_out    : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of mux_lui is
    signal aux: std_logic_vector(31 downto 0);
  begin
    aux <= in0(19 downto 0) & X"000";
    m_out <= aux when (sel = '1') else in1;
end rtl;
