
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.abb64Package.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Interrupts is
    port (
      -- System Interrupt register from Registers module
      Sys_IRQ                     : IN  std_logic_vector(C_DBUS_WIDTH-1   downto 0);

      -- Interrupt generator signals
      IG_Reset                    : IN  std_logic;
      IG_Host_Clear               : IN  std_logic;
      IG_Latency                  : IN  std_logic_vector(C_DBUS_WIDTH-1   downto 0);
      IG_Num_Assert               : OUT std_logic_vector(C_DBUS_WIDTH-1   downto 0);
      IG_Num_Deassert             : OUT std_logic_vector(C_DBUS_WIDTH-1   downto 0);
      IG_Asserting                : OUT std_logic;
 

      -- Interrupt Interface 
      cfg_interrupt_n             : OUT std_logic;
      cfg_interrupt_rdy_n         : IN  std_logic;
      cfg_interrupt_mmenable      : IN  std_logic_VECTOR(2 downto 0);
      cfg_interrupt_msienable     : IN  std_logic;
      cfg_interrupt_di            : OUT std_logic_VECTOR(7 downto 0);
      cfg_interrupt_do            : IN  std_logic_VECTOR(7 downto 0);
      cfg_interrupt_assert_n      : OUT std_logic;

      -- Irpt Channel
      Irpt_Req                    : OUT std_logic;
      Irpt_RE                     : IN  std_logic;
      Irpt_Qout                   : OUT std_logic_vector(C_CHANNEL_BUF_WIDTH-1 downto 0);

		IrptStatesOut					 : OUT std_logic_VECTOR(7 downto 0);
		Interrupts_ORed				 : OUT std_logic;	

      DAQTOUT_irq                  : IN  std_logic;
      CTLTOUT_irq                  : IN  std_logic;
      DLMTOUT_irq                  : IN  std_logic;
		
      DAQ_irq                  : IN  std_logic;
      CTL_irq                  : IN  std_logic;
      DLM_irq                  : IN  std_logic;		
		
      -- Clock and reset
      trn_clk                     : IN  std_logic;
      trn_reset_n                 : IN  std_logic

    );
end Interrupts;


architecture Behavioral of Interrupts is

  -- State machine: Interrupt control
  type IrptStates is              ( IntST_RST
                                  , IntST_Idle
                                  , IntST_Asserting
                                  , IntST_Asserted
                                  , IntST_Deasserting
                                  );

  signal edge_Intrpt_State        : IrptStates;
  signal level_Intrpt_State       : IrptStates;

  signal cfg_interrupt_n_i        : std_logic;
  signal cfg_interrupt_rdy_n_i    : std_logic;
  signal cfg_interrupt_di_i       : std_logic_vector(7 downto 0);
  signal cfg_interrupt_assert_n_i : std_logic;

  signal edge_Irpt_Req_i          : std_logic;
  signal level_Irpt_Req_i         : std_logic;

  signal Irpt_RE_i                : std_logic;
  signal Irpt_Qout_i              : std_logic_vector(C_CHANNEL_BUF_WIDTH-1 downto 0)
                                  := (OTHERS=>'0');

  signal Msg_Tag_Lo               : std_logic_vector( 3 downto 0);
  signal Msg_Code                 : std_logic_vector( 7 downto 0);

  signal edge_MsgCode_is_ASSERT   : std_logic;
  signal level_MsgCode_is_ASSERT  : std_logic;

  signal IrptStatesOut_i			 : std_logic_vector(7 downto 0);
  signal Interrupts_ORed_i        : std_logic;

  -- Interrupt Generator 
  signal IG_Trigger_i             : std_logic;

  -- Interrupt Generator Counter
  signal IG_Counter               : std_logic_vector(C_CNT_GINT_WIDTH-1 downto 0);
  signal IG_Run                   : std_logic;
  signal IG_Run_DAQ               : std_logic;

  -- Interrupt Generator Statistic: Assert number
  signal IG_Num_Assert_i          : std_logic_vector(C_DBUS_WIDTH-1   downto 0);

  -- Interrupt Generator Statistic: Deassert number
  signal IG_Num_Deassert_i        : std_logic_vector(C_DBUS_WIDTH-1   downto 0);

  -- Interrupt Generator indicator
  signal IG_Asserting_i           : std_logic;

