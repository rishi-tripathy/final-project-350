module pc_pipeline(pc, pc_q, clk, en, clr);
	input [11:0] pc;
	output [11:0] pc_q;
	input clk, en, clr;
	
	dffe_ref dff0(.d(pc[0]), .q(pc_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1(.d(pc[1]), .q(pc_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2(.d(pc[2]), .q(pc_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3(.d(pc[3]), .q(pc_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4(.d(pc[4]), .q(pc_q[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5(.d(pc[5]), .q(pc_q[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6(.d(pc[6]), .q(pc_q[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7(.d(pc[7]), .q(pc_q[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8(.d(pc[8]), .q(pc_q[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9(.d(pc[9]), .q(pc_q[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff10(.d(pc[10]), .q(pc_q[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff11(.d(pc[11]), .q(pc_q[11]), .clr(clr), .clk(clk), .en(en));
	
endmodule
