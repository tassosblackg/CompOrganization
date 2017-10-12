----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:29:08 03/05/2015 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           mDout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           mDout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is

signal dout0,dout1,dout2,dout3,dout4,dout5,dout6,dout7,dout8,dout9,
       dout10,dout11,dout12,dout13,dout14,dout15,dout16,dout17,dout18,
		 dout19,dout20,dout21,dout22,dout23,dout24,dout25,dout26,dout27,
		 dout28,dout29,dout30,dout31,
		 WEr,AddressDecoded,preout1,preout2:STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal compare_out1,compare_out2: STD_LOGIC:='0';

component CompareModule is
    Port ( ReadAddress : in  STD_LOGIC_VECTOR (4 downto 0);
           WriteAddress : in  STD_LOGIC_VECTOR (4 downto 0);
           WE : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;

component Decoder5x32 is
    Port ( input : in  STD_LOGIC_VECTOR(4 downto 0);
	 
           output : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

component Registers is
    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
           CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0'));
end component;



begin

--polyplektis meta ton decoder gia ta Write enable twn kataxwritwn
WEr <= AddressDecoded when WrEn = '1' else (others=>'0');
--polyplektis telikis ekswdou(Din i ekswdos register)
mDout1<= preout1 when compare_out1 = '0' or Ard1 = "00000" else Din;
mDout2<= preout2 when compare_out2 = '0' or Ard2 = "00000" else Din;


--polyplektes epilogis kataxwriti poy tha diavasoume
with Ard1 select 
preout1 <= Dout0 when "00000",
Dout1 when "00001",
Dout2 when "00010",
Dout3 when "00011",
Dout4 when "00100",
Dout5 when "00101",
Dout6 when "00110",
Dout7 when "00111",
Dout8 when "01000",
Dout9 when "01001",
Dout10 when "01010",
Dout11 when "01011",
Dout12 when "01100",
Dout13 when "01101",
Dout14 when "01110",
Dout15 when "01111",
Dout16 when "10000",
Dout17 when "10001",
Dout18 when "10010",
Dout19 when "10011",
Dout20 when "10100",
Dout21 when "10101",
Dout22 when "10110",
Dout23 when "10111",
Dout24 when "11000",
Dout25 when "11001",
Dout26 when "11010",
Dout27 when "11011",
Dout28 when "11100",
Dout29 when "11101",
Dout30 when "11110",
Dout31 when "11111",
(others=>'0') when others;

with Ard2 select preout2 <=
Dout0 when "00000",
Dout1 when "00001",
Dout2 when "00010",
Dout3 when "00011",
Dout4 when "00100",
Dout5 when "00101",
Dout6 when "00110",
Dout7 when "00111",
Dout8 when "01000",
Dout9 when "01001",
Dout10 when "01010",
Dout11 when "01011",
Dout12 when "01100",
Dout13 when "01101",
Dout14 when "01110",
Dout15 when "01111",
Dout16 when "10000",
Dout17 when "10001",
Dout18 when "10010",
Dout19 when "10011",
Dout20 when "10100",
Dout21 when "10101",
Dout22 when "10110",
Dout23 when "10111",
Dout24 when "11000",
Dout25 when "11001",
Dout26 when "11010",
Dout27 when "11011",
Dout28 when "11100",
Dout29 when "11101",
Dout30 when "11110",
Dout31 when "11111",
(others=>'0') when others;

--to WE einai 0 gt ston R0 den mporoume na grapsoume
Reg0:Registers port map
(Data=>Din, CLK=>Clk, WE=> '0',Dout=>Dout0);

Reg1:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(1),Dout=>Dout1);

Reg2:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(2),Dout=>Dout2);

Reg3:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(3),Dout=>Dout3);

Reg4:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(4),Dout=>Dout4);

Reg5:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(5),Dout=>Dout5);

Reg6:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(6),Dout=>Dout6);

Reg7:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(7),Dout=>Dout7);

Reg8:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(8),Dout=>Dout8);

Reg9:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(9),Dout=>Dout9);

Reg10:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(10),Dout=>Dout10);

Reg11:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(11),Dout=>Dout11);

Reg12:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(12),Dout=>Dout12);

Reg13:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(13),Dout=>Dout13);

Reg14:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(14),Dout=>Dout14);

Reg15:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(15),Dout=>Dout15);

Reg16:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(16),Dout=>Dout16);

Reg17:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(17),Dout=>Dout17);

Reg18:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(18),Dout=>Dout18);

Reg19:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(19),Dout=>Dout19);

Reg20:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(20),Dout=>Dout20);

Reg21:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(21),Dout=>Dout21);

Reg22:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(22),Dout=>Dout22);

Reg23:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(23),Dout=>Dout23);

Reg24:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(24),Dout=>Dout24);

Reg25:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(25),Dout=>Dout25);

Reg26:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(26),Dout=>Dout26);

Reg27:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(27),Dout=>Dout27);

Reg28:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(28),Dout=>Dout28);

Reg29:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(29),Dout=>Dout29);

Reg30:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(30),Dout=>Dout30);

Reg31:Registers port map
(Data=>Din, CLK=>Clk, WE=> WEr(31),Dout=>Dout31);

DecUnit:Decoder5x32 port map
(input=>Awr, output=>AddressDecoded);

CompareUnit1:CompareModule port map
(ReadAddress=>Ard1,WriteAddress=>Awr,WE=>WrEn,output=>compare_out1);

CompareUnit2:CompareModule port map
(ReadAddress=>Ard2,WriteAddress=>Awr,WE=>WrEn,output=>compare_out2);

end Behavioral;

