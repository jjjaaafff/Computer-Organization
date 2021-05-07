module pipeif( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock );
	input  [1:0]  pcsource;
	input			  mem_clock;
	input  [31:0] pc, bpc, jpc, da;
	output [31:0] npc, pc4, ins;
	wire	 [31:0] npc, pc4, ins;
	assign pc4 = pc + 4;
	
	wire [31:0] fetched_ins;
	mux4x32 nextpc( pc4, bpc, da, jpc, pcsource, npc ); // 下一个pc值
	lpm_rom_irom irom( pc[7:2], mem_clock, fetched_ins );
	assign ins = (pcsource[0]|pcsource[1])? 32'h0:fetched_ins;
endmodule 