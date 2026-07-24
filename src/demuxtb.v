

module demuxtb;

    // Testbench signals
    reg        din;
    reg  [5:0] sel;
    reg        enable;
    wire [63:0] dout;

    integer i;

    // Instantiate Design Under Test
    demux uut (
        .din(din),
        .sel(sel),
        .enable(enable),
        .dout(dout)
    );

    initial begin
        // --- VCD Dump Commands ---
        $dumpfile("demux.vcd"); // Name of the output VCD file
        $dumpvars(0, demuxtb);   // Dump all signals in the testbench hierarchy

        // Monitor outputs in terminal console
        $monitor("Time = %0t | enable = %b | din = %b | sel = %0d | dout = %h", 
                 $time, enable, din, sel, dout);

        // Signal initialization
        din    = 1'b0;
        sel    = 6'b0;
        enable = 1'b0;
        #10;

        // Test disabled state
        din    = 1'b1;
        sel    = 6'd15;
        enable = 1'b0;
        #10;

        // Sweep all 64 select lines
        enable = 1'b1;
        din    = 1'b1;

        for (i = 0; i < 64; i = i + 1) begin
            sel = i[5:0];
            #10;
        end

        // End simulation and close dump file
        $display("\n--- Dump File Generated Successfully ---");
        $finish;
    end

endmodule
