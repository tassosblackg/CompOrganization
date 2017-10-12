----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:05:30 03/06/2016 
-- Design Name: 
-- Module Name:    Extender - Behavioral 
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

entity Extender is
    Port ( ZerOSign : in  STD_LOGIC;--zero-fill or sign ext
	        Shft2 : in  STD_LOGIC;--multiply 4 times --branch
			  Shft16 : in  STD_LOGIC;--lui
	        Instr : in std_logic_vector(15 downto 0); 
			  Immed : out std_logic_vector(31 downto 0) );
end Extender;

architecture Behavioral of Extender is

signal y :STD_LOGIC;
signal s_out,s_out2:std_logic_vector(31 downto 0);

begin

y<= Instr(15) and ZerOSign; --'0' or '1' --zero-fill --signedExtent

s_out(15 downto 0)<=Instr;--copy first 16bits
s_out(31 downto 16) <=(31 downto 16 =>y);--create the msb 16 msb

--branch
s_out2<=(s_out(29 downto 0)&"00") when (Shft2='1' and Shft16='0') else 
         --lui
         (s_out(15 downto 0)&"0000000000000000") when (Shft16='1' and Shft2='0') else s_out;

Immed<=s_out2;--output

end Behavioral;

