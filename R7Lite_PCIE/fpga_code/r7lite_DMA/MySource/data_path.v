`timescale 1ns / 1ps

module data_path(
	//---------------channel data input-----------------------------------------
	input				[15:0]	din16,
	//---------------channel data output-----------------------------------------
	output			[31:0]	dout32,
	//---------------Register-----------------------------------------------------
	input				[31:0]	control_reg,
	output			[63:0]	freq_reg,
	output			[63:0]	total_size,
	//--------------Globe signal----------------------------------------------------
	input		data_path_rst,
	input		clk_50m,
	input		clk_pcie,
	input		adc_clk,
	//---------------Control-----------------------------------------------------
	input		ddr3_fifo_full,
	output	fifo_empty,	
	output	fifo_full,
	output	total_size_mannul_reset,
	
	output	fifo_rd_en
	 );	
	
	localparam BUFR_DIVIDE = 2;
	BUFR #(
      .BUFR_DIVIDE(BUFR_DIVIDE),      // "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8" 
      .SIM_DEVICE("7SERIES")  // Specify target device, "VIRTEX4" or "VIRTEX5" 
   ) BUFR_clkdiv (
      .O(clk_bufr),          // Clock buffer output
      .CE(1'b1),                // Clock enable input
      .CLR(1'b0),        // Clock buffer reset input
      .I(clk_pcie)                // Clock buffer input
   );	
assign	fifo_rd_en = control_reg[4] ? counter_fifo_rd_en : fifo16to32_rd_en; 
assign	fifo_empty = control_reg[4] ? counter_fifo_empty : fifo16to32_empty;
assign	fifo_full = control_reg[4] ? counter_fifo_full : fifo16to32_full;
//--------------内部寄存器-----------------------------------------------------------------------
	wire	[63:0]	freq_det_q_d,freq_det_q_c;
	reg	[63:0]	total_size_reg1;
	reg	[63:0]	total_size_reg2;
	wire	[31:0]	fifo16to32_dout;//16to32串并转换数据输出	
	wire	[31:0]	counter_data;//计数器数据
	wire	[31:0]	counter_fifo_dout;//计数器数据缓冲输出	
//--------------交织交换---------------------------------------------
assign	dout32 = control_reg[4] ? counter_fifo_dout : 
								(control_reg[5] ? fifo16to32_dout : 
								{fifo16to32_dout[7:0],fifo16to32_dout[15:8],
								fifo16to32_dout[23:16],fifo16to32_dout[31:24]});									
//--------------8 to 32---------------------------------------------------
wire	rec_en = control_reg[1] ? 1'b0 : control_reg[0];
assign	fifo16to32_rd_en = !fifo16to32_empty & !ddr3_fifo_full;
fifo8to32 fifo16to32_ch (
		  .rst(data_path_rst), 			
		  .wr_clk(adc_clk), 		
		  .rd_clk(clk_pcie), 	
		  .din(din16), 				
		  .wr_en(rec_en), 			
		  .rd_en(fifo16to32_rd_en),
		  .dout(fifo16to32_dout), 	
		  .full(fifo16to32_full), 	
		  .empty(fifo16to32_empty) 	
			);
//------------------------递增测试计数器----------------------------------------------
wire	counter_ce = control_reg[7] & control_reg[4] & rec_en;
assign	counter_fifo_rd_en = !counter_fifo_empty & !ddr3_fifo_full;

   COUNTER_LOAD_MACRO #(
      .COUNT_BY(48'h000000000001), 
      .DEVICE("7SERIES"), 				
      .WIDTH_DATA(32)     				
   ) counter32_ch (
      .Q(counter_data),  			
      .CLK(clk_bufr), 			
      .CE(counter_ce & (~data_path_rst)),   			
      .DIRECTION(1'b1), 				
      .LOAD(control_reg[18]),          				
      .LOAD_DATA(counter_load_data), 				
      .RST(data_path_rst)       			
   );
	
	counter_fifo counter_fifo_ch (
		.rst(data_path_rst), 			
		.wr_clk(clk_bufr), 	
		.rd_clk(clk_pcie), 	
		.din(counter_data), 			
		.wr_en(counter_ce & (~data_path_rst)), 		
		.rd_en(counter_fifo_rd_en),		
		.dout(counter_fifo_dout),			
		.full(counter_fifo_full), 		
		.empty(counter_fifo_empty)		
		);
//------------------------数据统计----------------------------------------------
assign	total_size_mannul_reset = control_reg[17];
assign	total_size = control_reg[4] ? total_size_reg2 : total_size_reg1;
always @(posedge c_div or posedge data_path_rst)begin
	if(data_path_rst)begin
		total_size_reg1 <= 64'b0;
		end
	else if(!rec_en | total_size_mannul_reset)begin
		total_size_reg1 <= 64'b0;
		end
	else begin
		total_size_reg1 <= total_size_reg1 + 64'd8;
		end
	end

always @(posedge clk_bufr or posedge data_path_rst)begin
	if(data_path_rst)begin
		total_size_reg2 <= 64'b0;
		end
	else if(!counter_ce | total_size_mannul_reset)begin
		total_size_reg2 <= 64'b0;
		end
	else begin
		total_size_reg2 <= total_size_reg2 + 64'd32;
		end
	end	

	
//------------------------频率检测----------------------------------------------
assign	freq_reg = control_reg[4] ? (freq_det_q_c<<3) : (freq_det_q_d<<3);	
Freq_Count_Top freq_det_d (
	 .sys_clk_50m(clk_50m), 
	 .ch_c(c_div), 
	 .freq_reg(freq_det_q_d), 
	 .sys_rst_n(~data_path_rst)
	 );

Freq_Count_Top freq_det_c (
	 .sys_clk_50m(clk_50m), 
	 .ch_c(clk_bufr), 
	 .freq_reg(freq_det_q_c), 
	 .sys_rst_n(~data_path_rst)
	 );
	 

endmodule
