
module MIG_4Port	#(
	parameter C_DBUS_WIDTH           = 64,		//PCIe Data bus width
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

)
(
	//	FIFO Write Side 1
	input 	[31:0]  						WR1_DATA,         //Data input
	input										WR1,					//Write Request
	input		[ADDR_WIDTH-1:0]			WR1_ADDR,			//Write start address
	input		[ADDR_WIDTH-1:0]			WR1_MAX_ADDR,		//Write max address
	input		[31:0]						WR1_LENGTH,			//Write length
	input										WR1_LOAD,			//Write register load & fifo clear
	input										WR1_CLK,				//Write fifo clock
	output									WR1_FULL,			//Write fifo full
	output	[31:0]						WR1_USE,				//Write fifo usedw
	output									WR1_EMPTY,
	//	FIFO Write Side 2
	input   	[31:0]      				WR2_DATA,         
	input										WR2,					
	input		[ADDR_WIDTH-1:0]			WR2_ADDR,			
	input		[ADDR_WIDTH-1:0]			WR2_MAX_ADDR,		
	input		[31:0]						WR2_LENGTH,			
	input										WR2_LOAD,			
	input										WR2_CLK,				
	output									WR2_FULL,			
	output	[31:0]						WR2_USE,				
	output									WR2_EMPTY,
	//	FIFO Read Side 1
	output  	[C_DBUS_WIDTH-1:0]      RD1_DATA,         //Data output
	input										RD1,					//Read Request
	input		[ADDR_WIDTH-1:0]			RD1_ADDR,			//Read start address
	input		[ADDR_WIDTH-1:0]			RD1_MAX_ADDR,		//Read max address
	input		[31:0]						RD1_LENGTH,			//Read length
	input										RD1_LOAD,			//Read register load & fifo clear
	input										RD1_CLK,				//Read fifo clock
	output									RD1_EMPTY,			//Read fifo empty
	output	[31:0]						RD1_USE,				//Read fifo usedw
	input										RD1_DMA,
	output									RD1_FULL,
	
	//	FIFO Read Side 2
	output  	[C_DBUS_WIDTH-1:0]      RD2_DATA,          
	input										RD2,					
	input		[ADDR_WIDTH-1:0]			RD2_ADDR,			
	input		[ADDR_WIDTH-1:0]			RD2_MAX_ADDR,		
	input		[31:0]						RD2_LENGTH,			
	input										RD2_LOAD,			
	input										RD2_CLK,				
	output									RD2_EMPTY,			
	output	[31:0]						RD2_USE,				
	input										RD2_DMA,	
	output									RD2_FULL,
	
	output									WR1_RDEN,WR2_RDEN,RD1_WREN,RD2_WREN,
	output	reg	[1:0]					WR_MASK,				//Write port active mask
	output	reg	[1:0]					RD_MASK,				//Read port active mask
	output	reg							mWR_DONE,			//Flag write done, 1 pulse SDR_CLK
	output	reg							mRD_DONE,			//Flag read done, 1 pulse SDR_CLK
	output	reg							mWR,					//Internal WR edge capture
	output	reg							mRD,					//Internal RD edge capture
	
	
	input		[C_DBUS_WIDTH-1:0]		DMA_us_Length,
	input		[31:0]						CH0_DMA_SIZE,CH1_DMA_SIZE,
	
	output	reg	[ADDR_WIDTH-1:0]			mADDR,					//Internal address
	//	SDRAM Side
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
   output [ODT_WIDTH-1:0]                 ddr3_odt,
	
	input                                  sys_clk_i,
	
	input             							sys_clk_p,
	input             							sys_clk_n,
	
   input                                  sys_rst_n,
	input												eb_rst,
	input												pcie_clk,
	
	output	[31:0]								ch0_ddr3_use,ch1_ddr3_use,		//for pc status
	output	reg									ch0_ddr3_full,ch1_ddr3_full,	//for pc status
	output	reg									ch0_valid,ch1_valid,				//for pcie int
	
	output											init_calib_complete,
	output											ui_clk,								
	output											ui_clk_sync_rst,
	output											sys_clk_o								// for freq det 
	);

	localparam		BURST_BYTE 				= 8*1024;
	localparam		BURST_UIDATA_LEN		= BURST_BYTE>>5;//16KB---->512;1KB---->32
	localparam	 	BURST_ADDR_LEN			= BURST_UIDATA_LEN >> 1;
	
	wire	rst = (ui_clk_sync_rst | eb_rst) | (~init_calib_complete);
	
	wire												app_rdy;
	reg												app_en;
	reg	[2:0]										app_cmd;
	wire	[ADDR_WIDTH-1:0]						app_addr;//29bit
	wire												app_wdf_rdy;
	reg												app_wdf_wren;
	reg												app_wdf_end;
	wire	[(4*PAYLOAD_WIDTH)-1:0]				app_wdf_data;//256bit
	wire	[(4*PAYLOAD_WIDTH)/8-1:0]			app_wdf_mask=32'd0;//32bit
	wire												app_rd_data_valid;
	wire	[(4*PAYLOAD_WIDTH)-1:0]				app_rd_data;//256bit

