----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:31 04/02/2016 
-- Design Name: 
-- Module Name:    ALU_OUT_Mux - Behavioral 
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

entity ALU_OUT_Mux is
    Port ( ALU_OUT : in  STD_LOGIC_VECTOR (31 downto 0);
           RS : in  STD_LOGIC_VECTOR (31 downto 0);
           RT : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0));
end ALU_OUT_Mux;

architecture Behavioral of ALU_OUT_Mux is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= ALU_OUT when (sel="00") else
	    RS when (sel="01") else
		 RT when (sel="10");

Output<=tmp;

end Behavioral;

