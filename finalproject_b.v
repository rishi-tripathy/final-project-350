module finalproject_b(score, in, clock, count);
input clock;
output[6:0] score;
input in;
reg[7:0] count;
reg[31:0] sampler;
output count;

always @(posedge clock)
begin
	sampler <= sampler + 32'b1;
	if (sampler>32'd20000000)
	begin
		sampler <= 32'b0;
		count <= count + in;
	end
end

Hexadecimal_To_Seven_Segment h(count[3:0], score);

endmodule
