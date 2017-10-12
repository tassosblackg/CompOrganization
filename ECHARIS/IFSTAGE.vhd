----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:24:16 03/05/2016 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           PC_sel : in  STD_LOGIC;
           PC_IM : in  STD_LOGIC_VECTOR (31 downto 0);
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component Mux2to1b is
  Port (   sel : in  STD_LOGIC;
           Din1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0)
         );
end component;

component PC is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC);
end component;

component Incrementor is
    Port ( Ain : in  STD_LOGIC_VECTOR (31 downto 0);
           Bout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component AdderIM is
    Port ( Inp : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_im : in  STD_LOGIC_VECTOR (31 downto 0);
           Outp : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IMEM is
 Port ( CLK : in  STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (9 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
-------------------------------------------------------------------------------------------
signal muxOut,PCout,IncrOut, AdderOut,signalInstr :STD_LOGIC_VECTOR(31 downto 0);
------------------------------------------------------------------------------------------------

begin

MuxPart:Mux2to1b
Port map (  sel=>PC_sel,
            Din1=>IncrOut ,
				Din2=>AdderOut ,
				Dout=>muxOut );
				
PC_reg:PC
Port map ( CLK=>CLK,
           RST=>RST,
			  PC_LdEn=>PC_LdEn,
			  Din=>muxOut,
			  Dout=>PCout);
			  
IncrPart:Incrementor
Port map (  Ain=>PCout,
            Bout=>IncrOut);
				
AdderPart:AdderIM
Port map( Inp=>IncrOut,
          PC_im=>PC_IM,
			 Outp=>AdderOut);
			 
IMEM_Part:IMEM		
Port map ( CLK=>CLK,
           Addr=>PCout(11 downto 2), --akeraia pollaplasia tou 4
			  Dout=>signalInstr);
			  
       Instr<=   signalInstr; 	 
			  

end Behavioral;

