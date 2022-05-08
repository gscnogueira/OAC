library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;


entity rv_uniciclo is
  port
    (
      clk : in std_logic;
      rst : in std_logic
      );
end entity;

architecture rtl of rv_uniciclo is

  signal data : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

  signal opcode : std_logic_vector(6 downto 0) := (others => '0');
  signal funct3 : std_logic_vector(2 downto 0) := (others => '0');
  signal funct7 : std_logic;

  -- PC
  signal pc_inc   : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal pc_salto : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal pc_in    : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal pc_out   : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

  -- Controle
  signal alu_op     : std_logic_vector(1 downto 0) := (others => '0');
  signal branch     : std_logic                    := '0';
  signal mem_read   : std_logic                    := '0';
  signal mem_to_reg : std_logic                    := '0';
  signal mem_write  : std_logic                    := '0';
  signal alu_src    : std_logic                    := '0';
  signal reg_write  : std_logic                    := '0';
  signal lui        : std_logic                    := '0';
  signal auipc      : std_logic                    := '0';
  signal jal        : std_logic                    := '0';
  signal jalr       : std_logic                    := '0';

  -- Imediato
  signal imm32 : signed(31 downto 0);

  -- Registradores
  signal rs1, rs2, rd : std_logic_vector(4 downto 0)           := (others => '0');
  signal ro1, ro2     : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

  -- Memoria
  signal ram_address : std_logic_vector(IMEM_ADDR-1 downto 0) := (others => '0');
  signal ram_datain  : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal ram_dataout : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal rom_address : std_logic_vector(IMEM_ADDR-1 downto 0) := (others => '0');
  signal rom_dataout : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');


  -- ULA
  signal entradaB_ula : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal saida_ula    : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal zero         : std_logic;
  signal ula_opcode   : std_logic_vector(3 downto 0);

  -- Branch
  signal escolhe_pc : std_logic;

  -- Mux outputs

  signal mux0_out     : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal mux3_out     : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal mux4_out     : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');
  signal salto_offset : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

begin

  ipc : pc port map(clk, rst, pc_in, pc_out);

  adder1 : adder port map(pc_out, x"00000004", pc_inc);

  adder2 : adder port map(pc_out, std_logic_vector(imm32), pc_salto);


  escolhe_pc <= (branch and not(zero)) or jal;

  mux0 : mux_2 port map(escolhe_pc, pc_inc, pc_salto, mux0_out);

  mux1 : mux_2 port map(jalr, mux0_out, saida_ula, pc_in);

  rom : rom_rv port map(pc_out(11 downto 2), rom_dataout);
  opcode <= rom_dataout(6 downto 0);
  rd     <= rom_dataout(11 downto 7);
  rs1    <= rom_dataout(19 downto 15);
  rs2    <= rom_dataout(24 downto 20);
  funct3 <= rom_dataout(14 downto 12);
  funct7 <= rom_dataout(30);

  gerador_Imm : genImm32 port map(rom_dataout, imm32);

  -- arrumar data
  banco_reg : XREGS port map(clk, reg_write, rst, rs1, rs2, rd, data, ro1, ro2);

  mux2 : mux_2 port map(alu_src, ro2, std_logic_vector(imm32), entradaB_ula);

  ctr_ula : controle_ula port map(alu_op, funct3, funct7, ula_opcode);

  ula : ulaRV port map(ula_opcode, ro1, entradaB_ula, saida_ula, zero);

  ram : ram_rv port map(clk, mem_write, saida_ula(11 downto 0), ro2, ram_dataout);

  mux3 : mux_2 port map(mem_to_reg, saida_ula, ram_dataout, mux3_out);

  mux4 : mux_2 port map(jal, mux3_out, pc_inc, mux4_out);

  megamux : mux_lui_auipc port map(lui, auipc, std_logic_vector(imm32), pc_out, mux4_out, data);

  control : controle port map(opcode, alu_op, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write, lui, auipc, jal, jalr);



end architecture;
