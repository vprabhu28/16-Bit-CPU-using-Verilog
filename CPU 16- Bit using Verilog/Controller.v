////////////////////////////////////////////////////////////////////////////////
////////	Verilog Program for the controller of the CPU		///////
//////////////////////////////////////////////////////////////////////////////
module controller ( clk, en, opcode, loadA, loadB, loadC, loadIR, loadPC, incPC, mode, we_DM, selA, selB);
input clk;
input en;
input [3:0] opcode;
output loadA;
output loadB;
output loadC;
output loadIR;
output loadPC;
output incPC;
output mode;
output we_DM;
output selA;
output selB;

reg loadA;
reg loadB;
reg loadC;
reg loadIR;
reg mode;
reg we_DM;
reg selA;
reg selB;
reg loadPC;
reg incPC;

// Registers to hold the value of state and next state

reg [2:0] state;
reg [2:0] next_state;

parameter reset = 3'b000, load = 3'b010, execute = 3'b100;


//Code for operation of the CPU
always@(posedge clk)
begin
	
	if ( en == 0 ) begin
	state = reset;
	end
	else if (en == 1) begin
	state = next_state;
	end
end


// Now for the Output logic. Output logic depends on OPCODE and Enable signal
always@(*)
begin
	if ( en == 0 ) begin
	loadA = 0;
	loadB = 0;
	loadC = 0;
	loadIR = 0;
	loadPC = 0;
	incPC = 0;
	mode = 1'bZ;
	we_DM = 0;
	selA = 1'b0;
	selB = 1'b0;
	next_state = reset;
	end

	else begin
		
		case(state)
		// We just wait for a small duration of time in the same state to see if there is any change in input
		reset: 	begin
			loadA = 0;
			loadB = 0;
			loadC = 0;
			loadIR = 0;
			loadPC = 0;
			incPC = 0;
			mode = 1'bZ;
			we_DM = 0;
			selA = 1'b0;
			selB = 1'b0;
			next_state = load;
			end

		load:	begin
			loadA = 0;
			loadB = 0;
			loadC = 0;
			loadIR = 1;
			loadPC = 1;
			incPC = 0;
			mode = 1'bZ;
			we_DM = 0;
			selA = 1'b0;
			selB = 1'b0;
			next_state = execute;
			end

		execute:begin
			case(opcode)
			// Mode 0, ALU operation for opcode 000
			0000: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b0;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 0, ALU operation for opcode 001
			0001: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b0;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 0, ALU operation for opcode 010
			0010: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b0;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 0, ALU operation for opcode 011
			0011: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b0;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Load A operation
			0100: 	begin
				loadA = 1;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'bZ;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Load B operation
			0101: 	begin
				loadA = 0;
				loadB = 1;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'bZ;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Load C operation
			0110: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 1;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b0;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// JMP translation
			0111: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 1;
				incPC = 1;
				mode = 1'b0;
				we_DM = 1;
				selA = 1'b1;
				selB = 1'b1;
				end
			// Mode 1, ALU operation for opcode 000
			1000: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 001
			1001: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 010
			1010: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 011
			1011: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 100
			1100: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 101
			1101: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 110
			1110: 	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				#5 we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			// Mode 1, ALU operation for opcode 111
			1111:	begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 0;
				loadPC = 0;
				incPC = 1;
				mode = 1'b1;
				we_DM = 1;
				selA = 1'b0;
				selB = 1'b0;
				end
			default: begin
				loadA = 0;
				loadB = 0;
				loadC = 0;
				loadIR = 1;
				mode = 1'bZ;
				we_DM = 0;
				selA = 1'b0;
				selB = 1'b0;
				end
			endcase
			next_state = load;
			end
			
		default: begin
			loadA = 0;
			loadB = 0;
			loadC = 0;
			loadIR = 1;
			mode = 1'bZ;
			we_DM = 0;
			selA = 1'b0;
			selB = 1'b0;
			next_state = reset;
			end
		endcase
	end
end
endmodule

///////////////////////////////////////////////////////////////
///////// Testbench for controller ///////////////////////////
//////////////////////////////////////////////////////////////
module tb_controller ();
reg clk;
reg en;
reg [3:0] opcode;
wire loadA;
wire loadB;
wire loadC;
wire loadIR;
wire loadPC;
wire incPC;
wire mode;
wire we_DM;
wire selA;
wire selB;

// Design instantiation
controller c1 (.clk(clk), .en(en), .opcode(opcode), .loadA(loadA), .loadB(loadB), .loadC(loadC), .loadIR(loadIR), .loadPC(loadPC), .incPC(incPC), .mode(mode), .we_DM(we_DM), .selA(selA), .selB(selB));

// initialization
initial
begin
	clk = 0;
	en = 0;
	opcode = 4'b0000;
end
// Clock setup
always #5 clk = ~clk;

// Stimulus
initial
begin
	#10 en = 1;
	opcode = 4'b0001;
	
	#20 opcode = 4'b0001;

	#20 opcode = 4'b0010;
end
endmodule 