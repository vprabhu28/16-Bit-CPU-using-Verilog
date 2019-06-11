//////////////////////////////////////////////////////////////////////////////
////	This module describes a Logic unit of ALU.			/////
///	This will have two inputs of 16 bits each.			/////
///	It has to provide either logic operation 			////
////////////////////////////////////////////////////////////////////////////
module logic(a,b,opcode,outlu,za,zb,eq,gt,lt);
input [15:0] a;
input [15:0] b;
input [2:0] opcode;
output [31:0] outlu;
output za, zb,eq,gt,lt;

reg [31:0] outlu;
reg za,zb,eq,gt,lt;

always@(a,b,opcode)
begin
	case(opcode)
	3'b000: outlu = {16'h0000, (a & b)};
	3'b001: outlu = {16'h0000, (a | b)};
	3'b010: outlu = {16'h0000, (~(a | b))};
	3'b100: outlu = {16'h0000, (~ a)};
	3'b101: outlu = {16'h0000, (~ b)};
	3'b110: outlu = {16'h0000, (a ^ b)};
	3'b111: outlu = {16'h0000, (~(a ^ b))};
	default outlu = 32'h00000000;
	endcase
end

always@(a,b)
begin
	if( a == b) begin
	eq = 1;
	end
	else begin
	eq = 0;
	end

	if ( a > b) begin
	gt = 1;
	end
	else begin
	gt = 0;
	end

	if ( a < b) begin
	lt = 1;
	end
	else begin
	lt = 0;
	end
	
	if( a == 16'h0000) begin
	za = 1;
	end
	else begin
	za = 0;
	end
	
	if (b == 16'h0000) begin
	zb = 1;
	end
	else begin
	zb = 0;
	end
end
endmodule

////////////////////////////////////////////////////////////////
//	Test bench for the logic unit			///////
///////////////////////////////////////////////////////////////

module tb_logic();
reg [15:0] a;
reg [15:0] b;
reg [2:0] opcode;
wire [31:0] outlu;
wire za, zb,eq,gt,lt;

// Instantiation of the module

logic l1 (.a(a), .b(b), .opcode(opcode), .outlu(outlu), .za(za), .zb(zb), .eq(eq), .gt(gt), .lt(lt));

// Initialization

initial
begin
	a = 16'h0000;
	b = 16'h0000;
	opcode = 3'b000;
end

// Stimulus must be writte in such a way that we test all the cases for input conditions.
initial
begin
	// When A>B test all the conditions
	#10 a = 16'h0009;
	b <= 16'h0005;
	# 5 opcode = 3'b001;
	# 5 opcode = 3'b010;
	# 5 opcode = 3'b011;
	# 5 opcode = 3'b100;
	# 5 opcode = 3'b101;
	# 5 opcode = 3'b110;
	# 5 opcode = 3'b111;

	// When A<B test all the cases
	#10 a = 16'h0003;
	b = 16'h000F;
	# 5 opcode = 3'b001;
	# 5 opcode = 3'b010;
	# 5 opcode = 3'b011;
	# 5 opcode = 3'b100;
	# 5 opcode = 3'b101;
	# 5 opcode = 3'b110;
	# 5 opcode = 3'b111;
	
	// When A=B test all the conditions
	#10 a = 16'h00E9;
	b = 16'h00E9;
	# 5 opcode = 3'b001;
	# 5 opcode = 3'b010;
	# 5 opcode = 3'b011;
	# 5 opcode = 3'b100;
	# 5 opcode = 3'b101;
	# 5 opcode = 3'b110;
	# 5 opcode = 3'b111;

	// Test ZA
	#10 a <= 16'h0000;

	// Test ZB
	#10 b <= 16'h0000;
end
endmodule
