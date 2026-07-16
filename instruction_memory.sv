module instruction_memory (
    input logic [31:0] address,
    output logic [31:0] instruction
);

    logic [31:0] memory_array [0:255];

    initial begin
        $readmemh("program.hex", memory_array);
    end

    assign instruction = memory_array[address[31:2]];
endmodule