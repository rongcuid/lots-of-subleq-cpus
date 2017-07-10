----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: RegFile
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

-- This is a register file with generic width and depth.
-- The default depth is 16, which is the numver of architectural
-- registers in the Pipelined Subleq machine.
-- This register file has internal forwarding, one write port and
-- two read ports. It is also implemented using BRAM
entity RegFile is
  generic ( WIDTH : integer := 64;
            DEPTH : integer := 16;
            DEPTH_LOG : integer := 4
            );
  port (
    clk : in std_logic;
    resetb : in std_logic;
    -- Read rs
    rs_a : in std_logic_vector(DEPTH_LOG-1 downto 0);
    rs_d : out std_logic_vector(WIDTH-1 downto 0);
    -- Read rt
    rt_a : in std_logic_vector(DEPTH_LOG-1 downto 0);
    rt_d : out std_logic_vector(WIDTH-1 downto 0);
    -- Write back
    wb_en : in std_logic;
    wb_a : in std_logic_vector(DEPTH_LOG-1 downto 0);
    wb_d : in std_logic_vector(WIDTH-1 downto 0);
    );
end entity RegFile;

architecture syn of RegFile is
  component BRAM_DP
    generic ( WIDTH : integer := 32;
              DEPTH : integer := 1024;
              DEPTH_LOG : integer := 10;
              );
    port (
      clk : in std_logic;
      awe : in std_logic;
      aen : in std_logic;
      aaddr : in std_logic_vector(DEPTH_LOG-1 downto 0);
      adi : in std_logic_vector(WIDTH-1 downto 0);
      ado : out std_logic_vector(WIDTH-1 downto 0)
      bwe : in std_logic;
      ben : in std_logic;
      baddr : in std_logic_vector(DEPTH_LOG-1 downto 0);
      bdi : in std_logic_vector(WIDTH-1 downto 0);
      bdo : out std_logic_vector(WIDTH-1 downto 0)
      );
  end component BRAM_DP;

  -- Raw signals from BRAM
  signal rs_d0, rt_d0, wb_do : std_logic_vector(WIDTH-1 downto 0);
  signal forward_rs, forward_rt : std_logic;
begin

  -- The BRAMs have two ports: Port A for reading, and Port B
  -- for mirroring data.
  RS_RAM : BRAM_DP
    generic map (WIDTH=>WIDTH,DEPTH=>DEPTH,DEPTH_LOG=>DEPTH_LOG)
    port map (
      clk => clk,
      awe => '0',
      aen => '1',
      aaddr => rs_a,
      adi => open,
      ado => rs_d0,
      bwe => wb_en,
      ben => '1',
      baddr => wb_a,
      bdi => wb_d,
      bdo => wb_data
      );
  RT_RAM : BRAM_DP
    generic map (WIDTH=>WIDTH,DEPTH=>DEPTH,DEPTH_LOG=>DEPTH_LOG)
    port map (
      clk => clk,
      awe => '0',
      aen => '1',
      aaddr => rt_a,
      adi => open,
      ado => rt_d0,
      bwe => wb_en,
      ben => '1',
      baddr => wb_a,
      bdi => wb_d,
      bdo => wb_do
      );
  -- Pipelined forwarding, so:
  -- | Input Reg | SRAM
  -- Keep a copy of wb_d and give it out if necessary
  Forward : process (clk, resetb)
    if (resetb = '0') then
      forward_rs <= '0';
      forward_rt <= '0';
    else
      -- If any reads share address with write back,
      -- writeback value will be selected
      rs_forward : if (rs_a = wb_a) then
        forward_rs <= '1';
      elsif (forward_rs = '1') then
        forward_rs <= '0';  
      end if rs_forward;
      rt_forward : if (rt_a = wb_a) then
        forward_rt <= '1';
      elsif (forward_rt = '1') then
        forward_rt <= '0';  
      end if rt_forward;
    end if;
  end process Forward;
end architecture syn;
