module finalproject_b(score_seg_ones, score_seg_tens, in0, in1, in2, clock, count, enA, reset);
input clock, enA, reset;
output[6:0] score_seg_ones, score_seg_tens;
input in0, in1, in2;
reg[7:0] count;
reg[31:0] sampler;
reg [7:0] triggerCount;
output count;

always @(posedge clock)
begin
	if (reset == 1) begin
		sampler <= 32'b0;
		count <= 8'b0;
		triggerCount <= 8'b0;
	end
	sampler <= sampler + 32'b1;
	if (in0 == 1 || in1 == 1 || in2 == 1) begin
		triggerCount <= triggerCount + 1;
	end
	if (sampler > 32'd100000000 && enA ==1) begin
		if (triggerCount > 0) begin
			count <= count + 1;
		end
		triggerCount <= 8'b0;
		sampler <= 32'b0;
	end
end
	
	

//always @(posedge clock)
//begin
//	if (reset == 1) begin
//		sampler <= 32'b0;
//		count <= 8'b0;
//	end
//	sampler <= sampler + 32'b1;
//	//toAdd <= in0 + in1 + in2;
//	if (sampler>32'd2000000 && enA == 1)
//	begin
//		sampler <= 32'b0;
//		if (in0 == 1 || in1== 1 || in2 == 1) begin
//			count <= count + 1;
//		end
//	end
//end

Decimal_To_Seven_Segment h(clock, count, score_seg_ones, score_seg_tens);

endmodule