//	Internal Registers/Wires

	//	Controller
//	reg	[ADDR_WIDTH-1:0]			mADDR;					//Internal address
	reg	[31:0]							mDATA_LENGTH;			//Internal length	
	reg	[31:0]						mADDR_LENGTH;			//Internal length
	
	reg	[ADDR_WIDTH-1:0]			rWR1_ADDR;				//Register write address				
	reg	[ADDR_WIDTH-1:0]			rWR1_MAX_ADDR;			//Register max write address				
	reg	[31:0]						rWR1_ADDR_LENGTH;		//Addr write length
	reg	[31:0]						rWR1_DATA_LENGTH;		//Data write length
	
	reg	[ADDR_WIDTH-1:0]			rWR2_ADDR;				//Register write address				
	reg	[ADDR_WIDTH-1:0]			rWR2_MAX_ADDR;			//Register max write address				
	reg	[31:0]						rWR2_ADDR_LENGTH;		//Addr write length
	reg	[31:0]						rWR2_DATA_LENGTH;		//Data write length
	
	reg	[ADDR_WIDTH-1:0]			rRD1_ADDR;				//Register read address
	reg	[ADDR_WIDTH-1:0]			rRD1_MAX_ADDR;			//Register max read address
	reg	[31:0]						rRD1_ADDR_LENGTH;		//Addr read length
	reg	[31:0]						rRD1_DATA_LENGTH;		//Data write length
	
	reg	[ADDR_WIDTH-1:0]			rRD2_ADDR;				//Register read address
	reg	[ADDR_WIDTH-1:0]			rRD2_MAX_ADDR;			//Register max read address
	reg	[31:0]						rRD2_ADDR_LENGTH;		//Addr read length
	reg	[31:0]						rRD2_DATA_LENGTH;		//Data write length
	
