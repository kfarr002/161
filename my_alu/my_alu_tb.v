`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:39:03 01/17/2018
// Design Name:   my_alu
// Module Name:   /home/csmajs/kfarr002/my_alu/my_alu_tb.v
// Project Name:  my_alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: my_alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module my_alu_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] opcode;

	// Outputs
	wire [31:0] result;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	my_alu uut (
		.clk(clk), 
		.reset(reset), 
		.A(A), 
		.B(B), 
		.opcode(opcode), 
		.result(result), 
		.zero(zero)
	);
	initial begin
	 clk = 0 ; rst = 1 ; #10 ; clk = 1 ; rst = 1 ; #10 ;
	 clk = 0 ; rst = 1 ; #10 ; clk = 1 ; rst = 1 ; #10 ;
	 forever begin clk = -clk; #10 ; end
	end
	
	initial begin
		A = 'd0; B = 'd0; opcode = 0;
		#40; //reset
		A = 'd1; B = 'd1; opcode = 0; #20;
		A = 'd1; B = 'd0; opcode = 0; #20;
		A = 'd2; B = 'd2; opcode = 0; #20;
		A = 'd3; B = 'd3; opcode = 0; #20;
		
		A = 'd8; B = 'd0; opcode = 1; #20;
		A = 'd7; B = 'd1; opcode = 1; #20;
		A = 'd6; B = 'd2; opcode = 1; #20;
		A = 'd5; B = 'd4; opcode = 1; #20;

	end
      
endmodule

