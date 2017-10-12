----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:54 03/07/2016 
-- Design Name: 
-- Module Name:    DECMUX5 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECMUX5 is
    Port ( Instr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Instr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel : in  STD_LOGIC;
           MOut5 : out  STD_LOGIC_VECTOR (4 downto 0));
end DECMUX5;

architecture Behavioral of DECMUX5 is

begin

MOut5 <= Instr1 when (RF_B_sel='0') else
	        Instr2;

end Behavioral;

