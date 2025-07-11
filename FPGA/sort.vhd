
--------------------------------------------------------------------------------
-- PROJECT    : FPGA_IP_Adaptive_filter_RealTime_Video_denoising.
--------------------------------------------------------------------------------
-- AUTHORS    : Olivier FAURIE <olivier.faurie.hk@gmail.com>
-- LICENSE    : 
-- WEBSITE    : https://github.com/olivierHK
--------------------------------------------------------------------------------
--FILE        : sort.vhd
--DESCRIPTION : An optimized 25-elements Batcher odd-even mergesort network. 
--              Optimized for less cells. the designed is pipelined to reach 
--              100MHZ on a Virtex 4 FPGA.
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
USE work.package_type_and_contant.ALL;

entity sort_batcher is
   port ( clk      : in    std_logic; 
          kernel   : in    type_mask;
          sort_25  : out   type_mask);
end sort_batcher;

architecture BEHAVIORAL of sort_batcher is
   signal XLXN_217 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_218 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_219 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_220 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_221 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_222 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_223 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_224 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_225 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_226 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_227 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_228 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_229 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_230 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_231 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_232 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_233 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_234 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_235 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_236 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_237 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_238 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_239 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_240 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_241 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_242 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_243 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_244 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_245 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_246 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_247 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_248 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_249 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_250 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_251 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_252 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_253 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_254 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_255 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_256 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_257 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_258 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_259 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_260 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_261 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_262 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_263 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_264 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_265 : std_logic_vector (7 downto 0):= (others => '0') ;
   signal XLXN_266 : std_logic_vector (7 downto 0):= (others => '0') ;
   component batcher_25
      port ( XLXN_1   : in    std_logic_vector (7 downto 0); 
             XLXN_2   : in    std_logic_vector (7 downto 0); 
             XLXN_3   : in    std_logic_vector (7 downto 0); 
             XLXN_4   : in    std_logic_vector (7 downto 0); 
             XLXN_5   : in    std_logic_vector (7 downto 0); 
             XLXN_6   : in    std_logic_vector (7 downto 0); 
             XLXN_7   : in    std_logic_vector (7 downto 0); 
             XLXN_8   : in    std_logic_vector (7 downto 0); 
             XLXN_9   : in    std_logic_vector (7 downto 0); 
             XLXN_10  : in    std_logic_vector (7 downto 0); 
             XLXN_11  : in    std_logic_vector (7 downto 0); 
             XLXN_12  : in    std_logic_vector (7 downto 0); 
             XLXN_13  : in    std_logic_vector (7 downto 0); 
             XLXN_14  : in    std_logic_vector (7 downto 0); 
             XLXN_15  : in    std_logic_vector (7 downto 0); 
             XLXN_16  : in    std_logic_vector (7 downto 0); 
             XLXN_17  : in    std_logic_vector (7 downto 0); 
             XLXN_18  : in    std_logic_vector (7 downto 0); 
             XLXN_19  : in    std_logic_vector (7 downto 0); 
             XLXN_20  : in    std_logic_vector (7 downto 0); 
             XLXN_21  : in    std_logic_vector (7 downto 0); 
             XLXN_22  : in    std_logic_vector (7 downto 0); 
             XLXN_23  : in    std_logic_vector (7 downto 0); 
             XLXN_24  : in    std_logic_vector (7 downto 0); 
             XLXN_25  : in    std_logic_vector (7 downto 0); 
             clk      : in    std_logic; 
             XLXN_540 : out   std_logic_vector (7 downto 0); 
             XLXN_541 : out   std_logic_vector (7 downto 0); 
             XLXN_542 : out   std_logic_vector (7 downto 0); 
             XLXN_543 : out   std_logic_vector (7 downto 0); 
             XLXN_544 : out   std_logic_vector (7 downto 0); 
             XLXN_545 : out   std_logic_vector (7 downto 0); 
             XLXN_546 : out   std_logic_vector (7 downto 0); 
             XLXN_547 : out   std_logic_vector (7 downto 0); 
             XLXN_548 : out   std_logic_vector (7 downto 0); 
             XLXN_549 : out   std_logic_vector (7 downto 0); 
             XLXN_550 : out   std_logic_vector (7 downto 0); 
             XLXN_551 : out   std_logic_vector (7 downto 0); 
             XLXN_552 : out   std_logic_vector (7 downto 0); 
             XLXN_553 : out   std_logic_vector (7 downto 0); 
             XLXN_554 : out   std_logic_vector (7 downto 0); 
             XLXN_555 : out   std_logic_vector (7 downto 0); 
             XLXN_556 : out   std_logic_vector (7 downto 0); 
             XLXN_557 : out   std_logic_vector (7 downto 0); 
             XLXN_558 : out   std_logic_vector (7 downto 0); 
             XLXN_559 : out   std_logic_vector (7 downto 0); 
             XLXN_560 : out   std_logic_vector (7 downto 0); 
             XLXN_561 : out   std_logic_vector (7 downto 0); 
             XLXN_562 : out   std_logic_vector (7 downto 0); 
             XLXN_563 : out   std_logic_vector (7 downto 0); 
             XLXN_564 : out   std_logic_vector (7 downto 0));
   end component;
   
   component mask_to_25
      port ( kernel : in   type_mask;
             out0    : out   std_logic_vector (7 downto 0); 
             out1    : out   std_logic_vector (7 downto 0); 
             out2    : out   std_logic_vector (7 downto 0); 
             out3    : out   std_logic_vector (7 downto 0); 
             out4    : out   std_logic_vector (7 downto 0); 
             out5    : out   std_logic_vector (7 downto 0); 
             out6    : out   std_logic_vector (7 downto 0); 
             out7    : out   std_logic_vector (7 downto 0); 
             out8    : out   std_logic_vector (7 downto 0); 
             out9    : out   std_logic_vector (7 downto 0); 
             out10   : out   std_logic_vector (7 downto 0); 
             out11   : out   std_logic_vector (7 downto 0); 
             out12   : out   std_logic_vector (7 downto 0); 
             out13   : out   std_logic_vector (7 downto 0); 
             out14   : out   std_logic_vector (7 downto 0); 
             out15   : out   std_logic_vector (7 downto 0); 
             out16   : out   std_logic_vector (7 downto 0); 
             out17   : out   std_logic_vector (7 downto 0); 
             out18   : out   std_logic_vector (7 downto 0); 
             out19   : out   std_logic_vector (7 downto 0); 
             out20   : out   std_logic_vector (7 downto 0); 
             out21   : out   std_logic_vector (7 downto 0); 
             out22   : out   std_logic_vector (7 downto 0); 
             out23   : out   std_logic_vector (7 downto 0); 
             out24   : out   std_logic_vector (7 downto 0));
   end component;
   
   component sort_to_mask
      port ( out0     : in    std_logic_vector (7 downto 0); 
             out1     : in    std_logic_vector (7 downto 0); 
             out2     : in    std_logic_vector (7 downto 0); 
             out3     : in    std_logic_vector (7 downto 0); 
             out4     : in    std_logic_vector (7 downto 0); 
             out5     : in    std_logic_vector (7 downto 0); 
             out6     : in    std_logic_vector (7 downto 0); 
             out7     : in    std_logic_vector (7 downto 0); 
             out8     : in    std_logic_vector (7 downto 0); 
             out9     : in    std_logic_vector (7 downto 0); 
             out10    : in    std_logic_vector (7 downto 0); 
             out11    : in    std_logic_vector (7 downto 0); 
             out12    : in    std_logic_vector (7 downto 0); 
             out13    : in    std_logic_vector (7 downto 0); 
             out14    : in    std_logic_vector (7 downto 0); 
             out15    : in    std_logic_vector (7 downto 0); 
             out16    : in    std_logic_vector (7 downto 0); 
             out17    : in    std_logic_vector (7 downto 0); 
             out18    : in    std_logic_vector (7 downto 0); 
             out19    : in    std_logic_vector (7 downto 0); 
             out20    : in    std_logic_vector (7 downto 0); 
             out21    : in    std_logic_vector (7 downto 0); 
             out22    : in    std_logic_vector (7 downto 0); 
             out23    : in    std_logic_vector (7 downto 0); 
             out24    : in    std_logic_vector (7 downto 0); 
             sort_25 : out   type_mask);
   end component;  
