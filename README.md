# Summary

A Full pipelined, low latency, adaptive spatial filter for real-time YUV Video denoising. It targets FPGA, but can be implemented on ASICs as its design requires little ressources.

This Repo is a VHDL implementation and improvemeent of the filter presented in SPIE publication [Adaptive defect correction and noise suppression module in the CIS image processing system](https://doi.org/10.1117/12.836651). It has been tested successfully on a FPGA Virtex-II runing at 105MHz.


It takes a continuous stream of input pixels (5-lines input), transforms it into a 5x5 pixels kernel block, and output a processed pixel (line 3) 15 clocks cycles later.

This adaptive filter work on the YUV color space. Each color component need to call its own instance of the filter.

Purpose of this filter is to remove impulse noise ("Salt & pepper"), and reduce Gaussian noise while preserving details of the image. It uses a combination of Weighted-Median filter(CWM) and a set of Gaussian's filters associated with defect detector and details estimator for filter selection.

To achieve so, some novative FPGA designs had been used, like a 25-elements Batcher's odd-even mergesorte, or constant coefficient Multiplication/Division using LUTs only.

Effectiveness of the filter IP had been demonstrated with the use of PSNR, as detailed in the [published article](https://doi.org/10.1117/12.836651).


- This README file is working as a general documentation. please contact the author at olivier.faurie.hk@gmail.com for detailed specification and test document.
- Implementable code of the filter (HDL+XDC), and VHDL testbench associated can be found in the [FGPA](https://github.com/OlivierHK/FPGA_IP_RealTime_Adaptive_Video_Denoising_Filter/tree/main/FPGA) Folder.
- Matlab project code with exemple, image generation and PSNR calculation can be found in the [MATLAB](https://github.com/OlivierHK/FPGA_IP_RealTime_Adaptive_Video_Denoising_Filter/tree/main/MATLAB) Folder.
- A 5x5 Block kernel tester in the form of an `.odf` file can be found in the root of this repository as `Spreadsheet_Tester.odt`. 


# Filter Architecture

The architecture of the IP can be defined as:

![Filter_architecture_diagram](https://github.com/user-attachments/assets/d8242c80-be30-41fe-9f04-116b957eac0f)

From a 5x5 block of pixels:

1. It will be first analized by a defect detector (cross mask checking) for impulse noise finding. If found, it will send the block to the CWM filter. if not, either defect detector found a line of pixel and the block will be bypassed, or it will be sent to the detail estimator.

2. In the detail estimator, it will be compared from 2 fixed thresholds values. It will then be send on either the 5x5 Gauss filter if very low details found, send to the 3x3 Gauss if low details found, or bypassed if high details found. Before being processed by Gaussian filters, extremum values of the sorted block will be swaped by middle pixel value. This is done to avoid an impulse noise in the 5x5 block to introduce too much shift in the outputed pixel.


as summary for filters:
- CW Median filter must be used for pepper noise and edges.
- Gaussian 3x3 filter must be used for low details area.
- Gaussian 5x5 filter must be used for very low details area.
- No filtering in high details area.


## Defect Estimator 


Defect Estimator is under the form of a cross-mask centered of the 5x5 block middle pixel, where we compute the Absolute maximum (T1) and Absolute minimum(T2). their value is compared to fixed threshold and will tell if the block will go for CWM or not.

![Cross_Mask](https://github.com/user-attachments/assets/47929578-3c02-4904-b852-a01a4a5014fc)


```
T1=abs (P – Max (P1,P2,P3,P4) )
T2=abs (P – Min (P1,P2,P3,P4) )

IF (T1>50) AND (T2>5) THEN CWM filter, else nothing.
```

T1 and T2 value had been set and fixed after several tests to identify in most case impulse noise, and to avoid drwan lines of pixels to be filtered out.

## Detail Estimator

The detail estimator will work on the whole 5x5 block of pixel:
![Detail_Estimator](https://github.com/user-attachments/assets/6f0fc3d4-c492-417a-8459-6427ee199cbe)

1. It will sort-up the 5x5 block and store it in a 25 elements array.
2. It will compute the difference between the second Maximum sorted pixel, and second Minimum sorted pixel. Max/Min pixel values are not used to avoid to pick up an impulse noise pixel (in case there is).
3. That difference value will be compares to a set of fixed threshold (T3,T4), that will tell which Gaussian filters should be used, or no filter (NOP) to be used.

```
d= Sort(22)-Sort(2)

IF(d<T3)
    THEN Gauss5x5
ELSIF(T3<d<T4)
    THEN Gauss3x3
ELSE
    NOP_Filter

With T3= 10 and T4=20
```


## CWM Filter

The CWM filter is a central-weight Median filter. This design is using a fixed 15-weighted center. It has been found the most robust and less error-prone filter for impulse noise.

1. The 5x5 Block in copied into a 25-elements array and sorted-up using a Batcher's odd-even mergesorte network algorithm.
2. the 5x5 Block middle pixel is found in the sorted array and inserted 14 times in the correct location in a new array of 39-elements.
3. the Median pixel, at the index 20, is outputed and used as filtered pixel.

The sorting is not done directly on the 39 elements array to save ressource.

## Gaussian Filters

For Removing random Gaussian type noie, 2D-Gaussian filtering has been found the most robust, stable and less prone to artifact like Moire effect.

- Gaussian 3x3 filter must be used for low details area.
- Gaussian 5x5 filter must be used for very low details area.
- Gaussian Weights are truncated as discretisation from their natural values heritated from their sigma value. They will be used as fixed value, and set as Sigma=1 and Sigma=3.8 for respectually the 3x3, and 5x5 Gaussian filter.


The smooth and light 3x3 Gaussian Filter indexes and Coefficients:

```
    Index Table       Gauss3x3 Coefficient table
 |----|----|----|         |----|----|----|
 |  0 |  1 |  2 |         |  1 |  2 |  1 |
 |----|----|----|         |----|----|----|
 |  3 |  4 |  5 |         |  2 |  3 |  2 | / 15
 |----|----|----|         |----|----|----|
 |  6 |  7 |  8 |         |  1 |  2 |  1 | 
 |----|----|----|         |----|----|----|
```

The strong 5x5 Gaussian Filter indexes and Coefficients:
```
         Index Table              Gauss5x5 Coefficient table
 |----|----|----|----|----|       |----|----|----|----|----|
 |  0 |  1 |  2 |  3 |  4 |       |  1 |  4 |  7 |  4 |  1 |
 |----|----|----|----|----|       |----|----|----|----|----|
 |  5 |  6 |  7 |  8 |  9 |       |  4 | 18 | 30 | 18 |  4 |
 |----|----|----|----|----|       |----|----|----|----|----|
 | 10 | 11 | 12 | 13 | 14 |       |  7 | 30 | 50 | 30 |  7 | / 306
 |----|----|----|----|----|       |----|----|----|----|----|
 | 15 | 16 | 17 | 18 | 19 |       |  4 | 18 | 30 | 18 |  4 |
 |----|----|----|----|----|       |----|----|----|----|----|
 | 20 | 21 | 22 | 23 | 24 |       |  1 |  4 |  7 |  4 |  1 |
 |----|----|----|----|----|       |----|----|----|----|----|
```

## NOP filter

In case of High details found in the Block of pixel, no filter is applied; The center pixel is outputed directly.


# FPGA Design

This Filter had been wrote in pure VHDL, without any proprietary IPs:
- Pixel size are 8-Bytes per YUV Channel.
- Will only use FGPA's LUTs, D-FlipFlop, CARRY8 and Mux as ressources. It should use under 6000 4-Inputs LUTs.
- The Design will be fully pipelined, where 1 clock cycle feeds-in a column of 5 pixels, and output 1 processed pixel continuoulsy.
- coding style will be as concurrent as possible, One clock cycle will do more than one operation. FDRE will then be inserted between concurent statements to meet timing constraints for a Xilinx Virtex II (105MHz). 
- All operations are done on Fixed-size Length, integer numbers, and represented as `std_logic_vector`:
  - Additions, Substractions, comparators will infer LUTs and CARRY8 type cells directly by the IDE tool. No DSP block will be used.
  - Multiplications/Divisions will be done by Left/Righ shifting and addition/substraction, using advantage of power-of-two and binary numbers. For exemple,  multiply 13 will be computed as: (2^3)+(2^2)+1 or (2^4)-(2^2)+1.
  - Several intermediary results had been casted into unsigned integer. This do no affect ressource usage, it is just done for easier readability.
- Cascade of adders/substrators will be using tree-shape design to shorten critical path, increasing parallelism. Temporary calculation registers have larger size to avoid overflow.
- Several stages of D-Flop to be added to time synchronized all datas betwen different modules, as the design have no FSM, and is a pure continuous stream.
- This filter can be implemented as an IP, or as an OOC module by the IDE.

The design's Hierrachy is as following:  
```
package_type_and_constant: [package_type_and_constant.vhd]

module_top: [module_top.vhd]
    |_ stream_to_kernel5x5_mod: [stream_to_kernel5x5.vhd]
    |_ filter_IP_mod: [filter_IP_module.vhd]
        |_ control_unit: [control.vhd]
        |   |_ sort_control: [sort_batcher.vhd]
        |   |   |_ comparatorX: [comparator.vhd]
        |   |   |_ ...
        |   |_ control_min1: [indice_MinMaxIndex_module.vhd]
        |   |_ control_min2: [indice_MinMaxIndex_module.vhd]
        |   |_ control_max1: [indice_MinMaxIndex_module.vhd]
        |   |_ control_max2: [indice_MinMaxIndex_module.vhd]
        |_ cwm_filter: cwm [filters_package.vhd]
        |_ gauss3x3_filter: gauss3x3 [filters_package.vhd]
        |_ gauss5x5_filter: gauss5x5 [filters_package.vhd]
        |_ nop_filter: nop [filters_package.vhd]

module_top_tb: [TB_test.vhd]
```
## Top module (wrapper)

The top module act as a wrapper for the in-stream to block of 5x5 pixel and the filter IP top module:

![Top_Module_wrapper_diagram](https://github.com/user-attachments/assets/7c3cb68e-f38d-45b4-a4b5-5fddd92a72aa)

### In-Stream to 5x5 block

It uses a classic image/video processing x5 pipeline of 5x D-flop to create a mask of 5x5 pixels. unlike the diagram, the code fill the flip-flop from right to left, so it ease representation during simulation:

![Strean_to_5x5Block_diagram](https://github.com/user-attachments/assets/b6fea316-564e-41b6-bc60-b166b3260e2d)


## Filter IP module

This module is the top module of the filter IP. several stages of pipeline need to be instered to control signals flow and make sure all is in sync. it can be represented as :

![filter_IP_module_diagram](https://github.com/user-attachments/assets/1cc10222-7861-4421-9d42-39ed6b631249)

## Batcher's Sort

In 2008/2009, for its first release, this work was the first documented/implemented usage of a 25-elements Batcher's odd-even mergesorte network. Extensive tests been conducted to make sure it was 100% accurate. This algorithm has been choosen as it was the best in terms of needed comparators. it requires:
- 138 comparators.
- 15 parallels operations.
- 5 pipelines stages to meetup 100MHz timing (3 comparators cascaded per clock cycle).

Since, such type of sorting has been formalized and can even be writen as parametric code. It seems it also managed to reduce its number of needed comparators from 138 to 130. There is then room to improve further.

Comparator node are from the litterature:

![comparator_diagram](https://github.com/user-attachments/assets/78ebcdbd-a864-4779-ac0b-97554d98b30c)

For the Batcher's network, to its latest optimization, it can be represented as:

![batcher_sorter_network_diagram](https://github.com/user-attachments/assets/0fe25622-1e74-40d1-888a-53c8dcf449c6)

## Edge & pepper cross Mask (Defect estimator}
Subtractions and some comparators areused to find the absolute maximum and the absolute minimum in the tested cross. The output is two `control` signals used just after. They are `CWM` signal and `Choice` signal. The last one is used to tell if the mask will be filtered by Gaussian way or CWM way. The `CWM` signal gives the information of the presence or not of a line of pixel. Because this operation is very small, it was directly coded in the `control` module.

## Logic control
It consists of use the two control signals come from the defect estimator computer earlier and the sorted array from the batcher module.
Detail estimator is computed with the algorithm provided ealier. `out_control` signal will record which filter is chosen. This logic control being very small, it is coded directly into the control module. 

`out_control` is define as:
```
00b : CWM filter.
01b : Gauss3x3 filter.
10b : Gauss5x5 filter.
111b: NOP filter.
```

## Indice Min/Max Index finder

Indices modules are composed by 4 times of the same module. The 5x5 block, and the sorted array are used as inputs alongside with the desired ordered element index. it will output the Index of this element in the 5x5 block.

THe first step consist to replace every element of the 5x5 block by binary zero excepted those ones wantedd by the user in the sorted array. This number takes the binarye value of `1`.

Second step is to identify the address of highest `1`.  The Binary array is casted into a decimal number. This number is then compared to find a proportional interval (with a LUT). Thsi interval return then its corresponding index.


Example if the number desired is 153 in a small test array:
```
|---|---|---|---|
| 23|153|208| 89|
|---|---|---|---|
| 0 | 1 | 0 | 0 |
|---|---|---|---|
```
Give the number 0100b casted to integer as 4. The LUT give for this number the value 3. The index of the element that we want is 3.

This functions is used to replace the extremum values of the 5x5 block, but also find the middle element of the sorted array to insert it 14 times in the CWM filter.

## CWM filter

The CWM filter takes the sorted array and the 5x5 block. The central pixel of the 5x5 block is found in the ordered row with the help of the Indice Min/Max Index finder algorithm. A smart LUT will then introduce 14 times the central value into the sorted row at the identified position (in a 39 elements array).

The output is then the median pixel, at index 20. the output processed pixel will need to be pipelined 3 times to sync with others filters' output.

## Gaussian Filters

The first step swaps the 2 second extremum Min/Max values with the help of the indices index computes from `control` module. This new Mask is then filtered.

It is then simple convolution: we multiply each pixel by its own Gauss coefficient, add each of these values and divide by the sum of yjr coefficients. 

Each coefficient will be decomposed into a sum of power-of-two and pixels's values to processed independently by corresponding shift-left. 
these temporary values are then casted in interger and added two-by-two using a “tree-adder” topology to optimize timing.

Fianally, the division is done by shift-right the final addition value that had been casted back to fixed point binary number.

This method introduce an error of +/-1 on pixel valuee, which is acceptable in our case.

- The 3x3 Gauss filter critical path is 4-adders cascaded. It does not need pipeline. the output processed pixel will need to be pipelined 3 times to sync with others filters output.
- The 5x5 Gauss filter being much more deep in computation, it needs to be internally pipelined twice, to keep the 4-adders cascaded max as critical path within needed timing.

## NOP filter

Nothing is done here, and the middle 5x5 block pixel is outputed directly. The output Pixel will need to be pipelined 3 times to sync with others filters output.

## Final Multiplexor

Final multiplexor select the correct filtered pixel. The select signal comes from the control module.

# Simulation

[FPGA](https://github.com/OlivierHK/FPGA_IP_RealTime_Adaptive_Video_Denoising_Filter/tree/main/FPGA) folder contains a testbench file (`TB_test.vhd`) for post-Place and post-PAR simulation. It has a steam test vector that will test all types of filters. 

Behaviorial simulation may not be accurate on ModelSim/ActiveHDL, as it doesn't simulate propagation delay of the logic. 

Testbench results are compared against `Spreadsheet_Tester.odt` for correctness and found similar.

![Sim_result](https://github.com/user-attachments/assets/0e369650-aebf-4aa2-bee4-6442fe078ba5)

The Xilinx vivado integrated simulator had been use for simulation.

# Implementation and result

## Project/Netlist generation and implementation
to generate and implement the project as an IP of an OOC design:
1. Open Vivado GUI and create a new project.
2. import all the .vhd file, and the .xdc file.
3. Symth the design ( with performance optimized directive), then PAR with default directive.
4. From here, can use the module as an OOC and save it as routed .dcp file, or use vivado IP generator to transorm it into an exportable blackbox netlist module.

For implementing the design in an existing video flow design, a FSM will need to be coded for storing 5 lines of each image, and handlings image edges and line return. 

- 2008 original design had been implemented for a virtexII at 105MHz. It was using 2,096 ff, and 5,142 4-LUTs for a total of 70,098 of total equivalent gates.
- 2025 optimized design had been implemented for a Virtex Ultrascale+ (XCVU9P), and could close timing at 100MHz. as ressource usage:
```
+----------------------------+------+-------+------------+-----------+-------+
|          Site Type         | Used | Fixed | Prohibited | Available | Util% |
+----------------------------+------+-------+------------+-----------+-------+
| CLB LUTs*                  | 4745 |     0 |          0 |   1182240 |  0.40 |
|   LUT as Logic             | 4543 |     0 |          0 |   1182240 |  0.38 |
|   LUT as Memory            |  202 |     0 |          0 |    591840 |  0.03 |
|     LUT as Distributed RAM |    0 |     0 |            |           |       |
|     LUT as Shift Register  |  202 |     0 |            |           |       |
| CLB Registers              | 2211 |     0 |          0 |   2364480 |  0.09 |
|   Register as Flip Flop    | 2211 |     0 |          0 |   2364480 |  0.09 |
|   Register as Latch        |    0 |     0 |          0 |   2364480 |  0.00 |
| CARRY8                     |  180 |     0 |          0 |    147780 |  0.12 |
| F7 Muxes                   |    8 |     0 |          0 |    591120 | <0.01 |
| F8 Muxes                   |    0 |     0 |          0 |    295560 |  0.00 |
| F9 Muxes                   |    0 |     0 |          0 |    147780 |  0.00 |
+----------------------------+------+-------+------------+-----------+-------+
```

## Real-life test

The project had been implemented into a Virtex-II and run at 80MHz to display fixed image (Lena), and short videos samples on Luminance channel (Y) only.

The whole filter IP had been wrapped into a higher level design including image control FSM and monitor driver following a similar design:

![real_life_test_diagram](https://github.com/user-attachments/assets/8248ce98-cf58-457e-a29b-9f88ea183b81)

Result shown on monitor proved the effectivness of the filter on real application:

![real_test_Lena](https://github.com/user-attachments/assets/25743933-8e19-43e7-af88-8b06dc33a61f)

  
# Further development

Further steps can be done to improve filter flexibility without increase fignificantly improve ressource usage:

- Add a control port connected to DP-RAM that could help to:
  - Make T1, T2, T3 and T4 threshold value variable, to change the adaptive behavior of the filter.
  - Make the CWM central weight variable, to change strength of the CWM filter.
  - optionnally, make the Gauss coefficients variable to adjust the smoothing effect. This change may impacts timing, and may requires change in design to call DSP cells instead, as multiplication and division will not be fixed anymore.
- Make extremum swaping smarter by reordering priority ordering. actual design is just replacing the pixel with higher index in the 5x5 block.
- Optimize the Batcher's sorter with the latest algorithm improvement to save some ressources.
- remove all integers casting in the design to make cleaner code.
- Add Filter for image's edges. It has been implemented in the MATLAB code, but not in the FPGA design (average 3x1 and average 1x3).
