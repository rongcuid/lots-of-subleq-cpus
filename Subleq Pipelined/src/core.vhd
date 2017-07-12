----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: core
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- This is the CPU core with its pipeline. The pipeline is as following:
-- IF | ID | XB | MEM | WB
-- Here, branch is handled in XB (eXecute/Branch) stage. Due to the
-- restriction of SUBLEQ instruction, an early branch is not possible.
-- However, since only SUBLEQ and LW/SW are supported, we have lots of
-- slack in XB stage to handle branch.
entity CPUCore is
  port (
    clk : in std_logic;
    resetb : in std_logic;
    -- Interface with register file
    core_rf_en : out std_logic;
    core_rf_rs_a : out std_logic_vector(4 downto 0);
    core_rf_rs_d : in std_logic_vector(63 downto 0);
    core_rf_rt_a : out std_logic_vector(4 downto 0);
    core_rf_rt_d : in std_logic_vector(63 downto 0);
    core_rf_wb_we : out std_logic;
    core_rf_wb_a : out std_logic_vector(4 downto 0);
    core_rf_wb_d : out std_logic_vector(63 downto 0);
    -- Interface with MMU
    ---- Instruction Port
    core_mmu_we_i : out std_logic;
    core_mmu_en_i : out std_logic;
    core_mmu_addr_i : out std_logic_vector(31 downto 3);
    core_mmu_ben_i : out std_logic_vector(7 downto 0);
    core_mmu_di_i : out std_logic_vector(63 downto 0);
    core_mmu_do_i : in std_logic_vector(63 downto 0);
    ---- Data Port
    core_mmu_we_d : out std_logic;
    core_mmu_en_d : out std_logic;
    core_mmu_addr_d : out std_logic_vector(31 downto 3);
    core_mmu_ben_d : out std_logic_vector(7 downto 0);
    core_mmu_di_d : out std_logic_vector(63 downto 0);
    core_mmu_do_d : in std_logic_vector(63 downto 0);
    );
end entity CPUCore;    

architecture simple_pipeline of CPUCore is
  type opcode_t is std_logic_vector(6 downto 0);
  type opcode_type_t is std_logic_vector(4 downto 0);
  type func3_t is std_logic_vector(2 downto 0);
  type func7_t is std_logic_vector(7 downto 0);
  type addr_t is signed(31 downto 0);
  type rf_addr_t is std_logic_vector(4 downto 0);
  type data_t is signed(63 downto 0);
  type instr_t is std_logic_vector(31 downto 0);
  signal stall : std_logic;
  signal PC : addr_t;
  signal mmu_addr_i_s32 : signed(31 downto 0);
  -- ID stage signals
  signal ID_XMXB1, ID_XMXB2 : std_logic;
  signal ID_Valid : std_logic;
  signal ID_RType, ID_IType, ID_SType, ID_UType : std_logic;
  alias ID_instr : instr_t is core_mmu_do_i(31 downto 0);
  alias ID_op : opcode_t is core_mmu_do_i(6 downto 0);
  alias ID_rs1 : rf_addr_t is core_mmu_do_i(19 downto 15);
  alias ID_rs2 : rf_addr_t is core_mmu_do_i(24 downto 20);
  alias ID_rd : rf_addr_t is core_mmu_do_i(11 downto 7);
  alias ID_func3 : func3_t is core_mmu_do_i(14 downto 12);
  alias ID_func7 : func7_t is core_mmu_do_i(31 downto 25);
  signal ID_RegWrite, ID_MemRead, ID_MemWrite : std_logic;
  -- XB stage signals
  signal XB_RType, XB_IType, XB_SType, XB_UType : std_logic;
  signal XB_MemRead, XB_RegWrite : std_logic;
  signal XB_Imm : signed(31 downto 0);
  signal XB_rs1, XB_rs2, XB_rd : rf_addr_t;
  signal XB_rs1_d, XB_rs2_d : data_t;
  signal XB_RegWrite, XB_MemRead, XB_MemWrite : std_logic;
  signal XB_Branch : std_logic;
  -- MEM stage signals
  signal MEM_MemRead, MEM_MemWrite, MEM_RegWrite : std_logic;
  signal MEM_rd : rf_addr_t;
  signal MEM_data : data_t;
  -- WB stage signals
  signal WB_RegWrite : std_logic;
  signal WB_rd : rf_addr_t;
  signal WB_data : data_t;

  -- Constants
  ---- Opcode types
  constant OPT_STORE : opcode_type_t = "01000";
  constant OPT_LOAD : opcode_type_t = "00000";
  ------ This means "R-type Custom"
  constant OPT_RC : opcode_type_t = "00010";
  constant OP_SUBLEQ : opcode_t := "0001000";
  constant OP_LD : opcode_t := "0000011";
  constant OP_SD : opcode_t := "0100011";
