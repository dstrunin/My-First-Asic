`default_nettype none

module tt_um_first_asic (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // 1. Safety Assignments
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // 2. The Counter
    reg [24:0] counter;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 25'd0;
        end else begin
            counter <= counter + 1;
        end
    end

    // 3. Instantiate the Decoder
    // We pass the TOP 4 bits of the counter (slowest changing) to the input.
    // We map the output straight to the chip pins.
    seven_seg my_decoder (
        .bin_in(counter[24:21]), 
        .seg_out(uo_out[6:0])
    );

    // 4. The Decimal Point
    // We use the 7th pin as a "heartbeat" blinker, moving slightly faster
    assign uo_out[7] = counter[20];

endmodule