----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:20:40 04/01/2015 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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

entity datapath is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
			  Registers_LdEn : in  STD_LOGIC;
			  RF_WrEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR(3 downto 0);
           MEM_WrEn : in  STD_LOGIC;
			  MEM_DataIn_Sel : in STD_LOGIC;
			  ALU_zero : out STD_LOGIC;
			  IF_Instr : out STD_LOGIC_vector(31 downto 0));
end datapath;

architecture Behavioral of datapath is

component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  zero : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_vector(31 downto 0);
           RF_WrEn : in  STD_LOGIC;
			  AWR : in  STD_LOGIC_vector(4 downto 0);
           ALU_out : in  STD_LOGIC_vector(31 downto 0);
           MEM_out : in  STD_LOGIC_vector(31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_vector(31 downto 0);
           RF_A : out  STD_LOGIC_vector(31 downto 0);
           RF_B : out STD_LOGIC_vector(31 downto 0)
			  
			  );
end component;

component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_vector(31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_vector(31 downto 0));
end component;

component MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Register32 is
   Port ( dataIn : in  STD_LOGIC_vector(31 downto 0);
           LoadEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_vector(31 downto 0));
end component;

component CONTROL is
    Port ( Instr : in STD_LOGIC_VECTOR(31 downto 0);
    	     control_output: out  STD_LOGIC_VECTOR(31 downto 0)
			 );
end component;

component Register5 is
   Port ( dataIn : in  STD_LOGIC_vector(4 downto 0);
           LoadEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_vector(4 downto 0));
end component;

component Mux4x1 is
    Port ( input0 : in  STD_LOGIC_vector(31 downto 0);
           input1 : in  STD_LOGIC_vector(31 downto 0);
			  input2 : in  STD_LOGIC_vector(31 downto 0);
			  input3 : in  STD_LOGIC_vector(31 downto 0);
           sel : in   STD_LOGIC_vector(1 downto 0);
           output : out  STD_LOGIC_vector(31 downto 0));
end component;

component Mux2x1 is
    Port ( input0 : in  STD_LOGIC_vector(31 downto 0);
           input1 : in  STD_LOGIC_vector(31 downto 0);
			  sel : in   STD_LOGIC;
           output : out  STD_LOGIC_vector(31 downto 0));
end component;


component Forward is
    Port ( RS_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           RT_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_FROM_ALU : in  STD_LOGIC_VECTOR (4 downto 0);
           RD_FROM_MEM : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_WR_EN : in  STD_LOGIC;
			  OPCODE : in  STD_LOGIC_VECTOR (5 downto 0);
			  NEXT_OPCODE : in  STD_LOGIC_VECTOR (5 downto 0);
           SEL_A_B : out  STD_LOGIC_VECTOR (3 downto 0) --SEL_A_B(1 downto 0) gia A,SEL_A_B(3 downto 2)gia B
           );
end component;




signal InstructionRegisterOut,B_SELECT_OUT,A_SELECT_OUT,RFB_RegisterOut,ImmedRegisterOut,
AluRegisterOut1,AluRegisterOut2,ControlRegisterAOut,ControlRegisterBOut,ControlRegisterCOut,tempControlOut,
DEC_MEM_out,A_from_Register,B_from_Register,Dec_Immed,tempIf_Instr,ALU_output,
MEM_output,Dec_RF_A,Dec_RF_B,MEM_in:STD_LOGIC_vector(31 downto 0):=(others=>'0');
signal RS_REGISTEROut,RT_REGISTEROut,RD_REGISTER3Out,RD_REGISTER2Out,RD_REGISTER1Out:STD_LOGIC_vector(4 downto 0):=(others=>'0');

signal SEL_A_B_temp:STD_LOGIC_vector(3 downto 0):=(others=>'0');
signal SEL_NORMAL_OR_NOP:STD_LOGIC:='0';
begin


--Sthn periptwsh tou lb xreiazetai zerofill sthn eksodo tou MEM
DEC_MEM_out<="000000000000000000000000"&MEM_output(7 downto 0) when ControlRegisterCOut(10)='1' else MEM_output;


--To MEM_in xrhsimopoieitai gia sb kai sw. Gia sw pairnoume ton kataxwrhth rd (RF_B) opws einai, alla gia sb pairnoume mono ta prwta 8 bit kai kanoume zerofill
MEM_in<=RFB_RegisterOut when ControlRegisterBOut(9) = '0' 
         else "000000000000000000000000"&Dec_RF_B(7 downto 0);

ALU: ALUSTAGE 
port map  (                                         --pairnei to b sel kai to func apo ton prwto register tou control
             RF_A=>A_SELECT_OUT, 
             RF_B=>B_SELECT_OUT, 
             Immed=>ImmedRegisterOut, 
             ALU_Bin_sel=>ControlRegisterAOut(3),
             ALU_func=>ControlRegisterAOut(7 downto 4), 
             zero=>ALU_zero, 
             ALU_out=>ALU_output);

Decode: DECSTAGE 
port map(  Instr=>tempIf_Instr,
           AWR=>RD_REGISTER3Out, 
           RF_WrEn=>ControlRegisterCOut(11), 
           ALU_out=>AluRegisterOut2, 
           MEM_out=>DEC_MEM_out, 
           RF_WrData_sel=>ControlRegisterCOut(12), 
           RF_B_sel=>tempControlOut(2),
           Clk=>Clk, 
			  Immed=>Dec_Immed, 
           RF_A=>Dec_RF_A, 
           RF_B=>Dec_RF_B);

