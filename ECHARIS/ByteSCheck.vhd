----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:04:29 03/20/2016 
-- Design Name: 
-- Module Name:    ByteSCheck - Behavioral 
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

entity ByteSCheck is
    Port ( sinp : in  STD_LOGIC_VECTOR (31 downto 0);
           sout : out  STD_LOGIC_VECTOR (31 downto 0);
			  bum  : in  STD_LOGIC_VECTOR (2 downto 0);-----b_p_mem
           ssel : in  STD_LOGIC);
end ByteSCheck;

architecture Behavioral of ByteSCheck is

signal r : STD_LOGIC_VECTOR (31 downto 0);
signal y :STD_LOGIC;

begin
process(sinp,bum,ssel) is
begin

if (bum="001") then

r<=sinp;
y<= r(7) and '0';
r(31 downto 8) <=(31 downto 8 =>y);

elsif (bum="010") then

r<="00000000" & sinp(31 downto 8);
y<= r(7) and '0';
r(31 downto 8) <=(31 downto 8 =>y);

elsif (bum="011") then

r<="0000000000000000" & sinp(31 downto 16);
y<= r(7) and '0';
r(31 downto 8) <=(31 downto 8 =>y);

elsif (bum="100") then

r<="000000000000000000000000" & sinp(31 downto 24);
y<= r(7) and '0';
r(31 downto 8) <=(31 downto 8 =>y);

else

     if (ssel='1') then
             r<=         ("000000000000000000000000" & sinp(7 downto 0)) ;
	 else
            r<=(sinp) ;
	 end if;
				
end if;

end process;

sout<=r;


end Behavioral;

