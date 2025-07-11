
--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : TB_test.vhd
--DESCRIPTION : Simulation testbench. Include test stream-vector checking all cases. 
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.package_type_and_contant.ALL;
USE ieee.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY module_top_tb IS
end module_top_tb;



ARCHITECTURE module_top_tb_arch OF module_top_tb IS
	
COMPONENT module_top IS
    PORT ( 
    	in_stream0: IN std_logic_vector (7 DOWNTO 0);
		in_stream1: IN std_logic_vector (7 DOWNTO 0);
		in_stream2: IN std_logic_vector (7 DOWNTO 0);
		in_stream3: IN std_logic_vector (7 DOWNTO 0);
		in_stream4: IN std_logic_vector (7 DOWNTO 0);
        
        clk       : IN  std_logic;
		rst       : IN  std_logic;
        
        pixel     : OUT  std_logic_vector (7 DOWNTO 0);
		controle  : OUT  std_logic_vector (1 DOWNTO 0));
END COMPONENT;

    SIGNAL r_in_stream0  : std_logic_vector (7 DOWNTO 0) := (others => '1');
	SIGNAL r_in_stream1  : std_logic_vector (7 DOWNTO 0) := (others => '1');
	SIGNAL r_in_stream2  : std_logic_vector (7 DOWNTO 0) := (others => '1');
	SIGNAL r_in_stream3  : std_logic_vector (7 DOWNTO 0) := (others => '1');
	SIGNAL r_in_stream4  : std_logic_vector (7 DOWNTO 0) := (others => '1');
 
    SIGNAL r_clk         : std_logic                     := '0';
	SIGNAL r_rst         : std_logic                     := '1';
 
	SIGNAL r_init_time   : std_logic                     := '0';
 
 
	SIGNAL r_pixel_out   : std_logic_vector (7 DOWNTO 0) ;
	SIGNAL r_control     : std_logic_vector (1 DOWNTO 0) ;

	--Sync signal, for visualization
	SIGNAL pixel_out_sync: std_logic_vector (7 DOWNTO 0) ;
	SIGNAL control_sync  : std_logic_vector (1 DOWNTO 0) ;

	TYPE ROM_stream is array (0 to 32) of INTEGER RANGE 0 TO 255 ;                                                            ----------------------------------------CWM------------------------------------
	constant ROM_stream0 : ROM_stream := (177, 186, 191, 192, 199, 202, 192, 188, 149, 129, 111, 115, 145, 167, 186, 200, 182, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);
	constant ROM_stream1 : ROM_stream := (179, 188, 193, 193, 199, 202, 192, 182, 145, 128, 116, 123, 153, 171, 186, 192, 173, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);
	constant ROM_stream2 : ROM_stream := (182, 189, 194, 192, 198, 200, 190, 174, 139, 126, 122, 135, 165, 178, 187, 189, 167, 255, 255, 255, 255, 255, 255, 255, 255, 0  , 255, 255, 255, 255, 255, 255, 255);
	constant ROM_stream3 : ROM_stream := (182, 189, 193, 191, 195, 196, 187, 169, 134, 123, 125, 145, 177, 186, 191, 193, 170, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);
	constant ROM_stream4 : ROM_stream := (182, 188, 191, 189, 193, 194, 183, 167, 131, 121, 125, 149, 183, 192, 196, 200, 175, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);

	SIGNAL	 int_stream0 : integer range 0 to 255 := 177;
	SIGNAL	 int_stream1 : integer range 0 to 255 := 179;
	SIGNAL	 int_stream2 : integer range 0 to 255 := 182;
	SIGNAL	 int_stream3 : integer range 0 to 255 := 182;
	SIGNAL	 int_stream4 : integer range 0 to 255 := 182;

	SIGNAL   i           : integer range 0 to 34  := 0 ;

BEGIN



	module_module : module_top 
		PORT MAP(
			in_stream0 =>  r_in_stream0 ,
			in_stream1 =>  r_in_stream1 ,
			in_stream2 =>  r_in_stream2 ,
			in_stream3 =>  r_in_stream3 ,
			in_stream4 =>  r_in_stream4 ,
			
			clk        => r_clk         ,
			rst        => r_rst         ,
			 
			pixel      => r_pixel_out   ,
			controle   => r_control     
		);



	--generate a 100MHz clock
	PROCESS
	BEGIN
		r_clk <= '0', '1' after 5 ns;
		wait for 10 ns  ;

	END PROCESS;
	
	--de-assert REset after 100ns
	r_rst       <= '1', '0' after 100  ns;	

	--waiting x15 clock cycle after reset de-assert to start launching 
	r_init_time <= '0', '1' after 1600 ns;


	--pushing ROM testing vector to the filter module.
	PROCESS (r_clk)
	BEGIN
		
		IF (r_clk'event AND r_clk = '1') THEN
			IF (r_rst = '1') THEN
				int_stream0 <= ROM_stream0(0);--(others => '0');
				int_stream1 <= ROM_stream1(0);--(others => '0');
				int_stream2 <= ROM_stream2(0);--(others => '0');
				int_stream3 <= ROM_stream3(0);--(others => '0');
				int_stream4 <= ROM_stream4(0);--(others => '0');

				i <= 0;
			ELSE
				
				IF(r_init_time = '1') THEN
					IF (i<33) THEN
						int_stream0 <= ROM_stream0(i);
						int_stream1 <= ROM_stream1(i);
						int_stream2 <= ROM_stream2(i);
						int_stream3 <= ROM_stream3(i);
						int_stream4 <= ROM_stream4(i);
						i           <= i+1;
					END IF;		
				END IF;	
			END IF;	
		END IF;
	END PROCESS;


	r_in_stream0 <= std_logic_vector(to_unsigned(int_stream0,8));
	r_in_stream1 <= std_logic_vector(to_unsigned(int_stream1,8));
	r_in_stream2 <= std_logic_vector(to_unsigned(int_stream2,8));
	r_in_stream3 <= std_logic_vector(to_unsigned(int_stream3,8));
	r_in_stream4 <= std_logic_vector(to_unsigned(int_stream4,8));


	--Sync signal, for visualization
	PROCESS (r_clk)
	BEGIN
		
		IF (r_clk'event AND r_clk = '1') THEN
			IF (r_rst = '1') THEN
				pixel_out_sync <= (others => '0');
				control_sync   <= (others => '0');

			ELSE				
				pixel_out_sync <= r_pixel_out ;
				control_sync   <= r_control   ;
			END IF;	
		END IF;
	END PROCESS;	



END module_top_tb_arch;