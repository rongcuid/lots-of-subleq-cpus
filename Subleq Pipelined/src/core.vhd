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
    core_mmu_do_d : in std_logic_vector(63 downto 0)
    );
end entity CPUCore;    

architecture simple_pipeline of CPUCore is
  subtype opcode_t is std_logic_vector(6 downto 0);
  subtype int64_t is signed(63 downto 0);
  subtype func3_t is std_logic_vector(2 downto 0);
  subtype func7_t is std_logic_vector(6 downto 0);
  subtype addr_t is signed(31 downto 0);
  subtype rf_addr_t is std_logic_vector(4 downto 0);
  subtype data_t is std_logic_vector(63 downto 0);
  subtype instr_t is std_logic_vector(31 downto 0);
  -- IF stage signals
  signal IF_PC : addr_t;
  signal IF_Instr : instr_t;
  signal mmu_addr_i_s32 : signed(31 downto 3);
  signal IF_nextPC : signed(31 downto 0);
  signal IF_Valid : std_logic;
  -- ID stage signals
  signal ID_PC : addr_t;
  signal stall : std_logic;
  signal ID_highword : std_logic;
  signal ID_XMXB1, ID_XMXB2 : std_logic;
  signal ID_XMMEM1, ID_XMMEM2 : std_logic;
  signal ID_Valid : std_logic;
  signal ID_RType, ID_IType, ID_SType, ID_UType : std_logic;
  signal ID_Instr : instr_t;
  alias ID_opcode : opcode_t is ID_Instr(6 downto 0);
  alias ID_rs1 : rf_addr_t is ID_Instr(19 downto 15);
  alias ID_rs2 : rf_addr_t is ID_Instr(24 downto 20);
  alias ID_rs1_d : data_t is core_rf_rs_d;
  alias ID_rs2_d : data_t is core_rf_rt_d;
  alias ID_wb_d : data_t is core_rf_wb_d;
  alias ID_rd : rf_addr_t is ID_Instr(11 downto 7);
  alias ID_func3 : func3_t is ID_Instr(14 downto 12);
  alias ID_func7 : func7_t is ID_Instr(31 downto 25);
  --signal ID_RegWrite, ID_MemRead, ID_MemWrite : std_logic;
  -- XB stage signals
  signal XB_PC : addr_t;
  signal XB_RType, XB_IType, XB_SType, XB_UType : std_logic;
  ---- Note that add and negate can make subtract
  ---- ls3 = Left Shift 3 bits
  signal XB_aluout, XB_forwrs2 : int64_t;
  signal XB_opadd, XB_opneg, XB_opls3, XB_opbranch : std_logic;
  signal XB_op2rs2, XB_op2imm : std_logic;
  signal XB_Branch : std_logic;
  signal XB_Imm : signed(31 downto 0);
  signal XB_rs1, XB_rs2, XB_rd : rf_addr_t;
  signal XB_rs1_d, XB_rs2_d : int64_t;
  signal XB_RegWrite, XB_MemRead, XB_MemWrite : std_logic;
  signal XB_FORW1_MEM_XB, XB_FORW1_WB_XB : std_logic;
  signal XB_FORW2_MEM_XB, XB_FORW2_WB_XB : std_logic;
  -- MEM stage signals
  signal MEM_RType, MEM_IType, MEM_SType, MEM_UType : std_logic;
  signal MEM_MemRead, MEM_MemWrite, MEM_RegWrite : std_logic;
  signal MEM_rs1, MEM_rs2, MEM_rd : rf_addr_t;
  signal MEM_aluresult, MEM_rs2_d : int64_t;
  -- WB stage signals
  signal WB_RegWrite : std_logic;
  signal WB_rd : rf_addr_t;
  signal WB_data : int64_t;

  -- Constants
  ---- Opcode types
  ------ This means "S-type Custom"
  constant OP_SC : opcode_t := "0001000";
  constant OP_LOAD : opcode_t := "0000011";
  constant OP_STORE : opcode_t := "0100011";
  constant FUNC3_SUBLEQ : func3_t := "000";
  constant FUNC3_LD : func3_t := "011";
  constant FUNC3_SD : func3_t := "011";
  constant ZERO64 : int64_t := (others => '0');
