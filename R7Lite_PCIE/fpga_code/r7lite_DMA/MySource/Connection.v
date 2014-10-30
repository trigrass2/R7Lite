`timescale 1ns / 1ps

module Connection(
	input							user_clk, 
	input 						sys_rst_n,
			
	input							dma_host2board_busy,
	input							dma_host2board_done,
			
	output	reg				CH0_irq, CH1_irq,
	output						TEMP_irq,
	output	reg				CH0TOUT_irq, CH1TOUT_irq,
	output						TEMPTOUT_irq,
	
	input	[63:0]				Sys_Int_Enable,
	input	[31:0]				DMA_us_Length,
	input	[31:0]				DMA_us_PA,
	input							DMA_us_Busy,	

	input	[31:0]				DMA_ds_Length,
	input	[31:0]				DMA_ds_PA,
	input							DMA_ds_Busy,	
	
	//pcie fifo read side
	input	[14:0]				fifo_rd_count,
	input							fifo_rd_empty,
	input							fifo_rd_pempty,
	input							fifo_rd_valid,
	output	reg				fifo_rd_en,
	input		[63:0]			fifo_rd_dout, 	
	//pcie fifo write side
	input		[14:0]			fifo_wr_count, 
	input							fifo_wr_full,
	input							fifo_wr_pfull,
	output	reg				fifo_wr_en, 
	output	reg [63:0]		fifo_wr_din,
	
	//pcie dpram port
	output	reg	[11:0]	bram_rd_addr, 
	output	reg	[11:0]	bram_wr_addr, 
	output	reg	[63:0]	bram_wr_din,
	output	reg	[7:0]		bram_wr_en,
	input		[63:0]			bram_rd_dout,	
	
	//DAQ ch input
	input		[31:0]			ch0_fifo_dout,
	input							ch0_fifo_empty,
	input		[31:0]			ch1_fifo_dout,
	input							ch1_fifo_empty,		
		
	//	FIFO Write Side 1
	output 	reg	[31:0]  			WR1_DATA,         //Data input
	output						WR1,					//Write Request
	input							WR1_FULL,			//Write fifo full
	input		[31:0]			WR1_USE,				//Write fifo usedw
	input							WR1_EMPTY,
	//	FIFO Write Side 2
	output  	reg	[31:0]      	WR2_DATA,         
	output						WR2,			
	input							WR2_FULL,			
	input		[31:0]			WR2_USE,				
	input							WR2_EMPTY,	
	
	//	FIFO Read Side 1	
	input  	[63:0]   		RD1_DATA,         //Data output
	output						RD1,					//Read Request
	input							RD1_EMPTY,			//Read fifo empty
	input		[11:0]			RD1_USE,				//Read fifo usedw
	output						RD1_DMA,
		
	//	FIFO Read Side 2	
	input  	[63:0]   		RD2_DATA,          
	output						RD2,
	input							RD2_EMPTY,			
	input		[11:0]			RD2_USE,				
	output						RD2_DMA,
		
	input		[31:0]			debug_in_1i, debug_in_2i, debug_in_3i,debug_in_4i, 	 
			
	input		[31:0]			reg01_td,reg02_td,reg03_td,reg04_td,reg05_td,reg06_td,reg07_td,reg08_td,reg09_td,reg10_td,
									reg11_td,reg12_td,reg13_td,reg14_td,reg15_td,reg16_td,reg17_td,reg18_td,reg19_td,reg20_td,
									reg21_td,reg22_td,reg23_td,reg24_td,reg25_td,
	input		[24:0]			reg_tv,

	output	[31:0]			reg01_rd,reg02_rd,reg03_rd,reg04_rd,reg05_rd,reg06_rd,reg07_rd,reg08_rd,reg09_rd,reg10_rd,
									reg11_rd,reg12_rd,reg13_rd,reg14_rd,reg15_rd,reg16_rd,reg17_rd,reg18_rd,reg19_rd,reg20_rd,
									reg21_rd,reg22_rd,reg23_rd,reg24_rd,reg25_rd,
	output	reg	[24:0]	reg_rv,

	output	reg	[31:0]	ch0_control_reg,ch1_control_reg,
	output	reg	[31:0]	ch0_dmasize_reg,ch1_dmasize_reg,
	input		[31:0]			ch0_status_reg,ch1_status_reg,
	input		[63:0]			ch0_freq_reg,ch1_freq_reg,

	input		[63:0]			ch0_total_size,ch1_total_size,
			
	input		[31:0]			ch0_ddr3_use,ch1_ddr3_use,
	input							ch0_valid,ch1_valid,

	input							ch0_total_size_mannul_reset,

	input							ch1_total_size_mannul_reset	

);

localparam	C_INT_TIME_OUT_VALUE = 32'd250_000_000;//2s @ 125MHz, for 4Mbps data rate, 1s means 512KB

//---------------us DMA FIFO Read Control-----------------------------------------------------
reg	RD1_reg,RD2_reg;//local reg for Ch data read fifo en

assign	RD1_DMA = (~ch0_control_reg[1] & (DMA_us_PA[31:28] == 4'h1) & DMA_us_Busy);
assign	RD2_DMA = (~ch1_control_reg[1] & (DMA_us_PA[31:28] == 4'h2) & DMA_us_Busy);
assign	RD1 = ~fifo_wr_full & RD1_reg & !RD1_EMPTY;	 
assign	RD2 = ~fifo_wr_full & RD2_reg & !RD2_EMPTY;

//assign	fifo_wr_din = RD1 ? RD1_DATA : RD2 ? RD2_DATA : fifo_wr_din;
//assign	fifo_wr_en = RD1 | RD2;
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		fifo_wr_din <= 64'b0;
		end
	else begin
		case({RD1,RD2})
			2'b10: fifo_wr_din <= RD1_DATA;
			2'b01: fifo_wr_din <= RD2_DATA;
			default:fifo_wr_din <= fifo_wr_din;
		endcase
	end
end	
		
		
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		fifo_wr_en <= 1'b0;
		end
	else begin
		fifo_wr_en <= RD1 | RD2;
		end
	end
	

reg	[31:0]	us_transfer_count1,us_transfer_count2;
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		us_transfer_count1 <= 32'b0;
		RD1_reg <= 1'b0;
		end
	else if(RD1_DMA)begin	
		if(~fifo_wr_full & !RD1_EMPTY)begin
			if(us_transfer_count1 != (ch0_dmasize_reg>>3))begin//DMA_us_Length is in BYTE, fifo width is QDWORD               
				us_transfer_count1 <= us_transfer_count1 + 1'b1;
				RD1_reg <= 1'b1;
				end
			else begin
				us_transfer_count1 <= us_transfer_count1;
				RD1_reg <= 1'b0;
				end
			end
		else begin
			us_transfer_count1 <= us_transfer_count1;
			RD1_reg <= 1'b0;
			end
		end
	else begin
		us_transfer_count1 <= 32'b0;
		RD1_reg <= 1'b0;
		end
	end
	
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		us_transfer_count2 <= 32'b0;
		RD2_reg <= 1'b0;
		end
	else if(RD2_DMA)begin
		if(~fifo_wr_full & !RD2_EMPTY)begin
			if(us_transfer_count2 != (ch1_dmasize_reg>>3))begin
				us_transfer_count2 <= us_transfer_count2 + 1'b1;
				RD2_reg <= 1'b1;
				end
			else begin
				us_transfer_count2 <= us_transfer_count2;
				RD2_reg <= 1'b0;
				end		
			end
		else begin
			us_transfer_count2 <= us_transfer_count2;
			RD2_reg <= 1'b0;
			end	
		end
	else begin
		us_transfer_count2 <= 32'b0;
		RD2_reg <= 1'b0;
		end
	end

//---------------ds DMA FIFO Write Control-----------------------------------------------------
reg	WR1_reg,WR2_reg;//local reg for Ch data read fifo en

assign	WR1_DMA = (ch0_control_reg[1] & (DMA_ds_PA[31:28] == 4'h1) & DMA_ds_Busy);
assign	WR2_DMA = (ch1_control_reg[1] & (DMA_ds_PA[31:28] == 4'h2) & DMA_ds_Busy);
assign	WR1 = ch0_control_reg[1] ? (~fifo_rd_empty & WR1_reg & ~WR1_FULL) : (~ch0_fifo_empty & ~WR1_FULL);	 
assign	WR2 = ch1_control_reg[1] ? (~fifo_rd_empty & WR2_reg & ~WR2_FULL) : (~ch1_fifo_empty & ~WR2_FULL);


//assign	WR1_DATA = ch0_control_reg[1] ? fifo_rd_dout : ch0_fifo_dout;
//assign	WR2_DATA = ch1_control_reg[1] ? fifo_rd_dout : ch1_fifo_dout;

always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		WR1_DATA <= 64'b0;
		WR2_DATA <= 64'b0;
		end
	else begin
		case({WR1,WR2})
			2'b10: WR1_DATA <= ch0_control_reg[1] ? fifo_rd_dout : ch0_fifo_dout;
			2'b01: WR2_DATA <= ch1_control_reg[1] ? fifo_rd_dout : ch1_fifo_dout;
			default:begin
				WR1_DATA <= WR1_DATA;
				WR2_DATA <= WR2_DATA;
				end
		endcase
	end
end	
		
		
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		fifo_rd_en <= 1'b0;
		end
	else begin
		fifo_rd_en <= WR1 | WR2;
		end
	end


reg	[31:0]	ds_transfer_count1,ds_transfer_count2;
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ds_transfer_count1 <= 32'b0;
		WR1_reg <= 1'b0;
		end
	else if(WR1_DMA)begin	
		if(~fifo_rd_empty & !WR1_FULL)begin
			if(ds_transfer_count1 != (ch0_dmasize_reg>>3))begin//DMA_ds_Length is in BYTE, fifo width is QDWORD               
				ds_transfer_count1 <= ds_transfer_count1 + 1'b1;
				WR1_reg <= 1'b1;
				end
			else begin
				ds_transfer_count1 <= ds_transfer_count1;
				WR1_reg <= 1'b0;
				end
			end
		else begin
			ds_transfer_count1 <= ds_transfer_count1;
			WR1_reg <= 1'b0;
			end
		end
	else begin
		ds_transfer_count1 <= 32'b0;
		WR1_reg <= 1'b0;
		end
	end
	
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ds_transfer_count2 <= 32'b0;
		WR2_reg <= 1'b0;
		end
	else if(WR2_DMA)begin
		if(~fifo_rd_empty & !WR2_FULL)begin
			if(ds_transfer_count2 != (ch1_dmasize_reg>>3))begin
				ds_transfer_count2 <= ds_transfer_count2 + 1'b1;
				WR2_reg <= 1'b1;
				end
			else begin
				ds_transfer_count2 <= ds_transfer_count2;
				WR2_reg <= 1'b0;
				end		
			end
		else begin
			ds_transfer_count2 <= ds_transfer_count2;
			WR2_reg <= 1'b0;
			end	
		end
	else begin
		ds_transfer_count2 <= 32'b0;
		WR2_reg <= 1'b0;
		end
	end
	
//--------------------------xd daq int gen------------------------------------------------
assign 	TEMP_irq = CH0_irq | CH1_irq;
assign	TEMPTOUT_irq   = Sys_Int_Enable[28]  & (!Sys_Int_Enable[26]  | CH0TOUT_irq)  & (!Sys_Int_Enable[27] | CH1TOUT_irq);

reg	[31:0]	CH0_TimeOut_Count,CH1_TimeOut_Count;
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		CH0_irq 			<= 1'b0;
		CH1_irq 			<= 1'b0;

		CH0TOUT_irq		<= 1'b0;
		CH1TOUT_irq    <= 1'b0;
		end
	else begin
		
		if(ch0_control_reg[0] & ch0_valid & !ch0_control_reg[1])begin
			CH0_irq <= Sys_Int_Enable[22];
			end
		else begin
			CH0_irq <= 1'b0;
			end
			
		if(ch1_control_reg[0] & ch1_valid & !ch1_control_reg[1])begin
			CH1_irq <= Sys_Int_Enable[23];
			end
		else begin
			CH1_irq <= 1'b0;	
			end
			
		if(ch0_control_reg[0] & (CH0_TimeOut_Count == C_INT_TIME_OUT_VALUE) & !ch0_control_reg[1])begin
			CH0TOUT_irq <= Sys_Int_Enable[26];
			end
		else begin
			CH0TOUT_irq <= 1'b0;
			end
			
		if(ch1_control_reg[0] & (CH1_TimeOut_Count == C_INT_TIME_OUT_VALUE) & !ch1_control_reg[1])begin
			CH1TOUT_irq <= Sys_Int_Enable[27];
			end
		else begin
			CH1TOUT_irq <= 1'b0;			
			end
		end
	end
	
always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		CH0_TimeOut_Count <= 32'b0;
		CH1_TimeOut_Count <= 32'b0;
		end
	else begin
		if(ch0_control_reg[0] & !ch0_valid & Sys_Int_Enable[26] & !ch0_control_reg[1])begin
			if(CH0_TimeOut_Count == C_INT_TIME_OUT_VALUE)
				CH0_TimeOut_Count <= CH0_TimeOut_Count;
			else
				CH0_TimeOut_Count <= CH0_TimeOut_Count + 1'b1;
			end
		else
			CH0_TimeOut_Count <= 32'b0;
			
		if(ch1_control_reg[0] & !ch1_valid & Sys_Int_Enable[27] & !ch1_control_reg[1])begin
			if(CH1_TimeOut_Count == C_INT_TIME_OUT_VALUE)
				CH1_TimeOut_Count <= CH1_TimeOut_Count;
			else
				CH1_TimeOut_Count <= CH1_TimeOut_Count + 1'b1;
			end
		else
			CH1_TimeOut_Count <= 32'b0;	
		end
	end
	
//-------------------------------------------register map-------------------------------------
reg	[31:0]  		reg01_td_reg;
reg	[31:0]  		reg02_td_reg;
reg	[31:0]  		reg03_td_reg;
reg	[31:0]  		reg04_td_reg;
reg	[31:0]  		reg05_td_reg;
reg	[31:0]  		reg06_td_reg;
reg	[31:0]  		reg07_td_reg;
reg	[31:0]  		reg08_td_reg;
reg	[31:0]  		reg09_td_reg;
reg	[31:0]		reg10_td_reg;
reg	[31:0]		reg11_td_reg;
reg	[31:0]		reg12_td_reg;
reg	[31:0]		reg13_td_reg;
reg	[31:0]		reg14_td_reg;
reg	[31:0]		reg15_td_reg;
reg	[31:0]		reg16_td_reg;
reg	[31:0]		reg17_td_reg;
reg	[31:0]		reg18_td_reg;
reg	[31:0]		reg19_td_reg;
reg	[31:0]		reg20_td_reg;
reg	[31:0]  		reg21_td_reg;
reg	[31:0]  		reg22_td_reg;
reg	[31:0]  		reg23_td_reg;
reg	[31:0]  		reg24_td_reg;
reg	[31:0]  		reg25_td_reg;
reg 	[24:0]		reg_tv_reg;
always @(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		reg01_td_reg    	<=   32'b0; 
		reg02_td_reg    	<=   32'b0; 
		reg03_td_reg    	<=   32'b0; 
		reg04_td_reg    	<=   32'b0; 
		reg05_td_reg    	<=   32'b0; 
		reg06_td_reg    	<=   32'b0;  
		reg07_td_reg    	<=   32'b0;  
		reg08_td_reg    	<=   32'b0; 
		reg09_td_reg    	<=   32'b0; 
		reg10_td_reg    	<=   32'b0; 
		reg11_td_reg    	<=   32'b0; 
		reg12_td_reg    	<=   32'b0; 
		reg13_td_reg    	<=   32'b0; 
		reg14_td_reg    	<=   32'b0;  
		reg15_td_reg    	<=   32'b0; 
		reg16_td_reg    	<=   32'b0; 
		reg17_td_reg    	<=   32'b0; 
		reg18_td_reg    	<=   32'b0; 
		reg19_td_reg    	<=   32'b0; 
		reg20_td_reg    	<=   32'b0; 
		reg21_td_reg    	<=   32'b0; 
		reg22_td_reg    	<=   32'b0; 
		reg23_td_reg    	<=   32'b0; 
		reg24_td_reg    	<=   32'b0; 
		reg25_td_reg    	<=   32'b0; 		
		reg_tv_reg    	<=   25'b0;
	end
	else begin	
		reg_tv_reg    	<=   reg_tv;
		
		if(reg_tv[0])
			reg01_td_reg    	<=   reg01_td; 		
		if(reg_tv[1])
			reg02_td_reg    	<=   reg02_td; 
		if(reg_tv[2])
			reg03_td_reg    	<=   reg03_td; 		
		if(reg_tv[3])
			reg04_td_reg    	<=   reg04_td; 			
		if(reg_tv[4])
			reg05_td_reg    	<=   reg05_td; 		
		if(reg_tv[5])
			reg06_td_reg    	<=   reg06_td; 			
		if(reg_tv[6])
			reg07_td_reg    	<=   reg07_td; 		
		if(reg_tv[7])
			reg08_td_reg    	<=   reg08_td; 
		if(reg_tv[8])
			reg09_td_reg    	<=   reg09_td; 		
		if(reg_tv[9])
			reg10_td_reg    	<=   reg10_td; 			
		if(reg_tv[10])
			reg11_td_reg    	<=   reg11_td; 		
		if(reg_tv[11])
			reg12_td_reg    	<=   reg12_td; 			
		if(reg_tv[12])
			reg13_td_reg    	<=   reg13_td; 		
		if(reg_tv[13])
			reg14_td_reg    	<=   reg14_td; 
		if(reg_tv[14])
			reg15_td_reg    	<=   reg15_td; 		
		if(reg_tv[15])
			reg16_td_reg    	<=   reg16_td; 			
		if(reg_tv[16])
			reg17_td_reg    	<=   reg17_td; 		
		if(reg_tv[17])
			reg18_td_reg    	<=   reg18_td; 			
		if(reg_tv[18])
			reg19_td_reg    	<=   reg19_td; 		
		if(reg_tv[19])
			reg20_td_reg    	<=   reg20_td; 	
		if(reg_tv[20])
			reg21_td_reg    	<=   reg21_td; 		
		if(reg_tv[21])
			reg22_td_reg    	<=   reg22_td; 
		if(reg_tv[22])
			reg23_td_reg    	<=   reg23_td; 		
		if(reg_tv[23])
			reg24_td_reg    	<=   reg24_td; 			
		if(reg_tv[24])
			reg25_td_reg    	<=   reg25_td; 		
			
	end
end

always@(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		reg_rv	<= 25'b0;
		end
	else begin			
		reg_rv	<= {14'h3FFF,reg_tv_reg[10],9'h1FF,reg_tv_reg[0]};		//control words are R + W, others are Read Only		
		end
	end

assign	reg01_rd	= ch0_status_reg;
assign	reg02_rd	= ch0_freq_reg[63:32];
assign	reg03_rd	= ch0_freq_reg[31:0];
assign	reg04_rd	= 32'h12345678;//reserve
assign	reg05_rd	= 32'h87654321;//reserve
assign	reg06_rd	= 32'h00000000;//reserve
assign	reg07_rd	= 32'hffffffff;//reserve
assign	reg08_rd	= ch0_total_size[63:32];
assign	reg09_rd	= ch0_total_size[31:0];
assign	reg10_rd	= ch0_ddr3_use;

assign	reg11_rd = ch1_status_reg;
assign	reg12_rd = ch1_freq_reg[63:32];			
assign	reg13_rd = ch1_freq_reg[31:0];
assign	reg14_rd = 32'h12345678;//reserve
assign	reg15_rd = 32'h87654321;//reserve
assign	reg16_rd = 32'h00000000;//reserve
assign	reg17_rd = 32'hffffffff;//reserve
assign	reg18_rd = ch1_total_size[63:32];
assign	reg19_rd = ch1_total_size[31:0];
assign	reg20_rd = ch1_ddr3_use;	

assign	reg21_rd = ch0_dmasize_reg;
assign	reg22_rd = ch1_dmasize_reg;	
assign	reg23_rd = 32'h55aa55aa;//reserve
assign	reg24_rd = 32'h12345678;//reserve
assign	reg25_rd = 32'h87654321;//reserve
	
//------------------------¿ØÖÆ¼Ä´æÆ÷----------------------------------------------
always @(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ch0_control_reg <= 32'b0;
		ch1_control_reg <= 32'b0;
		end
	else begin
		if(reg_tv[0])
			ch0_control_reg <= reg01_td;
		else begin
			ch0_control_reg[17] <= ch0_total_size_mannul_reset ? 1'b0 : ch0_control_reg[17];
			end
			
		if(reg_tv[10])
			ch1_control_reg <= reg11_td;
		else begin
			ch1_control_reg[17] <= ch1_total_size_mannul_reset ? 1'b0 : ch1_control_reg[17];
			end
		end
	end
//------------------------DMA_SIZE¼Ä´æÆ÷----------------------------------------------
always @(posedge user_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		ch0_dmasize_reg <= 32'b0;
		ch1_dmasize_reg <= 32'b0;
		end
	else begin
		if(reg_tv[20])
			ch0_dmasize_reg <= reg21_td;
		else begin
			ch0_dmasize_reg <= ch0_dmasize_reg;			
			end
			
		if(reg_tv[21])
			ch1_dmasize_reg <= reg22_td;
		else begin		
			ch1_dmasize_reg <= ch1_dmasize_reg;			
			end
		end
	end
	
endmodule
