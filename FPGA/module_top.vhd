
--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : module_top.vhdControl
--DESCRIPTION : IP Top module. Take a row of 5x1 Pixels input , build a 5x5  
--              kernel and provide a centered filtered pixel output of the kernel,  
-- 				alongside the tupee of filter than had been used (contrle).
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.package_type_and_contant.ALL;


ENTITY module_top IS
    PORT ( 
    	in_stream0: IN  std_logic_vector (7 DOWNTO 0); --1st Line of pixel.
		in_stream1: IN  std_logic_vector (7 DOWNTO 0); --2nd Line of pixel.
		in_stream2: IN  std_logic_vector (7 DOWNTO 0); --3rd Line of pixel.
		in_stream3: IN  std_logic_vector (7 DOWNTO 0); --4th Line of pixel.
		in_stream4: IN  std_logic_vector (7 DOWNTO 0); --5th Line of pixel.
        
        clk       : IN  std_logic;                     --SYSCLK : 100MHZ.
		rst       : IN  std_logic;                     --Synchronized reset signal.
        
        pixel     : OUT std_logic_vector (7 DOWNTO 0); --Centered filtered Pixel.
		controle  : OUT std_logic_vector (1 DOWNTO 0)  --Filter type applies to the centered pixel.
	);	
END module_top;

ARCHITECTURE Behavioral OF module_top IS


	--input a 5-columns of pixel and output a 5x5 kernel of pixel.
	COMPONENT stream_to_kernel5x5
	    PORT ( 
			clk       : IN   STD_LOGIC;
			--rst     : IN   STD_LOGIC;		
			in_stream : IN   type_mask_5;	
			out_kernel: OUT  type_mask
			); 
	END COMPONENT;
	------------------------------------------------------------
	
	-----------Kernel's Filters top module wrapper--------------
	COMPONENT filter_IP_module 
		PORT(
			clk      : IN  std_logic  ;
			--rst    : IN  STD_LOGIC  ;
			kernel   : IN  type_mask  ;
			pixel    : OUT type_pixel ;
			controle : out std_logic_vector(1 downto 0)
		    );	
	END COMPONENT;
	------------------------------------------------------------
	

	SIGNAL Kernel5x5_input  : type_mask                   := (others => (others => '0'));
	SIGNAL in_stream        : type_mask_5                 := (others => (others => '0'));
	SIGNAL pixelZ           : type_pixel                  := (others => '0');
	SIGNAL controleZ        : std_logic_vector(1 downto 0):= (others => '0');
	SIGNAL Kernel5x5_inputZ : type_mask                   := (others => (others => '0'));

BEGIN

	--concatenating the x5 in_stream input to the "type_mask_5" type.
	in_stream <= (in_stream0, in_stream1, in_stream2, in_stream3, in_stream4);

	stream_to_kernel5x5_mod: stream_to_kernel5x5 PORT MAP(clk, in_stream, Kernel5x5_input);
	filter_IP_mod:           filter_IP_module    PORT MAP(clk, Kernel5x5_inputZ, pixelZ, controleZ);
	

	--latching data and add a reset state.
	PROCESS(clk)
	BEGIN
	IF(RISING_EDGE(clk)) THEN
		IF(rst='1') THEN
			Kernel5x5_inputZ  <= (others => (others => '0')) ;
			pixel             <= "00000000"                  ;
			controle          <= controleZ                   ;
		ELSE		 
			Kernel5x5_inputZ  <= Kernel5x5_input             ;
			pixel             <= pixelZ                      ;
			controle          <= controleZ                   ;
		END IF;
	END IF;
	END PROCESS;


END Behavioral;
