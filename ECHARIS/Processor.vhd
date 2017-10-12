----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:04 03/22/2016 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
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

entity Processor is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  Ovf: out STD_LOGIC;
			  Cout:out STD_LOGIC);
end Processor;

architecture Behavioral of Processor is
component ControlFSM is
 Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  
			  ALUf: in STD_LOGIC_VECTOR(3 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
			  
			  Zero : in STD_LOGIC;
			  
			  -------------REGs enables---------
			  RgAen : out STD_LOGIC;
			  RgBen : out STD_LOGIC;
			  RgAluOen : out STD_LOGIC;
			  RgMEMen : out STD_LOGIC;
			  ------------IFs------------------
			  
           PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
			  ----------DECs------------------
           RF_B_sel : out  STD_LOGIC;
			  RF_Wen : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           ZerOSign : out  STD_LOGIC;
           Shft2 : out  STD_LOGIC;
           Shft16 : out  STD_LOGIC;
			  
           ALU_Bin_sel : out  STD_LOGIC;
			  -----
			  SbOrSw : out STD_LOGIC;
			  LbOrLw : out STD_LOGIC; 
			  ------
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : out  STD_LOGIC;
			  --------all other new command selects
			  
			  BuM  : out  STD_LOGIC_VECTOR (2 downto 0);-----b_p_mem select in bytescheck
			  ALU_Bin_sel2 : out  STD_LOGIC_VECTOR (1 downto 0);------------------------------Mux after rfb mux in ALU
			  Mux_MEM_sel : out  STD_LOGIC_VECTOR (1 downto 0);-------------------------------After ALU new Mux for b_n_e_mem
			  IFmSel : out  STD_LOGIC;--------------------------------------------------Before IFSTAGE mux for b_e_r_mem
			  RgM1en : out  STD_LOGIC;--------write enable reg1 for byte_pack_mem after byteload
			  RgM2en : out  STD_LOGIC;--------2
			  RgM3en : out  STD_LOGIC;--------3
			  RgM4en : out  STD_LOGIC;--------4
			  RgMEMen2 : out  STD_LOGIC;--------------after MEM reg
			  
			  --------Cmov
		    ALU_A_sel : out STD_LOGIC_VECTOR (2 downto 0);
		    RF_WrData_sel2 : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component TopLab2 is
Port ( ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           PC_sel : in  STD_LOGIC;
			  WrEn : in  STD_LOGIC;----------+RegFILE
			  ZerOSign : in  STD_LOGIC;---------------/
	        Shft2 : in  STD_LOGIC;-----------------/Extender
			  Shft16 : in  STD_LOGIC;---------------/
			  Zero : out std_logic;-------|
		     Ovf : out std_logic;--------|ALUSTAGE
		     Cout : out std_logic;-------|
			  WErAluO : in  STD_LOGIC;-------------\
			  WErMem : in  STD_LOGIC;--------------\REGISTERS
			  WErA : in  STD_LOGIC;---------------\
			  WErB : in  STD_LOGIC;----------------\
			  Ssel : in  STD_LOGIC;------=new component for StoreByte
			  Lsel : in  STD_LOGIC;------=new component for LoadByte
           PC_LdEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Aluf : out std_logic_vector(3 downto 0);
			  Opcode : out std_logic_vector (5 downto 0);
           Mem_WrEn : in  STD_LOGIC;-------#MEMSTAGE
			  BUM  : in  STD_LOGIC_VECTOR (2 downto 0);-----b_p_mem select in bytescheck
			  SELMUX : in  STD_LOGIC_VECTOR (1 downto 0);------------------------------Mux Down of RegFile
			  SELMUX1 : in  STD_LOGIC_VECTOR (2 downto 0);-----------------------------Before ALU,After RegRFA  MUX
			  MUXSEL : in  STD_LOGIC_VECTOR (1 downto 0);------------------------------Mux after rfb mux in ALU
			  AOSEL : in  STD_LOGIC_VECTOR (1 downto 0);-------------------------------After ALU new Mux for b_n_e_mem
			  IFMSEL : in  STD_LOGIC;--------------------------------------------------Before IFSTAGE mux for b_e_r_mem
			  WEN1 : in  STD_LOGIC;--------write enable reg1 for byte_pack_mem after byteload
			  WEN2 : in  STD_LOGIC;--------2
			  WEN3 : in  STD_LOGIC;--------3
			  WEN4 : in  STD_LOGIC;--------4
			  WENM : in  STD_LOGIC);-------------------after MEM reg
end component;

-------------------------signals---------------------------------------
signal Zers,sRGA,sRGB,sRGALU,sRGMem,sPCsel,sPCld,sRFBsel,sRFwe,sRFwd,sZorS,sShft2,sShft16,
sALUBsel,sSborSw,sLborLw,sMEMen : STD_LOGIC;
signal sALUAsel:STD_LOGIC_VECTOR(2 downto 0) ;--cmov
signal sRFDsel2:STD_LOGIC_VECTOR(1 downto 0) ;--cmov
signal Alfunc,sAlufo :STD_LOGIC_VECTOR(3 downto 0) ;
signal Ops :STD_LOGIC_VECTOR(5 downto 0) ;
signal B  :   STD_LOGIC_VECTOR (2 downto 0);-----b_p_mem select in bytescheck
signal  A2 :   STD_LOGIC_VECTOR (1 downto 0);------------------------------Mux after rfb mux in ALU
signal  Mu :   STD_LOGIC_VECTOR (1 downto 0);-------------------------------After ALU new Mux for b_n_e_mem
signal  I :   STD_LOGIC;--------------------------------------------------Before IFSTAGE mux for b_e_r_mem
signal  R1en :   STD_LOGIC;--------write enable reg1 for byte_pack_mem after byteload
signal	  R2en :   STD_LOGIC;--------2
signal	  R3en :   STD_LOGIC;--------3
signal	  R4en :  STD_LOGIC;--------4
signal	  R :   STD_LOGIC;--------------a

-------------------------------------------------------------------

begin
Control:ControlFSM
Port map(
          ---inputs-----
           CLK =>CLK,
           RST =>RST,
			  
			  ALUf =>Alfunc,
           Opcode =>Ops,			  
			  Zero =>Zers, 
			  -------------REGs enables---------
			  RgAen =>sRGA,
			  RgBen =>sRGB,
			  RgAluOen =>sRGALU,
			  RgMEMen =>sRGMem,
			  ------------IFs------------------
			  PC_sel =>sPCsel,
           PC_LdEn =>sPCld,
			  ----------DECs------------------
           RF_B_sel =>sRFBsel,
			  RF_Wen =>sRFwe,
           RF_WrData_sel =>sRFwd,
           ZerOSign =>sZorS,
           Shft2 =>sShft2,
           Shft16 =>sShft16,
			  
           ALU_Bin_sel =>sALUBsel,
			  -----
			  SbOrSw =>sSbOrSw,
			  LbOrLw =>sLbOrLw,
			  ------
           ALU_func =>sAlufo,
           MEM_WrEn =>sMEMen,
			  --------all other new command selects
			   
			  BuM=>B,
			  ALU_Bin_sel2=>A2,
			  Mux_MEM_sel=>Mu,
			  IFmSel=>I,--------------------------------------------------Before IFSTAGE mux for b_e_r_mem
			  RgM1en=>R1en,--------write enable reg1 for byte_pack_mem after byteload
			  RgM2en=>R2en,--------2
			  RgM3en=>R3en,--------3
			  RgM4en=>R4en,--------4
			  RgMEMen2=>R,--------------after MEM reg
			  
			  --Cmov
			  ALU_A_sel=>sALUAsel,
			  RF_WrData_sel2 =>sRFDsel2
			  );
---

DatP:TopLab2
Port map ( ALU_Bin_sel =>sALUBsel,
           ALU_func =>sAlufo ,
           RF_WrData_sel => sRFwd,
           RF_B_sel =>sRFBsel ,
           PC_sel =>sPCsel ,
			  WrEn =>sRFwe ,----------+RegFILE
			  ZerOSign =>sZOrS ,---------------/
	        Shft2 => sShft2,-----------------/Extender
			  Shft16 => sShft16,---------------/
			  Zero =>Zers ,-------|
		     Ovf =>Ovf ,--------|ALUSTAGE
		     Cout =>Cout ,-------|
			  WErAluO => sRGALU,-------------\
			  WErMem => sRGMEM,--------------\REGISTERS
			  WErA => sRGA,---------------\
			  WErB => SRGB,----------------\
			  Ssel => sSbOrSw,------=new component for StoreByte
			  Lsel => sLbOrLw,------=new component for LoadByte
           PC_LdEn =>sPCld ,
           Clk => CLK,
           Reset =>RST ,
			  Aluf=>Alfunc,
			  Opcode=>Ops,
           Mem_WrEn =>sMEMen,
			  --------all other new command selects
		  
			  BUM=>B,-----b_p_mem select in bytescheck
			  MUXSEL=>A2,----------------Mux after rfb mux in ALU
			  AOSEL=>Mu,-----------------After ALU new Mux for b_n_e_mem
			  IFMSEL=>I,----------------Before IFSTAGE mux for b_e_r_mem
			  WEN1=>R1en,--------write enable reg1 for byte_pack_mem after byteload
			  WEN2=>R2en,--------2
			  WEN3=>R3en,--------3
			  WEN4=>R4en,--------4
			  WENM=>R,------------after MEM reg
			  
			  --Cmov
			  SELMUX=>sRFDsel2,
			  SELMUX1=>sALUAsel);

end Behavioral;

