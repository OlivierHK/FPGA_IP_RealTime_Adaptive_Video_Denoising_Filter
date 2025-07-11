
--------------------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------------------
--FILE        : filters_package.vhd
--DESCRIPTION : Package containing all the filters of the IP: 
--              * CWM Filter (Weighted 15) => remove impulsive noise.
-- 				* Gauss 3x3                => remove Gaussian noise on middle detailed area.
--              * Gaus 5x5                 => remove Gaussian noise on low detailed area.
--              * NOP                      => No operation on high-detailed area or others.
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.MATH_REAL.ALL;

USE work.package_type_and_contant.ALL;


PACKAGE filter IS
	COMPONENT control		
		PORT (
			kernel                   : IN  type_mask                      ;
 
			kernel_out               : OUT type_mask                      ;
			sort                     : OUT type_mask                      ;
			out_control              : OUT std_logic_vector( 1 DOWNTO 0 ) ;
			indice_min1, indice_min2 : OUT integer RANGE 0 TO 24          ;
			indice_max1, indice_max2 : OUT integer RANGE 0 TO 24          ;
			clk                      : IN  std_logic
		);
		
	END COMPONENT ;
	
	
	COMPONENT cwm
		PORT (
			--clk : IN std_logic ;
			sort         : IN type_mask   ;
			value_centre : IN type_pixel  ;

			out_filter00 : OUT type_pixel
		);
		
	END COMPONENT ;
	

	COMPONENT gauss3x3
		PORT (
			--clk : IN std_logic ;
			kernel_out               : IN type_mask             ;
			indice_min1, indice_min2 : IN integer RANGE 0 TO 24 ;
			indice_max1, indice_max2 : IN integer RANGE 0 TO 24 ;
 
			out_filter01             : OUT type_pixel
		);
		
	END COMPONENT ;
	

	COMPONENT gauss5x5
		PORT (
			clk                      : IN std_logic             ;
			kernel_out               : IN type_mask             ;
			indice_min1, indice_min2 : IN integer RANGE 0 TO 24 ;
			indice_max1, indice_max2 : IN integer RANGE 0 TO 24 ;
 
			out_filter10             : OUT type_pixel
		);
		
	END COMPONENT ;

	
	COMPONENT nop
		PORT (
			--clk : IN std_logic ;
			kernel_out   : IN  type_mask ;
			out_filter11 : OUT type_pixel
		);
		
	END COMPONENT ;	
	

--	COMPONENT big_or
--		PORT (
--			out_control  : IN std_logic_vector( 1 DOWNTO 0) ;
--			out_filter00 : IN type_pixel                    ;
--			out_filter01 : IN type_pixel                    ;
--			out_filter10 : IN type_pixel                    ;
--			out_filter11 : IN type_pixel                    ;
--			--clock : IN std_logic ;
--			pixel        : OUT type_pixel
--		);
--		
--	END COMPONENT ;
--	
END filter;




------------------------------------------------------------------------------------
-----------------------------CWM Filter (W= 15)-------------------------------------
------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.type_perso.ALL;
USE ieee.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY cwm IS
	PORT (
		--clk : IN std_logic ;
		sort         : IN  type_mask ;
		value_centre : IN  type_pixel;
		out_filter00 : OUT type_pixel
		);
END cwm;


