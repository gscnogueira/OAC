library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
  generic(WORD_SIZE : natural := 32);
  port(
    clk   : in  std_logic;
    rst   : in  std_logic;
    d_in  : in  std_logic_vector(WORD_SIZE-1 downto 0);
    d_out : out std_logic_vector(WORD_SIZE-1 downto 0)
  );
end pc;

architecture rtl of pc is
  signal pc_value : std_logic_vector(WORD_SIZE-1 downto 0) := X"00000000";
begin
  d_out <= pc_value; -- talvez dê merda, fique atento!!
  process(clk)
  begin
    if(rst = '1') then 
      pc_value <= X"00000000";
    elsif (rising_edge(clk)) then
        pc_value <= d_in;
    end if;

  end process;
end rtl;
