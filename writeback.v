module writeback(ir, output_xm, data_mw, ctrl_writeEnable, ctrl_writeReg, data_writeReg, exception);
	input [31:0] ir, output_xm, data_mw;
	input exception;
	output [4:0] ctrl_writeReg;
	output [31:0] data_writeReg;
	output ctrl_writeEnable;

	wire n0, n1, n2, n3, n4;
	
	not not0(n0, ir[27]);
	not not1(n1, ir[28]);
	not not2(n2, ir[29]);
	not not3(n3, ir[30]);
	not not4(n4, ir[31]);
	
	wire op0, op1, op2;
	and a0(op0, n0, n1, n2, n3, n4); //alu op
	and a1(op1, ir[27], n1, ir[29], n3, n4); //addi
	and a2(op2, n0, n1, n2, ir[30], n4); //load word
	
	or o0(ctrl_writeEnable, op0, op1, op2);
	
	wire[4:0] rstatus;
	assign rstatus[0] = 0;
	assign rstatus[1] = 1;
	assign rstatus[2] = 1;
	assign rstatus[3] = 1;
	assign rstatus[4] = 1;
	
	assign ctrl_writeReg = exception ? rstatus : ir[26:22];
	
	wire [31:0] dataaaa;
	assign dataaaa = op2 ? data_mw : output_xm;
	
	wire nn0, nn1, nn2, nn3, nn4;
	
	not nnot0(nn0, ir[2]);
	not nnot1(nn1, ir[3]);
	not nnot2(nn2, ir[4]);
	not nnot3(nn3, ir[5]);
	not nnot4(nn4, ir[6]);
	
	wire add, addi, sub, addorsub, addiorsub;
	and aaa(add, nn0, nn1, nn2, nn3, nn4, op0);
	and aaa1(addi, ir[27], n1, ir[29], n3, n4);
	and aaa2(sub, ir[2], nn1, nn2, nn3, nn4, op0);
	
	or ooo(addorsub, add, sub);
	or oooooo(addiorsub, addi, sub);
	
	
	wire [31:0] exNum;
	assign exNum[0] = addorsub;
	assign exNum[1] = addiorsub;
	assign exNum[31:2] = 29'b0;
	
	assign data_writeReg = exception ? exNum : dataaaa;
	
	
endmodule
