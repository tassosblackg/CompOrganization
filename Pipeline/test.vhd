--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:46:23 03/05/2015
-- Design Name:   
-- Module Name:   C:/Users/Nickba/Proxw/RegisterFile/test.vhd
-- Project Name:  RegisterFile
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         mDout1 : OUT  std_logic_vector(31 downto 0);
         mDout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal mDout1 : std_logic_vector(31 downto 0);
   signal mDout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          mDout1 => mDout1,
          mDout2 => mDout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

--write 1 to R1
      Din <= "11100000000000000000000000000001";
		WrEn <='1';
		Awr <= "00001";
      wait for CLK_period*10;
		
		--write 2 to R2
		Din <= "10100000000000000000000000000010";
		WrEn <='1';
		Awr <= "00010";
		wait for CLK_period*10;
		
		--read R1,R2
		WrEn <='0';
      Ard1 <= "00001";
		Ard2 <= "00010";
		wait for CLK_period*10;
		
		
		--read R1 and write R1
		WrEn <='1';
		Awr <= "00001";
		Din <= "01010101010101010101010101100010";
      Ard1 <= "00001";
		Ard2 <= "00010";
		wait for CLK_period*10;
		
		--write something to R4
		Din <= "10101000000000000000000000000000";
		WrEn <='1';
		Awr <= "00100";
		wait for CLK_period*10;
		
		--read and write on R4
		Din <= "11110110000000000000011111111111";
		WrEn <='1';
		Awr <= "00100";
		Ard1 <= "00100";
      wait for CLK_period*10;
		
		--write something on R0
		Din <= "11111111111111111111111111111111";
		WrEn <='1';
		Awr <= "00000";
		wait for CLK_period*10;
		
		--read R0
		WrEn <='0';
		Ard1 <= "00000";
		wait for CLK_period*10;


      -- insert stimulus here 

      wait;
   end process;

END;
