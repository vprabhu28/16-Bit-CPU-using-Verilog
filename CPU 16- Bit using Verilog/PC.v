///////////////////////////////////////////////////////////////
/////	Module to realize a Program Counter. 		//////
/////////////////////////////////////////////////////////////
module PC(clk, loadPC, incPC, address, execadd);
input clk;
input loadPC;
input incPC;
input [11:0] address;
output [11:0] execadd;

reg [11:0] execadd;

reg [11:0] temp;

always@( posedge clk)
begin
	if ( loadPC == 0 && incPC == 0 ) begin
	temp <= 12'h000;
	end
	else if (loadPC == 1 && incPC == 0 ) begin
	temp <= address;
	end
	else if (loadPC == 0 && incPC == 1 ) begin
	temp <= temp + 12'h001;
	end
	else begin
	temp <= temp;
	end
	execadd <= temp;
end
endmodule

///////////////////////////////////////////////////////////////
////	Testbench for the Design of PC			//////
/////////////////////////////////////////////////////////////
module tb_PC ();
reg clk;
reg loadPC;
reg incPC;
reg [11:0] address;
wire [11:0] execadd;

// Instantiation of the design
PC p1 (.clk(clk), .loadPC(loadPC), .incPC(incPC), .address(address), .execadd(execadd));

// Initialization of inputs
initial
begin
	clk = 1'b0;
	loadPC = 1'b0;
	incPC = 1'b0;
	address = 12'h000;
end

//  Clock instantiation
always #5 clk = ~ clk;

// Adress randomization
always #30 address = address + 12'h001;

// Stimulus
initial 
begin
	// Execaddress will be same as initial address during this time
	#10 loadPC <= 1'b0;
	incPC <= 1'b0;

	// Now let the address increment and then load the address into the PC
	#30 loadPC = 1'b1;
	incPC = 1'b0;

	// Increment the address to get the next address
	#10 loadPC = 1'b0;
	incPC = 1'b1;
end
endmodule
