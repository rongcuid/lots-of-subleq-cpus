----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date:
-- Design Name:
-- Module Name: test_cpu_top
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

entity test_cpu_top_tb is
end test_cpu_top_tb;

architecture behavioral of test_cpu_top_tb is
  component cpu_top 
    port(
      clk : in std_logic;
      resetb : in std_logic;
      -- Interface with boot ROM
      cpu_rom_addr : out unsigned(31 downto 0);
      cpu_rom_data : in std_logic_vector(31 downto 0);
      -- Interface with board
      boot_done : out std_logic
      );
  end component cpu_top;

  subtype word_t is std_logic_vector(31 downto 0);
  type ram_t is array(0 to 1023) of word_t;
  signal rom : ram_t;
  signal clk, resetb, boot_done : std_logic;
  signal cpu_rom_addr : unsigned(31 downto 0);
  signal cpu_rom_data : std_logic_vector(31 downto 0);

  -- Simulation control
  shared variable END_SIMULATION : boolean := false;

  -- https://electronics.stackexchange.com/questions/180446/how-to-load-std-logic-vector-array-from-text-file-at-start-of-simulation
-- Read a *.hex file
  impure function ocram_ReadMemFile(FileName : STRING) return ram_t is
    file FileHandle       : TEXT open READ_MODE is FileName;
    variable CurrentLine  : LINE;
    variable TempWord     : word_t;
    variable Result       : ram_t    := (others => (others => '0'));
    variable i : integer;

  begin
    for i in 0 to 1023 loop
      exit when endfile(FileHandle);

      readline(FileHandle, CurrentLine);
      read(CurrentLine, TempWord);
      Result(i)    := TempWord;
    end loop;

    return Result;
  end function;

  -- Test procedures
  procedure reset (
    signal resetb : out std_logic
    ) is
  begin
    wait until rising_edge(clk);
    resetb <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    resetb <= '1';
  end procedure reset;
  procedure test_1(
    signal resetb : out std_logic;
    signal rom : inout ram_t
    ) is
  begin
    rom <= ocram_ReadMemFile("test/simulation/code/00-SW.bin");
    reset(resetb);
    write(output, lf & "(TT)==============================================" & lf);    
    write(output, "(TT) Test 1 SW Expected Behaviour:" & lf);
    write(output, "(TT)   1. All instructions are SD x0, off(x0)" & lf);
    write(output, "(TT)   2. Offset start from 0x100 to 0x120" & lf);
    write(output, "(TT)   3. RAM data in range should be cleared" & lf);
    write(output, "(TT)   4. Waveforms must be read" & lf);
    write(output, "(TT) ==============================================" & lf);
    for i in 0 to 127 loop
      wait until rising_edge(clk);
    end loop;
  end procedure test_1;


begin
  -- Reads ROM
  cpu_rom_data <= rom(to_integer(signed(cpu_rom_addr(11 downto 2))));
  UUT : cpu_top
    port map (clk, resetb, cpu_rom_addr, cpu_rom_data, boot_done);
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
    test_1(resetb, rom);
    -- End Simulation
    END_SIMULATION := true;
    wait;
  -- assert false report "Simulation Ended" severity failure;
  end process stimulus;

end architecture behavioral;
