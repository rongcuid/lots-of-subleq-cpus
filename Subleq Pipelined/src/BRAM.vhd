----------------------------------------------------------------------------------
-- Company: The Most Awesome Mad Scientist Ever
-- Engineer: Rongcui Dong
--
-- Create Date: 06/29/2017 07:16:10 PM
-- Design Name:
-- Module Name: BRAM
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- This is a single port BRAM
entity BRAM_SP is
  generic ( WIDTH : integer := 32;
            DEPTH : integer := 1024;
            DEPTH_LOG : integer := 10
            );
  port (
    clk : in std_logic;
    we : in std_logic;
    en : in std_logic;
    addr : in std_logic_vector(DEPTH_LOG-1 downto 0);
    di : in std_logic_vector(WIDTH-1 downto 0);
    do : out std_logic_vector(WIDTH-1 downto 0)
    );
end BRAM_SP;

-- This is a write first memory which should be inferred as a BRAM
architecture syn of BRAM_SP is
  type ram_type is array(DEPTH-1 downto 0) of std_logic_vector (WIDTH-1 downto 0);
  signal data: ram_type;
begin
  process (clk)
  begin
    if clk'event and clk = '1' then
      if en = '1' then
        if we = '1' then
          data(to_integer(unsigned(addr))) <= di;
          do <= di;
        else
          do <= data(to_integer(unsigned(addr)));
        end if;
      end if;

    end if;
  end process;
end syn;