ARCHITECTURE cwm_arch OF cwm IS
	
	SIGNAL tab_bin    : std_logic_vector (24 DOWNTO 0) := (OTHERS => '0')            ; -- Binary array of all 5x5Kernel center pixel found inside the 25-sorted array.
	SIGNAL tab_comp   : std_logic_vector (24 DOWNTO 0) := (OTHERS => '0')            ; -- Find highest index inside tab_bin.
	SIGNAL binary     : integer RANGE 0 TO 33554431    := 0                          ; -- tab_bin array converted to an integer for easier computation.
	SIGNAL indice_out : integer RANGE 0 TO 24          := 0                          ; -- The index of the 5x5Kernel center pixel inside the 25-sorted array.
	SIGNAL tab_y      : type_cwm_y                     := (others => (others => '0')); -- 39 elements array (25+14).
	
	BEGIN
	
	assign:FOR k IN 0 TO 24 GENERATE
   BEGIN
		--first LUT -> value look for : take '1' if found, else'0'...Give "0001110000000...."
        tab_bin(k)<='1' WHEN (sort(k) = value_centre) ELSE '0';   
   END GENERATE assign;
	
	binary <= to_integer(unsigned(tab_bin)) ;--convert to integer

    tab_comp(0) <='1' WHEN(binary < 2                            ) ELSE '0'; --second LUT -> look for the greater '1'... Give "000100000..."
	tab_comp(1) <='1' WHEN(binary > 1       AND binary < 4       ) ELSE '0';
	tab_comp(2) <='1' WHEN(binary > 3       AND binary < 8       ) ELSE '0';
	tab_comp(3) <='1' WHEN(binary > 7       AND binary < 16      ) ELSE '0';
	tab_comp(4) <='1' WHEN(binary > 15      AND binary < 32      ) ELSE '0';
	tab_comp(5) <='1' WHEN(binary > 31      AND binary < 64      ) ELSE '0';
	tab_comp(6) <='1' WHEN(binary > 63      AND binary < 128     ) ELSE '0';
	tab_comp(7) <='1' WHEN(binary > 127     AND binary < 256     ) ELSE '0';
	tab_comp(8) <='1' WHEN(binary > 255     AND binary < 512     ) ELSE '0';
	tab_comp(9) <='1' WHEN(binary > 511     AND binary < 1024    ) ELSE '0';
	tab_comp(10)<='1' WHEN(binary > 1023    AND binary < 2048    ) ELSE '0';
	tab_comp(11)<='1' WHEN(binary > 2047    AND binary < 4096    ) ELSE '0';
	tab_comp(12)<='1' WHEN(binary > 4095    AND binary < 8192    ) ELSE '0';
	tab_comp(13)<='1' WHEN(binary > 8191    AND binary < 16384   ) ELSE '0';
	tab_comp(14)<='1' WHEN(binary > 16383   AND binary < 32768   ) ELSE '0';
	tab_comp(15)<='1' WHEN(binary > 32767   AND binary < 65536   ) ELSE '0';
	tab_comp(16)<='1' WHEN(binary > 65535   AND binary < 131072  ) ELSE '0';
	tab_comp(17)<='1' WHEN(binary > 131071  AND binary < 262144  ) ELSE '0';
	tab_comp(18)<='1' WHEN(binary > 262143  AND binary < 524288  ) ELSE '0';
	tab_comp(19)<='1' WHEN(binary > 524287  AND binary < 1048576 ) ELSE '0';
	tab_comp(20)<='1' WHEN(binary > 1048575 AND binary < 2097152 ) ELSE '0';
	tab_comp(21)<='1' WHEN(binary > 2097151 AND binary < 4194304 ) ELSE '0';
	tab_comp(22)<='1' WHEN(binary > 4194303 AND binary < 8388608 ) ELSE '0';
	tab_comp(23)<='1' WHEN(binary > 8388607 AND binary < 16777216) ELSE '0';
	tab_comp(24)<='1' WHEN(binary > 16777215) ELSE '0';
	
	
   WITH tab_comp SELECT --third LUT, Greater '1' convert to integer (the adress)
  indice_out <=    --0  WHEN  "0000000000000000000000001",
					 1  WHEN  "0000000000000000000000010",
					 2  WHEN  "0000000000000000000000100",
					 3  WHEN  "0000000000000000000001000",
					 4  WHEN  "0000000000000000000010000",
					 5  WHEN  "0000000000000000000100000",
					 6  WHEN  "0000000000000000001000000",
					 7  WHEN  "0000000000000000010000000",
					 8  WHEN  "0000000000000000100000000",
					 9  WHEN  "0000000000000001000000000",
					 10 WHEN  "0000000000000010000000000",
					 11 WHEN  "0000000000000100000000000",
					 12 WHEN  "0000000000001000000000000",
					 13 WHEN  "0000000000010000000000000",
					 14 WHEN  "0000000000100000000000000",
					 15 WHEN  "0000000001000000000000000",
					 16 WHEN  "0000000010000000000000000",
					 17 WHEN  "0000000100000000000000000",
					 18 WHEN  "0000001000000000000000000",
					 19 WHEN  "0000010000000000000000000",
					 20 WHEN  "0000100000000000000000000",
					 21 WHEN  "0001000000000000000000000",
					 22 WHEN  "0010000000000000000000000",
					 23 WHEN  "0100000000000000000000000",
					 24 WHEN  "1000000000000000000000000",
                      0 WHEN OTHERS;
	
	--centre value insertion (centre value is weighted x15 times)
	WITH indice_out SELECT	
		tab_y<=   (sort(0),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),sort(1),
				  sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),
				  sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 1,
				  
				  (sort(0),sort(1),
				  sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),sort(2),
				  sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),
				  sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 2,
				  
				  (sort(0),sort(1),sort(2),
				  sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),sort(3),
				  sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),
				  sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 3,
				  
				  (sort(0),sort(1),sort(2),sort(3),
				  sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),sort(4),
				  sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 4,


				  (sort(0),sort(1),sort(2),sort(3),sort(4),
				  sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),sort(5),
				  sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 5,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),
					sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),sort(6),
					sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				   sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
					WHEN 6,

				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),
				  sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),sort(7),
				  sort(8),sort(9),sort(10),sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 7,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),
				  sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),sort(8),
				  sort(9),sort(10),sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 8,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),
				  sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),sort(9),
				  sort(10),sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 9,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),
				  sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),sort(10),
				  sort(11),sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 10,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),
				  sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 11,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),sort(12),
				  sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 12,
				  
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),
				  sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),sort(13),
				  sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 13,

				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),
				  sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),sort(14),
				  sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 14,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),			  
				  sort(15),sort(15),sort(15),sort(15),sort(15),sort(15),sort(15),sort(15),sort(5),sort(15),sort(15),sort(15),sort(15),sort(15),sort(15),
				  sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 15,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),
				  sort(16),sort(16),sort(6),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),sort(16),
				  sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
			     WHEN 16,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),
				  sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),sort(17),
				  sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 17,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),
				  sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),sort(18),
				  sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 18,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),
				  sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),sort(19),
				  sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN 19,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),
				  sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),sort(20),
				  sort(21),sort(22),sort(23),sort(24))
				  WHEN 20,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),
				  sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),sort(21),
				  sort(22),sort(23),sort(24))
				  WHEN 21,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),
				  sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),sort(22),
				  sort(23),sort(24))
				  WHEN 22,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),
				  sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),sort(23),
				  sort(24))
				  WHEN 23,
				  
				  (sort(0),sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),
				  sort(12),sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),
				  sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24),sort(24))
				  WHEN 24,
				  
				  (sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),sort(0),
				  sort(1),sort(2),sort(3),sort(4),sort(5),sort(6),sort(7),sort(8),sort(9),sort(10),sort(11),sort(12),
				  sort(13),sort(14),sort(15),sort(16),sort(17),sort(18),sort(19),sort(20),sort(21),sort(22),sort(23),sort(24))
				  WHEN OTHERS;

		--the centered pixel of the weighted and sorted 39 element array is extracted and outputed.  
		out_filter00<=tab_y(19);
		
