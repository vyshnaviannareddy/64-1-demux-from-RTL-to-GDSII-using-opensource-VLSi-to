module demux (
    input  wire        din,      // 1-bit input data
    input  wire [5:0]  sel,      // 6-bit select signal (0 to 63)
    input  wire        enable,   // Active-high enable (optional, recommended)
    output reg  [63:0] dout      // 64-bit output vector
);

    always @(*) begin
        // Default state: all outputs set to 0
        dout = 64'b0;
        
        if (enable) begin
            // Bitwise shift left: places 'din' at index 'sel'
            dout[sel] = din;
        end
    end

endmodule
