module alu_control (
    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic funct7_b5, // A specific bit from funct7
    output alu_op_e alu_ctrl
);

    always_comb begin
        case (ALUOp)
            2'b00: alu_ctrl = ALU_ADD; // Load/Store -> Force Add
            2'b01: alu_ctrl = ALU_SUB; // Branch -> Force Subtract
            2'b10: begin
                // R-type
                case (funct3)
                    3'b111: alu_ctrl = ALU_AND; // AND
                    3'b110: alu_ctrl = ALU_OR;  // OR
                    3'b000: begin
                        if (funct7_b5) begin
                            alu_ctrl = ALU_SUB; //SUB
                        end else begin
                            alu_ctrl = ALU_ADD; //ADD
                        end
                    end
                    default: alu_ctrl = ALU_ADD;
                endcase
            end
            default: alu_ctrl = ALU_ADD;
        endcase
    end
endmodule

