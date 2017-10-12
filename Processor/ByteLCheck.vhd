----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:42 03/20/2016 
-- Design Name: 
-- Module Name:    ByteLCheck - Behavioral 
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

entity ByteLCheck is
    Port ( linp : in  STD_LOGIC_VECTOR (31 downto 0);
           lout : out  STD_LOGIC_VECTOR (31 downto 0);
           lsel : in  STD_LOGIC);
end ByteLCheck;

architecture Behavioral of ByteLCheck is

signal r : STD_LOGIC_VECTOR (31 downto 0);

begin

r<=         ("000000000000000000000000" & linp(7 downto 0)) when lsel='1' else
            (linp) ;

lout<=r;

end Behavioral;

