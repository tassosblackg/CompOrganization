----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:40 03/17/2015 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_vector(31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_vector(31 downto 0);
           MEM_out : in  STD_LOGIC_vector(31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  AWR : in  STD_LOGIC_vector(4 downto 0);
           Immed : out  STD_LOGIC_vector(31 downto 0);
           RF_A : out  STD_LOGIC_vector(31 downto 0);
           RF_B : out STD_LOGIC_vector(31 downto 0)
			  
	  
			  );
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           mDout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           mDout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end component;

component Mux2x1 is
    Port ( input0 : in  STD_LOGIC_vector(31 downto 0);
           input1 : in  STD_LOGIC_vector(31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_vector(31 downto 0));
end component;




signal readRegAddress2:STD_LOGIC_VECTOR (4 downto 0):=(others=>'0');
signal writeData,tempImmed:STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');


begin
--metatropi toy immed se 32bits
with Instr(31 downto 26) select 
--SignExtend
tempImmed <= sxt(Instr(15 downto 0), 32) when "111000",
sxt(Instr(15 downto 0), 32) when "110000",
sxt(Instr(15 downto 0), 32) when "000011",
sxt(Instr(15 downto 0), 32) when "000111",
sxt(Instr(15 downto 0), 32) when "001111",
sxt(Instr(15 downto 0), 32) when "011111",
--SignExtend and shift
sxt(Instr(15 downto 0), 32)(29 downto 0)&"00" when "111111",
sxt(Instr(15 downto 0), 32)(29 downto 0)&"00" when "000000",
sxt(Instr(15 downto 0), 32)(29 downto 0)&"00" when "000001",
--Imm<<16(zero-fill)
sxt(Instr(15 downto 0), 32) (15 downto 0)&"0000000000000000" when "111001",
--Zerofill
"0000000000000000"&Instr(15 downto 0) when "110010",
"0000000000000000"&Instr(15 downto 0) when "110011",
(others=>'0') when others;


Immed<=tempImmed;


--polyplektis prin tin eisodo ReadRegister2
with RF_B_sel select 
readRegAddress2 <= Instr(15 downto 11) when '0',
Instr(20 downto 16) when others;

MuxForWriteData:Mux2x1 
port map
(  input0=>ALU_out,
   input1=>MEM_out,
   sel=>RF_WrData_sel,
   output=>writeData);


RegisterFile:RF 
port map
(  Ard1=>Instr(25 downto 21),
   Ard2=>readRegAddress2,
   Awr=>AWR,
   mDout1=>RF_A,
   mDout2=>RF_B,
   Din=>writeData,
   Clk=>Clk,
   WrEn=>RF_WrEn );



end Behavioral;

