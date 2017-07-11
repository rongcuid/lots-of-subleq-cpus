----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: MMU
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

-- This is a 32-bit address, 64-bit data, byte addressable MMU.
-- Multiple devices can be mapped onto the memory. Currently the
-- memory map is as following:
--
-- - 0x00000000 - 0x0FFFFFFF, Main Memory. Maximum size: 256MiB
-- - 0x7F000000 - 0x7FFFFFFF, I/O devices.
-- -
-- -
--
-- Currently, RWXD bits are NOT SUPPORTED (at least, not in this
-- version of the CPU)
--
-- This MMU is dual-port. Port I is for Instruction memory, and
-- Port D is for Data memory. Suffixes i and d are used to distinguish
-- signals.
entity MMU is
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
    do_i : out std_logic_vector(63 downto 0)
    -- Data Memory
    we_d : in std_logic;
    en_d : in std_logic;
    addr_d : in std_logic_vector(31 downto 3);
    ben_d : in std_logic_vector(7 downto 0);
    di_d : in std_logic_vector(63 downto 0);
    do_d : out std_logic_vector(63 downto 0)
    );
end MMU;

architecture behavior of MMU is
  -- Memory Bank Control Signals
  signal wei_ram, wed_ram, eni_ram, end_ram : std_logic(7 downto 0);
  signal dii, did, doi, dod : array (0 to 7) of std_logic_vector(7 downto 0);
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

  -- -- Memory Bank control signals
  -- signal we_ram0, en_ram0 : std_logic;
  -- signal we_ram1, en_ram1 : std_logic;
  -- signal we_ram2, en_ram2 : std_logic;
  -- signal we_ram3, en_ram3 : std_logic;
  -- signal we_ram4, en_ram4 : std_logic;
  -- signal we_ram5, en_ram5 : std_logic;
  -- signal we_ram6, en_ram6 : std_logic;
  -- signal we_ram7, en_ram7 : std_logic;
  -- -- Memory Bank Data In
  -- signal di_ram0, di_ram1, di_ram2, di_ram3, di_ram4, di_ram5, di_ram6, di_ram7 : std_logic_vector(7 downto 0);
  -- -- Memory Bank Data Out
  -- signal do_ram0, do_ram1, do_ram2, do_ram3, do_ram4, do_ram5, do_ram6, do_ram7 : std_logic_vector(7 downto 0);
  -- signal do_ram : std_logic_vector(63 downto 0);

  -- component BRAM_SP
  --   generic ( WIDTH : integer := 32;
  --             DEPTH : integer := 1024;
  --             DEPTH_LOG : integer := 10
  --             );
  --   port (
  --     clk : in std_logic;
  --     we : in std_logic;
  --     en : in std_logic;
  --     addr : in std_logic_vector(DEPTH_LOG-1 downto 0);
  --     di : in std_logic_vector(WIDTH-1 downto 0);
  --     do : out std_logic_vector(WIDTH-1 downto 0)
  --     );
  -- end component BRAM_SP;

