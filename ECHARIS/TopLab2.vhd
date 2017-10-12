----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:17 03/19/2016 
-- Design Name: 
-- Module Name:    TopLab2 - Behavioral 
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

entity TopLab2 is
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
end TopLab2;

architecture Behavioral of TopLab2 is

component ALUSTAGE is
Port(      RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           aLU_Bin_sel : in  STD_LOGIC;---------top
           aLU_func : in  STD_LOGIC_VECTOR (3 downto 0);--------
		     zero : out std_logic;--------
		     ovf : out std_logic;--------
		     cout : out std_logic;------
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  MSEL : in  STD_LOGIC_VECTOR (1 downto 0);-------------------new mux select
			  Mout :in  STD_LOGIC_VECTOR (31 downto 0));-------------exodos tis MEM
end component;

component DECSTAGE is
Port(      Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           rF_WrData_sel : in  STD_LOGIC;
           rF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  wrEn : in  STD_LOGIC;------------------/RegFILE
		  	  zerOSign : in  STD_LOGIC;------------[
	        shft2 : in  STD_LOGIC;-------------[Extender
			  shft16 : in  STD_LOGIC;--------------[
			     Selmux : in  STD_LOGIC_VECTOR (1 downto 0);------------------Mux Down of RegFile
				  RFAmux : in  STD_LOGIC_VECTOR (31 downto 0);----------------/
				  B_p_mem_out : in  STD_LOGIC_VECTOR (31 downto 0);----------/
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IFSTAGE is
Port(      clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pC_LdEn : in  STD_LOGIC;
           pC_sel : in  STD_LOGIC;
           PC_IM : in  STD_LOGIC_VECTOR (31 downto 0);
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Data_Mem is---or MEMSTAGE---
Port(      clk : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (9 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-------------------REGISTERS---------------------

component RegALUOut is
port(      inp : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WErAluO : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegMEM is
port(      Min : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WErMem : in  STD_LOGIC;
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegRFA is
port(      RFAOut : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WErA : in  STD_LOGIC;
           Dout3 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RegB_I is----or Reg for RF_B
port(      RFBOut : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WErB : in  STD_LOGIC;
           Dout4 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

----------------NEW COMPONENTS----------------

component ByteSCheck is-----before Data_Mem or MEMSTAGE
port(      sinp : in  STD_LOGIC_VECTOR (31 downto 0);
           sout : out  STD_LOGIC_VECTOR (31 downto 0);
			  bum  : in  STD_LOGIC_VECTOR (2 downto 0);-----b_p_mem
           ssel : in  STD_LOGIC);
end component;

component ByteLCheck is-----after Data_Mem or MEMSTAGE
port(      linp : in  STD_LOGIC_VECTOR (31 downto 0);
           lout : out  STD_LOGIC_VECTOR (31 downto 0);
           lsel : in  STD_LOGIC);
end component;

--------------------Before ALU,After RegRFA  MUX--------------------

component RF_A_ALU_MUX is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           b_n_e_mem : in  STD_LOGIC_VECTOR (31 downto 0);
           b_p_mem : in  STD_LOGIC_VECTOR (31 downto 0);
           b_e_r_mem : in  STD_LOGIC_VECTOR (31 downto 0);
           selmux : in  STD_LOGIC_VECTOR (2 downto 0);
           outmux : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--------------------------------------------------------------------

-------------------Mux for IfSTAGE b_e_r_mem------------------------

component IFSTAGE_Mux is
    Port ( Rs : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC);
end component;

--------------------------------------------------------------------

---------------------After ALU new Mux for b_n_e_mem----------------

component ALU_OUT_Mux is
    Port ( ALU_OUT : in  STD_LOGIC_VECTOR (31 downto 0);
           RS : in  STD_LOGIC_VECTOR (31 downto 0);
           RT : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0));
end component;

--------------------------------------------------------------------

-------------------NEW REGISTERS and Concatinator---------------------

component MEMR1 is
    Port ( Inp1 : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEn1 : in  STD_LOGIC;
           Outp1 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MEMR2 is
    Port ( Inp2 : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEn2 : in  STD_LOGIC;
           Outp2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MEMR3 is
    Port ( Inp3 : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEn3 : in  STD_LOGIC;
           Outp3 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MEMR4 is
    Port ( Inp4 : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEn4 : in  STD_LOGIC;
           Outp4 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Concatinator is
    Port ( in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           in2 : in  STD_LOGIC_VECTOR (31 downto 0);
           in3 : in  STD_LOGIC_VECTOR (31 downto 0);
           in4 : in  STD_LOGIC_VECTOR (31 downto 0);
           outconc : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-----------------------------------------------------------------------
----------------------After MEM reg------------------------------------

component AfterMEMReg is
   Port ( Inpm : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           WEnm : in  STD_LOGIC;
           Outpm : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-----------------------------------------------------------------------

--------------------SIGNALS-------------------------

signal RFAALU1:std_logic_vector(31 downto 0);
signal RFAALU2:std_logic_vector(31 downto 0);
signal RFAALU3:std_logic_vector(31 downto 0);
signal Im:std_logic_vector(31 downto 0);
signal RFBALU1:std_logic_vector(31 downto 0);
signal RFBALU2:std_logic_vector(31 downto 0);
signal RFBALU3:std_logic_vector(31 downto 0);
signal ALUOUT1:std_logic_vector(31 downto 0);
signal ALUOUT2:std_logic_vector(31 downto 0);
signal INSTRDEC:std_logic_vector(31 downto 0);
signal MEMOUT1:std_logic_vector(31 downto 0);
signal MEMOUT2:std_logic_vector(31 downto 0);
signal MEMOUT3:std_logic_vector(31 downto 0);
signal R1:std_logic_vector(31 downto 0);
signal R2:std_logic_vector(31 downto 0);
signal R3:std_logic_vector(31 downto 0);
signal R4:std_logic_vector(31 downto 0);
signal BPMEM:std_logic_vector(31 downto 0);
signal memreg:std_logic_vector(31 downto 0);
signal aloutm:std_logic_vector(31 downto 0);
signal Im1:std_logic_vector(31 downto 0);

----------------------------------------------------

begin


ALU:ALUSTAGE
port map
(      
           RF_A=>RFAALU3,
           RF_B=>RFBALU2,
           Immed=>Im,
           aLU_Bin_sel=>ALU_Bin_sel,--top
           aLU_func=>ALU_func,--
		     zero=>Zero,--
		     ovf=>Ovf,--
		     cout=>Cout,--
			  MSEL=>MUXSEL,-------------Mux after rfb mux in ALU
			  Mout=>MEMOUT1,-------------------nea eisodos gia ton neo mux mesa stin ALU
           ALU_out=>ALUOUT1
);

DEC:DECSTAGE
port map
(      
           Instr=>INSTRDEC,
           ALU_out(31 downto 0)=>ALUOUT2(31 downto 0),
           MEM_out=>MEMOUT2,
           rF_WrData_sel=>RF_WrData_sel,--top
           rF_B_sel=>RF_B_sel,--
           clk=>Clk,--
			  wrEn=>WrEn,--
			  zerOSign=>ZerOSign,--
	        shft2=>Shft2,--
			  shft16=>Shft16,--
           Immed=>Im,
			  Selmux=>SELMUX,----------------------------Mux Down of RegFile
			  RFAmux=>RFAALU2,--------------------------/
			  B_p_mem_out=>BPMEM,----------------------/
           RF_A=>RFAALU1,
           RF_B=>RFBALU1
);

IFS:IFSTAGE
port map
(      
           clk=>Clk,--top
           rst=>Reset,--
           pC_LdEn=>PC_LdEn,--
           pC_sel=>PC_sel,--
           PC_IM=>Im1,
           Instr=>INSTRDEC
			 
);
 ------***----------------------
 Opcode<=INSTRDEC(31 downto 26);
 Aluf<=INSTRDEC(3 downto 0);
 ---------------------------------------

MEM:Data_Mem----or MEMSTAGE----
port map
(      
           clk=>Clk,--top
           WE=>Mem_WrEn,--
           Addr=>aloutm(9 downto 0),
           Din=>RFBALU3,
           Dout=>MEMOUT1
);

--------------REGISTERS PORT MAP----------------

RgALUOut:RegALUOut
port map
(          inp=>ALUOUT1,
           clk=>Clk,
           WErAluO=>WErAluO,
           Dout1=>ALUOUT2
);

RgMEM:RegMEM
port map
(          Min=>MEMOUT1,
           clk=>Clk,
           WErMem=>WErMem,
           Dout2=>MEMOUT2
);


RgRFA:RegRFA
port map
(          RFAOut=>RFAALU1,
           clk=>Clk,
           WErA=>WErA,
           Dout3=>RFAALU2
);

RgB_I:RegB_I
port map
(          RFBOut=>RFBALU1,
           clk=>Clk,
           WErB=>WErB,
           Dout4=>RFBALU2
);

---------------------After ALU new Mux for b_n_e_mem----------------

ALU_OUT_Mux_portmap:ALU_OUT_Mux
port map ( 
           ALU_OUT=>ALUOUT2,
           RS=>RFAALU2,
           RT=>RFBALU2,
           Output=>aloutm,
           sel=>AOSEL
);


--------------------------------------------------------------------

--------------------Before ALU,After RegRFA  MUX--------------------

RF_A_ALU_MUX_portmap:RF_A_ALU_MUX
port map 
( 
           RF_A=>RFAALU2,
           b_n_e_mem=>memreg,
           b_p_mem=>ALUOUT2,
           b_e_r_mem=>MEMOUT2,
           selmux=>SELMUX1,
           outmux=>RFAALU3
);

--------------------------------------------------------------------

-------------------NEW REGISTERS and Concatinator---------------------

MEMR1_portmap:MEMR1
port map( 
           Inp1(31 downto 8)=>"000000000000000000000000",
			  Inp1(7 downto 0)=>MEMOUT3(7 downto 0),
           clk=>Clk,
           WEn1=>WEN1,
           Outp1=>R1
);


MEMR2_portmap:MEMR2
port map ( 
           Inp2(31 downto 8)=>"000000000000000000000000",
           Inp2(7 downto 0)=>MEMOUT3(7 downto 0),
           clk=>Clk,
           WEn2=>WEN2,
           Outp2=>R2
);


MEMR3_portmap:MEMR3
 port map( 
 Inp3(31 downto 8)=>"000000000000000000000000",
           Inp3(7 downto 0)=>MEMOUT3(7 downto 0),
           clk=>Clk,
           WEn3=>WEN3,
           Outp3=>R3
);


MEMR4_portmap:MEMR4
port map( 
Inp4(31 downto 8)=>"000000000000000000000000",
           Inp4(7 downto 0)=>MEMOUT3(7 downto 0),
           clk=>Clk,
           WEn4=>WEN4,
           Outp4=>R4
);


Concatinator_portmap:Concatinator
port map( 
           in1=>R1,
           in2=>R2,
           in3=>R3,
           in4=>R4,
           outconc=>BPMEM
);


-----------------------------------------------------------------------

-------------------Mux for IfSTAGE b_e_r_mem------------------------

IFSTAGE_Mux_portmap:IFSTAGE_Mux
Port map( 
           Rs=>RFAALU2,
           Immed=>Im,
           Output=>Im1,
           sel=>IFMSEL
);

--------------------------------------------------------------------

----------------------After MEM reg------------------------------------

AfterMEMReg_portmap:AfterMEMReg
port map( 
           Inpm=>MEMOUT1,
           clk=>Clk,
           WEnm=>WENM,
           Outpm=>memreg
);


-----------------------------------------------------------------------

-------------NEW COMPONENTS PORT MAP-------------

ByteStore:ByteSCheck
port map-----before Data_Mem or MEMSTAGE
(          sinp=>RFBALU2,
           sout=>RFBALU3,
			  bum=>BUM,
           ssel=>Ssel
);

ByteLoad:ByteLCheck
port map-----after Data_Mem or MEMSTAGE
(          linp=>MEMOUT2,
           lout=>MEMOUT3,
           lsel=>Lsel
);

end Behavioral;

