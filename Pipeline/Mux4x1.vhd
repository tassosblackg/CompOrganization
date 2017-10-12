----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:46:50 05/21/2015 
-- Design Name: 
-- Module Name:    Mux4x1 - Behavioral 
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

entity Mux4x1 is
    Port ( input0 : in  STD_LOGIC_vector(31 downto 0);
           input1 : in  STD_LOGIC_vector(31 downto 0);
			  input2 : in  STD_LOGIC_vector(31 downto 0);
			  input3 : in  STD_LOGIC_vector(31 downto 0);
           sel : in   STD_LOGIC_vector(1 downto 0);
           output : out  STD_LOGIC_vector(31 downto 0));
end Mux4x1;

architecture Behavioral of Mux4x1 is

begin

with sel select 
output <= input0 when "00",
input1 when "01",
input2 when "10",
input3 when others;

end Behavioral;

