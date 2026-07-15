typedef enum logic [3:0] {
    ALU_ADD  = 4'b0000,
    ALU_SUB  = 4'b1000,
    ALU_SLL  = 4'b0001, // Shift Left Logical
    ALU_SLT  = 4'b0010, // Set Less Than (Signed)
    ALU_SLTU = 4'b0011, // Set Less Than (Unsigned)
    ALU_XOR  = 4'b0100,
    ALU_SRL  = 4'b0101, // Shift Right Logical
    ALU_SRA  = 4'b1101, // Shift Right Arithmetic
    ALU_OR   = 4'b0110,
    ALU_AND  = 4'b0111
 } alu_op_e;