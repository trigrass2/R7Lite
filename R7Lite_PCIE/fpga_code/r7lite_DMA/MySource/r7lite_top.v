`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		 Weihongwei
// 
// Create Date:    13:04:23 06/25/2014 
// Design Name: 	 r7lite_ada
// Module Name:    r7lite_top 
// Project Name: 	 r7lite
// Target Devices: XC7K160T-2FFG676
// Tool versions:  ISE14.7
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
`include "globe_parameter.v"
//////////////////////////////////////////////////////////////////////////////////
module r7lite_top #(
	parameter 	USE_LOOPBACK_TEST  	= 0,	
	parameter 	C_NUM_PCIE_LANES		= 4,	
	parameter 	C_DBUS_WIDTH         = 64,		//PCIe Data bus width
	
`ifdef PCIE2	
	parameter	PCIE_LINK_SPEED		= 2,		//1 - Gen1 , 2 - Gen2
	parameter 	USER_CLK_FREQ 			= 3,		// 0 - 31.25 MHz , 1 - 62.5 MHz , 2 - 125 MHz , 3 - 250 MHz , 4 - 500Mhz
`endif
`ifdef PCIE1
	parameter	PCIE_LINK_SPEED		= 1,		//1 - Gen1 , 2 - Gen2
	parameter 	USER_CLK_FREQ 			= 2,		// 0 - 31.25 MHz , 1 - 62.5 MHz , 2 - 125 MHz , 3 - 250 MHz , 4 - 500Mhz
`endif	
	parameter	C_PRAM_AWIDTH			= 12,
	parameter 	C_EMU_FIFO_DC_WIDTH  = 15, 		//Small BRAM FIFO for emulation//S 14 x fifo originale  15 x fifo grande!!
	
`ifdef DDR3_4GB
   parameter BANK_WIDTH            	= 3,	// # of memory Bank Address bits.
   parameter CK_WIDTH              	= 2,	// # of CK/CK# outputs to memory.
   parameter CS_WIDTH              	= 2,	// # of unique CS outputs to memory.
   parameter nCS_PER_RANK          	= 1,	// # of unique CS outputs per rank for phy
   parameter CKE_WIDTH             	= 2,	// # of CKE outputs to memory.
	parameter DM_WIDTH              	= 8, 	// # of DM (data mask)
   parameter DQ_WIDTH              	= 64,	// # of DQ (data)											 
	parameter DQS_WIDTH             	= 8,
   parameter ODT_WIDTH             	= 2,	// # of ODT outputs to memory.
   parameter ROW_WIDTH             	= 15,	// # of memory Row Address bits.
	parameter ADDR_WIDTH            	= 29,
	parameter PAYLOAD_WIDTH         	= 64,
	parameter nCK_PER_CLK				= 2,
	parameter RANKS                 	= 2
`endif
`ifdef DDR3_2GB
   parameter BANK_WIDTH            	= 3,	// # of memory Bank Address bits.
   parameter CK_WIDTH              	= 1,	// # of CK/CK# outputs to memory.
   parameter CS_WIDTH              	= 1,	// # of unique CS outputs to memory.
   parameter nCS_PER_RANK          	= 1,	// # of unique CS outputs per rank for phy
   parameter CKE_WIDTH             	= 1,	// # of CKE outputs to memory.
	parameter DM_WIDTH              	= 8, 	// # of DM (data mask)
   parameter DQ_WIDTH              	= 64,	// # of DQ (data)											 
	parameter DQS_WIDTH             	= 8,
   parameter ODT_WIDTH             	= 1,	// # of ODT outputs to memory.
   parameter ROW_WIDTH             	= 15,	// # of memory Row Address bits.
	parameter ADDR_WIDTH            	= 29,
	parameter PAYLOAD_WIDTH         	= 64,
	parameter nCK_PER_CLK				= 2,
	parameter RANKS                 	= 1
`endif
	)
	(
	//--------------Globe signal----------------------------------------------------
	input					key_rst_n,
	input					sys_clk_i,
	input             sys_clk_p,
	input             sys_clk_n,	
//	input					clk_66m,
	output	[3:0]		led,
//	input		[3:0]		user_cfg,

//--------------ADA signal----------------------------------------------------	
	output 					lpc_clkin_p,
	output 					lpc_clkin_n,
	output  		[15:0] 	daci,
	output  		[15:0] 	dacq,
	input 		[13:0] 	adci,
	input 		[13:0] 	adcq,
	input 					adc_clk,
	output 					sclk,
	output 					sdio,
	output 					csb,
	output 					lpc_rst,	
	//--------------Pcie signal----------------------------------------------------
	input		[C_NUM_PCIE_LANES-1 : 0]		pci_exp_rxp,
	input		[C_NUM_PCIE_LANES-1 : 0]		pci_exp_rxn,
	output	[C_NUM_PCIE_LANES-1 : 0]		pci_exp_txp,
	output	[C_NUM_PCIE_LANES-1 : 0]		pci_exp_txn,
	input												pci_clk_p,
	input												pci_clk_n,
	input												pci_rst_n,
	//--------------DDR3 signal----------------------------------------------------
   // Inouts
   inout [DQ_WIDTH-1:0]                   ddr3_dq,
   inout [DQS_WIDTH-1:0]                  ddr3_dqs_n,
   inout [DQS_WIDTH-1:0]                  ddr3_dqs_p,

   // Outputs
   output [ROW_WIDTH-1:0]                 ddr3_addr,
   output [BANK_WIDTH-1:0]                ddr3_ba,
   output                                 ddr3_ras_n,
   output                                 ddr3_cas_n,
   output                                 ddr3_we_n,
   output                                 ddr3_reset_n,
   output [CK_WIDTH-1:0]                  ddr3_ck_p,
   output [CK_WIDTH-1:0]                  ddr3_ck_n,
   output [CKE_WIDTH-1:0]                 ddr3_cke,
   output [CS_WIDTH*nCS_PER_RANK-1:0]     ddr3_cs_n,
   output [DM_WIDTH-1:0]                  ddr3_dm,
   output [ODT_WIDTH-1:0]                 ddr3_odt
	
    );
