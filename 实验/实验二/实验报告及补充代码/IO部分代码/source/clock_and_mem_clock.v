module clock_and_mem_clock(clk,clock_out);
	input clk;
	output clock_out;
	reg clock_out;
	initial clock_out = 0;

	always @(posedge clk) clock_out <= ~clock_out;

endmodule 