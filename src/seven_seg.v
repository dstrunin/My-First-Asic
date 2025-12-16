`default_nettype none

module seven_seg (
    input  wire [3:0] bin_in, // 4-bit binary input to display 0-15
    output reg  [6:0] seg_out // The 7-bit pattern for the LEDs
);

    // Combinational logic: The Case Statement
    // essentially a lookup table
    always @(*) begin
        case (bin_in)
        // gfedcba
            4'h0: seg_out = 7'b0111111; // 0: All on except g
            4'h1: seg_out = 7'b0000110; // 1: Only b and c on
            4'h2: seg_out = 7'b1011011;
            4'h3: seg_out = 7'b1001111;
            4'h4: seg_out = 7'b1100110;
            4'h5: seg_out = 7'b1101101;
            4'h6: seg_out = 7'b1111101;
            4'h7: seg_out = 7'b0000111;
            4'h8: seg_out = 7'b1111111;
            4'h9: seg_out = 7'b1100111;  
            
            default: seg_out = 7'b0000000; // Blank for invalid inputs
        endcase    
    end
endmodule