begin
  -- The main memory bank.
  RAM0 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(0),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(0),ado=>doi(0),
      bwe=>wed_ram(0),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(0),bdo=>dod(0)
      );
  RAM1 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(1),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(1),ado=>doi(1),
      bwe=>wed_ram(1),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(1),bdo=>dod(1)
      );
  RAM2 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(2),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(2),ado=>doi(2),
      bwe=>wed_ram(2),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(2),bdo=>dod(2)
      );
  RAM3 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(3),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(3),ado=>doi(3),
      bwe=>wed_ram(3),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(3),bdo=>dod(3)
      );
  RAM4 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(4),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(4),ado=>doi(4),
      bwe=>wed_ram(4),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(4),bdo=>dod(4)
      );
  RAM5 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(5),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(5),ado=>doi(5),
      bwe=>wed_ram(5),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(5),bdo=>dod(5)
      );
  RAM6 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(6),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(6),ado=>doi(6),
      bwe=>wed_ram(6),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(6),bdo=>dod(6)
      );
  RAM7 : BRAM_DP
    generic map (WIDTH => 8, DEPTH => DEPTH_BANK, DEPTH_LOG => DEPTH_LOG)
    port map (
      clk=>clk,
      awe=>wei_ram(7),aen=>eni_ram(i),
      aaddr=>addr_i(DEPTH_LOG+3-1 downto 3),adi=>dii(7),ado=>doi(7),
      bwe=>wed_ram(7),ben=>end_ram(i),
      baddr=>addr_d(DEPTH_LOG+3-1 downto 3),bdi=>did(7),bdo=>dod(7)
      );
  -- RAM0 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram0, en => en_ram0,
  --     addr => addr(12 downto 3),
  --     di => di_ram0, do => do_ram0
  --     );
  -- RAM1 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram1, en => en_ram1,
  --     addr => addr(12 downto 3),
  --     di => di_ram1, do => do_ram1
  --     );
  -- RAM2 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram2, en => en_ram2,
  --     addr => addr(12 downto 3),
  --     di => di_ram2, do => do_ram2
  --     );
  -- RAM3 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram3, en => en_ram3,
  --     addr => addr(12 downto 3),
  --     di => di_ram3, do => do_ram3
  --     );
  -- RAM4 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram4, en => en_ram4,
  --     addr => addr(12 downto 3),
  --     di => di_ram4, do => do_ram4
  --     );
  -- RAM5 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram5, en => en_ram5,
  --     addr => addr(12 downto 3),
  --     di => di_ram5, do => do_ram5
  --     );
  -- RAM6 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram6, en => en_ram6,
  --     addr => addr(12 downto 3),
  --     di => di_ram6, do => do_ram6
  --     );
  -- RAM7 : BRAM_SP
  --   generic map (WIDTH => 8, DEPTH => DEPTH_BANK)
  --   port map(
  --     clk => clk,
  --     we => we_ram7, en => en_ram7,
  --     addr => addr(12 downto 3),
  --     di => di_ram7, do => do_ram7
  --     );

  -- -- RAM input is interleaved
  -- di_ram0 <= di(7 downto 0);
  -- di_ram1 <= di(15 downto 8);
  -- di_ram2 <= di(23 downto 16);
  -- di_ram3 <= di(31 downto 24);
  -- di_ram4 <= di(39 downto 32);
  -- di_ram5 <= di(47 downto 40);
  -- di_ram6 <= di(55 downto 48);
  -- di_ram7 <= di(63 downto 56);

  -- do_ram <= do_ram7 & do_ram6 & do_ram5 & do_ram4 &
  --           do_ram3 & do_ram2 & do_ram1 & do_ram0;

  -- -- The main mux which selects devices
  -- selector : process (we, en, addr,
  --                     be7n, be6n, be5n, be4n,
  --                     be3n, be2n, be1n, be0n,
  --                     do_ram)
  -- begin
  --   -- Write and Enable are all inactive by default
  --   we_ram0 <= '0'; en_ram0 <= '0'; we_ram1 <= '0'; en_ram1 <= '0';
  --   we_ram2 <= '0'; en_ram2 <= '0'; we_ram3 <= '0'; en_ram3 <= '0';
  --   we_ram4 <= '0'; en_ram4 <= '0'; we_ram5 <= '0'; en_ram5 <= '0';
  --   we_ram6 <= '0'; en_ram6 <= '0'; we_ram7 <= '0'; en_ram7 <= '0';
  --   -- By default, MMU generates invalid data
  --   do <= (others => '-');
  --   if (addr(31) = '0') then
  --     -- If address is 0x0XXXXXXX, then selet Main Memory
  --     do <= do_ram;
  --     -- The following section turns on memory bank as needed
  --     -- The memory is in low-level interleaving mode so that
  --     -- we can access 8 bytes in parallel
  --     if (be0n = '0') then
  --       we_ram0 <= we;
  --       en_ram0 <= en;
  --     end if;
  --     if (be1n = '0') then
  --       we_ram1 <= we;
  --       en_ram1 <= en;
  --     end if;
  --     if (be2n = '0') then
  --       we_ram2 <= we;
  --       en_ram2 <= en;
  --     end if;
  --     if (be3n = '0') then
  --       we_ram3 <= we;
  --       en_ram3 <= en;
  --     end if;
  --     if (be4n = '0') then
  --       we_ram4 <= we;
  --       en_ram4 <= en;
  --     end if;
  --     if (be5n = '0') then
  --       we_ram5 <= we;
  --       en_ram5 <= en;
  --     end if;
  --     if (be6n = '0') then
  --       we_ram6 <= we;
  --       en_ram6 <= en;
  --     end if;
  --     if (be7n = '0') then
  --       we_ram7 <= we;
  --       en_ram7 <= en;
  --     end if;

  --   else
  --   -- If not main memory. This is not implemented in this project
  --   end if;
  -- end process selector;

end behavior;
