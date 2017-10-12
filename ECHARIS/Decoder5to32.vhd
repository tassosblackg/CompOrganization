----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:47:31 02/21/2016 
-- Design Name: 
-- Module Name:    Decoder5to32 - Behavioral 
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

entity Decoder5to32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder5to32;

architecture Behavioral of Decoder5to32 is

signal tmp : STD_LOGIC_VECTOR(31 downto 0);

begin

   tmp <= "00000000000000000000000000000000" when Awr="00000" else --Lsb=0 instead of '1'(in 32bit number)--R0
          "00000000000000000000000000000010" when Awr="00001" else --R1
			 "00000000000000000000000000000100" when Awr="00010" else --R2
			 "00000000000000000000000000001000" when Awr="00011" else --R3
			 "00000000000000000000000000010000" when Awr="00100" else --R4
			 "00000000000000000000000000100000" when Awr="00101" else --R5
			 "00000000000000000000000001000000" when Awr="00110" else --R6
			 "00000000000000000000000010000000" when Awr="00111" else --R7
			 "00000000000000000000000100000000" when Awr="01000" else --R8
			 "00000000000000000000001000000000" when Awr="01001" else --R9
			 "00000000000000000000010000000000" when Awr="01010" else --R10
			 "00000000000000000000100000000000" when Awr="01011" else --R11
			 "00000000000000000001000000000000" when Awr="01100" else --R12
			 "00000000000000000010000000000000" when Awr="01101" else --R13
			 "00000000000000000100000000000000" when Awr="01110" else --R14
			 "00000000000000001000000000000000" when Awr="01111" else --R15
			 "00000000000000010000000000000000" when Awr="10000" else --R16
			 "00000000000000100000000000000000" when Awr="10001" else --R17
			 "00000000000001000000000000000000" when Awr="10010" else --R18
			 "00000000000010000000000000000000" when Awr="10011" else --R19
			 "00000000000100000000000000000000" when Awr="10100" else --R20
			 "00000000001000000000000000000000" when Awr="10101" else --R21
			 "00000000010000000000000000000000" when Awr="10110" else --R22
			 "00000000100000000000000000000000" when Awr="10111" else --R23
			 "00000001000000000000000000000000" when Awr="11000" else --R24
			 "00000010000000000000000000000000" when Awr="11001" else --R25
			 "00000100000000000000000000000000" when Awr="11010" else --R26
			 "00001000000000000000000000000000" when Awr="11011" else --R27
			 "00010000000000000000000000000000" when Awr="11100" else --R28
			 "00100000000000000000000000000000" when Awr="11101" else --R29
			 "01000000000000000000000000000000" when Awr="11110" else --R30
			 "10000000000000000000000000000000" ; --R31
			 
			 
  Outp <= tmp;

end Behavioral;