begin

   XLXI_15 : batcher_25
      port map (clk=>clk,
                XLXN_1(7 downto 0)=>XLXN_217(7 downto 0),
                XLXN_2(7 downto 0)=>XLXN_218(7 downto 0),
                XLXN_3(7 downto 0)=>XLXN_219(7 downto 0),
                XLXN_4(7 downto 0)=>XLXN_220(7 downto 0),
                XLXN_5(7 downto 0)=>XLXN_221(7 downto 0),
                XLXN_6(7 downto 0)=>XLXN_222(7 downto 0),
                XLXN_7(7 downto 0)=>XLXN_223(7 downto 0),
                XLXN_8(7 downto 0)=>XLXN_224(7 downto 0),
                XLXN_9(7 downto 0)=>XLXN_225(7 downto 0),
                XLXN_10(7 downto 0)=>XLXN_226(7 downto 0),
                XLXN_11(7 downto 0)=>XLXN_227(7 downto 0),
                XLXN_12(7 downto 0)=>XLXN_228(7 downto 0),
                XLXN_13(7 downto 0)=>XLXN_229(7 downto 0),
                XLXN_14(7 downto 0)=>XLXN_230(7 downto 0),
                XLXN_15(7 downto 0)=>XLXN_231(7 downto 0),
                XLXN_16(7 downto 0)=>XLXN_232(7 downto 0),
                XLXN_17(7 downto 0)=>XLXN_233(7 downto 0),
                XLXN_18(7 downto 0)=>XLXN_234(7 downto 0),
                XLXN_19(7 downto 0)=>XLXN_235(7 downto 0),
                XLXN_20(7 downto 0)=>XLXN_236(7 downto 0),
                XLXN_21(7 downto 0)=>XLXN_237(7 downto 0),
                XLXN_22(7 downto 0)=>XLXN_238(7 downto 0),
                XLXN_23(7 downto 0)=>XLXN_239(7 downto 0),
                XLXN_24(7 downto 0)=>XLXN_240(7 downto 0),
                XLXN_25(7 downto 0)=>XLXN_241(7 downto 0),
                XLXN_540(7 downto 0)=>XLXN_242(7 downto 0),
                XLXN_541(7 downto 0)=>XLXN_243(7 downto 0),
                XLXN_542(7 downto 0)=>XLXN_244(7 downto 0),
                XLXN_543(7 downto 0)=>XLXN_245(7 downto 0),
                XLXN_544(7 downto 0)=>XLXN_246(7 downto 0),
                XLXN_545(7 downto 0)=>XLXN_247(7 downto 0),
                XLXN_546(7 downto 0)=>XLXN_248(7 downto 0),
                XLXN_547(7 downto 0)=>XLXN_249(7 downto 0),
                XLXN_548(7 downto 0)=>XLXN_250(7 downto 0),
                XLXN_549(7 downto 0)=>XLXN_251(7 downto 0),
                XLXN_550(7 downto 0)=>XLXN_252(7 downto 0),
                XLXN_551(7 downto 0)=>XLXN_253(7 downto 0),
                XLXN_552(7 downto 0)=>XLXN_254(7 downto 0),
                XLXN_553(7 downto 0)=>XLXN_255(7 downto 0),
                XLXN_554(7 downto 0)=>XLXN_256(7 downto 0),
                XLXN_555(7 downto 0)=>XLXN_257(7 downto 0),
                XLXN_556(7 downto 0)=>XLXN_258(7 downto 0),
                XLXN_557(7 downto 0)=>XLXN_259(7 downto 0),
                XLXN_558(7 downto 0)=>XLXN_260(7 downto 0),
                XLXN_559(7 downto 0)=>XLXN_261(7 downto 0),
                XLXN_560(7 downto 0)=>XLXN_262(7 downto 0),
                XLXN_561(7 downto 0)=>XLXN_263(7 downto 0),
                XLXN_562(7 downto 0)=>XLXN_264(7 downto 0),
                XLXN_563(7 downto 0)=>XLXN_265(7 downto 0),
                XLXN_564(7 downto 0)=>XLXN_266(7 downto 0));
   
   XLXI_16 : mask_to_25
      port map (kernel=>kernel,
                out0(7 downto 0)=>XLXN_217(7 downto 0),
                out1(7 downto 0)=>XLXN_218(7 downto 0),
                out2(7 downto 0)=>XLXN_219(7 downto 0),
                out3(7 downto 0)=>XLXN_220(7 downto 0),
                out4(7 downto 0)=>XLXN_221(7 downto 0),
                out5(7 downto 0)=>XLXN_222(7 downto 0),
                out6(7 downto 0)=>XLXN_223(7 downto 0),
                out7(7 downto 0)=>XLXN_224(7 downto 0),
                out8(7 downto 0)=>XLXN_225(7 downto 0),
                out9(7 downto 0)=>XLXN_226(7 downto 0),
                out10(7 downto 0)=>XLXN_227(7 downto 0),
                out11(7 downto 0)=>XLXN_228(7 downto 0),
                out12(7 downto 0)=>XLXN_229(7 downto 0),
                out13(7 downto 0)=>XLXN_230(7 downto 0),
                out14(7 downto 0)=>XLXN_231(7 downto 0),
                out15(7 downto 0)=>XLXN_232(7 downto 0),
                out16(7 downto 0)=>XLXN_233(7 downto 0),
                out17(7 downto 0)=>XLXN_234(7 downto 0),
                out18(7 downto 0)=>XLXN_235(7 downto 0),
                out19(7 downto 0)=>XLXN_236(7 downto 0),
                out20(7 downto 0)=>XLXN_237(7 downto 0),
                out21(7 downto 0)=>XLXN_238(7 downto 0),
                out22(7 downto 0)=>XLXN_239(7 downto 0),
                out23(7 downto 0)=>XLXN_240(7 downto 0),
                out24(7 downto 0)=>XLXN_241(7 downto 0));
   
   XLXI_17 : sort_to_mask
      port map (out0(7 downto 0)=>XLXN_242(7 downto 0),
                out1(7 downto 0)=>XLXN_243(7 downto 0),
                out2(7 downto 0)=>XLXN_244(7 downto 0),
                out3(7 downto 0)=>XLXN_245(7 downto 0),
                out4(7 downto 0)=>XLXN_246(7 downto 0),
                out5(7 downto 0)=>XLXN_247(7 downto 0),
                out6(7 downto 0)=>XLXN_248(7 downto 0),
                out7(7 downto 0)=>XLXN_249(7 downto 0),
                out8(7 downto 0)=>XLXN_250(7 downto 0),
                out9(7 downto 0)=>XLXN_251(7 downto 0),
                out10(7 downto 0)=>XLXN_252(7 downto 0),
                out11(7 downto 0)=>XLXN_253(7 downto 0),
                out12(7 downto 0)=>XLXN_254(7 downto 0),
                out13(7 downto 0)=>XLXN_255(7 downto 0),
                out14(7 downto 0)=>XLXN_256(7 downto 0),
                out15(7 downto 0)=>XLXN_257(7 downto 0),
                out16(7 downto 0)=>XLXN_258(7 downto 0),
                out17(7 downto 0)=>XLXN_259(7 downto 0),
                out18(7 downto 0)=>XLXN_260(7 downto 0),
                out19(7 downto 0)=>XLXN_261(7 downto 0),
                out20(7 downto 0)=>XLXN_262(7 downto 0),
                out21(7 downto 0)=>XLXN_263(7 downto 0),
                out22(7 downto 0)=>XLXN_264(7 downto 0),
                out23(7 downto 0)=>XLXN_265(7 downto 0),
                out24(7 downto 0)=>XLXN_266(7 downto 0),
                sort_25=>sort_25);
   
end BEHAVIORAL;


---------------------------------------------comparator--------------------------------------------------
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--USE work.type_perso.ALL;
--
--ENTITY comparator IS
--    PORT ( in_up    : IN   type_pixel;
--           in_down  : IN   type_pixel;
--           out_up   : OUT  type_pixel;
--           out_down : OUT  type_pixel 
--			 );
--END comparator;
--
--
--ARCHITECTURE Behavioral OF comparator IS
--
--BEGIN
--
--	out_up   <= in_up   WHEN (in_up > in_down) ELSE in_down;
--	out_down <= in_down WHEN (in_up > in_down) ELSE in_up  ;
--	
--end Behavioral;
------------------------------------------------------------------------------------------------------

---------------------------------------------ff--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ff is
    Port ( in1  : in  STD_LOGIC_VECTOR (7 downto 0);
           out1 : out STD_LOGIC_VECTOR (7 downto 0);
           clk  : in  STD_LOGIC);
end ff;

architecture Behavioral of ff is
  begin
    PROCESS(clk)
    BEGIN
      IF(RISING_EDGE(clk)) THEN
	       out1 <= in1;
      END IF;
    END PROCESS;	
end Behavioral;
---------------------------------------------------------------------------------------------------------

-----------------------------------------------mask_to_25------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.type_perso.ALL;

entity mask_to_25 is
    Port ( kernel : in  type_mask;
           out0 : out  STD_LOGIC_VECTOR (7 downto 0);
           out1 : out  STD_LOGIC_VECTOR (7 downto 0);
           out2 : out  STD_LOGIC_VECTOR (7 downto 0);
           out3 : out  STD_LOGIC_VECTOR (7 downto 0);
           out4 : out  STD_LOGIC_VECTOR (7 downto 0);
           out5 : out  STD_LOGIC_VECTOR (7 downto 0);
           out6 : out  STD_LOGIC_VECTOR (7 downto 0);
           out7 : out  STD_LOGIC_VECTOR (7 downto 0);
           out8 : out  STD_LOGIC_VECTOR (7 downto 0);
           out9 : out  STD_LOGIC_VECTOR (7 downto 0);
           out10 : out  STD_LOGIC_VECTOR (7 downto 0);
           out11 : out  STD_LOGIC_VECTOR (7 downto 0);
           out12 : out  STD_LOGIC_VECTOR (7 downto 0);
           out13 : out  STD_LOGIC_VECTOR (7 downto 0);
           out14 : out  STD_LOGIC_VECTOR (7 downto 0);
           out15 : out  STD_LOGIC_VECTOR (7 downto 0);
           out16 : out  STD_LOGIC_VECTOR (7 downto 0);
           out17 : out  STD_LOGIC_VECTOR (7 downto 0);
           out18 : out  STD_LOGIC_VECTOR (7 downto 0);
           out19 : out  STD_LOGIC_VECTOR (7 downto 0);
           out20 : out  STD_LOGIC_VECTOR (7 downto 0);
           out21 : out  STD_LOGIC_VECTOR (7 downto 0);
           out22 : out  STD_LOGIC_VECTOR (7 downto 0);
           out23 : out  STD_LOGIC_VECTOR (7 downto 0);
           out24 : out  STD_LOGIC_VECTOR (7 downto 0));
end mask_to_25;

architecture Behavioral of mask_to_25 is

begin
	out0<=kernel(0);
	out1<=kernel(1);
	out2<=kernel(2);
	out3<=kernel(3);
	out4<=kernel(4);
	out5<=kernel(5);
	out6<=kernel(6);
	out7<=kernel(7);
	out8<=kernel(8);
	out9<=kernel(9);
	out10<=kernel(10);
	out11<=kernel(11);
	out12<=kernel(12);
	out13<=kernel(13);
	out14<=kernel(14);
	out15<=kernel(15);
	out16<=kernel(16);
	out17<=kernel(17);
	out18<=kernel(18);
	out19<=kernel(19);
	out20<=kernel(20);
	out21<=kernel(21);
	out22<=kernel(22);
	out23<=kernel(23);
	out24<=kernel(24);
end Behavioral;
-------------------------------------------------------------------------------------------------


-----------------------------------------------sort_to_mask---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.type_perso.ALL;

ENTITY sort_to_mask IS
    PORT ( 
           out0 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out1 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out2 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out3 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out4 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out5 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out6 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out7 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out8 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out9 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out10 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out11 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out12 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out13 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out14 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out15 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out16 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out17 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out18 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out19 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out20 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out21 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out22 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out23 : IN  STD_LOGIC_VECTOR (7 downto 0);
           out24 : IN  STD_LOGIC_VECTOR (7 downto 0);
			  sort_25 : OUT  type_mask
			  );
end sort_to_mask;

architecture Behavioral of sort_to_mask is
begin
	sort_25<=(out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24);
end Behavioral;
---------------------------------------------------------------------------------------------------


-----------------------------------------------batcher_25------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
--library UNISIM;
--use UNISIM.Vcomponents.ALL;

