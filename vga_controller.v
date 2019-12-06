module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 time_segment_ones,
							 time_segment_tens,
							 score_segment_ones,
							 score_segment_tens,
							 lb1_segment_ones,
							 lb1_segment_tens,
							 lb2_segment_ones,
							 lb2_segment_tens,
							 lb3_segment_ones,
							 lb3_segment_tens,
							 mLeft,
							 mRight,
							 mUp,
							 mDown,
							 make);
							 
localparam screenW = 640,
segL = 60,
segS = 6,
segGap = 3,

segL_lb = 30,
segS_lb = 3,
segGap_lb = 2;

// SHOT
input[6:0] 				 time_segment_ones,
							 time_segment_tens,
							 score_segment_ones,
							 score_segment_tens,
							 lb1_segment_ones,
							 lb1_segment_tens,
							 lb2_segment_ones,
							 lb2_segment_tens,
							 lb3_segment_ones,
							 lb3_segment_tens;

//
 


	
input iRST_n;
input iVGA_CLK;
input mLeft, mRight, mUp, mDown, make;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////
reg [18:0] topLeft = 680;

reg [18:0] scoreTopLeftTens =  9990;
reg [18:0] scoreTopLeftOnes = 10080;
reg [18:0] timeTopLeftTens = 137990;
reg [18:0] timeTopLeftOnes = 138080;


reg [18:0] lb1_TopLeftTens =  3210;
reg [18:0] lb1_TopLeftOnes =  3255;

reg [18:0] lb2_TopLeftTens = 54410;
reg [18:0] lb2_TopLeftOnes = 54455;

reg [18:0] lb3_TopLeftTens = 105610;
reg [18:0] lb3_TopLeftOnes = 105655;


reg[18:0] sw_TopLeft = 160000;







reg [63:0] counter = 0;                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
reg [7:0] b_data, g_data, r_data;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index ),
	.swish (make),
	);
	
/////////////////////////
//////Add switch-input logic here
	
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw),
	.swish (make),
	);	
	
	



//////
//////latch valid data at falling edge;
always@(posedge VGA_CLK_n) begin//, posedge mUp, posedge mDown, posedge mRight, posedge mLeft) begin 
bgr_data <= bgr_data_raw;


