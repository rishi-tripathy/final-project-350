/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile

//	 alu_inputA,							//test outputs
//	 alu_inputB,
//	 ex_out,
//	 decode_insn,
//	 execute_insn,
//	 memory_insn,
//	 writeback_insn,
//	 readRegA, readRegB,
//	 write_reg, write_data,
//	 reset_branch, notEqual, b_n_e, branch_opcode, jumper, tb, m_x_controlA, w0, w1, w2, w3, w4, w_en, mem_data, regB_memInput
	// mem_writeReg
);
    // Control signals
    input clock, reset;
	 
	 //testing ports
	 //output [31:0] alu_inputA, alu_inputB;
	 wire[31:0] alu_output;
	 //output alu_data_ready;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 wire [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 wire [11:0] new_pc, pc;
	 wire[31:0] pc_plus_1;
	 
	 pc_pipeline p(pc, new_pc, clock, 1, reset);//branch_jump_reset);
	 
	 //fetch stage
	 assign address_imem = new_pc;
	 
	 wire [31:0] pc_32, one;
	 assign pc_32[11:0] = new_pc;
	 assign pc_32[31:12] = 20'b0;
	 assign one[31:1] = 31'b0;
	 assign one[0] = 1;
	 
	 wire[4:0] ad_opcode;
	 assign ad_opcode = 5'b0;
	 
	 alu alu0(pc_32, one, ad_opcode, ad_opcode, pc_plus_1, ignore, ignore1, ignore2); //use ad_opcode for shamt also b/c it's all 0's
	 
	 wire blt, bne, take_branch;
	 //output [4:0] branch_opcode;
	 //assign branch_opcode = ir_dx[31:27];
	 wire n0, n1, n2, n3, n4;
	 not not0(n0, ir_dx[27]);
	 not not1(n1, ir_dx[28]);
	 not not2(n2, ir_dx[29]);
	 not not3(n3, ir_dx[30]);
	 not not4(n4, ir_dx[31]);
	 
	 wire blt_lessthan;
	 not nlt(blt_lessthan, isLessThan);
	 and aa(blt, n0, ir_dx[28], ir_dx[29], n3, n4, blt_lessthan);
	 and aa1(bne, n0, ir_dx[28], n2, n3, n4, isNotEqual);
	 //output notEqual;
	 //assign notEqual = isNotEqual;
	 or oo(take_branch, blt, bne);
	 
	 //output jumper, tb;//,tb0,tb1,tb2,tb3,tb4;
	 //assign jumper = jump;
	 //assign tb = take_branch;
	 
	 wire [11:0] plus1OrJump;
	 assign plus1OrJump =  jump ? j_pc : pc_plus_1[11:0];
	 assign pc = take_branch ? pc_plus_1_N[11:0] : plus1OrJump;
	 
	 wire [31:0] ir_fd;
	 wire [11:0] pc_fd;
	 
	 wire branch_reset, branch_jump_reset;
	 or ooo(branch_reset, take_branch, reset);
	 or oooo(branch_jump_reset, branch_reset, jump); //want to reset 1 instruction if jump was taken
	 
	 fd_pipeline fd(new_pc, q_imem, ir_fd, pc_fd, clock, 1, branch_reset);
	 
	 //output [31:0] decode_insn;
	 //assign decode_insn = ir_fd;
	 
	 //get registers to read from
	 decoder d(ir_fd, ctrl_readRegA, ctrl_readRegB);
	 
	 //wire [5:0] j_op;
	 //assign j_op = ir_fd[31:27];
	 wire n00, n01, n02, n03, n04;
	 not not00(n00, ir_fd[27]);
	 not not10(n01, ir_fd[28]);
	 not not20(n02, ir_fd[29]);
	 not not30(n03, ir_fd[30]);
	 not not40(n04, ir_fd[31]);
	 
	 wire pcT, pcT1, pcT2, pcRd;
	 and aaa(pcT1, ir_fd[27], n01, n02, n03, n04);//n00, n01, n02, j_op[4]);
	 and aaa2(pcT2, ir_fd[27], ir_fd[28], n02, n03, n04);
	 or oooo2(pcT, pcT1, pcT2);
	 and aaa1(pcRd, n00, n01,  ir_fd[29], n03, n04);
	 
	 wire [11:0] j_pc;
	 assign j_pc = pcT ? ir_fd[11:0] : regB_q[11:0];
	 wire jump;
	 or orrrr(jump, pcT, pcRd);
	 
	 wire[4:0] regA, regB, regA_ctrl_q, regB_ctrl_q;
	 assign regA = ctrl_readRegA;
	 assign regB = ctrl_readRegB;
	 
	 //output [4:0] readRegA, readRegB;
	 //assign readRegA = ctrl_readRegA;
	 //assign readRegB = ctrl_readRegB;
	 
	 wire [31:0] regA_q, regB_q, ir_dx, pc_dx;
	 //output reset_branch, b_n_e;
	 //assign reset_branch = branch_reset;
	 //assign b_n_e = bne;
	 dx_pipeline dx(pc_fd, ir_fd, regA, data_readRegA, regB, data_readRegB, regA_ctrl_q, regA_q, regB_ctrl_q, regB_q, ir_dx, pc_dx, clock, 1, reset);
	 
	 //do the alu op or multdiv op
	 wire startNewOp;
	 assign startNewOp = 1;
	 //assign alu_inputA = regA_q;
	 //assign alu_inputB = regB_q;
	 //assign alu_output = data_output_w0;
	 //assign alu_data_ready = data_ready;
	 
	 //output [31:0] execute_insn;
	 //assign execute_insn = ir_dx;
	 
	 wire [31:0] data_output_w0, data_output_w1, data_output_w2;
	 wire isNotEqual, isLessThan;
	 
	 wire [31:0] regA_data, regB_data;
	 wire w0, w1, w2,w3,w4,w00,w01,w02,w03,w04, w_x_controlA, w_x_controlB;
	 
	 //check if regA is being written to
	 xnor z0(w0, regA_ctrl_q[0], w_reg[0]);
	 xnor z1(w1, regA_ctrl_q[1], w_reg[1]);
	 xnor z2(w2, regA_ctrl_q[2], w_reg[2]);
	 xnor z3(w3, regA_ctrl_q[3], w_reg[3]);
	 xnor z4(w4, regA_ctrl_q[4], w_reg[4]);
	 and z5(w_x_controlA, w0, w1, w2, w3, w4, w_en);
	 //output m_x_controlA;
	 //output w0, w1, w2, w3, w4, w_en;
	 
	 //check if regB is being written to
	 xnor zz0(w00, regB_ctrl_q[0], w_reg[0]);
	 xnor zz1(w01, regB_ctrl_q[1], w_reg[1]);
	 xnor zz2(w02, regB_ctrl_q[2], w_reg[2]);
	 xnor zz3(w03, regB_ctrl_q[3], w_reg[3]);
	 xnor zz4(w04, regB_ctrl_q[4], w_reg[4]);
	 and zz5(w_x_controlB, w00, w01, w02, w03, w04, w_en);
	 
	 wire m_x_controlA, m_x_controlB;
	 
	 wire wb0, wb1, wb2, wb3, wb4, wbb0, wbb1, wbb2, wbb3, wbb4;
	 xnor zb0(wb0, regA_ctrl_q[0], mem_writeReg[0]);
	 xnor zb1(wb1, regA_ctrl_q[1], mem_writeReg[1]);
	 xnor zb2(wb2, regA_ctrl_q[2], mem_writeReg[2]);
	 xnor zb3(wb3, regA_ctrl_q[3], mem_writeReg[3]);
	 xnor zb4(wb4, regA_ctrl_q[4], mem_writeReg[4]);
	 and zb5(m_x_controlA, wb0, wb1, wb2, wb3, wb4, mem_writeEnable);
	 
	 xnor zbb0(wbb0, regB_ctrl_q[0], mem_writeReg[0]);
	 xnor zbb1(wbb1, regB_ctrl_q[1], mem_writeReg[1]);
	 xnor zbb2(wbb2, regB_ctrl_q[2], mem_writeReg[2]);
	 xnor zbb3(wbb3, regB_ctrl_q[3], mem_writeReg[3]);
	 xnor zbb4(wbb4, regB_ctrl_q[4], mem_writeReg[4]);
	 and zbb5(m_x_controlB, wbb0, wbb1, wbb2, wbb3, wbb4, mem_writeEnable);
	 
	 wire bypass_controlA, bypass_controlB, mem_bypass;
	 or oasfad(bypass_controlA, m_x_controlA, w_x_controlA);
	 or dafs(bypass_controlB, m_x_controlB, w_x_controlB);
	 or adsaf(mem_bypass, m_x_controlA, m_x_controlB);
	 
	 wire [31:0] toBypassA, toBypassB;
	 //output [31:0] mem_data;
	 assign toBypassA = m_x_controlA ? mem_data : w_data;
	 assign toBypassB = m_x_controlB ? mem_data : w_data;
	
	 assign regA_data = bypass_controlA ? toBypassA : regA_q;
	 assign regB_data = bypass_controlB ? toBypassB : regB_q;
	 wire data_exception, exception_xm, exception_mw;
	 
	 execute x(ir_dx, regA_data, regB_data, startNewOp, clock, data_output_w0, data_ready, data_exception, isNotEqual, isLessThan);
	 
	 wire [31:0] pc_plus_1_N, n;
	 assign n[16:0] = ir_dx[16:0];
	 assign n[31:17] = 15'b0;
	 alu alu1(new_pc, n, ad_opcode, ad_opcode, pc_plus_1_N, ignore3, ignore4, ignore5);
	 
	 //output [31:0] ex_out;
	 //assign ex_out = data_output_w0;
	 
	 wire [31:0] ir_xm, regB_xm;
	 wire [4:0] regBaddr;
	 xm_pipeline xm(ir_dx, data_output_w0, regB_ctrl_q, regB_q, data_output_w1, regBaddr, regB_xm, ir_xm, clock, 1, reset, data_exception, exception_xm);
	
	//bypassing m->x
	 wire [31:0] mem_data;
	 wire [4:0] mem_writeReg;
	 wire mem_writeEnable;
	 
	 assign mem_data = data_output_w1;
	 
	 wire nh0, nh1, nh2, nh3, nh4;
	 not noth0(nh0, ir_xm[27]);
	 not noth1(nh1, ir_xm[28]);
	 not noth2(nh2, ir_xm[29]);
	 not noth3(nh3, ir_xm[30]);
	 not noth4(nh4, ir_xm[31]);
	 
	 wire op0, op1, op2, writeEnable;
	 and ah0(op0, nh0, nh1, nh2, nh3, nh4); //alu op
	 and a1h(op1, ir_xm[27], nh1, ir_xm[29], nh3, nh4); //addi
	 and a2h(op2, nh0, nh1, nh2, ir_xm[30], nh4); //load word
	 or oh0(mem_writeEnable, op0, op1, op2);
	 
	 assign mem_writeReg = ir_xm[26:22];
	 
	 //output [31:0] memory_insn;
	 //assign memory_insn = ir_xm;
	 
	 wire [31:0] regB_memInput;
	 wire w000,w001,w002,w003,w004, w_m_controlB;
	 
	 xnor zzz0(w000, regBaddr[0], w_reg[0]);
	 xnor zzz1(w001, regBaddr[1], w_reg[1]);
	 xnor zzz2(w002, regBaddr[2], w_reg[2]);
	 xnor zzz3(w003, regBaddr[3], w_reg[3]);
	 xnor zzz4(w004, regBaddr[4], w_reg[4]);
	 and zzz5(w_m_controlB, w000, w001, w002, w003, w004, w_en);
	 
	 assign regB_memInput = w_m_controlB ? w_data : regB_xm;
	 
	 //output [31:0] regB_memInput;
	 
	 //address to read from/write to, whether to read or write, what to write
	 memory m(ir_xm, data_output_w1, regB_memInput, address_dmem, data, wren);
	 
	 wire [31:0] data_mw, ir_mw;
	 mw_pipeline mw(ir_xm, data_output_w1, q_dmem, data_output_w2, data_mw, ir_mw, clock, 1, reset, exception_xm, exception_mw);
	 
	 //output [31:0] writeback_insn;
	 //assign writeback_insn = ir_mw;
	 //determine if a register should be written to; if so which reg, and what to write
	 writeback w(ir_mw, data_output_w2, data_mw, ctrl_writeEnable, ctrl_writeReg, data_writeReg, exception_mw);
	 
	 wire w_en;
	 assign w_en = ctrl_writeEnable;
	 wire [4:0] w_reg;
	 //output [4:0] write_reg;
	 //assign write_reg = ctrl_writeReg;
	 assign w_reg = ctrl_writeReg;
	 //output [31:0] write_data;
	 wire [31:0] w_data;
	 //assign write_data = data_writeReg;
	 assign w_data = data_writeReg;
	 

endmodule
