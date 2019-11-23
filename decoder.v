module decoder(ir, readRegA, readRegB);
	input [31:0] ir;
	output [4:0] readRegA, readRegB;
	
	assign readRegA = ir[21:17];
	
	wire [4:0] opcode;
	assign opcode = ir[31:27];
	
	wire n0, n1, n2, n3, n4, rtOp;

	not not0(n0, opcode[0]);
	not not1(n1, opcode[1]);
	not not2(n2, opcode[2]);
	not not3(n3, opcode[3]);
	not not4(n4, opcode[4]);
	and a0(rtOp, n0, n1, n2, n3, n4);
	
	assign readRegB = rtOp ? ir[16:12] : ir[26:22];
	
endmodule
