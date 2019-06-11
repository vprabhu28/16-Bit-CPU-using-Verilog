///////////////////////////////////////////////////////
//// 		Design of Multiplxer		//////
/////////////////////////////////////////////////////

module muxA ( clk, in1, in2, sel, outA);
input clk;
input [31:0] in1;
input [15:0] in2;
input sel;
output [31:0] outA;

reg [31:0] outA;

always@(posedge clk)
begin
	if ( sel == 1 ) begin
	outA <= in1;
	end
	else if ( sel == 0) begin
	outA <= {16'b0000000000000000 , in2};
	end
end
endmodule