//------------------指示灯输出---------------------------------
assign	led = {~sys_rst_n,init_calib_complete,user_lnk_up,trn_Blinker};
//--------------寄存器空间----------------------------------------------------------------------------	
wire	[31:0]	ch0_control_reg;	//控制寄存器
wire	[31:0]	ch0_dmasize_reg;	//DMA_SIZE
reg	[31:0]	ch0_status_reg;	//状态寄存器
wire	[63:0]	ch0_freq_reg;		//记录频率

wire	[63:0]	ch0_total_size;	//记录数据总量

wire	[31:0]	ch1_control_reg;	//控制寄存器
wire	[31:0]	ch1_dmasize_reg;	//DMA_SIZE
reg	[31:0]	ch1_status_reg;	//状态寄存器
wire	[63:0]	ch1_freq_reg;		//记录频率

wire	[63:0]	ch1_total_size;	//记录数据总量

wire	[31:0]	int_vector;
//--------------内部寄存器-----------------------------------------------------------------------
wire	[31:0]	ch0_fifo_dout,ch1_fifo_dout;//数据缓冲区数据输出
//------------------系统复位---------------------------------------------------------------
wire  sys_rst_n = key_rst_n & pcie_sys_rst_o_n;

//------------------ADC & DAC---------------------------------------------------------------

adaloop adaloop_inst (
    .mclk(sys_clk_o), 
    .rst(sys_rst_n & (~eb_rst)), 
    .lpc_clkin_p(lpc_clkin_p), 
    .lpc_clkin_n(lpc_clkin_n), 
    .daci(daci), 
    .dacq(dacq), 
    .adci(adci), 
    .adcq(adcq), 
    .adc_clk(adc_clk), 
    .sclk(sclk), 
    .sdio(sdio), 
    .csb(csb), 
    .lpc_rst(lpc_rst),
	 .clk50m(clk_50m)
    );

