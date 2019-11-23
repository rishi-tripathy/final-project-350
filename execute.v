module execute(ir, regA, regB, startOp, clock, data_result, data_ready, data_exception, isNotEqual, isLessThan);
	input [31:0] ir, regA, regB;
	input clock, startOp;
	output [31:0] data_result;
	output data_ready, data_exception, isNotEqual, isLessThan;
	wire isNotEqual0, isNotEqual1, isLessThan0, isLessThan1;
	
	wire w0, w1, mult_div;
	assign w0 = ir[3];
	assign w1 = ir[4];
	and a0(mult_div, w0, w1);
	
	wire [31:0] alu_result, alu_result0, alu_result1, md_result;
	wire alu_exception0, alu_exception1, md_exception, md_ready;
	
	wire multCtrl, divCtrl; //1 when a new mult or div should start
	and a1(multCtrl, startOp, ir[2]);
	and a2(divCtrl, startOp, ir[2]);
	
	wire [31:0] N;
	assign N[16:0] = ir[16:0];
	assign N[31:17] = 15'b0;
	wire [4:0] ad_op = 5'b0;
	
	
	wire ignore0, ignore1;
	
	alu alu0(regA, regB, ir[6:2], ir[11:7], alu_result0, isNotEqual0, isLessThan0, alu_exception0);
	alu alu1(regA, N, ad_op, ad_op, alu_result1, isNotEqual1, isLessThan1, alu_exception1);
	
	multdiv md0(regA, regB, multCtrl, divCtrl, clock, md_result, md_exception, md_ready);
	
	assign data_ready = mult_div ? md_ready : 1;
	
	wire I;
	or (I, ir[30], ir[27]);
	
	assign alu_result = I ? alu_result1 : alu_result0;
	assign isNotEqual = I ? isNotEqual1 : isNotEqual0;
	assign isLessThan = I ? isLessThan1 : isLessThan0;
	
	assign data_result = mult_div ? md_result : alu_result;
	assign data_exception = mult_div ? md_exception : alu_exception0;

endmodule
