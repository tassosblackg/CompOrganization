----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:14:16 03/05/2015 
-- Design Name: 
-- Module Name:    Decoder5x32 - Behavioral 
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

entity Decoder5x32 is
    Port ( input : in  STD_LOGIC_VECTOR(4 downto 0);
	 
           output : out  STD_LOGIC_VECTOR(31 downto 0));
end Decoder5x32;

architecture Behavioral of Decoder5x32 is

begin
                                                                     --register number
output <=     "00000000000000000000000000000001" when input = "00000" else --0
			
"00000000000000000000000000000010" when input = "00001" else --1
"00000000000000000000000000000100" when input = "00010" else --2
"00000000000000000000000000001000" when input = "00011" else --3
"00000000000000000000000000010000" when input = "00100" else --4
"00000000000000000000000000100000" when input = "00101" else --5
"00000000000000000000000001000000" when input = "00110" else --6
"00000000000000000000000010000000" when input = "00111" else --7
"00000000000000000000000100000000" when input = "01000" else --8
"00000000000000000000001000000000" when input = "01001" else --9
"00000000000000000000010000000000" when input = "01010" else --10
"00000000000000000000100000000000" when input = "01011" else --11
"00000000000000000001000000000000" when input = "01100" else --12
"00000000000000000010000000000000" when input = "01101" else --13
"00000000000000000100000000000000" when input = "01110" else --14
"00000000000000001000000000000000" when input = "01111" else --15
"00000000000000010000000000000000" when input = "10000" else --16
"00000000000000100000000000000000" when input = "10001" else --17
"00000000000001000000000000000000" when input = "10010" else --18
"00000000000010000000000000000000" when input = "10011" else --19
"00000000000100000000000000000000" when input = "10100" else --20
"00000000001000000000000000000000" when input = "10101" else --21
"00000000010000000000000000000000" when input = "10110" else --22
"00000000100000000000000000000000" when input = "10111" else --23
"00000001000000000000000000000000" when input = "11000" else --24
"00000010000000000000000000000000" when input = "11001" else --25
"00000100000000000000000000000000" when input = "11010" else --26
"00001000000000000000000000000000" when input = "11011" else --27
"00010000000000000000000000000000" when input = "11100" else --28
"00100000000000000000000000000000" when input = "11101" else --29
"01000000000000000000000000000000" when input = "11110" else --30
"10000000000000000000000000000000" when input = "11111";--31 

end Behavioral;