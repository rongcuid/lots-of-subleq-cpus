----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: test_mmu
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

library std;
use std.textio.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_textio.all;
use std.standard.all;

entity test_mmu_tb is
end test_mmu_tb;

architecture behavioral of test_mmu_tb is
  -- Component declarations
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

  -- Signals
  signal clk, resetb, we_i, en_i, we_d, en_d : std_logic;
  signal ben_i, ben_d : std_logic_vector(7 downto 0);
  signal addr_i, addr_d : std_logic_vector(31 downto 0);
  signal di_i, di_d, do_i, do_d : std_logic_vector(63 downto 0);
  -- Simulation control
  shared variable END_SIMULATION : boolean := false;
  -- Test procedures
  procedure reset (
    signal resetb : out std_logic;
    signal en_i, we_i, en_d, we_d : out std_logic;
    signal ben_i, ben_d : out std_logic_vector(7 downto 0)
    ) is
  begin
    wait until rising_edge(clk);
    resetb <= '0';
    en_i <= '0'; we_i <= '0';
    en_d <= '0'; we_d <= '0';
    ben_i <= (others => '1');
    ben_d <= (others => '1');
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    resetb <= '1';

  end procedure reset;
  
  procedure test_1(
    signal resetb : out std_logic;
    signal en_i, we_i, en_d, we_d : out std_logic;
    signal ben_i, ben_d : out std_logic_vector(7 downto 0);
    signal addr_i, addr_d : inout std_logic_vector(31 downto 0);
    signal di_i, di_d : inout std_logic_vector(63 downto 0)
   -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addri_tmp, addrd_tmp : integer;
    variable naddri_line, addri_line, datai_line : line;
    variable naddrd_line, addrd_line, datad_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"DEADBEEFBAADC0DE";

  begin
    reset(resetb, en_i, we_i, en_d, we_d, ben_i, ben_d);
    --wait until rising_edge(resetb_tb);
    --wait until rising_edge(clk_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 1: Expected Behaviour:" & lf);
    write(output, "  1. Instruction Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0xDEADBEEFBAADC0DE every iteration" & lf);
    write(output, "  3. Writes to all 8 bytes" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk);
    for i in 0 to 15 loop
      -- Write 0xDEADBEEFBAADC0DE to address 0x0000000, 0x00000008, ...
      addri_tmp := i * 8;
      addr_i <= std_logic_vector(to_unsigned(addri_tmp, 32));
      di_i <= std_logic_vector(data_unsigned);
      en_i <= '1'; we_i <= '1';
      ben_i <= (others => '0');
      -- Display some info
      display : if (i /= 0) then
        hwrite(naddri_line, std_logic_vector(to_unsigned(addri_tmp, 32)));
        hwrite(addri_line, addr_i);
        hwrite(datai_line, do_i);
        report lf & "(TT) Test 1 Iter " & integer'image(i-1) & lf &
          "(TT)  Addr in = 0x" & naddri_line.all & lf &
          "(TT)  Addr = 0x" & addri_line.all & lf &
          "(TT)  Data = 0x" & datai_line.all severity note;
        deallocate(naddri_line);
        deallocate(addri_line);
        deallocate(datai_line);
      end if display;
      -- Wait a clock
      wait until rising_edge(clk);
    end loop;
  end procedure test_1;

  procedure test_2(
    signal resetb : out std_logic;
    signal en_i, we_i, en_d, we_d : out std_logic;
    signal ben_i, ben_d : out std_logic_vector(7 downto 0);
    signal addr_i, addr_d : inout std_logic_vector(31 downto 0);
    signal di_i, di_d : inout std_logic_vector(63 downto 0)
   -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addri_tmp, addrd_tmp : integer;
    variable naddri_line, addri_line, datai_line : line;
    variable naddrd_line, addrd_line, datad_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"BADA661ECAFEF00D";

  begin
    reset(resetb, en_i, we_i, en_d, we_d, ben_i, ben_d);
    --wait until rising_edge(resetb_tb);
    --wait until rising_edge(clk_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 2: Expected Behaviour:" & lf);
    write(output, "  1. Instruction Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0xBADA661ECAFEF00D every iteration" & lf);
    write(output, "  3. Writes to all 8 bytes" & lf);
    write(output, "  4. At the same time, Data Address increment by 0x8 for each iteration" & lf);
    write(output, "  5. The two ports should give identical outputs" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk);
    for i in 0 to 15 loop
      -- Write 0xBADA661ECAFEF00D to address 0x0000000, 0x00000008, ...
      addri_tmp := i * 8;
      addr_i <= std_logic_vector(to_unsigned(addri_tmp, 32));
      di_i <= std_logic_vector(data_unsigned);
      en_i <= '1'; we_i <= '1';
      ben_i <= (others => '0');
      addrd_tmp := i * 8;
      addr_d <= std_logic_vector(to_unsigned(addrd_tmp, 32));
      en_d <= '1'; we_d <= '0';
      ben_d <= (others => '0');
      -- Display some info
      display : if (i /= 0) then
        hwrite(naddri_line, std_logic_vector(to_unsigned(addri_tmp, 32)));
        hwrite(addri_line, addr_i);
        hwrite(datai_line, do_i);
        hwrite(naddrd_line, std_logic_vector(to_unsigned(addrd_tmp, 32)));
        hwrite(addrd_line, addr_d);
        hwrite(datad_line, do_d);
        report lf & "(TT) Test 2 Iter " & integer'image(i-1) & lf &
          "(TT)  I. Addr in = 0x" & naddri_line.all & lf &
          "(TT)  I. Addr = 0x" & addri_line.all & lf &
          "(TT)  I. Data = 0x" & datai_line.all & lf &
          "(TT)  D. Addr in = 0x" & naddrd_line.all & lf &
          "(TT)  D. Addr = 0x" & addrd_line.all & lf &
          "(TT)  D. Data = 0x" & datad_line.all severity note;
        deallocate(naddri_line);
        deallocate(addri_line);
        deallocate(datai_line);
        deallocate(naddrd_line);
        deallocate(addrd_line);
        deallocate(datad_line);
      end if display;
      -- Wait a clock
      wait until rising_edge(clk);
    end loop;
  end procedure test_2;

  procedure test_3(
    signal resetb : out std_logic;
    signal en_i, we_i, en_d, we_d : out std_logic;
    signal ben_i, ben_d : out std_logic_vector(7 downto 0);
    signal addr_i, addr_d : inout std_logic_vector(31 downto 0);
    signal di_i, di_d : inout std_logic_vector(63 downto 0)
   -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addri_tmp, addrd_tmp : integer;
    variable naddri_line, addri_line, datai_line : line;
    variable naddrd_line, addrd_line, datad_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"0FF1CECAFEBADD06";

  begin
    reset(resetb, en_i, we_i, en_d, we_d, ben_i, ben_d);
    --wait until rising_edge(resetb_tb);
    --wait until rising_edge(clk_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 3: Expected Behaviour:" & lf);
    write(output, "  1. Instruction Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0x0FF1CECAFEBADF00D every iteration" & lf);
    write(output, "  3. Writes only high 4 bytes" & lf);
    write(output, "  4. At the same time, Data Address increment by 0x8 for each iteration" & lf);
    write(output, "  5. The two ports should give identical outputs" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk);
    for i in 0 to 15 loop
      -- Write 0x0FF1CECAFEBADF00D to address 0x0000000, 0x00000008, ...
      addri_tmp := i * 8;
      addr_i <= std_logic_vector(to_unsigned(addri_tmp, 32));
      di_i <= std_logic_vector(data_unsigned);
      en_i <= '1'; we_i <= '1';
      ben_i(7 downto 4) <= (others => '0');
      addrd_tmp := i * 8;
      addr_d <= std_logic_vector(to_unsigned(addrd_tmp, 32));
      en_d <= '1'; we_d <= '0';
      ben_d <= (others => '0');
      -- Display some info
      display : if (i /= 0) then
        hwrite(naddri_line, std_logic_vector(to_unsigned(addri_tmp, 32)));
        hwrite(addri_line, addr_i);
        hwrite(datai_line, do_i);
        hwrite(naddrd_line, std_logic_vector(to_unsigned(addrd_tmp, 32)));
        hwrite(addrd_line, addr_d);
        hwrite(datad_line, do_d);
        report lf & "(TT) Test 3 Iter " & integer'image(i-1) & lf &
          "(TT)  I. Addr in = 0x" & naddri_line.all & lf &
          "(TT)  I. Addr = 0x" & addri_line.all & lf &
          "(TT)  I. Data = 0x" & datai_line.all & lf &
          "(TT)  D. Addr in = 0x" & naddrd_line.all & lf &
          "(TT)  D. Addr = 0x" & addrd_line.all & lf &
          "(TT)  D. Data = 0x" & datad_line.all severity note;
        deallocate(naddri_line);
        deallocate(addri_line);
        deallocate(datai_line);
        deallocate(naddrd_line);
        deallocate(addrd_line);
        deallocate(datad_line);
      end if display;
      -- Wait a clock
      wait until rising_edge(clk);
    end loop;
  end procedure test_3;
  
begin
  UUT : MMU port map(
    clk => clk, resetb => resetb,
    we_i => we_i, en_i => en_i,
    addr_i => addr_i(31 downto 3), ben_i => ben_i,
    di_i => di_i, do_i => do_i,
    we_d => we_d, en_d => en_d,
    addr_d => addr_d(31 downto 3), ben_d => ben_d,
    di_d => di_d, do_d => do_d
    );

  clk_generation : process
  begin
    if (not END_SIMULATION) then
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    else
      wait;
    end if;
  end process clk_generation;

  stimulus : process
  begin
    -- test_1(resetb, en_i, we_i, en_d, we_d,
    --        ben_i, ben_d, addr_i, addr_d,
    --        di_i, di_d);
    -- test_2(resetb, en_i, we_i, en_d, we_d,
    --        ben_i, ben_d, addr_i, addr_d,
    --        di_i, di_d);
    test_3(resetb, en_i, we_i, en_d, we_d,
           ben_i, ben_d, addr_i, addr_d,
           di_i, di_d);
    -- End Simulation
    END_SIMULATION := true;
    wait;
  -- assert false report "Simulation Ended" severity failure;
  end process stimulus;
end architecture behavioral;
