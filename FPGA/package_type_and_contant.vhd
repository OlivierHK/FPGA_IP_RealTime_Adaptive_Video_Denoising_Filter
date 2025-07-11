
--------------------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------------------
--FILE        : type_perso.vhd
--DESCRIPTION : Package of type for easier code representation of arrays and pixel.        
---------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.NUMERIC_STD.ALL;

PACKAGE package_type_and_contant IS
	SUBTYPE type_pixel      IS std_logic_vector(7 DOWNTO 0);                       -- 8-bits Pixel subtype definition.
	TYPE    type_mask       IS ARRAY(24 DOWNTO 0) OF type_pixel;                   -- 5x5 Block of Pixel represented as a 1 Dimension array of 25 elements.
	TYPE    type_cwm_y      IS ARRAY(38 DOWNTO 0) OF type_pixel;                   -- 39 elemnets array of pixels used for CWM filter.
	TYPE    small_mask      IS ARRAY(8  DOWNTO 0) OF type_pixel;                   -- 3x3 Block of Pixel represented as a 1 Dimension array of 9 elements. 
	TYPE    small_mask_mult IS ARRAY(8  DOWNTO 0) OF std_logic_vector(9 DOWNTO 0); -- exented pixel size of a 3x3 block for avoinding overflow.
	TYPE    type_mask_5     IS ARRAY(4  DOWNTO 0) OF type_pixel;                   -- 5 elements of pixel to represent in-stream data.

	constant T1: integer RANGE 0 to 255 := 20;
	constant T2: integer RANGE 0 to 255 := 20;
	constant T3: integer RANGE 0 to 255 := 20;
	constant T4: integer RANGE 0 to 255 := 20;
END package_type_and_contant;