counter <= counter  + 1;
//
if (counter >= 23'd1000000) begin
	counter <= 0;
	if (!mUp) begin
		topLeft = topLeft - 640;//(640*counter/20000000);
	end
	if (!mDown) begin
		topLeft = topLeft + 640;//(640*counter/20000000);
	end
	if (!mRight) begin
		topLeft = topLeft + 1;//(counter/20000000);
	end
	if (!mLeft) begin
		topLeft = topLeft - 1;//(counter/20000000);
	end
	
end

//if (ADDR/640 <=(topLeft/640 + 50) && ADDR/640 >= (topLeft/640) && ADDR%640 <=(topLeft%640 +50) && ADDR%640 >=(topLeft%640))
//	begin
//		b_data = 8'h00;
//		g_data = 8'hFF;
//		r_data = 8'h00;
//	end
///Attempting to insert numbers

//LEADERBOARD

   //LB1
		


		//ONES DIGIT
	
	//Top (segment 0)
	else if (
				~lb1_segment_ones[0] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftOnes/screenW) && 		//min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~lb1_segment_ones[1] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftOnes/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW + segL_lb + segGap_lb+ segS_lb) && 						//max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~lb1_segment_ones[2] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW + segL_lb + segGap_lb+ segS_lb) && //max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~lb1_segment_ones[3] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb + segS_lb) && //max Y
				ADDR/screenW >=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb) && //min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~lb1_segment_ones[4] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW + segS_lb) && //max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~lb1_segment_ones[5] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftOnes/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW + segS_lb) && 	//max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~lb1_segment_ones[6] &&
				ADDR/screenW <=(lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segS_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftOnes%screenW + segL_lb) && 	//max X
				ADDR%screenW >=(lb1_TopLeftOnes%screenW + segS_lb + segGap_lb )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
		
		//Tens DIGIT
	
	//Top (segment 0)
	else if (
				~lb1_segment_tens[0] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftTens/screenW) && 		//min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~lb1_segment_tens[1] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftTens/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW + segL_lb + segGap_lb+ segS_lb) && 						//max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~lb1_segment_tens[2] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW + segL_lb + segGap_lb+ segS_lb) && //max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~lb1_segment_tens[3] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb + segS_lb) && //max Y
				ADDR/screenW >=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb) && //min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~lb1_segment_tens[4] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW + segS_lb) && //max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~lb1_segment_tens[5] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftTens/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW + segS_lb) && 	//max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~lb1_segment_tens[6] &&
				ADDR/screenW <=(lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segS_lb) && //max Y
				ADDR/screenW >= (lb1_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) &&		//min Y
				ADDR%screenW <=(lb1_TopLeftTens%screenW + segL_lb) && 	//max X
				ADDR%screenW >=(lb1_TopLeftTens%screenW + segS_lb + segGap_lb )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end

   //LB2
		


		//ONES DIGIT
	
	//Top (segment 0)
	else if (
				~lb2_segment_ones[0] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftOnes/screenW) && 		//min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~lb2_segment_ones[1] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftOnes/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW + segL_lb + segGap_lb+ segS_lb) && 						//max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~lb2_segment_ones[2] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW + segL_lb + segGap_lb+ segS_lb) && //max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~lb2_segment_ones[3] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb + segS_lb) && //max Y
				ADDR/screenW >=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb) && //min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~lb2_segment_ones[4] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW + segS_lb) && //max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~lb2_segment_ones[5] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftOnes/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW + segS_lb) && 	//max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~lb2_segment_ones[6] &&
				ADDR/screenW <=(lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segS_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftOnes%screenW + segL_lb) && 	//max X
				ADDR%screenW >=(lb2_TopLeftOnes%screenW + segS_lb + segGap_lb )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
		
		//Tens DIGIT
	
	//Top (segment 0)
	else if (
				~lb2_segment_tens[0] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftTens/screenW) && 		//min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~lb2_segment_tens[1] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftTens/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW + segL_lb + segGap_lb+ segS_lb) && 						//max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~lb2_segment_tens[2] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW + segL_lb + segGap_lb+ segS_lb) && //max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~lb2_segment_tens[3] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb + segS_lb) && //max Y
				ADDR/screenW >=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb) && //min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~lb2_segment_tens[4] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW + segS_lb) && //max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~lb2_segment_tens[5] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftTens/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW + segS_lb) && 	//max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~lb2_segment_tens[6] &&
				ADDR/screenW <=(lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segS_lb) && //max Y
				ADDR/screenW >= (lb2_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) &&		//min Y
				ADDR%screenW <=(lb2_TopLeftTens%screenW + segL_lb) && 	//max X
				ADDR%screenW >=(lb2_TopLeftTens%screenW + segS_lb + segGap_lb )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end

		
