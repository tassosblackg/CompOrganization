----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:54:07 02/21/2016 
-- Design Name: 
-- Module Name:    Reg - Behavioral 
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

entity RegB_I is
    port(      RFBOut : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WErB : in  STD_LOGIC;
           Dout4 : out  STD_LOGIC_VECTOR (31 downto 0));
end RegB_I;

architecture Behavioral of RegB_I is


signal tmp : STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";

begin

Process
begin
	wait until(CLK'EVENT AND CLK='1') ;
		if(WErB='1') then 
			tmp<= RFBOut;
		else
			tmp <= tmp;
		end if;
	
end process;	
	Dout4 <=tmp;

end Behavioral;

