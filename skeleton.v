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
	inSwitch,
	mLeft,
	mRight,
	mUp,
	mDown, indicator,
	CLOCK_50);  													// 50 MHz clock
		
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
	
	
	wire			 clock;
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;
	wire	[7:0]	 ps2_key_data;
	wire			 ps2_key_pressed;
	wire	[7:0]	 ps2_out;	
	
	
	//Hoop
	input inSwitch;
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// your processor
	processor_init(clock, reset, regA, dataA);
	
	// keyboard controller
//	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
//	lcd mylcd(clock, ~resetn, 1'b1, ps2_out, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	wire [7:0] score_count;
	
	wire score_count_en;
	and a0(score_count_en, ~diff[0], ~diff[1], ~diff[2], ~diff[3], ~diff[4], ~diff[5], ~diff[6], ~diff[7]);
	
	//switch from hoop
	finalproject_b cont(score_seg_ones, score_seg_tens,inSwitch, clock, score_count, ~score_count_en, ~reset);
	
	
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
	wire [6:0] curr_t;
	//reg game_over;
	reg enA, hold;
	
	always @(posedge clock)
		begin
			timer <= timer + 32'b1;
			if (reset == 0) begin
				curr_time_reg <= 8'b0;
				hold <= 0;
			end
			if (timer>32'd100000000 && curr_time_reg < start_time)
			begin
				timer <= 32'b0;
				curr_time_reg <= curr_time_reg + 1;
			end
			if (diff == 'b0 && hold==0) begin
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
	
	wire [7:0] score1, score2, score3;
	//curr_time == 0 acts as enable for leaderboard updates
	//output top three scores
	leaderboard l(clock, enA, score_count, user_id, score1, score2, score3, id1, id2, id3, indicator);
	
	Hexadecimal_To_Seven_Segment yo(score1[3:0], seg1);
	
	wire [7:0] start_time, diff;
	assign start_time = 8'd10;
	assign diff = start_time - curr_time_reg;
	Hexadecimal_To_Seven_Segment h(diff[3:0], curr_t);
	Hexadecimal_To_Seven_Segment yo2(score2[3:0], seg3);
	Hexadecimal_To_Seven_Segment yo3(score3[3:0], seg4);
	Decimal_To_Seven_Segment yo4(CLOCK_50, curr_time_reg, time_seg_ones, time_seg_tens);
	Hexadecimal_To_Seven_Segment hex5(curr_time_reg, seg5);
	
		
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
								 .mLeft(mLeft),
								 .mRight(mRight),
								 .mUp(mUp),
								 .mDown(mDown));
								 
	
endmodule
