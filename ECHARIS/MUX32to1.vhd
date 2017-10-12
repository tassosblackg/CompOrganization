----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:45:26 02/21/2016 
-- Design Name: 
-- Module Name:    MUX32to1 - Behavioral 
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

entity MUX32to1 is
    Port ( Adr : in  STD_LOGIC_VECTOR (4 downto 0);
           R0 : in  STD_LOGIC_VECTOR (31 downto 0);
           R1 : in  STD_LOGIC_VECTOR (31 downto 0);
           R2 : in  STD_LOGIC_VECTOR (31 downto 0);
           R3 : in  STD_LOGIC_VECTOR (31 downto 0);
           R4 : in  STD_LOGIC_VECTOR (31 downto 0);
           R5 : in  STD_LOGIC_VECTOR (31 downto 0);
           R6 : in  STD_LOGIC_VECTOR (31 downto 0);
           R7 : in  STD_LOGIC_VECTOR (31 downto 0);
           R8 : in  STD_LOGIC_VECTOR (31 downto 0);
           R9 : in  STD_LOGIC_VECTOR (31 downto 0);
           R10 : in  STD_LOGIC_VECTOR (31 downto 0);
           R11 : in  STD_LOGIC_VECTOR (31 downto 0);
           R12 : in  STD_LOGIC_VECTOR (31 downto 0);
           R13 : in  STD_LOGIC_VECTOR (31 downto 0);
           R14 : in  STD_LOGIC_VECTOR (31 downto 0);
           R15 : in  STD_LOGIC_VECTOR (31 downto 0);
           R16 : in  STD_LOGIC_VECTOR (31 downto 0);
           R17 : in  STD_LOGIC_VECTOR (31 downto 0);
           R18 : in  STD_LOGIC_VECTOR (31 downto 0);
           R19 : in  STD_LOGIC_VECTOR (31 downto 0);
           R20 : in  STD_LOGIC_VECTOR (31 downto 0);
           R21 : in  STD_LOGIC_VECTOR (31 downto 0);
           R22 : in  STD_LOGIC_VECTOR (31 downto 0);
           R23 : in  STD_LOGIC_VECTOR (31 downto 0);
           R24 : in  STD_LOGIC_VECTOR (31 downto 0);
           R25 : in  STD_LOGIC_VECTOR (31 downto 0);
           R26 : in  STD_LOGIC_VECTOR (31 downto 0);
           R27 : in  STD_LOGIC_VECTOR (31 downto 0);
           R28 : in  STD_LOGIC_VECTOR (31 downto 0);
           R29 : in  STD_LOGIC_VECTOR (31 downto 0);
           R30 : in  STD_LOGIC_VECTOR (31 downto 0);
           R31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32to1;

architecture Behavioral of MUX32to1 is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

   tmp<= R0 when Adr="00000" else
	      R1 when Adr="00001" else
			R2 when Adr="00010" else
			R3 when Adr="00011" else
			R4 when Adr="00100" else
			R5 when Adr="00101" else
			R6 when Adr="00110" else
			R7 when Adr="00111" else
			R8 when Adr="01000" else
			R9 when Adr="01001" else
			R10 when Adr="01010" else
		   R11 when Adr="01011" else			
			R12 when Adr="01100" else
			R13 when Adr="01101" else
			R14 when Adr="01110" else			
			R15 when Adr="01111" else			
			R16 when Adr="10000" else			
			R17 when Adr="10001" else
			R18 when Adr="10010" else
			R18 when Adr="10011" else
			R20 when Adr="10100" else
			R21 when Adr="10101" else
			R22 when Adr="10110" else
			R23 when Adr="10111" else
			R24 when Adr="11000" else
			R25 when Adr="11001" else
			R26 when Adr="11010" else
			R27 when Adr="11011" else
			R28 when Adr="11100" else
			R29 when Adr="11101" else
			R30 when Adr="11110" else
			R31;
			
  Outp <= tmp;

end Behavioral;

