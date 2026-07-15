module control (
    input logic [6:0] opcode,
    output logic RegWrite,
    output logic ALUSrc,
    output logic MemRead,
    output logic MemWrite,
    output logic Branch,
    output logic MemReg,
    output logic [1:0] ALUOp
);

    always_comb begin
        RegWrite = 1'b0;
        ALUSrc = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        Branch = 1'b0;
        MemReg = 1'b0;

        case (opcode)
            //R-type
            7'b0110011: begin
                RegWrite = 1'b1;
                //everything else low
            end
            //Load Word
            7'b0000011: begin
                MemRead = 1'b1;
                ALUSrc = 1'b1;
                MemReg = 1'b1;
                RegWrite = 1'b1;
            end
            //Store Word
            7'b0100011: begin
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
            end
          	// I-type (ADDI, etc.)
            7'b0010011: begin
                ALUSrc = 1'b1;
                RegWrite = 1'b1;
                ALUOp = 2'b10; // Tell the ALU control to look at funct3
            end
        endcase
    end
endmodule
