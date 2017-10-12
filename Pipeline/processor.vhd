----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:01:02 04/01/2015 
-- Design Name: 
-- Module Name:    processor - Behavioral 
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

entity processor is
    Port ( Clock : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end processor;

architecture Behavioral of processor is

component datapath is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
			  RF_WrEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
			  Registers_LdEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR(3 downto 0);
           MEM_WrEn : in  STD_LOGIC;
			  MEM_DataIn_Sel : in STD_LOGIC;
			  ALU_zero : out STD_LOGIC;
			  IF_Instr : out STD_LOGIC_vector(31 downto 0));
end component;



begin

--ousiastika, ola ta shmata erxontai apo to ena component kai pane sto alo, ektos apo to Instr to opoio dinei mono ta merh tou pou xrhsimopoiei to CONTROL, opcode kai func
DatapathUnit: datapath 
port map
(Clk=>Clock, 
Reset=>Rst,
PC_Sel=>'0',
PC_LdEn=>'0',
RF_B_sel=>'0',
RF_WrEn=>'0',
Registers_LdEn=>'1',
RF_WrData_sel=>'0',
ALU_Bin_sel=>'0', 
ALU_func=>"0000",
MEM_WrEn=>'0',
MEM_DataIn_Sel=>'0');


end Behavioral;

