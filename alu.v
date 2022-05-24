`timescale 1ns/1ps

module alu(ctl, a, b, result, shamt)(
  input  [2:0]  ctl ; 
  input  [4:0]  shamt;
  input  [31:0] a, b ;
  output [31:0] result ;
);

	wire [31:0] c_out;
	wire [31:0] c_in;
	reg  [31:0] tmp;
	wire [1:0] sel ;
	wire set, cout, binvert ;
	assign sel = ctl[1:0];
	assign binvert = ctl[2];

	
	ALU_1bit alu_00( .dataOut(temp[0]), .cout(c[0]), .inputA(a[0]), .inputB(b[0]), .cin(binvert), .sel(sel), .binvert(binvert), .less(set) ) ;

	genvar i;
	generate
		for(i=1;i<32;i=i+1) begin: alu32
			assign c_in[i]=c_out[i-1];
			
			ALU_1bit alu_01( .dataOut(temp[i]), .cout(c[i]), .inputA(a[i]), .inputB(b[i]), .cin(i-1), .sel(sel), .binvert(binvert), .less(1'b0) ) ;

		end
	endgenerate

	wire wOf;
	assign wOf=c_in[31]^c_out[31];

	integer j;
	for(j=0;j<32;j++) begin
		result[j]=tmp[j];
	end
	if({ALU_control[1],ALU_control[0]}==2'b10) begin
		cout=c_out[31];		
	end else begin
		cout=0;
	end
		


endmodule