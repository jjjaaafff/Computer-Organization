module in_port(SW4,SW3,SW2,SW1,SW0,in_port0);
	input SW4,SW3,SW2,SW1,SW0;
	output [31:0] in_port0;
	assign in_port0={27'b0,SW4,SW3,SW2,SW1,SW0};
endmodule
