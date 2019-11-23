module xm_pipeline(ir, result, Baddr, dataB, out, Baddr_q, dataB_q, ir_q, clk, en, clr, exception, exception_q);
	
	input [31:0] ir, result, dataB;
	input [4:0] Baddr;
	input clk, clr, en, exception;
	output [31:0] out, dataB_q ,ir_q;
	output [4:0] Baddr_q;
	output exception_q;
	
	dffe_ref dff00(.d(exception), .q(exception_q), .clr(clr), .clk(clk), .en(en));
	
	dffe_ref dffg0(.d(Baddr[0]), .q(Baddr_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffg1(.d(Baddr[1]), .q(Baddr_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffg2(.d(Baddr[2]), .q(Baddr_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffg3(.d(Baddr[3]), .q(Baddr_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dffg4(.d(Baddr[4]), .q(Baddr_q[4]), .clr(clr), .clk(clk), .en(en));

	dffe_ref dff0(.d(result[0]), .q(out[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1(.d(result[1]), .q(out[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2(.d(result[2]), .q(out[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3(.d(result[3]), .q(out[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4(.d(result[4]), .q(out[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5(.d(result[5]), .q(out[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6(.d(result[6]), .q(out[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7(.d(result[7]), .q(out[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8(.d(result[8]), .q(out[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9(.d(result[9]), .q(out[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff10(.d(result[10]), .q(out[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff11(.d(result[11]), .q(out[11]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff12(.d(result[12]), .q(out[12]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff13(.d(result[13]), .q(out[13]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff14(.d(result[14]), .q(out[14]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff15(.d(result[15]), .q(out[15]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff16(.d(result[16]), .q(out[16]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff17(.d(result[17]), .q(out[17]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff18(.d(result[18]), .q(out[18]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff19(.d(result[19]), .q(out[19]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff20(.d(result[20]), .q(out[20]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff21(.d(result[21]), .q(out[21]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff22(.d(result[22]), .q(out[22]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff23(.d(result[23]), .q(out[23]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff24(.d(result[24]), .q(out[24]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff25(.d(result[25]), .q(out[25]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff26(.d(result[26]), .q(out[26]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff27(.d(result[27]), .q(out[27]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff28(.d(result[28]), .q(out[28]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff29(.d(result[29]), .q(out[29]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff30(.d(result[30]), .q(out[30]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff31(.d(result[31]), .q(out[31]), .clr(clr), .clk(clk), .en(en));
	
	dffe_ref dff0a(.d(dataB[0]), .q(dataB_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a(.d(dataB[1]), .q(dataB_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a(.d(dataB[2]), .q(dataB_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3a(.d(dataB[3]), .q(dataB_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4a(.d(dataB[4]), .q(dataB_q[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5a(.d(dataB[5]), .q(dataB_q[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6a(.d(dataB[6]), .q(dataB_q[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7a(.d(dataB[7]), .q(dataB_q[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8a(.d(dataB[8]), .q(dataB_q[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9a(.d(dataB[9]), .q(dataB_q[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a0(.d(dataB[10]), .q(dataB_q[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a1(.d(dataB[11]), .q(dataB_q[11]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a2(.d(dataB[12]), .q(dataB_q[12]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a3(.d(dataB[13]), .q(dataB_q[13]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a4(.d(dataB[14]), .q(dataB_q[14]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a5(.d(dataB[15]), .q(dataB_q[15]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a6(.d(dataB[16]), .q(dataB_q[16]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a7(.d(dataB[17]), .q(dataB_q[17]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a8(.d(dataB[18]), .q(dataB_q[18]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1a9(.d(dataB[19]), .q(dataB_q[19]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a0(.d(dataB[20]), .q(dataB_q[20]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a1(.d(dataB[21]), .q(dataB_q[21]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a2(.d(dataB[22]), .q(dataB_q[22]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a3(.d(dataB[23]), .q(dataB_q[23]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a4(.d(dataB[24]), .q(dataB_q[24]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a5(.d(dataB[25]), .q(dataB_q[25]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a6(.d(dataB[26]), .q(dataB_q[26]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a7(.d(dataB[27]), .q(dataB_q[27]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a8(.d(dataB[28]), .q(dataB_q[28]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2a9(.d(dataB[29]), .q(dataB_q[29]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3a0(.d(dataB[30]), .q(dataB_q[30]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3a1(.d(dataB[31]), .q(dataB_q[31]), .clr(clr), .clk(clk), .en(en));
	
	dffe_ref dff0b(.d(ir[0]), .q(ir_q[0]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b(.d(ir[1]), .q(ir_q[1]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b(.d(ir[2]), .q(ir_q[2]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3b(.d(ir[3]), .q(ir_q[3]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff4b(.d(ir[4]), .q(ir_q[4]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff5b(.d(ir[5]), .q(ir_q[5]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff6b(.d(ir[6]), .q(ir_q[6]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff7b(.d(ir[7]), .q(ir_q[7]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff8b(.d(ir[8]), .q(ir_q[8]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff9b(.d(ir[9]), .q(ir_q[9]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b0(.d(ir[10]), .q(ir_q[10]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b1(.d(ir[11]), .q(ir_q[11]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b2(.d(ir[12]), .q(ir_q[12]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b3(.d(ir[13]), .q(ir_q[13]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b4(.d(ir[14]), .q(ir_q[14]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b5(.d(ir[15]), .q(ir_q[15]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b6(.d(ir[16]), .q(ir_q[16]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b7(.d(ir[17]), .q(ir_q[17]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b8(.d(ir[18]), .q(ir_q[18]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff1b9(.d(ir[19]), .q(ir_q[19]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b0(.d(ir[20]), .q(ir_q[20]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b1(.d(ir[21]), .q(ir_q[21]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b2(.d(ir[22]), .q(ir_q[22]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b3(.d(ir[23]), .q(ir_q[23]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b4(.d(ir[24]), .q(ir_q[24]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b5(.d(ir[25]), .q(ir_q[25]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b6(.d(ir[26]), .q(ir_q[26]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b7(.d(ir[27]), .q(ir_q[27]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b8(.d(ir[28]), .q(ir_q[28]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff2b9(.d(ir[29]), .q(ir_q[29]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3b0(.d(ir[30]), .q(ir_q[30]), .clr(clr), .clk(clk), .en(en));
	dffe_ref dff3b1(.d(ir[31]), .q(ir_q[31]), .clr(clr), .clk(clk), .en(en));
endmodule