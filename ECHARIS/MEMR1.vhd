----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:11:39 04/03/2016 
-- Design Name: 
-- Module Name:    MEMR1 - Behavioral 
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

entity MEMR1 is
    Port ( Inp1 : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEn1 : in  STD_LOGIC;
           Outp1 : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMR1;

architecture Behavioral of MEMR1 is

signal tmp : STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";

begin

Process
begin
	wait until(CLK'EVENT AND CLK='1') ;
		if(WEn1='1') then 
			tmp<= Inp1;
		else
			tmp <= tmp;
		end if;
	
end process;	
	Outp1 <=tmp;

end Behavioral;