RegisterForA: Register32 
port map
(     dataIn=>Dec_RF_A,
      LoadEn=>'1',
      clk=>Clk,
      reset=>Reset,
      dataOut=>A_from_Register);

RegisterForB: Register32 
port map(    dataIn=>Dec_RF_B,
             LoadEn =>'1',
             clk=>Clk,
             reset=>Reset,
             dataOut=>B_from_Register);

Instruction: IFSTAGE 
port map
(   PC_Immed=>Dec_Immed, 
    PC_sel=>tempControlOut(0), 
    PC_LdEn=>tempControlOut(1), 
    Reset=>Reset, 
    Clk=>Clk, 
    Instr=>tempIf_Instr);

Memory: MEMSTAGE 
port map
(    clk=>Clk, 
     Mem_WrEn=>ControlRegisterBOut(8), 
     ALU_MEM_Addr=>AluRegisterOut1, 
     MEM_DataIn=>MEM_in, 
     MEM_DataOut=>MEM_output);

--control kai regiters gia to contol
CONTROL_Module: CONTROL 
port map
(  Instr=>tempIf_Instr,
   control_output=>tempControlOut);

ControlRegisterA: Register32 
port map
(   dataIn=>tempControlOut,
     LoadEn=>'1',
     clk=>Clk,
   reset=>Reset,
   dataOut=>ControlRegisterAOut);

ControlRegisterB: Register32 
port map
(dataIn=>ControlRegisterAOut,
LoadEn=>'1',
clk=>Clk,
reset=>Reset,
dataOut=>ControlRegisterBOut);

ControlRegisterC: Register32 port map
(   dataIn=>ControlRegisterBOut,
    LoadEn=>'1',
    clk=>Clk,
    reset=>Reset,
    dataOut=>ControlRegisterCOut);

--krataei tin ekswdo tis ALU
ALU_OUT_REGISTER1: Register32 
port map
(   dataIn=>ALU_output,
    LoadEn=>'1',
    clk=>Clk,
    reset=>Reset,
    dataOut=>AluRegisterOut1);

ALU_OUT_REGISTER2: Register32 
port map
(   dataIn=>AluRegisterOut1,
    LoadEn=>'1',
    clk=>Clk,
    reset=>Reset,
    dataOut=>AluRegisterOut2);

--krataei to Immed
IMMED_REGISTER1: Register32 
port map
(  dataIn=>Dec_Immed,
   LoadEn=>'1',
   clk=>Clk,
   reset=>Reset,
   dataOut=>ImmedRegisterOut);

--krataei to RF_B gia na paei sto mem

RF_B_REGISTER: Register32 
port map
(  dataIn=>B_from_Register,
   LoadEn=>'1',
   clk=>Clk,
   reset=>Reset,
   dataOut=>RFB_RegisterOut);


--registers gia to RD
RD_REGISTER1: Register5 
port map
(  dataIn=>tempIf_Instr(20 downto 16),
   LoadEn=>'1',
   clk=>Clk,
   reset=>Reset,
   dataOut=>RD_REGISTER1Out);

RD_REGISTER2: Register5 
port map
( dataIn=>RD_REGISTER1Out,
  LoadEn=>'1',
  clk=>Clk,
  reset=>Reset,
  dataOut=>RD_REGISTER2Out);

RD_REGISTER3: Register5 port map
(  dataIn=>RD_REGISTER2Out,
   LoadEn=>'1',
   clk=>Clk,
   reset=>Reset,
   dataOut=>RD_REGISTER3Out);



--mux for ALU
--A from reg or ALU out
A_SELECT: Mux4x1 
port map
(  input0=>A_from_Register,
   input1=>AluRegisterOut1,
   input2=>AluRegisterOut2,
   input3=>DEC_MEM_out,
   sel=>SEL_A_B_temp(1 downto 0),
	output=>A_SELECT_OUT);
--B from reg or ALU out
B_SELECT: Mux4x1 
port map
(  input0=>B_from_Register,
   input1=>AluRegisterOut1,
   input2=>AluRegisterOut2,
   input3=>DEC_MEM_out,
   sel=>SEL_A_B_temp(3 downto 2),
   output=>B_SELECT_OUT);


--Registers for RS and RT
RS_REGISTER: Register5 
port map
( dataIn=>tempIf_Instr(25 downto 21),
  LoadEn=>'1',
  clk=>Clk,
  reset=>Reset,
  dataOut=>RS_REGISTEROut);

RT_REGISTER: Register5 
port map
(  dataIn=>tempIf_Instr(15 downto 11),
   LoadEn=>'1',
   clk=>Clk,
   reset=>Reset,
   dataOut=>RT_REGISTEROut);

--forward
FORWARD_MOD: Forward 
port map
(  NEXT_OPCODE=>ControlRegisterBOut(18 downto 13),
   OPCODE=>ControlRegisterAOut(18 downto 13),
   RS_IN =>RS_REGISTEROut,
   RT_IN=>RT_REGISTEROut,
   RD_FROM_ALU=>RD_REGISTER2Out,
   RD_FROM_MEM=>RD_REGISTER3Out,
   RF_WR_EN=>ControlRegisterBOut(11),
   SEL_A_B=>SEL_A_B_temp);



IF_Instr<=tempIf_Instr;
end Behavioral;

