`timescale 1ns / 1ps
module tb_up_down_counter;

    reg clk;
    reg reset;
    reg load;
    reg up;
    reg down;
    reg [3:0] data_in;
    wire [3:0] count;

    // Unit Under Test (UUT) for instantiation of module up_down_counter
    up_down_counter uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .up(up),
        .down(down),
        .data_in(data_in),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Dump file for generating waveform (gtkwave)
        $dumpfile("up_down_counter_waveform.vcd"); // VCD file
        $dumpvars(0, tb_up_down_counter); // Dumps all variables in this module
        
        // Initialize inputs
        clk = 0;
        reset = 0;
        load = 0;
        up = 0;
        down = 0;
        data_in = 4'b0000;

        // Applying reset
        reset = 1;
        #10;
        reset = 0;

        // Testing Load functionality
        data_in = 4'b0010;
        load = 1;
        #10;
        load = 0;

        // Testing Up counting
        up = 1;
        #20;
        up = 0;

        // Testing Down counting
        down = 1;
        #20;
        down = 0;
	    #10;

	    // Testing priority of reset, Load, Up and Down
	    reset = 1;
	    data_in = 4'b0110;
	    load = 1;
	    up = 1;
	    down = 1;
	    #20;
	
	    reset=0;
	    #20

	    load=0;
	    #160

	    up=0;
	    #40

	    down=0;
	    #20 

        // Finish simulation
        #10;
        $finish;
    end
endmodule

//Conditions tested

//reset : 1 0 0 0 0 1 0 0 0 0
//load  : 0 1 0 0 0 1 1 0 0 0
//up    : 0 0 1 0 0 1 1 1 0 0
//down  : 0 0 0 1 0 1 1 1 1 0

//data_in input is changed as well in-between to test the load functionality