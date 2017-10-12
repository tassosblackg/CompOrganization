----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:59:05 05/20/2015 
-- Design Name: 
-- Module Name:    Register5 - Behavioral 
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


entity Register5 is
 Port ( dataIn : in  STD_LOGIC_vector(4 downto 0);
           LoadEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_vector(4 downto 0));
end Register5;

architecture Behavioral of Register5 is

begin
process(clk)
	begin
	if clk'event and clk='1' then
	if reset='1' then
	dataOut<="00000";
	elsif LoadEn='1' then
	dataOut<=dataIn;
	end if;
	end if;
	end process;

end Behavioral;






