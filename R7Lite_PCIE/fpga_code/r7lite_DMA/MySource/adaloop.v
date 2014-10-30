`timescale 1ns / 1ps

module adaloop(
	input 					mclk,
	input 					rst,
	output 					lpc_clkin_p,
	output 					lpc_clkin_n,
	output reg 	[15:0] 	daci,
	output reg 	[15:0] 	dacq,
	input 		[13:0] 	adci,
	input 		[13:0] 	adcq,
	input 					adc_clk,
	output 					sclk,
	output 					sdio,
	output 					csb,
	output 					lpc_rst,
	output 		[3:0] 	led,
	output					clk50m
    );


	//pll1
	pll pll_inst(
		.CLK_IN1(mclk),
		.RESET(~rst),
		.CLK_OUT1(dac_clk),
		.CLK_OUT2(chip_clk),
		.CLK_OUT3(lpc_clkin_p),
		.CLK_OUT4(clk50m),
		.LOCKED(lock)
		);
		
	assign lpc_clkin_n=1'b0;
	
	//generat rstr	
	reg rstr=1'b0;
	always @ (posedge clk50m)begin
		rstr<=rst;
		end
		
	//clk divide
	reg [24:0] cnt;
	always @ (posedge clk50m or negedge rstr)begin
		if(!rstr)
			cnt<=25'd0;
		else
			cnt<=cnt+1'b1;
		end
		
	wire clk_spi=cnt[9];
	wire clk24=cnt[24];
	
	//AD9777 SPI
	ad9777_spi ad9777_spi(
		.sdio		(sdio_ad9777	),
		.csb		(csb_ad9777		),
		.rst		(rstr				),
		.clk		(clk_spi			),
		.spi_ok 	(spi_ok_ad9777	)
		);
		
	wire [2:0] adcmode;//000 nomal;011 toggle 0x1555->0x2AAA;100 ramp;101 0x1555
	ads62p44_spi ads62p44_spi(
		.sdio		(sdio_ads62p44	),
		.csb		(csb_ads62p44	),
		.rst		(spi_ok_ad9777	),
		.clk		(clk_spi			),
		.spi_ok 	(spi_ok_ads62p44),
		.adcmode	(adcmode			)
		);
		
	assign lpc_rst = ~spi_ok_ad9777;
	assign sclk		= clk_spi;
	assign sdio		= !spi_ok_ad9777	?	sdio_ad9777	:	sdio_ads62p44;
	assign csb		= !spi_ok_ad9777	?	csb_ad9777	:	csb_ads62p44;
	
	//dac
	wire sample;//0x0 x4 interpolation;0x1 x2 interpolation
	reg [12:0] addr;
	always @ (posedge dac_clk or negedge rstr)begin
		if(!rstr)
			addr<=13'd8191;
		else if(!sample)
			addr<=addr+1'b1;
		else
			addr<=addr+2'd2;
		end
		
	wire [31:0] data_mcs720;
	rom_8192x32 rom_8192x32(
		.clka		(dac_clk		),
		.addra	(addr			),
		.douta	(data_mcs720)
		);
		
	wire [31:0] data_tone;
	wire [11:0] phase;
	dds dds_inst(
		.clk		(dac_clk				),
		.we		(1'b1					),
		.data		(phase				),
		.cosine	(data_tone[31:16]	),
		.sine		(data_tone[15:0]	)
		);
		
	wire [3:0] sel;
	reg [31:0] data;
	always @ (posedge dac_clk or negedge rstr)begin
		if(!rstr)begin
			data<=32'd0;
			end
		else begin
			case(sel)
				4'b0000:data<=32'd0;
				4'b0001:data<=data_tone;
				4'b0010:data<=data_mcs720;
			endcase
			end
		end
		
	always @ (posedge dac_clk or negedge rstr)begin
		if(!rstr)begin
			daci<=16'd0;
			dacq<=16'd0;
			end
		else begin
			{daci,dacq}<=data;
			end
		end
		
	assign led[3]=lpc_rst			;//DD4
	assign led[2]=spi_ok_ad9777	;//DD3
	assign led[1]=spi_ok_ads62p44	;//DD2
	assign led[0]=lock				;//DD1
	
	
	//chipscope
	wire [35:0] CONTROL0,CONTROL1;
	
	icon icon_inst(.CONTROL0(CONTROL0),.CONTROL1(CONTROL1));
	
	ila ila_inst
	(
		.CLK(chip_clk),
		.CONTROL(CONTROL0),
		.TRIG0({
					adci,	//[63:50]W
					2'd0,	//[49:48]
					adcq,	//[47:34]
					2'd0,	//[33:32]
					daci,	//[31:16]
					dacq	//[15:0]
					})
	);
	
	wire [31:0] ASYNC_OUT;
	vio vio_inst (.CONTROL(CONTROL1),.ASYNC_OUT(ASYNC_OUT));
	
	assign sel		=ASYNC_OUT[3:0];
	assign phase	=ASYNC_OUT[15:4];
	assign adcmode =ASYNC_OUT[18:16];
	assign sample  =ASYNC_OUT[19];
	assign rst_vio =ASYNC_OUT[31];

	
endmodule