END cwm_arch;




------------------------------------------------------------------------------------
----------------------------Gauss 3x3 Filter----------------------------------------
------------------------------------------------------------------------------------
--
--       Index Table       Gauss3x3 Coefficient table
--    |----|----|----|         |----|----|----|
--    |  0 |  1 |  2 |         |  1 |  2 |  1 |
--    |----|----|----|         |----|----|----|
--    |  3 |  4 |  5 |         |  2 |  3 |  2 | / 15
--    |----|----|----|         |----|----|----|
--    |  6 |  7 |  8 |         |  1 |  2 |  1 | 
--    |----|----|----|         |----|----|----|
--                          
-------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.type_perso.ALL;
USE ieee.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY gauss3x3 IS
	PORT (
		--clk : IN std_logic ;
		kernel_out               : IN  type_mask             ;
		indice_min1, indice_min2 : IN  integer RANGE 0 TO 24 ;
		indice_max1,indice_max2  : IN  integer RANGE 0 TO 24 ;

		out_filter01             : OUT type_pixel
	);		
END gauss3x3;


ARCHITECTURE gauss3x3_arch OF gauss3x3 IS
	SIGNAL out_mux001  : type_mask                     := (others => (others => '0')) ;
	SIGNAL mask        : small_mask                    := (others => (others => '0')) ;
	SIGNAL mask_mult   : small_mask_mult               := (others => (others => '0')) ;
	SIGNAL sum_int     : integer RANGE 0 TO 4080       := 0                           ;
	SIGNAL sum_byte    : std_logic_vector(11 DOWNTO 0) := (others => '0')             ;
	SIGNAL sum_byte_x17: std_logic_vector(15 DOWNTO 0) := (others => '0')             ;
	--SIGNAL sortie: type_pixel;

