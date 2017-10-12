----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:46:30 04/01/2015 
-- Design Name: 
-- Module Name:    Register32 - Behavioral 
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

entity Register32 is
 Port ( dataIn : in  STD_LOGIC_vector(31 downto 0);
           LoadEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_vector(31 downto 0));
end Register32;

architecture Behavioral of Register32 is

begin
process(clk)
	begin
	if clk'event and clk='1' then
	if reset='1' then
	dataOut<="00000000000000000000000000000000";
	elsif LoadEn='1' then
	dataOut<=dataIn;
	end if;
	end if;
	end process;

end Behavioral;

