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
end entity RegFile;

architecture syn of RegFile is
  component BRAM_DP
    generic ( WIDTH : integer := 32;
              DEPTH : integer := 1024;
              DEPTH_LOG : integer := 10
              );
    port (
      clk : in std_logic;
      awe : in std_logic;
      aen : in std_logic;
      aaddr : in std_logic_vector(DEPTH_LOG-1 downto 0);
      adi : in std_logic_vector(WIDTH-1 downto 0);
      ado : out std_logic_vector(WIDTH-1 downto 0);
      bwe : in std_logic;
      ben : in std_logic;
      baddr : in std_logic_vector(DEPTH_LOG-1 downto 0);
      bdi : in std_logic_vector(WIDTH-1 downto 0);
      bdo : out std_logic_vector(WIDTH-1 downto 0)
      );
  end component BRAM_DP;

  -- Raw signals from BRAM
  signal rs_do, rs_d0, rs_df,
    rt_do, rt_d0, rt_df,
    wb_do : std_logic_vector(WIDTH-1 downto 0);
  signal s2_rs_a, s2_rt_a : std_logic_vector(DEPTH_LOG-1 downto 0);
  signal forward1_rs, forward1_rt : std_logic;
  signal forward2_rs, forward2_rt : std_logic;
  signal zero_rs, zero_rt : std_logic;
  constant ZERO : std_logic_vector(DEPTH_LOG-1 downto 0) := (others => '0');
begin

  -- The BRAMs have two ports: Port A for reading, and Port B
  -- for mirroring data.
  RS_RAM : BRAM_DP
    generic map (WIDTH=>WIDTH,DEPTH=>DEPTH,DEPTH_LOG=>DEPTH_LOG)
    port map (
      clk => clk,
      awe => '0',
      aen => en,
      aaddr => rs_a,
      adi => (others => '-'),
      ado => rs_do,
      bwe => wb_we,
      ben => en,
      baddr => wb_a,
      bdi => wb_d,
      bdo => wb_do
      );
  RT_RAM : BRAM_DP
    generic map (WIDTH=>WIDTH,DEPTH=>DEPTH,DEPTH_LOG=>DEPTH_LOG)
    port map (
      clk => clk,
      awe => '0',
      aen => en,
      aaddr => rt_a,
      adi => (others => '-'),
      ado => rt_do,
      bwe => wb_we,
      ben => en,
      baddr => wb_a,
      bdi => wb_d,
      bdo => open
      );
  -- Pipelined forwarding, so:
  -- | Input Reg | SRAM
  -- Keep a copy of wb_d and give it out if necessary
  -- Pipelined zero:
  -- If $0 is requested, then 0 will be read on the next clock
  Forward_Zero : process (clk, resetb)
    begin
    if (resetb = '0') then
      forward1_rs <= '0';
      forward1_rt <= '0';
      zero_rs <= '0';
      zero_rt <= '0';
    elsif (clk'event and clk = '1') then
      -- Save the previous addresses
      s2_rs_a <= rs_a;
      s2_rt_a <= rt_a;
      -- If any reads share address with write back,
      -- writeback value will be selected
      rs_forward : if (wb_we = '1' and rs_a = wb_a) then
        forward1_rs <= '1';
      elsif (forward1_rs = '1') then
        forward1_rs <= '0';  
      end if rs_forward;
      rt_forward : if (wb_we = '1' and rt_a = wb_a) then
        forward1_rt <= '1';
      elsif (forward1_rt = '1') then
        forward1_rt <= '0';  
      end if rt_forward;
      -- Return 0 for $0
      rs_zero : if (rs_a = ZERO) then
        zero_rs <= '1';
      elsif (zero_rs = '1') then
        zero_rs <= '0';
      end if rs_zero;
      rt_zero : if (rt_a = ZERO) then
        zero_rt <= '1';
      elsif (zero_rt = '1') then
        zero_rt <= '0';
      end if rt_zero;
    end if;
  end process Forward_Zero;

  -- Muxes to choose from keep register/memory ports
  rs_df <= wb_do when forward1_rs = '1' else rs_do;
  rt_df <= wb_do when forward1_rt = '1' else rt_do;
  rs_d0 <= wb_do when s2_rs_a = wb_a else rs_do;
  rt_d0 <= wb_do when s2_rt_a = wb_a else rt_do;
  -- Note that $0 always read 0
  rs_d <= (others => '0') when zero_rs = '1' else rs_d0;
  rt_d <= (others => '0') when zero_rt = '1' else rt_d0;
end architecture syn;
