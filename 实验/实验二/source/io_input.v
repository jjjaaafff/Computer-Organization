module io_input(addr,io_clk,io_read_data,in_port0,in_port1);
	input [31:0] addr;
	input io_clk;
	input [31:0] in_port0,in_port1;
	output [31:0] io_read_data;
	
	reg [31:0] in_reg0;// input port 0
	reg [31:0] in_reg1;// input port 1
	io_input_mux io_input_mux2x32(in_reg0,in_reg1,addr[7:2],io_read_data);
	
	always@(posedge io_clk)
	begin //这里有问题，调换顺序才能保证结果一致
		in_reg0 <= in_port1;  //输入端口在io_clk上升沿锁存
		in_reg1 <= in_port0;
		//可根据需要设计更多端口
	end
	
endmodule 