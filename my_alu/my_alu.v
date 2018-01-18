`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kenneth Farrell
// 
// Create Date:    14:06:40 01/17/2018 
// Design Name: 
// Module Name:    my_alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module my_alu #( parameter NUMBITS = 32)(
    input wire clk,
    input wire reset,
    input wire[NUMBITS-1:0]A,
    input wire[NUMBITS-1:0]B,
    input wire[2:0]opcode,
    output reg[NUMBITS-1:0]result,
    output reg carryout,
    output reg overflow,
    output reg zero);
    
//Combinational Block
reg [NUMBITS-1:0]c_result ;
reg c_carryover ;
reg c_overflow ;	 
always@(*)begin
c_result = 'd0 ; //Always set result. No latches
c_carryover = 'd0 ;
c_overflow = 'd0 ;
 case(opcode)
 3'd0 : begin
		{c_carryover,c_result} = {1'b0,A} + {1'b0,B} ;
	 end
 3'd1 : begin
	c_result = $signed(A) + $signed(B) ;
	 if((A[NUMBITS - 1] == B[NUMBITS - 1]) && (c_result[NUMBITS - 1] != A[NUMBITS - 1]))
		begin
			c_overflow = 1'b1 ;
		end
	end	
 3'd2 : begin
	  {c_carryover,c_result} = {1'b0,A} - {1'b0,B} ;
	  //c_result = A - B ;
	  //if(A >= B)
		//	begin
		//	c_carryover = 1'b1 ;
		//	end  
         end	
 3'd3 : begin
	  c_result = $signed(A) - $signed(B) ;
	  if(A[NUMBITS - 1] != B[NUMBITS - 1])
			begin
			if((A[NUMBITS - 1] == 1'b1) && (c_result[NUMBITS - 1] == 1'b0))
				begin
				c_overflow = 1'b1 ;
				end
			if((A[NUMBITS - 1] == 1'b0) && (c_result[NUMBITS - 1] == 1'b1))
				begin
				c_overflow = 1'b1 ;
				end	
//kf
			end
		  
		  end
 3'd4 : {c_carryover,c_result} = {1'b0,A} & {1'b0,B} ;
 3'd5 : c_result = A | B ;
 3'd6 : c_result = A ^ B ;
 3'd7 : c_result = A << 1 ;
 endcase
 end
 
 // Sequential Blcok
 always @( posedge clk ) begin 
  if ( reset == 1'b1 ) begin
		result <= 'd0 ;
		zero   <= 'd0 ;
	  	carryout <= c_carryover ;
		overflow <= c_overflow ;
  end else begin
		   result <= c_result ;
			zero <= ( c_result == {NUMBITS{1'b0}}) ? 1'b1 : 1'b0 ;
			carryout <= c_carryover ;
			overflow <= c_overflow ;
		 end//kf
		end
		
endmodule

