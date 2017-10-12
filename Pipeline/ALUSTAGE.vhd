----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:58 03/18/2015 
-- Design Name: 
-- Module Name:    ALUSTAGE - Behavioral 
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

entity ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  zero: out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is

signal Bin: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

component ALU is
 Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
        B : in  STD_LOGIC_VECTOR(31 downto 0);
		  OP: in STD_LOGIC_VECTOR(3 downto 0) ;
		  Output : out  STD_LOGIC_VECTOR(31 downto 0);
		  Zero : out STD_LOGIC;
		  Cout : out STD_LOGIC;
		  Ovf :out STD_LOGIC);
end component;

begin

Bin <= Immed when ALU_Bin_sel='1' else RF_B;

ALUunit: ALU 
port map
(  A=>RF_A,
   B=>Bin,
   OP=>ALU_func,
   Output=>ALU_out,
   zero=>zero);


end Behavioral;

