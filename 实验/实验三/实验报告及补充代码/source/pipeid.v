module pipeid(mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,ins,
                    wrn,wdi,ealu,malu,mmo,wwreg,mem_clock,resetn,
					bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
					daluimm,da,db,dimm,dsa,drn,dshift,djal,mzero,
					drs,drt/*,npc*/,ebubble,dbubble);
	
	input  [4:0]  mrn, ern, wrn;
	input			  mm2reg, em2reg, mwreg, ewreg, wwreg, mem_clock, resetn;
	input  [31:0] ins, inst, wdi, ealu, malu, mmo, dpc4;
	output [31:0] bpc, dimm, dsa, jpc, da, db;
	output [1:0]  pcsource;
	output 		  wpcir, dwreg, dm2reg, dwmem, daluimm, dshift, djal, mzero, ebubble, dbubble;
	output [3:0]  daluc;
	output [4:0]  drs, drt, drn;
	
	wire   [31:0] q1, q2, da, db;
	wire	 [1:0]  fwda, fwdb;
	wire 			  rsrtequ = (da == db);
	wire          mzero = rsrtequ;
	wire          regrt, sext;
	wire          e = sext & inst[15];
	wire   [31:0] dimm = {{16{e}}, inst[15:0]};
	wire   [31:0] dsa = {27'b0, inst[10:6]};
	wire   [31:0] jpc = {dpc4[31:28],inst[25:0],1'b0,1'b0};
	wire   [31:0] offset = {{14{e}},inst[15:0],1'b0,1'b0};
	wire   [31:0] bpc = dpc4 + offset;
	wire	 [4:0]  drs = inst[25:21];
	wire	 [4:0]  drt = inst[20:16];
	wire          wpcir;
	
	assign wpcir = ~(em2reg & ((ern==drs)|(ern==drt)) & ~dwmem);
	assign dbubble = wpcir | pcsource != 0;
	
	
	regfile rf( drs, drt, wdi, wrn, wwreg, mem_clock, resetn, q1, q2 );  //寄存器堆
	mux4x32 da_mux( q1, ealu, malu, mmo, fwda, da ); // 四选一  可能的直通
	mux4x32 db_mux( q2, ealu, malu, mmo, fwdb, db );
	mux2x5  rn_mux( inst[15:11], inst[20:16], regrt, drn );
	//sc_cu cu(inst[31:26], inst[5:0], rsrtequ, dwmem, dwreg, regrt, dm2reg, daluc, dshift, daluimm, pcsource, djal, sext);//控制单元
	
	wire dwmem_tmp, dwreg_tmp, dm2reg_tmp, dshift_tmp, daluimm_tmp, djal_tmp;
	wire [3:0]  daluc_tmp; 
	sc_cu cu(inst[31:26], inst[5:0], rsrtequ, dwmem_tmp, dwreg_tmp, regrt, dm2reg_tmp, daluc_tmp, dshift_tmp, daluimm_tmp, 
	pcsource, djal_tmp, sext);
	assign dwreg = wpcir?dwreg_tmp:1'b0;
	assign dm2reg = wpcir?dm2reg_tmp:1'b0;
	assign dwmem = wpcir?dwmem_tmp:1'b0;
	assign daluimm = wpcir?daluimm_tmp:1'b0;
	assign dshift = wpcir?dshift_tmp:1'b0;
	assign djal = wpcir?djal_tmp:1'b0;
	assign daluc = wpcir?daluc_tmp:4'b0;
	
	
	
	
	forward a(ewreg, mwreg, ern, mrn, mm2reg, em2reg, drs, fwda);
	forward b(ewreg, mwreg, ern, mrn, mm2reg, em2reg, drt, fwdb);
	
	/*always @(*)
   begin
		fwda = 2'b00; //default forward a: no hazards
		if(ewreg & (ern != 0) & (ern == drs) & ~ em2reg) begin
         fwda<=2'b01; //select exe_alu
      end else begin 
			if (mwreg & (mrn != 0) & (mrn == drs) & ~ mm2reg) begin
            fwda<=2'b10; //select mem_alu
         end else begin  
            if  (mwreg & (mrn != 0) & (mrn == drs) & mm2reg) begin
               fwda<=2'b11; //select mem_lw
				end
			end
		end
   end

	always @(*)
   begin
		fwdb = 2'b00; //default forward b: no hazards
		if(ewreg & (ern != 0) & (ern == drt) & ~ em2reg) begin
         fwdb<=2'b01; //select exe_alu
      end else begin 
			if (mwreg & (mrn != 0) & (mrn == drt) & ~ mm2reg) begin
            fwdb<=2'b10; //select mem_alu
         end else begin  
            if  (mwreg & (mrn != 0) & (mrn == drt) & mm2reg) begin
               fwdb<=2'b11; //select mem_lw
				end
			end
		end
   end*/
	
endmodule 