//////////////////////////////////////////////////////////////////////////////////////////////////

data_path data_path_i (
    .din16({adci,2'b00}), 
    .dout32(ch0_fifo_dout), 
    .control_reg(ch0_control_reg), 
    .freq_reg(ch0_freq_reg),
    .total_size(ch0_total_size), 
    .data_path_rst(ddr3_sys_rst_o | eb_rst | (~init_calib_complete)), 
    .clk_50m(clk_50m), 
	 .clk_pcie(user_clk_out),
    .adc_clk(adc_clk), 
	 .ddr3_fifo_full(WR1_FULL),  
    .fifo_empty(ch0_fifo_empty),
	 .fifo_full(ch0_fifo_full),
	 .total_size_mannul_reset(ch0_total_size_mannul_reset),
	 .fifo_rd_en(ch0_fifo_rd_en)
    );
	 
data_path data_path_q (
    .din16({adcq,2'b00}), 
    .dout32(ch1_fifo_dout), 
    .control_reg(ch1_control_reg), 
    .freq_reg(ch1_freq_reg), 
    .total_size(ch1_total_size), 
    .data_path_rst(ddr3_sys_rst_o | eb_rst | (~init_calib_complete)), 
    .clk_50m(clk_50m), 
	 .clk_pcie(user_clk_out),
    .adc_clk(adc_clk), 
	 .ddr3_fifo_full(WR2_FULL), 
    .fifo_empty(ch1_fifo_empty),
	 .fifo_full(ch1_fifo_full),
	 .total_size_mannul_reset(ch1_total_size_mannul_reset),
	 .fifo_rd_en(ch1_fifo_rd_en)
    );

//-----------------------------------------------------------------------------------------------
wire	[C_DBUS_WIDTH-1:0]		RD1_DATA,RD2_DATA,WR1_DATA,WR2_DATA;
wire	[31:0]						RD1_USE,RD2_USE,WR1_USE,WR2_USE;
wire	[C_DBUS_WIDTH-1:0]		DMA_us_Length,DMA_ds_Length;
wire	[C_DBUS_WIDTH-1:0]		DMA_us_PA,DMA_ds_PA;
wire	[31:0]						ch0_ddr3_use,ch1_ddr3_use;
	
	MIG_4Port #(
		.C_DBUS_WIDTH				(C_DBUS_WIDTH	),
		.BANK_WIDTH            	(BANK_WIDTH    ),	// # of memory Bank Address bits.
		.CK_WIDTH              	(CK_WIDTH      ),	// # of CK/CK# outputs to memory.
		.CS_WIDTH              	(CS_WIDTH      ),	// # of unique CS outputs to memory.
		.nCS_PER_RANK          	(nCS_PER_RANK  ),	// # of unique CS outputs per rank for phy
		.CKE_WIDTH             	(CKE_WIDTH     ),	// # of CKE outputs to memory.
		.DM_WIDTH              	(DM_WIDTH      ), 	// # of DM (data mask)
		.DQ_WIDTH              	(DQ_WIDTH      ),	// # of DQ (data)											 
		.DQS_WIDTH             	(DQS_WIDTH     ),
		.ODT_WIDTH             	(ODT_WIDTH     ),	// # of ODT outputs to memory.
		.ROW_WIDTH             	(ROW_WIDTH     ),	// # of memory Row Address bits.
		.ADDR_WIDTH            	(ADDR_WIDTH    ),
		.PAYLOAD_WIDTH         	(PAYLOAD_WIDTH ),
		.nCK_PER_CLK				(nCK_PER_CLK	),
		.RANKS						(RANKS			)
	)MIG_4Port_inst
	(
	 //ch0 write fifo
    .WR1_DATA(WR1_DATA), 
    .WR1(WR1), 
    .WR1_ADDR(29'h0), 
    .WR1_MAX_ADDR(29'h0FFF_FFFF), //2GB
    .WR1_LENGTH(DMA_us_Length>>6), 
    .WR1_LOAD(1'b0), 
    .WR1_CLK(user_clk_out), 
    .WR1_FULL(WR1_FULL), 
    .WR1_USE(WR1_USE), 
	 .WR1_EMPTY(WR1_EMPTY),
	 //ch1 write fifo
    .WR2_DATA(WR2_DATA), 
    .WR2(WR2), 
    .WR2_ADDR(29'h1000_0000), 
    .WR2_MAX_ADDR(29'h1FFF_FFFF), //2GB
    .WR2_LENGTH(DMA_us_Length>>6), 
    .WR2_LOAD(1'b0), 
    .WR2_CLK(user_clk_out), 
    .WR2_FULL(WR2_FULL), 
    .WR2_USE(WR2_USE), 
	 .WR2_EMPTY(WR2_EMPTY),
	 //ch1 read fifo
    .RD1_DATA(RD1_DATA), 
    .RD1(RD1),
    .RD1_ADDR(29'h0), 
    .RD1_MAX_ADDR(29'h0FFF_FFFF), 
    .RD1_LENGTH(DMA_us_Length>>6), 
    .RD1_LOAD(1'b0), 
    .RD1_CLK(user_clk_out), 
    .RD1_EMPTY(RD1_EMPTY), 
    .RD1_USE(RD1_USE), 
	 .RD1_DMA(RD1_DMA),
	 .RD1_FULL(RD1_FULL),
	 //ch2 read fifo
    .RD2_DATA(RD2_DATA), 
    .RD2(RD2), 
    .RD2_ADDR(29'h1000_0000), 
    .RD2_MAX_ADDR(29'h1FFF_FFFF), 
    .RD2_LENGTH(DMA_us_Length>>6), 
    .RD2_LOAD(1'b0), 
    .RD2_CLK(user_clk_out), 
    .RD2_EMPTY(RD2_EMPTY), 
    .RD2_USE(RD2_USE),
	 .RD2_DMA(RD2_DMA),
	 .RD2_FULL(RD2_FULL),

	 .DMA_us_Length(DMA_us_Length),
	 .CH0_DMA_SIZE(ch0_dmasize_reg),
	 .CH1_DMA_SIZE(ch1_dmasize_reg),
	 //ddr3
    .ddr3_dq(ddr3_dq), 
    .ddr3_dqs_n(ddr3_dqs_n), 
    .ddr3_dqs_p(ddr3_dqs_p), 
    .ddr3_addr(ddr3_addr), 
    .ddr3_ba(ddr3_ba), 
    .ddr3_ras_n(ddr3_ras_n), 
    .ddr3_cas_n(ddr3_cas_n), 
    .ddr3_we_n(ddr3_we_n), 
    .ddr3_reset_n(ddr3_reset_n), 
    .ddr3_ck_p(ddr3_ck_p), 
    .ddr3_ck_n(ddr3_ck_n), 
    .ddr3_cke(ddr3_cke), 
    .ddr3_cs_n(ddr3_cs_n), 
    .ddr3_dm(ddr3_dm), 
    .ddr3_odt(ddr3_odt), 
	
	 //system input
    .sys_clk_i(sys_clk_i),  
	 .sys_clk_p(sys_clk_p),
	 .sys_clk_n(sys_clk_n),
    .sys_rst_n(sys_rst_n & (~eb_rst)),
	 .eb_rst(eb_rst),
	 .pcie_clk(user_clk_out),
	 
	 //status	 
    .ch0_ddr3_use(ch0_ddr3_use), 
    .ch1_ddr3_use(ch1_ddr3_use), 
    .ch0_ddr3_full(ch0_ddr3_full), 
    .ch1_ddr3_full(ch1_ddr3_full), 
    .ch0_valid(ch0_valid), 
    .ch1_valid(ch1_valid), 
	 
//  .led(led), 
    .init_calib_complete(init_calib_complete), 
	 //system output
    .ui_clk(ui_clk), 
    .ui_clk_sync_rst(ddr3_sys_rst_o), 
    .sys_clk_o(sys_clk_o)
    );
	 	
//-----------------------------------PCIe_UserLogic signal-------------------------------------------
	wire  [C_EMU_FIFO_DC_WIDTH-1 : 0]	user_rd_data_count 	;
	wire  										user_rd_en				;
	wire  [C_DBUS_WIDTH-1:0]				user_rd_dout			;
	wire  										user_rd_pempty     	;
	wire  										user_rd_empty      	;
	wire  [C_EMU_FIFO_DC_WIDTH-1 : 0]	user_wr_data_count 	;
	wire  										user_wr_en         	;
	wire  [C_DBUS_WIDTH-1:0]				user_wr_din 			;
	wire  										user_wr_pfull      	;
	wire  										user_wr_full       	;
	wire  										user_rd_valid      	;
	wire	[7:0]									user_wr_weA				;
	wire	[C_PRAM_AWIDTH-1 : 0]			user_wr_addrA 			;
	wire	[C_DBUS_WIDTH-1 : 0] 			user_wr_dinA  			;
	wire	[C_PRAM_AWIDTH-1 : 0]			user_rd_addrB 			;
	wire	[C_DBUS_WIDTH-1 : 0] 			user_rd_doutB			;
	
	wire	[31:0]	reg01_td,reg02_td,reg03_td,reg04_td,reg05_td,reg06_td,reg07_td,reg08_td,reg09_td,reg10_td,
						reg11_td,reg12_td,reg13_td,reg14_td,reg15_td,reg16_td,reg17_td,reg18_td,reg19_td,reg20_td,
						reg21_td,reg22_td,reg23_td,reg24_td,reg25_td;
	wire	[24:0]	reg_tv;
	wire	[31:0]	reg01_rd,reg02_rd,reg03_rd,reg04_rd,reg05_rd,reg06_rd,reg07_rd,reg08_rd,reg09_rd,reg10_rd,
						reg11_rd,reg12_rd,reg13_rd,reg14_rd,reg15_rd,reg16_rd,reg17_rd,reg18_rd,reg19_rd,reg20_rd,
						reg21_rd,reg22_rd,reg23_rd,reg24_rd,reg25_rd;
	wire	[24:0]	reg_rv;					
	wire				CTL_irq;
	wire				DAQ_irq;
	wire				DLM_irq;
	wire				CTLTOUT_irq;
	wire				DAQTOUT_irq;
	wire				DLMTOUT_irq;	
	wire	[C_DBUS_WIDTH-1 : 0]			Sys_Int_Enable;
	wire	[31:0]   debug_in_1i,debug_in_2i,debug_in_3i,debug_in_4i ;
	
pcie_if #(
	.USE_LOOPBACK_TEST		(USE_LOOPBACK_TEST),	
	.C_NUM_PCIE_LANES			(C_NUM_PCIE_LANES),
	.C_DBUS_WIDTH         	(C_DBUS_WIDTH)	,	//PCIe Data bus width	
	.PCIE_LINK_SPEED			(PCIE_LINK_SPEED),
	.USER_CLK_FREQ				(USER_CLK_FREQ),
	.C_PRAM_AWIDTH				(C_PRAM_AWIDTH),
	.C_EMU_FIFO_DC_WIDTH		(C_EMU_FIFO_DC_WIDTH)
)pcie_if_inst (
	 //pcie port
    .user_clk_out(user_clk_out), 
    .user_lnk_up(user_lnk_up), 
    .trn_Blinker(trn_Blinker), 
    .pci_exp_rxp(pci_exp_rxp), 
    .pci_exp_rxn(pci_exp_rxn), 
    .pci_exp_txp(pci_exp_txp), 
    .pci_exp_txn(pci_exp_txn), 
    .sys_clk_p(pci_clk_p), 
    .sys_clk_n(pci_clk_n), 
    .pci_rst_n(pci_rst_n),
	 .pci_rst_n_c(pcie_sys_rst_o_n),
	 
	 //fifo port
    .user_rd_data_count(user_rd_data_count), 
    .user_rd_en(user_rd_en), 
    .user_rd_dout(user_rd_dout), 
    .user_rd_pempty(user_rd_pempty), 
    .user_rd_empty(user_rd_empty), 
    .user_wr_data_count(user_wr_data_count), 
    .user_wr_en(user_wr_en), 
    .user_wr_din(user_wr_din), 
    .user_wr_pfull(user_wr_pfull), 
    .user_wr_full(user_wr_full), 
    .user_rd_valid(user_rd_valid), 
	 
	 //dpram port
    .user_wr_weA(user_wr_weA), 
    .user_wr_addrA(user_wr_addrA), 
    .user_wr_dinA(user_wr_dinA), 
    .user_rd_addrB(user_rd_addrB), 
    .user_rd_doutB(user_rd_doutB), 
	 
    .DMA_Host2Board_Busy(DMA_Host2Board_Busy), 
    .DMA_Host2Board_Done(DMA_Host2Board_Done), 
	 .eb_empty(eb_empty),
	 
		//Interrupter triggers
		.DAQ_irq							(DAQ_irq),                
		.CTL_irq							(CTL_irq),                
		.DLM_irq							(DLM_irq),
		.DAQTOUT_irq 					(DAQTOUT_irq),
		.CTLTOUT_irq 					(CTLTOUT_irq),
		.DLMTOUT_irq					(DLMTOUT_irq),		
		.Sys_Int_Enable				(Sys_Int_Enable),

		.DMA_us_Length			(DMA_us_Length),
		.DMA_us_PA				(DMA_us_PA),
		.DMA_us_Busy			(DMA_us_Busy	),

		.DMA_ds_Length			(DMA_ds_Length),
		.DMA_ds_PA				(DMA_ds_PA),
		.DMA_ds_Busy			(DMA_ds_Busy	),
		
		 //debug port
		 .debug_in_1i(debug_in_1i), 
		 .debug_in_2i(debug_in_2i), 
		 .debug_in_3i(debug_in_3i), 
		 .debug_in_4i(debug_in_4i), 

		//Register: PC-->FPGA
		.reg01_td(reg01_td),	.reg02_td(reg02_td),                   
		.reg03_td(reg03_td),	.reg04_td(reg04_td),                   
		.reg05_td(reg05_td), .reg06_td(reg06_td),                   
		.reg07_td(reg07_td), .reg08_td(reg08_td),                   
		.reg09_td(reg09_td), .reg10_td(reg10_td),                   
		.reg11_td(reg11_td), .reg12_td(reg12_td),                   
		.reg13_td(reg13_td), .reg14_td(reg14_td), 
		.reg15_td(reg15_td), .reg16_td(reg16_td),                   
		.reg17_td(reg17_td), .reg18_td(reg18_td),                   
		.reg19_td(reg19_td), .reg20_td(reg20_td),	
		.reg21_td(reg21_td),	.reg22_td(reg22_td),                   
		.reg23_td(reg23_td),	.reg24_td(reg24_td),                   
		.reg25_td(reg25_td), 
		.reg_tv(reg_tv),
		
		//Register: FPGA-->PC
		.reg01_rd(reg01_rd), .reg02_rd(reg02_rd),                   
		.reg03_rd(reg03_rd), .reg04_rd(reg04_rd),
		.reg05_rd(reg05_rd),	.reg06_rd(reg06_rd),
		.reg07_rd(reg07_rd), .reg08_rd(reg08_rd),                   
		.reg09_rd(reg09_rd), .reg10_rd(reg10_rd),                   
		.reg11_rd(reg11_rd), .reg12_rd(reg12_rd),                   
		.reg13_rd(reg13_rd), .reg14_rd(reg14_rd),
		.reg15_rd(reg15_rd), .reg16_rd(reg16_rd),
		.reg17_rd(reg17_rd), .reg18_rd(reg18_rd),
		.reg19_rd(reg19_rd), .reg20_rd(reg20_rd),				
		.reg21_rd(reg21_rd), .reg22_rd(reg22_rd),                   
		.reg23_rd(reg23_rd), .reg24_rd(reg24_rd),
		.reg25_rd(reg25_rd),
		.reg_rv(reg_rv)		

    );

Connection Connection_inst
	(	
		.sys_rst_n			(sys_rst_n & (~eb_rst)),
		.user_clk			(user_clk_out),

		.ch0_fifo_dout		(ch0_fifo_dout),
		.ch0_fifo_empty	(ch0_fifo_empty),
		.ch1_fifo_dout		(ch1_fifo_dout),
		.ch1_fifo_empty	(ch1_fifo_empty),
		
		 //ch0 write fifo
		 .WR1_DATA(WR1_DATA), 
		 .WR1(WR1), 
		 .WR1_FULL(WR1_FULL), 
		 .WR1_USE(WR1_USE), 
		 .WR1_EMPTY(WR1_EMPTY),
		 
		 //ch1 write fifo
		 .WR2_DATA(WR2_DATA), 
		 .WR2(WR2), 
		 .WR2_FULL(WR2_FULL), 
		 .WR2_USE(WR2_USE), 
		 .WR2_EMPTY(WR2_EMPTY),
	 
		//ddr3 ch1 read fifo
		.RD1_DATA			(RD1_DATA), 
		.RD1					(RD1), 
		.RD1_EMPTY			(RD1_EMPTY), 
		.RD1_USE				(RD1_USE), 
		.RD1_DMA				(RD1_DMA),

		//ddr3 ch2 read fifo
		.RD2_DATA			(RD2_DATA), 
		.RD2					(RD2),
		.RD2_EMPTY			(RD2_EMPTY), 
		.RD2_USE				(RD2_USE),
		.RD2_DMA				(RD2_DMA),
	 
		//pcie fifo port
		.fifo_rd_count  	(user_rd_data_count),
		.fifo_rd_dout   	(user_rd_dout),
		.fifo_rd_empty  	(user_rd_empty),
		.fifo_rd_pempty 	(user_rd_pempty),
		.fifo_rd_en 		(user_rd_en), 
		.fifo_rd_valid		(user_rd_valid),

		.fifo_wr_full   	(user_wr_full), 
		.fifo_wr_pfull  	(user_wr_pfull),
		.fifo_wr_din 		(user_wr_din),
		.fifo_wr_en 		(user_wr_en),			
		.fifo_wr_count  	(user_wr_data_count),
			
		//pcie dpram port
		.bram_rd_addr 		(user_rd_addrB),
		.bram_rd_dout   	(user_rd_doutB), 		
		.bram_wr_addr 		(user_wr_addrA),
		.bram_wr_din 		(user_wr_dinA),
		.bram_wr_en 		(user_wr_weA),

		//debug signals	
		.dma_host2board_busy (DMA_Host2Board_Busy),
		.dma_host2board_done (DMA_Host2Board_Done),

		//debug wires
		.debug_in_1i			(debug_in_1i),		 
		.debug_in_2i			(debug_in_2i),			 
		.debug_in_3i			(debug_in_3i),					
		.debug_in_4i			(debug_in_4i),	
			
		//Interrupter triggers
		.CH0_irq					(DAQ_irq),                
		.CH1_irq					(CTL_irq),                
		.TEMP_irq				(DLM_irq),
		.CH0TOUT_irq 			(DAQTOUT_irq),
		.CH1TOUT_irq 			(CTLTOUT_irq),
		.TEMPTOUT_irq			(DLMTOUT_irq),
		.Sys_Int_Enable		(Sys_Int_Enable),
		
		.DMA_us_Length			(DMA_us_Length),
		.DMA_us_PA				(DMA_us_PA),
		.DMA_us_Busy			(DMA_us_Busy),
		
		// Register: PC-->FPGA
		.reg01_td(reg01_td),	.reg02_td(reg02_td),                   
		.reg03_td(reg03_td),	.reg04_td(reg04_td),                   
		.reg05_td(reg05_td), .reg06_td(reg06_td),                   
		.reg07_td(reg07_td), .reg08_td(reg08_td),                   
		.reg09_td(reg09_td), .reg10_td(reg10_td),                   
		.reg11_td(reg11_td), .reg12_td(reg12_td),                   
		.reg13_td(reg13_td), .reg14_td(reg14_td),
		.reg15_td(reg15_td), .reg16_td(reg16_td),                   
		.reg17_td(reg17_td), .reg18_td(reg18_td),                   
		.reg19_td(reg19_td), .reg20_td(reg20_td),		
		.reg21_td(reg21_td),	.reg22_td(reg22_td),                   
		.reg23_td(reg23_td),	.reg24_td(reg24_td),                   
		.reg25_td(reg25_td), 		
		.reg_tv(reg_tv),
		
		// Register: FPGA-->PC
		.reg01_rd(reg01_rd), .reg02_rd(reg02_rd),                   
		.reg03_rd(reg03_rd), .reg04_rd(reg04_rd),
		.reg05_rd(reg05_rd),	.reg06_rd(reg06_rd),
		.reg07_rd(reg07_rd), .reg08_rd(reg08_rd),                   
		.reg09_rd(reg09_rd), .reg10_rd(reg10_rd),                   
		.reg11_rd(reg11_rd), .reg12_rd(reg12_rd),                   
		.reg13_rd(reg13_rd), .reg14_rd(reg14_rd),
		.reg15_rd(reg15_rd), .reg16_rd(reg16_rd),
		.reg17_rd(reg17_rd), .reg18_rd(reg18_rd),
		.reg19_rd(reg19_rd), .reg20_rd(reg20_rd),	
		.reg21_rd(reg21_rd), .reg22_rd(reg22_rd),                   
		.reg23_rd(reg23_rd), .reg24_rd(reg24_rd),
		.reg25_rd(reg25_rd),		
		.reg_rv(reg_rv),   
			
		.ch0_control_reg(ch0_control_reg), 
		.ch0_dmasize_reg(ch0_dmasize_reg),
		.ch0_status_reg(ch0_status_reg), 
		.ch0_freq_reg(ch0_freq_reg), 
		.ch0_total_size(ch0_total_size),

		.ch1_control_reg(ch1_control_reg), 
		.ch1_dmasize_reg(ch1_dmasize_reg),
		.ch1_status_reg(ch1_status_reg), 
		.ch1_freq_reg(ch1_freq_reg), 
		.ch1_total_size(ch1_total_size),

		.ch0_ddr3_use(ch0_ddr3_use), 
		.ch1_ddr3_use(ch1_ddr3_use),
		.ch0_valid(ch0_valid), 
		.ch1_valid(ch1_valid),
		
		.ch0_total_size_mannul_reset(ch0_total_size_mannul_reset),
		.ch1_total_size_mannul_reset(ch1_total_size_mannul_reset)


	);

//--------------状态寄存器--------------------------------------------------------------------
always @(posedge user_clk_out or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ch0_status_reg <= 32'b0;
		end
	else begin
		ch0_status_reg <= {	
							user_lnk_up,	
							init_calib_complete,	
							ch0_valid,
							ch0_ddr3_full,
							
							ch0_fifo_empty,
							ch0_fifo_full,
							WR1_FULL,
							RD1_EMPTY,						
							
							user_wr_full,
							eb_empty,
														
							ch0_control_reg[21:0]
							};
		end
	end
	
always @(posedge user_clk_out or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ch1_status_reg <= 32'b0;
		end
	else begin
		ch1_status_reg <= {	
							user_lnk_up,	
							init_calib_complete,	
							ch1_valid,
							ch1_ddr3_full,
							
							ch1_fifo_empty,
							ch1_fifo_full,
							WR2_FULL,
							RD2_EMPTY,						
							
							user_wr_full,
							eb_empty,
														
							ch1_control_reg[21:0]
							};
		end
	end	



endmodule
