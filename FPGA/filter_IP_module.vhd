
--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : filter_IP_module.vhd
--DESCRIPTION : Wrapper of the Filter module. Take a 5x5 kernel input, 
--              instanciates the controle module, all filters modules, and final  
-- 		Mux for the output Pixel. Output filtered Pixel and ctrl vector. 
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.package_type_and_contant.ALL;
USE work.filter.ALL;
USE ieee.NUMERIC_STD.ALL;


ENTITY filter_IP_module IS
	PORT(
		clk     : IN  std_logic ;
		kernel  : IN  type_mask ;
		pixel   : OUT type_pixel;
		controle: OUT std_logic_vector(1 downto 0)
		--diff1,diff2, diff3, diff4:OUT integer RANGE 0 TO 255
	    );	
END filter_IP_module;




ARCHITECTURE filter_IP_arch OF filter_IP_module IS

	SIGNAL out_filter00, out_filter01, out_filter10, out_filter11: type_pixel   := (others => '0')             ; --pixel after filter;
	
	SIGNAL sorted_kernel,kernel_out       : type_mask                           := (others => (others => '0')) ; --sorterd kernel and kernel after control.
	SIGNAL kernel_out_reg                 : type_mask                           := (others => (others => '0')) ; --sorterd kernel registered.
	
	SIGNAL out_control                    : std_logic_vector(1 DOWNTO 0)        := (others => '0')             ; --out control vector
	SIGNAL out_control_reg                : std_logic_vector(1 DOWNTO 0)        := (others => '0')             ; --registered out control vector
	SIGNAL out_control_regZ               : std_logic_vector(1 DOWNTO 0)        := (others => '0')             ; --Z
	SIGNAL out_control_regZZ              : std_logic_vector(1 DOWNTO 0)        := (others => '0')             ; --ZZ
	SIGNAL out_control_regZZZ             : std_logic_vector(1 DOWNTO 0)        := (others => '0')             ; --ZZZ
	
	--min/max index signals
	SIGNAL indice_min1, indice_min2       : integer RANGE 0 TO 24               := 0;
	SIGNAL indice_max1, indice_max2       : integer RANGE 0 TO 24               := 0;
	--registered min/max index signals
	SIGNAL indice_min1_reg,indice_min2_reg: integer RANGE 0 TO 24               := 0;
	SIGNAL indice_max1_reg,indice_max2_reg: integer RANGE 0 TO 24               := 0;
	
	SIGNAL sorted_kernel_reg              : type_mask                           := (others => (others => '0')) ;
	
	--pipeline signals for CWM filter
	SIGNAL out_filter001                  : type_pixel                          := (others => '0')             ;
	SIGNAL out_filter002                  : type_pixel                          := (others => '0')             ;
	SIGNAL out_filter003                  : type_pixel                          := (others => '0')             ;

	--pipeline signals for Gauss5x5 filter.
	SIGNAL out_filter103                  : type_pixel                          := (others => '0')             ; --5x5 need only one stage because of its pipelinisation in the module

	--pipeline signals for Gauss3x3 filter.
	SIGNAL out_filter011                  : type_pixel                          := (others => '0')             ;
	SIGNAL out_filter012                  : type_pixel                          := (others => '0')             ;
	SIGNAL out_filter013                  : type_pixel                          := (others => '0')             ;	

	--pipeline signals for NOP filter.
	SIGNAL out_filter111                  : type_pixel                          := (others => '0')             ;
	SIGNAL out_filter112                  : type_pixel                          := (others => '0')             ;	
	SIGNAL out_filter113                  : type_pixel                          := (others => '0')             ;
 
	
	BEGIN
	
	--input the kernek5x5 and out pipelined kernel5x5, sorted kernel5x5, the control signal for filter, and the min/max indices index.
	control_unit    : control  PORT MAP ( kernel, kernel_out, sorted_kernel, out_control, indice_min1, indice_min2, indice_max1, indice_max2, clk);
	
	cwm_filter      : cwm      PORT MAP ( sorted_kernel_reg, kernel_out_reg(12), out_filter00);
	gauss3x3_filter : gauss3x3 PORT MAP ( kernel_out_reg, indice_min1_reg, indice_min2_reg, indice_max1_reg, indice_max2_reg, out_filter01);
	gauss5x5_filter : gauss5x5 PORT MAP ( clk, kernel_out_reg, indice_min1_reg, indice_min2_reg, indice_max1_reg, indice_max2_reg, out_filter10);
	nop_filter      : nop      PORT MAP ( kernel_out_reg,out_filter11);
	
	--big_or_kernel   : big_or   PORT MAP ( out_control_regZZZ, out_filter003, out_filter013, out_filter103, out_filter113, pixel);


	
	--timing pipeline: controle -> filtres 
	PROCESS(clk)
	BEGIN
		IF(RISING_EDGE(clk)) THEN
			kernel_out_reg     <= kernel_out   ;
			indice_min1_reg    <= indice_min1  ;
			indice_min2_reg    <= indice_min2  ;
			indice_max1_reg    <= indice_max1  ;
			indice_max2_reg    <= indice_max2  ;
			sorted_kernel_reg  <= sorted_kernel;
			out_control_reg    <= out_control  ;
		END IF;
	END PROCESS;
	
	--timing pipeline: filtres -> Mux  
	PROCESS(clk)
	BEGIN
		IF(RISING_EDGE(clk)) THEN
			--Pipeline for matching timing with the final Mux.
			out_control_regZ   <= out_control_reg   ;--
			out_control_regZZ  <= out_control_regZ  ;--
			out_control_regZZZ <= out_control_regZZ ;--

			out_filter001      <= out_filter00      ;
			out_filter002      <= out_filter001     ;
			out_filter003      <= out_filter002     ;

			out_filter103      <= out_filter10      ;--5x5 need only one stage because of its pipelining in the module

			out_filter011      <= out_filter01      ;
			out_filter012      <= out_filter011     ;
			out_filter013      <= out_filter012     ;

			out_filter111      <= out_filter11      ;
			out_filter112      <= out_filter111     ;		
			out_filter113      <= out_filter112     ;
			
		END IF;
	END PROCESS;
		
	--output the control signal vector.
	controle <= out_control_regZZZ;

	--Final output of the Pixel, via MUX.
	WITH out_control_regZZZ SELECT
	pixel<=out_filter003 WHEN "00"  , -- CWM
	       out_filter013 WHEN "01"  , -- Gauss 3x3	
	       out_filter103 WHEN "10"  , -- Gauss 5x5
	       out_filter113 WHEN "11"  , -- NOP
	       "ZZZZZZZZ"    WHEN OTHERS;

	
END filter_IP_arch;
