----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:33:50 04/03/2016 
-- Design Name: 
-- Module Name:    Cmov_mux1 - Behavioral 
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

entity Cmov_mux1 is
    Port ( RFA : in  STD_LOGIC_VECTOR (31 downto 0);
           selmux1 : in  STD_LOGIC;
           muxout1 : out  STD_LOGIC_VECTOR (31 downto 0));
end Cmov_mux1;

architecture Behavioral of Cmov_mux1 is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= "00000000000000000000000000000000" when (selmux1='1') else
       RFA ;

muxout1<=tmp;

end Behavioral;
