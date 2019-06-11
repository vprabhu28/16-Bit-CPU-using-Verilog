//////////////////////////////////////////////////////////////////////
//	Program to realise Datamemory in the CPU		/////
////////////////////////////////////////////////////////////////////

module datamem(clk, we_DM, dataDM, addDM, outDM);
input clk;
input we_DM;
input [31:0] dataDM;
input [11:0] addDM;
output [31:0] outDM;

reg [31:0] outDM;

// Memory is an array stored at particular address

reg [31:0] mem [0 : 31];

always@(posedge clk)
begin
	if (we_DM == 1) begin
	mem[addDM] = dataDM;
	end
	
	else if (we_DM == 0) begin
	outDM = mem[addDM];
	end
end
endmodule

////////////////////////////////////////////////////////////////////////
//	Test bench for the data memory design used		///////
//////////////////////////////////////////////////////////////////////
module tb_datamem();
reg clk;
reg we_DM;
reg [31:0] dataDM;
reg [11:0] addDM;
wire [31:0] outDM;

// Instantiation of the design
datamem d1 (.clk(clk), .we_DM(we_DM), .dataDM(dataDM), .addDM(addDM), .outDM(outDM));

// Initialization of signals
initial
begin
	clk <= 0;
	we_DM <= 0;
	dataDM <= 32'h00000000;
	addDM <= 12'h000;
end

// Clock setup
always #5 clk = ~clk;

// Address setup 
always #60 addDM = addDM + 12'h001;

// Stimulus
initial 
begin
	#5 we_DM <= 1;
	#5 dataDM <= 32'h1dfe;
	#30 we_DM <= 0;

	#30 we_DM <= 1;
	#5 dataDM <= 32'h1001;
	#30 we_DM <= 0;
end
endmodule
