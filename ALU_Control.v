`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALUControl( clk, Signal, SignaltoALU, SignaltoSHT, SignaltoDIV, SignaltoMUX );
input clk ;
input [5:0] Signal ;
output [5:0] SignaltoALU ;
output [5:0] SignaltoSHT ;
output [5:0] SignaltoDIV ;
output [5:0] SignaltoMUX ;

reg [5:0] temp ;
reg [6:0] counter ;

always@( Signal )
begin
  if ( Signal == DIVU )
  begin
    counter = 0 ;
  end
/*
如果訊號改變成除法 就把counter歸0
*/
end
	
always @(Signal)
begin
	case (Signal) 
		6'd32 : outputOp = 3'b010; // add
		6'd34 : outputOp = 3'b110; // sub
		6'd36 : outputOp = 3'b000; // and
		6'd37 : outputOp = 3'b001; // or
		6'd42 : outputOp =  3'b111; // slt
		6'd0 : outputOp = 3'b011; // sll
		// 6'd27 : outputOp = 3'b011; // div
		default outputOp = 3'bxxx;
	endcase
end
	
	
always@( posedge clk )
begin
  temp = Signal ;
  if ( Signal == 6'd27 )
  begin
	counter = counter + 1 ;
	if ( counter == 32 )
	begin
	  temp = 6'b111111 ; // Open HiLo reg for Div
	  counter = 0 ;
	end
  end
/*
數32個clk然後開啟HiLo暫存器給除法器放值進去
*/
end


assign SignaltoALU = temp ;
assign SignaltoSHT = temp ;
assign SignaltoDIV = temp ;
assign SignaltoMUX = temp ;

endmodule