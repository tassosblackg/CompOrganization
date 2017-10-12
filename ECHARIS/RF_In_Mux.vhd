----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:17 04/02/2016 
-- Design Name: 
-- Module Name:    RF_In_Mux - Behavioral 
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

entity RF_In_Mux is
    Port ( Mux_out : in  STD_LOGIC_VECTOR (31 downto 0);
           b_p_mem_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end RF_In_Mux;

architecture Behavioral of RF_In_Mux is

signal tmp :STD_LOGIC_VECTOR(31 downto 0);

begin

tmp <= Mux_out when (sel="00") else
	    b_p_mem_out when (sel="01") else
		 RF_A;-----------"10"

Outp<=tmp;

end Behavioral;

