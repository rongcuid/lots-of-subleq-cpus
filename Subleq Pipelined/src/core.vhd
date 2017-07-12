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
-- IF | ID | EX | MEM/BR | WB
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
    core_mmu_we : out std_logic;
    core_mmu_en : out std_logic;
    core_mmu_addr : out std_logic_vector(31 downto 3);
    core_mmu_ben : out std_logic_vector(7 downto 0);
    core_mmu_di : out std_logic_vector(63 downto 0);
    core_mmu_do : in std_logic_vector(63 downto 0);
    );
end entity CPUCore;    

architecture simple_pipeline of CPUCore is
  signal PC : std_logic_vector(31 downto 0);
  signal mmu_addr_u32 : unsigned (31 downto 0);
begin

  core_mmu_addr <= std_logic_vector(mmu_addr_u32);

  core : process (clk, resetb)
  begin
    if (resetb = '0') then
      PC <= (others => '0');
    elsif (clk'event and clk = '1') then
    end if;
  end process core;

end architecture simple_pipeline;
