----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:42:28 04/04/2016 
-- Design Name: 
-- Module Name:    AfterMEMReg - Behavioral 
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

entity AfterMEMReg is
   Port ( Inpm : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEnm : in  STD_LOGIC;
           Outpm : out  STD_LOGIC_VECTOR (31 downto 0));
end AfterMEMReg;

architecture Behavioral of AfterMEMReg is

signal tmp : STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";

begin

Process
begin
	wait until(CLK'EVENT AND CLK='1') ;
		if(WEnm='1') then 
			tmp<= Inpm;
		else
			tmp <= tmp;
		end if;
	
end process;	
	Outpm <=tmp;

end Behavioral;

