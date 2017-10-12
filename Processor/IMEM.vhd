----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:54 03/05/2016 
-- Design Name: 
-- Module Name:    IMEM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IMEM is
    Port ( CLK : in  STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (9 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end IMEM;

architecture Behavioral of IMEM is

type rom_type is array (1023 downto 0) of std_logic_vector (31 downto 0);

impure function InitRomFromFile (RomFileName : in string) return rom_type is
FILE romfile : text is in RomFileName;

variable RomFileLine : line;
variable  rom : rom_type;

begin
for i in 0 to 1023 loop
  readline(romfile, RomFileLine);
  read (RomFileLine, rom(i));
  
end loop;
return rom; 

end function;

signal ROM : rom_type := InitRomFromFile("Rom.data");

begin

 process (clk)
 
 begin
  if clk'event and clk = '1' then
   dout<= ROM(conv_integer(addr)) ;
  end if;
  
end process;

end Behavioral;

