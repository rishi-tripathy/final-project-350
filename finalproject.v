module finalproject(out, led, in, clock);
input clock;
output[6:0] out;
output led;
input in;
reg[3:0] count;
reg[31:0] divider;
always @(posedge clock)
begin
	divider <= divider + 32'b1;
	if (divider>32'd20000000)
	begin
		divider <= 32'b0;
		count <= count + in;//count + in;

		//count <= count + 4'b1;
	end
end
assign led = in;
Hexadecimal_To_Seven_Segment (count, out);

endmodule