//LB3
		


		//ONES DIGIT
	
	//Top (segment 0)
	else if (
				~lb3_segment_ones[0] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftOnes/screenW) && 		//min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~lb3_segment_ones[1] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftOnes/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW + segL_lb + segGap_lb+ segS_lb) && 						//max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~lb3_segment_ones[2] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW + segL_lb + segGap_lb+ segS_lb) && //max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~lb3_segment_ones[3] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb + segS_lb) && //max Y
				ADDR/screenW >=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb) && //min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~lb3_segment_ones[4] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW + segS_lb) && //max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~lb3_segment_ones[5] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftOnes/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW + segS_lb) && 	//max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~lb3_segment_ones[6] &&
				ADDR/screenW <=(lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb + segS_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftOnes/screenW + segS_lb + segGap_lb + segL_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftOnes%screenW + segL_lb) && 	//max X
				ADDR%screenW >=(lb3_TopLeftOnes%screenW + segS_lb + segGap_lb )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
		
		//Tens DIGIT
	
	//Top (segment 0)
	else if (
				~lb3_segment_tens[0] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftTens/screenW) && 		//min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~lb3_segment_tens[1] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftTens/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW + segL_lb + segGap_lb+ segS_lb) && 						//max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~lb3_segment_tens[2] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW + segL_lb + segGap_lb+ segS_lb) && //max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW + segL_lb + segGap_lb)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~lb3_segment_tens[3] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb + segS_lb) && //max Y
				ADDR/screenW >=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb + segGap_lb) && //min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW +segL_lb + segGap_lb + segS_lb) &&  //max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~lb3_segment_tens[4] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW + segS_lb) && //max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~lb3_segment_tens[5] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftTens/screenW + segS_lb + segGap_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW + segS_lb) && 	//max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~lb3_segment_tens[6] &&
				ADDR/screenW <=(lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb + segS_lb) && //max Y
				ADDR/screenW >= (lb3_TopLeftTens/screenW + segS_lb + segGap_lb + segL_lb) &&		//min Y
				ADDR%screenW <=(lb3_TopLeftTens%screenW + segL_lb) && 	//max X
				ADDR%screenW >=(lb3_TopLeftTens%screenW + segS_lb + segGap_lb )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end




	
	
