	module MUX4to1(
		input			src1,
		input			src2,
		input			src3,
		input			src4,
		input   [2-1:0] select,
		output reg		result
		);
		assign out = ( select == 2'b00 ) ? src1 :
					 ( select == 2'b01 ) ? src2 :
					 ( select == 2'b10 ) ? src3 :
										   src4 ;
		always @(*) begin
			result=out;
		end
	endmodule