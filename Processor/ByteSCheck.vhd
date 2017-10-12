----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:04:29 03/20/2016 
-- Design Name: 
-- Module Name:    ByteSCheck - Behavioral 
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

entity ByteSCheck is
    Port ( sinp : in  STD_LOGIC_VECTOR (31 downto 0);
           sout : out  STD_LOGIC_VECTOR (31 downto 0);
           ssel : in  STD_LOGIC);
end ByteSCheck;

architecture Behavioral of ByteSCheck is

signal r : STD_LOGIC_VECTOR (31 downto 0);

begin

r<=         ("000000000000000000000000" & sinp(7 downto 0)) when ssel='1' else
            (sinp) ;


sout<=r;

end Behavioral;

