--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : stream_to_kernel5x5.vhd
--DESCRIPTION : Take a row of 5x1 Pixels input and build a 5x5 kernel.  
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.NUMERIC_STD.ALL;
USE work.package_type_and_contant.ALL;

ENTITY stream_to_kernel5x5 IS
    PORT ( 
		clk       : IN   STD_LOGIC  ;
		--rst     : IN   STD_LOGIC  ;		
		in_stream : IN   type_mask_5;	
		out_kernel: OUT  type_mask
	); 
END stream_to_kernel5x5;

ARCHITECTURE Behavioral OF stream_to_kernel5x5 IS

SIGNAL interne: type_mask := (others => (others => '0'));
	
BEGIN

--Filling up first row of the kernen
PROCESS(clk)
		BEGIN
		IF(RISING_EDGE(clk)) THEN
			interne(4) <=in_stream(0); 
			interne(9) <=in_stream(1);
			interne(14)<=in_stream(2);
			interne(19)<=in_stream(3);
			interne(24)<=in_stream(4);
		END IF;
END PROCESS;

--pipelining the 4 remaining Lines
boucle1: FOR j IN 1 TO 4 GENERATE
	PROCESS(clk)
		BEGIN
		IF(RISING_EDGE(clk)) THEN
			interne(j-1    )<=interne(j    );
			interne(j-1 +5 )<=interne(j +5 );
			interne(j-1 +10)<=interne(j +10);
			interne(j-1 +15)<=interne(j +15);
			interne(j-1 +20)<=interne(j +20);
		END IF;
	END PROCESS;
END GENERATE;

 
out_kernel(0) <=interne(0 ); 
out_kernel(1) <=interne(1 );
out_kernel(2) <=interne(2 );
out_kernel(3) <=interne(3 );
out_kernel(4) <=interne(4 );
out_kernel(5) <=interne(5 );
out_kernel(6) <=interne(6 );	
out_kernel(7) <=interne(7 );	
out_kernel(8) <=interne(8 );	
out_kernel(9) <=interne(9 );	
out_kernel(10)<=interne(10);	
out_kernel(11)<=interne(11);	
out_kernel(12)<=interne(12);	
out_kernel(13)<=interne(13);	
out_kernel(14)<=interne(14);	
out_kernel(15)<=interne(15);	
out_kernel(16)<=interne(16);	
out_kernel(17)<=interne(17);	
out_kernel(18)<=interne(18);	
out_kernel(19)<=interne(19);	
out_kernel(20)<=interne(20);	
out_kernel(21)<=interne(21);	
out_kernel(22)<=interne(22);	
out_kernel(23)<=interne(23);	
out_kernel(24)<=interne(24);	
	
END Behavioral;

