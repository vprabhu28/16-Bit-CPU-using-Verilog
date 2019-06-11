///////////////////////////////////////////////////////////////
//	This program is for a 4-bit 			------
//	Requirements:					------
//	4-bit synchronous up counter.			------
//	Active high, synchronous reset.			------
//	Active high enable.				------
///////////////////////////////////////////////////////////////

module counter4b( clk,rst,en,out);
input clk,rst,en;
output [3:0] out;
wire clk, rst,en;
reg [3:0] out;

always@(posedge clk)
begin
	if(rst == 1'b1)
	begin
		out <= 4'b0000;
	end
	else if (en == 1'b1)
	begin
		out <= out + 4'b0001;
	end
end
endmodule
////////////// Test bench to for the counter	///////////////

module tb_counter4b();
reg clk,rst,en;
wire [3:0] outtb;

// Initialise the input signals
initial
begin
	clk<=1'b0;
	rst<=1'b0;
	en<=1'b0;
end

// Instantiation of the Counter4b module

counter4b c1(.clk(clk), .rst(rst), .en(en), .out(outtb));

// Clock signal every 10ns

always #10 clk = ~clk;

// Stimulus for checking the working of counter

initial
begin
	#5 rst <= 1;
	#10 en <= 1;
	
	#10 rst <= 0;
	#10 en <= 1;

	#100 en <= 0;

	#10 rst <= 1;
end
endmodule
	


