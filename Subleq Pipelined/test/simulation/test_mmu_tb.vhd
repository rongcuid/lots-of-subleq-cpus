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
      we : in std_logic;
      en : in std_logic;
      addr : in std_logic_vector(31 downto 3);
      be7n, be6n, be5n, be4n, be3n, be2n, be1n, be0n : in std_logic;
      di : in std_logic_vector(63 downto 0);
      do : out std_logic_vector(63 downto 0)
      );
  end component MMU;

  -- Signals
  signal clk_tb, resetb_tb, we_tb, en_tb : std_logic;
  signal be7n_tb, be6n_tb, be5n_tb, be4n_tb : std_logic;
  signal be3n_tb, be2n_tb, be1n_tb, be0n_tb : std_logic;
  signal addr_tb : std_logic_vector(31 downto 0);
  signal di_tb, do_tb : std_logic_vector(63 downto 0);
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
  procedure test_template(
    signal resetb, we, en : out std_logic;
    signal be7n, be6n, be5n, be4n : out std_logic;
    signal be3n, be2n, be1n, be0n : out std_logic;
    signal addr : out std_logic_vector(31 downto 0);
    signal di : out std_logic_vector(63 downto 0);
    signal do : out std_logic_vector(63 downto 0)
    ) is
    begin
  end procedure test_template;
  procedure test_1(
    signal resetb, we, en : out std_logic;
    signal be7n, be6n, be5n, be4n : out std_logic;
    signal be3n, be2n, be1n, be0n : out std_logic;
    signal addr : out std_logic_vector(31 downto 0);
    signal di : out std_logic_vector(63 downto 0)
    -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addr_tmp : integer;
    variable naddr_line, addr_line, data_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"DEADBEEFBAADC0DE";

  begin
    we <= '0'; en <= '0';
    be7n <= '0'; be6n <= '0'; be5n <= '0'; be4n <= '0';
    be3n <= '0'; be2n <= '0'; be1n <= '0'; be0n <= '0';
    addr <= (others => '-');
    di <= (others => '-');
    reset(resetb);
    --wait until rising_edge(resetb_tb);
    --wait until rising_edge(clk_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 1: Expected Behaviour:" & lf);
    write(output, "  1. Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0xDEADBEEFBAADC0DE every iteration" & lf);
    write(output, "  3. Writes to all 8 bytes" & lf);
    write(output, "  4. Disregard Prev_* for first iteration" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk_tb);
    for i in 0 to 15 loop
      -- Write 0xDEADBEEFBAADC0DE to address 0x0000000, 0x00000008, ...
      addr_tmp := i * 8;
      addr <= std_logic_vector(to_unsigned(addr_tmp, 32));
      di <= std_logic_vector(data_unsigned);
      en <= '1'; we <= '1';
      -- Display some info
      hwrite(naddr_line, std_logic_vector(to_unsigned(addr_tmp, 32)));
      hwrite(addr_line, addr_tb);
      hwrite(data_line, do_tb);
      report "Test 1 Iter " & integer'image(i) & lf &
        "  Addr in = 0x" & naddr_line.all & lf &
        "  Prev Addr = 0x" & addr_line.all & lf &
        "  Prev Data = 0x" & data_line.all severity note;
      deallocate(naddr_line);
      deallocate(addr_line);
      deallocate(data_line);
      -- Wait a clock
      wait until rising_edge(clk_tb);
    end loop;
  end procedure test_1;

  procedure test_2(
    signal resetb, we, en : out std_logic;
    signal be7n, be6n, be5n, be4n : out std_logic;
    signal be3n, be2n, be1n, be0n : out std_logic;
    signal addr : out std_logic_vector(31 downto 0);
    signal di : out std_logic_vector(63 downto 0)
    -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addr_tmp : integer;
    variable naddr_line, addr_line, data_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"BADA661E11223344";

  begin
    we <= '0'; en <= '0';
    be7n <= '1'; be6n <= '1'; be5n <= '1'; be4n <= '1';
    be3n <= '1'; be2n <= '1'; be1n <= '1'; be0n <= '1';
    addr <= (others => '-');
    di <= (others => '-');
    reset(resetb);
    --wait until rising_edge(resetb_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 2: Expected Behaviour:" & lf);
    write(output, "  1. Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0xBADA661E11223344 every iteration" & lf);
    write(output, "  3. Writes to individual bytes equal to iteration count" & lf);
    write(output, "  4. Disregard Prev_* for first iteration" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk_tb);
    for i in 0 to 9 loop
      case i is
        when 0 => be0n <= '0';
        when 1 => be0n <= '1'; be1n <= '0';
        when 2 => be1n <= '1'; be2n <= '0';
        when 3 => be2n <= '1'; be3n <= '0';
        when 4 => be3n <= '1'; be4n <= '0';
        when 5 => be4n <= '1'; be5n <= '0';
        when 6 => be5n <= '1'; be6n <= '0';
        when 7 => be6n <= '1'; be7n <= '0';
        when others => be7n <= '1';
      end case;       
      addr_tmp := i * 8;
      addr <= std_logic_vector(to_unsigned(addr_tmp, 32));
      di <= std_logic_vector(data_unsigned);
      en <= '1'; we <= '1';
      -- Display some info
      hwrite(naddr_line, std_logic_vector(to_unsigned(addr_tmp, 32)));
      hwrite(addr_line, addr_tb);
      hwrite(data_line, do_tb);
      report "Test 2 Iter " & integer'image(i) & lf &
        "  Addr in = 0x" & naddr_line.all & lf &
        "  Prev Addr = 0x" & addr_line.all & lf &
        "  Prev Data = 0x" & data_line.all severity note;
      deallocate(naddr_line);
      deallocate(addr_line);
      deallocate(data_line);
      -- Wait a clock
      wait until rising_edge(clk_tb);
    end loop;
  end procedure test_2;

  procedure test_3(
    signal resetb, we, en : out std_logic;
    signal be7n, be6n, be5n, be4n : out std_logic;
    signal be3n, be2n, be1n, be0n : out std_logic;
    signal addr : out std_logic_vector(31 downto 0);
    signal di : out std_logic_vector(63 downto 0)
    -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addr_tmp : integer;
    variable naddr_line, addr_line, data_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"4B1D0D06F00DCAFE";

  begin
    we <= '0'; en <= '0';
    be7n <= '1'; be6n <= '1'; be5n <= '1'; be4n <= '1';
    be3n <= '1'; be2n <= '1'; be1n <= '1'; be0n <= '1';
    addr <= (others => '-');
    di <= (others => '-');
    reset(resetb);
    --wait until rising_edge(resetb_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 3: Expected Behaviour:" & lf);
    write(output, "  1. Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0x4B1D0D06F00DCAFE every iteration" & lf);
    write(output, "  3. Writes two bytes at a time" & lf);
    write(output, "  4. Disregard Prev_* for first iteration" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk_tb);
    for i in 0 to 5 loop
      case i is
        when 0 => be0n <= '0'; be1n <= '0';
        when 1 => be0n <= '1'; be1n <= '1'; be2n <= '0'; be3n <= '0';
        when 2 => be2n <= '1'; be3n <= '1'; be4n <= '0'; be5n <= '0';
        when 3 => be4n <= '1'; be5n <= '1'; be6n <= '0'; be7n <= '0';
        when others => be6n <= '1'; be7n <= '1';
      end case;       
      addr_tmp := i * 8;
      addr <= std_logic_vector(to_unsigned(addr_tmp, 32));
      di <= std_logic_vector(data_unsigned);
      en <= '1'; we <= '1';
      -- Display some info
      hwrite(naddr_line, std_logic_vector(to_unsigned(addr_tmp, 32)));
      hwrite(addr_line, addr_tb);
      hwrite(data_line, do_tb);
      report "Test 3 Iter " & integer'image(i) & lf &
        "  Addr in = 0x" & naddr_line.all & lf &
        "  Prev Addr = 0x" & addr_line.all & lf &
        "  Prev Data = 0x" & data_line.all severity note;
      deallocate(naddr_line);
      deallocate(addr_line);
      deallocate(data_line);
      -- Wait a clock
      wait until rising_edge(clk_tb);
    end loop;
  end procedure test_3;

  procedure test_4(
    signal resetb, we, en : out std_logic;
    signal be7n, be6n, be5n, be4n : out std_logic;
    signal be3n, be2n, be1n, be0n : out std_logic;
    signal addr : out std_logic_vector(31 downto 0);
    signal di : out std_logic_vector(63 downto 0)
    -- signal do : out std_logic_vector(63 downto 0)
    ) is
    variable addr_tmp : integer;
    variable naddr_line, addr_line, data_line : line;
    constant data_unsigned : unsigned(63 downto 0) :=
      X"B00000000000DEAD";

  begin
    we <= '0'; en <= '0';
    be7n <= '1'; be6n <= '1'; be5n <= '1'; be4n <= '1';
    be3n <= '1'; be2n <= '1'; be1n <= '1'; be0n <= '1';
    addr <= (others => '-');
    di <= (others => '-');
    reset(resetb);
    --wait until rising_edge(resetb_tb);
    write(output, lf & "==============================================" & lf);    
    write(output, "(II) Test 4: Expected Behaviour:" & lf);
    write(output, "  1. Address increment by 0x8 for each iteration" & lf);
    write(output, "  2. Writes 0xB00000000000DEAD every iteration" & lf);
    write(output, "  3. Writes four bytes at a time" & lf);
    write(output, "  4. Disregard Prev_* for first iteration" & lf);
    write(output, "==============================================" & lf);
    wait until rising_edge(clk_tb);
    for i in 0 to 3 loop
      case i is
        when 0 => be0n <= '0'; be1n <= '0'; be2n <='0'; be3n <= '0';
        when 1 => be0n <= '1'; be1n <= '1'; be2n <= '1'; be3n <= '1';
                  be4n <= '0'; be5n <= '0'; be6n <= '0'; be7n <= '0';     
        when others => be4n <= '1'; be5n <= '1'; be6n <= '1'; be7n <= '1';
      end case;       
      addr_tmp := i * 8;
      addr <= std_logic_vector(to_unsigned(addr_tmp, 32));
      di <= std_logic_vector(data_unsigned);
      en <= '1'; we <= '1';
      -- Display some info
      hwrite(naddr_line, std_logic_vector(to_unsigned(addr_tmp, 32)));
      hwrite(addr_line, addr_tb);
      hwrite(data_line, do_tb);
      report "Test 4 Iter " & integer'image(i) & lf &
        "  Addr in = 0x" & naddr_line.all & lf &
        "  Prev Addr = 0x" & addr_line.all & lf &
        "  Prev Data = 0x" & data_line.all severity note;
      deallocate(naddr_line);
      deallocate(addr_line);
      deallocate(data_line);
      -- Wait a clock
      wait until rising_edge(clk_tb);
    end loop;
  end procedure test_4;

  
begin
  UUT : MMU port map(
    clk => clk_tb, resetb => resetb_tb,
    we => we_tb, en => en_tb,
    addr => addr_tb(31 downto 3),
    be7n=>be7n_tb, be6n=>be6n_tb,
    be5n=>be5n_tb, be4n=>be4n_tb,
    be3n=>be3n_tb, be2n=>be2n_tb,
    be1n=>be1n_tb, be0n=>be0n_tb,
    di => di_tb,
    do => do_tb
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
    test_1(resetb_tb, we_tb, en_tb,
           be7n_tb, be6n_tb, be5n_tb, be4n_tb,
           be3n_tb, be2n_tb, be1n_tb, be0n_tb,
           addr_tb, di_tb
           );
    test_2(resetb_tb, we_tb, en_tb,
           be7n_tb, be6n_tb, be5n_tb, be4n_tb,
           be3n_tb, be2n_tb, be1n_tb, be0n_tb,
           addr_tb, di_tb
           );
    test_3(resetb_tb, we_tb, en_tb,
           be7n_tb, be6n_tb, be5n_tb, be4n_tb,
           be3n_tb, be2n_tb, be1n_tb, be0n_tb,
           addr_tb, di_tb
           );
    test_4(resetb_tb, we_tb, en_tb,
           be7n_tb, be6n_tb, be5n_tb, be4n_tb,
           be3n_tb, be2n_tb, be1n_tb, be0n_tb,
           addr_tb, di_tb
           );
    -- End Simulation
    END_SIMULATION := true;
    wait;
    -- assert false report "Simulation Ended" severity failure;
  end process stimulus;
end architecture behavioral;
