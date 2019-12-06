module skeleton(reset, 
	ps2_clock, ps2_data, 										// ps2 related I/O
	debug_data_in, debug_addr, leds, 						// extra debugging ports
	lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,// LCD info
	seg1, curr_time, score_seg_ones, score_seg_tens, seg3, seg4, seg5, seg7, seg8,		// seven segements
	time_seg_ones, time_seg_tens,
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,
	inSwitch0, inSwitch1, inSwitch2,
	mLeft,
	mRight,
	mUp,
	mDown, indicator, sampled, timer, dc, gameModeSwitch,
	dataaa, reg5,
	CLOCK_50, div_clk, div_clk_counter, clock);  													// 50 MHz clock
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	input				CLOCK_50, mLeft, mRight, mUp, mDown;

	////////////////////////	PS2	////////////////////////////
	input 			reset;
	inout 			ps2_data, ps2_clock;
	
	////////////////////////	LCD and Seven Segment	////////////////////////////
	output 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, curr_time, score_seg_ones, score_seg_tens, seg3, seg4, seg5, seg7, seg8, time_seg_ones, time_seg_tens;
	output 	[31:0] 	debug_data_in;
	output   [11:0]   debug_addr;
	
	
	output indicator;
	input gameModeSwitch;
	
	output			 clock;
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;
	wire	[7:0]	 ps2_key_data;
	wire			 ps2_key_pressed;
	wire	[7:0]	 ps2_out;	
	wire [6:0] lb1_seg_ones, lb1_seg_tens,lb2_seg_ones, lb2_seg_tens, lb3_seg_ones, lb3_seg_tens;
	
	
	//Hoop
	input inSwitch0, inSwitch1, inSwitch2;
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
//	output inclock;
//	wire clock2, clock3, clock4, clock5;
//	assign clock2 = inclock;
//	pll div1(clock2,clock3);
	//pll div2(clock3,clock4);
	//pll div3(clock4,clock5);
	
	processor_init (clock, 1'b0, regA, dataA, timer, reg5, dc);
	output [31:0] dc;
	wire [4:0] procReg;
	output [31:0] dataaa;
	assign dataaa = dataA;
	assign procReg = regA;
	wire isReg5;
	and (isReg5, procReg[0], ~procReg[1], procReg[2], ~procReg[3], ~procReg[4]);
	//wire yup;
	and a5(yup, reg5, dataaa[0]);
	wire sampled; 
	output reg5;
	assign sampled = yup;
	output sampled;
	
	
	
	// keyboard controller
//	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
//	lcd mylcd(clock, ~resetn, 1'b1, ps2_out, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	wire [7:0] score_count;
	
	wire score_count_en;
	and a0(score_count_en, ~diff[0], ~diff[1], ~diff[2], ~diff[3], ~diff[4], ~diff[5], ~diff[6], ~diff[7]);
	
	wire score_count_mode1_en;
	assign score_count_mode1_en = (score_count == end_score) ? 1 : 0;
	
	wire scoreEnable;
	assign scoreEnable = gameMode ? (~score_count_mode1_en) : (~score_count_en);
	
	wire [7:0] lb1, lb2, lb3;
	assign lb1 = gameMode ? time1 : score1;
	assign lb2 = gameMode ? time2 : score2;
	assign lb3 = gameMode ? time3 : score3;
	
	//switch from hoop
	wire make;
	finalproject_b cont(score_seg_ones, score_seg_tens, lb1_seg_ones, lb1_seg_tens,lb2_seg_ones, lb2_seg_tens, lb3_seg_ones, lb3_seg_tens, inSwitch0, inSwitch1, inSwitch2, lb1, lb22, lb3, clock, score_count, scoreEnable, ~reset, make);
	
	
	// example for sending ps2 data to the first two seven segment displays
	//Hexadecimal_To_Seven_Segment hex1(ps2_out[3:0], seg1);
	//Hexadecimal_To_Seven_Segment hex2(ps2_out[7:4], seg2);
	
	// the other seven segment displays are currently set to 0
	//Hexadecimal_To_Seven_Segment hex3(4'b0, seg3);
	//Hexadecimal_To_Seven_Segment hex4(4'b0, seg4);
	//Hexadecimal_To_Seven_Segment hex5(4'b0, seg5);
	//Hexadecimal_To_Seven_Segment hex6(4'b0, seg6);
	Hexadecimal_To_Seven_Segment hex7(4'b0, seg7);
	Hexadecimal_To_Seven_Segment hex8(4'b0, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds[7:1] = 7'b0;
	
	reg[7:0] curr_time_reg;
	reg[31:0] timer;
	reg div_clk;
	output div_clk;
	reg[31:0] div_clk_counter;
	output[31:0] div_clk_counter;
	output [31:0] timer;
	wire [6:0] curr_t;
	//reg game_over;
	reg enA, hold;
	
	reg gameMode;
	
	initial begin
		gameMode <= gameModeSwitch;
	end
	
	always @(posedge clock)
		begin
			timer <= timer + 32'b1;
			if (reset == 0) begin
				curr_time_reg <= 8'b0;
				hold <= 0;
				gameMode <= gameModeSwitch;
			end
			if (yup)
			begin
			div_clk_counter <= div_clk_counter + 32'b1;
			end
			if (div_clk_counter<32'd3750000)
			begin
			div_clk <= 1'b0;
			end
			else if (div_clk_counter>32'd3750000)
			begin
			div_clk <= 1'b1;
			div_clk_counter <= 32'b0;
			end
			
			if (div_clk && curr_time_reg < start_time && !((score_count == end_score && gameMode == 1)))
			begin
			curr_time_reg <= curr_time_reg + 1;
			end
			
			if (yup) // && curr_time_reg < start_time)
			begin
				timer <= 32'b0;
				//div_clk_counter <= 32'b0;
				//curr_time_reg <= curr_time_reg + 1;
			end
			if (((diff == 8'b0 && gameMode == 0) || (score_count == end_score && gameMode == 1)) && hold==0) begin
				enA <= 1;
				hold <= 1;
			end
			if (hold == 1) begin
				enA <= 0;
			end
	end
	
//	reg 
//	always @(reset)
//		begin
//			curr_time <= 8'b0;
//	end
	
	wire [7:0] score1, score2, score3, time1, time2, time3;
	//curr_time == 0 acts as enable for leaderboard updates
	//output top three scores
	
	wire scoreLeaderBoardEn, timeLeaderBoardEn;
	and scand(scoreLeaderBoardEn, enA, ~gameMode);
	and scand1(timeLeaderBoardEn, enA, gameMode);
	
	leaderboard score(clock, scoreLeaderBoardEn, score_count, user_id, score1, score2, score3, id1, id2, id3, indicator);
	leaderboard times(clock, timeLeaderBoardEn, curr_time_reg, user_id1, time1, time2, time3, id01, id02, id03, ignore);
	
	Hexadecimal_To_Seven_Segment yo(score1[3:0], seg1);
	
	wire [7:0] start_time, diff, display_time, end_score;
	assign start_time = 8'd30;
	assign end_score = 8'd10;
	assign diff = start_time - curr_time_reg;
	assign display_time = gameMode ? curr_time_reg : diff;
	
	Hexadecimal_To_Seven_Segment h(diff[3:0], curr_t);
	Hexadecimal_To_Seven_Segment yo2(score2[3:0], seg3);
	Hexadecimal_To_Seven_Segment yo3(score3[3:0], seg4);
	Decimal_To_Seven_Segment yo4(CLOCK_50, display_time, time_seg_ones, time_seg_tens);
	Hexadecimal_To_Seven_Segment hex5(display_time, seg5);
	
		
	// VGA
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(.iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .oBLANK_n(VGA_BLANK),
								 .oHS(VGA_HS),
								 .oVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R),
								 .time_segment_ones(time_seg_ones),
								 .time_segment_tens(time_seg_tens),
								 .score_segment_ones(score_seg_ones),
								 .score_segment_tens(score_seg_tens),
								.lb1_segment_ones (lb1_seg_ones),
								.lb1_segment_tens (lb1_seg_tens),
								.lb2_segment_ones (lb2_seg_ones),
								.lb2_segment_tens (lb2_seg_tens),
								.lb3_segment_ones (lb3_seg_ones),
								.lb3_segment_tens (lb3_seg_tens),
								 .mLeft(mLeft),
								 .mRight(mRight),
								 .mUp(mUp),
								 .mDown(mDown),
								 .make(make));
								 
	
endmodule
