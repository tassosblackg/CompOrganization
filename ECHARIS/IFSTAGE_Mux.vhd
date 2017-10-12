----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:32:23 04/02/2016 
-- Design Name: 
-- Module Name:    IFSTAGE_Mux - Behavioral 
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

entity IFSTAGE_Mux is
    Port ( Rs : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC);
end IFSTAGE_Mux;

architecture Behavioral of IFSTAGE_Mux is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= Rs when (sel='0') else
	    Immed when (sel='1');

Output<=tmp;

end Behavioral;

