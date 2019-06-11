///////////////////////////////////////////////////////
//// 		Design of Multiplxer		//////
/////////////////////////////////////////////////////

module muxB ( clk, in1, in2, sel, outB);
input clk;
input [11:0] in1;
input [11:0] in2;
input sel;
output [11:0] outB;

reg [11:0] outB;

always@(posedge clk)
begin
	if ( sel == 1 ) begin
	outB <= in1;
	end
	else if ( sel == 0) begin
	outB <= in2;
	end
end
endmodule
