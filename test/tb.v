`default_nettype none
`timescale 1ns/1ps

module tb;

    //1. Declase signals to connect to the DUT
    // We use 'reg' for signals this testbench drives (inputs to chip)
    // We use 'wire' for signals the chip drives (outputs from chip)
    reg clk;
    reg rst_n;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    wire ena;

    //2. Instantiate the DUT (Device under test)
    // This connects our testbench signals to the chip's ports

    tt_um_first_asic dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // 3. Clock Generation
    // This block runs forever, flipping the clock every 10ns.
    // 10ns high + 10ns low = 20ns period = 50 MHZ.
    initial begin 
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // 4. Test Sequence
    initial begin
        // Setup visual dumping so we can see the waves later
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        // A. Initialize inputs
        rst_n = 0;
        ui_in = 0;
        uio_in = 0;
        ena = 1;

        // B. Wait and Release reset

        #100; // Wait 100 nano seconds
        rst_n = 1; // Release Reset (Chip starts running)

        // C. Run Simulation
        // We run for 2000 ns. This won't be enough to blink the LED
        // (which takes millions of cycles), but enough to see the 
        // counter incremeting in the wave form.

        #2000;
        
        // D. Finish
        $display("Simulation finished");
        $finish;
    end
endmodule