begin
  core_mmu_en_i <= '1';
  core_mmu_we_i <= '0';
  -- Signed/Unsigned signals for convenience
  core_mmu_addr_i <= std_logic_vector(mmu_addr_i_s32);

  -- Check source/destination matches
  ID_XMXB1 <= '1' when
              XB_RegWrite = '1' and
              ID_rs1 = XB_rd and
              ID_rs1 /= "00000" and
              (ID_RType = '1' or ID_Itype = '1' or ID_SType = '1')
              else '0';
  ID_XMXB2 <= '1' when
              XB_RegWrite = '1'and
              ID_rs2 = XB_rd and
              ID_rs2 /= "00000" and (ID_RType = '1' or ID_SType = '1')
              else '0';
  ID_XMMEM1 <= '1' when
               XB_RegWrite = '1' and
               ID_rs1 = MEM_rd and
               ID_rs1 /= "00000" and
               (MEM_RType = '1' or MEM_Itype = '1')
               else '0';
  ID_XMMEM2 <= '1' when
               XB_RegWrite = '1' and
               ID_rs2 = MEM_rd and
               ID_rs2 /= "00000" and
               (MEM_RType = '1' or MEM_SType = '1')
               else '0';
  -- The stall signal.
  -- Stall is needed when source register is dependant on an immediate
  -- senior LW.
  stall <= '1' when (ID_XMXB1 = '1' or ID_XMXB2 = '1')
           and XB_MemRead = '1' and XB_RegWrite = '1'
           else '0';

  -- ID Stage Combinational
  ---- No R type here
  ID_RType <= '0';
  ---- Loads are itype, so is subleq
  ID_IType <= '1' when
              ID_opcode = OP_LOAD
              else '0';
  ID_SType <= '1' when (ID_opcode = OP_STORE or ID_opcode = OP_SC) else '0';
  ID_UType <= '0';

  -- IF stage combinational
  core_mmu_ben_i <= "00000000";
  if_comb : process (IF_PC, core_mmu_do_i, IF_Instr)
  begin
    IF_Instr <= (others=>'-');
    core_rf_rs_a <= (others=>'-');
    core_rf_rt_a <= (others=>'-');
    if (IF_PC(2) = '0') then
      IF_Instr <= core_mmu_do_i(31 downto 0);
    else
      IF_Instr <= core_mmu_do_i(63 downto 32);
    end if;
    core_rf_rs_a <= IF_Instr(19 downto 15);
    core_rf_rt_a <= IF_Instr(24 downto 20);
  end process if_comb;
  
  -- Branch overrides stall, or there will be deadlock
  update_pc : process (stall, XB_Branch, IF_PC, XB_Imm)
  begin
    if (stall = '0' or XB_Branch = '1') then
      if (XB_Branch = '0') then
        -- PC increment by 4 when not branching
        IF_nextPC <= IF_PC + to_signed(4, 32);
      else
        -- PC increment by signed extended branch offset. Aligned to 4-bytes
        IF_nextPC <= XB_PC + to_signed(4, 32) + shift_left(resize(XB_Imm(11 downto 0), 32), 2);
      end if;
    else
      IF_nextPC <= IF_PC;
    end if;
  end process;
  
  mmu_addr_i_s32(31 downto 3) <= IF_nextPC(31 downto 3);

  -- XB stage combinational
  -- Forwarding
  xb_comb : process
    (
      XB_rs1_d,
      XB_FORW1_MEM_XB, MEM_aluresult, XB_FORW1_WB_XB, WB_data,
      XB_rs2_d, 
      XB_FORW2_MEM_XB, XB_FORW2_WB_XB, 
      XB_forwrs2, XB_op2rs2, XB_op2imm, XB_IType, XB_SType, XB_Imm,
      XB_opls3, XB_opneg, XB_opadd, XB_opbranch, XB_aluout,
      XB_MemRead, XB_MemWrite
      )
    variable XB_forwrs1 : int64_t;
    variable XB_op1, XB_op2 : int64_t;
  begin
    XB_forwrs1 := XB_rs1_d;
    if (XB_FORW1_MEM_XB = '1') then
      -- Forward from Mem stage
      XB_forwrs1 := MEM_aluresult;
    elsif (XB_FORW1_WB_XB = '1') then
      -- Forward from WB stage
      if (MEM_MemRead = '1')then
        XB_forwrs1 := signed(core_mmu_do_d);
      else
        XB_forwrs1 := MEM_aluresult;
      end if;
    end if;
    XB_forwrs2 <= XB_rs2_d;
    if (XB_FORW2_MEM_XB = '1') then
      -- Forward from Mem stage
      if (MEM_MemRead = '1')then
        XB_forwrs2 <= signed(core_mmu_do_d);
      else
        XB_forwrs2 <= MEM_aluresult;
      end if;
    elsif (XB_FORW2_WB_XB = '1') then
      -- Forward from WB stage
      XB_forwrs2 <= WB_data;
    end if;
    
    XB_op1 := XB_forwrs1;
    XB_op2 := (others => '-');
    XB_op2_mux : if (XB_op2rs2 = '1') then
      XB_op2 := XB_forwrs2;
    elsif (XB_op2imm = '1') then
      if (XB_IType = '1' or XB_SType = '1') then
        -- Sign extend
        XB_op2 := resize(XB_Imm(11 downto 0), 64);
      end if;
    end if XB_op2_mux;
    ---- Left shift op2 when needed, such as in LD and SD
    if (XB_opls3 = '1') then
      XB_op2 := shift_left(XB_op2, 3);
    end if;
    ---- Negate op2 when needed, such as in SUBLEQ
    if (XB_opneg = '1') then
      XB_op2 := -XB_op2;
    end if;
    ---- Compute
    XB_aluout <= (others => '-');
    if XB_opadd = '1' then
      XB_aluout <= XB_op1 + XB_op2; 
    end if;
    ---- Branch
    XB_Branch <= '0';
    if XB_opbranch = '1' then
      -- There is only one branch condition: Less than or Equal to 0
      if XB_aluout <= ZERO64 then
        XB_Branch <= '1';
      end if;
    end if;

    ---- Memory
    core_mmu_en_d <= '0';
    core_mmu_we_d <= '0';
    core_mmu_ben_d <= "00000000";
    core_mmu_di_d <= (others => '-');
    if (XB_MemRead = '1' or XB_MemWrite = '1') then
      core_mmu_en_d <= '1';
      -- No memory protection!
      core_mmu_addr_d <= std_logic_vector(XB_aluout(31 downto 3));
      if (XB_MemWrite = '1') then
        core_mmu_we_d <= '1';
      end if;
    end if;
    if (XB_MemWrite = '1') then
      core_mmu_di_d <= std_logic_vector(XB_rs2_d);
    end if;      
  end process xb_comb;

  -- MEM stage combinational
  mem_comb : process (MEM_RegWrite, MEM_rd,
                      MEM_MemRead, core_mmu_do_d, MEM_aluresult)
  begin
    -- Note that WB signals are shadow registers
    core_rf_wb_we <= MEM_RegWrite;
    core_rf_wb_a <= MEM_rd;
    core_rf_wb_d <= (others=>'-');
    if (MEM_MemRead = '1') then
      core_rf_wb_d <= core_mmu_do_d;
    else
      core_rf_wb_d <= std_logic_vector(MEM_aluresult);
    end if;
  end process mem_comb;
  
  -- PC_ben : process (PC)
  -- begin
  --   core_mmu_ben_i <= (others => 'X');
  --   if (PC(2 downto 0) = "000") then
  --     core_mmu_ben_i <= "11110000";
  --   elsif (PC(2 downto 0) = "100") then
  --     core_mmu_ben_i <= "00001111";
  --   end if;
  -- end process;
  -- THE CPU CORE IS HERE!!!!!!
  core : process (clk, resetb)
  --variable IF_Instr : instr_t;
  --variable XB_Branch : std_logic;
  --variable inc_pc : addr_t;
  begin
    main_clock : if (resetb = '0') then
      -- IF reset
      IF_PC <= X"FFFFFFFC";
      IF_Valid <= '0';
      --mmu_addr_i_s32 <= (others => '0');
      -- ID reset
      ID_Valid <= '0';
      -- XB reset
      XB_MemRead <= '0';
      XB_MemWrite <= '0';
      XB_RegWrite <= '0';
      XB_opbranch <= '0';
      -- MEM reset
      MEM_MemRead <= '0';
      MEM_MemWrite <= '0';
      MEM_RegWrite <= '0';
      -- WB reset
      WB_RegWrite <= '0';
    elsif (clk'event and clk = '1') then
      ------------------------------------- WB stage
      ------------------------------------- MEM stage
      -- Note that WB signals are shadow registers
      WB_RegWrite <= MEM_RegWrite;
      WB_rd <= MEM_rd;
      if (MEM_MemRead = '1') then
        WB_data <= signed(core_mmu_do_d);
      else
        WB_data <= MEM_aluresult;
      end if;
      ------------------------------------- XB stage
      ---- Note that the mem control signals are shadow registers
      MEM_MemRead <= XB_MemRead;
      MEM_MemWrite <= XB_MemWrite;
      MEM_RegWrite <= XB_RegWrite;

      MEM_Rs1 <= XB_Rs1;
      MEM_Rs2 <= XB_Rs2;
      MEM_Rd <= XB_Rd;
      MEM_RType <= XB_RType;
      MEM_ITYPE <= XB_IType;
      MEM_SType <= XB_SType;
      MEM_UType <= XB_UType;
      MEM_rs2_d <= XB_forwrs2;

      MEM_aluresult <= XB_aluout;    

      ------------------------------------- IF stage
      ---- Update PC
      IF_Valid <= '1';
      ID_highword <= IF_PC(2);
      if (stall = '0' or XB_Branch = '1') then
        if (XB_Branch = '0') then
          ID_valid <= IF_Valid;
        --inc_pc := to_signed(4, 32);
        else
          ID_valid <= '0';
        --inc_pc := shift_left(resize(XB_Imm(19 downto 8), 32), 2);
        end if;
      end if;
      IF_PC <= IF_nextPC;
      ID_PC <= IF_PC;
      ID_Instr <= IF_Instr;
      ------------------------------------- ID stage
      XB_RType <= ID_RType;
      XB_IType <= ID_IType;
      XB_SType <= ID_SType;
      XB_UType <= ID_UType;
      XB_PC <= ID_PC;
      immediate_field : if (ID_IType = '1') then
        XB_Imm(11 downto 0) <= signed(ID_Instr(31 downto 20));
      elsif (ID_SType = '1') then
        XB_Imm(11 downto 5) <= signed(ID_Instr(31 downto 25));
        XB_Imm(4 downto 0) <= signed(ID_Instr(11 downto 7));
      elsif (ID_UType = '1') then
        XB_Imm(31 downto 12) <= signed(ID_Instr(31 downto 12));
      end if immediate_field;
      -- Defaults
      XB_RegWrite <= '0';
      XB_MemRead <= '0';
      XB_MemWrite <='0';
      XB_opbranch <= '0';
      XB_opls3 <= '0';
      XB_op2rs2 <= '0';
      XB_op2imm <= '0';
      XB_opneg <= '0';
      -- Only continue if instruction is valid
      ID_is_valid : if (ID_Valid = '1') then
        side_effect_signals : if (ID_IType = '1') then
          case ID_opcode is
            when OP_LOAD =>
              if (ID_func3 = FUNC3_LD) then
                -- Immediate value left shift 3 bits, add to register value
                XB_rs1 <= ID_rs1;
                XB_rs1_d <= signed(ID_rs1_d);
                XB_rd <= ID_rd;
                XB_opls3 <= '1';
                XB_op2imm <= '1';
                XB_opadd <= '1';
                XB_MemRead <= '1';
                XB_RegWrite <= '1';
              else -- No illegal instructions here
              end if;
            when others => NULL; -- No illegal instruction here
          end case;
        elsif (ID_SType = '1') then
          case ID_opcode is
            when OP_SC =>
              if (ID_func3 = FUNC3_SUBLEQ) then
                -- There is only the SubLEq instruction
                XB_RegWrite <= '1';
                XB_rs1 <= ID_rs1;
                XB_rs1_d <= signed(ID_rs1_d);
                XB_rs2 <= ID_rs2;
                XB_rs2_d <= signed(ID_rs2_d);
                XB_rd <= ID_rs1;
                XB_op2rs2 <= '1'; XB_op2imm <= '0';
                XB_opadd <= '1';
                XB_opneg <= '1';
                XB_opbranch <= '1';
              else -- No illegal instruction here
              end if;
            when OP_STORE =>
              if (ID_func3 = FUNC3_SD) then
                -- Immediate value left shift 3 bits, add to register value
                XB_rs1 <= ID_rs1;
                XB_rs1_d <= signed(ID_rs1_d);
                XB_rs2 <= ID_rs2;
                XB_rs2_d <= signed(ID_rs2_d);
                XB_opls3 <= '1';
                XB_opadd <= '1';
                XB_op2imm <= '1';
                XB_MemWrite <= '1';
              else -- No illegal instructions here              
              end if;
            when others => NULL;
          end case;
        end if side_effect_signals;
      end if ID_is_valid;
      

      ------------------------------------- Hazard Detection Unit in ID
      -- Default Value
      XB_FORW1_MEM_XB <= '0';
      XB_FORW1_WB_XB <= '0';
      hdu_rs1 : if (ID_XMXB1 = '1') then
        -- RS1 forwarding from MEM to XB.
        -- When an instr in XB needs immediate senior's help.
        -- | XB | MEM |
        -- | SUBLEQ x2, x3, C1 | SUBLEQ x3, x8, C2 |
        --              ^-----Depend-----^
        -- | LW x4, (off)x2 | SUBLEQ x2, x0, C4 |
        --               ^---Depend---^
        XB_FORW1_MEM_XB <= '1';
      elsif (ID_XMMEM1 = '1') then
        -- RS1 forwarding from WB to XB
        XB_FORW1_WB_XB <= '1';
      end if hdu_rs1;
      XB_FORW2_MEM_XB <= '0';
      XB_FORW2_WB_XB <= '0';
      hdu_rs2 : if (ID_XMXB2 = '1') then
        -- RS2 forwarding from MEM to XB
        XB_FORW2_MEM_XB <= '1';
      elsif (ID_XMMEM2 = '1')then
        XB_FORW2_WB_XB <= '1';
      end if hdu_rs2;
    end if main_clock;

  end process core;

end architecture simple_pipeline;
