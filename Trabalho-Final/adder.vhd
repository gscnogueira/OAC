library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic (WSIZE : natural := 32);
    port (
      in0, in1 : in  std_logic_vector (WSIZE-1 downto 0);
      m_out    : out std_logic_vector (WSIZE-1 downto 0)
    );
end adder;

architecture rtl of adder is
begin
        m_out <= std_logic_vector(signed(in0) + signed(in1));
end rtl;