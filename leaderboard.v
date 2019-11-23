module leaderboard(clk, enA, score_count, user_id, score1, score2, score3, id1, id2, id3, enOut);
	input clk, enA;
	input [7:0] score_count;
	input [2:0] user_id;
	output [7:0] score1, score2, score3;
	output id1, id2, id3;
	
//	wire enA;
//	and a0(enA, ~enable[0], ~enable[1], ~enable[2], ~enable[3], ~enable[4], ~enable[5], ~enable[6], ~enable[7]);
	
	reg ctrl1, ctrl2, ctrl3;
	
	always @(enA)
	begin
		if (score_count >= score1) begin
			ctrl1 <= 1;
			ctrl2 <= 1;
			ctrl3 <= 1;
		end
		if (score_count < score1 && score_count >= score2) begin
			ctrl1 <= 0;
			ctrl2 <= 1;
			ctrl3 <= 1;
		end
		if (score_count < score2 && score_count >= score3) begin
			ctrl1 <= 0;
			ctrl2 <= 0;
			ctrl3 <= 1;
		end
		if (score_count < score3) begin
			ctrl1 <= 0;
			ctrl2 <= 0;
			ctrl3 <= 0;
		end
	end
	
	wire en1, en2, en3;
	and o1(en1, enA, ctrl1);
	and o2(en2, enA, ctrl2);
	and o3(en3, enA, ctrl3);
	
	output enOut;
	
	assign enOut = score_count[0];
	
	dffe_ref dff0a(.d(score_count[0]), .q(score1[0]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff1a(.d(score_count[1]), .q(score1[1]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff2a(.d(score_count[2]), .q(score1[2]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff3a(.d(score_count[3]), .q(score1[3]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff4a(.d(score_count[4]), .q(score1[4]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff5a(.d(score_count[5]), .q(score1[5]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff6a(.d(score_count[6]), .q(score1[6]), .clr(1'b0), .clk(clk), .en(en1));
	dffe_ref dff7a(.d(score_count[7]), .q(score1[7]), .clr(1'b0), .clk(clk), .en(en1));
	
	wire [7:0] second;
	assign second = ctrl1 ? score1 : score_count;
	
	dffe_ref dff0b(.d(second[0]), .q(score2[0]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff1b(.d(second[1]), .q(score2[1]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff2b(.d(second[2]), .q(score2[2]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff3b(.d(second[3]), .q(score2[3]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff4b(.d(second[4]), .q(score2[4]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff5b(.d(second[5]), .q(score2[5]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff6b(.d(second[6]), .q(score2[6]), .clr(clr), .clk(clk), .en(en2));
	dffe_ref dff7b(.d(second[7]), .q(score2[7]), .clr(clr), .clk(clk), .en(en2));
	
	wire [7:0] third;
	assign third = ctrl2 ? score2 : score_count;
	
	dffe_ref dff0c(.d(third[0]), .q(score3[0]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff1c(.d(third[1]), .q(score3[1]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff2c(.d(third[2]), .q(score3[2]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff3c(.d(third[3]), .q(score3[3]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff4c(.d(third[4]), .q(score3[4]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff5c(.d(third[5]), .q(score3[5]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff6c(.d(third[6]), .q(score3[6]), .clr(clr), .clk(clk), .en(en3));
	dffe_ref dff7c(.d(third[7]), .q(score3[7]), .clr(clr), .clk(clk), .en(en3));
	

endmodule