--  signal DAQ_irq_i					: std_logic;
--  signal CTL_irq_i					: std_logic;
--  signal DLM_irq_i					: std_logic;
	
begin

  -- Interrupt interface
  -- cfg_interrupt_n should be explicitly clarified!
  cfg_interrupt_assert_n          <= cfg_interrupt_assert_n_i;
  cfg_interrupt_rdy_n_i           <= cfg_interrupt_rdy_n;
  -- Only Legacy IntA for the moment ...
  cfg_interrupt_di                <= cfg_interrupt_di_i;
  cfg_interrupt_di_i              <= (Others=>'0');

  -- Channel mode interface.
  Irpt_RE_i       <= Irpt_RE;
  Irpt_Qout       <= Irpt_Qout_i;
  
  Interrupts_ORed <= Interrupts_ORed_i;
  IrptStatesOut <= IrptStatesOut_i;
  
--  DAQ_irq_i <= DAQ_irq;
--  CTL_irq_i <= CTL_irq; 
--  DLM_irq_i <= DLM_irq;  
--  ---------------------------------------------------
--  emulates a channel buffer output
--     Note: Type not shows in this buffer
--
--  127 ~  97 : reserved
--         96 : reserved
--         95 : reserved
--         94 : Valid
--   93 ~  35 : reserved
--   34 ~  27 : Msg code
--   26 ~  19 : Tag
--
--   18 ~  17 : Format
--   16 ~  14 : TC
--         13 : TD
--         12 : EP
--   11 ~  10 : Attribute
--    9 ~   0 : Length
-- 
  Irpt_Qout_i(C_CHBUF_QVALID_BIT)                                       <= '1';
  Irpt_Qout_i(C_CHBUF_TAG_BIT_TOP downto C_CHBUF_TAG_BIT_BOT)           <= C_MSG_TAG_HI & Msg_Tag_Lo;
  Irpt_Qout_i(C_CHBUF_MSG_CODE_BIT_TOP downto C_CHBUF_MSG_CODE_BIT_BOT) <= Msg_Code;
  Irpt_Qout_i(C_CHBUF_FMT_BIT_TOP downto C_CHBUF_FMT_BIT_BOT)           <= C_FMT4_NO_DATA;
  Irpt_Qout_i(C_CHBUF_LENG_BIT_TOP downto C_CHBUF_LENG_BIT_BOT)         <= C_ALL_ZEROS(C_CHBUF_LENG_BIT_TOP downto C_CHBUF_LENG_BIT_BOT);


	IG_Run_DAQ <= IG_Run AND (DLM_irq OR DLMTOUT_irq);--Sys_IRQ(8)
-- ---------------------------------------------------------------
-- All Interrups are OR'ed
--
   Syn_Interrupts_ORed:
   process ( trn_clk )
   begin
      if trn_clk'event and trn_clk = '1' then
         if Sys_IRQ(C_NUM_OF_INTERRUPTS-1 downto 0)
              = C_ALL_ZEROS(C_NUM_OF_INTERRUPTS-1 downto 0)
            then
            Interrupts_ORed_i      <= '0';
         else
            Interrupts_ORed_i      <= '1';
         end if;
      end if;
   end process;



