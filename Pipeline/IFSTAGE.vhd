----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:48 03/17/2015 
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
    Port ( PC_Immed : in  STD_LOGIC_vector(31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_vector(31 downto 0));
end IFSTAGE;


architecture Behavioral of IFSTAGE is

component Incrementor is
    Port ( input : in  STD_LOGIC_vector(31 downto 0);
           result : out  STD_LOGIC_vector(31 downto 0));
end component;

component IncrementorImmed is
    Port (currentAddress : in  STD_LOGIC_vector(31 downto 0);
           immed : in  STD_LOGIC_vector(31 downto 0);
           result : out  STD_LOGIC_vector(31 downto 0));
end component;

component Mux2x1 is
    Port ( input0 : in  STD_LOGIC_vector(31 downto 0);
           input1 : in  STD_LOGIC_vector(31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_vector(31 downto 0));
end component;

component PC is
    Port ( addressIn : in  STD_LOGIC_vector(31 downto 0);
           LdEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addressOut : out  STD_LOGIC_vector(31 downto 0));
end component;

component IF_MEM is
    Port ( clk : in std_logic;
           addr : in std_logic_vector(9 downto 0);
           dout : out std_logic_vector(31 downto 0));
end component;



signal muxOutput,pcOutput,incrementorOutput,incremWithImmedOut:STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');

begin







increment:Incrementor port map
(input=>pcOutput, result=>incrementorOutput);

incrementImmed:IncrementorImmed port map
(currentAddress=>incrementorOutput, immed=>PC_Immed,result=>incremWithImmedOut);

Mux:Mux2x1 port map
(input0=>incrementorOutput, input1=>incremWithImmedOut, sel=> PC_Sel,output=>muxOutput);

ProgCounter:PC port map
(addressIn=>muxOutput, clk=>Clk, LdEn=>PC_LdEn,reset=>Reset,addressOut=>pcOutput);

Memory:IF_MEM port map
(clk=>Clk,addr=>pcOutput(11 downto 2),dout=>Instr);

end Behavioral;

