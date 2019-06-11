// Sample code for D flip flop in Verilog
// Verilog starts with the module name followed by the parameter list
module dff( d,clk,q,q_b);
input d,clk;		// Define the input
output q,q_b;		// Define the output
wire d,clk;		// To use as input, the signals must be declared as wire
reg q,q_b;		// To use as output, the signals must be declared as resgister

// Wire is used for signals that just connect two points
// Registers are sued to define signals that need to store and output the signals

always@(posedge clk)	// During the positive edge of clock
begin
	q<=d;		// Assigns q to D
	q_b<= !d;	// Assigns q_b to not of D
end
endmodule

// We can write the testbench in the same file or different file

module tb_dff();	// Test bench does not take in any parameters
reg dtb,clktb;		// The input signals are now declared as registers as they store and display value
wire qtb,q_btb;		// Output signals just display the values, hence use then as wires

// Instantiantiation of the DFF module to the testbench using the formal parameters
dff d1 (.d(dtb), .clk(clktb), .q(qtb), .q_b(q_btb));

// Initialise the clock and input to 0 before starting to make sure no garbage vlaue
initial
begin
	clktb = 0;
	dtb=0;
end

// Make sure the clock changes logic value every 10ns
always #10 clktb = ~clktb;

// Different input to DFF
initial 
begin 
#20 dtb = 1'b1; 
#20 dtb = 1'b0;
end
endmodule