entity batcher_25 is
   port ( clk      : in    std_logic; 
          XLXN_1   : in    std_logic_vector (7 downto 0); 
          XLXN_2   : in    std_logic_vector (7 downto 0); 
          XLXN_3   : in    std_logic_vector (7 downto 0); 
          XLXN_4   : in    std_logic_vector (7 downto 0); 
          XLXN_5   : in    std_logic_vector (7 downto 0); 
          XLXN_6   : in    std_logic_vector (7 downto 0); 
          XLXN_7   : in    std_logic_vector (7 downto 0); 
          XLXN_8   : in    std_logic_vector (7 downto 0); 
          XLXN_9   : in    std_logic_vector (7 downto 0); 
          XLXN_10  : in    std_logic_vector (7 downto 0); 
          XLXN_11  : in    std_logic_vector (7 downto 0); 
          XLXN_12  : in    std_logic_vector (7 downto 0); 
          XLXN_13  : in    std_logic_vector (7 downto 0); 
          XLXN_14  : in    std_logic_vector (7 downto 0); 
          XLXN_15  : in    std_logic_vector (7 downto 0); 
          XLXN_16  : in    std_logic_vector (7 downto 0); 
          XLXN_17  : in    std_logic_vector (7 downto 0); 
          XLXN_18  : in    std_logic_vector (7 downto 0); 
          XLXN_19  : in    std_logic_vector (7 downto 0); 
          XLXN_20  : in    std_logic_vector (7 downto 0); 
          XLXN_21  : in    std_logic_vector (7 downto 0); 
          XLXN_22  : in    std_logic_vector (7 downto 0); 
          XLXN_23  : in    std_logic_vector (7 downto 0); 
          XLXN_24  : in    std_logic_vector (7 downto 0); 
          XLXN_25  : in    std_logic_vector (7 downto 0); 
          XLXN_540 : out   std_logic_vector (7 downto 0); 
          XLXN_541 : out   std_logic_vector (7 downto 0); 
          XLXN_542 : out   std_logic_vector (7 downto 0); 
          XLXN_543 : out   std_logic_vector (7 downto 0); 
          XLXN_544 : out   std_logic_vector (7 downto 0); 
          XLXN_545 : out   std_logic_vector (7 downto 0); 
          XLXN_546 : out   std_logic_vector (7 downto 0); 
          XLXN_547 : out   std_logic_vector (7 downto 0); 
          XLXN_548 : out   std_logic_vector (7 downto 0); 
          XLXN_549 : out   std_logic_vector (7 downto 0); 
          XLXN_550 : out   std_logic_vector (7 downto 0); 
          XLXN_551 : out   std_logic_vector (7 downto 0); 
          XLXN_552 : out   std_logic_vector (7 downto 0); 
          XLXN_553 : out   std_logic_vector (7 downto 0); 
          XLXN_554 : out   std_logic_vector (7 downto 0); 
          XLXN_555 : out   std_logic_vector (7 downto 0); 
          XLXN_556 : out   std_logic_vector (7 downto 0); 
          XLXN_557 : out   std_logic_vector (7 downto 0); 
          XLXN_558 : out   std_logic_vector (7 downto 0); 
          XLXN_559 : out   std_logic_vector (7 downto 0); 
          XLXN_560 : out   std_logic_vector (7 downto 0); 
          XLXN_561 : out   std_logic_vector (7 downto 0); 
          XLXN_562 : out   std_logic_vector (7 downto 0); 
          XLXN_563 : out   std_logic_vector (7 downto 0); 
          XLXN_564 : out   std_logic_vector (7 downto 0));
end batcher_25;

architecture BEHAVIORAL of batcher_25 is
   signal XLXN_26  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_27  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_28  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_29  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_30  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_31  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_32  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_33  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_34  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_35  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_36  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_38  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_39  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_40  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_41  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_42  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_45  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_46  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_48  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_49  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_50  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_51  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_52  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_53  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_54  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_55  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_56  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_57  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_58  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_59  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_60  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_61  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_62  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_63  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_64  : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_113 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_114 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_115 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_116 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_117 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_118 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_119 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_120 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_121 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_122 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_123 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_124 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_125 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_126 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_127 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_128 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_129 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_130 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_131 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_132 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_314 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_316 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_317 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_318 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_320 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_321 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_322 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_323 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_324 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_325 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_326 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_327 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_328 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_329 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_334 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_335 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_336 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_337 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_338 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_339 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_340 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_341 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_342 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_343 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_344 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_345 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_346 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_347 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_348 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_349 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_350 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_351 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_353 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_354 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_355 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_356 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_357 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_358 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_359 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_360 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_361 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_362 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_363 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_364 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_365 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_366 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_367 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_368 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_369 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_370 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_371 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_372 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_373 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_374 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_375 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_376 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_377 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_378 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_379 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_380 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_390 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_391 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_392 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_393 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_394 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_395 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_396 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_397 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_398 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_399 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_400 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_401 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_402 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_403 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_404 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_405 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_406 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_407 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_409 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_410 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_411 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_412 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_413 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_414 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_415 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_416 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_417 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_418 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_419 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_420 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_421 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_422 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_423 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_424 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_425 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_426 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_427 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_428 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_429 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_432 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_434 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_435 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_436 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_437 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_438 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_439 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_440 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_447 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_448 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_449 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_450 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_451 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_452 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_453 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_454 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_455 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_456 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_457 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_458 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_459 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_460 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_462 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_463 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_464 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_465 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_466 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_467 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_468 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_469 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_470 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_471 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_472 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_473 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_474 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_475 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_476 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_477 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_478 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_479 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_480 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_481 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_482 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_483 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_484 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_485 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_486 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_487 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_488 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_489 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_490 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_491 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_492 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_493 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_494 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_495 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_496 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_497 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_498 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_499 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_500 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_501 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_502 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_503 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_504 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_505 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_506 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_507 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_508 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_509 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_510 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_511 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_512 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_513 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_515 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_516 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_517 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_518 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_519 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_520 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_521 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_522 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_523 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_524 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_525 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_526 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_527 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_528 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_529 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_530 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_531 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_532 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_533 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_534 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_535 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_536 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_575 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_576 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_577 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_578 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_584 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_585 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_586 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_587 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_588 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_589 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_590 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_591 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_592 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_593 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_594 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_595 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_596 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_597 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_598 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_599 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_600 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_601 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_602 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_603 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_604 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_629 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_630 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_631 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_632 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_633 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_634 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_635 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_636 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_637 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_638 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_639 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_640 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_641 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_642 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_643 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_644 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_645 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_646 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_647 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_650 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_653 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_657 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_678 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_679 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_680 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_681 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_682 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_683 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_684 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_685 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_686 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_687 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_688 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_689 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_690 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_691 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_692 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_693 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_694 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_695 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_696 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_697 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_700 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_701 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_722 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_723 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_724 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_725 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_726 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_727 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_728 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_729 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_730 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_731 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_732 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_733 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_735 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_737 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_738 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_740 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_741 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_744 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_749 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_750 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_752 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_753 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_755 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_758 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_761 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_763 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_764 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_766 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_771 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_775 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_776 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_777 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_778 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_779 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_780 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_781 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_782 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_783 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_784 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_785 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_786 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_787 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_788 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_789 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_790 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_791 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_792 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_793 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_794 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_795 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_796 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_797 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_798 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_800 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_804 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_805 : std_logic_vector (7 downto 0) := (others => '0') ;
   signal XLXN_806 : std_logic_vector (7 downto 0) := (others => '0') ;
   

   component comparator
      port ( in_up    : in    std_logic_vector (7 downto 0); 
             in_down  : in    std_logic_vector (7 downto 0); 
             out_up   : out   std_logic_vector (7 downto 0); 
             out_down : out   std_logic_vector (7 downto 0));
   end component;
   
   component ff
      port ( in1  : in    std_logic_vector (7 downto 0); 
             out1 : out   std_logic_vector (7 downto 0); 
             clk  : in    std_logic);
   end component;
   