-------------------------------------------
---- Cfg Interface mode
-------------------------------------------
 Gen_Cfg_Irpt: if USE_CFG_INTERRUPT generate

   cfg_interrupt_n      <= cfg_interrupt_n_i;
   --Irpt_Req             <= '0';               -- Cfg interface mode, channel disabled.
	Irpt_Req             <= level_Irpt_Req_i;
   Msg_Code             <= (Others=>'0');
	
   States_Machine_Irpt:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         edge_Intrpt_State      <= IntST_RST;
         cfg_interrupt_n_i <= '1';
         cfg_interrupt_assert_n_i  <= '1';
			
			level_Irpt_Req_i        <= '0';
			IrptStatesOut_i <= "00000000";
			
      elsif trn_clk'event and trn_clk = '1' then

        case edge_Intrpt_State is

          when IntST_RST =>----0
              edge_Intrpt_State      <= IntST_Idle;
              cfg_interrupt_n_i <= '1';
              cfg_interrupt_assert_n_i  <= '1';
				  
				  level_Irpt_Req_i        <= '0';
				  IrptStatesOut_i <= "00000001";
				  
          when IntST_Idle =>----1
            if Interrupts_ORed_i='1' then
              edge_Intrpt_State      <= IntST_Asserting;
              cfg_interrupt_n_i <= '0';
              cfg_interrupt_assert_n_i  <= '0';
				  
				  level_Irpt_Req_i        <= '1';
				  IrptStatesOut_i <= "00000010";
            else
              edge_Intrpt_State      <= IntST_Idle;
              cfg_interrupt_n_i <= '1';
              cfg_interrupt_assert_n_i  <= '1';
				  
				  level_Irpt_Req_i        <= '0';
				  IrptStatesOut_i <= "00000001";
            end if;

          when IntST_Asserting =>----2
            if cfg_interrupt_rdy_n='1' then
              edge_Intrpt_State      <= IntST_Asserting;
              cfg_interrupt_n_i <= '0';
              cfg_interrupt_assert_n_i  <= '0';
				  
				  level_Irpt_Req_i        <= '1';
				  IrptStatesOut_i <= "00000010";
            else
              edge_Intrpt_State      <= IntST_Asserted;
              cfg_interrupt_n_i <= '1';
              cfg_interrupt_assert_n_i  <= '0';
				  
				  level_Irpt_Req_i        <= '1';
				  IrptStatesOut_i <= "00000011";
            end if;


          when IntST_Asserted =>----3
            if Interrupts_ORed_i='0' then
              edge_Intrpt_State      <= IntST_Deasserting;
              cfg_interrupt_n_i <= '0';
              cfg_interrupt_assert_n_i  <= '1';
				  
				  level_Irpt_Req_i        <= '0';
				  IrptStatesOut_i <= "00000100";
            else
              edge_Intrpt_State      <= IntST_Asserted;
              cfg_interrupt_n_i <= '1';
              cfg_interrupt_assert_n_i  <= '0';
				  
				  level_Irpt_Req_i        <= '1';
				  IrptStatesOut_i <= "00000011";
            end if;


          when IntST_Deasserting =>----4
            if Irpt_RE_i='0' then
              edge_Intrpt_State      <= IntST_Deasserting;
              cfg_interrupt_n_i <= '0';
              cfg_interrupt_assert_n_i  <= '1';
				  
				  level_Irpt_Req_i        <= '0';
				  IrptStatesOut_i <= "00000100";
            else
              edge_Intrpt_State      <= IntST_Idle;
              cfg_interrupt_n_i <= '1';
              cfg_interrupt_assert_n_i  <= '1';
				  
				  level_Irpt_Req_i        <= '0';
				  IrptStatesOut_i <= "00000001";
            end if;


          when OTHERS  =>
              edge_Intrpt_State      <= IntST_Idle;
              cfg_interrupt_n_i <= '1';
              cfg_interrupt_assert_n_i  <= '1';
				  
				  level_Irpt_Req_i        <= '0';
				  IrptStatesOut_i <= "00000001";
        end case;

      end if;
   end process;

 end generate;


