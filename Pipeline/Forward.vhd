----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:28:44 05/21/2015 
-- Design Name: 
-- Module Name:    Forward - Behavioral 
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

entity Forward is
    Port ( RS_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           RT_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_FROM_ALU : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_FROM_MEM : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_WR_EN : in  STD_LOGIC;
			  OPCODE : in  STD_LOGIC_VECTOR (5 downto 0);
			  NEXT_OPCODE : in  STD_LOGIC_VECTOR (5 downto 0);
           SEL_A_B : out  STD_LOGIC_VECTOR (3 downto 0) --SEL_A_B(1 downto 0) gia A,SEL_A_B(3 downto 2)gia B
           );
end Forward;

architecture Behavioral of Forward is
signal tempOutput:STD_LOGIC_VECTOR (3 downto 0):=(others=>'0');
begin

--Elegxos gia to RS
tempOutput <=	 "0101" when RS_IN = RD_FROM_ALU AND RT_IN = RD_FROM_ALU AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE/="001111" else --rs=rd and rt=rd 
"0001" when RS_IN = RD_FROM_ALU AND RT_IN /= RD_FROM_ALU AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE/="001111"else --rs=rd
    "0100" when RS_IN = RD_FROM_ALU AND RT_IN = RD_FROM_ALU AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE/="001111"else --rt=rd
 --from alu2
	  "1010" when RS_IN = RD_FROM_MEM AND RT_IN = RD_FROM_MEM AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE/="001111"else --rs=rd and rt=rd
	 "0010" when RS_IN = RD_FROM_MEM AND RT_IN /= RD_FROM_MEM AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE/="001111"else --rs=rd
	 "1000" when RS_IN /= RD_FROM_MEM AND RT_IN = RD_FROM_MEM AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE/="001111"else --rt=rd
	 --from mem
"1111" when RS_IN = RD_FROM_MEM AND RT_IN = RD_FROM_MEM AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE="001111"else --rs=rd and rt=rd
	 "0011" when RS_IN = RD_FROM_MEM AND RT_IN /= RD_FROM_MEM AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE="001111"else --rs=rd
	 "1100" when RS_IN /= RD_FROM_MEM AND RT_IN = RD_FROM_MEM AND RF_WR_EN='1' AND OPCODE="100000" AND NEXT_OPCODE="001111"else --rt=rd
	

"0000";

SEL_A_B<=tempOutput;

end Behavioral;

