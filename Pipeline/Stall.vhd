----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:49:49 05/21/2015 
-- Design Name: 
-- Module Name:    Stall - Behavioral 
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

entity Stall is
    Port ( CurrentOpcode : in  STD_LOGIC_VECTOR (5 downto 0);
           PrevOpcode : in  STD_LOGIC_VECTOR (5 downto 0);
           RD_IN : in  STD_LOGIC_VECTOR (4 downto 0);
			  RT_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           RS_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           SELECT_CONTROL : out  STD_LOGIC);
end Stall;

architecture Behavioral of Stall is

begin

SELECT_CONTROL <=	 '1' when RS_IN = RD_IN AND PrevOpcode="001111" AND CurrentOpcode="100000" else --rs=rd
'1' when RT_IN = RD_IN AND PrevOpcode="001111" AND CurrentOpcode="100000" else --rt=rd



'0';

end Behavioral;