//Score

	//ONES DIGIT
	
	//Top (segment 0)
	else if (
				~score_segment_ones[0] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS) && //max Y
				ADDR/screenW >= (scoreTopLeftOnes/screenW) && 		//min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~score_segment_ones[1] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftOnes/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW + segL + segGap+ segS) && 						//max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~score_segment_ones[2] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftOnes/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW + segL + segGap+ segS) && //max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~score_segment_ones[3] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS + segGap + segL + segGap + segL + segGap + segS) && //max Y
				ADDR/screenW >=(scoreTopLeftOnes/screenW + segS + segGap + segL + segGap + segL + segGap) && //min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~score_segment_ones[4] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftOnes/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW + segS) && //max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~score_segment_ones[5] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftOnes/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW + segS) && 	//max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~score_segment_ones[6] &&
				ADDR/screenW <=(scoreTopLeftOnes/screenW + segS + segGap + segL + segS) && //max Y
				ADDR/screenW >= (scoreTopLeftOnes/screenW + segS + segGap + segL) &&		//min Y
				ADDR%screenW <=(scoreTopLeftOnes%screenW + segL) && 	//max X
				ADDR%screenW >=(scoreTopLeftOnes%screenW + segS + segGap )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
		
	//Tens DIGIT
	//Top (segment 0)
	else if (
				~score_segment_tens[0] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS) && //max Y
				ADDR/screenW >= (scoreTopLeftTens/screenW) && 		//min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(scoreTopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~score_segment_tens[1] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftTens/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW + segL + segGap+ segS) && 						//max X
				ADDR%screenW >=(scoreTopLeftTens%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~score_segment_tens[2] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftTens/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW + segL + segGap+ segS) && //max X
				ADDR%screenW >=(scoreTopLeftTens%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~score_segment_tens[3] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS + segGap + segL + segGap + segL + segGap + segS) && //max Y
				ADDR/screenW >=(scoreTopLeftTens/screenW + segS + segGap + segL + segGap + segL + segGap) && //min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(scoreTopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~score_segment_tens[4] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftTens/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW + segS) && //max X
				ADDR%screenW >=(scoreTopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~score_segment_tens[5] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (scoreTopLeftTens/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW + segS) && 	//max X
				ADDR%screenW >=(scoreTopLeftTens%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~score_segment_tens[6] &&
				ADDR/screenW <=(scoreTopLeftTens/screenW + segS + segGap + segL + segS) && //max Y
				ADDR/screenW >= (scoreTopLeftTens/screenW + segS + segGap + segL) &&		//min Y
				ADDR%screenW <=(scoreTopLeftTens%screenW + segL) && 	//max X
				ADDR%screenW >=(scoreTopLeftTens%screenW + segS + segGap )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end

//Time
	//ONES DIGIT
		else if (
				~time_segment_ones[0] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS) && //max Y
				ADDR/screenW >= (timeTopLeftOnes/screenW) && 		//min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(timeTopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~time_segment_ones[1] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftOnes/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW + segL + segGap+ segS) && 						//max X
				ADDR%screenW >=(timeTopLeftOnes%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~time_segment_ones[2] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftOnes/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW + segL + segGap+ segS) && //max X
				ADDR%screenW >=(timeTopLeftOnes%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~time_segment_ones[3] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS + segGap + segL + segGap + segL + segGap + segS) && //max Y
				ADDR/screenW >=(timeTopLeftOnes/screenW + segS + segGap + segL + segGap + segL + segGap) && //min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(timeTopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~time_segment_ones[4] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftOnes/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW + segS) && //max X
				ADDR%screenW >=(timeTopLeftOnes%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~time_segment_ones[5] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftOnes/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW + segS) && 	//max X
				ADDR%screenW >=(timeTopLeftOnes%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~time_segment_ones[6] &&
				ADDR/screenW <=(timeTopLeftOnes/screenW + segS + segGap + segL + segS) && //max Y
				ADDR/screenW >= (timeTopLeftOnes/screenW + segS + segGap + segL) &&		//min Y
				ADDR%screenW <=(timeTopLeftOnes%screenW + segL) && 	//max X
				ADDR%screenW >=(timeTopLeftOnes%screenW + segS + segGap )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end

	//Tens DIGIT
		else if (
				~time_segment_tens[0] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS) && //max Y
				ADDR/screenW >= (timeTopLeftTens/screenW) && 		//min Y
				ADDR%screenW <=(timeTopLeftTens%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(timeTopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Right (Segment 1)
	else if (~time_segment_tens[1] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftTens/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftTens%screenW + segL + segGap+ segS) && 						//max X
				ADDR%screenW >=(timeTopLeftTens%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Right (Segment 2)
	else if (~time_segment_tens[2] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftTens/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftTens%screenW + segL + segGap+ segS) && //max X
				ADDR%screenW >=(timeTopLeftTens%screenW + segL + segGap)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Bottom (Segment 3)
	else if (~time_segment_tens[3] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS + segGap + segL + segGap + segL + segGap + segS) && //max Y
				ADDR/screenW >=(timeTopLeftTens/screenW + segS + segGap + segL + segGap + segL + segGap) && //min Y
				ADDR%screenW <=(timeTopLeftTens%screenW +segL + segGap + segS) &&  //max X
				ADDR%screenW >=(timeTopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Lower Left (Segment 4)
	else if (~time_segment_tens[4] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS + segGap + segL + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftTens/screenW + segS + segGap + segL + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftTens%screenW + segS) && //max X
				ADDR%screenW >=(timeTopLeftTens%screenW)				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Upper Left (Segment 5)
	else if (~time_segment_tens[5] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS + segGap + segL) && //max Y
				ADDR/screenW >= (timeTopLeftTens/screenW + segS + segGap) &&		//min Y
				ADDR%screenW <=(timeTopLeftTens%screenW + segS) && 	//max X
				ADDR%screenW >=(timeTopLeftTens%screenW )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end
	//Center (Segment 6)
	else if (~time_segment_tens[6] &&
				ADDR/screenW <=(timeTopLeftTens/screenW + segS + segGap + segL + segS) && //max Y
				ADDR/screenW >= (timeTopLeftTens/screenW + segS + segGap + segL) &&		//min Y
				ADDR%screenW <=(timeTopLeftTens%screenW + segL) && 	//max X
				ADDR%screenW >=(timeTopLeftTens%screenW + segS + segGap )				//min X
				)
		begin
			b_data = 8'h00;
			g_data = 8'h00;
			r_data = 8'hFF;
		end

else
	begin
		b_data = bgr_data[23:16];
		g_data = bgr_data[15:8];
		r_data = bgr_data[7:0]; 
	end
end
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule









