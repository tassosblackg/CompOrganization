----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:18:55 03/03/2015 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is

 Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
        B : in  STD_LOGIC_VECTOR(31 downto 0);
		  OP: in STD_LOGIC_VECTOR(3 downto 0) ;

	     Output : out  STD_LOGIC_VECTOR(31 downto 0);
		  Zero : out STD_LOGIC;
		  Cout : out STD_LOGIC;
		  Ovf :out STD_LOGIC
		 
		  
		  );


end ALU;

architecture Behavioral of ALU is

SIGNAL newB:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL temp: STD_LOGIC_VECTOR (31 downto 0);

begin

	


with OP select temp <=
	 (A+B) when "0000",--prosthesi
	 (A-B) when "0001",--afairesi	
	 A and B when "0010",--logiko kai	
	 A or B when "0011",--logiko H	
	 not A when "0100",--antistrofi tou A
	 A(31) & A(31 downto 1) when "1000",--arithmitiki olisthisi dexia kata 1 thesi
	 '0' & A(31 downto 1) when "1001",--logiki olisthisi dexia kata 1 thesi
	 A(30 downto 0) & '0' when "1010",--logiki olisthisi aristera kata 1 thesi
	 A(30 downto 0) & A(31) when "1100",--kukliko rotate aristera
	 A(0) & A(31 downto 1)  when "1101",--kukliko rotate dexia
	 (others=>'0') when others;
	 --eksodos kai carry out
	 Output<=temp(31 downto 0);
	 Cout<=A(31) AND B(31);
	 
	 --zero
	 zero <= '1' WHEN temp=0 ELSE '0';
	 
	 
	 --otan exoyme afaireisi to newB=-B
	 WITH OP select newB<=
	  B when "0000",
	  -B when "0001",
       B when others;
	 
	 --uperxilisi
	 WITH A(31) XOR newB(31) select
			Ovf<= A(31) xor temp(31) when '0',
					'0' when others;

	
end Behavioral;

