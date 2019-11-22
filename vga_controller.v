module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 scoreSegment,
							 mLeft,
							 mRight,
							 mUp,
							 mDown);
							 
localparam screenW = 640,
segL = 150,
segS = 15,
segGap = 3;

// SHOT
input[6:0] scoreSegment;


	
input iRST_n;
input iVGA_CLK;
input mLeft, mRight, mUp, mDown;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////
reg [18:0] topLeft = 680;
reg [18:0] scoreTopLeft = 10000;
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
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here
	
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
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

//Score

//Top (segment 0)


else if (
			~scoreSegment[0] &&
			ADDR/screenW <=(scoreTopLeft/screenW + segS) && //max Y
			ADDR/screenW >= (scoreTopLeft/screenW) && 		//min Y
			ADDR%screenW <=(scoreTopLeft%screenW +segL + segGap + segS) &&  //max X
			ADDR%screenW >=(scoreTopLeft%screenW)				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
	end


//Upper Right (Segment 1)

else if (~scoreSegment[1] &&
			
			ADDR/screenW <=(scoreTopLeft/screenW + segS + segGap + segL) && //max Y
			ADDR/screenW >= (scoreTopLeft/screenW + segS + segGap) &&		//min Y
			ADDR%screenW <=(scoreTopLeft%screenW + segL + segGap+ segS) && 						//max X
			ADDR%screenW >=(scoreTopLeft%screenW + segL + segGap)				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
	end

//Lower Right (Segment 2)

else if (~scoreSegment[2] &&
			
			ADDR/screenW <=(scoreTopLeft/screenW + segS + segGap + segL + segGap + segL) && //max Y
			ADDR/screenW >= (scoreTopLeft/screenW + segS + segGap + segL + segGap) &&		//min Y
			ADDR%screenW <=(scoreTopLeft%screenW + segL + segGap+ segS) && //max X
			ADDR%screenW >=(scoreTopLeft%screenW + segL + segGap)				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
	end
	
//Bottom (Segment 3)

else if (~scoreSegment[3] &&
			
			ADDR/screenW <=(scoreTopLeft/screenW + segS + segGap + segL + segGap + segL + segGap + segS) && //max Y
			ADDR/screenW >=(scoreTopLeft/screenW + segS + segGap + segL + segGap + segL + segGap) && //min Y
			ADDR%screenW <=(scoreTopLeft%screenW +segL + segGap + segS) &&  //max X
			ADDR%screenW >=(scoreTopLeft%screenW)				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
	end

//Lower Left (Segment 4)

else if (~scoreSegment[4] &&
			
			ADDR/screenW <=(scoreTopLeft/screenW + segS + segGap + segL + segGap + segL) && //max Y
			ADDR/screenW >= (scoreTopLeft/screenW + segS + segGap + segL + segGap) &&		//min Y
			ADDR%screenW <=(scoreTopLeft%screenW + segS) && //max X
			ADDR%screenW >=(scoreTopLeft%screenW)				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
	end
	
//Upper Left (Segment 5)

else if (~scoreSegment[5] &&
			
			ADDR/screenW <=(scoreTopLeft/screenW + segS + segGap + segL) && //max Y
			ADDR/screenW >= (scoreTopLeft/screenW + segS + segGap) &&		//min Y
			ADDR%screenW <=(scoreTopLeft%screenW + segS) && 	//max X
			ADDR%screenW >=(scoreTopLeft%screenW )				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
	end

	
//Center (Segment 6)

else if (~scoreSegment[6] &&
			
			ADDR/screenW <=(scoreTopLeft/screenW + segS + segGap + segL + segS) && //max Y
			ADDR/screenW >= (scoreTopLeft/screenW + segS + segGap + segL) &&		//min Y
			ADDR%screenW <=(scoreTopLeft%screenW + segL) && 	//max X
			ADDR%screenW >=(scoreTopLeft%screenW + segS + segGap )				//min X
			)
	begin
		b_data = 8'h00;
		g_data = 8'h00;
		r_data = 8'h00;
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









