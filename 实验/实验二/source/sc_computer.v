/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (in_port0,in_port1,resetn,clock,mem_clk,out_port0,out_port1,out_port2);
   
   input resetn,clock,mem_clk;
	input [31:0] in_port0,in_port1;
   wire [31:0] pc,inst,aluout,memout;
   wire        imem_clk,dmem_clk;
	output [31:0] out_port0,out_port1,out_port2;
	wire	 [31:0] out_port0, out_port1, out_port2;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   
   sc_cpu cpu (clock,resetn,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem (aluout,data,memout,wmem,clock,mem_clk,dmem_clk,resetn,
	out_port0,out_port1,out_port2,in_port0,in_port1,mem_dataout,io_read_data ); // data memory.

endmodule



