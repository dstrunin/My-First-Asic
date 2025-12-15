`default_nettype none
`timescale 1ns/1ps

module tb;

    // 1. Declare signals
    // FIX: 'ena' MUST be 'reg' to be assigned in initial block
    reg clk;
    reg rst_n;
    reg [7:0] ui_in;
    reg [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg ena;  // <--- This is the critical fix

    // 2. Instantiate the DUT
    // Must match your source file name: tt_um_first_asic
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
    initial begin 
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // 4. Test Sequence
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        // Initialize inputs
        rst_n = 0;
        ui_in = 0;
        uio_in = 0;
        ena = 1;

        // Wait and Release reset
        #100;
        rst_n = 1; 

        // Run Simulation
        #2000;
        
        $display("Simulation finished");
        $finish;
    end
endmodule