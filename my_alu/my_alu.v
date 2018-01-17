`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
always@(*)begin
c_result = 'd0 ; //Always set result. No latches
 case(opcode)
 3'd0 : c_result = A + B ;
 3'd1 : c_result = $signed(A) + $signed(B) ;
 3'd2 : c_result = A - B ;
 3'd3 : c_result = $signed(A) - $signed(B) ;
 3'd4 : c_result = A & B ;
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
  end else begin
		   result <= c_result ;
			zero <= ( c_result == {NUMBITS{1'b0}}) ? 1'b1 : 1'b0 ;
		 end
		end
		
endmodule
