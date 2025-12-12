/*
 * tt_um_first_asic.v
 * Top level module for your blinking LED demo.
 */

// BEST PRACTICE 1: 'default_nettype none'
// This forces us to declare every signal. It prevents accidental bugs
// where a typo creates a new, unconnected wire automatically.
`default_nettype none

module tt_um_first_asic (
  input wire [7:0] ui_in,   //Dedicated Inputs
  output wire [7:0] uo_out, // Dedicated Output
  input wire [7:0] uio_in, //IOs: Input Path
  output wire [7:0] uio_out, //IOs: Output Path
  output wire [7:0] uio_oe, // IOs: Enable path (active high: 0=input, 1=output)
  input wire ena , //always 1 when the design is powered, so you can ignore it
  input wire clk, // clock
  input wire rst_n // reset_n - low to reset
);

//1. SAFETY: Tie off unused inputs to 0
// In Silicon, never leave output wires "foating" (undefined)
  assign uio_out = 8'b0;
  assign uio_oe = 8'b0; // Set all bidirectional pins to inputs (safe state)

//2. Logic: The Counter
// The chip clock runs at ~50mhz (50 million times a second)
// To see a blink, we need to slow this down
// A 25-bit counter will overflow rountly once per second
  reg [24:0] counter;

//Best Practice 2: Synchronous Logic
// We use 'always @(posedge clk) for sequential logic
// We use 'negedge rst_n" for asynchronous support

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 25'd0; // Reset state: clear counter
    end else begin 
      counter <= counter + 1; // Active state: increment
    end
  end

//3. Output: Map the blink to the pin
// We take the most significant bit (MSB) of the counter.
// It changes the slowest

  assign uo_out[0] = counter[24];

  //Tie the remaining 7 output pins to 0
  assign uo_out[7:1] = 7'b0;

endmodule