begin
   XLXI_1 : comparator
      port map (in_down(7 downto 0)=>XLXN_2(7 downto 0),
                in_up(7 downto 0)=>XLXN_1(7 downto 0),
                out_down(7 downto 0)=>XLXN_27(7 downto 0),
                out_up(7 downto 0)=>XLXN_26(7 downto 0));
   
   XLXI_2 : comparator
      port map (in_down(7 downto 0)=>XLXN_4(7 downto 0),
                in_up(7 downto 0)=>XLXN_3(7 downto 0),
                out_down(7 downto 0)=>XLXN_58(7 downto 0),
                out_up(7 downto 0)=>XLXN_28(7 downto 0));
   
   XLXI_3 : comparator
      port map (in_down(7 downto 0)=>XLXN_6(7 downto 0),
                in_up(7 downto 0)=>XLXN_5(7 downto 0),
                out_down(7 downto 0)=>XLXN_59(7 downto 0),
                out_up(7 downto 0)=>XLXN_29(7 downto 0));
   
   XLXI_4 : comparator
      port map (in_down(7 downto 0)=>XLXN_8(7 downto 0),
                in_up(7 downto 0)=>XLXN_7(7 downto 0),
                out_down(7 downto 0)=>XLXN_60(7 downto 0),
                out_up(7 downto 0)=>XLXN_30(7 downto 0));
   
   XLXI_5 : comparator
      port map (in_down(7 downto 0)=>XLXN_10(7 downto 0),
                in_up(7 downto 0)=>XLXN_9(7 downto 0),
                out_down(7 downto 0)=>XLXN_61(7 downto 0),
                out_up(7 downto 0)=>XLXN_31(7 downto 0));
   
   XLXI_6 : comparator
      port map (in_down(7 downto 0)=>XLXN_12(7 downto 0),
                in_up(7 downto 0)=>XLXN_11(7 downto 0),
                out_down(7 downto 0)=>XLXN_62(7 downto 0),
                out_up(7 downto 0)=>XLXN_32(7 downto 0));
   
   XLXI_7 : comparator
      port map (in_down(7 downto 0)=>XLXN_14(7 downto 0),
                in_up(7 downto 0)=>XLXN_13(7 downto 0),
                out_down(7 downto 0)=>XLXN_63(7 downto 0),
                out_up(7 downto 0)=>XLXN_33(7 downto 0));
   
   XLXI_8 : comparator
      port map (in_down(7 downto 0)=>XLXN_16(7 downto 0),
                in_up(7 downto 0)=>XLXN_15(7 downto 0),
                out_down(7 downto 0)=>XLXN_64(7 downto 0),
                out_up(7 downto 0)=>XLXN_34(7 downto 0));
   
   XLXI_9 : comparator
      port map (in_down(7 downto 0)=>XLXN_18(7 downto 0),
                in_up(7 downto 0)=>XLXN_17(7 downto 0),
                out_down(7 downto 0)=>XLXN_36(7 downto 0),
                out_up(7 downto 0)=>XLXN_35(7 downto 0));
   
   XLXI_15 : comparator
      port map (in_down(7 downto 0)=>XLXN_19(7 downto 0),
                in_up(7 downto 0)=>XLXN_28(7 downto 0),
                out_down(7 downto 0)=>XLXN_38(7 downto 0),
                out_up(7 downto 0)=>XLXN_51(7 downto 0));
   
   XLXI_16 : comparator
      port map (in_down(7 downto 0)=>XLXN_20(7 downto 0),
                in_up(7 downto 0)=>XLXN_29(7 downto 0),
                out_down(7 downto 0)=>XLXN_39(7 downto 0),
                out_up(7 downto 0)=>XLXN_52(7 downto 0));
   
   XLXI_17 : comparator
      port map (in_down(7 downto 0)=>XLXN_21(7 downto 0),
                in_up(7 downto 0)=>XLXN_30(7 downto 0),
                out_down(7 downto 0)=>XLXN_40(7 downto 0),
                out_up(7 downto 0)=>XLXN_53(7 downto 0));
   
   XLXI_18 : comparator
      port map (in_down(7 downto 0)=>XLXN_22(7 downto 0),
                in_up(7 downto 0)=>XLXN_31(7 downto 0),
                out_down(7 downto 0)=>XLXN_41(7 downto 0),
                out_up(7 downto 0)=>XLXN_54(7 downto 0));
   
   XLXI_19 : comparator
      port map (in_down(7 downto 0)=>XLXN_23(7 downto 0),
                in_up(7 downto 0)=>XLXN_32(7 downto 0),
                out_down(7 downto 0)=>XLXN_42(7 downto 0),
                out_up(7 downto 0)=>XLXN_55(7 downto 0));
   
   XLXI_20 : comparator
      port map (in_down(7 downto 0)=>XLXN_24(7 downto 0),
                in_up(7 downto 0)=>XLXN_33(7 downto 0),
                out_down(7 downto 0)=>XLXN_48(7 downto 0),
                out_up(7 downto 0)=>XLXN_56(7 downto 0));
   
   XLXI_21 : comparator
      port map (in_down(7 downto 0)=>XLXN_25(7 downto 0),
                in_up(7 downto 0)=>XLXN_34(7 downto 0),
                out_down(7 downto 0)=>XLXN_49(7 downto 0),
                out_up(7 downto 0)=>XLXN_57(7 downto 0));
   
   XLXI_22 : comparator
      port map (in_down(7 downto 0)=>XLXN_36(7 downto 0),
                in_up(7 downto 0)=>XLXN_27(7 downto 0),
                out_down(7 downto 0)=>XLXN_604(7 downto 0),
                out_up(7 downto 0)=>XLXN_46(7 downto 0));
   
   XLXI_23 : comparator
      port map (in_down(7 downto 0)=>XLXN_35(7 downto 0),
                in_up(7 downto 0)=>XLXN_26(7 downto 0),
                out_down(7 downto 0)=>XLXN_45(7 downto 0),
                out_up(7 downto 0)=>XLXN_50(7 downto 0));
   
   XLXI_24 : comparator
      port map (in_down(7 downto 0)=>XLXN_58(7 downto 0),
                in_up(7 downto 0)=>XLXN_38(7 downto 0),
                out_down(7 downto 0)=>XLXN_598(7 downto 0),
                out_up(7 downto 0)=>XLXN_599(7 downto 0));
   
   XLXI_25 : comparator
      port map (in_down(7 downto 0)=>XLXN_59(7 downto 0),
                in_up(7 downto 0)=>XLXN_39(7 downto 0),
                out_down(7 downto 0)=>XLXN_596(7 downto 0),
                out_up(7 downto 0)=>XLXN_597(7 downto 0));
   
   XLXI_26 : comparator
      port map (in_down(7 downto 0)=>XLXN_60(7 downto 0),
                in_up(7 downto 0)=>XLXN_40(7 downto 0),
                out_down(7 downto 0)=>XLXN_594(7 downto 0),
                out_up(7 downto 0)=>XLXN_595(7 downto 0));
   
   XLXI_27 : comparator
      port map (in_down(7 downto 0)=>XLXN_61(7 downto 0),
                in_up(7 downto 0)=>XLXN_41(7 downto 0),
                out_down(7 downto 0)=>XLXN_592(7 downto 0),
                out_up(7 downto 0)=>XLXN_593(7 downto 0));
   
   XLXI_28 : comparator
      port map (in_down(7 downto 0)=>XLXN_62(7 downto 0),
                in_up(7 downto 0)=>XLXN_42(7 downto 0),
                out_down(7 downto 0)=>XLXN_590(7 downto 0),
                out_up(7 downto 0)=>XLXN_591(7 downto 0));
   
   XLXI_29 : comparator
      port map (in_down(7 downto 0)=>XLXN_63(7 downto 0),
                in_up(7 downto 0)=>XLXN_48(7 downto 0),
                out_down(7 downto 0)=>XLXN_588(7 downto 0),
                out_up(7 downto 0)=>XLXN_589(7 downto 0));
   
   XLXI_30 : comparator
      port map (in_down(7 downto 0)=>XLXN_64(7 downto 0),
                in_up(7 downto 0)=>XLXN_49(7 downto 0),
                out_down(7 downto 0)=>XLXN_587(7 downto 0),
                out_up(7 downto 0)=>XLXN_602(7 downto 0));
   
   XLXI_31 : comparator
      port map (in_down(7 downto 0)=>XLXN_54(7 downto 0),
                in_up(7 downto 0)=>XLXN_50(7 downto 0),
                out_down(7 downto 0)=>XLXN_585(7 downto 0),
                out_up(7 downto 0)=>XLXN_586(7 downto 0));
   
   XLXI_32 : comparator
      port map (in_down(7 downto 0)=>XLXN_46(7 downto 0),
                in_up(7 downto 0)=>XLXN_45(7 downto 0),
                out_down(7 downto 0)=>XLXN_600(7 downto 0),
                out_up(7 downto 0)=>XLXN_601(7 downto 0));
   
   XLXI_33 : comparator
      port map (in_down(7 downto 0)=>XLXN_55(7 downto 0),
                in_up(7 downto 0)=>XLXN_51(7 downto 0),
                out_down(7 downto 0)=>XLXN_578(7 downto 0),
                out_up(7 downto 0)=>XLXN_584(7 downto 0));
   
   XLXI_34 : comparator
      port map (in_down(7 downto 0)=>XLXN_56(7 downto 0),
                in_up(7 downto 0)=>XLXN_52(7 downto 0),
                out_down(7 downto 0)=>XLXN_576(7 downto 0),
                out_up(7 downto 0)=>XLXN_577(7 downto 0));
   
   XLXI_35 : comparator
      port map (in_down(7 downto 0)=>XLXN_57(7 downto 0),
                in_up(7 downto 0)=>XLXN_53(7 downto 0),
                out_down(7 downto 0)=>XLXN_603(7 downto 0),
                out_up(7 downto 0)=>XLXN_575(7 downto 0));
   
   XLXI_168 : comparator
      port map (in_down(7 downto 0)=>XLXN_130(7 downto 0),
                in_up(7 downto 0)=>XLXN_114(7 downto 0),
                out_down(7 downto 0)=>XLXN_344(7 downto 0),
                out_up(7 downto 0)=>XLXN_336(7 downto 0));
   
   XLXI_169 : comparator
      port map (in_down(7 downto 0)=>XLXN_131(7 downto 0),
                in_up(7 downto 0)=>XLXN_115(7 downto 0),
                out_down(7 downto 0)=>XLXN_346(7 downto 0),
                out_up(7 downto 0)=>XLXN_341(7 downto 0));
   
   XLXI_170 : comparator
      port map (in_down(7 downto 0)=>XLXN_132(7 downto 0),
                in_up(7 downto 0)=>XLXN_116(7 downto 0),
                out_down(7 downto 0)=>XLXN_348(7 downto 0),
                out_up(7 downto 0)=>XLXN_342(7 downto 0));
   
   XLXI_171 : comparator
      port map (in_down(7 downto 0)=>XLXN_124(7 downto 0),
                in_up(7 downto 0)=>XLXN_125(7 downto 0),
                out_down(7 downto 0)=>XLXN_350(7 downto 0),
                out_up(7 downto 0)=>XLXN_317(7 downto 0));
   
   XLXI_172 : comparator
      port map (in_down(7 downto 0)=>XLXN_123(7 downto 0),
                in_up(7 downto 0)=>XLXN_126(7 downto 0),
                out_down(7 downto 0)=>XLXN_328(7 downto 0),
                out_up(7 downto 0)=>XLXN_326(7 downto 0));
   
   XLXI_173 : comparator
      port map (in_down(7 downto 0)=>XLXN_129(7 downto 0),
                in_up(7 downto 0)=>XLXN_113(7 downto 0),
                out_down(7 downto 0)=>XLXN_324(7 downto 0),
                out_up(7 downto 0)=>XLXN_335(7 downto 0));
   
   XLXI_174 : comparator
      port map (in_down(7 downto 0)=>XLXN_122(7 downto 0),
                in_up(7 downto 0)=>XLXN_127(7 downto 0),
                out_down(7 downto 0)=>XLXN_653(7 downto 0),
                out_up(7 downto 0)=>XLXN_321(7 downto 0));
   
   XLXI_175 : comparator
      port map (in_down(7 downto 0)=>XLXN_121(7 downto 0),
                in_up(7 downto 0)=>XLXN_128(7 downto 0),
                out_down(7 downto 0)=>XLXN_329(7 downto 0),
                out_up(7 downto 0)=>XLXN_323(7 downto 0));
   
   XLXI_176 : comparator
      port map (in_down(7 downto 0)=>XLXN_119(7 downto 0),
                in_up(7 downto 0)=>XLXN_117(7 downto 0),
                out_down(7 downto 0)=>XLXN_650(7 downto 0),
                out_up(7 downto 0)=>XLXN_327(7 downto 0));
   
   XLXI_177 : comparator
      port map (in_down(7 downto 0)=>XLXN_120(7 downto 0),
                in_up(7 downto 0)=>XLXN_118(7 downto 0),
                out_down(7 downto 0)=>XLXN_647(7 downto 0),
                out_up(7 downto 0)=>XLXN_314(7 downto 0));
   
   XLXI_178 : comparator
      port map (in_down(7 downto 0)=>XLXN_317(7 downto 0),
                in_up(7 downto 0)=>XLXN_316(7 downto 0),
                out_down(7 downto 0)=>XLXN_343(7 downto 0),
                out_up(7 downto 0)=>XLXN_334(7 downto 0));
   
   XLXI_179 : comparator
      port map (in_down(7 downto 0)=>XLXN_326(7 downto 0),
                in_up(7 downto 0)=>XLXN_318(7 downto 0),
                out_down(7 downto 0)=>XLXN_345(7 downto 0),
                out_up(7 downto 0)=>XLXN_337(7 downto 0));
   
   XLXI_180 : comparator
      port map (in_down(7 downto 0)=>XLXN_321(7 downto 0),
                in_up(7 downto 0)=>XLXN_320(7 downto 0),
                out_down(7 downto 0)=>XLXN_347(7 downto 0),
                out_up(7 downto 0)=>XLXN_338(7 downto 0));
   
   XLXI_181 : comparator
      port map (in_down(7 downto 0)=>XLXN_323(7 downto 0),
                in_up(7 downto 0)=>XLXN_322(7 downto 0),
                out_down(7 downto 0)=>XLXN_349(7 downto 0),
                out_up(7 downto 0)=>XLXN_339(7 downto 0));
   
   XLXI_182 : comparator
      port map (in_down(7 downto 0)=>XLXN_325(7 downto 0),
                in_up(7 downto 0)=>XLXN_324(7 downto 0),
                out_down(7 downto 0)=>XLXN_351(7 downto 0),
                out_up(7 downto 0)=>XLXN_340(7 downto 0));
   
   XLXI_183 : comparator
      port map (in_down(7 downto 0)=>XLXN_329(7 downto 0),
                in_up(7 downto 0)=>XLXN_328(7 downto 0),
                out_down(7 downto 0)=>XLXN_752(7 downto 0),
                out_up(7 downto 0)=>XLXN_657(7 downto 0));
   
   XLXI_184 : comparator
      port map (in_down(7 downto 0)=>XLXN_314(7 downto 0),
                in_up(7 downto 0)=>XLXN_327(7 downto 0),
                out_down(7 downto 0)=>XLXN_749(7 downto 0),
                out_up(7 downto 0)=>XLXN_806(7 downto 0));
   
   XLXI_304 : comparator
      port map (in_down(7 downto 0)=>XLXN_336(7 downto 0),
                in_up(7 downto 0)=>XLXN_337(7 downto 0),
                out_down(7 downto 0)=>XLXN_643(7 downto 0),
                out_up(7 downto 0)=>XLXN_644(7 downto 0));
   
   XLXI_305 : comparator
      port map (in_down(7 downto 0)=>XLXN_341(7 downto 0),
                in_up(7 downto 0)=>XLXN_338(7 downto 0),
                out_down(7 downto 0)=>XLXN_641(7 downto 0),
                out_up(7 downto 0)=>XLXN_642(7 downto 0));
   
   XLXI_306 : comparator
      port map (in_down(7 downto 0)=>XLXN_342(7 downto 0),
                in_up(7 downto 0)=>XLXN_339(7 downto 0),
                out_down(7 downto 0)=>XLXN_639(7 downto 0),
                out_up(7 downto 0)=>XLXN_640(7 downto 0));
   
   XLXI_307 : comparator
      port map (in_down(7 downto 0)=>XLXN_343(7 downto 0),
                in_up(7 downto 0)=>XLXN_340(7 downto 0),
                out_down(7 downto 0)=>XLXN_637(7 downto 0),
                out_up(7 downto 0)=>XLXN_638(7 downto 0));
   
   XLXI_308 : comparator
      port map (in_down(7 downto 0)=>XLXN_345(7 downto 0),
                in_up(7 downto 0)=>XLXN_344(7 downto 0),
                out_down(7 downto 0)=>XLXN_635(7 downto 0),
                out_up(7 downto 0)=>XLXN_636(7 downto 0));
   
   XLXI_309 : comparator
      port map (in_down(7 downto 0)=>XLXN_335(7 downto 0),
                in_up(7 downto 0)=>XLXN_334(7 downto 0),
                out_down(7 downto 0)=>XLXN_645(7 downto 0),
                out_up(7 downto 0)=>XLXN_646(7 downto 0));
   
   XLXI_310 : comparator
      port map (in_down(7 downto 0)=>XLXN_347(7 downto 0),
                in_up(7 downto 0)=>XLXN_346(7 downto 0),
                out_down(7 downto 0)=>XLXN_633(7 downto 0),
                out_up(7 downto 0)=>XLXN_634(7 downto 0));
   
   XLXI_311 : comparator
      port map (in_down(7 downto 0)=>XLXN_349(7 downto 0),
                in_up(7 downto 0)=>XLXN_348(7 downto 0),
                out_down(7 downto 0)=>XLXN_631(7 downto 0),
                out_up(7 downto 0)=>XLXN_632(7 downto 0));
   
   XLXI_312 : comparator
      port map (in_down(7 downto 0)=>XLXN_351(7 downto 0),
                in_up(7 downto 0)=>XLXN_350(7 downto 0),
                out_down(7 downto 0)=>XLXN_629(7 downto 0),
                out_up(7 downto 0)=>XLXN_630(7 downto 0));
   
   XLXI_313 : comparator
      port map (in_down(7 downto 0)=>XLXN_365(7 downto 0),
                in_up(7 downto 0)=>XLXN_354(7 downto 0),
                out_down(7 downto 0)=>XLXN_377(7 downto 0),
                out_up(7 downto 0)=>XLXN_700(7 downto 0));
   
   XLXI_314 : comparator
      port map (in_down(7 downto 0)=>XLXN_355(7 downto 0),
                in_up(7 downto 0)=>XLXN_363(7 downto 0),
                out_down(7 downto 0)=>XLXN_378(7 downto 0),
                out_up(7 downto 0)=>XLXN_391(7 downto 0));
   
   XLXI_315 : comparator
      port map (in_down(7 downto 0)=>XLXN_356(7 downto 0),
                in_up(7 downto 0)=>XLXN_364(7 downto 0),
                out_down(7 downto 0)=>XLXN_404(7 downto 0),
                out_up(7 downto 0)=>XLXN_401(7 downto 0));
   
   XLXI_316 : comparator
      port map (in_down(7 downto 0)=>XLXN_366(7 downto 0),
                in_up(7 downto 0)=>XLXN_357(7 downto 0),
                out_down(7 downto 0)=>XLXN_405(7 downto 0),
                out_up(7 downto 0)=>XLXN_402(7 downto 0));
   
   XLXI_317 : comparator
      port map (in_down(7 downto 0)=>XLXN_367(7 downto 0),
                in_up(7 downto 0)=>XLXN_358(7 downto 0),
                out_down(7 downto 0)=>XLXN_406(7 downto 0),
                out_up(7 downto 0)=>XLXN_403(7 downto 0));
   
   XLXI_318 : comparator
      port map (in_down(7 downto 0)=>XLXN_362(7 downto 0),
                in_up(7 downto 0)=>XLXN_353(7 downto 0),
                out_down(7 downto 0)=>XLXN_375(7 downto 0),
                out_up(7 downto 0)=>XLXN_701(7 downto 0));
   
   XLXI_319 : comparator
      port map (in_down(7 downto 0)=>XLXN_359(7 downto 0),
                in_up(7 downto 0)=>XLXN_368(7 downto 0),
                out_down(7 downto 0)=>XLXN_407(7 downto 0),
                out_up(7 downto 0)=>XLXN_372(7 downto 0));
   
   XLXI_320 : comparator
      port map (in_down(7 downto 0)=>XLXN_360(7 downto 0),
                in_up(7 downto 0)=>XLXN_369(7 downto 0),
                out_down(7 downto 0)=>XLXN_697(7 downto 0),
                out_up(7 downto 0)=>XLXN_374(7 downto 0));
   
   XLXI_321 : comparator
      port map (in_down(7 downto 0)=>XLXN_370(7 downto 0),
                in_up(7 downto 0)=>XLXN_361(7 downto 0),
                out_down(7 downto 0)=>XLXN_696(7 downto 0),
                out_up(7 downto 0)=>XLXN_376(7 downto 0));
   
   XLXI_335 : comparator
      port map (in_down(7 downto 0)=>XLXN_379(7 downto 0),
                in_up(7 downto 0)=>XLXN_378(7 downto 0),
                out_down(7 downto 0)=>XLXN_400(7 downto 0),
                out_up(7 downto 0)=>XLXN_395(7 downto 0));
   
   XLXI_336 : comparator
      port map (in_down(7 downto 0)=>XLXN_376(7 downto 0),
                in_up(7 downto 0)=>XLXN_375(7 downto 0),
                out_down(7 downto 0)=>XLXN_398(7 downto 0),
                out_up(7 downto 0)=>XLXN_393(7 downto 0));
   
   XLXI_337 : comparator
      port map (in_down(7 downto 0)=>XLXN_380(7 downto 0),
                in_up(7 downto 0)=>XLXN_377(7 downto 0),
                out_down(7 downto 0)=>XLXN_399(7 downto 0),
                out_up(7 downto 0)=>XLXN_394(7 downto 0));
   
   XLXI_338 : comparator
      port map (in_down(7 downto 0)=>XLXN_374(7 downto 0),
                in_up(7 downto 0)=>XLXN_373(7 downto 0),
                out_down(7 downto 0)=>XLXN_397(7 downto 0),
                out_up(7 downto 0)=>XLXN_392(7 downto 0));
   
   XLXI_339 : comparator
      port map (in_down(7 downto 0)=>XLXN_372(7 downto 0),
                in_up(7 downto 0)=>XLXN_371(7 downto 0),
                out_down(7 downto 0)=>XLXN_396(7 downto 0),
                out_up(7 downto 0)=>XLXN_390(7 downto 0));
   
   XLXI_340 : comparator
      port map (in_down(7 downto 0)=>XLXN_400(7 downto 0),
                in_up(7 downto 0)=>XLXN_407(7 downto 0),
                out_down(7 downto 0)=>XLXN_695(7 downto 0),
                out_up(7 downto 0)=>XLXN_694(7 downto 0));
   
   XLXI_341 : comparator
      port map (in_down(7 downto 0)=>XLXN_397(7 downto 0),
                in_up(7 downto 0)=>XLXN_404(7 downto 0),
                out_down(7 downto 0)=>XLXN_689(7 downto 0),
                out_up(7 downto 0)=>XLXN_688(7 downto 0));
   
   XLXI_342 : comparator
      port map (in_down(7 downto 0)=>XLXN_398(7 downto 0),
                in_up(7 downto 0)=>XLXN_405(7 downto 0),
                out_down(7 downto 0)=>XLXN_691(7 downto 0),
                out_up(7 downto 0)=>XLXN_690(7 downto 0));
   
   XLXI_343 : comparator
      port map (in_down(7 downto 0)=>XLXN_399(7 downto 0),
                in_up(7 downto 0)=>XLXN_406(7 downto 0),
                out_down(7 downto 0)=>XLXN_693(7 downto 0),
                out_up(7 downto 0)=>XLXN_692(7 downto 0));
   
   XLXI_344 : comparator
      port map (in_down(7 downto 0)=>XLXN_396(7 downto 0),
                in_up(7 downto 0)=>XLXN_395(7 downto 0),
                out_down(7 downto 0)=>XLXN_687(7 downto 0),
                out_up(7 downto 0)=>XLXN_686(7 downto 0));
   
   XLXI_345 : comparator
      port map (in_down(7 downto 0)=>XLXN_402(7 downto 0),
                in_up(7 downto 0)=>XLXN_393(7 downto 0),
                out_down(7 downto 0)=>XLXN_683(7 downto 0),
                out_up(7 downto 0)=>XLXN_682(7 downto 0));
   
   XLXI_346 : comparator
      port map (in_down(7 downto 0)=>XLXN_403(7 downto 0),
                in_up(7 downto 0)=>XLXN_394(7 downto 0),
                out_down(7 downto 0)=>XLXN_685(7 downto 0),
                out_up(7 downto 0)=>XLXN_684(7 downto 0));
   
   XLXI_347 : comparator
      port map (in_down(7 downto 0)=>XLXN_401(7 downto 0),
                in_up(7 downto 0)=>XLXN_392(7 downto 0),
                out_down(7 downto 0)=>XLXN_681(7 downto 0),
                out_up(7 downto 0)=>XLXN_680(7 downto 0));
   
   XLXI_348 : comparator
      port map (in_down(7 downto 0)=>XLXN_391(7 downto 0),
                in_up(7 downto 0)=>XLXN_390(7 downto 0),
                out_down(7 downto 0)=>XLXN_679(7 downto 0),
                out_up(7 downto 0)=>XLXN_678(7 downto 0));
   
   XLXI_364 : comparator
      port map (in_down(7 downto 0)=>XLXN_410(7 downto 0),
                in_up(7 downto 0)=>XLXN_409(7 downto 0),
                out_down(7 downto 0)=>XLXN_436(7 downto 0),
                out_up(7 downto 0)=>XLXN_434(7 downto 0));
   
   XLXI_365 : comparator
      port map (in_down(7 downto 0)=>XLXN_432(7 downto 0),
                in_up(7 downto 0)=>XLXN_411(7 downto 0),
                out_down(7 downto 0)=>XLXN_437(7 downto 0),
                out_up(7 downto 0)=>XLXN_435(7 downto 0));
   
   XLXI_366 : comparator
      port map (in_down(7 downto 0)=>XLXN_426(7 downto 0),
                in_up(7 downto 0)=>XLXN_412(7 downto 0),
                out_down(7 downto 0)=>XLXN_440(7 downto 0),
                out_up(7 downto 0)=>XLXN_438(7 downto 0));
   
   XLXI_367 : comparator
      port map (in_down(7 downto 0)=>XLXN_427(7 downto 0),
                in_up(7 downto 0)=>XLXN_413(7 downto 0),
                out_down(7 downto 0)=>XLXN_447(7 downto 0),
                out_up(7 downto 0)=>XLXN_439(7 downto 0));
   
   XLXI_368 : comparator
      port map (in_down(7 downto 0)=>XLXN_419(7 downto 0),
                in_up(7 downto 0)=>XLXN_414(7 downto 0),
                out_down(7 downto 0)=>XLXN_450(7 downto 0),
                out_up(7 downto 0)=>XLXN_448(7 downto 0));
   
   XLXI_369 : comparator
      port map (in_down(7 downto 0)=>XLXN_420(7 downto 0),
                in_up(7 downto 0)=>XLXN_415(7 downto 0),
                out_down(7 downto 0)=>XLXN_451(7 downto 0),
                out_up(7 downto 0)=>XLXN_449(7 downto 0));
   
   XLXI_370 : comparator
      port map (in_down(7 downto 0)=>XLXN_421(7 downto 0),
                in_up(7 downto 0)=>XLXN_416(7 downto 0),
                out_down(7 downto 0)=>XLXN_454(7 downto 0),
                out_up(7 downto 0)=>XLXN_452(7 downto 0));
   
   XLXI_371 : comparator
      port map (in_down(7 downto 0)=>XLXN_422(7 downto 0),
                in_up(7 downto 0)=>XLXN_417(7 downto 0),
                out_down(7 downto 0)=>XLXN_455(7 downto 0),
                out_up(7 downto 0)=>XLXN_453(7 downto 0));
   
   XLXI_372 : comparator
      port map (in_down(7 downto 0)=>XLXN_423(7 downto 0),
                in_up(7 downto 0)=>XLXN_418(7 downto 0),
                out_down(7 downto 0)=>XLXN_458(7 downto 0),
                out_up(7 downto 0)=>XLXN_456(7 downto 0));
   
   XLXI_373 : comparator
      port map (in_down(7 downto 0)=>XLXN_424(7 downto 0),
                in_up(7 downto 0)=>XLXN_429(7 downto 0),
                out_down(7 downto 0)=>XLXN_459(7 downto 0),
                out_up(7 downto 0)=>XLXN_457(7 downto 0));
   
   XLXI_374 : comparator
      port map (in_down(7 downto 0)=>XLXN_425(7 downto 0),
                in_up(7 downto 0)=>XLXN_428(7 downto 0),
                out_down(7 downto 0)=>XLXN_471(7 downto 0),
                out_up(7 downto 0)=>XLXN_460(7 downto 0));
   
   XLXI_375 : comparator
      port map (in_down(7 downto 0)=>XLXN_435(7 downto 0),
                in_up(7 downto 0)=>XLXN_434(7 downto 0),
                out_down(7 downto 0)=>XLXN_464(7 downto 0),
                out_up(7 downto 0)=>XLXN_513(7 downto 0));
   
   XLXI_376 : comparator
      port map (in_down(7 downto 0)=>XLXN_437(7 downto 0),
                in_up(7 downto 0)=>XLXN_436(7 downto 0),
                out_down(7 downto 0)=>XLXN_465(7 downto 0),
                out_up(7 downto 0)=>XLXN_758(7 downto 0));
   
   XLXI_377 : comparator
      port map (in_down(7 downto 0)=>XLXN_439(7 downto 0),
                in_up(7 downto 0)=>XLXN_438(7 downto 0),
                out_down(7 downto 0)=>XLXN_466(7 downto 0),
                out_up(7 downto 0)=>XLXN_761(7 downto 0));
   
   XLXI_378 : comparator
      port map (in_down(7 downto 0)=>XLXN_447(7 downto 0),
                in_up(7 downto 0)=>XLXN_440(7 downto 0),
                out_down(7 downto 0)=>XLXN_467(7 downto 0),
                out_up(7 downto 0)=>XLXN_744(7 downto 0));
   
   XLXI_379 : comparator
      port map (in_down(7 downto 0)=>XLXN_449(7 downto 0),
                in_up(7 downto 0)=>XLXN_448(7 downto 0),
                out_down(7 downto 0)=>XLXN_738(7 downto 0),
                out_up(7 downto 0)=>XLXN_740(7 downto 0));
   
   XLXI_380 : comparator
      port map (in_down(7 downto 0)=>XLXN_451(7 downto 0),
                in_up(7 downto 0)=>XLXN_450(7 downto 0),
                out_down(7 downto 0)=>XLXN_735(7 downto 0),
                out_up(7 downto 0)=>XLXN_737(7 downto 0));
   
   XLXI_381 : comparator
      port map (in_down(7 downto 0)=>XLXN_453(7 downto 0),
                in_up(7 downto 0)=>XLXN_452(7 downto 0),
                out_down(7 downto 0)=>XLXN_733(7 downto 0),
                out_up(7 downto 0)=>XLXN_741(7 downto 0));
   
   XLXI_382 : comparator
      port map (in_down(7 downto 0)=>XLXN_455(7 downto 0),
                in_up(7 downto 0)=>XLXN_454(7 downto 0),
                out_down(7 downto 0)=>XLXN_732(7 downto 0),
                out_up(7 downto 0)=>XLXN_463(7 downto 0));
   
   XLXI_383 : comparator
      port map (in_down(7 downto 0)=>XLXN_457(7 downto 0),
                in_up(7 downto 0)=>XLXN_456(7 downto 0),
                out_down(7 downto 0)=>XLXN_763(7 downto 0),
                out_up(7 downto 0)=>XLXN_468(7 downto 0));
   
   XLXI_384 : comparator
      port map (in_down(7 downto 0)=>XLXN_459(7 downto 0),
                in_up(7 downto 0)=>XLXN_458(7 downto 0),
                out_down(7 downto 0)=>XLXN_764(7 downto 0),
                out_up(7 downto 0)=>XLXN_469(7 downto 0));
   
   XLXI_385 : comparator
      port map (in_down(7 downto 0)=>XLXN_755(7 downto 0),
                in_up(7 downto 0)=>XLXN_460(7 downto 0),
                out_down(7 downto 0)=>XLXN_536(7 downto 0),
                out_up(7 downto 0)=>XLXN_470(7 downto 0));
   
   XLXI_386 : comparator
      port map (in_down(7 downto 0)=>XLXN_468(7 downto 0),
                in_up(7 downto 0)=>XLXN_464(7 downto 0),
                out_down(7 downto 0)=>XLXN_725(7 downto 0),
                out_up(7 downto 0)=>XLXN_724(7 downto 0));
   
   XLXI_387 : comparator
      port map (in_down(7 downto 0)=>XLXN_469(7 downto 0),
                in_up(7 downto 0)=>XLXN_465(7 downto 0),
                out_down(7 downto 0)=>XLXN_727(7 downto 0),
                out_up(7 downto 0)=>XLXN_726(7 downto 0));
   
   XLXI_388 : comparator
      port map (in_down(7 downto 0)=>XLXN_470(7 downto 0),
                in_up(7 downto 0)=>XLXN_466(7 downto 0),
                out_down(7 downto 0)=>XLXN_729(7 downto 0),
                out_up(7 downto 0)=>XLXN_728(7 downto 0));
   
   XLXI_389 : comparator
      port map (in_down(7 downto 0)=>XLXN_471(7 downto 0),
                in_up(7 downto 0)=>XLXN_467(7 downto 0),
                out_down(7 downto 0)=>XLXN_731(7 downto 0),
                out_up(7 downto 0)=>XLXN_730(7 downto 0));
   
   XLXI_390 : comparator
      port map (in_down(7 downto 0)=>XLXN_463(7 downto 0),
                in_up(7 downto 0)=>XLXN_462(7 downto 0),
                out_down(7 downto 0)=>XLXN_723(7 downto 0),
                out_up(7 downto 0)=>XLXN_722(7 downto 0));
   
   XLXI_393 : comparator
      port map (in_down(7 downto 0)=>XLXN_483(7 downto 0),
                in_up(7 downto 0)=>XLXN_474(7 downto 0),
                out_down(7 downto 0)=>XLXN_507(7 downto 0),
                out_up(7 downto 0)=>XLXN_491(7 downto 0));
   
   XLXI_394 : comparator
      port map (in_down(7 downto 0)=>XLXN_484(7 downto 0),
                in_up(7 downto 0)=>XLXN_475(7 downto 0),
                out_down(7 downto 0)=>XLXN_506(7 downto 0),
                out_up(7 downto 0)=>XLXN_492(7 downto 0));
   
   XLXI_395 : comparator
      port map (in_down(7 downto 0)=>XLXN_485(7 downto 0),
                in_up(7 downto 0)=>XLXN_476(7 downto 0),
                out_down(7 downto 0)=>XLXN_505(7 downto 0),
                out_up(7 downto 0)=>XLXN_493(7 downto 0));
   
   XLXI_396 : comparator
      port map (in_down(7 downto 0)=>XLXN_478(7 downto 0),
                in_up(7 downto 0)=>XLXN_477(7 downto 0),
                out_down(7 downto 0)=>XLXN_504(7 downto 0),
                out_up(7 downto 0)=>XLXN_494(7 downto 0));
   
   XLXI_397 : comparator
      port map (in_down(7 downto 0)=>XLXN_479(7 downto 0),
                in_up(7 downto 0)=>XLXN_486(7 downto 0),
                out_down(7 downto 0)=>XLXN_503(7 downto 0),
                out_up(7 downto 0)=>XLXN_495(7 downto 0));
   
   XLXI_398 : comparator
      port map (in_down(7 downto 0)=>XLXN_480(7 downto 0),
                in_up(7 downto 0)=>XLXN_487(7 downto 0),
                out_down(7 downto 0)=>XLXN_502(7 downto 0),
                out_up(7 downto 0)=>XLXN_496(7 downto 0));
   
   XLXI_399 : comparator
      port map (in_down(7 downto 0)=>XLXN_481(7 downto 0),
                in_up(7 downto 0)=>XLXN_488(7 downto 0),
                out_down(7 downto 0)=>XLXN_501(7 downto 0),
                out_up(7 downto 0)=>XLXN_497(7 downto 0));
   
   XLXI_400 : comparator
      port map (in_down(7 downto 0)=>XLXN_482(7 downto 0),
                in_up(7 downto 0)=>XLXN_489(7 downto 0),
                out_down(7 downto 0)=>XLXN_500(7 downto 0),
                out_up(7 downto 0)=>XLXN_498(7 downto 0));
   
   XLXI_401 : comparator
      port map (in_down(7 downto 0)=>XLXN_473(7 downto 0),
                in_up(7 downto 0)=>XLXN_472(7 downto 0),
                out_down(7 downto 0)=>XLXN_499(7 downto 0),
                out_up(7 downto 0)=>XLXN_490(7 downto 0));
   
   XLXI_405 : comparator
      port map (in_down(7 downto 0)=>XLXN_507(7 downto 0),
                in_up(7 downto 0)=>XLXN_493(7 downto 0),
                out_down(7 downto 0)=>XLXN_529(7 downto 0),
                out_up(7 downto 0)=>XLXN_518(7 downto 0));
   
   XLXI_406 : comparator
      port map (in_down(7 downto 0)=>XLXN_506(7 downto 0),
                in_up(7 downto 0)=>XLXN_494(7 downto 0),
                out_down(7 downto 0)=>XLXN_530(7 downto 0),
                out_up(7 downto 0)=>XLXN_519(7 downto 0));
   
   XLXI_407 : comparator
      port map (in_down(7 downto 0)=>XLXN_505(7 downto 0),
                in_up(7 downto 0)=>XLXN_495(7 downto 0),
                out_down(7 downto 0)=>XLXN_531(7 downto 0),
                out_up(7 downto 0)=>XLXN_520(7 downto 0));
   
   XLXI_408 : comparator
      port map (in_down(7 downto 0)=>XLXN_504(7 downto 0),
                in_up(7 downto 0)=>XLXN_496(7 downto 0),
                out_down(7 downto 0)=>XLXN_532(7 downto 0),
                out_up(7 downto 0)=>XLXN_521(7 downto 0));
   
   XLXI_409 : comparator
      port map (in_down(7 downto 0)=>XLXN_503(7 downto 0),
                in_up(7 downto 0)=>XLXN_497(7 downto 0),
                out_down(7 downto 0)=>XLXN_533(7 downto 0),
                out_up(7 downto 0)=>XLXN_522(7 downto 0));
   
   XLXI_410 : comparator
      port map (in_down(7 downto 0)=>XLXN_499(7 downto 0),
                in_up(7 downto 0)=>XLXN_492(7 downto 0),
                out_down(7 downto 0)=>XLXN_528(7 downto 0),
                out_up(7 downto 0)=>XLXN_517(7 downto 0));
   
   XLXI_411 : comparator
      port map (in_down(7 downto 0)=>XLXN_501(7 downto 0),
                in_up(7 downto 0)=>XLXN_511(7 downto 0),
                out_down(7 downto 0)=>XLXN_535(7 downto 0),
                out_up(7 downto 0)=>XLXN_524(7 downto 0));
   
   XLXI_412 : comparator
      port map (in_down(7 downto 0)=>XLXN_500(7 downto 0),
                in_up(7 downto 0)=>XLXN_510(7 downto 0),
                out_down(7 downto 0)=>XLXN_526(7 downto 0),
                out_up(7 downto 0)=>XLXN_525(7 downto 0));
   
   XLXI_413 : comparator
      port map (in_down(7 downto 0)=>XLXN_502(7 downto 0),
                in_up(7 downto 0)=>XLXN_498(7 downto 0),
                out_down(7 downto 0)=>XLXN_534(7 downto 0),
                out_up(7 downto 0)=>XLXN_523(7 downto 0));
   
   XLXI_414 : comparator
      port map (in_down(7 downto 0)=>XLXN_509(7 downto 0),
                in_up(7 downto 0)=>XLXN_491(7 downto 0),
                out_down(7 downto 0)=>XLXN_527(7 downto 0),
                out_up(7 downto 0)=>XLXN_515(7 downto 0));
   
   XLXI_415 : comparator
      port map (in_down(7 downto 0)=>XLXN_508(7 downto 0),
                in_up(7 downto 0)=>XLXN_490(7 downto 0),
                out_down(7 downto 0)=>XLXN_516(7 downto 0),
                out_up(7 downto 0)=>XLXN_512(7 downto 0));
   
   XLXI_416 : comparator
      port map (in_down(7 downto 0)=>XLXN_526(7 downto 0),
                in_up(7 downto 0)=>XLXN_766(7 downto 0),
                out_down(7 downto 0)=>XLXN_798(7 downto 0),
                out_up(7 downto 0)=>XLXN_797(7 downto 0));
   
   XLXI_417 : comparator
      port map (in_down(7 downto 0)=>XLXN_535(7 downto 0),
                in_up(7 downto 0)=>XLXN_525(7 downto 0),
                out_down(7 downto 0)=>XLXN_796(7 downto 0),
                out_up(7 downto 0)=>XLXN_795(7 downto 0));
   
   XLXI_418 : comparator
      port map (in_down(7 downto 0)=>XLXN_534(7 downto 0),
                in_up(7 downto 0)=>XLXN_524(7 downto 0),
                out_down(7 downto 0)=>XLXN_794(7 downto 0),
                out_up(7 downto 0)=>XLXN_793(7 downto 0));
   
   XLXI_419 : comparator
      port map (in_down(7 downto 0)=>XLXN_533(7 downto 0),
                in_up(7 downto 0)=>XLXN_523(7 downto 0),
                out_down(7 downto 0)=>XLXN_792(7 downto 0),
                out_up(7 downto 0)=>XLXN_791(7 downto 0));
   
   XLXI_420 : comparator
      port map (in_down(7 downto 0)=>XLXN_532(7 downto 0),
                in_up(7 downto 0)=>XLXN_522(7 downto 0),
                out_down(7 downto 0)=>XLXN_790(7 downto 0),
                out_up(7 downto 0)=>XLXN_789(7 downto 0));
   
   XLXI_421 : comparator
      port map (in_down(7 downto 0)=>XLXN_531(7 downto 0),
                in_up(7 downto 0)=>XLXN_521(7 downto 0),
                out_down(7 downto 0)=>XLXN_788(7 downto 0),
                out_up(7 downto 0)=>XLXN_787(7 downto 0));
   
   XLXI_422 : comparator
      port map (in_down(7 downto 0)=>XLXN_530(7 downto 0),
                in_up(7 downto 0)=>XLXN_520(7 downto 0),
                out_down(7 downto 0)=>XLXN_786(7 downto 0),
                out_up(7 downto 0)=>XLXN_785(7 downto 0));
   
   XLXI_423 : comparator
      port map (in_down(7 downto 0)=>XLXN_529(7 downto 0),
                in_up(7 downto 0)=>XLXN_519(7 downto 0),
                out_down(7 downto 0)=>XLXN_784(7 downto 0),
                out_up(7 downto 0)=>XLXN_783(7 downto 0));
   
   XLXI_424 : comparator
      port map (in_down(7 downto 0)=>XLXN_528(7 downto 0),
                in_up(7 downto 0)=>XLXN_518(7 downto 0),
                out_down(7 downto 0)=>XLXN_782(7 downto 0),
                out_up(7 downto 0)=>XLXN_781(7 downto 0));
   
   XLXI_425 : comparator
      port map (in_down(7 downto 0)=>XLXN_527(7 downto 0),
                in_up(7 downto 0)=>XLXN_517(7 downto 0),
                out_down(7 downto 0)=>XLXN_780(7 downto 0),
                out_up(7 downto 0)=>XLXN_779(7 downto 0));
   
   XLXI_426 : comparator
      port map (in_down(7 downto 0)=>XLXN_516(7 downto 0),
                in_up(7 downto 0)=>XLXN_515(7 downto 0),
                out_down(7 downto 0)=>XLXN_778(7 downto 0),
                out_up(7 downto 0)=>XLXN_777(7 downto 0));
   
   XLXI_427 : comparator
      port map (in_down(7 downto 0)=>XLXN_771(7 downto 0),
                in_up(7 downto 0)=>XLXN_512(7 downto 0),
                out_down(7 downto 0)=>XLXN_776(7 downto 0),
                out_up(7 downto 0)=>XLXN_775(7 downto 0));
   
   XLXI_429 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_603(7 downto 0),
                out1(7 downto 0)=>XLXN_322(7 downto 0));
   
   XLXI_430 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_575(7 downto 0),
                out1(7 downto 0)=>XLXN_120(7 downto 0));
   
   XLXI_431 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_576(7 downto 0),
                out1(7 downto 0)=>XLXN_320(7 downto 0));
   
   XLXI_433 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_577(7 downto 0),
                out1(7 downto 0)=>XLXN_119(7 downto 0));
   
   XLXI_434 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_578(7 downto 0),
                out1(7 downto 0)=>XLXN_318(7 downto 0));
   
   XLXI_436 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_584(7 downto 0),
                out1(7 downto 0)=>XLXN_118(7 downto 0));
   
   XLXI_437 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_585(7 downto 0),
                out1(7 downto 0)=>XLXN_316(7 downto 0));
   
   XLXI_438 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_586(7 downto 0),
                out1(7 downto 0)=>XLXN_117(7 downto 0));
   
   XLXI_439 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_587(7 downto 0),
                out1(7 downto 0)=>XLXN_121(7 downto 0));
   
   XLXI_440 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_588(7 downto 0),
                out1(7 downto 0)=>XLXN_122(7 downto 0));
   
   XLXI_441 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_589(7 downto 0),
                out1(7 downto 0)=>XLXN_131(7 downto 0));
   
   XLXI_442 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_590(7 downto 0),
                out1(7 downto 0)=>XLXN_123(7 downto 0));
   
   XLXI_443 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_591(7 downto 0),
                out1(7 downto 0)=>XLXN_130(7 downto 0));
   
   XLXI_444 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_592(7 downto 0),
                out1(7 downto 0)=>XLXN_124(7 downto 0));
   
   XLXI_445 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_593(7 downto 0),
                out1(7 downto 0)=>XLXN_129(7 downto 0));
   
   XLXI_446 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_594(7 downto 0),
                out1(7 downto 0)=>XLXN_128(7 downto 0));
   
   XLXI_447 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_595(7 downto 0),
                out1(7 downto 0)=>XLXN_116(7 downto 0));
   
   XLXI_448 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_596(7 downto 0),
                out1(7 downto 0)=>XLXN_127(7 downto 0));
   
   XLXI_449 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_597(7 downto 0),
                out1(7 downto 0)=>XLXN_115(7 downto 0));
   
   XLXI_450 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_598(7 downto 0),
                out1(7 downto 0)=>XLXN_126(7 downto 0));
   
   XLXI_451 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_599(7 downto 0),
                out1(7 downto 0)=>XLXN_114(7 downto 0));
   
   XLXI_452 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_600(7 downto 0),
                out1(7 downto 0)=>XLXN_125(7 downto 0));
   
   XLXI_453 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_601(7 downto 0),
                out1(7 downto 0)=>XLXN_113(7 downto 0));
   
   XLXI_454 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_602(7 downto 0),
                out1(7 downto 0)=>XLXN_132(7 downto 0));
   
   XLXI_455 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_604(7 downto 0),
                out1(7 downto 0)=>XLXN_325(7 downto 0));
   
   XLXI_456 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_629(7 downto 0),
                out1(7 downto 0)=>XLXN_379(7 downto 0));
   
   XLXI_457 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_630(7 downto 0),
                out1(7 downto 0)=>XLXN_361(7 downto 0));
   
   XLXI_458 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_631(7 downto 0),
                out1(7 downto 0)=>XLXN_360(7 downto 0));
   
   XLXI_459 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_632(7 downto 0),
                out1(7 downto 0)=>XLXN_367(7 downto 0));
   
   XLXI_460 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_633(7 downto 0),
                out1(7 downto 0)=>XLXN_359(7 downto 0));
   
   XLXI_461 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_634(7 downto 0),
                out1(7 downto 0)=>XLXN_366(7 downto 0));
   
   XLXI_462 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_635(7 downto 0),
                out1(7 downto 0)=>XLXN_369(7 downto 0));
   
   XLXI_463 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_636(7 downto 0),
                out1(7 downto 0)=>XLXN_358(7 downto 0));
   
   XLXI_464 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_637(7 downto 0),
                out1(7 downto 0)=>XLXN_368(7 downto 0));
   
   XLXI_465 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_638(7 downto 0),
                out1(7 downto 0)=>XLXN_357(7 downto 0));
   
   XLXI_466 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_639(7 downto 0),
                out1(7 downto 0)=>XLXN_356(7 downto 0));
   
   XLXI_467 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_640(7 downto 0),
                out1(7 downto 0)=>XLXN_365(7 downto 0));
   
   XLXI_468 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_641(7 downto 0),
                out1(7 downto 0)=>XLXN_355(7 downto 0));
   
   XLXI_469 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_642(7 downto 0),
                out1(7 downto 0)=>XLXN_362(7 downto 0));
   
   XLXI_470 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_643(7 downto 0),
                out1(7 downto 0)=>XLXN_364(7 downto 0));
   
   XLXI_471 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_644(7 downto 0),
                out1(7 downto 0)=>XLXN_354(7 downto 0));
   
   XLXI_472 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_645(7 downto 0),
                out1(7 downto 0)=>XLXN_363(7 downto 0));
   
   XLXI_473 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_646(7 downto 0),
                out1(7 downto 0)=>XLXN_353(7 downto 0));
   
   XLXI_474 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_650(7 downto 0),
                out1(7 downto 0)=>XLXN_371(7 downto 0));
   
   XLXI_475 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_647(7 downto 0),
                out1(7 downto 0)=>XLXN_373(7 downto 0));
   
   XLXI_476 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_653(7 downto 0),
                out1(7 downto 0)=>XLXN_370(7 downto 0));
   
   XLXI_477 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_657(7 downto 0),
                out1(7 downto 0)=>XLXN_380(7 downto 0));
   
   XLXI_478 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_678(7 downto 0),
                out1(7 downto 0)=>XLXN_409(7 downto 0));
   
   XLXI_479 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_679(7 downto 0),
                out1(7 downto 0)=>XLXN_426(7 downto 0));
   
   XLXI_480 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_680(7 downto 0),
                out1(7 downto 0)=>XLXN_411(7 downto 0));
   
   XLXI_481 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_681(7 downto 0),
                out1(7 downto 0)=>XLXN_427(7 downto 0));
   
   XLXI_482 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_682(7 downto 0),
                out1(7 downto 0)=>XLXN_412(7 downto 0));
   
   XLXI_483 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_683(7 downto 0),
                out1(7 downto 0)=>XLXN_419(7 downto 0));
   
   XLXI_484 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_684(7 downto 0),
                out1(7 downto 0)=>XLXN_413(7 downto 0));
   
   XLXI_485 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_685(7 downto 0),
                out1(7 downto 0)=>XLXN_420(7 downto 0));
   
   XLXI_486 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_686(7 downto 0),
                out1(7 downto 0)=>XLXN_414(7 downto 0));
   
   XLXI_487 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_687(7 downto 0),
                out1(7 downto 0)=>XLXN_421(7 downto 0));
   
   XLXI_488 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_688(7 downto 0),
                out1(7 downto 0)=>XLXN_415(7 downto 0));
   
   XLXI_489 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_689(7 downto 0),
                out1(7 downto 0)=>XLXN_422(7 downto 0));
   
   XLXI_490 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_690(7 downto 0),
                out1(7 downto 0)=>XLXN_416(7 downto 0));
   
   XLXI_491 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_691(7 downto 0),
                out1(7 downto 0)=>XLXN_423(7 downto 0));
   
   XLXI_492 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_692(7 downto 0),
                out1(7 downto 0)=>XLXN_417(7 downto 0));
   
   XLXI_493 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_693(7 downto 0),
                out1(7 downto 0)=>XLXN_424(7 downto 0));
   
   XLXI_494 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_694(7 downto 0),
                out1(7 downto 0)=>XLXN_418(7 downto 0));
   
   XLXI_495 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_695(7 downto 0),
                out1(7 downto 0)=>XLXN_425(7 downto 0));
   
   XLXI_496 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_696(7 downto 0),
                out1(7 downto 0)=>XLXN_428(7 downto 0));
   
   XLXI_497 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_697(7 downto 0),
                out1(7 downto 0)=>XLXN_429(7 downto 0));
   
   XLXI_498 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_701(7 downto 0),
                out1(7 downto 0)=>XLXN_410(7 downto 0));
   
   XLXI_499 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_700(7 downto 0),
                out1(7 downto 0)=>XLXN_432(7 downto 0));
   
   XLXI_500 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_722(7 downto 0),
                out1(7 downto 0)=>XLXN_472(7 downto 0));
   
   XLXI_501 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_723(7 downto 0),
                out1(7 downto 0)=>XLXN_478(7 downto 0));
   
   XLXI_502 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_724(7 downto 0),
                out1(7 downto 0)=>XLXN_474(7 downto 0));
   
   XLXI_503 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_725(7 downto 0),
                out1(7 downto 0)=>XLXN_479(7 downto 0));
   
   XLXI_504 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_726(7 downto 0),
                out1(7 downto 0)=>XLXN_475(7 downto 0));
   
   XLXI_505 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_727(7 downto 0),
                out1(7 downto 0)=>XLXN_480(7 downto 0));
   
   XLXI_506 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_728(7 downto 0),
                out1(7 downto 0)=>XLXN_476(7 downto 0));
   
   XLXI_507 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_729(7 downto 0),
                out1(7 downto 0)=>XLXN_481(7 downto 0));
   
   XLXI_508 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_730(7 downto 0),
                out1(7 downto 0)=>XLXN_477(7 downto 0));
   
   XLXI_509 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_731(7 downto 0),
                out1(7 downto 0)=>XLXN_482(7 downto 0));
   
   XLXI_510 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_732(7 downto 0),
                out1(7 downto 0)=>XLXN_489(7 downto 0));
   
   XLXI_511 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_733(7 downto 0),
                out1(7 downto 0)=>XLXN_488(7 downto 0));
   
   XLXI_512 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_741(7 downto 0),
                out1(7 downto 0)=>XLXN_485(7 downto 0));
   
   XLXI_513 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_735(7 downto 0),
                out1(7 downto 0)=>XLXN_487(7 downto 0));
   
   XLXI_514 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_737(7 downto 0),
                out1(7 downto 0)=>XLXN_484(7 downto 0));
   
   XLXI_515 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_738(7 downto 0),
                out1(7 downto 0)=>XLXN_486(7 downto 0));
   
   XLXI_516 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_740(7 downto 0),
                out1(7 downto 0)=>XLXN_483(7 downto 0));
   
   XLXI_517 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_744(7 downto 0),
                out1(7 downto 0)=>XLXN_473(7 downto 0));
   
   XLXI_518 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_749(7 downto 0),
                out1(7 downto 0)=>XLXN_750(7 downto 0));
   
   XLXI_519 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_750(7 downto 0),
                out1(7 downto 0)=>XLXN_462(7 downto 0));
   
   XLXI_520 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_752(7 downto 0),
                out1(7 downto 0)=>XLXN_753(7 downto 0));
   
   XLXI_521 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_753(7 downto 0),
                out1(7 downto 0)=>XLXN_755(7 downto 0));
   
   XLXI_523 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_758(7 downto 0),
                out1(7 downto 0)=>XLXN_508(7 downto 0));
   
   XLXI_524 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_761(7 downto 0),
                out1(7 downto 0)=>XLXN_509(7 downto 0));
   
   XLXI_525 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_763(7 downto 0),
                out1(7 downto 0)=>XLXN_511(7 downto 0));
   
   XLXI_526 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_764(7 downto 0),
                out1(7 downto 0)=>XLXN_510(7 downto 0));
   
   XLXI_527 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_536(7 downto 0),
                out1(7 downto 0)=>XLXN_766(7 downto 0));
   
   XLXI_528 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_513(7 downto 0),
                out1(7 downto 0)=>XLXN_771(7 downto 0));
   
   XLXI_529 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_775(7 downto 0),
                out1(7 downto 0)=>XLXN_563(7 downto 0));
   
   XLXI_530 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_776(7 downto 0),
                out1(7 downto 0)=>XLXN_562(7 downto 0));
   
   XLXI_531 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_777(7 downto 0),
                out1(7 downto 0)=>XLXN_561(7 downto 0));
   
   XLXI_532 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_778(7 downto 0),
                out1(7 downto 0)=>XLXN_560(7 downto 0));
   
   XLXI_533 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_779(7 downto 0),
                out1(7 downto 0)=>XLXN_559(7 downto 0));
   
   XLXI_534 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_780(7 downto 0),
                out1(7 downto 0)=>XLXN_558(7 downto 0));
   
   XLXI_535 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_781(7 downto 0),
                out1(7 downto 0)=>XLXN_557(7 downto 0));
   
   XLXI_536 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_782(7 downto 0),
                out1(7 downto 0)=>XLXN_556(7 downto 0));
   
   XLXI_537 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_783(7 downto 0),
                out1(7 downto 0)=>XLXN_555(7 downto 0));
   
   XLXI_538 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_784(7 downto 0),
                out1(7 downto 0)=>XLXN_554(7 downto 0));
   
   XLXI_539 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_785(7 downto 0),
                out1(7 downto 0)=>XLXN_553(7 downto 0));
   
   XLXI_540 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_786(7 downto 0),
                out1(7 downto 0)=>XLXN_552(7 downto 0));
   
   XLXI_541 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_787(7 downto 0),
                out1(7 downto 0)=>XLXN_551(7 downto 0));
   
   XLXI_542 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_788(7 downto 0),
                out1(7 downto 0)=>XLXN_550(7 downto 0));
   
   XLXI_543 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_789(7 downto 0),
                out1(7 downto 0)=>XLXN_549(7 downto 0));
   
   XLXI_544 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_790(7 downto 0),
                out1(7 downto 0)=>XLXN_548(7 downto 0));
   
   XLXI_545 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_791(7 downto 0),
                out1(7 downto 0)=>XLXN_547(7 downto 0));
   
   XLXI_546 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_792(7 downto 0),
                out1(7 downto 0)=>XLXN_546(7 downto 0));
   
   XLXI_547 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_793(7 downto 0),
                out1(7 downto 0)=>XLXN_545(7 downto 0));
   
   XLXI_548 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_794(7 downto 0),
                out1(7 downto 0)=>XLXN_544(7 downto 0));
   
   XLXI_549 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_795(7 downto 0),
                out1(7 downto 0)=>XLXN_543(7 downto 0));
   
   XLXI_550 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_796(7 downto 0),
                out1(7 downto 0)=>XLXN_542(7 downto 0));
   
   XLXI_551 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_797(7 downto 0),
                out1(7 downto 0)=>XLXN_541(7 downto 0));
   
   XLXI_552 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_798(7 downto 0),
                out1(7 downto 0)=>XLXN_540(7 downto 0));
   
   XLXI_553 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_800(7 downto 0),
                out1(7 downto 0)=>XLXN_564(7 downto 0));
   
   XLXI_554 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_804(7 downto 0),
                out1(7 downto 0)=>XLXN_800(7 downto 0));
   
   XLXI_556 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_805(7 downto 0),
                out1(7 downto 0)=>XLXN_804(7 downto 0));
   
   XLXI_557 : ff
      port map (clk=>clk,
                in1(7 downto 0)=>XLXN_806(7 downto 0),
                out1(7 downto 0)=>XLXN_805(7 downto 0));
   
end BEHAVIORAL;

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

