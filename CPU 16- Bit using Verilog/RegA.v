////////////////////////////////////////////////////////////////////////////////////////////
//	Program to realise a Register. The operation depends on Clock and load		///
///////////////////////////////////////////////////////////////////////////////////////////

module regA (clk, loadA, dataAin, dataAout);
input clk;
input loadA;
input [15:0] dataAin;
output [15:0] dataAout;

reg [15:0] dataAout;
reg [15:0] tempA;

always@(clk,loadA)
begin
	@(posedge clk) 
	begin
		if ( loadA == 1) begin
		dataAout <= dataAin;
		tempA <= dataAin;
		end

		else if (loadA == 0) begin
		dataAout <= tempA;
		end
	end
end
endmodule

//////////////////////////////////////////////////////////////////////////////
//	Program to test the design of the Register			/////
////////////////////////////////////////////////////////////////////////////
module tb_regA ();
reg clk;
reg loadA;
reg [15:0] dataAin;
wire [15:0] dataAout;

// Instantiation of the Register A

regA r1 (.clk(clk), .loadA(loadA), .dataAin(dataAin), .dataAout(dataAout));

// Initialization
initial
begin
	clk <= 1'b0;
	loadA <= 0;
	dataAin <= 16'h0000;
end

// Clock signal setup

always #5 clk = ~clk;

// Stimilus
initial
begin
	#20 loadA = 1;
	dataAin = 16'h00fe;
	
	#20 loadA = 0;
	dataAin = 16'h0fe6;

	#20 loadA = 1;
end
endmodule
