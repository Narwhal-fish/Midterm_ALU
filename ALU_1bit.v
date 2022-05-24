`timescale 1ns/1ps
module FA( a, b, c, cout, sum );
	input a, b, c;
	output sum,cout; 
 
    wire s,c1,c2;
	xor (s, a,b);
	and (c1, a,b);
	xor (sum, s, c);
	and (c2, s, c);
	xor (cout, c2, c1);
	
endmodule

module ALU_1bit( dataOut, cout, inputA, inputB, cin, sel, binvert, less );
  input inputA, inputB, sel;
  input cin, binvert, less ;
  input[1:0] sel ;
  output dataOut ;
  output cout ;
  wire   e1, e2, e3, e4, temp ;

  and ( e1, inputA, inputB ) ;
  or ( e2, inputA, inputB ) ;

  xor ( temp, inputB, binvert ) ;
  FA full_adder( .a(dataA), .b(temp), .c(cin), .cout(cout), .sum(e3) ) ;
  
  assign e4 = less ;

  MUX_ALU_1bit U_MUX_ALU_1bit( .dataOut(dataOut), .e1(e1), .e2(e2), .e3(e3), .e4(e4), .sel(sel) ) ;
						
endmodule