BEGIN
	assign:FOR I IN 0 TO 24 GENERATE
		out_mux001(I)<= kernel_out(12) WHEN (indice_min1=I) ELSE    --
			            kernel_out(12) WHEN (indice_min2=I) ELSE    -- Exclusion of the two maximas and two minimas.  replaced by center pixel value.
			            kernel_out(12) WHEN (indice_max1=I) ELSE    --
			            kernel_out(12) WHEN (indice_max2=I) ELSE    --
			            kernel_out(I);
	END GENERATE assign;

	--Small mask 3x3 fetching
	mask(0)<=out_mux001(6);-----
	mask(1)<=out_mux001(7);------
	mask(2)<=out_mux001(8);-------
	mask(3)<=out_mux001(11);-------
	mask(4)<=out_mux001(12);--------centre pixel
	mask(5)<=out_mux001(13);-------
	mask(6)<=out_mux001(16);------
	mask(7)<=out_mux001(16);-----
	mask(8)<=out_mux001(18);----
	
	--multiplication by bit-shifting
	mask_mult(0)<="00" & mask(0);-----------x1
	mask_mult(2)<="00" & mask(2);-----------x1
	mask_mult(6)<="00" & mask(6);-----------x1
	mask_mult(8)<="00" & mask(8);-----------x1

	mask_mult(1)<= "0" & mask(1)& "0" ;-----x2
	mask_mult(3)<= "0" & mask(3)& "0" ;-----x2
	mask_mult(5)<= "0" & mask(5)& "0" ;-----x2
	mask_mult(7)<= "0" & mask(7)& "0" ;-----x2

	mask_mult(4)<= (mask(4) & "00") - ("00" & mask(4)) ;-----x3 =(4-1)
	
	--addition~conversion to integer. add are done two-by-two, in a tree-way, to ease Synthesis and parallelized adder,
	sum_int     <= (((to_integer(unsigned(mask_mult(0)))   +  to_integer(unsigned(mask_mult(1))))  +(to_integer(unsigned(mask_mult(2)))
		            + to_integer(unsigned(mask_mult(3))))) +((to_integer(unsigned(mask_mult(4)))   + to_integer(unsigned(mask_mult(5))))
	                +(to_integer(unsigned(mask_mult(6)))   +  to_integer(unsigned(mask_mult(7))))))+ to_integer(unsigned(mask_mult(8)));
	
	--conversion to std_logic_vector of 12-bit to avoid overflow
	sum_byte    <= std_logic_vector( to_unsigned( sum_int, 12 ));

	--multiply by 17 = 16+1
	sum_byte_x17 <= (sum_byte&"0000") + ("0000"&sum_byte); --x17
	
	--division by 16 by bit-shifting and wire to output module. add little error as should be 15. Can do (value X256/17) for exact division. but will impact critical path.
	--out_filter01<= sum_byte(11 DOWNTO 4);	

	--divide by 256 by bit-shifting and wire to output module.
	out_filter01<= sum_byte_x17(15 DOWNTO 8); --256/17= 15.2588. Error max is (-1) on a (255) pixel, so negligible.
	

