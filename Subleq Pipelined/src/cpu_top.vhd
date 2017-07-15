----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: cpu_top
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

-- This module assembles the CPU core, MMU, register file,
-- plus a very simple bootloader
entity cpu_top is
  port(
    clk : in std_logic;
    resetb : in std_logic;
    -- Interface with boot ROM
    cpu_rom_addr : out unsigned(31 downto 0);
    cpu_rom_data : in std_logic_vector(31 downto 0);
    -- Interface with board
    boot_done : out std_logic
    );
end entity cpu_top;

architecture syn of cpu_top is
  component CPUCore
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
  end component CPUCore;    
  component MMU
    generic ( DEPTH_BANK : integer := 1024;
              DEPTH_LOG : integer := 10
              );
    port (
      clk : in std_logic;
      resetb : in std_logic;
      -- Instruction Memory
      we_i : in std_logic;
      en_i : in std_logic;
      addr_i : in std_logic_vector(31 downto 3);
      ben_i : in std_logic_vector(7 downto 0);
      di_i : in std_logic_vector(63 downto 0);
      do_i : out std_logic_vector(63 downto 0);
      -- Data Memory
      we_d : in std_logic;
      en_d : in std_logic;
      addr_d : in std_logic_vector(31 downto 3);
      ben_d : in std_logic_vector(7 downto 0);
      di_d : in std_logic_vector(63 downto 0);
      do_d : out std_logic_vector(63 downto 0)
      );
  end component MMU;
  component RegFile
    generic ( WIDTH : integer := 64;
              DEPTH : integer := 32;
              DEPTH_LOG : integer := 5
              );
    port (
      clk : in std_logic;
      resetb : in std_logic;
      en : in std_logic;
      -- Read rs
      rs_a : in std_logic_vector(DEPTH_LOG-1 downto 0);
      rs_d : out std_logic_vector(WIDTH-1 downto 0);
      -- Read rt
      rt_a : in std_logic_vector(DEPTH_LOG-1 downto 0);
      rt_d : out std_logic_vector(WIDTH-1 downto 0);
      -- Write back
      wb_we : in std_logic;
      wb_a : in std_logic_vector(DEPTH_LOG-1 downto 0);
      wb_d : in std_logic_vector(WIDTH-1 downto 0)
      );
  end component RegFile;
  signal core_resetb : std_logic;
  signal rf_en, rf_wb_we : std_logic;
  signal rf_rs_a, rf_rt_a, rf_wb_a : std_logic_vector(4 downto 0);
  signal rf_rs_d, rf_rt_d, rf_wb_d : std_logic_vector(63 downto 0);
  signal core_mmu_we_i, core_mmu_en_i, core_mmu_we_d, core_mmu_en_d : std_logic;
  signal
    core_mmu_addr_i, core_mmu_addr_d,
    boot_mmu_addr_i, mmu_addr_i, mmu_addr_d : std_logic_vector(31 downto 0);
  signal core_mmu_ben_i, core_mmu_ben_d,
    boot_mmu_ben_i, mmu_ben_i, mmu_ben_d : std_logic_vector(7 downto 0);
  signal core_mmu_di_i, core_mmu_do_i,
    core_mmu_di_d, core_mmu_do_d,
    boot_mmu_di_i,
    mmu_di_i, mmu_di_d, mmu_do_i, mmu_do_d : std_logic_vector(63 downto 0);
  
  signal boot_mmu_we_i, boot_mmu_en_i : std_logic;
  signal mmu_we_i, mmu_en_i, mmu_we_d, mmu_en_d : std_logic;
  signal boot_possibly_done, boot_done_temp, boot_second_word : std_logic;
  signal boot_addr : unsigned(31 downto 0);
  signal boot_wait_one_clock : std_logic;
  constant ZERO64 : std_logic_vector(63 downto 0) := (others => '0');
