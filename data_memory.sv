module data_memory (
    input  logic clk,
    input  logic MemRead,   // Control signal to read
    input  logic MemWrite,  // Control signal to write
    input  logic [31:0] address,   // Address to read/write (comes from ALU)
    input  logic [31:0] write_data, // Data to write (comes from rs2)
    output logic [31:0] read_data  // Data read out
);

    // Create an array of 256 memory slots, where each slot holds a 32-bit word
    logic [31:0] memory_array [0:255];

    // Read Logic (Combinational)
    assign read_data = (MemRead) ? memory_array[address[31:2]] : 32'b0;

    // Write Logic goes here...
    always_ff @(posedge clk) begin
        if (MemWrite) begin
            memory_array[address[31:2]] <= write_data;
        end
    end

endmodule