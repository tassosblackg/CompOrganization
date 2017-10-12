----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:12:58 03/07/2016 
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
		     Zero : out std_logic;
		     Ovf : out std_logic;
		     Cout : out std_logic;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is



component ALU is
Port(      rF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           muxout : in  STD_LOGIC_VECTOR (31 downto 0);
           aLU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           aLU_out : out  STD_LOGIC_VECTOR (31 downto 0);
		     zero : out  STD_LOGIC;
           cout : out  STD_LOGIC;
           ovf : out  STD_LOGIC);
end component;

component ALUMUX is
Port(      rF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           immed : in  STD_LOGIC_VECTOR (31 downto 0);
           aLU_Bin_sel : in  STD_LOGIC;
           MUXO : out  STD_LOGIC_VECTOR (31 downto 0));
		   
end component;


---------------------SIGNALS-----------------------
signal H: std_logic_vector(31 downto 0);
----------------------------------------------------

begin

M:ALUMUX 
port map
(   
    rF_B=>RF_B,
    immed=>Immed,
    aLU_Bin_sel=>ALU_Bin_sel,
	 MUXO=>H
);

A:ALU 
port map(  
            rF_A=>RF_A,
            muxout=>H,
            aLU_func=>ALU_func,
            aLU_out=>ALU_out,
	         zero=>Zero,
	         ovf=>Ovf,
	         cout=>Cout
);

end Behavioral;

