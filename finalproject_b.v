module finalproject_b(score, in, clock, count, enA, reset);
input clock, enA, reset;
output[6:0] score;
input in;
reg[7:0] count;
reg[31:0] sampler;
output count;

always @(posedge clock)
begin
	if (reset == 1) begin
		sampler <= 32'b0;
		count <= 8'b0;
	end

	sampler <= sampler + 32'b1;
	if (sampler>32'd20000000 && enA == 1)
	begin
		sampler <= 32'b0;
		count <= count + in;
	end
end

Hexadecimal_To_Seven_Segment h(count[3:0], score);

endmodule
