module test (SW0,SW1,SW2,SW3,SW4,SW5,SW6,SW7,SW8,SW9,clk,reset,out_port0,out_port1,out_port2,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

	input reset,clk;
	input SW0,SW1,SW2,SW3,SW4,SW5,SW6,SW7,SW8,SW9;
	
	output [31:0] 	out_port0, out_port1, out_port2;

	output wire [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;

	wire clock_out;

	wire [31:0] in_port0,in_port1;
	
	clock_and_mem_clock inst(clk,clock_out);
	//assign clock_out=clk;
	
	in_port inst1(SW4,SW3,SW2,SW1,SW0,in_port0);
	in_port inst2(SW9,SW8,SW7,SW6,SW5,in_port1);
	
	sc_computer inst4(in_port0,in_port1,reset,clock_out,clk,out_port0,out_port1,out_port2);
	//sc_computer inst4(inpt0,inpt1,resetn,clock,mem_clk,out_port0,out_port1,out_port2);//aaa
	
	out_port_seg inst5(out_port0,HEX0,HEX1);// HEX奇数为高位，偶数为低位
	out_port_seg inst6(out_port1,HEX2,HEX3);
	out_port_seg inst7(out_port2,HEX4,HEX5);
	
	
endmodule
	