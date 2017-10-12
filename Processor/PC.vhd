----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:57 03/05/2016 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC);
end PC;

architecture Behavioral of PC is

signal tmp : STD_LOGIC_VECTOR (31 downto 0);

begin
Process
begin
	
	wait until(CLK'EVENT AND CLK='1') ;
	 if(RST='1') then
	   tmp<="00000000000000000000000000000000";
		
	else
		

	   if(PC_LdEn='1') then 
			tmp<= Din;
		 else
			tmp <= tmp;
		 end if;
		 
	end if;
	
end process;	
	Dout <=tmp;

end Behavioral;

