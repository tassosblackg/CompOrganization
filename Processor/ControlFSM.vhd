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
           MEM_WrEn : out  STD_LOGIC);
end ControlFSM;

architecture Behavioral of ControlFSM is
------------------------------------------------------------------------------------------------------------------------------------------------
type state_type is (IFs,DECs,MEMadComp,MemAccLwLb,MemLwLbcmpl,MemSwSbcmpl,RExec,Rcomp,IExec,Icomp,BEQorBNE,BranchCmpl,B,nop,ErrorS);
signal c_state,next_state : state_type;
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
	  RF_B_sel <='0';
	  RF_Wen <='0';
      RF_WrData_sel <='0';
      ZerOSign <='0';
      Shft2 <='0';
      Shft16 <='0';
      ALU_Bin_sel <='0';
		ALU_func<="0000";
	  -----
	  SbOrSw <='0';
      LbOrLw <='0'; 
     ------
      MEM_WrEn <='0';
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
	    RF_Wen<='0';
	    ZerOSign<='1';
		Shft2<='1';
	    Shft16<='0';
		--------------------
	    next_state<=B;
	    --------------------
     elsif(opcode=("000000"))then--nop
      next_state<=nop;
     else
      next_state<=ErrorS;
    end if;
 --MemadComp
 when MEMadComp =>--alu add
   ALU_Bin_sel<='1';
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
	   MEM_WrEn<='1';
	   RgMEMen<='0';
	   --------------------
	    next_state<=MemSwSbcmpl;
	   --------------------
	  
	  --Sw --write
	  when("011111")=>	
	    SbOrSw<='0';	  --sw
		MEM_WrEn<='1';
	    RgMEMen<='0';
	 	next_state<=MemSwSbcmpl;
	  when others =>
	    next_state<=ErrorS;
	  end case;
	  
 when MemAccLwLb =>      
      MEM_WrEn<='0';--read
	  RgMEMen<='1';--register enables
      ---Write to RF----
      RF_Wen<='1';
      RF_WrData_sel<='1';
      -------------------	 
	  next_state<=MemLwLbcmpl;
	  --------------------
 when MemLwLbcmpl =>
  RgMEMen<='0';--close mem reg
  PC_sel<='0';
  PC_LdEn<='1';
  next_state<=IFs;
  
 --Sw or Sb complete 
 when MemSwSbcmpl =>
  MEM_WrEn<='0';
  PC_sel<='0';
  PC_LdEn<='1';
  next_state<=IFs;
  
 
 when RExec  =>
   ALU_func<=ALUf;
   ALU_Bin_sel<='0';
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
   RF_Wen<='1';--write
   -----------ifs
   PC_sel<='0';
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
   ALU_Bin_sel<='1';
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
   RF_Wen<='1';
   PC_sel<='0';
   PC_LdEn<='1';
  --------------------
  next_state<=IFs;
  --------------------   
 when BEQorBNE =>
	RF_B_sel <= '1';
	ALU_Bin_sel <= '0';
	ALU_func <= "0001";
	next_state <= BranchCmpl;
when BranchCmpl =>--
	if (opcode="010000") then
	  PC_sel <= zero;
	else
	  PC_sel <= not zero;
	end if;
	PC_LdEn <= '1';
	
	next_state<=IFs;
	
 when B=>
    PC_sel <= '1';
	PC_LdEn <= '1';
	next_state<=IFs;
 when nop =>
  PC_sel<='0';
  PC_LdEn<='1';
  next_state<=IFs;
 when ErrorS =>--??stay at the same state and instruction
  PC_sel<='0';
  PC_LdEn<='0';
  next_state<=IFs;
 when others=>
 next_state<=ErrorS;
 end case;

end process;


end Behavioral;