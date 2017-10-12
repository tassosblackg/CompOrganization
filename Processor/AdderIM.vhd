----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:14 03/05/2016 
-- Design Name: 
-- Module Name:    AdderIM - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AdderIM is
    Port ( Inp : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_im : in  STD_LOGIC_VECTOR (31 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end AdderIM;

architecture Behavioral of AdderIM is

signal result,shl2 :STD_LOGIC_VECTOR(31 downto 0);

begin

result<=(Inp + PC_im );

Outp<=result;

end Behavioral;

