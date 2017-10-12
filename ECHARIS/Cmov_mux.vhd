----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:27:17 04/03/2016 
-- Design Name: 
-- Module Name:    Cmov_mux - Behavioral 
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

entity Cmov_mux is
    Port ( muxout : in  STD_LOGIC_VECTOR (31 downto 0);
           RFA : in  STD_LOGIC_VECTOR (31 downto 0);
           selmux : in  STD_LOGIC;
           outmux : out  STD_LOGIC_VECTOR (31 downto 0));
end Cmov_mux;

architecture Behavioral of Cmov_mux is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= muxout when (selmux='0') else
	    RFA ;

outmux<=tmp;

end Behavioral;