----------------------------------------------
--  Channel mode
----------------------------------------------
 Gen_Chan_MSI: if not USE_CFG_INTERRUPT generate

   cfg_interrupt_n      <= '1';          -- Channel mode, cfg interface disabled.
   cfg_interrupt_assert_n_i  <= '1'; 

   Irpt_Req             <= edge_Irpt_Req_i;
   Msg_Code             <= C_MSGCODE_INTA when edge_MsgCode_is_ASSERT='1'
                           else C_MSGCODE_INTA_N;

   -- State Machine for edge interrupts
   State_Machine_edge_Irpt:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         edge_Intrpt_State      <= IntST_RST;
         edge_Irpt_Req_i        <= '0';
         edge_MsgCode_is_ASSERT <= '0';
			
			IrptStatesOut_i <= "00000000";
			
      elsif trn_clk'event and trn_clk = '1' then

        case edge_Intrpt_State is

          when IntST_RST =>
              edge_Intrpt_State      <= IntST_Idle;
              edge_Irpt_Req_i        <= '0';
		        edge_MsgCode_is_ASSERT <= '0';
					
					IrptStatesOut_i <= "00000001";
					
          when IntST_Idle =>
            if Interrupts_ORed_i='1' then
              edge_Intrpt_State      <= IntST_Asserting;
              edge_Irpt_Req_i        <= '1';
		        edge_MsgCode_is_ASSERT <= edge_MsgCode_is_ASSERT;  -- '1';
				  
				  IrptStatesOut_i <= "00000010";
				  
            else
              edge_Intrpt_State      <= IntST_Idle;
              edge_Irpt_Req_i        <= '0';
		        edge_MsgCode_is_ASSERT <= edge_MsgCode_is_ASSERT;
				  
				  IrptStatesOut_i <= "00000001";
				  
            end if;

          when IntST_Asserting =>
            if Irpt_RE_i='0' then
              edge_Intrpt_State      <= IntST_Asserting;
              edge_Irpt_Req_i        <= '1';
		        edge_MsgCode_is_ASSERT <= edge_MsgCode_is_ASSERT; -- '1';
				  
				  IrptStatesOut_i <= "00000010";
				  
            else
              edge_Intrpt_State      <= IntST_Asserted;
              edge_Irpt_Req_i        <= '0';
		        edge_MsgCode_is_ASSERT <= '1';
				  
				  IrptStatesOut_i <= "00000011";
				  
            end if;

          when IntST_Asserted =>
            if Interrupts_ORed_i='0' then
              edge_Intrpt_State      <= IntST_Deasserting;
              edge_Irpt_Req_i        <= '1';
		        edge_MsgCode_is_ASSERT <= edge_MsgCode_is_ASSERT;  -- !!
				  
				  IrptStatesOut_i <= "00000100";				  
				  
            else
              edge_Intrpt_State      <= IntST_Asserted;
              edge_Irpt_Req_i        <= '0';
		        edge_MsgCode_is_ASSERT <= edge_MsgCode_is_ASSERT;  -- '1';
				  
				  IrptStatesOut_i <= "00000011";
				  
            end if;

          when IntST_Deasserting =>
            if Irpt_RE_i='0' then
              edge_Intrpt_State      <= IntST_Deasserting;
              edge_Irpt_Req_i        <= '1';
		        edge_MsgCode_is_ASSERT <= edge_MsgCode_is_ASSERT; -- '0';
				  
				  IrptStatesOut_i <= "00000100";
				  
            else
              edge_Intrpt_State      <= IntST_Idle;
              edge_Irpt_Req_i        <= '0';
		        edge_MsgCode_is_ASSERT <= '0';
				  
				  IrptStatesOut_i <= "00000001";
				  
            end if;

          when OTHERS  =>
              edge_Intrpt_State      <= IntST_Idle;
              edge_Irpt_Req_i        <= '0';
		        edge_MsgCode_is_ASSERT <= '0';
				  
				  IrptStatesOut_i <= "00000001";

        end case;

      end if;
   end process;




   --  Tag of Msg TLP increments
   Sync_Msg_Tag_Increment:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         Msg_Tag_Lo        <= (Others=>'0');

      elsif trn_clk'event and trn_clk = '1' then
         if Irpt_RE_i = '1' then
            Msg_Tag_Lo  <=  Msg_Tag_Lo + '1';
         else
            Msg_Tag_Lo  <=  Msg_Tag_Lo;
         end if;

      end if;
   end process;


 end generate;   -- Gen_Chan_MSI: if not USE_CFG_INTERRUPT


 -- 
 --------------      Generate Interrupt Generator       ------------------
 --
 Gen_IG:  if IMP_INT_GENERATOR generate

   IG_Num_Assert   <= IG_Num_Assert_i;
   IG_Num_Deassert <= IG_Num_Deassert_i;
   IG_Asserting    <= IG_Asserting_i;

