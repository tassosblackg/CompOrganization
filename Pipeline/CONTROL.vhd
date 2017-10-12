----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:51:38 04/01/2015 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
    Port ( Instr : in STD_LOGIC_VECTOR(31 downto 0);			 

			 control_output: out  STD_LOGIC_VECTOR(31 downto 0)
			 );
end CONTROL;

architecture Behavioral of CONTROL is



begin

--opcode,RF_WRDATASEL,RF_WRT_EN,MEM_DATA_OUT_SEL,MEM_DATA_IN_SEL,MEM_WRITE_ENAbLE
--ALU_func=0011,ALU_Bin_Sel=1,RF_B_sel=0,pc_loadEnamble=1,pc_sel=0
control_output <= "00000000000011110000100000111010" when Instr(31 downto 26) = "111000" else --li
	 "00000000000011000000100000000010" when Instr(31 downto 26) = "100000" and Instr(5 downto 0) = "110000" else --add
	 "00000000000010011111100000001010" when Instr(31 downto 26) = "001111" else --lw
	 "00000000000010111110000100001110" when Instr(31 downto 26) = "011111" else --sw

"00000000000000000000000000000000";


end Behavioral;

