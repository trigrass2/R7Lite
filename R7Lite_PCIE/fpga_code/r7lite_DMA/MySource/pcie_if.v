`timescale 1ns / 1ps

module pcie_if  #(
	parameter 	USE_LOOPBACK_TEST  	= 0,	
	parameter   PL_FAST_TRAIN 			= "FALSE",
	parameter   PCIE_EXT_CLK 			= "TRUE",  
	parameter 	C_NUM_PCIE_LANES		= 4,		//Number of Lanes for PCIe, 1, 4 or 8
	
	parameter	PCIE_LINK_SPEED		= 2,		//1 - Gen1 , 2 - Gen2
	parameter 	USER_CLK_FREQ 			= 3,		// 0 - 31.25 MHz , 1 - 62.5 MHz , 2 - 125 MHz , 3 - 250 MHz , 4 - 500Mhz

	parameter 	C_DBUS_WIDTH         = 64,		//Data bus width 
   parameter 	KEEP_WIDTH        	= C_DBUS_WIDTH / 8,
	parameter	C_ASYNFIFO_WIDTH		= 72,
	parameter	C_PRAM_AWIDTH			= 12,
	parameter 	C_FIFO_DC_WIDTH      = 26, 	// Event Buffer: FIFO Data Count width  
	parameter 	C_EMU_FIFO_DC_WIDTH  = 15 		//Small BRAM FIFO for emulation//S 14 x fifo originale  15 x fifo grande!!
)
(
		output	[3:0]									led,
		output											user_lnk_up,
		output											trn_Blinker,
		input		[C_NUM_PCIE_LANES-1 : 0]		pci_exp_rxp,
		input		[C_NUM_PCIE_LANES-1 : 0]		pci_exp_rxn,
		output	[C_NUM_PCIE_LANES-1 : 0]		pci_exp_txp,
		output	[C_NUM_PCIE_LANES-1 : 0]		pci_exp_txn,
		input												sys_clk_p,
		input												sys_clk_n,
		input												pci_rst_n
		,output											user_clk_out
		,output											pci_rst_n_c,

		output  [C_EMU_FIFO_DC_WIDTH-1 : 0]	user_rd_data_count 	,
		input  										user_rd_en				,
		output  [C_DBUS_WIDTH-1:0]				user_rd_dout			,
		output  										user_rd_pempty     	,
		output  										user_rd_empty      	,
		output  [C_EMU_FIFO_DC_WIDTH-1 : 0]	user_wr_data_count 	,
		input  										user_wr_en         	,
		input   [C_DBUS_WIDTH-1:0]				user_wr_din 			,
		output  										user_wr_pfull      	,
		output  										user_wr_full       	,
		output  										user_rd_valid      	,
		
		input		[7:0]								user_wr_weA				,
		input		[C_PRAM_AWIDTH-1 : 0]		user_wr_addrA 			,
		input		[C_DBUS_WIDTH-1 : 0] 		user_wr_dinA  			,
		input		[C_PRAM_AWIDTH-1 : 0]		user_rd_addrB 			,
		output	[C_DBUS_WIDTH-1 : 0] 		user_rd_doutB			,
		
		output										DMA_Host2Board_Busy	,
		output										DMA_Host2Board_Done	, 
		
		input											DAQ_irq, CTL_irq, DLM_irq,
		input											DAQTOUT_irq, CTLTOUT_irq, DLMTOUT_irq,
		output	[C_DBUS_WIDTH-1 : 0]			Sys_Int_Enable,
		
		output	[C_DBUS_WIDTH-1:0]			DMA_us_PA,
		output	[C_DBUS_WIDTH-1:0]			DMA_us_HA,
		output	[C_DBUS_WIDTH-1:0]			DMA_us_BDA,
		output	[C_DBUS_WIDTH-1:0]			DMA_us_Length,
		output	[C_DBUS_WIDTH-1:0]			DMA_us_Control,

		output	[C_DBUS_WIDTH-1:0]			DMA_ds_PA,
		output	[C_DBUS_WIDTH-1:0]			DMA_ds_HA,
		output	[C_DBUS_WIDTH-1:0]			DMA_ds_BDA,
		output	[C_DBUS_WIDTH-1:0]			DMA_ds_Length,
		output	[C_DBUS_WIDTH-1:0]			DMA_ds_Control,
		
		output	DMA_us_Done,DMA_us_Busy,DMA_ds_Done,DMA_ds_Busy,
		output	dsDMA_Start,dsDMA_Stop,dsDMA_Start2,dsDMA_Stop2,dsDMA_Channel_Rst,
		output	usDMA_Start,usDMA_Stop,usDMA_Start2,usDMA_Stop2,usDMA_Channel_Rst,
		
		output	eb_re,eb_empty,eb_pempty,eb_valid,
		output	[C_ASYNFIFO_WIDTH-1:0]			eb_dout,
		
		output	eb_rst,
		
		output	[31:0]	debug_in_1i, debug_in_2i, debug_in_3i,debug_in_4i, 	 
	
		output	[31:0]	reg01_td,reg02_td,reg03_td,reg04_td,reg05_td,reg06_td,reg07_td,reg08_td,reg09_td,reg10_td,
								reg11_td,reg12_td,reg13_td,reg14_td,reg15_td,reg16_td,reg17_td,reg18_td,reg19_td,reg20_td,
								reg21_td,reg22_td,reg23_td,reg24_td,reg25_td,
		output	[24:0]	reg_tv,

		input		[31:0]	reg01_rd,reg02_rd,reg03_rd,reg04_rd,reg05_rd,reg06_rd,reg07_rd,reg08_rd,reg09_rd,reg10_rd,
								reg11_rd,reg12_rd,reg13_rd,reg14_rd,reg15_rd,reg16_rd,reg17_rd,reg18_rd,reg19_rd,reg20_rd,
								reg21_rd,reg22_rd,reg23_rd,reg24_rd,reg25_rd,
		input		[24:0]	reg_rv
	 );
//------------------------------------user logic----------------------------------
	assign		DMA_Host2Board_Busy 	= DMA_ds_Busy;
	wire			DMA_ds_Done;					
	assign  		DMA_Host2Board_Done = DMA_ds_Done;
	 
//-----------------------------------pci express if--------------------------------
  localparam                                  TCQ = 1;

//  wire                                        user_clk;
  wire                                        user_reset;
  wire                                        user_lnk_up;


  // Tx
  wire [5:0]                                  tx_buf_av;
  wire                                        tx_cfg_req;
  wire                                        tx_err_drop;
  wire                                        tx_cfg_gnt;
  wire                                        s_axis_tx_tready;
  wire [3:0]                                  s_axis_tx_tuser;
  wire [C_DBUS_WIDTH-1:0]                     s_axis_tx_tdata;
  wire [KEEP_WIDTH-1:0]                       s_axis_tx_tkeep;
  wire                                        s_axis_tx_tlast;
  wire                                        s_axis_tx_tvalid;


  // Rx
  wire [C_DBUS_WIDTH-1:0]                     m_axis_rx_tdata;
  wire [KEEP_WIDTH-1:0]                       m_axis_rx_tkeep;
  wire                                        m_axis_rx_tlast;
  wire                                        m_axis_rx_tvalid;
  wire                                        m_axis_rx_tready;
  wire  [21:0]                                m_axis_rx_tuser;
  wire                                        rx_np_ok;
  wire                                        rx_np_req;

  // Flow Control
  wire [11:0]                                 fc_cpld;
  wire [7:0]                                  fc_cplh;
  wire [11:0]                                 fc_npd;
  wire [7:0]                                  fc_nph;
  wire [11:0]                                 fc_pd;
  wire [7:0]                                  fc_ph;
  wire [2:0]                                  fc_sel;


  //-------------------------------------------------------
  // 3. Configuration (CFG) Interface
  //-------------------------------------------------------

  wire                                        cfg_err_cor;
  wire                                        cfg_err_ur;
  wire                                        cfg_err_ecrc;
  wire                                        cfg_err_cpl_timeout;
  wire                                        cfg_err_cpl_abort;
  wire                                        cfg_err_cpl_unexpect;
  wire                                        cfg_err_posted;
  wire                                        cfg_err_locked;
  wire  [47:0]                                cfg_err_tlp_cpl_header;
  wire                                        cfg_err_cpl_rdy;

 wire           cfg_err_atomic_egress_blocked;
 wire           cfg_err_internal_cor;
 wire           cfg_err_malformed;
 wire           cfg_err_mc_blocked;
 wire           cfg_err_poisoned;
 wire           cfg_err_norecovery;
 wire           cfg_err_acs;
 wire           cfg_err_internal_uncor;
 
  wire                                        cfg_interrupt;
  wire                                        cfg_interrupt_rdy;
  wire                                        cfg_interrupt_assert;
  wire   [7:0]                                cfg_interrupt_di;
  wire   [7:0]                                cfg_interrupt_do;
  wire   [2:0]                                cfg_interrupt_mmenable;
  wire                                        cfg_interrupt_msienable;
  wire                                        cfg_interrupt_msixenable;
  wire                                        cfg_interrupt_msixfm;
  wire                                        cfg_interrupt_stat;
  wire   [4:0]                                cfg_pciecap_interrupt_msgnum;
  wire                                        cfg_turnoff_ok;
  wire                                        cfg_to_turnoff;
  wire                                        cfg_trn_pending;
  wire                                        cfg_pm_halt_aspm_l0s;
  wire                                        cfg_pm_halt_aspm_l1;
  wire                                        cfg_pm_force_state_en;
  wire   [1:0]                                cfg_pm_force_state;
  wire                                        cfg_pm_wake;
  wire   [7:0]                                cfg_bus_number;
  wire   [4:0]                                cfg_device_number;
  wire   [2:0]                                cfg_function_number;
  wire  [15:0]                                cfg_status;
  wire  [15:0]                                cfg_command;
  wire  [15:0]                                cfg_dstatus;
  wire  [15:0]                                cfg_dcommand;
  wire  [15:0]                                cfg_lstatus;
  wire  [15:0]                                cfg_lcommand;
  wire  [15:0]                                cfg_dcommand2;
  wire   [2:0]                                cfg_pcie_link_state;
  wire  [63:0]                                cfg_dsn;
  wire [127:0]                                cfg_err_aer_headerlog;
  wire   [4:0]                                cfg_aer_interrupt_msgnum;
  wire                                        cfg_err_aer_headerlog_set;
  wire                                        cfg_aer_ecrc_check_en;
  wire                                        cfg_aer_ecrc_gen_en;

  wire  [31:0]                                cfg_mgmt_di;
  wire   [3:0]                                cfg_mgmt_byte_en;
  wire   [9:0]                                cfg_mgmt_dwaddr;
  wire                                        cfg_mgmt_wr_en;
  wire                                        cfg_mgmt_rd_en;
  wire                                        cfg_mgmt_wr_readonly;

  wire  [31:0]  cfg_mgmt_do;
  wire          cfg_mgmt_rd_wr_done;
  
  wire          cfg_pmcsr_pme_en;
  wire  [1:0]   cfg_pmcsr_powerstate;
  wire          cfg_pmcsr_pme_status;
  wire          cfg_received_func_lvl_rst;
  
  //-------------------------------------------------------
  // 4. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  wire [2:0]                                  pl_initial_link_width;
  wire [1:0]                                  pl_lane_reversal_mode;
  wire                                        pl_link_gen2_cap;
  wire                                        pl_link_partner_gen2_supported;
  wire                                        pl_link_upcfg_cap;
  wire                                        pl_received_hot_rst;
  wire                                        pl_sel_lnk_rate;
  wire [1:0]                                  pl_sel_lnk_width;
  wire                                        pl_directed_link_auton;
  wire [1:0]                                  pl_directed_link_change;
  wire                                        pl_directed_link_speed;
  wire [1:0]                                  pl_directed_link_width;
  wire                                        pl_upstream_prefer_deemph;

//  wire                                        pci_rst_n_c;

  // Wires used for external clocking connectivity
  wire                                        PIPE_PCLK_IN;
  wire                                        PIPE_RXUSRCLK_IN;
  wire   [3:0]   PIPE_RXOUTCLK_IN;
  wire                                        PIPE_DCLK_IN;
  wire                                        PIPE_USERCLK1_IN;
  wire                                        PIPE_USERCLK2_IN;
  wire                                        PIPE_MMCM_LOCK_IN;

  wire                                        PIPE_TXOUTCLK_OUT;
  wire [3:0]     PIPE_RXOUTCLK_OUT;

  wire [3:0]     PIPE_PCLK_SEL_OUT;
  wire                                        PIPE_GEN3_OUT;
 
  wire                                        PIPE_OOBCLK_IN;

 
//  localparam USER_CLK_FREQ = 2;// 0 - 31.25 MHz , 1 - 62.5 MHz , 2 - 125 MHz , 3 - 250 MHz , 4 - 500Mhz
  localparam USER_CLK2_DIV2 = "FALSE";
  localparam USERCLK2_FREQ = (USER_CLK2_DIV2 == "TRUE") ?
                             (USER_CLK_FREQ == 4) ? 3 :
                             (USER_CLK_FREQ == 3) ? 2 : USER_CLK_FREQ :
                             USER_CLK_FREQ;
  //-------------------------------------------------------
  IBUF   sys_reset_n_ibuf (.O(pci_rst_n_c), .I(pci_rst_n));

  IBUFDS_GTE2 refclk_ibuf (.O(sys_clk), .ODIV2(), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));


  reg user_reset_q;
  reg user_lnk_up_q;
  reg PIPE_MMCM_RST_N = 1'b1;

  always @(posedge user_clk_out) begin
    user_reset_q  <= user_reset;
    user_lnk_up_q <= user_lnk_up;
  end

 
  // Generate External Clock Module if External Clocking is selected
  generate
    if (PCIE_EXT_CLK == "TRUE") begin : ext_clk

      //---------- PIPE Clock Module -------------------------------------------------
      pcieCore_pipe_clock #
      (
          .PCIE_ASYNC_EN                  ( "FALSE" ),     // PCIe async enable
          .PCIE_TXBUF_EN                  ( "FALSE" ),     // PCIe TX buffer enable for Gen1/Gen2 only
          .PCIE_LANE                      ( C_NUM_PCIE_LANES ),     // PCIe number of lanes
          // synthesis translate_off
          .PCIE_LINK_SPEED                ( PCIE_LINK_SPEED ),//1 - Gen1 , 2 - Gen2
          // synthesis translate_on
          .PCIE_REFCLK_FREQ               ( 0 ),     // PCIe reference clock frequency  -- 0 - 100 MHz , 1 - 125 MHz , 2 - 250 MHz
          .PCIE_USERCLK1_FREQ             ( USER_CLK_FREQ +1 ),     // PCIe user clock 1 frequency  
          .PCIE_USERCLK2_FREQ             ( USERCLK2_FREQ +1 ),     // PCIe user clock 2 frequency
          .PCIE_DEBUG_MODE                ( 0 )
      )
      pipe_clock_i
      (

          //---------- Input -------------------------------------
          .CLK_CLK                        ( sys_clk ),
          .CLK_TXOUTCLK                   ( PIPE_TXOUTCLK_OUT ),     // Reference clock from lane 0
          .CLK_RXOUTCLK_IN                ( PIPE_RXOUTCLK_OUT ),
         // .CLK_RST_N                      ( 1'b1 ),
          .CLK_RST_N                      ( PIPE_MMCM_RST_N ),
          .CLK_PCLK_SEL                   ( PIPE_PCLK_SEL_OUT ),
          .CLK_GEN3                       ( PIPE_GEN3_OUT ),

          //---------- Output ------------------------------------
          .CLK_PCLK                       ( PIPE_PCLK_IN ),
          .CLK_RXUSRCLK                   ( PIPE_RXUSRCLK_IN ),
          .CLK_RXOUTCLK_OUT               ( PIPE_RXOUTCLK_IN ),
          .CLK_DCLK                       ( PIPE_DCLK_IN ),
          .CLK_OOBCLK                     ( PIPE_OOBCLK_IN ),
          .CLK_USERCLK1                   ( PIPE_USERCLK1_IN ),
          .CLK_USERCLK2                   ( PIPE_USERCLK2_IN ),
          .CLK_MMCM_LOCK                  ( PIPE_MMCM_LOCK_IN )

      );
    end  else begin
      assign pipe_pclk_in      = 1'b0;
      assign pipe_rxusrclk_in  = 1'b0;
      assign pipe_rxoutclk_in  = 0;
      assign pipe_dclk_in      = 1'b0;
      assign pipe_userclk1_in  = 1'b0;
      assign pipe_userclk2_in  = 1'b0;
      assign pipe_mmcm_lock_in = 1'b0;
      assign pipe_oobclk_in    = 1'b0;
    end

  endgenerate
 
pcieCore #(
  .PL_FAST_TRAIN      (PL_FAST_TRAIN),
  .PCIE_EXT_CLK       (PCIE_EXT_CLK)
) pcieCore_i
 (

  //----------------------------------------------------------------------------------------------------------------//
  // 1. PCI Express (pci_exp) Interface                                                                             //
  //----------------------------------------------------------------------------------------------------------------//

  // Tx
  .pci_exp_txn                                ( pci_exp_txn ),
  .pci_exp_txp                                ( pci_exp_txp ),

  // Rx
  .pci_exp_rxn                                ( pci_exp_rxn ),
  .pci_exp_rxp                                ( pci_exp_rxp ),

  //----------------------------------------------------------------------------------------------------------------//
  // 2. Clocking Interface                                                                                          //
  //----------------------------------------------------------------------------------------------------------------//
  .PIPE_PCLK_IN                              ( PIPE_PCLK_IN ),
  .PIPE_RXUSRCLK_IN                          ( PIPE_RXUSRCLK_IN ),
  .PIPE_RXOUTCLK_IN                          ( PIPE_RXOUTCLK_IN ),
  .PIPE_DCLK_IN                              ( PIPE_DCLK_IN ),
  .PIPE_USERCLK1_IN                          ( PIPE_USERCLK1_IN ),
  .PIPE_OOBCLK_IN                            ( PIPE_OOBCLK_IN ),
  .PIPE_USERCLK2_IN                          ( PIPE_USERCLK2_IN ),
  .PIPE_MMCM_LOCK_IN                         ( PIPE_MMCM_LOCK_IN ),

  .PIPE_TXOUTCLK_OUT                         ( PIPE_TXOUTCLK_OUT ),
  .PIPE_RXOUTCLK_OUT                         ( PIPE_RXOUTCLK_OUT ),
  .PIPE_PCLK_SEL_OUT                         ( PIPE_PCLK_SEL_OUT ),
  .PIPE_GEN3_OUT                             ( PIPE_GEN3_OUT ),


  //----------------------------------------------------------------------------------------------------------------//
  // 3. AXI-S Interface                                                                                             //
  //----------------------------------------------------------------------------------------------------------------//

  // Common
  .user_clk_out                               ( user_clk_out ),
  .user_reset_out                             ( user_reset ),
  .user_lnk_up                                ( user_lnk_up ),

  // TX

  .tx_buf_av                                  ( tx_buf_av ),
  .tx_err_drop                                ( tx_err_drop ),
  .tx_cfg_req                                 ( tx_cfg_req ),
  .s_axis_tx_tready                           ( s_axis_tx_tready ),
  .s_axis_tx_tdata                            ( s_axis_tx_tdata ),
  .s_axis_tx_tkeep                            ( s_axis_tx_tkeep ),
  .s_axis_tx_tuser                            ( s_axis_tx_tuser ),
  .s_axis_tx_tlast                            ( s_axis_tx_tlast ),
  .s_axis_tx_tvalid                           ( s_axis_tx_tvalid ),

  .tx_cfg_gnt                                 ( tx_cfg_gnt ),

  // Rx
  .m_axis_rx_tdata                            ( m_axis_rx_tdata ),
  .m_axis_rx_tkeep                            ( m_axis_rx_tkeep ),
  .m_axis_rx_tlast                            ( m_axis_rx_tlast ),
  .m_axis_rx_tvalid                           ( m_axis_rx_tvalid ),
  .m_axis_rx_tready                           ( m_axis_rx_tready ),
  .m_axis_rx_tuser                            ( m_axis_rx_tuser ),
  .rx_np_ok                                   ( rx_np_ok ),
  .rx_np_req                                  ( rx_np_req ),

  // Flow Control
  .fc_cpld                                    ( fc_cpld ),
  .fc_cplh                                    ( fc_cplh ),
  .fc_npd                                     ( fc_npd ),
  .fc_nph                                     ( fc_nph ),
  .fc_pd                                      ( fc_pd ),
  .fc_ph                                      ( fc_ph ),
  .fc_sel                                     ( fc_sel ),


  //----------------------------------------------------------------------------------------------------------------//
  // 4. Configuration (CFG) Interface                                                                               //
  //----------------------------------------------------------------------------------------------------------------//

  //------------------------------------------------//
  // EP and RP                                      //
  //------------------------------------------------//
  .cfg_mgmt_do                                ( cfg_mgmt_do ),
  .cfg_mgmt_rd_wr_done                        ( cfg_mgmt_rd_wr_done),

  .cfg_status                                 ( cfg_status ),
  .cfg_command                                ( cfg_command ),
  .cfg_dstatus                                ( cfg_dstatus ),
  .cfg_dcommand                               ( cfg_dcommand ),
  .cfg_lstatus                                ( cfg_lstatus ),
  .cfg_lcommand                               ( cfg_lcommand ),
  .cfg_dcommand2                              ( cfg_dcommand2 ),
  .cfg_pcie_link_state                        ( cfg_pcie_link_state ),

  .cfg_pmcsr_pme_en                           ( cfg_pmcsr_pme_en),
  .cfg_pmcsr_powerstate                       ( cfg_pmcsr_powerstate),
  .cfg_pmcsr_pme_status                       ( cfg_pmcsr_pme_status),
  .cfg_received_func_lvl_rst                  ( cfg_received_func_lvl_rst),

  // Management Interface
  .cfg_mgmt_di                                ( cfg_mgmt_di ),
  .cfg_mgmt_byte_en                           ( cfg_mgmt_byte_en ),
  .cfg_mgmt_dwaddr                            ( cfg_mgmt_dwaddr ),
  .cfg_mgmt_wr_en                             ( cfg_mgmt_wr_en ),
  .cfg_mgmt_rd_en                             ( cfg_mgmt_rd_en ),
  .cfg_mgmt_wr_readonly                       ( cfg_mgmt_wr_readonly ),

  // Error Reporting Interface
  .cfg_err_ecrc                               ( cfg_err_ecrc ),
  .cfg_err_ur                                 ( cfg_err_ur ),
  .cfg_err_cpl_timeout                        ( cfg_err_cpl_timeout ),
  .cfg_err_cpl_unexpect                       ( cfg_err_cpl_unexpect ),
  .cfg_err_cpl_abort                          ( cfg_err_cpl_abort ),
  .cfg_err_posted                             ( cfg_err_posted ),
  .cfg_err_cor                                ( cfg_err_cor ),
  .cfg_err_atomic_egress_blocked              ( cfg_err_atomic_egress_blocked ),
  .cfg_err_internal_cor                       ( cfg_err_internal_cor ),
  .cfg_err_malformed                          ( cfg_err_malformed ),
  .cfg_err_mc_blocked                         ( cfg_err_mc_blocked ),
  .cfg_err_poisoned                           ( cfg_err_poisoned ),
  .cfg_err_norecovery                         ( cfg_err_norecovery ),
  .cfg_err_tlp_cpl_header                     ( cfg_err_tlp_cpl_header ),
  .cfg_err_cpl_rdy                            ( cfg_err_cpl_rdy ),
  .cfg_err_locked                             ( cfg_err_locked ),
  .cfg_err_acs                                ( cfg_err_acs ),
  .cfg_err_internal_uncor                     ( cfg_err_internal_uncor ),

  .cfg_trn_pending                            ( cfg_trn_pending ),
  .cfg_pm_halt_aspm_l0s                       ( cfg_pm_halt_aspm_l0s ),
  .cfg_pm_halt_aspm_l1                        ( cfg_pm_halt_aspm_l1 ),
  .cfg_pm_force_state_en                      ( cfg_pm_force_state_en ),
  .cfg_pm_force_state                         ( cfg_pm_force_state ),

  .cfg_dsn                                    ( cfg_dsn ),

  //------------------------------------------------//
  // EP Only                                        //
  //------------------------------------------------//
  .cfg_interrupt                              ( cfg_interrupt ),
  .cfg_interrupt_rdy                          ( cfg_interrupt_rdy ),
  .cfg_interrupt_assert                       ( cfg_interrupt_assert ),
  .cfg_interrupt_di                           ( cfg_interrupt_di ),
  .cfg_interrupt_do                           ( cfg_interrupt_do ),
  .cfg_interrupt_mmenable                     ( cfg_interrupt_mmenable ),
  .cfg_interrupt_msienable                    ( cfg_interrupt_msienable ),
  .cfg_interrupt_msixenable                   ( cfg_interrupt_msixenable ),
  .cfg_interrupt_msixfm                       ( cfg_interrupt_msixfm ),
  .cfg_interrupt_stat                         ( cfg_interrupt_stat ),
  .cfg_pciecap_interrupt_msgnum               ( cfg_pciecap_interrupt_msgnum ),
  .cfg_to_turnoff                             ( cfg_to_turnoff ),
  .cfg_turnoff_ok                             ( cfg_turnoff_ok ),
  .cfg_bus_number                             ( cfg_bus_number ),
  .cfg_device_number                          ( cfg_device_number ),
  .cfg_function_number                        ( cfg_function_number ),
  .cfg_pm_wake                                ( cfg_pm_wake ),

  //------------------------------------------------//
  // RP Only                                        //
  //------------------------------------------------//
  .cfg_pm_send_pme_to                         ( 1'b0 ),
  .cfg_ds_bus_number                          ( 8'b0 ),
  .cfg_ds_device_number                       ( 5'b0 ),
  .cfg_ds_function_number                     ( 3'b0 ),
  .cfg_mgmt_wr_rw1c_as_rw                     ( 1'b0 ),
  .cfg_msg_received                           ( ),
  .cfg_msg_data                               ( ),

  .cfg_bridge_serr_en                         ( ),
  .cfg_slot_control_electromech_il_ctl_pulse  ( ),
  .cfg_root_control_syserr_corr_err_en        ( ),
  .cfg_root_control_syserr_non_fatal_err_en   ( ),
  .cfg_root_control_syserr_fatal_err_en       ( ),
  .cfg_root_control_pme_int_en                ( ),
  .cfg_aer_rooterr_corr_err_reporting_en      ( ),
  .cfg_aer_rooterr_non_fatal_err_reporting_en ( ),
  .cfg_aer_rooterr_fatal_err_reporting_en     ( ),
  .cfg_aer_rooterr_corr_err_received          ( ),
  .cfg_aer_rooterr_non_fatal_err_received     ( ),
  .cfg_aer_rooterr_fatal_err_received         ( ),

  .cfg_msg_received_err_cor                   ( ),
  .cfg_msg_received_err_non_fatal             ( ),
  .cfg_msg_received_err_fatal                 ( ),
  .cfg_msg_received_pm_as_nak                 ( ),
  .cfg_msg_received_pme_to_ack                ( ),
  .cfg_msg_received_assert_int_a              ( ),
  .cfg_msg_received_assert_int_b              ( ),
  .cfg_msg_received_assert_int_c              ( ),
  .cfg_msg_received_assert_int_d              ( ),
  .cfg_msg_received_deassert_int_a            ( ),
  .cfg_msg_received_deassert_int_b            ( ),
  .cfg_msg_received_deassert_int_c            ( ),
  .cfg_msg_received_deassert_int_d            ( ),

   .cfg_msg_received_pm_pme                   ( ),
   .cfg_msg_received_setslotpowerlimit        ( ),
  //----------------------------------------------------------------------------------------------------------------//
  // 5. Physical Layer Control and Status (PL) Interface                                                            //
  //----------------------------------------------------------------------------------------------------------------//
  .pl_directed_link_change                    ( pl_directed_link_change ),
  .pl_directed_link_width                     ( pl_directed_link_width ),
  .pl_directed_link_speed                     ( pl_directed_link_speed ),
  .pl_directed_link_auton                     ( pl_directed_link_auton ),
  .pl_upstream_prefer_deemph                  ( pl_upstream_prefer_deemph ),

  .pl_sel_lnk_rate                            ( pl_sel_lnk_rate ),
  .pl_sel_lnk_width                           ( pl_sel_lnk_width ),
  .pl_ltssm_state                             ( pl_ltssm_state ),
  .pl_lane_reversal_mode                      ( pl_lane_reversal_mode ),

  .pl_phy_lnk_up                              ( ),
  .pl_tx_pm_state                             ( ),
  .pl_rx_pm_state                             ( ),

  .pl_link_upcfg_cap                          ( pl_link_upcfg_cap ),
  .pl_link_gen2_cap                           ( pl_link_gen2_cap ),
  .pl_link_partner_gen2_supported             ( pl_link_partner_gen2_supported ),
  .pl_initial_link_width                      ( pl_initial_link_width ),

  .pl_directed_change_done                    ( ),

  //------------------------------------------------//
  // EP Only                                        //
  //------------------------------------------------//
  .pl_received_hot_rst                        ( pl_received_hot_rst),

  //------------------------------------------------//
  // RP Only                                        //
  //------------------------------------------------//
  .pl_transmit_hot_rst                        ( 1'b0 ),
  .pl_downstream_deemph_source                ( 1'b0 ),

  //----------------------------------------------------------------------------------------------------------------//
  // 6. AER Interface                                                                                               //
  //----------------------------------------------------------------------------------------------------------------//

  .cfg_err_aer_headerlog                      ( cfg_err_aer_headerlog ),
  .cfg_aer_interrupt_msgnum                   ( cfg_aer_interrupt_msgnum ),
  .cfg_err_aer_headerlog_set                  ( cfg_err_aer_headerlog_set ),
  .cfg_aer_ecrc_check_en                      ( cfg_aer_ecrc_check_en ),
  .cfg_aer_ecrc_gen_en                        ( cfg_aer_ecrc_gen_en ),

  //----------------------------------------------------------------------------------------------------------------//
  // 7. VC interface                                                                                                //
  //----------------------------------------------------------------------------------------------------------------//

  .cfg_vc_tcvc_map                            ( ),

  //----------------------------------------------------------------------------------------------------------------//
  // 8. System  (SYS) Interface                                                                                     //
  //----------------------------------------------------------------------------------------------------------------//


  .PIPE_MMCM_RST_N                            ( PIPE_MMCM_RST_N     ),        // Async      | Async
  .sys_clk                                    ( sys_clk ),
  .sys_rst_n                                  ( pci_rst_n_c)
);

// Clock buffer for the 100MHz configuration clock
BUFG sysclk_buf_i (
  .I (sys_clk),
  .O (sysclk_buf)
);


//------------------------------------------------------------------------------
//migrating logic for pcie controller use K7 pcie_core 
//------------------------------------------------------------------------------
//----------------------------
//name change, polarity change
//-----------------------------
//tx
wire trn_clk = user_clk_out;
wire trn_reset_n = ~user_reset_q;
wire trn_lnk_up_n = ~user_lnk_up_q;
wire [7:0] trn_fc_ph;
assign trn_fc_ph = fc_ph;
wire [11:0] trn_fc_pd;
assign trn_fc_pd = fc_pd;
wire [7:0] trn_fc_nph;
assign trn_fc_nph = fc_nph;
wire [11:0] trn_fc_npd;
assign trn_fc_npd = fc_npd;
wire [7:0] trn_fc_cplh;
assign trn_fc_cplh = fc_cplh;
wire [11:0] trn_fc_cpld;
assign trn_fc_cpld = fc_cpld;
wire [2:0] trn_fc_sel;
assign fc_sel = trn_fc_sel;
wire trn_teof_n;
assign s_axis_tx_tlast = ~trn_teof_n;
wire trn_tsrc_rdy_n;
assign s_axis_tx_tvalid = ~trn_tsrc_rdy_n;
wire trn_tdst_rdy_n;
assign trn_tdst_rdy_n = ~s_axis_tx_tready;
wire trn_tsrc_dsc_n;
assign s_axis_tx_tuser[3] = ~trn_tsrc_dsc_n;
wire trn_tecrc_gen_n;
assign s_axis_tx_tuser[0] = ~trn_tecrc_gen_n;
wire [5:0] trn_tbuf_av;
assign trn_tbuf_av = tx_buf_av;
wire trn_terr_drop_n = ~tx_err_drop;
wire trn_tstr_n;
assign s_axis_tx_tuser[2]=~trn_tstr_n;
wire trn_tcfg_req_n = ~ tx_cfg_req;
wire trn_tcfg_gnt_n;
assign  tx_cfg_gnt = ~trn_tcfg_gnt_n;
wire trn_terrfwd_n;
assign  s_axis_tx_tuser[1] =  ~trn_terrfwd_n;

//rx
wire trn_reof_n = ~m_axis_rx_tlast;
wire trn_rerrfwd_n = ~m_axis_rx_tuser[1]; 
wire trn_rsrc_rdy_n = ~m_axis_rx_tvalid;
wire trn_rdst_rdy_n;
assign m_axis_rx_tready = ~trn_rdst_rdy_n;
wire [7:0] trn_rbar_hit_n = ~m_axis_rx_tuser[9:2];

//config
wire [31:0] cfg_do;
assign cfg_do = cfg_mgmt_do;
wire cfg_rd_wr_done=cfg_mgmt_rd_wr_done;
wire [31:0] cfg_di;
assign cfg_mgmt_di = cfg_di;
wire [9:0] cfg_dwaddr;
assign	cfg_dwaddr = 10'h3FF;
assign cfg_mgmt_dwaddr = cfg_dwaddr;

wire cfg_rd_wr_done_n = ~cfg_mgmt_rd_wr_done;// Name change; Polarity
wire [3:0] cfg_byte_en_n;
assign cfg_mgmt_byte_en[3:0] = ~ cfg_byte_en_n[3:0]; // Name change; Polarity
wire cfg_wr_en_n;
assign cfg_mgmt_wr_en= ~cfg_wr_en_n;//Name change; Polarity
wire cfg_rd_en_n;
assign	cfg_rd_en_n = 1'b1;

assign	pl_directed_link_auton = 1'b0;
assign	pl_directed_link_change = 2'b0;
assign	pl_directed_link_speed = 1'b0;
assign	pl_directed_link_width = 2'b0;
assign	pl_upstream_prefer_deemph = 1'b0;
  
assign cfg_mgmt_rd_en = ~cfg_rd_en_n;//Name change; Polarity
wire [2:0]cfg_pcie_link_state_n= cfg_pcie_link_state[2:0]; //Name change only
wire cfg_trn_pending_n;
assign cfg_trn_pending=~cfg_trn_pending_n; //Name change; Polarity
wire cfg_to_turnoff_n = ~cfg_to_turnoff; //Name change; Polarity
wire cfg_turnoff_ok_n;
assign cfg_turnoff_ok_n = 1'b0;
assign cfg_turnoff_ok= ~cfg_turnoff_ok_n;//Name change; Polarity
wire cfg_pm_wake_n;
assign cfg_pm_wake= ~cfg_pm_wake_n;//Name change; Polarity
wire cfg_interrupt_n;
assign cfg_interrupt = ~cfg_interrupt_n;//Name change; Polarity
wire cfg_interrupt_rdy_n = ~cfg_interrupt_rdy; //Name change; Polarity
wire cfg_interrupt_assert_n;
assign cfg_interrupt_assert = ~cfg_interrupt_assert_n;//Name change; Polarity
wire cfg_err_ecrc_n;
assign cfg_err_ecrc = cfg_err_ecrc_n; //Name change; Polarity
wire cfg_err_ur_n;
assign cfg_err_ur = ~cfg_err_ur_n; //Name change; Polarity
wire cfg_err_cpl_timeout_n;
assign cfg_err_cpl_timeout = ~cfg_err_cpl_timeout_n; //Name change; Polarity
wire cfg_err_cpl_unexpect_n;
assign cfg_err_cpl_unexpect=~cfg_err_cpl_unexpect_n; //Name change; Polarity
wire cfg_err_cpl_abort_n;
assign cfg_err_cpl_abort=~cfg_err_cpl_abort_n; //Name change; Polarity
wire cfg_err_posted_n;
assign cfg_err_posted=~cfg_err_posted_n; //Name change; Polarity
wire cfg_err_cor_n;
assign cfg_err_cor=~cfg_err_cor_n; //Name change; Polarity
wire cfg_err_cpl_rdy_n =~cfg_err_cpl_rdy; //Name change; Polarity
wire cfg_err_locked_n;
assign cfg_err_locked = ~cfg_err_locked_n;//Name change; Polarity

/*pl*/
wire pl_link_gen2_capable=pl_link_gen2_cap;
wire pl_link_upcfg_capable= pl_link_upcfg_cap;
wire pl_sel_link_rate =pl_sel_lnk_rate;
wire [1:0] pl_sel_link_width =pl_sel_lnk_width;
//-----------------------------------------
//name change, DW order
//------------------------------------------
wire [C_DBUS_WIDTH-1:0] trn_td;
assign s_axis_tx_tdata = {trn_td[31:0],trn_td[63:32]};
wire [C_DBUS_WIDTH-1:0] trn_rd;
assign trn_rd={m_axis_rx_tdata[31:0],m_axis_rx_tdata[63:32]}; //Name change; DWORD Ordering
//-----------------------------------------
//others
//------------------------------------------
reg in_packet_reg;
wire trn_rsof_n;
always @(posedge user_clk_out)begin
	if(!trn_reset_n)begin
		 in_packet_reg = 0;
		end
	else if (m_axis_rx_tvalid & m_axis_rx_tready) begin
		 in_packet_reg = !m_axis_rx_tlast;
		end
	end
assign trn_rsof_n = !(m_axis_rx_tvalid & !in_packet_reg);

wire 	trn_trem_n;
assign s_axis_tx_tkeep[7:0] = (s_axis_tx_tlast & trn_trem_n) ? 8'h0F : 8'hFF;

assign rx_np_ok = ~trn_rnp_ok_n;
assign rx_np_req = 1'b1;
//------------------------------------------------------
//additional signals
//------------------------------------------------------
assign cfg_mgmt_wr_readonly = 1'b0;
assign cfg_pm_halt_aspm_l0s = 1'b0; 
assign cfg_pm_halt_aspm_l1 = 1'b0;
assign cfg_pm_force_state[1:0] = 2'b00;
assign cfg_pm_force_state_en = 1'b0;
assign cfg_err_aer_headerlog[127:0]=0; 
assign cfg_aer_interrupt_msgnum = 5'b00000;
assign cfg_pciecap_interrupt_msgnum= 5'b00000;
assign cfg_interrupt_stat =1'b0;
assign cfg_err_malformed = 1'b0;
assign cfg_err_acs = 1'b0;
assign cfg_err_atomic_egress_blocked = 1'b0;
assign cfg_err_mc_blocked = 1'b0;
assign cfg_err_internal_uncor = 1'b0;
assign cfg_err_internal_cor = 1'b0;
assign cfg_err_norecovery = 1'b0;
assign cfg_err_poisoned = 1'b0;

assign trn_fc_sel = 3'b0; 
assign trn_tcfg_gnt_n = 1'b0;
assign trn_tecrc_gen_n = 1'b1;

assign cfg_err_cor_n = 1'b1;
assign cfg_err_ur_n = 1'b1;
assign cfg_err_ecrc_n = 1'b1;
assign cfg_err_cpl_timeout_n = 1'b1;
assign cfg_err_cpl_abort_n = 1'b1;
assign cfg_err_cpl_unexpect_n = 1'b1;
assign cfg_err_posted_n = 1'b0;
assign cfg_err_locked_n = 1'b0;
assign cfg_pm_wake_n = 1'b1;
assign cfg_trn_pending_n = 1'b1;
assign trn_tstr_n = 1'b0;
assign cfg_err_tlp_cpl_header = 47'h0;
assign cfg_di = 0;
assign cfg_byte_en_n = 4'hf;
assign cfg_wr_en_n = 1;
assign cfg_dsn = {32'h00000001,{{8'h1}, 24'h000A35}};  
wire        cfg_ext_tag_en           = cfg_dcommand[8];
wire  [2:0] cfg_prg_max_payload_size = cfg_dcommand[7:5];
wire  [2:0] cfg_max_rd_req_size      = cfg_dcommand[14:12];
wire        cfg_rd_comp_bound        = cfg_lcommand[3];
wire        cfg_bus_mstr_enable      = cfg_command[2]; 
wire	[7:0]	trn_trem;
assign trn_trem_n = (trn_trem == 8'h0F) ? 1'b1 : 1'b0;
wire	[7:0]	trn_rrem_n;
assign	trn_rrem_n[0] = m_axis_rx_tlast ? (m_axis_rx_tkeep == 8'hFF) ? 1'b0 : 1'b1: 1'b0;
assign	trn_rrem_n[7:1] = {4'b0000, trn_rrem_n[0] , trn_rrem_n[0] , trn_rrem_n[0]};

reg	trn_rsrc_dsc_n;
always@(posedge user_clk_out)
	trn_rsrc_dsc_n <= !user_lnk_up_q;

assign	trn_tdst_dsc_n = 1'b1;

//------------------------------------------------------------------------------------------------	
wire	[5:0]		pcie_link_width	= cfg_lstatus[9 : 4];
wire	[15:0]	localId  			= {cfg_bus_number , cfg_device_number , cfg_function_number};

assign	led[0]	= user_reset_q ^ !Format_Shower;
assign	led[1]	= user_lnk_up_q;
assign	led[2]	= !Format_Shower;
assign	led[3]	= trn_Blinker;
//-----------------------------------end pci express if--------------------------------

//   wire  										eb_wclk           		 	;
   wire  										eb_we             		 	;
   wire  [C_ASYNFIFO_WIDTH-1:0]			eb_din							;
   wire  										eb_pfull           			;
   wire  										eb_full            			;
//   wire  										eb_rclk            			;
   wire  										eb_re              			;
   wire  [C_ASYNFIFO_WIDTH-1:0]			eb_dout							;			
   wire  										eb_pempty          			;
   wire  										eb_empty           			;
   wire  [C_FIFO_DC_WIDTH : 0]			eb_data_count      			;
//   wire  										eb_rst             			;
			
	wire											fifo_reset_done				;
	wire											pio_reading_status			;
   wire  										eb_FIFO_ow         			;	
	
   wire  [C_DBUS_WIDTH-1 : 0]				eb_FIFO_Status     			;			
   wire  [C_DBUS_WIDTH-1 : 0]				H2B_FIFO_Status    			;			
   wire  [C_DBUS_WIDTH-1 : 0]				B2H_FIFO_Status    			;		
	
   wire  [C_FIFO_DC_WIDTH : 0]			H2B_wr_data_count  			;			
   wire  [C_FIFO_DC_WIDTH : 0]			B2H_rd_data_count  			;	
			
   wire  										eb_valid           			;	

generate
    if (USE_LOOPBACK_TEST) begin: LoopBack_FIFO_On
			eb_wrapper_loopback eb_wrapper_loopback_inst (
				 .wr_clk			(user_clk_out), 
				 .wr_en			(eb_we), 
				 .din				(eb_din), 
				 .pfull			(eb_pfull), 
				 .full			(eb_full), 
				 .rd_clk			(user_clk_out), 
				 .rd_en			(eb_re), 
				 .dout			(eb_dout), 
				 .pempty			(eb_pempty), 
				 .empty			(eb_empty), 
				 .data_count	(eb_data_count[C_EMU_FIFO_DC_WIDTH : 1]), 
				 .rst				(eb_rst)
				 );
			assign	eb_data_count[C_FIFO_DC_WIDTH : C_EMU_FIFO_DC_WIDTH+1] = 0;
			assign	eb_data_count[0]= 0;
			assign	fifo_reset_done = ~ eb_rst;
			assign	eb_FIFO_ow      = eb_we & eb_full;
			assign	eb_din[C_ASYNFIFO_WIDTH-1 : C_DBUS_WIDTH]       = 0;

			assign	eb_FIFO_Status[C_DBUS_WIDTH-1 : C_FIFO_DC_WIDTH+3]	 = 0;
			assign	eb_FIFO_Status[C_FIFO_DC_WIDTH+2 : 3] = eb_data_count[C_FIFO_DC_WIDTH : 1];
			assign	eb_FIFO_Status[2]    = 0; 
			assign	eb_FIFO_Status[1]    = eb_pfull;
			assign	eb_FIFO_Status[0]    = eb_empty & fifo_reset_done;
			assign	H2B_FIFO_Status = 0;	 
			assign	B2H_FIFO_Status = 0;	  	
	  
		end else if (!USE_LOOPBACK_TEST)begin: LoopBack_FIFO_Off
			eb_wrapper eb_wrapper_inst (
				 .H2B_wr_clk			(user_clk_out), 
				 .H2B_wr_en				(eb_we), 
				 .H2B_wr_din			(eb_din), 
				 .H2B_wr_pfull			(eb_pfull), 
				 .H2B_wr_full			(eb_full), 
				 .H2B_wr_data_count	(H2B_wr_data_count[C_EMU_FIFO_DC_WIDTH:1]),
				 
				 .H2B_rd_clk			(user_clk_out), 
				 .H2B_rd_en				(user_rd_en), 
				 .H2B_rd_dout			(user_rd_dout), 
				 .H2B_rd_pempty		(user_rd_pempty), 
				 .H2B_rd_empty			(user_rd_empty), 
				 .H2B_rd_data_count	(user_rd_data_count), 
				 .H2B_rd_valid			(user_rd_valid), 
				 
				 .B2H_wr_clk			(user_clk_out), 
				 .B2H_wr_en				(user_wr_en), 
				 .B2H_wr_din			(user_wr_din), 
				 .B2H_wr_pfull			(user_wr_pfull), 
				 .B2H_wr_full			(user_wr_full), 
				 .B2H_wr_data_count	(user_wr_data_count),
				 
				 .B2H_rd_clk			(user_clk_out), 
				 .B2H_rd_en				(eb_re), 
				 .B2H_rd_dout			(eb_dout), 
				 .B2H_rd_pempty		(eb_pempty), 
				 .B2H_rd_empty			(eb_empty), 
				 .B2H_rd_data_count	(B2H_rd_data_count[C_EMU_FIFO_DC_WIDTH:1]), 
				 .B2H_rd_valid			(eb_valid), 
				 .rst						(eb_rst)
				 );


		//64 bits to 32 bits transformation ( --> Count * 2]//
		assign	B2H_rd_data_count[C_FIFO_DC_WIDTH : C_EMU_FIFO_DC_WIDTH+1] = 11'b0;
      assign	B2H_rd_data_count[0] = 1'b0;       
                      
      assign	H2B_wr_data_count[C_FIFO_DC_WIDTH : C_EMU_FIFO_DC_WIDTH+1] = 11'b0;
      assign	H2B_wr_data_count[0] = 1'b0;       
							 

		//Hybrid FIFO Signal used by PCIe interface and Linux Driver
      assign	eb_FIFO_ow      = eb_we & eb_full;
      assign	fifo_reset_done = ~ eb_rst;
      assign	eb_din[C_ASYNFIFO_WIDTH-1 : C_DBUS_WIDTH] = 8'b0;
		assign	eb_data_count   = B2H_rd_data_count;

		//Hybrid FIFO Status used by PCIe interface and Linux Driver ---
		//read: status ; write: reset H2B and B2H FIFO
      assign	eb_FIFO_Status[C_DBUS_WIDTH-1 : C_FIFO_DC_WIDTH+3] = 35'b0;
      assign	eb_FIFO_Status[C_FIFO_DC_WIDTH+2 : 3] = B2H_rd_data_count[C_FIFO_DC_WIDTH : 1];
      assign	eb_FIFO_Status[2]    = 1'b0;      
      assign	eb_FIFO_Status[1]    = eb_pfull;
      assign	eb_FIFO_Status[0]    = eb_empty & fifo_reset_done;


		//Host2Board FIFO status used by user ---
		//read: H2B status ; write: nothing 
      assign	H2B_FIFO_Status[C_DBUS_WIDTH-1 : C_FIFO_DC_WIDTH+3] = 35'b0;
      assign	H2B_FIFO_Status[C_FIFO_DC_WIDTH+2 : 3] = H2B_wr_data_count[C_FIFO_DC_WIDTH : 1];
      assign	H2B_FIFO_Status[2]    = 1'b0;
      assign	H2B_FIFO_Status[1]    = eb_pfull;
      assign	H2B_FIFO_Status[0]    = eb_full & fifo_reset_done;


		//Board2Host FIFO status used by user ---
		//read: B2H status ; write: nothing 
      assign	B2H_FIFO_Status[C_DBUS_WIDTH-1 : C_FIFO_DC_WIDTH+3] = 35'b0;
      assign	B2H_FIFO_Status[C_FIFO_DC_WIDTH+2 : 3] = B2H_rd_data_count[C_FIFO_DC_WIDTH : 1];
      assign	B2H_FIFO_Status[2]    = eb_valid;
      assign	B2H_FIFO_Status[1]    = eb_pempty;
      assign	B2H_FIFO_Status[0]    = eb_empty & fifo_reset_done;
		
		end
endgenerate

   wire    	DDR_wr_sof              ;
   wire    	DDR_wr_eof              ;
   wire    	DDR_wr_v                ;
   wire    	DDR_wr_FA               ;
   wire    	DDR_wr_Shift            ;
   wire    	[1:0]	DDR_wr_Mask       ;
   wire    	[C_DBUS_WIDTH-1 : 0] DDR_wr_din;
   wire    	DDR_wr_full             ;
	
   wire    	DDR_rdc_sof             ;
   wire    	DDR_rdc_eof             ;
   wire    	DDR_rdc_v               ;
   wire    	DDR_rdc_FA              ;
   wire    	DDR_rdc_Shift           ;
   wire    	[C_DBUS_WIDTH-1 : 0] DDR_rdc_din;
   wire    	DDR_rdc_full            ;
	
   wire    	DDR_FIFO_RdEn           ; 
   wire    	DDR_FIFO_Empty          ;
   wire    	[C_DBUS_WIDTH-1 : 0] DDR_FIFO_RdQout;
	
   wire    	DDR_Ready               ;
   wire    	DDR_Blinker             ;
	
	wire		Sim_Zeichen					;
generate
    if (USE_LOOPBACK_TEST) begin: LoopBack_BRAM_On
			bram_DDRs_Control_loopback #(
				.C_ASYNFIFO_WIDTH(C_ASYNFIFO_WIDTH),
				.P_SIMULATION(0)			
			)	bram_DDRs_Control_loopback_inst (
				 .DDR_wr_sof			(DDR_wr_sof), 
				 .DDR_wr_eof			(DDR_wr_eof), 
				 .DDR_wr_v				(DDR_wr_v), 
				 .DDR_wr_FA				(DDR_wr_FA), 
				 .DDR_wr_Shift			(DDR_wr_Shift), 
				 .DDR_wr_Mask			(DDR_wr_Mask), 
				 .DDR_wr_din			(DDR_wr_din), 
				 .DDR_wr_full			(DDR_wr_full), 
				 
				 .DDR_rdc_sof			(DDR_rdc_sof), 
				 .DDR_rdc_eof			(DDR_rdc_eof), 
				 .DDR_rdc_v				(DDR_rdc_v), 
				 .DDR_rdc_FA			(DDR_rdc_FA), 
				 .DDR_rdc_Shift		(DDR_rdc_Shift), 
				 .DDR_rdc_din			(DDR_rdc_din), 
				 .DDR_rdc_full			(DDR_rdc_full), 
				 
				 .DDR_FIFO_RdEn		(DDR_FIFO_RdEn), 
				 .DDR_FIFO_Empty		(DDR_FIFO_Empty), 
				 .DDR_FIFO_RdQout		(DDR_FIFO_RdQout), 
				 
				 .DDR_Ready				(DDR_Ready), 
				 .DDR_blinker			(DDR_blinker), 
				 .Sim_Zeichen			(Sim_Zeichen), 
				 .mem_clk				(user_clk_out), 
				 .trn_clk				(user_clk_out), 
				 .trn_reset_n			(trn_reset_n)
				 );	 
		end else if (!USE_LOOPBACK_TEST)begin: LoopBack_BRAM_Off		
			bram_DDRs_Control #(
				.C_ASYNFIFO_WIDTH(C_ASYNFIFO_WIDTH),
				.P_SIMULATION(0)			
			)	bram_DDRs_Control_inst 		
			(
				 .user_wr_weA			(user_wr_weA), 
				 .user_wr_addrA		(user_wr_addrA), 
				 .user_wr_dinA			(user_wr_dinA), 
				 .user_rd_addrB		(user_rd_addrB), 
				 .user_rd_doutB		(user_rd_doutB), 
				 .user_rd_clk			(user_clk_out), 
				 .user_wr_clk			(user_clk_out), 
				 
				 .DDR_wr_sof			(DDR_wr_sof), 
				 .DDR_wr_eof			(DDR_wr_eof), 
				 .DDR_wr_v				(DDR_wr_v), 
				 .DDR_wr_FA				(DDR_wr_FA), 
				 .DDR_wr_Shift			(DDR_wr_Shift), 
				 .DDR_wr_Mask			(DDR_wr_Mask), 
				 .DDR_wr_din			(DDR_wr_din), 
				 .DDR_wr_full			(DDR_wr_full), 
				 
				 .DDR_rdc_sof			(DDR_rdc_sof), 
				 .DDR_rdc_eof			(DDR_rdc_eof), 
				 .DDR_rdc_v				(DDR_rdc_v), 
				 .DDR_rdc_FA			(DDR_rdc_FA), 
				 .DDR_rdc_Shift		(DDR_rdc_Shift), 
				 .DDR_rdc_din			(DDR_rdc_din), 
				 .DDR_rdc_full			(DDR_rdc_full), 
				 
				 .DDR_FIFO_RdEn		(DDR_FIFO_RdEn), 
				 .DDR_FIFO_Empty		(DDR_FIFO_Empty), 
				 .DDR_FIFO_RdQout		(DDR_FIFO_RdQout), 
				 
				 .DDR_Ready				(DDR_Ready), 
				 .DDR_blinker			(DDR_blinker), 
				 .Sim_Zeichen			(Sim_Zeichen), 
				 .mem_clk				(user_clk_out), 
				 .trn_clk				(trn_clk), 
				 .trn_reset_n			(trn_reset_n)
				 );
		end
endgenerate

//UserLogic Signals, not Used	
	wire   	[1:0] 							protocol_link_act   		= 2'b0;
	wire   										protocol_rst       				;
	wire   										daq_rstop          				;
	wire   										ctl_rv             				;
	wire   	[C_DBUS_WIDTH/2-1 : 0]		ctl_rd 								;
	wire   										ctl_ttake      	    			;
	wire   										ctl_tv         	    	= 0	;
	wire   	[C_DBUS_WIDTH/2-1 : 0] 		ctl_td 						= 0	;
	wire   										ctl_tstop      	    			;
	wire   										ctl_reset      	    			;
	wire   	[C_DBUS_WIDTH/2-1 : 0]		ctl_status					= 0	;	
	wire   										dlm_tv         	    			;
	wire   	[C_DBUS_WIDTH/2-1 : 0]		dlm_td								;	
	wire   										dlm_rv         	    	= 0	;
	wire   	[C_DBUS_WIDTH/2-1 : 0]		dlm_rd 						= 0	;
   wire   	[1:0]								tab_we         	   			;
   wire   	[11:0]							tab_wa         		    		;
   wire   	[C_DBUS_WIDTH-1 : 0] 		tab_wd      						;
   wire   										dg_running        		= 0	;
   wire   										dg_rst            				;
   wire   										dg_mask           				;

//UserLogic Signals, not Used
	wire											Format_Shower						;
   wire  										eb_wsof								;
   wire  										eb_weof								;		
	

	wire		[7:0]								IrptStatesOut						;    

   wire   										Regs_WrEn0							;
   wire    [1:0]								Regs_WrMask0						;
   wire    [15 : 0]  						Regs_WrAddr0						;
   wire    [C_DBUS_WIDTH-1 : 0]  		Regs_WrDin0							;

   wire   										Regs_WrEn1  						;
   wire    [1:0]								Regs_WrMask1						;
   wire    [15 : 0]  						Regs_WrAddr1						;
   wire    [C_DBUS_WIDTH-1 : 0]  		Regs_WrDin1 						;

tlpControl tlpControl_inst(
      //Test pin, emulating DDR data flow discontinuity
      .mbuf_UserFull					(1'b0),
      .trn_Blinker					(trn_Blinker),//output
      //Interrupter triggers
      .DAQ_irq							(DAQ_irq),                
      .CTL_irq							(CTL_irq),                
      .DLM_irq							(DLM_irq),	
		.DAQTOUT_irq 					(DAQTOUT_irq),
		.CTLTOUT_irq 					(CTLTOUT_irq),
		.DLMTOUT_irq					(DLMTOUT_irq),		
		.Sys_Int_Enable				(Sys_Int_Enable),
      //DCB protocol interface
      .protocol_link_act			(protocol_link_act),     
      .protocol_rst					(protocol_rst), 
		.Link_Buf_full					(daq_rstop),
      //Fabric side: CTL Rx
      .ctl_rv							(ctl_rv),                 
      .ctl_rd							(ctl_rd),                 

      //Fabric side: CTL Tx
      .ctl_ttake						(ctl_ttake	),              
      .ctl_tv							(ctl_tv		),                 
      .ctl_td							(ctl_td		),              
      .ctl_tstop						(ctl_tstop	), 
      .ctl_reset						(ctl_reset	),              
      .ctl_status						(ctl_status),             

      //Fabric side: DLM Rx
      .dlm_tv							(dlm_tv),                 
      .dlm_td							(dlm_td),                 
							
      //Fabric side: DLM Tx
      .dlm_rv							(dlm_rv),                 
      .dlm_rd							(dlm_rd),  
		
      //Data generator table write
      .tab_we  				(tab_we),                 
      .tab_wa  				(tab_wa),                 
      .tab_wd  				(tab_wd),                 
				
      .DG_is_Running  		(dg_running),          
      .DG_Reset       		(dg_rst ),          
      .DG_Mask        		(dg_mask),   
		
		//User Register: PC-->FPGA
		.reg01_tv(reg_tv[0]),   .reg01_td(reg01_td),	.reg02_tv(reg_tv[1]),  .reg02_td(reg02_td),                   
		.reg03_tv(reg_tv[2]),   .reg03_td(reg03_td),	.reg04_tv(reg_tv[3]),  .reg04_td(reg04_td),                   
		.reg05_tv(reg_tv[4]),   .reg05_td(reg05_td),  .reg06_tv(reg_tv[5]),  .reg06_td(reg06_td),                   
		.reg07_tv(reg_tv[6]),   .reg07_td(reg07_td),  .reg08_tv(reg_tv[7]),  .reg08_td(reg08_td),                   
		.reg09_tv(reg_tv[8]),   .reg09_td(reg09_td),  .reg10_tv(reg_tv[9]),  .reg10_td(reg10_td),                   
		.reg11_tv(reg_tv[10]),   .reg11_td(reg11_td),  .reg12_tv(reg_tv[11]),  .reg12_td(reg12_td),                   
		.reg13_tv(reg_tv[12]),   .reg13_td(reg13_td),  .reg14_tv(reg_tv[13]),  .reg14_td(reg14_td),                   

		.reg15_tv(reg_tv[14]),   .reg15_td(reg15_td),  .reg16_tv(reg_tv[15]),  .reg16_td(reg16_td), 
		.reg17_tv(reg_tv[16]),   .reg17_td(reg17_td),  .reg18_tv(reg_tv[17]),  .reg18_td(reg18_td), 		
		.reg19_tv(reg_tv[18]),   .reg19_td(reg19_td),  .reg20_tv(reg_tv[19]),  .reg20_td(reg20_td), 
		
		.reg21_tv(reg_tv[20]),   .reg21_td(reg21_td),  .reg22_tv(reg_tv[21]),  .reg22_td(reg22_td), 
		.reg23_tv(reg_tv[22]),   .reg23_td(reg23_td),  .reg24_tv(reg_tv[23]),  .reg24_td(reg24_td), 		
		.reg25_tv(reg_tv[24]),   .reg25_td(reg25_td),
		
		//User Register: FPGA-->PC
		.reg01_rv(reg_rv[0]),   .reg01_rd(reg01_rd), 	.reg02_rv(reg_rv[1]),   .reg02_rd(reg02_rd),                   
		.reg03_rv(reg_rv[2]),   .reg03_rd(reg03_rd), 	.reg04_rv(reg_rv[3]),   .reg04_rd(reg04_rd),
		.reg05_rv(reg_rv[4]),   .reg05_rd(reg05_rd), 	.reg06_rv(reg_rv[5]),	  .reg06_rd(reg06_rd),
		.reg07_rv(reg_rv[6]),   .reg07_rd(reg07_rd),  .reg08_rv(reg_rv[7]),   .reg08_rd(reg08_rd),                   
		.reg09_rv(reg_rv[8]),   .reg09_rd(reg09_rd),  .reg10_rv(reg_rv[9]),   .reg10_rd(reg10_rd),                   
		.reg11_rv(reg_rv[10]),   .reg11_rd(reg11_rd),  .reg12_rv(reg_rv[11]),   .reg12_rd(reg12_rd),                   
		.reg13_rv(reg_rv[12]),   .reg13_rd(reg13_rd),  .reg14_rv(reg_rv[13]),   .reg14_rd(reg14_rd),

		.reg15_rv(reg_rv[14]),   .reg15_rd(reg15_rd),  .reg16_rv(reg_rv[15]),   .reg16_rd(reg16_rd),
		.reg17_rv(reg_rv[16]),   .reg17_rd(reg17_rd),  .reg18_rv(reg_rv[17]),   .reg18_rd(reg18_rd),
		.reg19_rv(reg_rv[18]),   .reg19_rd(reg19_rd),  .reg20_rv(reg_rv[19]),   .reg20_rd(reg20_rd),

		.reg21_rv(reg_rv[20]),   .reg21_rd(reg21_rd),  .reg22_rv(reg_rv[21]),   .reg22_rd(reg22_rd),
		.reg23_rv(reg_rv[22]),   .reg23_rd(reg23_rd),  .reg24_rv(reg_rv[23]),   .reg24_rd(reg24_rd),
		.reg25_rv(reg_rv[24]),   .reg25_rd(reg25_rd),  
		
		//User debug wires
		.debug_in_1i(debug_in_1i),		 
		.debug_in_2i(debug_in_2i),			 
		.debug_in_3i(debug_in_3i),					
		.debug_in_4i(debug_in_4i),	
			
      //Event Buffer FIFO interface
      .eb_FIFO_we				(eb_we	),               
      .eb_FIFO_wsof			(eb_wsof	),             
      .eb_FIFO_weof			(eb_weof	),             
      .eb_FIFO_din			(eb_din[C_DBUS_WIDTH-1 : 0]),              
      .eb_FIFO_re 			(eb_re 	),              
      .eb_FIFO_empty			(eb_empty),            
      .eb_FIFO_qout			(eb_dout[C_DBUS_WIDTH-1 : 0]),             
      .eb_FIFO_ow 			(eb_FIFO_ow 	),  
      .eb_FIFO_data_count	(eb_data_count),  
      .pio_reading_status	(pio_reading_status),       
      .eb_FIFO_Status		(eb_FIFO_Status),           
      .eb_FIFO_Rst			(eb_rst),      
	   .H2B_FIFO_Status		(H2B_FIFO_Status),    		
 	   .B2H_FIFO_Status		(B2H_FIFO_Status), 
     
      //Debugging wires
      .DMA_us_Done			(DMA_us_Done	),              
      .DMA_us_Busy			(DMA_us_Busy	),              
      .DMA_us_Busy_LED		(),          
      .DMA_ds_Done 			(DMA_ds_Done 	),             
      .DMA_ds_Busy 			(DMA_ds_Busy 	),             
      .DMA_ds_Busy_LED 		(),     
		
		.dsDMA_Start     		(dsDMA_Start		),  
		.dsDMA_Stop        	(dsDMA_Stop       ),  
		.dsDMA_Start2      	(dsDMA_Start2     ),  
		.dsDMA_Stop2       	(dsDMA_Stop2      ),  
		.dsDMA_Channel_Rst 	(dsDMA_Channel_Rst),  

		.usDMA_Start     		(usDMA_Start		),  
		.usDMA_Stop        	(usDMA_Stop       ),  
		.usDMA_Start2      	(usDMA_Start2     ),  
		.usDMA_Stop2       	(usDMA_Stop2      ),  
		.usDMA_Channel_Rst 	(usDMA_Channel_Rst), 
		
		.DMA_us_PA   			(DMA_us_PA),
		.DMA_us_HA   			(DMA_us_HA),
		.DMA_us_BDA  			(DMA_us_BDA),
		.DMA_us_Length 		(DMA_us_Length),
		.DMA_us_Control 		(DMA_us_Control),
		
		.DMA_ds_PA   			(DMA_ds_PA),
		.DMA_ds_HA   			(DMA_ds_HA),
		.DMA_ds_BDA  			(DMA_ds_BDA),
		.DMA_ds_Length 		(DMA_ds_Length),
		.DMA_ds_Control 		(DMA_ds_Control),
		
		.Regs_WrEn0				( Regs_WrEn0	 ),
		.Regs_WrMask0			( Regs_WrMask0  ),
		.Regs_WrAddr0			( Regs_WrAddr0  ),
		.Regs_WrDin0 			( Regs_WrDin0   ),
			                    	
		.Regs_WrEn1  			( Regs_WrEn1  ),
		.Regs_WrMask1			( Regs_WrMask1),
		.Regs_WrAddr1			( Regs_WrAddr1),
		.Regs_WrDin1 			( Regs_WrDin1 ),
		
     //DDR control interface
      .DDR_Ready				(DDR_Ready		), 
      .DDR_wr_sof 			(DDR_wr_sof 	),              
      .DDR_wr_eof 			(DDR_wr_eof 	),              
      .DDR_wr_v   			(DDR_wr_v   	),              
      .DDR_wr_FA  			(DDR_wr_FA  	),              
      .DDR_wr_Shift			(DDR_wr_Shift	),             
      .DDR_wr_Mask 			(DDR_wr_Mask 	),             
      .DDR_wr_din  			(DDR_wr_din  	),             
      .DDR_wr_full 			(DDR_wr_full 	), 
      .DDR_rdc_sof			(DDR_rdc_sof	),              
      .DDR_rdc_eof			(DDR_rdc_eof	),              
      .DDR_rdc_v   			(DDR_rdc_v   	),             
      .DDR_rdc_FA 			(DDR_rdc_FA 	),              
      .DDR_rdc_Shift			(DDR_rdc_Shift	),            
      .DDR_rdc_din  			(DDR_rdc_din  	),            
      .DDR_rdc_full 			(DDR_rdc_full 	), 
      //DDR payload FIFO Read Port
      .DDR_FIFO_RdEn  		(DDR_FIFO_RdEn  ),          
      .DDR_FIFO_Empty 		(DDR_FIFO_Empty ),          
      .DDR_FIFO_RdQout		(DDR_FIFO_RdQout), 
      //Common interface
      .trn_clk       		(trn_clk),           
      .trn_reset_n    		(trn_reset_n),          
      .trn_lnk_up_n  		(trn_lnk_up_n),           

      //Transaction receive interface
      .trn_rsof_n				(trn_rsof_n), //AXI4-Stream does not have equivalent signals for start-of-frame (trn_tsof_nand 
												//trn_rsof_n) in the 32-bit and 64-bit versions.  
												//On the transmit side, existing TRN designs can just leave the user trn_tsof_n connection unconnected. 
												//On the receive side, existing TRN designs can recreate trn_rsof_n using simple logic, if necessary.   
      .trn_reof_n						(trn_reof_n),    //1           
      .trn_rd							(trn_rd),   //64                
      .trn_rrem_n						(trn_rrem_n),  //8             
      .trn_rerrfwd_n					(trn_rerrfwd_n),  //1          
      .trn_rsrc_rdy_n				(trn_rsrc_rdy_n),           
      .trn_rdst_rdy_n				(trn_rdst_rdy_n),
      .trn_rnp_ok_n					(trn_rnp_ok_n),  
      .trn_rsrc_dsc_n				(trn_rsrc_dsc_n),           
      .trn_rbar_hit_n				(trn_rbar_hit_n),     //7      

      //Transaction transmit interface
      .trn_tsof_n						(trn_tsof_n),              
      .trn_teof_n						(trn_teof_n),             
      .trn_td							(trn_td),             //64     
      .trn_trem_n						(trn_trem),        //8      
      .trn_terrfwd_n					(trn_terrfwd_n),  
      .trn_tsrc_rdy_n				(trn_tsrc_rdy_n), 
      .trn_tdst_rdy_n				(trn_tdst_rdy_n),          
      .trn_tsrc_dsc_n				(trn_tsrc_dsc_n),      
      .trn_tdst_dsc_n				(trn_tdst_dsc_n),          
      .trn_tbuf_av					(trn_tbuf_av),      //6

      //Interrupt Interface
		.cfg_interrupt_n				(cfg_interrupt_n			),        
		.cfg_interrupt_rdy_n			(cfg_interrupt_rdy_n		),     
		.cfg_interrupt_mmenable		(cfg_interrupt_mmenable	),  //3
		.cfg_interrupt_msienable	(cfg_interrupt_msienable), 
		.cfg_interrupt_di				(cfg_interrupt_di			),   //8     
		.cfg_interrupt_do				(cfg_interrupt_do			),     //8   
		.cfg_interrupt_assert_n		(cfg_interrupt_assert_n	),  

		.Irpt_Req						(Irpt_Req),
		.Irpt_RE							(Irpt_RE),
		.IrptStatesOut					(IrptStatesOut),
		.Interrupts_ORed				(Interrupts_ORed),
		
      .Format_Shower					(Format_Shower),    
				
      //Local wires		
      .pcie_link_width				(pcie_link_width),       //6 
      .cfg_dcommand					(cfg_dcommand),           //16
      .localID							(localId)                //16
);	
		 
endmodule
