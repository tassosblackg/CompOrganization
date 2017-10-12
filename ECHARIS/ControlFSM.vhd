----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlFSM is
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
		   IFmSel : out STD_LOGIC;--mux of Ifstage
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
		   --------NewSignals
			BuM : out STD_LOGIC_VECTOR(2 downto 0);--byte unpack sel
		   RgM4en : out STD_LOGIC;--kataxwrhtes BpM
		   RgM3en : out STD_LOGIC;
		   RgM2en : out STD_LOGIC;
		   RgM1en : out STD_LOGIC;--------------------/
		   Mux_MEM_sel : out STD_LOGIC_VECTOR(1 downto 0);
		   RgMEMen2 : out STD_LOGIC;
		   ALU_A_sel : out STD_LOGIC_VECTOR(2 downto 0);--ALU Ain mux sel
		   RF_WrData_sel2 : out STD_LOGIC_VECTOR(1 downto 0);--RF_writedata sel 2
		   ALU_Bin_sel2 : out STD_LOGIC_VECTOR(1 downto 0));--ALUBsel2
end ControlFSM;

architecture Behavioral of ControlFSM is
------------------------------------------------------------------------------------------------------------------------------------------------
type state_type is (IFs,DECs,MEMadComp,MemAccLwLb,MemLwLbcmpl,MemSwSbcmpl,RExec,Rcomp,IExec,Icomp,BEQorBNE,BranchCmpl,
B,CmovA,CmovB,Add_mmxb1,Add_mmxb2,BERM1,BERM2,BERM3,BERMcmpl,BnEM1,BnEM2,BnEM3,BnEMcmpl,BpMba,BpM1,BpM2,BpM3,BpM4,
BpMaddr,BpMwr,BupMba,BupM1,BupMaddr,BupM2,BupM3,BupM4,BupMcmpl,nop,ErrorS);
signal c_state,next_state : state_type;
signal BpMopt,BupMopt : std_logic_vector(1 downto 0);
-------------------------------------------------------------------------------------------------------------------------------------------------
begin
----State change
process (clk)
begin
	if ( clk'event and clk = '1' ) then
		if (rst='1') then
			c_state <= IFs;
		else
			c_state <= next_state;
		end if;
	end if;
end process;
--Logic inside states
process (c_state,opcode,ALUf,zero)
begin
 case c_state is
 when IFs =>
      PC_sel <='0';
      PC_LdEn <='0';
		BpMopt<="00";
		BupMopt<="00";
	   RgAen <= '0';
      RgBen <='0';
      RgAluOen <='0';
      RgMEMen  <='0';
	
      RF_B_sel <='0';
	  RF_Wen <='0';
      RF_WrData_sel <='0';
      ZerOSign <='0';
      Shft2 <='0';
      Shft16 <='0';
      ALU_Bin_sel <='0';
		ALU_Bin_sel2<="00";--new
	  RF_B_sel <='0';
	  RF_Wen <='0';      
      ZerOSign <='0';
      Shft2 <='0';
      Shft16 <='0';
      
	  -----
	  SbOrSw <='0';
      LbOrLw <='0'; 
     ------
      MEM_WrEn <='0';
		-----NEW------
		RF_WrData_sel2<="00";
		ALU_A_sel<="001";
		BuM<="000";--
		RgM4en<='0';
		RgM3en<='0';
		RgM2en<='0';
		RgM1en<='0';
		Mux_MEM_sel<="00";
		RgMEMen2<='0';
		IFmSel<='0';
		RF_WrData_sel2<="00";
	  ----------------
	  next_state<=DECs;
 
 when DECs =>
  -------enableRegisters----------
  RgAen<='1';
  RgBen<='1';
  RgAluOen<='0';
  RgMEMen<='0';
  
   
    --Rtype
     if (opcode=("100000")) then
	    RF_B_sel<='0';
	    RF_WrData_sel<='0';
		 ---------new
		 RF_WrData_sel2<="00";
		 ---------
	    RF_Wen<='0';
	    ZerOSign<='0';
	    Shft2<='0';
        Shft16<='0';	
       -------------------
       next_state<=RExec;
	   -------------------
     --MemAccessinstr(Lb,Sb,Lw,Sw)
     elsif (opcode=("000011")or opcode=("000111")or opcode=("001111")or opcode=("011111"))then
	    RF_B_sel<='0';
	    RF_WrData_sel<='0';
		 ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ----------------
	    ZerOSign<='1';
	    ----------------
	    Shft2<='0';
       Shft16<='0';
		 
		if( opcode=("000111")or opcode=("011111") )then --Sb or Sw !!!!!
		RF_B_sel<='1';--rd 
		else
		RF_B_sel<='0';
		end if;
	    --------------------
	    next_state<=MEMadComp;
	    --------------------
	  --BEQorBNE
	  elsif (opcode=("010000")or opcode=("010001")) then
	    RF_B_sel<='1';--
	    RF_WrData_sel<='0';
		  ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='1';
	    Shft2<='1';
       Shft16<='0';
	  --------------------
	  next_state<=BEQorBNE;
	  --------------------
	  
	  --Itype(addi, andi,ori,lui,li)
	  elsif (opcode=("110000")or opcode=("110010")or opcode=("110011")or opcode=("111000")or opcode=("111001"))then
	    RF_B_sel<='0';
	    RF_WrData_sel<='0';
	    RF_Wen<='0';
	     ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    ZerOSign<='0';
	    Shft2<='0';
	    Shft16<='0';
	    --addi, li
	    if(opcode=("110000")or opcode=("111000"))then
	      ZerOSign<='1';--signextension
        end if;
	    --lui
	    if(Opcode="111001") then
         Shft16<='1';--shift <<16
	    end if;
	   --------------------
	    next_state<=IExec;
	   --------------------
	  --B
	  elsif (opcode=("111111"))then
	    RF_B_sel<='0';
	    RF_WrData_sel<='0';
		  ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='1';
		Shft2<='1';
	    Shft16<='0';
		--------------------
	    next_state<=B;
	    --------------------
	 --Cmov	
	 elsif (opcode=("100001")) then
        RF_B_sel<='0';
	    RF_WrData_sel<='0';
		  ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='0';
		Shft2<='0';
	    Shft16<='0';	 
		------------------
		next_state<=CmovA;
		-------------------
	 --ADD_MMX_Byte
	 elsif (opcode=("100011")) then
	   RF_B_sel<='0';--
	   RF_WrData_sel<='0';
		  ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='0';
		Shft2<='0';
	    Shft16<='0';
		-----
		next_state<=Add_mmxb1;
	 --BranchEqualRegMem
	 elsif(opcode=("100111")) then
	    RF_B_sel<='0';--
	    RF_WrData_sel<='0';
	    ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='1';--
		Shft2<='1';--
	    Shft16<='0';
		-----
		next_state<=BERM1;
	 
	 --BranchNotEqualMEM
	 elsif(opcode=("101111")) then
	    RF_B_sel<='0';--
	    RF_WrData_sel<='0';
	    ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='1';--
		Shft2<='1';--
	    Shft16<='0';
		-----
		next_state<=BnEM1;
	 --BytePackMEM
	 elsif(opcode=("111100")) then
	       RF_B_sel<='0';--
	    RF_WrData_sel<='0';
	    ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='1';--
		Shft2<='0';--
	    Shft16<='0';
		-----
		next_state<=BpMba;
	--ByteUnPackMem
   elsif(opcode=("11110")) then	
	     RF_B_sel<='0';--
	    RF_WrData_sel<='0';
	    ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
	    RF_Wen<='0';
	    ZerOSign<='1';--
		Shft2<='0';--
	    Shft16<='0';
		-----
		next_state<=BupMba;
		---
    elsif(opcode=("000000"))then--nop
      next_state<=nop;
     else
      next_state<=ErrorS;
    end if;
 --MemadComp
 when MEMadComp =>--alu add
   ALU_Bin_sel<='1';
	ALU_Bin_sel2<="00";--
	ALU_A_sel<="001";--
   ALU_func<="0000";--add for all mem instr
   --------------------
   RgAen<='0';
   RgBen<='0';
   RgAluOen<='1';
   RgMEMen<='0';
   --------------------
   case Opcode is
	  --Lb
     when ("000011")=>	
      LbOrLw<='1'; 	 
	   --------------------
	    next_state<=MemAccLwLb;
	   --------------------
	   --Lw
	  when("001111")=>
	    LbOrLw<='0';
    	--------------------
	    next_state<=MemAccLwLb;
	    --------------------
	  --Sb
	  when("000111")=>	  
       SbOrSw<='1';	  --sb
		 BuM<="000";--
	   MEM_WrEn<='1';
		Mux_MEM_sel<="00";--
	   RgMEMen<='0';
	   --------------------
	    next_state<=MemSwSbcmpl;
	   --------------------
	  
	  --Sw --write
	  when("011111")=>	
	    SbOrSw<='0';	  --sw
		 BuM<="000";
		MEM_WrEn<='1';
		Mux_MEM_sel<="00";--
	    RgMEMen<='0';
	 	next_state<=MemSwSbcmpl;
	  when others =>
	    next_state<=ErrorS;
	  end case;
	  
 when MemAccLwLb =>      
      MEM_WrEn<='0';--read
		Mux_MEM_sel<="00";--aluO
	   RgMEMen<='1';--register enables
      ---Write to RF----
      RF_Wen<='1';
      RF_WrData_sel<='1';
		 ---------new--------
		 RF_WrData_sel2<="00";
		 ------------------
      -------------------	 
	  next_state<=MemLwLbcmpl;
	  --------------------
 when MemLwLbcmpl =>
  RgMEMen<='0';--close mem reg
  PC_sel<='0';
  IFmSel<='1';--dontcare
  PC_LdEn<='1';
  next_state<=IFs;
  
 --Sw or Sb complete 
 when MemSwSbcmpl =>
  MEM_WrEn<='0';
  Mux_MEM_sel<="00";--aluO
  PC_sel<='0';--!
  IFmSel<='1';--dontcare
  PC_LdEn<='1';
  next_state<=IFs;
  
 
 when RExec  =>
   ALU_func<=ALUf;
   ALU_Bin_sel<='0';
	ALU_Bin_sel2<="00";--
	ALU_A_sel<="001";--
   --------------------
   RgAen<='0';
   RgBen<='0';	
   RgAluOen<='1';
   RgMEMen<='0';  
   --------------------
	 next_state<=Rcomp;
	--------------------
--Rtype complete
 when Rcomp =>
   ZerOSign<='0';
   Shft2<='0';
   Shft16<='0';	
   RF_B_sel<='0';
   RF_WrData_sel<='0';
	 ---------new--------
		 RF_WrData_sel2<="00";
	------------------
   RF_Wen<='1';--write
   -----------ifs
   PC_sel<='0';
	IFmSel<='1';--dontcare
   PC_LdEn<='1';
   --------------------
	 next_state<=IFs;
   --------------------
 --Itype Execution
 when IExec =>    
   RgAen<='0';
   RgBen<='0';
   RgAluOen<='1';
   RgMEMen<='0';
   --------------------
   ALU_Bin_sel<='1';--pass immed
	ALU_Bin_sel2<="00";--mux1out
	ALU_A_sel<="001";--
   --------------------
	
	 if(opcode=("111000")or opcode=("111001")) then --li or lui
	   ALU_func<="1111";	 
	 else--addi("110000")
	  ALU_func<=Opcode(3 downto 0); 
	 end if;--	
   --------------------
	 next_state<=Icomp;
	--------------------
	
--Itype complete
 when Icomp =>
   ZerOSign<='0';
   Shft2<='0';
   Shft16<='0';	
   RF_B_sel<='0';
   RF_WrData_sel<='0';
	 ---------new--------
	RF_WrData_sel2<="00";
	------------------
   RF_Wen<='1';
   PC_sel<='0';
	IFmSel<='1';--dontcare
   PC_LdEn<='1';
  --------------------
  next_state<=IFs;
  --------------------   
 when BEQorBNE =>
	RF_B_sel <= '1';
	ALU_Bin_sel <= '0';
	ALU_Bin_sel2<="00";--rfb
	ALU_A_sel<="001";--rfa
	ALU_func <= "0001";
	next_state <= BranchCmpl;
when BranchCmpl =>--
   IFmSel<='1';--!!care immed
	if (opcode="010000") then
	  PC_sel <= zero;
	else
	  PC_sel <= not zero;
	end if;
	PC_LdEn <= '1';
	
	next_state<=IFs;
	
 when B=>
     IFmSel<='1';--immed
    PC_sel <= '1';
	PC_LdEn <= '1';
	next_state<=IFs;
--Cmov	
 when CmovA =>
   ALU_func<="0001";--sub A-B
   ALU_Bin_sel<='0';--rt
	ALU_Bin_sel2<="00";--rt
	ALU_A_sel<="000";--pass 0
   --------------------
   RgAen<='0';
   RgBen<='0';	
   RgAluOen<='1';
   RgMEMen<='0';
   --------------------
	 next_state<=CmovB;
	--------------------
 when CmovB=>
   if(Zero='1') then
     next_state<=nop;
   else--RF[rt]!=0
    RF_Wen<='1';
    ZerOSign<='0';
    Shft2<='0';
    Shft16<='0';	
    RF_B_sel<='0';
    RF_WrData_sel<='0';--dontcare
	 RF_WrData_sel2<="10";--RS
    ------------
	PC_sel<='0';
	IFmSel<='1';--dontcare
	PC_LdEn<='1';
	-------------
	next_state<=IFs;
	end if;
--ADD_MMX_states	
 when Add_mmxb1=>
   ALU_func<="1110";--new function
   ALU_A_sel<="001";--rs
   ALU_Bin_sel<='0';--rt
   ALU_Bin_sel2<="00";-------newB
   RgAluOen<='1';
   RgAen<='0';
   RgBen<='0';
   RgMEMen<='0';
   -----------------------
   next_state<=add_mmxb2;
	
 when Add_mmxb2=>
    RF_WrData_sel2<="00";--alu out
	 RF_Wen<='1';
    ZerOSign<='0';
    Shft2<='0';
    Shft16<='0';	
    RF_B_sel<='0';
    RF_WrData_sel<='0';--?--aluO
    ------------
	PC_sel<='0';
	IFmSel<='1';--dontcare
	PC_LdEn<='1';
	-------------
	next_state<=IFs;
	
--BeqRgMeM-----------------------------------------
 when BERM1=>
    ALU_Bin_sel<='1';--immed
    ALU_Bin_sel2<="00";--Bin immed
    ALU_A_sel<="001";--x
    ALU_func<="1111";--pass immed from ALUO
    RgAluOen<='1';
	next_state<=BERM2;
 when BERM2=>    
    MEM_WrEn<='0';--read
    Mux_MEM_sel<="00";--aluOut	
    RgMEMen<='1';
    next_state<=BERM3;
 when BERM3=>
    RgMEMen<='0';
    ALU_A_sel<="100";--mem out
    ALU_Bin_sel<='0';--rt	
	ALU_Bin_sel2<="00";--rt
	ALU_func<="0001";--sub
	RgAluOen<='1';
	next_state<=BERMcmpl;
 when BERMcmpl =>
    if(Zero='1') then
      IFmSel<='0';--!!rs
      PC_sel<='1';
    else
      IFmSel<='1';--!!immed
      PC_sel<='0';
	end if;
    PC_LdEn<='1';
    next_state<=IFs;	
--------------------------------------------------	
--BnEqMem
 when BnEM1=>
   Mux_MEM_sel<="01";--rs
	RgMEMen<='1';
	RgMEMen2<='1';--new rg1||rg2
	MEM_WrEn<='0';
	next_state<=BnEM2;
 when BnEM2 =>
    RgMEMen<='1';
	 RgMEMen2<='0';---new!!
    Mux_MEM_sel<="10";--rt
    MEM_WrEn<='0';
    next_state<=BnEM3;
 when BnEM3=>
    RgMEMen<='0';
	RgMEMen2<='0';
    ALU_A_sel<="010";--mem RG2out
    ALU_Bin_sel<='0';
    ALU_Bin_sel2<="01";--mem RGout
    ALU_func<="0001";--sub
    RgAluOen<='1';
    next_state<=BnEMcmpl;
 when BnEMcmpl=>
    if(Zero='1') then
      IFmSel<='1';--!!immed
	  PC_sel<='1';
	else
	  PC_sel<='0';
	end if;
	PC_LdEn<='1';
	next_state<=IFs;
----BytePackMEM----------------------------------------------
 when BpMba =>
    ALU_A_sel<="001";--rs
    ALU_Bin_sel<='1';--immed
    ALU_Bin_sel2<="00";--immed
    ALU_func<="0000";--add
    RgAluOen<='1';
	--------------
	RgM4en<='0'	;
	RgM3en<='0'	;
    RgM2en<='0'	;
    RgM1en<='0'	;
	---------------
    next_state<=BpM1;
 when BpM1 =>
    Mux_MEM_sel<="00";---!!ALUOut
    RgAluOen<='0';--!
    RgM4en<='1'	;--write RG4
	RgM3en<='0'	;
    RgM2en<='0'	;
    RgM1en<='0'	;	
	MEM_WrEn<='0';
	-----------------
	BpMopt<="01";--prvs state BPM1
	next_state<=BpMaddr;
 when BpMaddr => --increase base address
    ALU_A_sel<="011";--RGALUOut
    ALU_Bin_sel<='0';--dont care
    ALU_Bin_sel2<="10";--"4"
    ALU_func<="0000";--add
    RgAluOen<='1';
    if(BpMopt="01") then --previous state BpM1
      next_state<=BpM2;
    elsif(BpMopt="10") then --previous state BpM2
      next_state<=BpM3;
    elsif(BpMopt="11") then --previous state BpM3
      next_state<=BpM4; 
    else --??"00"
      next_state<=BpMwr;
    end if;	  
 when BpM2=>
   BpMopt<="10";--state BpM2
	 Mux_MEM_sel<="00";---!!ALUOut
   RgAluOen<='0';
	RgM4en<='0';
	RgM3en<='1';	
	RgM2en<='0';
	RgM1en<='0';
	MEM_WrEn<='0';
	next_state<=BpMaddr;
 when BpM3=>
   BpMopt<="11";--state BpM3
	 Mux_MEM_sel<="00";---!!ALUOut
   RgAluOen<='0';
	RgM4en<='0';
	RgM3en<='0';	
	RgM2en<='1';
	RgM1en<='0';
	MEM_WrEn<='0';
	next_state<=BpMaddr;
 when BpM4=>
   Mux_MEM_sel<="00";---!!ALUOut
   RgAluOen<='0';
	RgM4en<='0';
	RgM3en<='0';	
	RgM2en<='0';
	RgM1en<='1';
	MEM_WrEn<='0';
	next_state<=BpMwr;
 when BpMwr=>
    RF_WrData_sel<='0';--dont care
    RF_WrData_sel2<="01";--concatenator
    RF_Wen<='1';
    ------
    PC_sel<='0';
	  IFmSel<='1';--dontcare
    PC_LdEn<='1';
    next_state<=IFs;
----------------------------------------------------------	
---ByteUnpackMEM----------------------------------------------
 when BupMba =>--base address calc
     BupMopt<="00";--??
     ALU_A_sel<="001";--rs 
	  ALU_Bin_sel<='1';--immed
	  ALU_Bin_sel2<="00";--mux1out
	  ALU_func<="0000";--add
	  RgALUOen<='1';
     next_state<=BupM1;
 when BupM1=>
     BupMopt<="01";--
     RgAluOen<='0';--close rg
     Bum<="001";--(7-->0)
	  SbOrSw<='0';
	  MeM_WrEn<='1';
	  next_state<=BupMaddr;
 when BupMaddr=> --increase BA+4
     ALU_A_sel<="011";--previous ba
	  ALU_Bin_sel<='0';--dontcare
	  ALU_Bin_sel2<="10";--"4" pass
	  RgAluOen<='1';--write
	  if(BupMopt="01") then --previous BupM1
	    next_state<=BupM2;
	  elsif(BupMopt="10") then --previous BupM2
	    next_state<=BupM3;
	  elsif(BupMopt="11") then --previous BupM3
	    next_state<=BupM4;
	  else
	    next_state<=BupMcmpl;
	  end if;
 when BupM2=>
    BupMopt<="10";--
    Bum<="010";--(15-8)
    SbOrSw<='0';
    MEM_WrEn<='1';
    next_state<= BupMaddr;
 when BupM3=>
    BupMopt<="11";--
    Bum<="011"; --(23-16)
	 SbOrSw<='0';
	 MEM_WrEn<='1';
	 next_state<=BupMaddr;
 when BupM4=>
    BupMopt<="00";---??
    Bum<="100";--(31-24)
	 SbOrSw<='0';
	 MEM_WrEn<='1';
	 next_state<=BupMcmpl;
 when BupMcmpl=>
    Bum<="000";
	 SbOrSw<='0';
	 MEM_WrEn<='0';
	 ----
	 PC_sel<='0';
	 PC_LdEn<='1';
	 next_state<=IFs;
-------------------------------------------------
--------
 when nop =>
  PC_sel<='0';
   IFmSel<='1';--dontcare
  PC_LdEn<='1';
  next_state<=IFs;
 when ErrorS =>--??stay at the same state and instruction
  PC_sel<='0';
   IFmSel<='1';--dontcare
  PC_LdEn<='0';
  next_state<=IFs;
 when others=>
 next_state<=ErrorS;
 end case;

end process;


end Behavioral;