begin

  -- Signed/Unsigned signals for convenience
  core_mmu_addr_i <= std_logic_vector(mmu_addr_i_s32);

  -- Check source/destination matches
  ID_XMXB1 <= '1' when
              ID_rs1 = XB_rs1 and (XB_RType = '1' or XB_Itype = '1')
              else '0';
  ID_XMXB2 <= '1' when
              ID_rs2 = XB_rs2 and (XB_RType = '1' or XB_SType = '1')
              else '0';
  -- The stall signal.
  -- Stall is needed only when source register is dependant on an immediate
  -- senior LW.
  stall <= '1' when (ID_XMXB1 = '1' or ID_XMXB2)
           and XB_MemRead = '1' and XB_RegWrite = '1'
           else '0';

  -- ID Stage Combinational
  ID_RType <= '1' when (ID_opcode(6 downto 2) = OPT_RC) else '0';
  ID_ITYPE <= '1' when (ID_opcode(6 downto 2) = OPT_LOAD) else '0';
  ID_SType <= '1' when (ID_opcode(6 downto 2) = OPT_STORE) else '0';
  ID_UType <= '0';

  
  -- THE CPU CORE IS HERE!!!!!!
  core : process (clk, resetb)
    variable inc_pc : addr_t;
  begin
    if (resetb = '0') then
      -- IF reset
      PC <= X"00000200";
      -- ID reset
      ID_Valid <= '0';
      -- XB reset
      XB_MemRead <= '0';
      XB_MemWrite <= '0';
      XB_RegWrite <= '0';
      -- MEM reset
      MEM_MemRead <= '0';
      MEM_MemWrite <= '0';
      MEM_RegWrite <= '0';
      -- WB reset
      WB_RegWrite <= '0';
    elsif (clk'event and clk = '1') then
      -- IF stage
      ---- Update PC
      update_pc : if (stall = '0' or XB_Branch = '1') then
        if (XB_Branch = '0') then
          -- PC increment by 4 when not branching
          inc_pc := 4;
        else
          -- PC increment by signed extended branch offset. Aligned to 2-bytes
          inc_pc := PC + shift_left(signed(XB_Imm(19 downto 8), 32), 1);
        end if;
      end if update_pc;
      -- ID stage
      XB_RType <= ID_RType;
      XB_IType <= ID_IType;
      XB_SType <= ID_SType;
      XB_UType <= ID_UType;
      immediate_field : if (ID_IType = '1') then
        XB_Imm(11 downto 0) <= ID_Instr(31 downto 20);
      elsif (ID_SType = '1') then
        XB_Imm(11 downto 5) <= ID_Instr(31 downto 25);
        XB_Imm(4 downto 0) <= ID_Instr(11 downto 7);
      elsif (ID_UType = '1') then
        XB_Imm(31 downto 12) <= ID_Instr(31 downto 12);
      end if immediate_field;
      -- XB stage
      -- MEM stage
      -- WB stage
    end if;
  end process core;

end architecture simple_pipeline;
