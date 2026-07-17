module testbench ();

    logic clk;
    logic rst;

    cpu test (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;
  
    initial begin
        // Waveform dump
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench); 

        // Power sequence
        clk = 0;
        rst = 1;

        #10; // wait ten time units
        
        rst = 0; // release reset, run cpu

        #200; // let run for 200 time units
        $finish;
    end
    
endmodule