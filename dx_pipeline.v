module dx_pipeline(pc, ir, regA, dataA, regB, dataB, regA_ctrl_q, dataA_q, regB_ctrl_q, dataB_q, ir_q, pc_q, clk, en, clr);
	input [31:0] ir, dataA, dataB;
	input [11:0] pc;
	input [4:0] regA, regB;
	input clr, en, clk;
	
	output [31:0] ir_q, dataA_q, dataB_q;
	output [11:0] pc_q;
	output [4:0] regA_ctrl_q, regB_ctrl_q;
	
	dffe_ref dffv0(.d(regA[0]), .q(regA_ctrl_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffv1(.d(regA[1]), .q(regA_ctrl_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffv2(.d(regA[2]), .q(regA_ctrl_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffv3(.d(regA[3]), .q(regA_ctrl_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffv4(.d(regA[4]), .q(regA_ctrl_q[4]), .clr(clr), .clk(clk), .en(en));
	
	dffe_ref dffvv0(.d(regB[0]), .q(regB_ctrl_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffvv1(.d(regB[1]), .q(regB_ctrl_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffvv2(.d(regB[2]), .q(regB_ctrl_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffvv3(.d(regB[3]), .q(regB_ctrl_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffvv4(.d(regB[4]), .q(regB_ctrl_q[4]), .clr(clr), .clk(clk), .en(en));
	
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
	
	dffe_ref dff0a(.d(dataA[0]), .q(dataA_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a(.d(dataA[1]), .q(dataA_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a(.d(dataA[2]), .q(dataA_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3a(.d(dataA[3]), .q(dataA_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4a(.d(dataA[4]), .q(dataA_q[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5a(.d(dataA[5]), .q(dataA_q[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6a(.d(dataA[6]), .q(dataA_q[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7a(.d(dataA[7]), .q(dataA_q[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8a(.d(dataA[8]), .q(dataA_q[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9a(.d(dataA[9]), .q(dataA_q[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a0(.d(dataA[10]), .q(dataA_q[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a1(.d(dataA[11]), .q(dataA_q[11]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a2(.d(dataA[12]), .q(dataA_q[12]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a3(.d(dataA[13]), .q(dataA_q[13]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a4(.d(dataA[14]), .q(dataA_q[14]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a5(.d(dataA[15]), .q(dataA_q[15]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a6(.d(dataA[16]), .q(dataA_q[16]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a7(.d(dataA[17]), .q(dataA_q[17]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a8(.d(dataA[18]), .q(dataA_q[18]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a9(.d(dataA[19]), .q(dataA_q[19]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a0(.d(dataA[20]), .q(dataA_q[20]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a1(.d(dataA[21]), .q(dataA_q[21]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a2(.d(dataA[22]), .q(dataA_q[22]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a3(.d(dataA[23]), .q(dataA_q[23]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a4(.d(dataA[24]), .q(dataA_q[24]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a5(.d(dataA[25]), .q(dataA_q[25]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a6(.d(dataA[26]), .q(dataA_q[26]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a7(.d(dataA[27]), .q(dataA_q[27]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a8(.d(dataA[28]), .q(dataA_q[28]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a9(.d(dataA[29]), .q(dataA_q[29]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3a0(.d(dataA[30]), .q(dataA_q[30]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3a1(.d(dataA[31]), .q(dataA_q[31]), .clr(clr), .clk(clk), .en(en));
	
	dffe_ref dff0b(.d(dataB[0]), .q(dataB_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b(.d(dataB[1]), .q(dataB_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b(.d(dataB[2]), .q(dataB_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3b(.d(dataB[3]), .q(dataB_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4b(.d(dataB[4]), .q(dataB_q[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5b(.d(dataB[5]), .q(dataB_q[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6b(.d(dataB[6]), .q(dataB_q[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7b(.d(dataB[7]), .q(dataB_q[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8b(.d(dataB[8]), .q(dataB_q[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9b(.d(dataB[9]), .q(dataB_q[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b0(.d(dataB[10]), .q(dataB_q[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b1(.d(dataB[11]), .q(dataB_q[11]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b2(.d(dataB[12]), .q(dataB_q[12]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b3(.d(dataB[13]), .q(dataB_q[13]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b4(.d(dataB[14]), .q(dataB_q[14]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b5(.d(dataB[15]), .q(dataB_q[15]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b6(.d(dataB[16]), .q(dataB_q[16]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b7(.d(dataB[17]), .q(dataB_q[17]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b8(.d(dataB[18]), .q(dataB_q[18]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b9(.d(dataB[19]), .q(dataB_q[19]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b0(.d(dataB[20]), .q(dataB_q[20]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b1(.d(dataB[21]), .q(dataB_q[21]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b2(.d(dataB[22]), .q(dataB_q[22]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b3(.d(dataB[23]), .q(dataB_q[23]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b4(.d(dataB[24]), .q(dataB_q[24]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b5(.d(dataB[25]), .q(dataB_q[25]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b6(.d(dataB[26]), .q(dataB_q[26]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b7(.d(dataB[27]), .q(dataB_q[27]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b8(.d(dataB[28]), .q(dataB_q[28]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b9(.d(dataB[29]), .q(dataB_q[29]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3b0(.d(dataB[30]), .q(dataB_q[30]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3b1(.d(dataB[31]), .q(dataB_q[31]), .clr(clr), .clk(clk), .en(en));
	
	dffe_ref dff0c(.d(ir[0]), .q(ir_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c(.d(ir[1]), .q(ir_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c(.d(ir[2]), .q(ir_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3c(.d(ir[3]), .q(ir_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4c(.d(ir[4]), .q(ir_q[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5c(.d(ir[5]), .q(ir_q[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6c(.d(ir[6]), .q(ir_q[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7c(.d(ir[7]), .q(ir_q[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8c(.d(ir[8]), .q(ir_q[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9c(.d(ir[9]), .q(ir_q[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c0(.d(ir[10]), .q(ir_q[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c1(.d(ir[11]), .q(ir_q[11]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c2(.d(ir[12]), .q(ir_q[12]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c3(.d(ir[13]), .q(ir_q[13]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c4(.d(ir[14]), .q(ir_q[14]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c5(.d(ir[15]), .q(ir_q[15]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c6(.d(ir[16]), .q(ir_q[16]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c7(.d(ir[17]), .q(ir_q[17]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c8(.d(ir[18]), .q(ir_q[18]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1c9(.d(ir[19]), .q(ir_q[19]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c0(.d(ir[20]), .q(ir_q[20]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c1(.d(ir[21]), .q(ir_q[21]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c2(.d(ir[22]), .q(ir_q[22]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c3(.d(ir[23]), .q(ir_q[23]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c4(.d(ir[24]), .q(ir_q[24]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c5(.d(ir[25]), .q(ir_q[25]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c6(.d(ir[26]), .q(ir_q[26]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c7(.d(ir[27]), .q(ir_q[27]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c8(.d(ir[28]), .q(ir_q[28]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2c9(.d(ir[29]), .q(ir_q[29]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3c0(.d(ir[30]), .q(ir_q[30]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3c1(.d(ir[31]), .q(ir_q[31]), .clr(clr), .clk(clk), .en(en));
endmodule
