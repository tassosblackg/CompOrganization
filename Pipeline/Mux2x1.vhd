----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:34 03/17/2015 
-- Design Name: 
-- Module Name:    Mux2x1 - Behavioral 
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

entity Mux2x1 is
    Port ( input0 : in  STD_LOGIC_vector(31 downto 0);
           input1 : in  STD_LOGIC_vector(31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_vector(31 downto 0));
end Mux2x1;

architecture Behavioral of Mux2x1 is

begin

with sel select 
output <= input0 when '0',
input1 when others;

end Behavioral;

