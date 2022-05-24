`timescale 1ns/1ps

module ALU( dataA, dataB, Signal, dataOut, reset );
	input reset ; 
	input [31:0] dataA ;
	input [31:0] dataB ;
	input [5:0] Signal ;
	output [31:0] dataOut ;
	wire [1:0] sel ;
	wire set, cout, binvert ;
	
	
	
	assign binvert = Signal[2];
	assign sel = Signal[1:0];
	



	//   Signal ( 6-bits)?
	//   AND  : 36
	//   OR   : 37
	//   ADD  : 32
	//   SUB  : 34
	//   SLT  : 42

	reg [31:0] temp ;
	wire [30:0] c ;
	
	ALU_1bit alu_00( .dataOut(temp[0]), .cout(c[0]), .inputA(dataA[0]), .inputB(dataB[0]), .cin(binvert), .sel(sel), .binvert(binvert), .less(set) ) ;

	genvar i;
	generate
		for(i=1;i<31;i=i+1) begin: alu32
			
			ALU_1bit alu_01( .dataOut(temp[i]), .cout(c[i]), .inputA(dataA[i]), .inputB(dataB[i]), .cin(c[i-1]), .sel(sel), .binvert(binvert), .less(1'b0) ) ;

		end
	endgenerate

	ALU_1bit alu_32( .dataOut(temp[31]), .cout(cout), .inputA(dataA[31]), .inputB(dataB[31]), .cin(c[30]), .sel(sel), .binvert(binvert), .less(1'b0) );
	assign dataOut=temp;
		


endmodule