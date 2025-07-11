
--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : control.vhd
--DESCRIPTION : filter control module. Take the 5x5 kernel as input, 
--              instanciates the sorting module, compute all the needed 
-- 				parameters and output the pipelined 5x5 kernel, the 5x5 sorted 
--              kernel, indexed needed indices and the filter arbitration result.   
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.filter.ALL;
USE work.package_type_and_contant.ALL;

ENTITY control IS
	PORT (
		kernel                   : IN  type_mask                      ;

		kernel_out               : OUT type_mask                      ;
		sort                     : OUT type_mask                      ;
		out_control              : OUT std_logic_vector( 1 DOWNTO 0 ) ;
		indice_min1, indice_min2 : OUT integer RANGE 0 TO 24          ;
		indice_max1,indice_max2  : OUT integer RANGE 0 TO 24          ;
		clk                      : IN  std_logic
	);		
END control ;


ARCHITECTURE control_arch OF control IS

	--------------------------------------------------
	COMPONENT sort_batcher
		PORT(
			clk    : IN  std_logic;
			kernel : IN  type_mask;
	    	sort_25: OUT type_mask
		);
	END COMPONENT;	 
	--------------------------------------------------

	--------------------------------------------------
	COMPONENT indice_MinMaxIndex_module is
    	GENERIC(
    		INDEX      : integer RANGE 0 to 24 := 0
    	);
    	PORT( 
    		kernel     : IN type_mask;               --mask array
        	sort_25    : IN type_mask;               --sorted array
        	indice_out : OUT integer RANGE 0 TO 24   --output indexed address
    	); 
	END COMPONENT;
	--------------------------------------------------

	
	
	TYPE   edge_mask    IS ARRAY(4 DOWNTO 0) OF type_pixel             ;
	TYPE   mask_integer IS ARRAY(4 DOWNTO 0) OF integer RANGE 0 TO 255 ;
	
	SIGNAL int_value              : mask_integer                 := (others => (0) )            ; --integer values of the cross mask
	SIGNAL edge_mask_value        : edge_mask                    := (others => (others => '0')) ; --std_logic_vector values of the cross mask
	SIGNAL choice, cwm            : std_logic                    := '0'                         ; 
	SIGNAL diff                   : integer RANGE 0 TO 255       :=  0                          ;
	SIGNAL diff1,diff2,diff3,diff4: integer RANGE 0 TO 255       :=  0                          ;
	SIGNAL gauss                  : std_logic_vector(1 DOWNTO 0) := (others => '0')             ;
	SIGNAL sort_25                : type_mask                    := (others => (others => '0')) ;
	
	-----pipeline's signals--------
	SIGNAL 		choiceZ           : std_logic                    := '0' ;
	SIGNAL 		choiceZZ          : std_logic                    := '0' ;
	SIGNAL 		choiceZZZ         : std_logic                    := '0' ;
	SIGNAL 		choiceZZZZ        : std_logic                    := '0' ;
	SIGNAL 		choiceZZZZZ       : std_logic                    := '0' ;
	SIGNAL 		cwmZ              : std_logic                    := '0' ;
	SIGNAL 		cwmZZ             : std_logic                    := '0' ;
	SIGNAL 		cwmZZZ            : std_logic                    := '0' ;
	SIGNAL 		cwmZZZZ           : std_logic                    := '0' ;
	SIGNAL 		cwmZZZZZ          : std_logic                    := '0' ;
	SIGNAL 		kernelZ           : type_mask                    := (others => (others => '0')) ;
	SIGNAL 		kernelZZ          : type_mask                    := (others => (others => '0')) ;
	SIGNAL 		kernelZZZ         : type_mask                    := (others => (others => '0')) ;
	SIGNAL 		kernelZZZZ        : type_mask                    := (others => (others => '0')) ;
	SIGNAL 		kernelZZZZZ       : type_mask                    := (others => (others => '0')) ;
	-------------------------------
	
	
	BEGIN
	
	--Cross-Mask generation
	edge_mask_value (0)<= kernel( 7);
	edge_mask_value (1)<= kernel(11);
	edge_mask_value (2)<= kernel(12);--center pixel
	edge_mask_value (3)<= kernel(13);
	edge_mask_value (4)<= kernel(17);
	
	--convert to int for easier computation
	int_value(0)       <= to_integer(unsigned(edge_mask_value (0)));
	int_value(1)       <= to_integer(unsigned(edge_mask_value (1)));
	int_value(2)       <= to_integer(unsigned(edge_mask_value (2)));
	int_value(3)       <= to_integer(unsigned(edge_mask_value (3)));
	int_value(4)       <= to_integer(unsigned(edge_mask_value (4)));
	
	--Cross-Mask value calculation
	diff1              <= abs(int_value(2) - int_value(0));
	diff2              <= abs(int_value(2) - int_value(1));
	diff3              <= abs(int_value(2) - int_value(3));
	diff4              <= abs(int_value(2) - int_value(4));	        
			  
			  
	choice<= ('1') WHEN  ((diff1>T1 OR diff2>T1) OR (diff3>T1 OR diff4>T1))  ELSE  --  ('1') for going CWM min check.
	         ('0') ;		                                                       --  ('0') for going details estimator.			  
			  
	cwm   <= ('0') WHEN ((diff1<T2   OR diff2<T2)  OR (diff3<T2  OR diff4<T2))   ELSE  --  ('0') for going NOP.
	         ('1') ;		                                                       --  ('1') for going CWM Filter.		  
			

	--pipelining sequence for compensate sorting delay. 		
	PROCESS(clk)
		BEGIN
			IF(RISING_EDGE(clk))THEN
			choiceZ    <= choice;
			choiceZZ   <= choiceZ;
			choiceZZZ  <= choiceZZ;
			choiceZZZZ <= choiceZZZ;
			choiceZZZZZ<= choiceZZZZ;

			cwmZ       <= cwm;
			cwmZZ      <= cwmZ;
			cwmZZZ     <= cwmZZ;
			cwmZZZZ    <= cwmZZZ;
			cwmZZZZZ   <= cwmZZZZ;

			kernelZ    <= kernel;
			kernelZZ   <= kernelZ;
			kernelZZZ  <= kernelZZ;
			kernelZZZZ <= kernelZZZ;
			kernelZZZZZ<= kernelZZZZ;
			END IF;
	END PROCESS;		
	
	
	--Batcher's 25 algorithm.
	sort_control: sort_batcher PORT MAP(clk, kernel, sort_25);
	
	--wire sorted array to module output.
	sort<= sort_25;
	
	--extremum indices index finder (indice block).
	control_min1: indice_MinMaxIndex_module GENERIC MAP (0)  PORT MAP(kernelZZZZZ, sort_25, indice_min1);
	control_min2: indice_MinMaxIndex_module GENERIC MAP (1)  PORT MAP(kernelZZZZZ, sort_25, indice_min2);
	control_max1: indice_MinMaxIndex_module GENERIC MAP (23) PORT MAP(kernelZZZZZ, sort_25, indice_max1);
	control_max2: indice_MinMaxIndex_module GENERIC MAP (24) PORT MAP(kernelZZZZZ, sort_25, indice_max2);
	

	--calculus of the max difference in the sorted array, exclude the two first and two last [detail estimator]:
	diff       <= abs(to_integer(unsigned(sort_25(2))) - to_integer(unsigned(sort_25(22))));
	
	--Gauss filter pre-selection
	gauss      <= "01" WHEN((diff<T4) AND (diff>=T3)) ELSE  --Gauss3x3 pre-selected
	              "10" WHEN (diff<T3) ELSE                --Gauss5x5 pre-selected
	              "11";                                   --NOP pre-selected

	--Final filter selection
	out_control<= "01" WHEN ( choiceZZZZZ='0' AND gauss      ="01") ELSE --Gauss3x3 will be selected.
			      "10" WHEN ( choiceZZZZZ='0' AND gauss      ="10") ELSE --Gauss5x5 will be selected.
			      "11" WHEN ( choiceZZZZZ='0' AND gauss      ="11") ELSE --NOP will be selected (from detail estimator/Gauss sector).
			      "11" WHEN ( cwmZZZZZ   ='0' AND choiceZZZZZ='1' ) ELSE --NOP will be selected (from cross value/CWM sector).
				  "00";		                                             --CWM will be selected.
	

	--wire pipelined 5x5 Kernel to module output.						
	kernel_out<=kernelZZZZZ;
	
END control_arch;
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