-- -------------------------------------------------------
-- FSM: generating interrupts
   FSM_Generate_Interrupts:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         IG_Counter    <= (Others=>'0');

      elsif trn_clk'event and trn_clk = '1' then

        if IG_Reset = '1' then
           IG_Counter    <= (Others=>'0');
        elsif IG_Counter /= C_ALL_ZEROS(C_CNT_GINT_WIDTH-1 downto 0) then
           IG_Counter    <= IG_Counter - '1';
        elsif IG_Run_DAQ = '0' then
           IG_Counter    <= (Others=>'0');
        else
           IG_Counter    <= IG_Latency(C_CNT_GINT_WIDTH-1 downto 0);
        end if;

      end if;
   end process;


-- -------------------------------------------------------
-- Issuing: Interrupt trigger
   Synch_Interrupt_Trigger:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         IG_Trigger_i  <= '0';

      elsif trn_clk'event and trn_clk = '1' then

        if IG_Reset = '1' then
           IG_Trigger_i  <= '0';
        elsif IG_Counter = CONV_STD_LOGIC_VECTOR(1, C_CNT_GINT_WIDTH) then
           IG_Trigger_i  <= '1';
        else
           IG_Trigger_i  <= '0';
        end if;

      end if;
   end process;


-- -------------------------------------------------------
-- register: IG_Run
   Synch_IG_Run:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         IG_Run   <= '0';

      elsif trn_clk'event and trn_clk = '1' then

        if IG_Reset = '1' then
           IG_Run   <= '0';
        elsif IG_Latency(C_DBUS_WIDTH-1 downto 2)=C_ALL_ZEROS(C_DBUS_WIDTH-1 downto 2) then
           IG_Run   <= '0';
        else
           IG_Run   <= '1';
        end if;

      end if;
   end process;

   
-- -----------------------------------------------
-- Synchronous Register: IG_Num_Assert_i
   SysReg_IntGen_Number_of_Assert:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         IG_Num_Assert_i       <= (OTHERS => '0');

      elsif trn_clk'event and trn_clk = '1' then

        if IG_Reset='1' then
            IG_Num_Assert_i    <=  (OTHERS => '0');
        elsif IG_Trigger_i = '1'  then
            IG_Num_Assert_i    <=  IG_Num_Assert_i + '1';
        else
            IG_Num_Assert_i    <=  IG_Num_Assert_i;
        end if;

      end if;
   end process;


-- -----------------------------------------------
-- Synchronous Register: IG_Num_Deassert_i
   SysReg_IntGen_Number_of_Deassert:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         IG_Num_Deassert_i       <= (OTHERS => '0');

      elsif trn_clk'event and trn_clk = '1' then

        if IG_Reset='1' then
            IG_Num_Deassert_i    <=  (OTHERS => '0');
        elsif IG_Host_Clear='1' and IG_Asserting_i='1' then
            IG_Num_Deassert_i    <=  IG_Num_Deassert_i + '1';
        else
            IG_Num_Deassert_i    <=  IG_Num_Deassert_i;
        end if;

      end if;
   end process;


-- -----------------------------------------------
-- Synchronous Register: IG_Asserting_i
   SysReg_IntGen_IG_Asserting_i:
   process ( trn_clk, trn_reset_n)
   begin
      if trn_reset_n = '0' then
         IG_Asserting_i       <= '0';

      elsif trn_clk'event and trn_clk = '1' then

        if IG_Reset='1' then
            IG_Asserting_i    <=  '0';
        elsif IG_Asserting_i='0' and IG_Trigger_i='1' then
            IG_Asserting_i    <=  '1';
        elsif IG_Asserting_i='0' and IG_Trigger_i='0' then
            IG_Asserting_i    <=  '0';
        elsif IG_Asserting_i='1' and IG_Host_Clear='0' then
            IG_Asserting_i    <=  '1';
        elsif IG_Asserting_i='1' and IG_Host_Clear='1' then
            IG_Asserting_i    <=  '0';
        else
            IG_Asserting_i    <=  IG_Asserting_i;
        end if;

      end if;
   end process;

 end generate;


 -- 
 --------------    No Generation of Interrupt Generator     ----------------
 --

 NotGen_IG:  if not IMP_INT_GENERATOR generate

   IG_Num_Assert   <= (OTHERS=>'0');
   IG_Num_Deassert <= (OTHERS=>'0');
   IG_Asserting    <= '0';

 end generate;

end Behavioral;
