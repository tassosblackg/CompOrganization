----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:22:31 03/05/2015 
-- Design Name: 
-- Module Name:    CompareModule - Behavioral 
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

entity CompareModule is
    Port ( ReadAddress : in  STD_LOGIC_VECTOR (4 downto 0);
           WriteAddress : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           output : out  STD_LOGIC);
end CompareModule;

architecture Behavioral of CompareModule is

begin

	output <= '1' when (ReadAddress=WriteAddress AND WE='1') else '0';

end Behavioral;

