 module processor_init(clock, reset, regA, data_A, count, reg5, q_imem);
    input clock, reset;
	 input [31:0] count;

    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_imem;
    wire [31:0] q_imem;
	 output [31:0] q_imem;
	 //output [31:0] instruction;
	// assign instruction = q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (~clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (~clock),                  // may need to invert the clock
        .data	    (data),    // data you want to write
        .wren	    (wren),      // write enable
        .q          (q_dmem)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	 wire [4:0] writeReg;
	 wire writeEnable;
	 assign writeEnable = 1;
	 wire reg5;
	 output reg5;
	 and a4(reg5, ctrl_writeReg[0], ~ctrl_writeReg[1], ctrl_writeReg[2], ~ctrl_writeReg[3], ~ctrl_writeReg[4]);
	 assign writeReg = reg5 ? ctrl_writeReg : 5'd1;
	 assign writeVal = reg5 ? data_writeReg : count;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
	 
//	 output sig;
	 wire sig;
	 and aaa(sig, ~ctrl_readRegA[0], ~ctrl_readRegA[1], ~ctrl_readRegA[2], ~ctrl_readRegA[3], ~ctrl_readRegA[4]);
	 
	 output [4:0] regA;
	 //assign regA = readRegA;
	 assign regA = ctrl_writeReg;
	 
	 output [31:0] data_A;
	 wire [4:0] readRegA;
	 assign readRegA = sig ? 5'd5 : ctrl_readRegA;
//	 assign data_A = data_readRegA;
	 
	 assign data_A = data_writeReg;
    regfile my_regfile(
        clock,
        ctrl_writeEnable,
        ctrl_reset,
        writeReg,
        readRegA,
        ctrl_readRegB,
        writeVal,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
    processor my_processor(
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
        data_readRegB                  // I: Data from port B of regfile
//		  alu_inputA,
//		  alu_inputB,
//		  ex_out,
//		  decode_insn,
//		  execute_insn,
//		  memory_insn,
//		  writeback_insn,
//		  readRegA,
//		  readRegB,
//		  write_reg,
//		  write_data,
//		  branch_reset, isNotEqual, bne, branch_opcode, jumper, tb, m_x_controlA, wb0, wb1, wb2, wb3, wb4, mem_writeEnable, mem_data, regB_memInput
		  //mem_writeReg
    );
endmodule
