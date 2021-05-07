module out_port_seg(out_port0,HEX0,HEX1);
	input [31:0] out_port0;
	output reg [6:0] HEX0,HEX1;
	wire [3:0] high=out_port0/10;
	wire [3:0] low=out_port0-high*10;
	initial
	begin
		HEX0 = 0;
		HEX1 = 0;
	end
	always @(*)
		begin
		case(low) //1为熄灭，0为亮起。七位数对应七段位为 gfedcba
			0: HEX0[6:0] = 7'b1000000;
			1: HEX0[6:0] = 7'b1111001;
			2: HEX0[6:0] = 7'b0100100;
			3: HEX0[6:0] = 7'b0110000;
			4: HEX0[6:0] = 7'b0011001;
			5: HEX0[6:0] = 7'b0010010;
			6: HEX0[6:0] = 7'b0000010;
			7: HEX0[6:0] = 7'b1111000;
			8: HEX0[6:0] = 7'b0000000;
			9: HEX0[6:0] = 7'b0010000;
			default: HEX0[6:0] = 7'b1111111;
		endcase
		end
		
	always @(*)
		begin
		case(high)
			0: HEX1[6:0] = 7'b1000000;
			1: HEX1[6:0] = 7'b1111001;
			2: HEX1[6:0] = 7'b0100100;
			3: HEX1[6:0] = 7'b0110000;
			4: HEX1[6:0] = 7'b0011001;
			5: HEX1[6:0] = 7'b0010010;
			6: HEX1[6:0] = 7'b0000010;
			7: HEX1[6:0] = 7'b1111000;
			8: HEX1[6:0] = 7'b0000000;
			9: HEX1[6:0] = 7'b0010000;
			default: HEX1[6:0] = 7'b1111111;
		endcase
		end

endmodule 