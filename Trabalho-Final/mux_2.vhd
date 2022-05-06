component mux_2 is
    generic (WSIZE : natural := 32);
    port (
      sel      : in  std_logic;
      in0, in1 : in  std_logic_vector(WSIZE-1 downto 0);
      m_out    : out std_logic_vector(WSIZE-1 downto 0)
    );
end component;

architecture rtl of mux_2 is
begin
    m_out <= in0 when (sel = '0') else in1;
end rtl;