//	reg	[1:0]							WR_MASK;				//Write port active mask
//	reg	[1:0]							RD_MASK;				//Read port active mask
//	reg									mWR_DONE;			//Flag write done, 1 pulse SDR_CLK
//	reg									mRD_DONE;			//Flag read done, 1 pulse SDR_CLK
//	reg									mWR;					//Internal WR edge capture
//	reg									mRD;					//Internal RD edge capture
	wire  [(4*PAYLOAD_WIDTH)-1:0]   	mDATAIN1;         //Controller Data input 1
	wire  [(4*PAYLOAD_WIDTH)-1:0]   	mDATAIN2;         //Controller Data input 2
	
	//	FIFO Control
	wire	[9:0]							write_side_fifo_rusedw1;	
	wire	[9:0]							read_side_fifo_wusedw1;
	wire	[9:0]							write_side_fifo_rusedw2;
	wire	[9:0]							read_side_fifo_wusedw2;
	
  ddr3_ip #(
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
)	u_ddr3_ip
      (
// Memory interface ports
       .ddr3_addr                      (ddr3_addr),
       .ddr3_ba                        (ddr3_ba),
       .ddr3_cas_n                     (ddr3_cas_n),
       .ddr3_ck_n                      (ddr3_ck_n),
       .ddr3_ck_p                      (ddr3_ck_p),
       .ddr3_cke                       (ddr3_cke),
       .ddr3_ras_n                     (ddr3_ras_n),
       .ddr3_reset_n                   (ddr3_reset_n),
       .ddr3_we_n                      (ddr3_we_n),
       .ddr3_dq                        (ddr3_dq),
       .ddr3_dqs_n                     (ddr3_dqs_n),
       .ddr3_dqs_p                     (ddr3_dqs_p),
       .init_calib_complete            (init_calib_complete),
       .ddr3_cs_n                      (ddr3_cs_n),
       .ddr3_dm                        (ddr3_dm),
       .ddr3_odt                       (ddr3_odt),
// Application interface ports
       .app_addr                       (app_addr),//Input This input indicates the address for the current request.
       .app_cmd                        (app_cmd),//Input This input selects the command for the current request
																//001:READ      000:WRITE
       .app_en                         (app_en),//Input This is the active-High strobe for the app_addr[], app_cmd[2:0], 
																//app_sz, and app_hi_pri inputs
       .app_wdf_data                   (app_wdf_data),//Input This provides the data for write commands
       .app_wdf_end                    (app_wdf_end),//Input This active-High input indicates that the current clock cycle is 
																		//the last cycle of input data on app_wdf_data[].
		//The app_wdf_end signal must be used to indicate the end of a memor y write 
		//burst. For memory burst types of eight, the app_wdf_endsignal must be 
		//asserted on the second write data word.
       .app_wdf_wren                   (app_wdf_wren),//Input This is the active-High strobe for app_wdf_data[]
       .app_rd_data                    (app_rd_data),//Output This provides the output data from read commands.
       .app_rd_data_end                (app_rd_data_end),//Output This active-High output indicates that the current clock cycle is 
																			//the last cycle of output data on app_rd_data[].
       .app_rd_data_valid              (app_rd_data_valid),//Output This active-High output indicates that app_rd_data[] is valid.
       .app_rdy                        (app_rdy),//Output This output indicates that the UI is ready to accept commands. 
																 //If the signal is deasserted when app_en is enabled, the current app_cmd 
																 //and app_addr must be retried until app_rdy is asserted.
       .app_wdf_rdy                    (app_wdf_rdy),//Output This output indicates that the write data FIFO is ready to receive 
																	//data. Write data is accepted when app_wdf_rdy = 1'b1 and app_wdf_wren = 1'b1.
		//If app_wdf_rdy is deasserted, the user logic needs to hold app_wdf_wren and app_wdf_end High along with 
		//the valid app_wdf_data value until app_wdf_rdy is asserted.
																	
       .app_sr_req                     (1'b0),//Input This input is reserved and should be tied to 0
       .app_sr_active                  (app_sr_active),//Output This output is reserved
       .app_ref_req                    (1'b0),//Input This active-High input requests that a refresh command be issued to the DRAM
       .app_ref_ack                    (app_ref_ack),//Output This active-High outputindicates that the Memory Controller 
																		//has sent the requested refresh command to the PHY interface
       .app_zq_req                     (1'b0),//Input This active-High input requests that a ZQ calibration command be issued to the DRAM
       .app_zq_ack                     (app_zq_ack),//Output This active-High output indicates that the Memory Controller 
																		//has sent the requested ZQ calibration command to the PHY interface
       .ui_clk                         (ui_clk),//Output This UI clock must be a half or quarter of the DRAM clock.
       .ui_clk_sync_rst                (ui_clk_sync_rst),//Output This is the active-High UI reset.
      
       .app_wdf_mask                   (app_wdf_mask),//Input This provides the mask for app_wdf_data[]
// System Clock Ports
       .sys_clk_i                      (sys_clk_i),		 
		 .sys_clk_p								(sys_clk_p),
		 .sys_clk_n								(sys_clk_n),		 
       .sys_rst                        (sys_rst_n),
		 .sys_clk_o								(sys_clk_o)
       );

wr_fifo32to256 write_fifo1 (
  .rst					(rst), // input rst
  .wr_clk				(WR1_CLK), // input wr_clk
  .rd_clk				(ui_clk), // input rd_clk
  .din					(WR1_DATA), // input [31 : 0] din
  .wr_en					(WR1), // input wr_en
  .rd_en					(WR1_RDEN), // input rd_en
  .dout					(mDATAIN1), // output [255 : 0] dout
  .full					(WR1_FULL), // output full
  .empty					(WR1_EMPTY), // output empty
							//reports the number of words available for reading  
  .rd_data_count		(write_side_fifo_rusedw1), // output [9 : 0] rd_data_count	
							//reports the number of words written into the FIFO
  .wr_data_count		(WR1_USE) // output [12 : 0] wr_data_count
);
assign	WR1_RDEN = 	app_wdf_wren & app_wdf_rdy & WR_MASK[0];

wr_fifo32to256 write_fifo2 (
  .rst					(rst), // input rst
  .wr_clk				(WR2_CLK), // input wr_clk
  .rd_clk				(ui_clk), // input rd_clk
  .din					(WR2_DATA), // input [31 : 0] din
  .wr_en					(WR2), // input wr_en
  .rd_en					(WR2_RDEN), // input rd_en
  .dout					(mDATAIN2), // output [255 : 0] dout
  .full					(WR2_FULL), // output full
  .empty					(WR2_EMPTY), // output empty
  .rd_data_count		(write_side_fifo_rusedw2), // output [9 : 0] rd_data_count
  .wr_data_count		(WR2_USE) // output [12 : 0] wr_data_count
);
assign	WR2_RDEN = 	app_wdf_wren & app_wdf_rdy & WR_MASK[1];
				
assign	app_wdf_data	=	(WR_MASK[0]) ?	mDATAIN1	: mDATAIN2	;

rd_fifo_256to64 read_fifo1 (
  .rst					(rst), // input rst
  .wr_clk				(ui_clk), // input wr_clk
  .rd_clk				(RD1_CLK), // input rd_clk
  .din					(app_rd_data), // input [255 : 0] din
  .wr_en					(RD1_WREN), // input wr_en
  .rd_en					(RD1), // input rd_en
  .dout					(RD1_DATA), // output [63 : 0] dout
  .full					(RD1_FULL), // output full
  .empty					(RD1_EMPTY), // output empty
  .prog_full			(RD1_prog_full), // output prog_full
  .rd_data_count		(RD1_USE), // output [11 : 0] rd_data_count
  .wr_data_count		(read_side_fifo_wusedw1) // output [9 : 0] wr_data_count
);
assign RD1_WREN = app_rd_data_valid & RD_MASK[0];

rd_fifo_256to64 read_fifo2 (
  .rst					(rst), // input rst
  .wr_clk				(ui_clk), // input wr_clk
  .rd_clk				(RD2_CLK), // input rd_clk
  .din					(app_rd_data), // input [255 : 0] din
  .wr_en					(RD2_WREN), // input wr_en
  .rd_en					(RD2), // input rd_en
  .dout					(RD2_DATA), // output [63 : 0] dout
  .full					(RD2_FULL), // output full
  .empty					(RD2_EMPTY), // output empty
  .prog_full			(RD2_prog_full), // output prog_full
  .rd_data_count		(RD2_USE), // output [11 : 0] rd_data_count
  .wr_data_count		(read_side_fifo_wusedw2) // output [9 : 0] wr_data_count
);
assign RD2_WREN = app_rd_data_valid & RD_MASK[1];

reg	[31:0]	ch0_ddr3_use_reg,ch1_ddr3_use_reg;
always @(posedge ui_clk or posedge rst)begin
	if(rst)begin
		ch0_ddr3_use_reg <= 0;
		end
	else begin
		if(WR1_RDEN) begin//256bit per clk
			ch0_ddr3_use_reg <= ch0_ddr3_use_reg + 1'b1;
			end
		if(RD1_WREN)begin//256bit per clk
			ch0_ddr3_use_reg <= ch0_ddr3_use_reg - 1'b1;
			end
		end
	end
assign	ch0_ddr3_use = ch0_ddr3_use_reg<<5;

always @(posedge ui_clk or posedge rst)begin
	if(rst)begin
		ch1_ddr3_use_reg <= 0;
		end
	else begin
		if(WR2_RDEN) begin//256bit per clk
			ch1_ddr3_use_reg <= ch1_ddr3_use_reg + 1'b1;
			end
		if(RD2_WREN)begin//256bit per clk
			ch1_ddr3_use_reg <= ch1_ddr3_use_reg - 1'b1;
			end
		end
	end
assign	ch1_ddr3_use = ch1_ddr3_use_reg<<5;

always @(posedge ui_clk or posedge rst)begin
	if(rst)begin
		ch0_valid <= 1'b0;
		end
	else begin
		if(ch0_ddr3_use > CH0_DMA_SIZE)begin//DMA_us_Length
			ch0_valid <= 1'b1;
			end
		else begin
			ch0_valid <= 1'b0;
			end			
		end
	end


always @(posedge ui_clk or posedge rst)begin
	if(rst)begin
		ch1_valid <= 1'b0;
		end
	else begin			
		if(ch1_ddr3_use > CH1_DMA_SIZE)begin//DMA_us_Length
			ch1_valid <= 1'b1;
			end
		else begin
			ch1_valid <= 1'b0;
			end			
		end
	end
	
	
always @(posedge ui_clk or posedge rst)begin
	if(rst)begin
		ch0_ddr3_full <= 1'b0;
		ch1_ddr3_full <= 1'b0;
		end
	else begin
		if(ch0_ddr3_use == 32'h7FFFFFFF)begin//2^31 = 2GB
			ch0_ddr3_full <= 1'b1;
			end
		if(ch1_ddr3_use == 32'h7FFFFFFF)begin
			ch1_ddr3_full <= 1'b1;
			end
		end
	end
	
//	Internal Address & Length Control
always@(posedge ui_clk or posedge rst)begin
	if(rst)	begin
		rWR1_ADDR		<=	29'h0;
		rWR1_MAX_ADDR	<=	29'h0FFF_FFFF;
		rWR2_ADDR		<=	29'h1000_0000;
		rWR2_MAX_ADDR	<=	29'h1FFF_FFFF;
		rRD1_ADDR		<=	29'h0;
		rRD1_MAX_ADDR	<=	29'h0FFF_FFFF;
		rRD2_ADDR		<=	29'h1000_0000;
		rRD2_MAX_ADDR	<=	29'h1FFF_FFFF;
		rWR1_ADDR_LENGTH		<=	BURST_ADDR_LEN;					//parameter this for PC
		rWR2_ADDR_LENGTH		<=	BURST_ADDR_LEN;
		rRD1_ADDR_LENGTH		<=	BURST_ADDR_LEN;
		rRD2_ADDR_LENGTH		<=	BURST_ADDR_LEN;
		end
	else	begin
		//	Write Side 1
		if(WR1_LOAD)begin					//reload the mem base addr
			rWR1_ADDR	<=	WR1_ADDR;
			rWR1_ADDR_LENGTH	<=	WR1_LENGTH;	
			end
		else if(mWR_DONE & WR_MASK[0])begin
			if(rWR1_ADDR < rWR1_MAX_ADDR - (rWR1_ADDR_LENGTH<<3))	//enough space in ddr3 to write in
				rWR1_ADDR <= rWR1_ADDR + (rWR1_ADDR_LENGTH<<3);		//next write base addr
			else 
				rWR1_ADDR <= WR1_ADDR;//roll back to the first base write addr when the mem write full
			end
			
		//	Write Side 2
		if(WR2_LOAD)begin
			rWR2_ADDR	<=	WR2_ADDR;
			rWR2_ADDR_LENGTH	<=	WR2_LENGTH;
			end
		else if(mWR_DONE & WR_MASK[1])	begin
			if(rWR2_ADDR < rWR2_MAX_ADDR - (rWR2_ADDR_LENGTH<<3))
				rWR2_ADDR <= rWR2_ADDR + (rWR2_ADDR_LENGTH<<3);
			else
				rWR2_ADDR <= WR2_ADDR;
			end
			
		//	Read Side 1
		if(RD1_LOAD)		begin	
			rRD1_ADDR	<=	RD1_ADDR;
			rRD1_ADDR_LENGTH	<=	RD1_LENGTH;
			end
		else if(mRD_DONE & RD_MASK[0])		begin
			if(rRD1_ADDR < rRD1_MAX_ADDR - (rRD1_ADDR_LENGTH<<3))
				rRD1_ADDR	<=	rRD1_ADDR + (rRD1_ADDR_LENGTH<<3);
			else
				rRD1_ADDR	<=	RD1_ADDR;
			end
			
		//	Read Side 2
		if(RD1_LOAD)	begin
			rRD2_ADDR	<=	RD2_ADDR;
			rRD2_ADDR_LENGTH	<=	RD2_LENGTH;
		end
		else if(mRD_DONE & RD_MASK[1])		begin
			if(rRD2_ADDR < rRD2_MAX_ADDR - (rRD2_ADDR_LENGTH<<3))
				rRD2_ADDR	<=	rRD2_ADDR + (rRD2_ADDR_LENGTH<<3);
			else
				rRD2_ADDR	<=	RD2_ADDR;
			end
		end
	end

//	Auto Read/Write Control
always@(posedge ui_clk or posedge rst)begin
	if(rst)	begin
		WR_MASK	<=	2'b00;
		RD_MASK	<=	2'b00;
		mWR		<=	0;
		mRD		<=	0;		
		mADDR		<=	0;
		mDATA_LENGTH	<=	0;
		mADDR_LENGTH	<=	0;
		rWR1_DATA_LENGTH		<= BURST_UIDATA_LEN;
		rWR2_DATA_LENGTH		<= BURST_UIDATA_LEN;
		rRD1_DATA_LENGTH		<= BURST_UIDATA_LEN;
		rRD2_DATA_LENGTH		<= BURST_UIDATA_LEN;
	end
	else	begin
		if((mWR==0) && (mRD==0) && (WR_MASK==0)	&&	(RD_MASK==0) &&
			(WR1_LOAD==0)	&&	(RD1_LOAD==0) &&	(WR2_LOAD==0)	&&	(RD2_LOAD==0) )
		begin
			//	Write Side 1
			if((write_side_fifo_rusedw1 >= rWR1_DATA_LENGTH) )//&& (write_side_fifo_rusedw1 > write_side_fifo_rusedw2)
			begin
				mADDR	<=	rWR1_ADDR;
				mDATA_LENGTH	<=	rWR1_DATA_LENGTH;
				mADDR_LENGTH	<=	rWR1_ADDR_LENGTH;
				WR_MASK	<=	2'b01;
				RD_MASK	<=	2'b00;
				mWR		<=	1;
				mRD		<=	0;
			end
			//	Write Side 2
			else if(write_side_fifo_rusedw2 >= rWR2_DATA_LENGTH)
			begin
				mADDR	<=	rWR2_ADDR;
				mDATA_LENGTH	<=	rWR2_DATA_LENGTH;
				mADDR_LENGTH	<=	rWR2_ADDR_LENGTH;
				WR_MASK	<=	2'b10;
				RD_MASK	<=	2'b00;
				mWR		<=	1;
				mRD		<=	0;
			end
			//	Read Side 1
			//else if(RD1_DMA && (read_side_fifo_wusedw1 < rRD1_DATA_LENGTH) && (ch0_ddr3_use >= rRD1_DATA_LENGTH))
			else if(~RD1_prog_full && (ch0_ddr3_use_reg >= rRD1_DATA_LENGTH))
			begin
				mADDR	<=	rRD1_ADDR;
				mDATA_LENGTH	<=	rRD1_DATA_LENGTH;
				mADDR_LENGTH	<=	rRD1_ADDR_LENGTH;
				WR_MASK	<=	2'b00;
				RD_MASK	<=	2'b01;
				mWR		<=	0;
				mRD		<=	1;				
			end
			//	Read Side 2
			//else if(RD2_DMA &&  (read_side_fifo_wusedw2 < rRD2_DATA_LENGTH)  && (ch1_ddr3_use >= rRD2_DATA_LENGTH))
			else if(~RD2_prog_full && (ch1_ddr3_use_reg >= rRD2_DATA_LENGTH))//----------need to changed
			begin
				mADDR	<=	rRD2_ADDR;
				mDATA_LENGTH	<=	rRD2_DATA_LENGTH;
				mADDR_LENGTH	<=	rRD2_ADDR_LENGTH;
				WR_MASK	<=	2'b00;
				RD_MASK	<=	2'b10;
				mWR		<=	0;
				mRD		<=	1;
			end
		end
		
		if(mWR_DONE)	begin
			WR_MASK	<=	0;
			mWR		<=	0;
			end
			
		if(mRD_DONE)	begin
			RD_MASK	<=	0;
			mRD		<=	0;
			end
	end
end

	reg 	[ADDR_WIDTH-1:0] 			tg_addr_wr,tg_addr_rd;
	reg	[4:0]		state;
	reg	[25:0] 	burst_len_wr,burst_len_rd;
	reg				write_data_end,write_data_start;		
	reg				read_data_end;
	
	assign	app_addr = app_cmd[0] ? tg_addr_rd : tg_addr_wr;
	
	always @ (posedge	ui_clk or posedge rst)begin
		if(rst)	begin
			app_cmd<=3'd0;
			app_en<=1'b0;
			tg_addr_wr<=29'd0;
			tg_addr_rd<=29'd0;
			state<=5'd0;
			burst_len_wr<=26'd0;
			burst_len_rd<=26'd0;
			write_data_start<=1'b0;
			end
		else begin
			case(state)
			
				5'd0:	begin
					if(init_calib_complete) begin
						state<=5'd1;
						end
					else begin
						state<=5'd0;
						end
					end
					
				5'd1: begin//write pre-start	
					if(app_rdy & mWR) begin 
						write_data_start <= 1'b1;
						state <= 5'd2;
						tg_addr_wr <= mADDR;
						burst_len_wr <= mADDR_LENGTH-1;
						end
					else if(app_rdy & mRD) begin
						state <= 5'd5;
						tg_addr_rd <= mADDR;
						burst_len_rd <= mADDR_LENGTH-1;
						end
					else begin state<=5'd1; end
					end
					
				5'd2: begin//write start				
					if(app_rdy) begin	app_cmd<=3'd0;	app_en<=1'b1;	state<=5'd3;end
					else begin	state<=5'd2;app_en<=1'b0;end
					end
					
				5'd3: begin
					if(app_rdy)	begin
						tg_addr_wr <= tg_addr_wr + 29'd8;
						if(burst_len_wr != 0) begin	burst_len_wr <= burst_len_wr - 1'b1;	state<=5'd3;	app_en<=1'b1;end
						else begin write_data_start<=1'b0;	burst_len_wr<=26'd0; state<=5'd4; app_en<=1'b0; end
						end
					else begin	app_en<=1'b1;	state<=5'd3;end
					end
					
				5'd4: begin//wait	write	data end					
					if(write_data_end) begin state<=5'd1;end
					else begin state<=5'd4;end
					end
					
				5'd5: begin//read
					if(app_rdy) begin	app_cmd<=3'd1; app_en<=1'b1; state<=5'd6;end
					else begin	app_en<=1'b0; state<=5'd5;end
					end
					
				5'd6: begin
					if(app_rdy)begin
						tg_addr_rd <= tg_addr_rd + 29'd8;
						if(burst_len_rd != 0)
							begin	burst_len_rd <= burst_len_rd - 1'b1; app_en <= 1'b1; state <= 5'd6; end
						else begin burst_len_rd<=26'd0; app_en<=1'b0; state<=5'd7; end
						end
					else begin	app_en<=1'b1;state<=5'd6;end
					end
				5'd7: begin//wait	read	data end					
					if(read_data_end) begin state<=5'd1;end
					else begin state<=5'd7;end
					end
					
				default:begin
					app_cmd<=3'd0;
					app_en<=1'b0;
					tg_addr_wr<=29'd0;
					tg_addr_rd<=29'd0;
					state<=5'd0;
					burst_len_wr<=26'd0;
					burst_len_rd<=26'd0;
					write_data_start<=1'b0;
					end
				endcase
			end
		end

		//data wr control
	reg	[25:0] 	write_cnt;
	reg	[4:0]		state_wr;
	always @ (posedge	ui_clk	or posedge rst)begin
		if(rst)begin
			app_wdf_wren<=1'b0;
			app_wdf_end<=1'b0;
			write_cnt<=26'd0;
			state_wr<=5'd0;
			write_data_end<=1'b0;
			mWR_DONE	<=	0;
			end
		else begin
			case(state_wr)
				5'd0: begin 
					if(init_calib_complete) begin	state_wr<=5'd1;end
					end
				5'd1: begin
					if(write_data_start) begin write_data_end<=1'b0;state_wr<=5'd2; end
					else begin	state_wr<=5'd1;end
					end
				5'd2: begin 
					if(app_wdf_rdy) begin app_wdf_wren<=1'b1;state_wr<=5'd3;end
					else begin app_wdf_wren<=1'b0;state_wr<=5'd2;end
					end
				5'd3: begin
					if(app_wdf_rdy) begin						
						app_wdf_end <= ~app_wdf_end;
						if(write_cnt != mDATA_LENGTH-1) begin
							app_wdf_wren<=1'b1;
							write_cnt<=write_cnt+1'b1;
							state_wr<=5'd3;
							end
						else begin
							write_cnt<=26'd0;
							app_wdf_wren<=1'b0;
							state_wr<=5'd4;
							write_data_end<=1'b1;
							mWR_DONE <= 1'b1;
							end
						end
					else begin
						app_wdf_wren<=1'b1;state_wr<=5'd3;
						end
					end
				5'd4: begin//wait for wr cmd to complete
					if(!write_data_start) begin 
						mWR_DONE <= 1'b0;
						write_data_end <= 1'b0;
						state_wr<=5'd1;
						end
					else begin 	state_wr<=5'd4;end
					end
				default: begin
					app_wdf_wren<=1'b0;
					app_wdf_end<=1'b0;
					write_cnt<=26'd0;
					state_wr<=5'd0;
					write_data_end<=1'b0;
					end
				endcase
			end
		end	

		//data rd control
	reg	[25:0] 	read_cnt;
	always @ (posedge	ui_clk	or posedge rst)begin
		if(rst)begin
			read_cnt<=26'd0;
			read_data_end<=1'b0;
			mRD_DONE	<=	0;
			end
		else if(init_calib_complete & app_rd_data_valid)begin
			if(read_cnt != mDATA_LENGTH-1) begin
				read_cnt<=read_cnt+1'b1;
				read_data_end<=1'b0;
				end
			else begin
				read_cnt<=26'd0;
				read_data_end<=1'b1;
				mRD_DONE <= 1'b1;
				end
			end
		else begin
			mRD_DONE	<=	0;
			read_data_end<=1'b0;
			end
	end

endmodule
