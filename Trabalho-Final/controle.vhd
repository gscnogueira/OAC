library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity controle is
  port(
    opcode     : in  std_logic_vector(6 downto 0);
    alu_op     : out std_logic_vector(1 downto 0);
    branch     : out std_logic;
    mem_read   : out std_logic;
    mem_to_reg : out std_logic;
    mem_write  : out std_logic;
    alu_src    : out std_logic;
    reg_write  : out std_logic;
    lui        : out std_logic;
    auipc      : out std_logic;
    jal        : out std_logic;
    jalr       : out std_logic
    );
end controle;


architecture rtl of controle is
begin
  process(opcode)
  begin
    case opcode is
      when iRType =>
        alu_op     <= "01";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '0';
        reg_write  <= '1';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '0';
        jalr       <= '0';

      when iIType =>
        alu_op     <= "01";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '1';
        reg_write  <= '1';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '0';
        jalr       <= '0';

      when iBType =>
        alu_op     <= "10";
        branch     <= '1';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '0';
        reg_write  <= '0';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '0';
        jalr       <= '0';

      when iILType =>
        alu_op     <= "00";
        branch     <= '0';
        mem_read   <= '1';
        mem_to_reg <= '1';
        mem_write  <= '0';
        alu_src    <= '1';
        reg_write  <= '1';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '0';
        jalr       <= '0';

      when iSType =>
        alu_op     <= "00";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '1';
        alu_src    <= '1';
        reg_write  <= '0';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '0';
        jalr       <= '0';

      when iLUI =>
        alu_op     <= "00";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '0';
        reg_write  <= '1';
        lui        <= '1';
        auipc      <= '0';
        jal        <= '0';
        jalr       <= '0';

      when iAUIPC =>
        alu_op     <= "00";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '0';
        reg_write  <= '1';
        lui        <= '0';
        auipc      <= '1';
        jal        <= '0';
        jalr       <= '0';

      when iJAL =>
        alu_op     <= "00";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '0';
        reg_write  <= '1';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '1';
        jalr       <= '0';

      when iJALR =>
        alu_op     <= "00";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '1';
        reg_write  <= '1';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '1';
        jalr       <= '1';

      when others =>
        alu_op     <= "--";
        branch     <= '0';
        mem_read   <= '0';
        mem_to_reg <= '0';
        mem_write  <= '0';
        alu_src    <= '0';
        reg_write  <= '0';
        lui        <= '0';
        auipc      <= '0';
        jal        <= '0';

    end case;

  end process;
end rtl;