END gauss3x3_arch;


------------------------------------------------------------------------------------
----------------------------Gauss 5x5 Filter----------------------------------------
------------------------------------------------------------------------------------
--
--            Index Table              Gauss5x5 Coefficient table
--    |----|----|----|----|----|       |----|----|----|----|----|
--    |  0 |  1 |  2 |  3 |  4 |       |  1 |  4 |  7 |  4 |  1 |
--    |----|----|----|----|----|       |----|----|----|----|----|
--    |  5 |  6 |  7 |  8 |  9 |       |  4 | 18 | 30 | 18 |  4 |
--    |----|----|----|----|----|       |----|----|----|----|----|
--    | 10 | 11 | 12 | 13 | 14 |       |  7 | 30 | 50 | 30 |  7 | / 306
--    |----|----|----|----|----|       |----|----|----|----|----|
--    | 15 | 16 | 17 | 18 | 19 |       |  4 | 18 | 30 | 18 |  4 |
--    |----|----|----|----|----|       |----|----|----|----|----|
--    | 20 | 21 | 22 | 23 | 24 |       |  1 |  4 |  7 |  4 |  1 |
--    |----|----|----|----|----|       |----|----|----|----|----|
--
-------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.type_perso.ALL;
USE ieee.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY gauss5x5 IS
		PORT (
			clk                      : IN  std_logic             ;
			kernel_out               : IN  type_mask             ;
			indice_min1, indice_min2 : IN  integer RANGE 0 TO 24 ;
			indice_max1, indice_max2 : IN  integer RANGE 0 TO 24 ;

			out_filter10             : OUT type_pixel
		     );
END gauss5x5 ;

