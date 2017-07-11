----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: test_regfile
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

entity test_regfile_tb is
end test_regfile_tb;

architecture behavioral of test_regfile_tb is
  -- Component declarations
  component RegFile
    generic ( WIDTH : integer := 64;
              DEPTH : integer := 16;
              DEPTH_LOG : integer := 4
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

  -- Signals
  signal clk_tb, resetb_tb, wb_we_tb, en_tb : std_logic;
  signal rs_a_tb, rt_a_tb, wb_a_tb : std_logic_vector(3 downto 0);
  signal rs_d_tb, rt_d_tb, wb_d_tb : std_logic_vector(63 downto 0);
  -- Simulation control
  shared variable END_SIMULATION : boolean := false;
  
  -- Test procedures
  procedure reset (
    signal resetb : out std_logic
    ) is
  begin
    wait until rising_edge(clk_tb);
    resetb <= '0';
    wait until rising_edge(clk_tb);
    wait until rising_edge(clk_tb);
    resetb <= '1';
  end procedure reset;

  procedure test_1(
    signal resetb, en, wb_we : out std_logic;
    signal rs_a, rt_a, wb_a : out std_logic_vector(3 downto 0);
    signal wb_d : out std_logic_vector(63 downto 0)
    ) is
    variable addr_tmp, addr2_tmp : std_logic_vector(3 downto 0);
    variable rs_line, rt_line : line;
  begin
    en <= '0'; wb_we <= '0';
    reset(resetb);
    --wait until rising_edge(resetb_tb);
    --wait until rising_edge(clk_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 1: Expected Behaviour:" & lf);
    write(output, "  1. Writes 15,14,...,0 to x0 to x15" & lf);
    write(output, "  2. Then reads all of them" & lf);
    write(output, "  3. x0 must read 0" & lf);
    write(output, "  4. All reads must delay by one clock" & lf);
    write(output, "  5. Disregard Prev_* for first iteration" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk_tb);
    -- Write cycle
    for i in 0 to 15 loop
      addr_tmp := std_logic_vector(to_unsigned(i,4));
      en <= '1';
      wb_we <= '1';
      wb_a <= addr_tmp;
      wb_d <= std_logic_vector(to_unsigned(15-i, 64));
      wait until rising_edge(clk_tb);
    end loop;
    for i in 0 to 31 loop
      addr_tmp := std_logic_vector(to_unsigned(i,4));
      addr2_tmp := std_logic_vector(unsigned(to_signed(15-i,4)));
      en <= '1';
      wb_we <= '0';
      rs_a <= addr_tmp;
      rt_a <= addr2_tmp;
      -- Display some info
      hwrite(rs_line, rs_d_tb);
      hwrite(rt_line, rt_d_tb);
      report "Test 1: " & lf &
        "  Rs = x"& integer'image(i mod 16) & lf &
        "  Rt = x"& integer'image((15-i) mod 16) & lf &
        "  Prev Rs = 0x" & rs_line.all & lf &
        "  Prev Rt = 0x" & rt_line.all severity note;
      deallocate(rs_line);
      deallocate(rt_line);
      wait until rising_edge(clk_tb);
    end loop;
  end procedure test_1;

  procedure test_2(
    signal resetb, en, wb_we : out std_logic;
    signal rs_a, rt_a, wb_a : out std_logic_vector(3 downto 0);
    signal wb_d : out std_logic_vector(63 downto 0)
    ) is
    variable addr_tmp, addr2_tmp : std_logic_vector(3 downto 0);
    variable rs_line, rt_line, wb_line : line;
  begin
    en <= '0'; wb_we <= '0';
    reset(resetb);
    --wait until rising_edge(resetb_tb);
    --wait until rising_edge(clk_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 2: Expected Behaviour:" & lf);
    write(output, "  1. Writes 15,14,...,0 to x0 to x15" & lf);
    write(output, "  2. Then writes 1,2,4,8,... to x0 to x15" & lf);
    write(output, "  3. At the same time, Rs reads from x0 to x15" & lf);
    write(output, "  4. At the same time, Rt reads from x15 to x0" & lf);
    write(output, "  5. All reads must receive latest and correct value" & lf);
    write(output, "  6. All operations are delayed for one clock, therefore correct output should be something like:" & lf);
    write(output, "Prev Rx = x<reg>" & lf);
    write(output, "--- Next Iteration ---" & lf);
    write(output, "Prev Rx_d = correct data" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk_tb);
    -- First write cycle to put in some valid data
    for i in 0 to 15 loop
      addr_tmp := std_logic_vector(to_unsigned(i,4));
      en <= '1';
      wb_we <= '1';
      wb_a <= addr_tmp;
      wb_d <= std_logic_vector(to_unsigned(15-i, 64));
      wait until rising_edge(clk_tb);
    end loop;
    for i in 0 to 31 loop
      addr_tmp := std_logic_vector(to_unsigned(i,4));
      addr2_tmp := std_logic_vector(unsigned(to_signed(15-i,4)));
      en <= '1';
      wb_we <= '1';
      wb_a <= addr_tmp;
      wb_d <= std_logic_vector(shift_left(to_unsigned(i,64), i));
      rs_a <= addr_tmp;
      rt_a <= addr2_tmp;
      -- Display some info
      if (i /= 0) then
        hwrite(wb_line, wb_d_tb);
        hwrite(rs_line, rs_d_tb);
        hwrite(rt_line, rt_d_tb);
        report "Test 2: " & lf &
          "  Prev Wb = x"& integer'image((i-1) mod 16) & lf &
          "  Prev Wb_d = 0x" & wb_line.all & lf &
          "  Prev Rs = x"& integer'image((i-1) mod 16) & lf &
          "  Prev Rs_d = 0x" & rs_line.all & lf &
          "  Prev Rt = x"& integer'image((15-i+1) mod 16) & lf &
          "  Prev Rt_d = 0x" & rt_line.all severity note;
        deallocate(rs_line);
        deallocate(rt_line);
        deallocate(wb_line);
      end if;
      wait until rising_edge(clk_tb);
    end loop;
  end procedure test_2;

begin
  UUT : RegFile port map(
    clk => clk_tb, resetb => resetb_tb, en => en_tb,
    rs_a => rs_a_tb, rs_d => rs_d_tb,
    rt_a => rt_a_tb, rt_d => rt_d_tb,
    wb_we => wb_we_tb, wb_a => wb_a_tb, wb_d => wb_d_tb
    );

  clk : process
  begin
    if (not END_SIMULATION) then
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
    else
      wait;
    end if;
  end process clk;

  stimulus : process
  begin
    test_1(resetb_tb, en_tb, wb_we_tb,
           rs_a_tb, rt_a_tb, wb_a_tb, wb_d_tb);
    test_2(resetb_tb, en_tb, wb_we_tb,
           rs_a_tb, rt_a_tb, wb_a_tb, wb_d_tb);
    -- End Simulation
    END_SIMULATION := true;
    wait;
  -- assert false report "Simulation Ended" severity failure;
  end process stimulus;
end architecture behavioral;
