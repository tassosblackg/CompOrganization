----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:10:20 03/05/2016 
-- Design Name: 
-- Module Name:    Data_Mem - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_Mem is
    Port ( CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (9 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Data_Mem;

architecture Behavioral of Data_Mem is

  type ram_type is array (1023 downto 0) of std_logic_vector (31 downto 0);
  impure function InitRam return ram_type is
  variable ram : ram_type;

 begin
  for  i in 0 to 1023 loop
    ram(i) := x"00000000";
 
  end loop;
 return ram;
 end function;


signal RAM: ram_type := InitRam;

begin

process (clk)
 begin
  if clk'event and clk = '1' then
   if we = '1' then
   RAM(conv_integer(addr)) <= din;
   end if;
  dout<= RAM(conv_integer(addr)) ;
 
 end if;
 
end process; 





end Behavioral;

