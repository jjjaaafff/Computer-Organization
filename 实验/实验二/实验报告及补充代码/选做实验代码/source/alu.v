module alu (a,b,aluc,s,z);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   reg [31:0] s;
	reg [31:0] tmp; 
   reg        z;
   always @ (a or b or aluc) 
      begin                                   // event
         casex (aluc)
				 4'b1011: 
				 begin
					tmp=a^b;                //1011 HAMM
					s=tmp[0]+tmp[1]+tmp[2]+tmp[3]+tmp[4]+tmp[5]+tmp[6]
				 +tmp[7]+tmp[8]+tmp[9]+tmp[10]+tmp[11]+tmp[12]+tmp[13]
				 +tmp[14]+tmp[15]+tmp[16]+tmp[17]+tmp[18]+tmp[19]+tmp[20]
				 +tmp[21]+tmp[22]+tmp[23]+tmp[24]+tmp[25]+tmp[26]+tmp[27]
				 +tmp[28]+tmp[29]+tmp[30]+tmp[31];
				 end 
				 
             4'bx000: s = a + b;              //x000 ADD
             4'bx100: s = a - b;              //x100 SUB
             4'bx001: s = a & b;              //x001 AND
             4'bx101: s = a | b;              //x101 OR
             4'bx010: s = a ^ b;              //x010 XOR
             4'bx110: s = {b[15:0],16'b0};    //x110 LUI: imm << 16bit             
             4'b0011: s = b << a;             //0011 SLL: rd <- (rt << sa)
             4'b0111: s = b >> a;             //0111 SRL: rd <- (rt >> sa) (logical)
             4'b1111: s = $signed(b) >>> a;   //1111 SRA: rd <- (rt >> sa) (arithmetic)
             default: s = 0;
         endcase
         if (s == 0 )  z = 1;
            else z = 0;         
      end      
endmodule 