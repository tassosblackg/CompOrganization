----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:01:41 04/02/2016 
-- Design Name: 
-- Module Name:    RF_A_ALU_MUX - Behavioral 
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

entity RF_A_ALU_MUX is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           b_n_e_mem : in  STD_LOGIC_VECTOR (31 downto 0);
           b_p_mem : in  STD_LOGIC_VECTOR (31 downto 0);
           b_e_r_mem : in  STD_LOGIC_VECTOR (31 downto 0);
           selmux : in  STD_LOGIC_VECTOR (2 downto 0);
           outmux : out  STD_LOGIC_VECTOR (31 downto 0));
end RF_A_ALU_MUX;

architecture Behavioral of RF_A_ALU_MUX is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= "00000000000000000000000000000000" when (selmux="000") else
       RF_A when (selmux="001") else
	    b_n_e_mem when (selmux="010") else
		 b_p_mem when (selmux="011") else
		 b_e_r_mem;-----------"100"

outmux<=tmp;


end Behavioral;