begin
  core : CPUCore
    port map (
      clk=>clk, resetb=>core_resetb,
      core_rf_en=>rf_en, core_rf_rs_a=>rf_rs_a, core_rf_rs_d=>rf_rs_d,
      core_rf_rt_a=>rf_rt_a, core_rf_rt_d=>rf_rt_d,
      core_rf_wb_we=>rf_wb_we, core_rf_wb_a=>rf_wb_a, core_rf_wb_d=>rf_wb_d,
      core_mmu_we_i=>core_mmu_we_i, core_mmu_en_i=>core_mmu_en_i,
      core_mmu_addr_i=>core_mmu_addr_i(31 downto 3),
      core_mmu_ben_i=>core_mmu_ben_i,
      core_mmu_di_i=>core_mmu_di_i, core_mmu_do_i=>core_mmu_do_i,
      core_mmu_we_d=>core_mmu_we_d, core_mmu_en_d=>core_mmu_en_d,
      core_mmu_addr_d=>core_mmu_addr_d(31 downto 3),
      core_mmu_ben_d=>core_mmu_ben_d,
      core_mmu_di_d=>core_mmu_di_d, core_mmu_do_d=>core_mmu_do_d
      );
  MMU0 : MMU
    port map (
      clk=>clk, resetb=>resetb,
      we_i=>mmu_we_i, en_i=>mmu_en_i, addr_i=>mmu_addr_i(31 downto 3),
      ben_i=>mmu_ben_i, di_i=>mmu_di_i, do_i=>mmu_do_i,
      we_d=>mmu_we_d, en_d=>mmu_en_d, addr_d=>mmu_addr_d(31 downto 3),
      ben_d=>mmu_ben_d, di_d=>mmu_di_d, do_d=>mmu_do_d
      );
  RegFile0 : Regfile
    port map (
      clk=>clk, resetb=>resetb, en=>rf_en,
      rs_a=>rf_rs_a, rs_d=>rf_rs_d,
      rt_a=>rf_rt_a, rt_d=>rf_rt_d,
      wb_we=>rf_wb_we, wb_a=>rf_wb_a, wb_d=>rf_wb_d
      );

  core_mmu_do_i <= mmu_do_i;
  core_mmu_do_d <= mmu_do_d;
  mmu_addr_i <= core_mmu_addr_i when boot_done_temp = '1' else boot_mmu_addr_i;
  mmu_addr_d <= core_mmu_addr_d;
  mmu_ben_i <= core_mmu_ben_i when boot_done_temp = '1' else boot_mmu_ben_i;
  mmu_ben_d <= core_mmu_ben_d;
  mmu_di_i <= core_mmu_di_i when boot_done_temp = '1' else boot_mmu_di_i;
  mmu_di_d <= core_mmu_di_d;
  core_mmu_do_d <= mmu_do_d;
  mmu_we_i <= core_mmu_we_i when boot_done_temp = '1' else boot_mmu_we_i;
  mmu_we_d <= core_mmu_we_d;
  mmu_en_i <= core_mmu_en_i when boot_done_temp = '1' else boot_mmu_en_i;
  mmu_en_d <= core_mmu_en_d;
  boot_done <= boot_done_temp;
  cpu_rom_addr <= boot_addr;
  boot_mmu_en_i <= '0' when boot_done_temp = '1' else '1';
  boot_mmu_we_i <= '0' when boot_done_temp = '1' else '1';
  -- boot_mmu_addr_i <= std_logic_vector(boot_addr);
  boot_loader : process (clk, resetb)
  begin
    if (resetb = '0') then
      core_resetb <= '0';
      boot_done_temp <= '0';
      boot_second_word <= '0';
      boot_addr <= (others => '0');
      boot_wait_one_clock <= '0';
      boot_possibly_done <= '0';
    elsif (clk'event and clk = '1') then
      if (boot_done_temp = '0' and boot_wait_one_clock = '0') then
        if (boot_mmu_di_i = ZERO64) then
          if (boot_possibly_done = '1') then
            boot_done_temp <= '1';
            boot_wait_one_clock <= '1';
          else
            boot_possibly_done <= '1';
          end if;
        else
          boot_possibly_done <= '0';
        end if;
        boot_addr <= boot_addr + 4;
        boot_mmu_addr_i <= std_logic_vector(boot_addr);
        -- Low word, then high word
        if (boot_addr(2) = '1') then
          boot_mmu_ben_i <= "00001111";
          boot_mmu_di_i(63 downto 32) <= cpu_rom_data;
        else
          boot_mmu_ben_i <= "11110000";
          boot_mmu_di_i(31 downto 0) <= cpu_rom_data;
        end if;
      elsif (boot_wait_one_clock = '1') then
        core_resetb <= '1';
      end if;
    end if;
  end process boot_loader;
  
end architecture syn;

