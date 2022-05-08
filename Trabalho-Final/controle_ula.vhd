library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.riscv_pkg.all;


entity controle_ula is
  port(
    alu_op : in  std_logic_vector(1 downto 0);
    funct3 : in  std_logic_vector(2 downto 0);
    funct7 : in  std_logic;
    opcode : out std_logic_vector(3 downto 0));
end entity controle_ula;

architecture rtl of controle_ula is
begin
  process(alu_op, funct3, funct7)
  begin
    case(alu_op) is
      when "00" => opcode <= ULA_ADD;
      when "01" =>
        case (funct3) is
          when (iAND3)   => opcode <= ULA_AND;
          when (iOR3)    => opcode <= ULA_OR;
          when (iXOR3)   => opcode <= ULA_XOR;
          when (iSLL3)   => opcode <= ULA_SLL;
          when (iSLTI3)  => opcode <= ULA_SLT;
          when (iSLTIU3) => opcode <= ULA_SLTU;
          when iADDSUB3 =>
            if(funct7 = iSUB7) then
              opcode <= ULA_SUB;
            else
              opcode <= ULA_ADD;
            end if;
          when (iSR3) =>
            if(funct7 = iSRA7) then
              opcode <= ULA_SRA;
            else
              opcode <= ULA_SRL;
            end if;
          when others => opcode <= ULA_ADD;
        end case;
      when "10" =>
        case (funct3) is
          when (iBEQ3)  => opcode <= ULA_SEQ;
          when (iBNE3)  => opcode <= ULA_SNE;
          when (iBLT3)  => opcode <= ULA_SLT;
          when (iBLTU3) => opcode <= ULA_SLTU;
          when (iBGE3)  => opcode <= ULA_SGE;
          when (iBGEU3) => opcode <= ULA_SGEU;
          when others   => opcode <= ULA_ADD;
        end case;
      when others => opcode <= ULA_ADD;
    end case;
  end process;

end architecture rtl;


