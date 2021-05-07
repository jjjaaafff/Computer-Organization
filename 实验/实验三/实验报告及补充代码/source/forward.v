module forward(ewreg, mwreg, ern, mrn, mm2reg, em2reg, drs, fwda);
	input ewreg, mwreg, mm2reg, em2reg;
	input [4:0] ern, mrn, drs;
	output [1:0] fwda;
	reg [1:0] fwda;
	
	always @(*)
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



endmodule 