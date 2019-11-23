module memory(ir, output_xm, regB_xm, address_dmem, data, wren);
	input [31:0] ir, output_xm, regB_xm;
	output [11:0] address_dmem;
	output [31:0] data;
	output wren;
	
	wire store;
	and a0(store, ir[27], ir[28], ir[29]);
	
	assign wren = store;
	
	assign address_dmem = output_xm[11:0];
	
	assign data = regB_xm;
	
endmodule
