----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:49:05 03/07/2016 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
				 WrEn : in  STD_LOGIC;------------------/RegFILE
				 ZerOSign : in  STD_LOGIC;------------[
	          Shft2 : in  STD_LOGIC;-------------[Extender
			    Shft16 : in  STD_LOGIC;--------------[
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component DECMUX5 is
port(      Instr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Instr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rF_B_sel : in  STD_LOGIC;
           MOut5 : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component DECMUX32 is
port(      mEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           aLU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           rF_WrData_sel : in  STD_LOGIC;
           MOut32 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegFILE is
port(      Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           CLK : in  STD_LOGIC;
           wrEn : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Extender is
port(      zerOSign : in  STD_LOGIC;
	        shft2 : in  STD_LOGIC;
			  shft16 : in  STD_LOGIC;
	        instr : in std_logic_vector(15 downto 0); 
			  immed : out std_logic_vector(31 downto 0));
end component;

signal mux5:STD_LOGIC_VECTOR(4 downto 0);
signal mux32:STD_LOGIC_VECTOR(31 downto 0);

begin

RFile:RegFILE port map
(    Din=>mux32,
     Adr1=>Instr(25 downto 21),
     Adr2=>mux5,
     Awr=>Instr(20 downto 16),
     CLK=>Clk,
     wrEn=>WrEn,
     Dout1=>RF_A,
     Dout2=>RF_B
);

Ex:Extender port map
(    zerOSign=>ZerOSign,
	  shft2=>Shft2,
	  shft16=>Shft16,
	  instr=>Instr(15 downto 0), 
	  immed=>Immed
);

M32:DECMUX32 port map
(    mEM_out=>MEM_out,
     aLU_out=>ALU_out,
     rF_WrData_sel=>RF_WrData_sel,
     MOut32=>mux32
);  

M5:DECMUX5 port map
(     Instr1=>Instr(15 downto 11),
      Instr2=>Instr(20 downto 16),
      rF_B_sel=>RF_B_sel,
      MOut5=>mux5
);


end Behavioral;

