----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:33 04/02/2016 
-- Design Name: 
-- Module Name:    AFTER_RFBMUX_Mux - Behavioral 
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

entity AFTER_RFBMUX_Mux is
    Port ( EarlierMuxOut : in  STD_LOGIC_VECTOR (31 downto 0);
           MemOut : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end AFTER_RFBMUX_Mux;

architecture Behavioral of AFTER_RFBMUX_Mux is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= EarlierMuxOut when (sel="00") else
	    MemOut when (sel="01") else
		 "00000000000000000000000000000100";-------------"10"

Output<=tmp;

end Behavioral;
