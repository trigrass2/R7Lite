////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: dds.v
// /___/   /\     Timestamp: Sun Jun 22 20:33:07 2014
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog E:/k7_pcie/trunk/ise/xd_daq_pcie2x4main/ipcore_dir/tmp/_cg/dds.ngc E:/k7_pcie/trunk/ise/xd_daq_pcie2x4main/ipcore_dir/tmp/_cg/dds.v 
// Device	: 7k160tffg676-2
// Input file	: E:/k7_pcie/trunk/ise/xd_daq_pcie2x4main/ipcore_dir/tmp/_cg/dds.ngc
// Output file	: E:/k7_pcie/trunk/ise/xd_daq_pcie2x4main/ipcore_dir/tmp/_cg/dds.v
// # of Modules	: 1
// Design Name	: dds
// Xilinx        : G:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module dds (
  clk, we, data, cosine, sine
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input we;
  input [11 : 0] data;
  output [15 : 0] cosine;
  output [15 : 0] sine;
  
  // synthesis translate_off
  
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
  wire sig00000007;
  wire sig00000008;
  wire sig00000009;
  wire sig0000000a;
  wire sig0000000b;
  wire sig0000000c;
  wire sig0000000d;
  wire sig0000000e;
  wire sig0000000f;
  wire sig00000010;
  wire sig00000011;
  wire sig00000012;
  wire sig00000013;
  wire sig00000014;
  wire sig00000015;
  wire sig00000016;
  wire sig00000017;
  wire sig00000018;
  wire sig00000019;
  wire sig0000001a;
  wire sig0000001b;
  wire sig0000001c;
  wire sig0000001d;
  wire sig0000001e;
  wire sig0000001f;
  wire sig00000020;
  wire sig00000021;
  wire sig00000022;
  wire sig00000023;
  wire sig00000024;
  wire sig00000025;
  wire sig00000026;
  wire sig00000027;
  wire sig00000028;
  wire sig00000029;
  wire sig0000002a;
  wire sig0000002b;
  wire sig0000002c;
  wire sig0000002d;
  wire sig0000002e;
  wire sig0000002f;
  wire sig00000030;
  wire sig00000031;
  wire sig00000032;
  wire sig00000033;
  wire sig00000034;
  wire sig00000035;
  wire sig00000036;
  wire sig00000037;
  wire sig00000038;
  wire sig00000039;
  wire sig0000003a;
  wire sig0000003b;
  wire sig0000003c;
  wire sig0000003d;
  wire sig0000003e;
  wire sig0000003f;
  wire sig00000040;
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  wire sig00000049;
  wire sig0000004a;
  wire sig0000004b;
  wire sig0000004c;
  wire sig0000004d;
  wire sig0000004e;
  wire sig0000004f;
  wire sig00000050;
  wire sig00000051;
  wire sig00000052;
  wire sig00000053;
  wire sig00000054;
  wire sig00000055;
  wire sig00000056;
  wire sig00000057;
  wire sig00000058;
  wire sig00000059;
  wire sig0000005a;
  wire sig0000005b;
  wire sig0000005c;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
  wire sig00000065;
  wire sig00000066;
  wire sig00000067;
  wire sig00000068;
  wire sig00000069;
  wire sig0000006a;
  wire sig0000006b;
  wire sig0000006c;
  wire sig0000006d;
  wire sig0000006e;
  wire sig0000006f;
  wire sig00000070;
  wire sig00000071;
  wire sig00000072;
  wire sig00000073;
  wire sig00000074;
  wire sig00000075;
  wire sig00000076;
  wire sig00000077;
  wire sig00000078;
  wire sig00000079;
  wire sig0000007a;
  wire sig0000007b;
  wire sig0000007c;
  wire sig0000007d;
  wire sig0000007e;
  wire sig0000007f;
  wire sig00000080;
  wire sig00000081;
  wire sig00000082;
  wire sig00000083;
  wire sig00000084;
  wire sig00000085;
  wire sig00000086;
  wire sig00000087;
  wire sig00000088;
  wire sig00000089;
  wire sig0000008a;
  wire sig0000008b;
  wire sig0000008c;
  wire sig0000008d;
  wire sig0000008e;
  wire sig0000008f;
  wire sig00000090;
  wire sig00000091;
  wire sig00000092;
  wire sig00000093;
  wire sig00000094;
  wire sig00000095;
  wire sig00000096;
  wire sig00000097;
  wire sig00000098;
  wire sig00000099;
  wire sig0000009a;
  wire sig0000009b;
  wire sig0000009c;
  wire sig0000009d;
  wire sig0000009e;
  wire sig0000009f;
  wire sig000000a0;
  wire sig000000a1;
  wire sig000000a2;
  wire sig000000a3;
  wire sig000000a4;
  wire sig000000a5;
  wire sig000000a6;
  wire sig000000a7;
  wire sig000000a8;
  wire sig000000a9;
  wire sig000000aa;
  wire sig000000ab;
  wire sig000000ac;
  wire sig000000ad;
  wire sig000000ae;
  wire sig000000af;
  wire sig000000b0;
  wire sig000000b1;
  wire sig000000b2;
  wire sig000000b3;
  wire sig000000b4;
  wire sig000000b5;
  wire sig000000b6;
  wire sig000000b7;
  wire sig000000b8;
  wire sig000000b9;
  wire sig000000ba;
  wire sig000000bb;
  wire sig000000bc;
  wire sig000000bd;
  wire sig000000be;
  wire sig000000bf;
  wire sig000000c0;
  wire sig000000c1;
  wire sig000000c2;
  wire sig000000c3;
  wire sig000000c4;
  wire sig000000c5;
  wire sig000000c6;
  wire sig000000c7;
  wire sig000000c8;
  wire sig000000c9;
  wire sig000000ca;
  wire sig000000cb;
  wire sig000000cc;
  wire sig000000cd;
  wire sig000000ce;
  wire sig000000cf;
  wire sig000000d0;
  wire sig000000d1;
  wire sig000000d2;
  wire sig000000d3;
  wire sig000000d4;
  wire sig000000d5;
  wire sig000000d6;
  wire sig000000d7;
  wire sig000000d8;
  wire sig000000d9;
  wire sig000000da;
  wire sig000000db;
  wire sig000000dc;
  wire sig000000dd;
  wire sig000000de;
  wire sig000000df;
  wire sig000000e0;
  wire sig000000e1;
  wire sig000000e2;
  wire sig000000e3;
  wire sig000000e4;
  wire sig000000e5;
  wire sig000000e6;
  wire sig000000e7;
  wire sig000000e8;
  wire sig000000e9;
  wire sig000000ea;
  wire sig000000eb;
  wire sig000000ec;
  wire sig000000ed;
  wire \blk0000001c/sig00000129 ;
  wire \blk0000001c/sig00000128 ;
  wire \blk0000001c/sig00000127 ;
  wire \blk0000001c/sig00000126 ;
  wire \blk0000001c/sig00000125 ;
  wire \blk0000001c/sig00000124 ;
  wire \blk0000001c/sig00000123 ;
  wire \blk0000001c/sig00000122 ;
  wire \blk0000001c/sig00000121 ;
  wire \blk0000001c/sig00000120 ;
  wire \blk0000001c/sig0000011f ;
  wire \blk0000001c/sig0000011e ;
  wire \blk0000001c/sig0000011d ;
  wire \blk0000001c/sig0000011c ;
  wire \blk0000001c/sig0000011b ;
  wire \blk0000001c/sig0000011a ;
  wire \blk0000001c/sig00000119 ;
  wire \blk0000001c/sig00000118 ;
  wire \blk0000001c/sig00000117 ;
  wire \blk0000001c/sig00000116 ;
  wire \blk0000001c/sig00000115 ;
  wire \blk0000001c/sig00000114 ;
  wire \blk0000001c/sig00000113 ;
  wire \blk0000001c/sig00000112 ;
  wire \NLW_blk000000d5_DIBDI<15>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<14>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<13>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<12>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<11>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<10>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<9>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<8>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<7>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<6>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<5>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<4>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<3>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<2>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<1>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIBDI<0>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIPBDIP<1>_UNCONNECTED ;
  wire \NLW_blk000000d5_DIPBDIP<0>_UNCONNECTED ;
  wire \NLW_blk000000d5_DOPADOP<1>_UNCONNECTED ;
  wire \NLW_blk000000d5_DOPADOP<0>_UNCONNECTED ;
  wire \NLW_blk000000d5_DOPBDOP<1>_UNCONNECTED ;
  wire \NLW_blk000000d5_DOPBDOP<0>_UNCONNECTED ;
  wire NLW_blk000000d6_PATTERNBDETECT_UNCONNECTED;
  wire NLW_blk000000d6_MULTSIGNOUT_UNCONNECTED;
  wire NLW_blk000000d6_CARRYCASCOUT_UNCONNECTED;
  wire NLW_blk000000d6_UNDERFLOW_UNCONNECTED;
  wire NLW_blk000000d6_PATTERNDETECT_UNCONNECTED;
  wire NLW_blk000000d6_OVERFLOW_UNCONNECTED;
  wire \NLW_blk000000d6_ACOUT<29>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<28>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<27>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<26>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<25>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<24>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<23>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<22>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<21>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<20>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<19>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<18>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d6_ACOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d6_CARRYOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d6_CARRYOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d6_CARRYOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d6_CARRYOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d6_BCOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<47>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<46>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<45>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<44>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<43>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<42>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<25>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<24>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<23>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<22>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<21>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<20>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<19>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<18>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<17>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<16>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<15>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<14>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<13>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<12>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<11>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<10>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<9>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<8>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<7>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<6>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<5>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<4>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<3>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<2>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<1>_UNCONNECTED ;
  wire \NLW_blk000000d6_P<0>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<47>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<46>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<45>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<44>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<43>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<42>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<41>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<40>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<39>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<38>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<37>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<36>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<35>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<34>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<33>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<32>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<31>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<30>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<29>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<28>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<27>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<26>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<25>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<24>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<23>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<22>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<21>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<20>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<19>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<18>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d6_PCOUT<0>_UNCONNECTED ;
  wire NLW_blk000000d7_PATTERNBDETECT_UNCONNECTED;
  wire NLW_blk000000d7_MULTSIGNOUT_UNCONNECTED;
  wire NLW_blk000000d7_CARRYCASCOUT_UNCONNECTED;
  wire NLW_blk000000d7_UNDERFLOW_UNCONNECTED;
  wire NLW_blk000000d7_PATTERNDETECT_UNCONNECTED;
  wire NLW_blk000000d7_OVERFLOW_UNCONNECTED;
  wire \NLW_blk000000d7_ACOUT<29>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<28>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<27>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<26>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<25>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<24>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<23>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<22>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<21>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<20>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<19>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<18>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d7_ACOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d7_CARRYOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d7_CARRYOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d7_CARRYOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d7_CARRYOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d7_BCOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<47>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<46>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<45>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<44>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<43>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<42>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<25>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<24>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<23>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<22>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<21>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<20>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<19>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<18>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<17>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<16>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<15>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<14>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<13>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<12>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<11>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<10>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<9>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<8>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<7>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<6>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<5>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<4>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<3>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<2>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<1>_UNCONNECTED ;
  wire \NLW_blk000000d7_P<0>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<47>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<46>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<45>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<44>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<43>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<42>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<41>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<40>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<39>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<38>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<37>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<36>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<35>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<34>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<33>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<32>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<31>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<30>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<29>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<28>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<27>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<26>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<25>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<24>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<23>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<22>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<21>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<20>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<19>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<18>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d7_PCOUT<0>_UNCONNECTED ;
  wire NLW_blk000000d8_PATTERNBDETECT_UNCONNECTED;
  wire NLW_blk000000d8_MULTSIGNOUT_UNCONNECTED;
  wire NLW_blk000000d8_CARRYCASCOUT_UNCONNECTED;
  wire NLW_blk000000d8_UNDERFLOW_UNCONNECTED;
  wire NLW_blk000000d8_PATTERNDETECT_UNCONNECTED;
  wire NLW_blk000000d8_OVERFLOW_UNCONNECTED;
  wire \NLW_blk000000d8_ACOUT<29>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<28>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<27>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<26>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<25>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<24>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<23>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<22>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<21>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<20>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<19>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<18>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d8_ACOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d8_CARRYOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d8_CARRYOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d8_CARRYOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d8_CARRYOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d8_BCOUT<0>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<47>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<46>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<45>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<44>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<43>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<42>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<41>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<40>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<39>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<38>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<37>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<36>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<17>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<16>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<15>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<14>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<13>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<12>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<11>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<10>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<9>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<8>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<7>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<6>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<5>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<4>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<3>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<2>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<1>_UNCONNECTED ;
  wire \NLW_blk000000d8_P<0>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<47>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<46>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<45>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<44>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<43>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<42>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<41>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<40>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<39>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<38>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<37>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<36>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<35>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<34>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<33>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<32>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<31>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<30>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<29>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<28>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<27>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<26>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<25>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<24>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<23>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<22>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<21>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<20>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<19>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<18>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<17>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<16>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<15>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<14>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<13>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<12>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<11>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<10>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<9>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<8>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<7>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<6>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<5>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<4>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<3>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<2>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<1>_UNCONNECTED ;
  wire \NLW_blk000000d8_PCOUT<0>_UNCONNECTED ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(sig00000059)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .CE(we),
    .D(data[11]),
    .Q(sig00000002)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .CE(we),
    .D(data[10]),
    .Q(sig00000003)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000005 (
    .C(clk),
    .CE(we),
    .D(data[9]),
    .Q(sig00000004)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .CE(we),
    .D(data[8]),
    .Q(sig00000005)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000007 (
    .C(clk),
    .CE(we),
    .D(data[7]),
    .Q(sig00000006)
  );
  FDE #(
    .INIT ( 1'b1 ))
  blk00000008 (
    .C(clk),
    .CE(we),
    .D(data[6]),
    .Q(sig00000007)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .CE(we),
    .D(data[5]),
    .Q(sig00000008)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .CE(we),
    .D(data[4]),
    .Q(sig00000009)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000b (
    .C(clk),
    .CE(we),
    .D(data[3]),
    .Q(sig0000000a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000c (
    .C(clk),
    .CE(we),
    .D(data[2]),
    .Q(sig0000000b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .CE(we),
    .D(data[1]),
    .Q(sig0000000c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000e (
    .C(clk),
    .CE(we),
    .D(data[0]),
    .Q(sig0000000d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000f (
    .C(clk),
    .D(sig0000000e),
    .Q(sig0000008e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000010 (
    .C(clk),
    .D(sig0000000f),
    .Q(sig00000046)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000011 (
    .C(clk),
    .D(sig00000010),
    .Q(sig00000045)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000012 (
    .C(clk),
    .D(sig00000011),
    .Q(sig00000044)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000013 (
    .C(clk),
    .D(sig00000012),
    .Q(sig00000043)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000014 (
    .C(clk),
    .D(sig00000013),
    .Q(sig00000042)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000015 (
    .C(clk),
    .D(sig00000014),
    .Q(sig00000041)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000016 (
    .C(clk),
    .D(sig00000015),
    .Q(sig00000040)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000017 (
    .C(clk),
    .D(sig00000016),
    .Q(sig0000003f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000018 (
    .C(clk),
    .D(sig00000017),
    .Q(sig0000003e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000019 (
    .C(clk),
    .D(sig00000018),
    .Q(sig0000003d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001a (
    .C(clk),
    .D(sig00000019),
    .Q(sig0000003c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001b (
    .C(clk),
    .D(sig0000001a),
    .Q(sig0000003b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000042 (
    .C(clk),
    .D(sig0000008f),
    .Q(sig000000cb)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000043 (
    .C(clk),
    .D(sig000000a1),
    .Q(sig000000ca)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .D(sig000000a0),
    .Q(sig000000c9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .D(sig0000009f),
    .Q(sig000000c8)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .D(sig0000009e),
    .Q(sig000000c7)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .D(sig0000009d),
    .Q(sig000000c6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .D(sig0000009c),
    .Q(sig000000c5)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .D(sig0000009b),
    .Q(sig000000c4)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .D(sig0000009a),
    .Q(sig000000c3)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .D(sig00000099),
    .Q(sig000000c2)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .D(sig00000046),
    .Q(sig000000d5)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .D(sig00000098),
    .Q(sig000000d4)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004e (
    .C(clk),
    .D(sig00000097),
    .Q(sig000000d3)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004f (
    .C(clk),
    .D(sig00000096),
    .Q(sig000000d2)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000050 (
    .C(clk),
    .D(sig00000095),
    .Q(sig000000d1)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000051 (
    .C(clk),
    .D(sig00000094),
    .Q(sig000000d0)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000052 (
    .C(clk),
    .D(sig00000093),
    .Q(sig000000cf)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000053 (
    .C(clk),
    .D(sig00000092),
    .Q(sig000000ce)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000054 (
    .C(clk),
    .D(sig00000091),
    .Q(sig000000cd)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000055 (
    .C(clk),
    .D(sig00000090),
    .Q(sig000000cc)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000056 (
    .C(clk),
    .D(sig000000b1),
    .Q(sig0000002a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000057 (
    .C(clk),
    .D(sig000000b0),
    .Q(sig00000029)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000058 (
    .C(clk),
    .D(sig000000af),
    .Q(sig00000028)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .D(sig000000ae),
    .Q(sig00000027)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .D(sig000000ad),
    .Q(sig00000026)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005b (
    .C(clk),
    .D(sig000000ac),
    .Q(sig00000025)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005c (
    .C(clk),
    .D(sig000000ab),
    .Q(sig00000024)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005d (
    .C(clk),
    .D(sig000000aa),
    .Q(sig00000023)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005e (
    .C(clk),
    .D(sig000000a9),
    .Q(sig00000022)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000005f (
    .C(clk),
    .D(sig000000a8),
    .Q(sig00000021)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000060 (
    .C(clk),
    .D(sig000000a7),
    .Q(sig00000020)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000061 (
    .C(clk),
    .D(sig000000a6),
    .Q(sig0000001f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000062 (
    .C(clk),
    .D(sig000000a5),
    .Q(sig0000001e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000063 (
    .C(clk),
    .D(sig000000a4),
    .Q(sig0000001d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000064 (
    .C(clk),
    .D(sig000000a3),
    .Q(sig0000001c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000065 (
    .C(clk),
    .D(sig000000a2),
    .Q(sig0000001b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000066 (
    .C(clk),
    .D(sig000000c1),
    .Q(sig0000003a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000067 (
    .C(clk),
    .D(sig000000c0),
    .Q(sig00000039)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000068 (
    .C(clk),
    .D(sig000000bf),
    .Q(sig00000038)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000069 (
    .C(clk),
    .D(sig000000be),
    .Q(sig00000037)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006a (
    .C(clk),
    .D(sig000000bd),
    .Q(sig00000036)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .D(sig000000bc),
    .Q(sig00000035)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006c (
    .C(clk),
    .D(sig000000bb),
    .Q(sig00000034)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006d (
    .C(clk),
    .D(sig000000ba),
    .Q(sig00000033)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006e (
    .C(clk),
    .D(sig000000b9),
    .Q(sig00000032)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000006f (
    .C(clk),
    .D(sig000000b8),
    .Q(sig00000031)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000070 (
    .C(clk),
    .D(sig000000b7),
    .Q(sig00000030)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000071 (
    .C(clk),
    .D(sig000000b6),
    .Q(sig0000002f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000072 (
    .C(clk),
    .D(sig000000b5),
    .Q(sig0000002e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000073 (
    .C(clk),
    .D(sig000000b4),
    .Q(sig0000002d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000074 (
    .C(clk),
    .D(sig000000b3),
    .Q(sig0000002c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000075 (
    .C(clk),
    .D(sig000000b2),
    .Q(sig0000002b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000076 (
    .C(clk),
    .D(sig0000002a),
    .Q(sig0000006a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000077 (
    .C(clk),
    .D(sig00000029),
    .Q(sig00000069)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000078 (
    .C(clk),
    .D(sig00000028),
    .Q(sig00000068)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000079 (
    .C(clk),
    .D(sig00000027),
    .Q(sig00000067)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007a (
    .C(clk),
    .D(sig00000026),
    .Q(sig00000066)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007b (
    .C(clk),
    .D(sig00000025),
    .Q(sig00000065)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007c (
    .C(clk),
    .D(sig00000024),
    .Q(sig00000064)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007d (
    .C(clk),
    .D(sig00000023),
    .Q(sig00000063)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007e (
    .C(clk),
    .D(sig00000022),
    .Q(sig00000062)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000007f (
    .C(clk),
    .D(sig00000021),
    .Q(sig00000061)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000080 (
    .C(clk),
    .D(sig00000020),
    .Q(sig00000060)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000081 (
    .C(clk),
    .D(sig0000001f),
    .Q(sig0000005f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000082 (
    .C(clk),
    .D(sig0000001e),
    .Q(sig0000005e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000083 (
    .C(clk),
    .D(sig0000001d),
    .Q(sig0000005d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000084 (
    .C(clk),
    .D(sig0000001c),
    .Q(sig0000005c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000085 (
    .C(clk),
    .D(sig0000001b),
    .Q(sig0000005b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000086 (
    .C(clk),
    .D(sig00000001),
    .Q(sig0000005a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000087 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e1)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000088 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e0)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000089 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000df)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000008a (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000de)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000008b (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000dd)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000008c (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000dc)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000008d (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000db)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000008e (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000da)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000008f (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000d9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000090 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000d8)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000091 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000d7)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000092 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000d6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000093 (
    .C(clk),
    .D(sig0000003a),
    .Q(sig0000007b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000094 (
    .C(clk),
    .D(sig00000039),
    .Q(sig0000007a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000095 (
    .C(clk),
    .D(sig00000038),
    .Q(sig00000079)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000096 (
    .C(clk),
    .D(sig00000037),
    .Q(sig00000078)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000097 (
    .C(clk),
    .D(sig00000036),
    .Q(sig00000077)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000098 (
    .C(clk),
    .D(sig00000035),
    .Q(sig00000076)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000099 (
    .C(clk),
    .D(sig00000034),
    .Q(sig00000075)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009a (
    .C(clk),
    .D(sig00000033),
    .Q(sig00000074)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009b (
    .C(clk),
    .D(sig00000032),
    .Q(sig00000073)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009c (
    .C(clk),
    .D(sig00000031),
    .Q(sig00000072)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .D(sig00000030),
    .Q(sig00000071)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009e (
    .C(clk),
    .D(sig0000002f),
    .Q(sig00000070)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009f (
    .C(clk),
    .D(sig0000002e),
    .Q(sig0000006f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a0 (
    .C(clk),
    .D(sig0000002d),
    .Q(sig0000006e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a1 (
    .C(clk),
    .D(sig0000002c),
    .Q(sig0000006d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a2 (
    .C(clk),
    .D(sig0000002b),
    .Q(sig0000006c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a3 (
    .C(clk),
    .D(sig00000001),
    .Q(sig0000006b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a4 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000ed)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a5 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000ec)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a6 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000eb)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a7 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000ea)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a8 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a9 (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e8)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000aa (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e7)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ab (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ac (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e5)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ad (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e4)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ae (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e3)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000af (
    .C(clk),
    .D(sig00000059),
    .Q(sig000000e2)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b0 (
    .C(clk),
    .D(sig0000008d),
    .Q(sig00000058)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b1 (
    .C(clk),
    .D(sig0000008c),
    .Q(sig00000057)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b2 (
    .C(clk),
    .D(sig0000008b),
    .Q(sig00000056)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b3 (
    .C(clk),
    .D(sig0000008a),
    .Q(sig00000055)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b4 (
    .C(clk),
    .D(sig00000089),
    .Q(sig00000054)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b5 (
    .C(clk),
    .D(sig00000088),
    .Q(sig00000053)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b6 (
    .C(clk),
    .D(sig00000087),
    .Q(sig00000052)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b7 (
    .C(clk),
    .D(sig00000086),
    .Q(sig00000051)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b8 (
    .C(clk),
    .D(sig00000085),
    .Q(sig00000050)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000b9 (
    .C(clk),
    .D(sig00000084),
    .Q(sig0000004f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000ba (
    .C(clk),
    .D(sig00000083),
    .Q(sig0000004e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bb (
    .C(clk),
    .D(sig00000082),
    .Q(sig0000004d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bc (
    .C(clk),
    .D(sig00000081),
    .Q(sig0000004c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bd (
    .C(clk),
    .D(sig00000080),
    .Q(sig0000004b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000be (
    .C(clk),
    .D(sig0000007f),
    .Q(sig0000004a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000bf (
    .C(clk),
    .D(sig0000007e),
    .Q(sig00000049)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c0 (
    .C(clk),
    .D(sig0000007d),
    .Q(sig00000048)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000c1 (
    .C(clk),
    .D(sig0000007c),
    .Q(sig00000047)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000c2 (
    .I0(sig0000003c),
    .I1(sig00000045),
    .O(sig00000099)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000c3 (
    .I0(sig0000003c),
    .I1(sig00000045),
    .O(sig00000090)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000c4 (
    .I0(sig0000003e),
    .I1(sig00000045),
    .O(sig0000009b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000c5 (
    .I0(sig0000003e),
    .I1(sig00000045),
    .O(sig00000092)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000c6 (
    .I0(sig0000003f),
    .I1(sig00000045),
    .O(sig0000009c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000c7 (
    .I0(sig0000003f),
    .I1(sig00000045),
    .O(sig00000093)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000c8 (
    .I0(sig0000003d),
    .I1(sig00000045),
    .O(sig0000009a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000c9 (
    .I0(sig0000003d),
    .I1(sig00000045),
    .O(sig00000091)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000ca (
    .I0(sig00000041),
    .I1(sig00000045),
    .O(sig0000009e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000cb (
    .I0(sig00000041),
    .I1(sig00000045),
    .O(sig00000095)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000cc (
    .I0(sig00000042),
    .I1(sig00000045),
    .O(sig0000009f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000cd (
    .I0(sig00000042),
    .I1(sig00000045),
    .O(sig00000096)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000ce (
    .I0(sig00000040),
    .I1(sig00000045),
    .O(sig0000009d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000cf (
    .I0(sig00000040),
    .I1(sig00000045),
    .O(sig00000094)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000d0 (
    .I0(sig00000044),
    .I1(sig00000045),
    .O(sig000000a1)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000d1 (
    .I0(sig00000044),
    .I1(sig00000045),
    .O(sig00000098)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000d2 (
    .I0(sig00000043),
    .I1(sig00000045),
    .O(sig000000a0)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000d3 (
    .I0(sig00000043),
    .I1(sig00000045),
    .O(sig00000097)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000d4 (
    .I0(sig00000046),
    .I1(sig00000045),
    .O(sig0000008f)
  );
  RAMB18E1 #(
    .INIT_00 ( 256'h061605B1054D04E80484041F03BB035602F2028D022901C4016000FB00970032 ),
    .INIT_01 ( 256'h0C5A0BF60B910B2D0AC90A650A01099D093808D40870080B07A7074306DE067A ),
    .INIT_02 ( 256'h1296123311CF116B110810A410410FDD0F790F150EB10E4D0DEA0D860D220CBE ),
    .INIT_03 ( 256'h18C718641802179F173C16D91676161315B0154D14EA1487142413C0135D12F9 ),
    .INIT_04 ( 256'h1EE91E871E251DC41D621D001C9E1C3C1BDA1B781B161AB31A5119EF198C192A ),
    .INIT_05 ( 256'h24F72497243723D62376231522B4225421F32192213120D0206E200D1FAC1F4A ),
    .INIT_06 ( 256'h2AEF2A902A3229D32974291428B5285627F62797273726D72678261825B82558 ),
    .INIT_07 ( 256'h30CD307030122FB52F582EFA2E9D2E3F2DE12D842D252CC72C692C0B2BAC2B4E ),
    .INIT_08 ( 256'h368C363135D6357A351F34C33468340C33B0335432F8329C323F31E331863129 ),
    .INIT_09 ( 256'h3C293BD13B783B1F3AC53A6C3A1239B9395F390538AB385137F7379C374136E7 ),
    .INIT_0A ( 256'h41A2414C40F5409E40473FF03F993F423EEB3E933E3B3DE33D8B3D333CDB3C82 ),
    .INIT_0B ( 256'h46F2469E464A45F645A2454E44F944A4444F43FA43A5434F42FA42A4424E41F8 ),
    .INIT_0C ( 256'h4C164BC54B744B234AD14A804A2E49DC498A493748E54892483F47EC47994746 ),
    .INIT_0D ( 256'h510C50BE507050214FD34F844F354EE64E974E484DF84DA84D584D084CB84C67 ),
    .INIT_0E ( 256'h55CF5584553954EE54A35458540C53C05374532752DB528E524151F451A75159 ),
    .INIT_0F ( 256'h5A5D5A1659CF5987593F58F758AE5866581D57D4578B574156F856AE5664561A ),
    .INIT_10 ( 256'h5EB45E705E2D5DE85DA45D5F5D1A5CD55C905C4A5C055BBF5B785B325AEB5AA5 ),
    .INIT_11 ( 256'h62D162916250621061CF618E614D610B60CA6088604660035FC15F7E5F3B5EF8 ),
    .INIT_12 ( 256'h66B06674663765FB65BE65816543650664C8648A644C640D63CE638F63506310 ),
    .INIT_13 ( 256'h6A506A1869DF69A7696E693568FC68C26888684E681367D9679E6763672766EC ),
    .INIT_14 ( 256'h6DAE6D7B6D466D126CDD6CA86C736C3D6C086BD16B9B6B656B2E6AF76ABF6A88 ),
    .INIT_15 ( 256'h70C9709A706A703970096FD86FA76F766F446F136EE16EAE6E7C6E496E166DE2 ),
    .INIT_16 ( 256'h739F73737348731C72F072C47297726A723D720F71E271B371857157712870F9 ),
    .INIT_17 ( 256'h762D760675DF75B7759075687540751774EF74C6749C74737449741F73F473CA ),
    .INIT_18 ( 256'h7872784F782D780A77E777C477A0777C77587734770F76EA76C5769F76797653 ),
    .INIT_19 ( 256'h7A6C7A4F7A317A1379F579D679B77998797879597938791878F778D678B57894 ),
    .INIT_1A ( 256'h7C1C7C037BEA7BD17BB77B9D7B837B687B4E7B337B177AFB7ADF7AC37AA77A8A ),
    .INIT_1B ( 256'h7D7F7D6B7D567D427D2D7D187D037CED7CD77CC07CAA7C937C7C7C647C4C7C34 ),
    .INIT_1C ( 256'h7E947E857E767E667E567E467E357E247E137E017DF07DDE7DCB7DB87DA57D92 ),
    .INIT_1D ( 256'h7F5B7F517F477F3C7F317F257F1A7F0E7F017EF57EE87EDB7ECD7EBF7EB17EA3 ),
    .INIT_1E ( 256'h7FD47FCF7FC97FC37FBD7FB77FB07FA97FA17F9A7F927F897F817F787F6F7F65 ),
    .INIT_1F ( 256'h7FFE7FFE7FFD7FFC7FFB7FF97FF77FF57FF37FF07FED7FEA7FE67FE27FDE7FD9 ),
    .INIT_20 ( 256'hF9EAFA4FFAB3FB18FB7CFBE1FC45FCAAFD0EFD73FDD7FE3CFEA0FF05FF69FFCE ),
    .INIT_21 ( 256'hF3A6F40AF46FF4D3F537F59BF5FFF663F6C8F72CF790F7F5F859F8BDF922F986 ),
    .INIT_22 ( 256'hED6AEDCDEE31EE95EEF8EF5CEFBFF023F087F0EBF14FF1B3F216F27AF2DEF342 ),
    .INIT_23 ( 256'hE739E79CE7FEE861E8C4E927E98AE9EDEA50EAB3EB16EB79EBDCEC40ECA3ED07 ),
    .INIT_24 ( 256'hE117E179E1DBE23CE29EE300E362E3C4E426E488E4EAE54DE5AFE611E674E6D6 ),
    .INIT_25 ( 256'hDB09DB69DBC9DC2ADC8ADCEBDD4CDDACDE0DDE6EDECFDF30DF92DFF3E054E0B6 ),
    .INIT_26 ( 256'hD511D570D5CED62DD68CD6ECD74BD7AAD80AD869D8C9D929D988D9E8DA48DAA8 ),
    .INIT_27 ( 256'hCF33CF90CFEED04BD0A8D106D163D1C1D21FD27CD2DBD339D397D3F5D454D4B2 ),
    .INIT_28 ( 256'hC974C9CFCA2ACA86CAE1CB3DCB98CBF4CC50CCACCD08CD64CDC1CE1DCE7ACED7 ),
    .INIT_29 ( 256'hC3D7C42FC488C4E1C53BC594C5EEC647C6A1C6FBC755C7AFC809C864C8BFC919 ),
    .INIT_2A ( 256'hBE5EBEB4BF0BBF62BFB9C010C067C0BEC115C16DC1C5C21DC275C2CDC325C37E ),
    .INIT_2B ( 256'hB90EB962B9B6BA0ABA5EBAB2BB07BB5CBBB1BC06BC5BBCB1BD06BD5CBDB2BE08 ),
    .INIT_2C ( 256'hB3EAB43BB48CB4DDB52FB580B5D2B624B676B6C9B71BB76EB7C1B814B867B8BA ),
    .INIT_2D ( 256'hAEF4AF42AF90AFDFB02DB07CB0CBB11AB169B1B8B208B258B2A8B2F8B348B399 ),
    .INIT_2E ( 256'hAA31AA7CAAC7AB12AB5DABA8ABF4AC40AC8CACD9AD25AD72ADBFAE0CAE59AEA7 ),
    .INIT_2F ( 256'hA5A3A5EAA631A679A6C1A709A752A79AA7E3A82CA875A8BFA908A952A99CA9E6 ),
    .INIT_30 ( 256'hA14CA190A1D3A218A25CA2A1A2E6A32BA370A3B6A3FBA441A488A4CEA515A55B ),
    .INIT_31 ( 256'h9D2F9D6F9DB09DF09E319E729EB39EF59F369F789FBA9FFDA03FA082A0C5A108 ),
    .INIT_32 ( 256'h9950998C99C99A059A429A7F9ABD9AFA9B389B769BB49BF39C329C719CB09CF0 ),
    .INIT_33 ( 256'h95B095E896219659969296CB9704973E977897B297ED98279862989D98D99914 ),
    .INIT_34 ( 256'h9252928592BA92EE93239358938D93C393F8942F9465949B94D2950995419578 ),
    .INIT_35 ( 256'h8F378F668F968FC78FF790289059908A90BC90ED911F9152918491B791EA921E ),
    .INIT_36 ( 256'h8C618C8D8CB88CE48D108D3C8D698D968DC38DF18E1E8E4D8E7B8EA98ED88F07 ),
    .INIT_37 ( 256'h89D389FA8A218A498A708A988AC08AE98B118B3A8B648B8D8BB78BE18C0C8C36 ),
    .INIT_38 ( 256'h878E87B187D387F68819883C8860888488A888CC88F18916893B8961898789AD ),
    .INIT_39 ( 256'h859485B185CF85ED860B862A86498668868886A786C886E88709872A874B876C ),
    .INIT_3A ( 256'h83E483FD8416842F84498463847D849884B284CD84E985058521853D85598576 ),
    .INIT_3B ( 256'h8281829582AA82BE82D382E882FD8313832983408356836D8384839C83B483CC ),
    .INIT_3C ( 256'h816C817B818A819A81AA81BA81CB81DC81ED81FF8210822282358248825B826E ),
    .INIT_3D ( 256'h80A580AF80B980C480CF80DB80E680F280FF810B8118812581338141814F815D ),
    .INIT_3E ( 256'h802C80318037803D8043804980508057805F8066806E8077807F80888091809B ),
    .INIT_3F ( 256'h8002800280038004800580078009800B800D801080138016801A801E80228027 ),
    .INIT_A ( 18'h00000 ),
    .INIT_B ( 18'h00000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .DOA_REG ( 1 ),
    .DOB_REG ( 1 ),
    .READ_WIDTH_A ( 18 ),
    .READ_WIDTH_B ( 18 ),
    .WRITE_WIDTH_A ( 18 ),
    .WRITE_WIDTH_B ( 0 ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .RAM_MODE ( "TDP" ),
    .RDADDR_COLLISION_HWCONFIG ( "DELAYED_WRITE" ),
    .RSTREG_PRIORITY_A ( "RSTREG" ),
    .RSTREG_PRIORITY_B ( "RSTREG" ),
    .SRVAL_A ( 18'h00000 ),
    .SRVAL_B ( 18'h00000 ),
    .SIM_COLLISION_CHECK ( "ALL" ),
    .SIM_DEVICE ( "7SERIES" ),
    .INIT_FILE ( "NONE" ))
  blk000000d5 (
    .CLKARDCLK(clk),
    .CLKBWRCLK(clk),
    .ENARDEN(sig00000001),
    .ENBWREN(sig00000001),
    .REGCEAREGCE(sig00000001),
    .REGCEB(sig00000001),
    .RSTRAMARSTRAM(sig00000059),
    .RSTRAMB(sig00000059),
    .RSTREGARSTREG(sig00000059),
    .RSTREGB(sig00000059),
    .ADDRARDADDR({sig000000d5, sig000000d4, sig000000d3, sig000000d2, sig000000d1, sig000000d0, sig000000cf, sig000000ce, sig000000cd, sig000000cc, 
sig00000001, sig00000001, sig00000001, sig00000001}),
    .ADDRBWRADDR({sig000000cb, sig000000ca, sig000000c9, sig000000c8, sig000000c7, sig000000c6, sig000000c5, sig000000c4, sig000000c3, sig000000c2, 
sig00000001, sig00000001, sig00000001, sig00000001}),
    .DIADI({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .DIBDI({\NLW_blk000000d5_DIBDI<15>_UNCONNECTED , \NLW_blk000000d5_DIBDI<14>_UNCONNECTED , \NLW_blk000000d5_DIBDI<13>_UNCONNECTED , 
\NLW_blk000000d5_DIBDI<12>_UNCONNECTED , \NLW_blk000000d5_DIBDI<11>_UNCONNECTED , \NLW_blk000000d5_DIBDI<10>_UNCONNECTED , 
\NLW_blk000000d5_DIBDI<9>_UNCONNECTED , \NLW_blk000000d5_DIBDI<8>_UNCONNECTED , \NLW_blk000000d5_DIBDI<7>_UNCONNECTED , 
\NLW_blk000000d5_DIBDI<6>_UNCONNECTED , \NLW_blk000000d5_DIBDI<5>_UNCONNECTED , \NLW_blk000000d5_DIBDI<4>_UNCONNECTED , 
\NLW_blk000000d5_DIBDI<3>_UNCONNECTED , \NLW_blk000000d5_DIBDI<2>_UNCONNECTED , \NLW_blk000000d5_DIBDI<1>_UNCONNECTED , 
\NLW_blk000000d5_DIBDI<0>_UNCONNECTED }),
    .DIPADIP({sig00000059, sig00000059}),
    .DIPBDIP({\NLW_blk000000d5_DIPBDIP<1>_UNCONNECTED , \NLW_blk000000d5_DIPBDIP<0>_UNCONNECTED }),
    .DOADO({sig000000c1, sig000000c0, sig000000bf, sig000000be, sig000000bd, sig000000bc, sig000000bb, sig000000ba, sig000000b9, sig000000b8, 
sig000000b7, sig000000b6, sig000000b5, sig000000b4, sig000000b3, sig000000b2}),
    .DOBDO({sig000000b1, sig000000b0, sig000000af, sig000000ae, sig000000ad, sig000000ac, sig000000ab, sig000000aa, sig000000a9, sig000000a8, 
sig000000a7, sig000000a6, sig000000a5, sig000000a4, sig000000a3, sig000000a2}),
    .DOPADOP({\NLW_blk000000d5_DOPADOP<1>_UNCONNECTED , \NLW_blk000000d5_DOPADOP<0>_UNCONNECTED }),
    .DOPBDOP({\NLW_blk000000d5_DOPBDOP<1>_UNCONNECTED , \NLW_blk000000d5_DOPBDOP<0>_UNCONNECTED }),
    .WEA({sig00000059, sig00000059}),
    .WEBWE({sig00000059, sig00000059, sig00000059, sig00000059})
  );
  DSP48E #(
    .ACASCREG ( 1 ),
    .ALUMODEREG ( 1 ),
    .AREG ( 1 ),
    .AUTORESET_PATTERN_DETECT ( "FALSE" ),
    .AUTORESET_PATTERN_DETECT_OPTINV ( "MATCH" ),
    .A_INPUT ( "DIRECT" ),
    .BCASCREG ( 1 ),
    .BREG ( 1 ),
    .B_INPUT ( "DIRECT" ),
    .CARRYINREG ( 1 ),
    .CARRYINSELREG ( 0 ),
    .CREG ( 1 ),
    .MASK ( 48'h3FFFFFFFFFFF ),
    .MREG ( 1 ),
    .MULTCARRYINREG ( 0 ),
    .OPMODEREG ( 0 ),
    .PATTERN ( 48'h000000000000 ),
    .PREG ( 1 ),
    .SEL_MASK ( "MASK" ),
    .SEL_PATTERN ( "PATTERN" ),
    .SEL_ROUNDING_MASK ( "SEL_MASK" ),
    .SIM_MODE ( "SAFE" ),
    .USE_MULT ( "MULT_S" ),
    .USE_PATTERN_DETECT ( "NO_PATDET" ),
    .USE_SIMD ( "ONE48" ))
  blk000000d6 (
    .CLK(clk),
    .PATTERNBDETECT(NLW_blk000000d6_PATTERNBDETECT_UNCONNECTED),
    .RSTC(sig00000059),
    .CEB1(sig00000059),
    .MULTSIGNOUT(NLW_blk000000d6_MULTSIGNOUT_UNCONNECTED),
    .CEC(sig00000001),
    .RSTM(sig00000059),
    .MULTSIGNIN(sig00000059),
    .CEB2(sig00000001),
    .RSTCTRL(sig00000059),
    .CEP(sig00000001),
    .CARRYCASCOUT(NLW_blk000000d6_CARRYCASCOUT_UNCONNECTED),
    .RSTA(sig00000059),
    .CECARRYIN(sig00000001),
    .UNDERFLOW(NLW_blk000000d6_UNDERFLOW_UNCONNECTED),
    .PATTERNDETECT(NLW_blk000000d6_PATTERNDETECT_UNCONNECTED),
    .RSTALUMODE(sig00000059),
    .RSTALLCARRYIN(sig00000059),
    .CEALUMODE(sig00000001),
    .CEA2(sig00000001),
    .CEA1(sig00000059),
    .RSTB(sig00000059),
    .CEMULTCARRYIN(sig00000059),
    .OVERFLOW(NLW_blk000000d6_OVERFLOW_UNCONNECTED),
    .CECTRL(sig00000059),
    .CEM(sig00000001),
    .CARRYIN(sig00000059),
    .CARRYCASCIN(sig00000059),
    .RSTP(sig00000059),
    .CARRYINSEL({sig00000059, sig00000059, sig00000059}),
    .A({sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a, sig0000003a
, sig0000003a, sig0000003a, sig00000039, sig00000038, sig00000037, sig00000036, sig00000035, sig00000034, sig00000033, sig00000032, sig00000031, 
sig00000030, sig0000002f, sig0000002e, sig0000002d, sig0000002c, sig0000002b, sig00000001, sig00000059}),
    .C({sig0000006a, sig0000006a, sig0000006a, sig0000006a, sig0000006a, sig0000006a, sig0000006a, sig00000069, sig00000068, sig00000067, sig00000066
, sig00000065, sig00000064, sig00000063, sig00000062, sig00000061, sig00000060, sig0000005f, sig0000005e, sig0000005d, sig0000005c, sig0000005b, 
sig0000005a, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000001, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059}),
    .B({sig00000058, sig00000057, sig00000056, sig00000055, sig00000054, sig00000053, sig00000052, sig00000051, sig00000050, sig0000004f, sig0000004e
, sig0000004d, sig0000004c, sig0000004b, sig0000004a, sig00000049, sig00000048, sig00000047}),
    .P({\NLW_blk000000d6_P<47>_UNCONNECTED , \NLW_blk000000d6_P<46>_UNCONNECTED , \NLW_blk000000d6_P<45>_UNCONNECTED , 
\NLW_blk000000d6_P<44>_UNCONNECTED , \NLW_blk000000d6_P<43>_UNCONNECTED , \NLW_blk000000d6_P<42>_UNCONNECTED , cosine[15], cosine[14], cosine[13], 
cosine[12], cosine[11], cosine[10], cosine[9], cosine[8], cosine[7], cosine[6], cosine[5], cosine[4], cosine[3], cosine[2], cosine[1], cosine[0], 
\NLW_blk000000d6_P<25>_UNCONNECTED , \NLW_blk000000d6_P<24>_UNCONNECTED , \NLW_blk000000d6_P<23>_UNCONNECTED , \NLW_blk000000d6_P<22>_UNCONNECTED , 
\NLW_blk000000d6_P<21>_UNCONNECTED , \NLW_blk000000d6_P<20>_UNCONNECTED , \NLW_blk000000d6_P<19>_UNCONNECTED , \NLW_blk000000d6_P<18>_UNCONNECTED , 
\NLW_blk000000d6_P<17>_UNCONNECTED , \NLW_blk000000d6_P<16>_UNCONNECTED , \NLW_blk000000d6_P<15>_UNCONNECTED , \NLW_blk000000d6_P<14>_UNCONNECTED , 
\NLW_blk000000d6_P<13>_UNCONNECTED , \NLW_blk000000d6_P<12>_UNCONNECTED , \NLW_blk000000d6_P<11>_UNCONNECTED , \NLW_blk000000d6_P<10>_UNCONNECTED , 
\NLW_blk000000d6_P<9>_UNCONNECTED , \NLW_blk000000d6_P<8>_UNCONNECTED , \NLW_blk000000d6_P<7>_UNCONNECTED , \NLW_blk000000d6_P<6>_UNCONNECTED , 
\NLW_blk000000d6_P<5>_UNCONNECTED , \NLW_blk000000d6_P<4>_UNCONNECTED , \NLW_blk000000d6_P<3>_UNCONNECTED , \NLW_blk000000d6_P<2>_UNCONNECTED , 
\NLW_blk000000d6_P<1>_UNCONNECTED , \NLW_blk000000d6_P<0>_UNCONNECTED }),
    .ACOUT({\NLW_blk000000d6_ACOUT<29>_UNCONNECTED , \NLW_blk000000d6_ACOUT<28>_UNCONNECTED , \NLW_blk000000d6_ACOUT<27>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<26>_UNCONNECTED , \NLW_blk000000d6_ACOUT<25>_UNCONNECTED , \NLW_blk000000d6_ACOUT<24>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<23>_UNCONNECTED , \NLW_blk000000d6_ACOUT<22>_UNCONNECTED , \NLW_blk000000d6_ACOUT<21>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<20>_UNCONNECTED , \NLW_blk000000d6_ACOUT<19>_UNCONNECTED , \NLW_blk000000d6_ACOUT<18>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<17>_UNCONNECTED , \NLW_blk000000d6_ACOUT<16>_UNCONNECTED , \NLW_blk000000d6_ACOUT<15>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<14>_UNCONNECTED , \NLW_blk000000d6_ACOUT<13>_UNCONNECTED , \NLW_blk000000d6_ACOUT<12>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<11>_UNCONNECTED , \NLW_blk000000d6_ACOUT<10>_UNCONNECTED , \NLW_blk000000d6_ACOUT<9>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<8>_UNCONNECTED , \NLW_blk000000d6_ACOUT<7>_UNCONNECTED , \NLW_blk000000d6_ACOUT<6>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<5>_UNCONNECTED , \NLW_blk000000d6_ACOUT<4>_UNCONNECTED , \NLW_blk000000d6_ACOUT<3>_UNCONNECTED , 
\NLW_blk000000d6_ACOUT<2>_UNCONNECTED , \NLW_blk000000d6_ACOUT<1>_UNCONNECTED , \NLW_blk000000d6_ACOUT<0>_UNCONNECTED }),
    .OPMODE({sig00000059, sig00000001, sig00000001, sig00000059, sig00000001, sig00000059, sig00000001}),
    .PCIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .ALUMODE({sig00000059, sig00000059, sig00000001, sig00000001}),
    .CARRYOUT({\NLW_blk000000d6_CARRYOUT<3>_UNCONNECTED , \NLW_blk000000d6_CARRYOUT<2>_UNCONNECTED , \NLW_blk000000d6_CARRYOUT<1>_UNCONNECTED , 
\NLW_blk000000d6_CARRYOUT<0>_UNCONNECTED }),
    .BCIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .BCOUT({\NLW_blk000000d6_BCOUT<17>_UNCONNECTED , \NLW_blk000000d6_BCOUT<16>_UNCONNECTED , \NLW_blk000000d6_BCOUT<15>_UNCONNECTED , 
\NLW_blk000000d6_BCOUT<14>_UNCONNECTED , \NLW_blk000000d6_BCOUT<13>_UNCONNECTED , \NLW_blk000000d6_BCOUT<12>_UNCONNECTED , 
\NLW_blk000000d6_BCOUT<11>_UNCONNECTED , \NLW_blk000000d6_BCOUT<10>_UNCONNECTED , \NLW_blk000000d6_BCOUT<9>_UNCONNECTED , 
\NLW_blk000000d6_BCOUT<8>_UNCONNECTED , \NLW_blk000000d6_BCOUT<7>_UNCONNECTED , \NLW_blk000000d6_BCOUT<6>_UNCONNECTED , 
\NLW_blk000000d6_BCOUT<5>_UNCONNECTED , \NLW_blk000000d6_BCOUT<4>_UNCONNECTED , \NLW_blk000000d6_BCOUT<3>_UNCONNECTED , 
\NLW_blk000000d6_BCOUT<2>_UNCONNECTED , \NLW_blk000000d6_BCOUT<1>_UNCONNECTED , \NLW_blk000000d6_BCOUT<0>_UNCONNECTED }),
    .PCOUT({\NLW_blk000000d6_PCOUT<47>_UNCONNECTED , \NLW_blk000000d6_PCOUT<46>_UNCONNECTED , \NLW_blk000000d6_PCOUT<45>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<44>_UNCONNECTED , \NLW_blk000000d6_PCOUT<43>_UNCONNECTED , \NLW_blk000000d6_PCOUT<42>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<41>_UNCONNECTED , \NLW_blk000000d6_PCOUT<40>_UNCONNECTED , \NLW_blk000000d6_PCOUT<39>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<38>_UNCONNECTED , \NLW_blk000000d6_PCOUT<37>_UNCONNECTED , \NLW_blk000000d6_PCOUT<36>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<35>_UNCONNECTED , \NLW_blk000000d6_PCOUT<34>_UNCONNECTED , \NLW_blk000000d6_PCOUT<33>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<32>_UNCONNECTED , \NLW_blk000000d6_PCOUT<31>_UNCONNECTED , \NLW_blk000000d6_PCOUT<30>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<29>_UNCONNECTED , \NLW_blk000000d6_PCOUT<28>_UNCONNECTED , \NLW_blk000000d6_PCOUT<27>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<26>_UNCONNECTED , \NLW_blk000000d6_PCOUT<25>_UNCONNECTED , \NLW_blk000000d6_PCOUT<24>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<23>_UNCONNECTED , \NLW_blk000000d6_PCOUT<22>_UNCONNECTED , \NLW_blk000000d6_PCOUT<21>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<20>_UNCONNECTED , \NLW_blk000000d6_PCOUT<19>_UNCONNECTED , \NLW_blk000000d6_PCOUT<18>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<17>_UNCONNECTED , \NLW_blk000000d6_PCOUT<16>_UNCONNECTED , \NLW_blk000000d6_PCOUT<15>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<14>_UNCONNECTED , \NLW_blk000000d6_PCOUT<13>_UNCONNECTED , \NLW_blk000000d6_PCOUT<12>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<11>_UNCONNECTED , \NLW_blk000000d6_PCOUT<10>_UNCONNECTED , \NLW_blk000000d6_PCOUT<9>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<8>_UNCONNECTED , \NLW_blk000000d6_PCOUT<7>_UNCONNECTED , \NLW_blk000000d6_PCOUT<6>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<5>_UNCONNECTED , \NLW_blk000000d6_PCOUT<4>_UNCONNECTED , \NLW_blk000000d6_PCOUT<3>_UNCONNECTED , 
\NLW_blk000000d6_PCOUT<2>_UNCONNECTED , \NLW_blk000000d6_PCOUT<1>_UNCONNECTED , \NLW_blk000000d6_PCOUT<0>_UNCONNECTED }),
    .ACIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059})
  );
  DSP48E #(
    .ACASCREG ( 1 ),
    .ALUMODEREG ( 1 ),
    .AREG ( 1 ),
    .AUTORESET_PATTERN_DETECT ( "FALSE" ),
    .AUTORESET_PATTERN_DETECT_OPTINV ( "MATCH" ),
    .A_INPUT ( "DIRECT" ),
    .BCASCREG ( 1 ),
    .BREG ( 1 ),
    .B_INPUT ( "DIRECT" ),
    .CARRYINREG ( 1 ),
    .CARRYINSELREG ( 0 ),
    .CREG ( 1 ),
    .MASK ( 48'h3FFFFFFFFFFF ),
    .MREG ( 1 ),
    .MULTCARRYINREG ( 0 ),
    .OPMODEREG ( 0 ),
    .PATTERN ( 48'h000000000000 ),
    .PREG ( 1 ),
    .SEL_MASK ( "MASK" ),
    .SEL_PATTERN ( "PATTERN" ),
    .SEL_ROUNDING_MASK ( "SEL_MASK" ),
    .SIM_MODE ( "SAFE" ),
    .USE_MULT ( "MULT_S" ),
    .USE_PATTERN_DETECT ( "NO_PATDET" ),
    .USE_SIMD ( "ONE48" ))
  blk000000d7 (
    .CLK(clk),
    .PATTERNBDETECT(NLW_blk000000d7_PATTERNBDETECT_UNCONNECTED),
    .RSTC(sig00000059),
    .CEB1(sig00000059),
    .MULTSIGNOUT(NLW_blk000000d7_MULTSIGNOUT_UNCONNECTED),
    .CEC(sig00000001),
    .RSTM(sig00000059),
    .MULTSIGNIN(sig00000059),
    .CEB2(sig00000001),
    .RSTCTRL(sig00000059),
    .CEP(sig00000001),
    .CARRYCASCOUT(NLW_blk000000d7_CARRYCASCOUT_UNCONNECTED),
    .RSTA(sig00000059),
    .CECARRYIN(sig00000001),
    .UNDERFLOW(NLW_blk000000d7_UNDERFLOW_UNCONNECTED),
    .PATTERNDETECT(NLW_blk000000d7_PATTERNDETECT_UNCONNECTED),
    .RSTALUMODE(sig00000059),
    .RSTALLCARRYIN(sig00000059),
    .CEALUMODE(sig00000001),
    .CEA2(sig00000001),
    .CEA1(sig00000059),
    .RSTB(sig00000059),
    .CEMULTCARRYIN(sig00000059),
    .OVERFLOW(NLW_blk000000d7_OVERFLOW_UNCONNECTED),
    .CECTRL(sig00000059),
    .CEM(sig00000001),
    .CARRYIN(sig00000059),
    .CARRYCASCIN(sig00000059),
    .RSTP(sig00000059),
    .CARRYINSEL({sig00000059, sig00000059, sig00000059}),
    .A({sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a, sig0000002a
, sig0000002a, sig0000002a, sig00000029, sig00000028, sig00000027, sig00000026, sig00000025, sig00000024, sig00000023, sig00000022, sig00000021, 
sig00000020, sig0000001f, sig0000001e, sig0000001d, sig0000001c, sig0000001b, sig00000001, sig00000059}),
    .C({sig0000007b, sig0000007b, sig0000007b, sig0000007b, sig0000007b, sig0000007b, sig0000007b, sig0000007a, sig00000079, sig00000078, sig00000077
, sig00000076, sig00000075, sig00000074, sig00000073, sig00000072, sig00000071, sig00000070, sig0000006f, sig0000006e, sig0000006d, sig0000006c, 
sig0000006b, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000001, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059}),
    .B({sig00000058, sig00000057, sig00000056, sig00000055, sig00000054, sig00000053, sig00000052, sig00000051, sig00000050, sig0000004f, sig0000004e
, sig0000004d, sig0000004c, sig0000004b, sig0000004a, sig00000049, sig00000048, sig00000047}),
    .P({\NLW_blk000000d7_P<47>_UNCONNECTED , \NLW_blk000000d7_P<46>_UNCONNECTED , \NLW_blk000000d7_P<45>_UNCONNECTED , 
\NLW_blk000000d7_P<44>_UNCONNECTED , \NLW_blk000000d7_P<43>_UNCONNECTED , \NLW_blk000000d7_P<42>_UNCONNECTED , sine[15], sine[14], sine[13], sine[12]
, sine[11], sine[10], sine[9], sine[8], sine[7], sine[6], sine[5], sine[4], sine[3], sine[2], sine[1], sine[0], \NLW_blk000000d7_P<25>_UNCONNECTED , 
\NLW_blk000000d7_P<24>_UNCONNECTED , \NLW_blk000000d7_P<23>_UNCONNECTED , \NLW_blk000000d7_P<22>_UNCONNECTED , \NLW_blk000000d7_P<21>_UNCONNECTED , 
\NLW_blk000000d7_P<20>_UNCONNECTED , \NLW_blk000000d7_P<19>_UNCONNECTED , \NLW_blk000000d7_P<18>_UNCONNECTED , \NLW_blk000000d7_P<17>_UNCONNECTED , 
\NLW_blk000000d7_P<16>_UNCONNECTED , \NLW_blk000000d7_P<15>_UNCONNECTED , \NLW_blk000000d7_P<14>_UNCONNECTED , \NLW_blk000000d7_P<13>_UNCONNECTED , 
\NLW_blk000000d7_P<12>_UNCONNECTED , \NLW_blk000000d7_P<11>_UNCONNECTED , \NLW_blk000000d7_P<10>_UNCONNECTED , \NLW_blk000000d7_P<9>_UNCONNECTED , 
\NLW_blk000000d7_P<8>_UNCONNECTED , \NLW_blk000000d7_P<7>_UNCONNECTED , \NLW_blk000000d7_P<6>_UNCONNECTED , \NLW_blk000000d7_P<5>_UNCONNECTED , 
\NLW_blk000000d7_P<4>_UNCONNECTED , \NLW_blk000000d7_P<3>_UNCONNECTED , \NLW_blk000000d7_P<2>_UNCONNECTED , \NLW_blk000000d7_P<1>_UNCONNECTED , 
\NLW_blk000000d7_P<0>_UNCONNECTED }),
    .ACOUT({\NLW_blk000000d7_ACOUT<29>_UNCONNECTED , \NLW_blk000000d7_ACOUT<28>_UNCONNECTED , \NLW_blk000000d7_ACOUT<27>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<26>_UNCONNECTED , \NLW_blk000000d7_ACOUT<25>_UNCONNECTED , \NLW_blk000000d7_ACOUT<24>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<23>_UNCONNECTED , \NLW_blk000000d7_ACOUT<22>_UNCONNECTED , \NLW_blk000000d7_ACOUT<21>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<20>_UNCONNECTED , \NLW_blk000000d7_ACOUT<19>_UNCONNECTED , \NLW_blk000000d7_ACOUT<18>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<17>_UNCONNECTED , \NLW_blk000000d7_ACOUT<16>_UNCONNECTED , \NLW_blk000000d7_ACOUT<15>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<14>_UNCONNECTED , \NLW_blk000000d7_ACOUT<13>_UNCONNECTED , \NLW_blk000000d7_ACOUT<12>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<11>_UNCONNECTED , \NLW_blk000000d7_ACOUT<10>_UNCONNECTED , \NLW_blk000000d7_ACOUT<9>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<8>_UNCONNECTED , \NLW_blk000000d7_ACOUT<7>_UNCONNECTED , \NLW_blk000000d7_ACOUT<6>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<5>_UNCONNECTED , \NLW_blk000000d7_ACOUT<4>_UNCONNECTED , \NLW_blk000000d7_ACOUT<3>_UNCONNECTED , 
\NLW_blk000000d7_ACOUT<2>_UNCONNECTED , \NLW_blk000000d7_ACOUT<1>_UNCONNECTED , \NLW_blk000000d7_ACOUT<0>_UNCONNECTED }),
    .OPMODE({sig00000059, sig00000001, sig00000001, sig00000059, sig00000001, sig00000059, sig00000001}),
    .PCIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .ALUMODE({sig00000059, sig00000059, sig00000059, sig00000059}),
    .CARRYOUT({\NLW_blk000000d7_CARRYOUT<3>_UNCONNECTED , \NLW_blk000000d7_CARRYOUT<2>_UNCONNECTED , \NLW_blk000000d7_CARRYOUT<1>_UNCONNECTED , 
\NLW_blk000000d7_CARRYOUT<0>_UNCONNECTED }),
    .BCIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .BCOUT({\NLW_blk000000d7_BCOUT<17>_UNCONNECTED , \NLW_blk000000d7_BCOUT<16>_UNCONNECTED , \NLW_blk000000d7_BCOUT<15>_UNCONNECTED , 
\NLW_blk000000d7_BCOUT<14>_UNCONNECTED , \NLW_blk000000d7_BCOUT<13>_UNCONNECTED , \NLW_blk000000d7_BCOUT<12>_UNCONNECTED , 
\NLW_blk000000d7_BCOUT<11>_UNCONNECTED , \NLW_blk000000d7_BCOUT<10>_UNCONNECTED , \NLW_blk000000d7_BCOUT<9>_UNCONNECTED , 
\NLW_blk000000d7_BCOUT<8>_UNCONNECTED , \NLW_blk000000d7_BCOUT<7>_UNCONNECTED , \NLW_blk000000d7_BCOUT<6>_UNCONNECTED , 
\NLW_blk000000d7_BCOUT<5>_UNCONNECTED , \NLW_blk000000d7_BCOUT<4>_UNCONNECTED , \NLW_blk000000d7_BCOUT<3>_UNCONNECTED , 
\NLW_blk000000d7_BCOUT<2>_UNCONNECTED , \NLW_blk000000d7_BCOUT<1>_UNCONNECTED , \NLW_blk000000d7_BCOUT<0>_UNCONNECTED }),
    .PCOUT({\NLW_blk000000d7_PCOUT<47>_UNCONNECTED , \NLW_blk000000d7_PCOUT<46>_UNCONNECTED , \NLW_blk000000d7_PCOUT<45>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<44>_UNCONNECTED , \NLW_blk000000d7_PCOUT<43>_UNCONNECTED , \NLW_blk000000d7_PCOUT<42>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<41>_UNCONNECTED , \NLW_blk000000d7_PCOUT<40>_UNCONNECTED , \NLW_blk000000d7_PCOUT<39>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<38>_UNCONNECTED , \NLW_blk000000d7_PCOUT<37>_UNCONNECTED , \NLW_blk000000d7_PCOUT<36>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<35>_UNCONNECTED , \NLW_blk000000d7_PCOUT<34>_UNCONNECTED , \NLW_blk000000d7_PCOUT<33>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<32>_UNCONNECTED , \NLW_blk000000d7_PCOUT<31>_UNCONNECTED , \NLW_blk000000d7_PCOUT<30>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<29>_UNCONNECTED , \NLW_blk000000d7_PCOUT<28>_UNCONNECTED , \NLW_blk000000d7_PCOUT<27>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<26>_UNCONNECTED , \NLW_blk000000d7_PCOUT<25>_UNCONNECTED , \NLW_blk000000d7_PCOUT<24>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<23>_UNCONNECTED , \NLW_blk000000d7_PCOUT<22>_UNCONNECTED , \NLW_blk000000d7_PCOUT<21>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<20>_UNCONNECTED , \NLW_blk000000d7_PCOUT<19>_UNCONNECTED , \NLW_blk000000d7_PCOUT<18>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<17>_UNCONNECTED , \NLW_blk000000d7_PCOUT<16>_UNCONNECTED , \NLW_blk000000d7_PCOUT<15>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<14>_UNCONNECTED , \NLW_blk000000d7_PCOUT<13>_UNCONNECTED , \NLW_blk000000d7_PCOUT<12>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<11>_UNCONNECTED , \NLW_blk000000d7_PCOUT<10>_UNCONNECTED , \NLW_blk000000d7_PCOUT<9>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<8>_UNCONNECTED , \NLW_blk000000d7_PCOUT<7>_UNCONNECTED , \NLW_blk000000d7_PCOUT<6>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<5>_UNCONNECTED , \NLW_blk000000d7_PCOUT<4>_UNCONNECTED , \NLW_blk000000d7_PCOUT<3>_UNCONNECTED , 
\NLW_blk000000d7_PCOUT<2>_UNCONNECTED , \NLW_blk000000d7_PCOUT<1>_UNCONNECTED , \NLW_blk000000d7_PCOUT<0>_UNCONNECTED }),
    .ACIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059})
  );
  DSP48E #(
    .ACASCREG ( 1 ),
    .ALUMODEREG ( 1 ),
    .AREG ( 1 ),
    .AUTORESET_PATTERN_DETECT ( "FALSE" ),
    .AUTORESET_PATTERN_DETECT_OPTINV ( "MATCH" ),
    .A_INPUT ( "DIRECT" ),
    .BCASCREG ( 1 ),
    .BREG ( 1 ),
    .B_INPUT ( "DIRECT" ),
    .CARRYINREG ( 1 ),
    .CARRYINSELREG ( 0 ),
    .CREG ( 1 ),
    .MASK ( 48'h3FFFFFFFFFFF ),
    .MREG ( 1 ),
    .MULTCARRYINREG ( 0 ),
    .OPMODEREG ( 0 ),
    .PATTERN ( 48'h000000000000 ),
    .PREG ( 1 ),
    .SEL_MASK ( "MASK" ),
    .SEL_PATTERN ( "PATTERN" ),
    .SEL_ROUNDING_MASK ( "SEL_MASK" ),
    .SIM_MODE ( "SAFE" ),
    .USE_MULT ( "MULT_S" ),
    .USE_PATTERN_DETECT ( "NO_PATDET" ),
    .USE_SIMD ( "ONE48" ))
  blk000000d8 (
    .CLK(clk),
    .PATTERNBDETECT(NLW_blk000000d8_PATTERNBDETECT_UNCONNECTED),
    .RSTC(sig00000059),
    .CEB1(sig00000059),
    .MULTSIGNOUT(NLW_blk000000d8_MULTSIGNOUT_UNCONNECTED),
    .CEC(sig00000001),
    .RSTM(sig00000059),
    .MULTSIGNIN(sig00000059),
    .CEB2(sig00000001),
    .RSTCTRL(sig00000059),
    .CEP(sig00000001),
    .CARRYCASCOUT(NLW_blk000000d8_CARRYCASCOUT_UNCONNECTED),
    .RSTA(sig00000059),
    .CECARRYIN(sig00000001),
    .UNDERFLOW(NLW_blk000000d8_UNDERFLOW_UNCONNECTED),
    .PATTERNDETECT(NLW_blk000000d8_PATTERNDETECT_UNCONNECTED),
    .RSTALUMODE(sig00000059),
    .RSTALLCARRYIN(sig00000059),
    .CEALUMODE(sig00000001),
    .CEA2(sig00000001),
    .CEA1(sig00000059),
    .RSTB(sig00000059),
    .CEMULTCARRYIN(sig00000059),
    .OVERFLOW(NLW_blk000000d8_OVERFLOW_UNCONNECTED),
    .CECTRL(sig00000059),
    .CEM(sig00000001),
    .CARRYIN(sig00000059),
    .CARRYCASCIN(sig00000059),
    .RSTP(sig00000059),
    .CARRYINSEL({sig00000059, sig00000059, sig00000059}),
    .B({sig00000059, sig00000001, sig00000001, sig00000059, sig00000059, sig00000001, sig00000059, sig00000059, sig00000001, sig00000059, sig00000059
, sig00000059, sig00000059, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001}),
    .P({\NLW_blk000000d8_P<47>_UNCONNECTED , \NLW_blk000000d8_P<46>_UNCONNECTED , \NLW_blk000000d8_P<45>_UNCONNECTED , 
\NLW_blk000000d8_P<44>_UNCONNECTED , \NLW_blk000000d8_P<43>_UNCONNECTED , \NLW_blk000000d8_P<42>_UNCONNECTED , \NLW_blk000000d8_P<41>_UNCONNECTED , 
\NLW_blk000000d8_P<40>_UNCONNECTED , \NLW_blk000000d8_P<39>_UNCONNECTED , \NLW_blk000000d8_P<38>_UNCONNECTED , \NLW_blk000000d8_P<37>_UNCONNECTED , 
\NLW_blk000000d8_P<36>_UNCONNECTED , sig0000008d, sig0000008c, sig0000008b, sig0000008a, sig00000089, sig00000088, sig00000087, sig00000086, 
sig00000085, sig00000084, sig00000083, sig00000082, sig00000081, sig00000080, sig0000007f, sig0000007e, sig0000007d, sig0000007c, 
\NLW_blk000000d8_P<17>_UNCONNECTED , \NLW_blk000000d8_P<16>_UNCONNECTED , \NLW_blk000000d8_P<15>_UNCONNECTED , \NLW_blk000000d8_P<14>_UNCONNECTED , 
\NLW_blk000000d8_P<13>_UNCONNECTED , \NLW_blk000000d8_P<12>_UNCONNECTED , \NLW_blk000000d8_P<11>_UNCONNECTED , \NLW_blk000000d8_P<10>_UNCONNECTED , 
\NLW_blk000000d8_P<9>_UNCONNECTED , \NLW_blk000000d8_P<8>_UNCONNECTED , \NLW_blk000000d8_P<7>_UNCONNECTED , \NLW_blk000000d8_P<6>_UNCONNECTED , 
\NLW_blk000000d8_P<5>_UNCONNECTED , \NLW_blk000000d8_P<4>_UNCONNECTED , \NLW_blk000000d8_P<3>_UNCONNECTED , \NLW_blk000000d8_P<2>_UNCONNECTED , 
\NLW_blk000000d8_P<1>_UNCONNECTED , \NLW_blk000000d8_P<0>_UNCONNECTED }),
    .A({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059
, sig00000059, sig00000059, sig0000003b, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .ACOUT({\NLW_blk000000d8_ACOUT<29>_UNCONNECTED , \NLW_blk000000d8_ACOUT<28>_UNCONNECTED , \NLW_blk000000d8_ACOUT<27>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<26>_UNCONNECTED , \NLW_blk000000d8_ACOUT<25>_UNCONNECTED , \NLW_blk000000d8_ACOUT<24>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<23>_UNCONNECTED , \NLW_blk000000d8_ACOUT<22>_UNCONNECTED , \NLW_blk000000d8_ACOUT<21>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<20>_UNCONNECTED , \NLW_blk000000d8_ACOUT<19>_UNCONNECTED , \NLW_blk000000d8_ACOUT<18>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<17>_UNCONNECTED , \NLW_blk000000d8_ACOUT<16>_UNCONNECTED , \NLW_blk000000d8_ACOUT<15>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<14>_UNCONNECTED , \NLW_blk000000d8_ACOUT<13>_UNCONNECTED , \NLW_blk000000d8_ACOUT<12>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<11>_UNCONNECTED , \NLW_blk000000d8_ACOUT<10>_UNCONNECTED , \NLW_blk000000d8_ACOUT<9>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<8>_UNCONNECTED , \NLW_blk000000d8_ACOUT<7>_UNCONNECTED , \NLW_blk000000d8_ACOUT<6>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<5>_UNCONNECTED , \NLW_blk000000d8_ACOUT<4>_UNCONNECTED , \NLW_blk000000d8_ACOUT<3>_UNCONNECTED , 
\NLW_blk000000d8_ACOUT<2>_UNCONNECTED , \NLW_blk000000d8_ACOUT<1>_UNCONNECTED , \NLW_blk000000d8_ACOUT<0>_UNCONNECTED }),
    .OPMODE({sig00000059, sig00000001, sig00000001, sig00000059, sig00000001, sig00000059, sig00000001}),
    .PCIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .ALUMODE({sig00000059, sig00000059, sig00000059, sig00000059}),
    .C({sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001, sig00000001
, sig00000001, sig00000001, sig00000001, sig00000001, sig00000059, sig00000059, sig00000001, sig00000001, sig00000059, sig00000001, sig00000001, 
sig00000059, sig00000001, sig00000001, sig00000001, sig00000001, sig00000059, sig00000059, sig00000059, sig00000059, sig00000001, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059}),
    .CARRYOUT({\NLW_blk000000d8_CARRYOUT<3>_UNCONNECTED , \NLW_blk000000d8_CARRYOUT<2>_UNCONNECTED , \NLW_blk000000d8_CARRYOUT<1>_UNCONNECTED , 
\NLW_blk000000d8_CARRYOUT<0>_UNCONNECTED }),
    .BCIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059}),
    .BCOUT({\NLW_blk000000d8_BCOUT<17>_UNCONNECTED , \NLW_blk000000d8_BCOUT<16>_UNCONNECTED , \NLW_blk000000d8_BCOUT<15>_UNCONNECTED , 
\NLW_blk000000d8_BCOUT<14>_UNCONNECTED , \NLW_blk000000d8_BCOUT<13>_UNCONNECTED , \NLW_blk000000d8_BCOUT<12>_UNCONNECTED , 
\NLW_blk000000d8_BCOUT<11>_UNCONNECTED , \NLW_blk000000d8_BCOUT<10>_UNCONNECTED , \NLW_blk000000d8_BCOUT<9>_UNCONNECTED , 
\NLW_blk000000d8_BCOUT<8>_UNCONNECTED , \NLW_blk000000d8_BCOUT<7>_UNCONNECTED , \NLW_blk000000d8_BCOUT<6>_UNCONNECTED , 
\NLW_blk000000d8_BCOUT<5>_UNCONNECTED , \NLW_blk000000d8_BCOUT<4>_UNCONNECTED , \NLW_blk000000d8_BCOUT<3>_UNCONNECTED , 
\NLW_blk000000d8_BCOUT<2>_UNCONNECTED , \NLW_blk000000d8_BCOUT<1>_UNCONNECTED , \NLW_blk000000d8_BCOUT<0>_UNCONNECTED }),
    .PCOUT({\NLW_blk000000d8_PCOUT<47>_UNCONNECTED , \NLW_blk000000d8_PCOUT<46>_UNCONNECTED , \NLW_blk000000d8_PCOUT<45>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<44>_UNCONNECTED , \NLW_blk000000d8_PCOUT<43>_UNCONNECTED , \NLW_blk000000d8_PCOUT<42>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<41>_UNCONNECTED , \NLW_blk000000d8_PCOUT<40>_UNCONNECTED , \NLW_blk000000d8_PCOUT<39>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<38>_UNCONNECTED , \NLW_blk000000d8_PCOUT<37>_UNCONNECTED , \NLW_blk000000d8_PCOUT<36>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<35>_UNCONNECTED , \NLW_blk000000d8_PCOUT<34>_UNCONNECTED , \NLW_blk000000d8_PCOUT<33>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<32>_UNCONNECTED , \NLW_blk000000d8_PCOUT<31>_UNCONNECTED , \NLW_blk000000d8_PCOUT<30>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<29>_UNCONNECTED , \NLW_blk000000d8_PCOUT<28>_UNCONNECTED , \NLW_blk000000d8_PCOUT<27>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<26>_UNCONNECTED , \NLW_blk000000d8_PCOUT<25>_UNCONNECTED , \NLW_blk000000d8_PCOUT<24>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<23>_UNCONNECTED , \NLW_blk000000d8_PCOUT<22>_UNCONNECTED , \NLW_blk000000d8_PCOUT<21>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<20>_UNCONNECTED , \NLW_blk000000d8_PCOUT<19>_UNCONNECTED , \NLW_blk000000d8_PCOUT<18>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<17>_UNCONNECTED , \NLW_blk000000d8_PCOUT<16>_UNCONNECTED , \NLW_blk000000d8_PCOUT<15>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<14>_UNCONNECTED , \NLW_blk000000d8_PCOUT<13>_UNCONNECTED , \NLW_blk000000d8_PCOUT<12>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<11>_UNCONNECTED , \NLW_blk000000d8_PCOUT<10>_UNCONNECTED , \NLW_blk000000d8_PCOUT<9>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<8>_UNCONNECTED , \NLW_blk000000d8_PCOUT<7>_UNCONNECTED , \NLW_blk000000d8_PCOUT<6>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<5>_UNCONNECTED , \NLW_blk000000d8_PCOUT<4>_UNCONNECTED , \NLW_blk000000d8_PCOUT<3>_UNCONNECTED , 
\NLW_blk000000d8_PCOUT<2>_UNCONNECTED , \NLW_blk000000d8_PCOUT<1>_UNCONNECTED , \NLW_blk000000d8_PCOUT<0>_UNCONNECTED }),
    .ACIN({sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, 
sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059, sig00000059})
  );
  XORCY   \blk0000001c/blk00000041  (
    .CI(\blk0000001c/sig00000128 ),
    .LI(\blk0000001c/sig00000129 ),
    .O(sig0000000f)
  );
  MUXCY   \blk0000001c/blk00000040  (
    .CI(\blk0000001c/sig00000128 ),
    .DI(sig00000046),
    .S(\blk0000001c/sig00000129 ),
    .O(sig0000000e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk0000003f  (
    .I0(sig00000046),
    .I1(sig00000002),
    .O(\blk0000001c/sig00000129 )
  );
  XORCY   \blk0000001c/blk0000003e  (
    .CI(\blk0000001c/sig00000126 ),
    .LI(\blk0000001c/sig00000127 ),
    .O(sig00000010)
  );
  MUXCY   \blk0000001c/blk0000003d  (
    .CI(\blk0000001c/sig00000126 ),
    .DI(sig00000045),
    .S(\blk0000001c/sig00000127 ),
    .O(\blk0000001c/sig00000128 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk0000003c  (
    .I0(sig00000003),
    .I1(sig00000045),
    .O(\blk0000001c/sig00000127 )
  );
  XORCY   \blk0000001c/blk0000003b  (
    .CI(\blk0000001c/sig00000124 ),
    .LI(\blk0000001c/sig00000125 ),
    .O(sig00000011)
  );
  MUXCY   \blk0000001c/blk0000003a  (
    .CI(\blk0000001c/sig00000124 ),
    .DI(sig00000044),
    .S(\blk0000001c/sig00000125 ),
    .O(\blk0000001c/sig00000126 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000039  (
    .I0(sig00000044),
    .I1(sig00000004),
    .O(\blk0000001c/sig00000125 )
  );
  XORCY   \blk0000001c/blk00000038  (
    .CI(\blk0000001c/sig00000122 ),
    .LI(\blk0000001c/sig00000123 ),
    .O(sig00000012)
  );
  MUXCY   \blk0000001c/blk00000037  (
    .CI(\blk0000001c/sig00000122 ),
    .DI(sig00000043),
    .S(\blk0000001c/sig00000123 ),
    .O(\blk0000001c/sig00000124 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000036  (
    .I0(sig00000043),
    .I1(sig00000005),
    .O(\blk0000001c/sig00000123 )
  );
  XORCY   \blk0000001c/blk00000035  (
    .CI(\blk0000001c/sig00000120 ),
    .LI(\blk0000001c/sig00000121 ),
    .O(sig00000013)
  );
  MUXCY   \blk0000001c/blk00000034  (
    .CI(\blk0000001c/sig00000120 ),
    .DI(sig00000042),
    .S(\blk0000001c/sig00000121 ),
    .O(\blk0000001c/sig00000122 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000033  (
    .I0(sig00000042),
    .I1(sig00000006),
    .O(\blk0000001c/sig00000121 )
  );
  XORCY   \blk0000001c/blk00000032  (
    .CI(\blk0000001c/sig0000011e ),
    .LI(\blk0000001c/sig0000011f ),
    .O(sig00000014)
  );
  MUXCY   \blk0000001c/blk00000031  (
    .CI(\blk0000001c/sig0000011e ),
    .DI(sig00000041),
    .S(\blk0000001c/sig0000011f ),
    .O(\blk0000001c/sig00000120 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000030  (
    .I0(sig00000041),
    .I1(sig00000007),
    .O(\blk0000001c/sig0000011f )
  );
  XORCY   \blk0000001c/blk0000002f  (
    .CI(\blk0000001c/sig0000011c ),
    .LI(\blk0000001c/sig0000011d ),
    .O(sig00000015)
  );
  MUXCY   \blk0000001c/blk0000002e  (
    .CI(\blk0000001c/sig0000011c ),
    .DI(sig00000040),
    .S(\blk0000001c/sig0000011d ),
    .O(\blk0000001c/sig0000011e )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk0000002d  (
    .I0(sig00000040),
    .I1(sig00000008),
    .O(\blk0000001c/sig0000011d )
  );
  XORCY   \blk0000001c/blk0000002c  (
    .CI(\blk0000001c/sig0000011a ),
    .LI(\blk0000001c/sig0000011b ),
    .O(sig00000016)
  );
  MUXCY   \blk0000001c/blk0000002b  (
    .CI(\blk0000001c/sig0000011a ),
    .DI(sig0000003f),
    .S(\blk0000001c/sig0000011b ),
    .O(\blk0000001c/sig0000011c )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk0000002a  (
    .I0(sig0000003f),
    .I1(sig00000009),
    .O(\blk0000001c/sig0000011b )
  );
  XORCY   \blk0000001c/blk00000029  (
    .CI(\blk0000001c/sig00000118 ),
    .LI(\blk0000001c/sig00000119 ),
    .O(sig00000017)
  );
  MUXCY   \blk0000001c/blk00000028  (
    .CI(\blk0000001c/sig00000118 ),
    .DI(sig0000003e),
    .S(\blk0000001c/sig00000119 ),
    .O(\blk0000001c/sig0000011a )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000027  (
    .I0(sig0000003e),
    .I1(sig0000000a),
    .O(\blk0000001c/sig00000119 )
  );
  XORCY   \blk0000001c/blk00000026  (
    .CI(\blk0000001c/sig00000116 ),
    .LI(\blk0000001c/sig00000117 ),
    .O(sig00000018)
  );
  MUXCY   \blk0000001c/blk00000025  (
    .CI(\blk0000001c/sig00000116 ),
    .DI(sig0000003d),
    .S(\blk0000001c/sig00000117 ),
    .O(\blk0000001c/sig00000118 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000024  (
    .I0(sig0000003d),
    .I1(sig0000000b),
    .O(\blk0000001c/sig00000117 )
  );
  XORCY   \blk0000001c/blk00000023  (
    .CI(\blk0000001c/sig00000114 ),
    .LI(\blk0000001c/sig00000115 ),
    .O(sig00000019)
  );
  MUXCY   \blk0000001c/blk00000022  (
    .CI(\blk0000001c/sig00000114 ),
    .DI(sig0000003c),
    .S(\blk0000001c/sig00000115 ),
    .O(\blk0000001c/sig00000116 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk00000021  (
    .I0(sig0000003c),
    .I1(sig0000000c),
    .O(\blk0000001c/sig00000115 )
  );
  XORCY   \blk0000001c/blk00000020  (
    .CI(\blk0000001c/sig00000112 ),
    .LI(\blk0000001c/sig00000113 ),
    .O(sig0000001a)
  );
  MUXCY   \blk0000001c/blk0000001f  (
    .CI(\blk0000001c/sig00000112 ),
    .DI(sig0000003b),
    .S(\blk0000001c/sig00000113 ),
    .O(\blk0000001c/sig00000114 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \blk0000001c/blk0000001e  (
    .I0(sig0000003b),
    .I1(sig0000000d),
    .O(\blk0000001c/sig00000113 )
  );
  GND   \blk0000001c/blk0000001d  (
    .G(\blk0000001c/sig00000112 )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
