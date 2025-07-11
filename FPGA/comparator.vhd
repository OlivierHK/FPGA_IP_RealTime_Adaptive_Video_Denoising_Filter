
--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : comparator.vhd
--DESCRIPTION : A simple Async comparator for Network sorting.
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE work.package_type_and_contant.ALL;

ENTITY comparator IS
    PORT ( in_up    : IN   std_logic_vector(7 DOWNTO 0);
           in_down  : IN   std_logic_vector(7 DOWNTO 0);
           out_up   : OUT  std_logic_vector(7 DOWNTO 0);
           out_down : OUT  std_logic_vector(7 DOWNTO 0) 
			 );
END comparator;


ARCHITECTURE Behavioral OF comparator IS

--SIGNAL comp: std_logic;

BEGIN

	out_up   <= in_up   WHEN (in_up > in_down) ELSE in_down;
	out_down <= in_down WHEN (in_up > in_down) ELSE in_up  ;
	
end Behavioral;

