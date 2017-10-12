----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:13:25 02/21/2016 
-- Design Name: 
-- Module Name:    RegFILE - Behavioral 
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

entity RegFILE is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           CLK : in  STD_LOGIC;
           WrEn : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end RegFILE;

architecture Behavioral of RegFILE is

component Compare is
 Port ( Adr : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           outp : out  STD_LOGIC);
end component;

component Decoder5to32 is
  Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX32to1 is
 Port ( Adr : in  STD_LOGIC_VECTOR (4 downto 0);
           R0 : in  STD_LOGIC_VECTOR (31 downto 0);
           R1 : in  STD_LOGIC_VECTOR (31 downto 0);
           R2 : in  STD_LOGIC_VECTOR (31 downto 0);
           R3 : in  STD_LOGIC_VECTOR (31 downto 0);
           R4 : in  STD_LOGIC_VECTOR (31 downto 0);
           R5 : in  STD_LOGIC_VECTOR (31 downto 0);
           R6 : in  STD_LOGIC_VECTOR (31 downto 0);
           R7 : in  STD_LOGIC_VECTOR (31 downto 0);
           R8 : in  STD_LOGIC_VECTOR (31 downto 0);
           R9 : in  STD_LOGIC_VECTOR (31 downto 0);
           R10 : in  STD_LOGIC_VECTOR (31 downto 0);
           R11 : in  STD_LOGIC_VECTOR (31 downto 0);
           R12 : in  STD_LOGIC_VECTOR (31 downto 0);
           R13 : in  STD_LOGIC_VECTOR (31 downto 0);
           R14 : in  STD_LOGIC_VECTOR (31 downto 0);
           R15 : in  STD_LOGIC_VECTOR (31 downto 0);
           R16 : in  STD_LOGIC_VECTOR (31 downto 0);
           R17 : in  STD_LOGIC_VECTOR (31 downto 0);
           R18 : in  STD_LOGIC_VECTOR (31 downto 0);
           R19 : in  STD_LOGIC_VECTOR (31 downto 0);
           R20 : in  STD_LOGIC_VECTOR (31 downto 0);
           R21 : in  STD_LOGIC_VECTOR (31 downto 0);
           R22 : in  STD_LOGIC_VECTOR (31 downto 0);
           R23 : in  STD_LOGIC_VECTOR (31 downto 0);
           R24 : in  STD_LOGIC_VECTOR (31 downto 0);
           R25 : in  STD_LOGIC_VECTOR (31 downto 0);
           R26 : in  STD_LOGIC_VECTOR (31 downto 0);
           R27 : in  STD_LOGIC_VECTOR (31 downto 0);
           R28 : in  STD_LOGIC_VECTOR (31 downto 0);
           R29 : in  STD_LOGIC_VECTOR (31 downto 0);
           R30 : in  STD_LOGIC_VECTOR (31 downto 0);
           R31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Mux2to1 is
   Port ( sel : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dreg : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Reg is
   Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;



--signals--------------------------------------------------------------
signal sign_din,sign_decOut,sign_we,sign_MUX1,sign_MUX2 : STD_LOGIC_VECTOR(31 downto 0);

type ar2d is array (0 to 31) of std_logic_vector(31 downto 0);
signal sign_Reg: ar2d;--2 dim array

--signal sign_Adr1,sign_Adr2,sign_Awr :STD_LOGIC_VECTOR(4 downto 0);
signal comp_mux1,comp_mux2,comp1,comp2 :STD_LOGIC;

---------------------------------------------------

begin




---sel='1', compare_output='1' AND WE='1'------------------
comp_mux1<=  WrEn and comp1;
comp_mux2<= WrEn and comp2;

sign_we(0) <= WrEn and sign_decOut(0);
sign_we(1) <= WrEn and sign_decOut(1);
sign_we(2) <= WrEn and sign_decOut(2);
sign_we(3) <= WrEn and sign_decOut(3);
sign_we(4) <= WrEn and sign_decOut(4);
sign_we(5) <= WrEn and sign_decOut(5);
sign_we(6) <= WrEn and sign_decOut(6);
sign_we(7) <= WrEn and sign_decOut(7);
sign_we(8) <= WrEn and sign_decOut(8);
sign_we(9) <= WrEn and sign_decOut(9);
sign_we(10) <= WrEn and sign_decOut(10);
sign_we(11) <= WrEn and sign_decOut(11);
sign_we(12) <= WrEn and sign_decOut(12);
sign_we(13) <= WrEn and sign_decOut(13);
sign_we(14) <= WrEn and sign_decOut(14);
sign_we(15) <= WrEn and sign_decOut(15);
sign_we(16) <= WrEn and sign_decOut(16);
sign_we(17) <= WrEn and sign_decOut(17);
sign_we(18) <= WrEn and sign_decOut(18);
sign_we(19) <= WrEn and sign_decOut(19);
sign_we(20) <= WrEn and sign_decOut(20);
sign_we(21) <= WrEn and sign_decOut(21);
sign_we(22) <= WrEn and sign_decOut(22);
sign_we(23) <= WrEn and sign_decOut(23);
sign_we(24) <= WrEn and sign_decOut(24);
sign_we(25) <= WrEn and sign_decOut(25);
sign_we(26) <= WrEn and sign_decOut(26);
sign_we(27) <= WrEn and sign_decOut(27);
sign_we(28) <= WrEn and sign_decOut(28);
sign_we(29) <= WrEn and sign_decOut(29);
sign_we(30) <= WrEn and sign_decOut(30);
sign_we(31) <= WrEn and sign_decOut(31);

DEC1: Decoder5to32
  Port map (  Awr=> Awr,
              Outp=>sign_decOut
				  );

Reg0: Reg
  Port map ( Data=>"00000000000000000000000000000000",
             CLK=>CLK,
				 WE=>sign_we(0),
				 Dout=>sign_Reg(0)
				 );
--GENERATE 1-31 Regs----
G1:For i in 1 to 31 generate
 
 RegX: Reg
   Port map ( Data=>Din,
               CLK=>CLK,
               WE=>sign_we(i),
               Dout=>sign_Reg(i)
             );	
end generate;			 

M1: MUX32to1
   Port map ( Adr=>Adr1,
              R0 =>sign_Reg(0),----*
              R1 =>sign_Reg(1),
              R2 =>sign_Reg(2),	
              R3 =>sign_Reg(3),
              R4 =>sign_Reg(4),
              R5 =>sign_Reg(5),
              R6 =>sign_Reg(6),
              R7 =>sign_Reg(7),
              R8 =>sign_Reg(8),
              R9 =>sign_Reg(9),
              R10 =>sign_Reg(10),
              R11 =>sign_Reg(11),
              R12 =>sign_Reg(12),
              R13 =>sign_Reg(13),
              R14 =>sign_Reg(14),
              R15 =>sign_Reg(15),
              R16 =>sign_Reg(16),
              R17 =>sign_Reg(17),
              R18 =>sign_Reg(18),
              R19 =>sign_Reg(19),
              R20 =>sign_Reg(20),
              R21 =>sign_Reg(21),
              R22 =>sign_Reg(22),
              R23 =>sign_Reg(23),
              R24 =>sign_Reg(24),
              R25 =>sign_Reg(25),
              R26 =>sign_Reg(26),
              R27 =>sign_Reg(27),
              R28 =>sign_Reg(28),
              R29 =>sign_Reg(29),
              R30 =>sign_Reg(30),
              R31 =>sign_Reg(31),
              
              Outp=>sign_MUX1
            );	
				
M2: MUX32to1
   Port map ( Adr=>Adr2,
              R0 =>sign_Reg(0),---*
              R1 =>sign_Reg(1),
              R2 =>sign_Reg(2),	
              R3 =>sign_Reg(3),
              R4 =>sign_Reg(4),
              R5 =>sign_Reg(5),
              R6 =>sign_Reg(6),
              R7 =>sign_Reg(7),
              R8 =>sign_Reg(8),
              R9 =>sign_Reg(9),
              R10 =>sign_Reg(10),
              R11 =>sign_Reg(11),
              R12 =>sign_Reg(12),
              R13 =>sign_Reg(13),
              R14 =>sign_Reg(14),
              R15 =>sign_Reg(15),
              R16 =>sign_Reg(16),
              R17 =>sign_Reg(17),
              R18 =>sign_Reg(18),
              R19 =>sign_Reg(19),
              R20 =>sign_Reg(20),
              R21 =>sign_Reg(21),
              R22 =>sign_Reg(22),
              R23 =>sign_Reg(23),
              R24 =>sign_Reg(24),
              R25 =>sign_Reg(25),
              R26 =>sign_Reg(26),
              R27 =>sign_Reg(27),
              R28 =>sign_Reg(28),
              R29 =>sign_Reg(29),
              R30 =>sign_Reg(30),
              R31 =>sign_Reg(31),
              
              Outp=>sign_MUX2
            );		

C1: Compare
     Port map ( Adr=>Adr1,
                Awr=>Awr,
                outp=>comp1
               );

C2: Compare
     Port map ( Adr=>Adr2,
                Awr=>Awr,
                outp=>comp2
               );
M3: Mux2to1
   Port map ( sel=>comp_mux1,
	           Din=>Din,
				  Dreg=>sign_MUX1,
				  Dout=>Dout1
				 );
M4: Mux2to1
   Port map ( sel=>comp_mux2,
	           Din=>Din,
				  Dreg=>sign_MUX2,
				  Dout=>Dout2
				 );
					
				  
			
end Behavioral;