----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:51:17 03/06/2016 
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
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           Muxout : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal result : STD_LOGIC_VECTOR (31 downto 0);
signal MsbXorLsb : STD_LOGIC;

begin

  result <=     (RF_A+Muxout) when ALU_func="0000" else --ADD
	             (RF_A-Muxout) when ALU_func="0001" else --SUB
					 (RF_A and Muxout) when ALU_func="0010" else --AND
					 (RF_A or Muxout) when ALU_func="0011" else --OR
					 (not RF_A) when ALU_func="0100" else --NOT--reverse
					 (RF_A(31) & RF_A(31 downto 1) ) when ALU_func="1010" else --Arithmetic Rshift
                ('0' & RF_A(31 downto 1) ) when ALU_func="1000" else --Logic Rshift
					 (RF_A(30 downto 0) & '0') when ALU_func="1001" else --Logic Lshift
					 (RF_A(30 downto 0) & RF_A(31)) when ALU_func="1101" else -- Cyclic Rshift
					 (RF_A(0) & RF_A(31 downto 1) ) when ALU_func="1100" else --Cyclic Lshift
					 (Muxout) when ALU_func="1111" else
					 ( (Muxout(31 downto 24) + RF_A(31 downto 24)) & (Muxout(23 downto 16) + RF_A(23 downto 16)) & ( Muxout(15 downto 8) + RF_A(15 downto 8)) & (Muxout(7 downto 0) + RF_A(7 downto 0)) )when ALU_func="1110" else--add_MMX_byte
  result;
  
  ALU_out<=result;
  
  Zero <= '1' when result=0 else '0';
	 
	 
	 MsbXorLsb <= RF_A(31) xor Muxout(31);
	 	 
	 Ovf<= ( RF_A(31)xor result(31) ) when MsbXorLsb='0' else
	        '0';
	 Cout <= RF_A(31) when MsbXorLsb= '0' else
	         (not result(31));
					 

end Behavioral;

