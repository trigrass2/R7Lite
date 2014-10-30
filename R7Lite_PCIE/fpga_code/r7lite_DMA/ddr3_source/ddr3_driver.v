`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:05 03/04/2014 
// Design Name: 
// Module Name:    ddr3_driver 
// Project Name: 
// Target Devices: 
// Tool versions: 
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
module ddr3_driver #(
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
	input                                  sys_clk_p,
	input                                  sys_clk_n,

   input                                  key_rst_n,	
	output [3:0] 									led
	);

	wire														ui_clk;
	wire														ui_clk_sync_rst;
	wire														rst = ~ui_clk_sync_rst & init_calib_complete;
	wire														init_calib_complete;
			
	wire														app_rdy;
	reg														app_en;
	reg	[2:0]												app_cmd;
	wire	[ADDR_WIDTH-1:0]								app_addr;//29bit
	wire														app_wdf_rdy;
	reg														app_wdf_wren;
	reg														app_wdf_end;
	wire	[(nCK_PER_CLK*2*PAYLOAD_WIDTH)-1:0]		app_wdf_data;//256bit
	wire	[(nCK_PER_CLK*2*PAYLOAD_WIDTH)/8-1:0]	app_wdf_mask=32'd0;//32bit
	wire														app_rd_data_valid;
	wire	[(nCK_PER_CLK*2*PAYLOAD_WIDTH)-1:0]		app_rd_data;//256bit

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
       .sys_clk_p                      (sys_clk_p),
		 .sys_clk_n                      (sys_clk_n),	 
	 
       .sys_rst                        (key_rst_n),
		 .sys_clk_o								(sys_clk_o),
		 .mmcm_locked							(mmcm_locked),
		 .pll_locked							(pll_locked)
       );
		
	//cmd	fifo
	parameter	BURST_LEN	= 32;	//addr number
	parameter	UI_BURST_LEN= BURST_LEN<<1;//8*8 64bit=8*2 256bit//data number
	reg 	[25:0] 	tg_addr_wr,tg_addr_rd;
	reg	[4:0]		state;
	reg	[25:0] 	burst_len_wr,burst_len_rd;
	reg				write_data_end,write_data_start;
	assign app_addr = (state < 5'd5) ? {tg_addr_wr,3'b0} : {tg_addr_rd,3'b0};
	
	always @ (posedge	ui_clk or posedge ui_clk_sync_rst)begin
		if(ui_clk_sync_rst)	begin
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
					if(init_calib_complete) begin	state<=5'd1;	end
					else begin end
					end
				5'd1: begin//write pre-start				
					if(app_rdy && (rd_data_count >= UI_BURST_LEN)) begin write_data_start <= 1'b1;	state <= 5'd2;	end
					else begin end
					end
				5'd2: begin//write start				
					if(app_rdy) begin	app_cmd<=3'd0;	app_en<=1'b1;	state<=5'd3;end
					else begin	state<=5'd2;app_en<=1'b0;end
					end
				5'd3: begin
					if(app_rdy)	begin
						tg_addr_wr<=tg_addr_wr+29'd1;
						if(burst_len_wr != BURST_LEN-1) begin	burst_len_wr<=burst_len_wr+1'b1;	state<=5'd3;	app_en<=1'b1;end
						else begin write_data_start<=1'b0;	burst_len_wr<=26'd0; state<=5'd4; app_en<=1'b0; end
						end
					else begin	app_en<=1'b1;	state<=5'd3;end
					end
				5'd4: begin//wait	write	data end					
					if(write_data_end) begin state<=5'd5;end
					else begin state<=5'd4;end
					end
				5'd5: begin//read
					if(app_rdy) begin	app_cmd<=3'd1; app_en<=1'b1; state<=5'd6;end
					else begin	app_en<=1'b0; state<=5'd5;end
					end
				5'd6: begin
					if(app_rdy)begin
						tg_addr_rd<=tg_addr_rd+29'd1;
						if(burst_len_rd != BURST_LEN-1)
							begin	burst_len_rd<=burst_len_rd+1'b1; app_en<=1'b1; state<=5'd6; end
						else begin burst_len_rd<=26'd0; app_en<=1'b0; state<=5'd1; end
						end
					else begin	app_en<=1'b1;state<=5'd6;end
					end
				endcase
			end
		end
		
		//data wr fifo
	reg	[25:0] 	write_cnt;
	reg	[4:0]		state_wr;
	always @ (posedge	ui_clk or posedge ui_clk_sync_rst)begin
		if(ui_clk_sync_rst)begin
			app_wdf_wren<=1'b0;
			app_wdf_end<=1'b0;
			write_cnt<=26'd0;
			state_wr<=5'd0;
			write_data_end<=1'b0;
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
						app_wdf_end<=~app_wdf_end;
						if(write_cnt != UI_BURST_LEN-1)begin
							app_wdf_wren<=1'b1;
							write_cnt<=write_cnt+1'b1;
							state_wr<=5'd3;
							end
						else begin
							write_cnt<=26'd0;
							app_wdf_wren<=1'b0;
							state_wr<=5'd4;
							write_data_end<=1'b1;
							end
						end
					else begin
						app_wdf_wren<=1'b1;
						state_wr<=5'd3;
						end
					end
				5'd4: begin
					if(!write_data_start) begin state_wr<=5'd1;end
					else begin	state_wr<=5'd4;end
					end
				endcase
			end
		end	
		
	//rd data	compare
	reg	[31:0]	data_rd_cmp;
	reg	good,error;
	
	always @ (posedge	ui_clk or negedge rst)begin
		if(!rst) begin
			data_rd_cmp<=32'd0;
			good<=1'b0;
			error<=1'b0;
			end
		else begin
			if(~rd_fifo_empty) begin
				data_rd_cmp<=data_rd_cmp+1'b1;
				end
			else begin end
			
			if(rd_fifo_dout != data_rd_cmp -9)begin
				error<=1'b1; good<=1'b0;
				end
			else begin
				good<=1'b1;	error<=1'b0;
				end
			end
		end

	reg	[31:0]	pattern;
	always @ (posedge	sys_clk_o or negedge rst)begin
		if(!rst) begin
			pattern <= 32'b0;
			end
		else	if(~wr_fifo_full)begin
			pattern <= pattern + 1'b1;
			end
		else begin
			pattern <= pattern;
			end
		end
	
	

	wire 	[6:0]	rd_data_count;
	wire	[9:0]	wr_data_count;	
	wr_fifo wr_fifo_inst (
	  .rst(!rst), // input rst
	  .wr_clk(sys_clk_o), // input wr_clk
	  .rd_clk(ui_clk), // input rd_clk
	  .din(pattern), // input [31 : 0] din
	  .wr_en(~wr_fifo_full), // input wr_en
	  .rd_en(app_wdf_wren & app_wdf_rdy), // input rd_en
	  .dout(app_wdf_data), // output [255 : 0] dout
	  .full(wr_fifo_full), // output full
	  .empty(wr_fifo_empty), // output empty
	  .rd_data_count(rd_data_count), // output [6 : 0] rd_data_count
	  .wr_data_count(wr_data_count) // output [9 : 0] wr_data_count
	);

	wire 	[11:0]	rd_fifo_rd_data_count;
	wire	[9:0]		rd_fifo_wr_data_count;	
	wire	[31:0]	rd_fifo_dout;
	rd_fifo rd_fifo_inst (
	  .rst(!rst), // input rst
	  .wr_clk(ui_clk), // input wr_clk
	  .rd_clk(ui_clk), // input rd_clk
	  .din(app_rd_data), // input [255 : 0] din
	  .wr_en(app_rd_data_valid), // input wr_en
	  .rd_en(~rd_fifo_empty), // input rd_en
	  .dout(rd_fifo_dout), // output [31 : 0] dout
	  .full(rd_fifo_full), // output full
	  .empty(rd_fifo_empty), // output empty
	  .rd_data_count(rd_fifo_rd_data_count), // output [11 : 0] rd_data_count
	  .wr_data_count(rd_fifo_wr_data_count), // output [9 : 0] wr_data_count
	  .prog_full(rd_fifo_prog_full) // output prog_full
	);
		
	assign led[0] = good;				
	assign led[1] = error;				
	assign led[2] = init_calib_complete;	
	assign led[3] = ui_clk_sync_rst;	

//wire	[35:0]	CONTROL0;	
//ddr3_icon ddr3_icon_inst (
//    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
//);
//ddr3_ila ddr3_ila_inst (
//    .CONTROL(CONTROL0), // INOUT BUS [35:0]
//    .CLK(ui_clk), // IN
//    .TRIG0(app_addr), // IN BUS [31:0]
//	 .TRIG1(tg_addr_wr), // IN BUS [31:0]
//    .TRIG2(tg_addr_rd), // IN BUS [31:0]
//    .TRIG3(app_cmd), // IN BUS [7:0]
//    .TRIG4(app_wdf_data), // IN BUS [255:0]
//	 .TRIG5(app_rd_data), // IN BUS [255:0]
//    .TRIG6(data_nstate), // IN BUS [15:0]	 
//    .TRIG7(addr_burst_count), // IN BUS [31:0]
//    .TRIG8(mem_usedw), // IN BUS [31:0]
//    .TRIG9(rd_data_count), // IN BUS [15:0]
//    .TRIG10(addr_nstate), // IN BUS [7:0]
//	 .TRIG11(data_rd_cmp), // IN BUS [63:0]
//    .TRIG12(rd_fifo_dout), // IN BUS [63:0]	 
//    .TRIG13({	
//				rd_fifo_wren,
//				init_calib_complete,//12
//				ui_clk_sync_rst,	
//				wr_fifo_empty,		//10		
//				wr_fifo_full,//9
//				rd_fifo_full,//8
//				rd_fifo_empty,//7
//				app_rd_data_end,//6
//				app_rd_data_valid,//5
//				app_wdf_end,//4
//				app_wdf_wren,//3
//				app_wdf_rdy,//2
//				app_rdy,
//				app_en
//				}), // IN BUS [15:0]
//	 .TRIG14(app_wdf_data), // IN BUS [31:0]
//	 .TRIG15(app_rd_data) // IN BUS [31:0]
//);



endmodule		