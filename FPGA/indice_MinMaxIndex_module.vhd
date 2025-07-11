
--------------------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------------------
--FILE        : indice_MinMaxIndex_module.vhd
--DESCRIPTION :  provide index of the indice wanted. index from sorted array is a generic statement.           
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.package_type_and_contant.ALL;

entity indice_MinMaxIndex_module is
    generic(
    	INDEX      : integer RANGE 0 to 24 := 0
    );
    Port ( 
    	kernel     : IN type_mask;               --mask array
        sort_25    : IN type_mask;               --sorted array
        indice_out : OUT integer RANGE 0 TO 24); --output adress
end indice_MinMaxIndex_module;

architecture indice_arch of indice_MinMaxIndex_module is

	SIGNAL tab_bin  : std_logic_vector (24 DOWNTO 0)  := (others => '0') ;
	SIGNAL tab_comp : std_logic_vector (24 DOWNTO 0)  := (others => '0') ;
	SIGNAL binary   : integer RANGE 0 TO 67108863     := 0               ;

begin

	
	assign:FOR k IN 0 TO 24 GENERATE
   BEGIN
        tab_bin(k)<='1' WHEN (kernel(k)=sort_25(INDEX)) ELSE '0';  --first LUT -> value look for '1' else'0'
   END GENERATE assign;
	
	binary <= to_integer(unsigned(tab_bin)) ;--convert to integer

    tab_comp(0) <='1' WHEN(binary < 2                            ) ELSE '0';--second LUT -> look for the greater '1'
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
	
	
   WITH tab_comp SELECT                               --third LUT, Greater '1' convert to integer (the adress)
  indice_out <=--0 WHEN  "0000000000000000000000001",
                1  WHEN "0000000000000000000000010",
				2  WHEN "0000000000000000000000100",
				3  WHEN "0000000000000000000001000",
				4  WHEN "0000000000000000000010000",
				5  WHEN "0000000000000000000100000",
				6  WHEN "0000000000000000001000000",
				7  WHEN "0000000000000000010000000",
				8  WHEN "0000000000000000100000000",
				9  WHEN "0000000000000001000000000",
				10 WHEN "0000000000000010000000000",
				11 WHEN "0000000000000100000000000",
				12 WHEN "0000000000001000000000000",
				13 WHEN "0000000000010000000000000",
				14 WHEN "0000000000100000000000000",
				15 WHEN "0000000001000000000000000",
				16 WHEN "0000000010000000000000000",
				17 WHEN "0000000100000000000000000",
				18 WHEN "0000001000000000000000000",
				19 WHEN "0000010000000000000000000",
				20 WHEN "0000100000000000000000000",
				21 WHEN "0001000000000000000000000",
				22 WHEN "0010000000000000000000000",
				23 WHEN "0100000000000000000000000",
				24 WHEN "1000000000000000000000000",
                0  WHEN OTHERS;
end indice_arch;