ARCHITECTURE gauss5x5_arch OF gauss5x5 IS
	
	SIGNAL out_mux010                                                   : type_mask                      := (others => (others => '0')) ;
	                    
	TYPE type_mult IS ARRAY(24 DOWNTO 0) OF std_logic_vector(16 DOWNTO 0) ;	                    
	SIGNAL mult                                                         : type_mult                      := (others => (others => '0')) ;
	
	SIGNAL mult_7_2_8, mult_7_10_8, mult_7_14_8, mult_7_22_8            : STD_logic_vector (10 DOWNTO 0) := (others => '0')             ;
	SIGNAL mult_7_2,   mult_7_10,   mult_7_14,   mult_7_22              : integer RANGE 0 TO 1785        := 0                           ;             
	             
	SIGNAL mult_18_6_16,  mult_18_6_2,   mult_18_8_16,   mult_18_8_2    : std_logic_vector(15 DOWNTO 0)  := (others => '0')             ;
	SIGNAL mult_18_16_2,  mult_18_16_16, mult_18_18_2,   mult_18_18_16  : std_logic_vector(15 DOWNTO 0)  := (others => '0')             ;
	SIGNAL mult_18_6_int, mult_18_8_int, mult_18_16_int, mult_18_18_int : integer RANGE 0 TO 4590        := 0                           ;             
	SIGNAL mult_30_7_32,  mult_30_11_32, mult_30_13_32,  mult_30_17_32  : std_logic_vector(12 DOWNTO 0)  := (others => '0')             ;
	SIGNAL mult_30_7_2,   mult_30_11_2,  mult_30_13_2,   mult_30_17_2   : std_logic_vector(8  DOWNTO 0)  := (others => '0')             ;
	SIGNAL mult_30_7,     mult_30_11,    mult_30_13,     mult_30_17     : integer RANGE 0 TO 7650        := 0                           ;             
	                    
	SIGNAL mult_50_12_32, mult_50_12_16, mult_50_12_2                   : std_logic_vector(15 DOWNTO 0)  := (others => '0')             ;
	SIGNAL mult_50_12_int                                               : integer RANGE 0 TO 12750       := 0                           ;
	                  
	SIGNAL sum_int                                                      : integer RANGE 0 TO 78030       := 0                           ;
	SIGNAL sum_int_a                                                    : integer RANGE 0 TO 78030       := 0                           ;--caution
	     
	SIGNAL sum_int_1,    sum_int_1_a                                    : integer RANGE 0 TO 78030       := 0                           ;--
	SIGNAL sum_int_2,    sum_int_2_a                                    : integer RANGE 0 TO 78030       := 0                           ;----
	SIGNAL sum_int_3,    sum_int_3_a                                    : integer RANGE 0 TO 78030       := 0                           ;---- temporal signal for the pipeline
	SIGNAL sum_int_4,    sum_int_4_a                                    : integer RANGE 0 TO 78030       := 0                           ;--
	SIGNAL sum_int_5_a , sum_int_5                                      : integer RANGE 0 TO 78030       := 0                           ;
	SIGNAL sum_int_6_a , sum_int_6                                      : integer RANGE 0 TO 78030       := 0                           ;
	SIGNAL sum_int_7_a , sum_int_7                                      : integer RANGE 0 TO 78030       := 0                           ;

	SIGNAL sum_std                                                      : std_logic_vector(16 DOWNTO 0)  := (others => '0')             ;
	                                               
	                                               
	SIGNAL sum_std_128                                                  : std_logic_vector(23 DOWNTO 0)  := (others => '0')             ;
	SIGNAL sum_std_16                                                   : std_logic_vector(23 DOWNTO 0)  := (others => '0')             ;
	SIGNAL sum_std_4                                                    : std_logic_vector(23 DOWNTO 0)  := (others => '0')             ;
	SIGNAL sum_std23                                                    : std_logic_vector(23 DOWNTO 0)  := (others => '0')             ;
	SIGNAL sum_std_tot                                                  : std_logic_vector(22 DOWNTO 0)  := (others => '0')             ;
	SIGNAL sum_int_tot                                                  : integer RANGE 0 TO 9987841     := 0                           ;

	BEGIN	
	
	-- exlusion of the two maximas and two minimas. Replaced by center pixel value.
	assign:FOR I IN 0 TO 24 GENERATE
		out_mux010(I)<=kernel_out(12) WHEN((indice_min1=I)) ELSE --
			           kernel_out(12) WHEN((indice_min2=I)) ELSE --
			           kernel_out(12) WHEN((indice_max1=I)) ELSE --
			           kernel_out(12) WHEN((indice_max2=I)) ELSE --
			           kernel_out(I);
	END GENERATE assign;
	--------------------------------------------------------------------------------
	

	-----------Coefficient 1, indice 0, 4, 20, 24--------------
	mult(0) <="000000000" & out_mux010(0)        ;---x1-
	mult(4) <="000000000" & out_mux010(4)        ;---x1-
	mult(20)<="000000000" & out_mux010(20)       ;---x1-
	mult(24)<="000000000" & out_mux010(24)       ;---x1-


	------Coefficient 4, indice 1, 3, 5, 9, 15, 19, 21, 23-----
	mult(1) <="0000000"   & out_mux010(1)  & "00";----x4----
	mult(3) <="0000000"   & out_mux010(3)  & "00";----x4----
	mult(5) <="0000000"   & out_mux010(5)  & "00";----x4----
	mult(9) <="0000000"   & out_mux010(9)  & "00";----x4----
	mult(15)<="0000000"   & out_mux010(15) & "00";----x4----
	mult(19)<="0000000"   & out_mux010(19) & "00";----x4----
	mult(21)<="0000000"   & out_mux010(21) & "00";----x4----
	mult(23)<="0000000"   & out_mux010(23) & "00";----x4----
	

	----------coeff 7=(8-1), indice 2-------------
	mult_7_2_8 <= out_mux010( 2) & "000";
	mult_7_2   <= to_integer(unsigned(mult_7_2_8))  - to_integer(unsigned(out_mux010(2)));
	----------coeff 7=(8-1), indice 10-------------
	mult_7_10_8<= out_mux010(10) & "000";
	mult_7_10  <= to_integer(unsigned(mult_7_10_8)) - to_integer(unsigned(out_mux010(10)));	
	----------coeff 7=(8-1), indice 14-------------
	mult_7_14_8<= out_mux010(14) & "000";
	mult_7_14  <= to_integer(unsigned(mult_7_14_8)) - to_integer(unsigned(out_mux010(14)));
	----------coeff 7=(8-1), indice 22-------------
	mult_7_22_8<= out_mux010(22) & "000";
	mult_7_22  <= to_integer(unsigned(mult_7_22_8)) - to_integer(unsigned(out_mux010(22)));


	----------coeff 18=(16+2), indice 6------------
	mult_18_6_16  <="0000"    & out_mux010(6)  & "0000";
	mult_18_6_2   <="0000000" & out_mux010(6)  & "0"   ;
	mult_18_6_int <= to_integer(unsigned(mult_18_6_16)) + to_integer(unsigned(mult_18_6_2));
	----------coeff 18=(16+2), indice 8------------
	mult_18_8_16  <="0000"    & out_mux010(8)  & "0000";
	mult_18_8_2   <="0000000" & out_mux010(8)  & "0"   ;
	mult_18_8_int <= to_integer(unsigned(mult_18_8_16)) + to_integer(unsigned(mult_18_8_2));
	----------coeff 18=(16+2), indice 16------------
	mult_18_16_16 <="0000"    & out_mux010(16) & "0000";
	mult_18_16_2  <="0000000" & out_mux010(16) & "0"   ;
	mult_18_16_int<= to_integer(unsigned(mult_18_16_16)) + to_integer(unsigned(mult_18_16_2));	
	----------coeff 18=(16+2), indice 18------------
	mult_18_18_16 <="0000"    & out_mux010(18) & "0000";
	mult_18_18_2  <="0000000" & out_mux010(18) & "0"   ;
	mult_18_18_int<= to_integer(unsigned(mult_18_18_16)) + to_integer(unsigned(mult_18_18_2));
	

	----------coeff 30=(32-2), indice 7-------------
	mult_30_7_32 <= out_mux010(7)  & "00000"  ;
	mult_30_7_2  <= out_mux010(7)  & "0"      ;
	mult_30_7    <= to_integer(unsigned(mult_30_7_32)) - to_integer(unsigned(mult_30_7_2));
	----------coeff 30=(32-2), indice 11-------------
	mult_30_11_32<= out_mux010(11) & "00000"  ;
	mult_30_11_2 <= out_mux010(11) & "0"      ;
	mult_30_11   <= to_integer(unsigned(mult_30_11_32)) - to_integer(unsigned(mult_30_11_2));
	----------coeff 30=(32-2), indice 13-------------	
	mult_30_13_32<= out_mux010(13) & "00000"  ;
	mult_30_13_2 <= out_mux010(13) & "0"      ;
	mult_30_13   <= to_integer(unsigned(mult_30_13_32)) - to_integer(unsigned(mult_30_13_2));
	----------coeff 30=(32-2), indice 17-------------
	mult_30_17_32<= out_mux010(17) & "00000"  ;
	mult_30_17_2 <= out_mux010(17) & "0"      ;
	mult_30_17   <= to_integer(unsigned(mult_30_17_32)) - to_integer(unsigned(mult_30_17_2));
	
	
	---------coeff 50=(32+16+2), indice 12--------------
	mult_50_12_32 <= "000"     & out_mux010(16) & "00000";
	mult_50_12_16 <= "0000"    & out_mux010(16) & "0000" ;
	mult_50_12_2  <= "0000000" & out_mux010(16) & "0"    ;
	mult_50_12_int<= (to_integer(unsigned(mult_50_12_16)) + to_integer(unsigned(mult_50_12_2)))+ to_integer(unsigned(mult_50_12_32)); --(a+b)+c tree-adder.	
	
	------------------------------------------------------
	-- adding all computed values in a tree-adder fashion for better timing.			  
	sum_int_1<= ((to_integer(unsigned(mult(0))) + to_integer(unsigned(mult(1))))  + (to_integer(unsigned(mult(3))) + to_integer(unsigned(mult(4)))));
	           
	sum_int_2<= ((to_integer(unsigned(mult(9))) + to_integer(unsigned(mult(19)))) + (to_integer(unsigned(mult(24)))+ to_integer(unsigned(mult(23)))));
				   			  
	sum_int_3<= ((to_integer(unsigned(mult(20)))+ to_integer(unsigned(mult(21)))) + (to_integer(unsigned(mult(15)))+ to_integer(unsigned(mult(5)))));
	            

	sum_int_4<= ((mult_18_6_int + mult_18_8_int) + (mult_18_16_int + mult_18_18_int));   
				  
				  
	sum_int_5<= ((mult_7_2  + mult_7_10)  + (mult_7_14  + mult_7_22)) ;

	sum_int_6<= ((mult_30_7 + mult_30_11) + (mult_30_13 + mult_30_17));
				  
	sum_int_7<= mult_50_12_int ; 	 
 

 	--pipelining step to break and shorten timing critical path.
 	PROCESS(clk)
		BEGIN
			IF(RISING_EDGE(clk)) THEN
			sum_int_1_a <= sum_int_1;
			sum_int_2_a <= sum_int_2;
			sum_int_3_a <= sum_int_3;
			sum_int_4_a <= sum_int_4;
			sum_int_5_a <= sum_int_5;
			sum_int_6_a <= sum_int_6;
			sum_int_7_a <= sum_int_7;
			END IF;
 	END PROCESS;	
 
 	--we give 1 full clock cycel for this operation line.
	sum_int <= (((sum_int_1_a+sum_int_2_a) + (sum_int_3_a+sum_int_4_a)) + ((sum_int_5_a + sum_int_6_a) + sum_int_7_a)); -- ((a+b)+(c+d)) + ((e+f)+g) adder-tree.

	--pipeline the final sum.
 	PROCESS(clk)
		BEGIN
			IF(RISING_EDGE(clk)) THEN
			sum_int_a   <= sum_int  ;
			END IF;
 	END PROCESS;	

	--convert back in to SLV [23:0] for binary operation
	sum_std     <= std_logic_vector( to_unsigned( sum_int_a,17));
	sum_std23   <= "0000000" & sum_std;
	
	----------multiplication by 107= 128-(16+4+1)------   
	sum_std_128 <= sum_std & "0000000"         ;
	sum_std_16  <= "000"   & sum_std   & "0000";   --(2^15)/107=306.243...  (2^15) is "power of two"" with the closest value to 306.00. We need to truncate here.
	sum_std_4   <= "00000" & sum_std   & "00"  ;   -- error added is max under 1 pixel value, so negligible.
	

	-------------------summation----------------------
	sum_int_tot <= ( to_integer(unsigned(sum_std_128)) - to_integer(unsigned(sum_std_16)) ) - ( to_integer(unsigned(sum_std_4)) + to_integer(unsigned(sum_std23)) );
	sum_std_tot <= std_logic_vector( to_unsigned( sum_int_tot,23));
	

	----division by 2^15 and wire out the result------
	out_filter10<=sum_std_tot(22 DOWNTO 15);
	
END gauss5x5_arch;


------------------------------------------------------------------------------------
----------------------------no operation filter-------------------------------------
------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.type_perso.ALL;
USE ieee.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY nop IS
	PORT (
		--clk : IN std_logic ;
		kernel_out   : IN  type_mask ;
		out_filter11 : OUT type_pixel
	);
END nop ;


ARCHITECTURE nop_arch OF nop IS
BEGIN
	out_filter11<= kernel_out(12); 
END nop_arch;
