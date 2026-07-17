module cpu (
    input logic clk,
    input logic rst
);
    logic [31:0] instruction;
    logic [31:0] pc_current;
    logic [31:0] pc_next;
    logic [31:0] alu_b;
    logic [31:0] alu_result;
    logic [31:0] imm_out;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] branch_target;
    logic [31:0] mem_read_data;
    logic [31:0] reg_write_data;
    
    logic [3:0] alu_control;

    logic [1:0] ALUOp;
    
    logic zero_flag;
    logic RegWrite;
    logic ALUSrc;
    logic MemRead;
    logic MemWrite;
    logic Branch;
    logic MemReg;
    logic PCSrc;

    assign reg_write_data = MemReg ? mem_read_data : alu_result;
    assign alu_b = ALUSrc ? imm_out : rs2_data;
    assign PCSrc = Branch & zero_flag;
    assign pc_next = PCSrc ? branch_target : (pc_current + 32'd4);
    assign branch_target = pc_current + imm_out;
    
    progcount pc_inst (
        .clk(clk),
        .rst(rst),
        .pc(pc_current),
        .next_pc(pc_next)
    );

    instruction_memory imem_inst (
        .address(pc_current),
        .instruction(instruction)
    );

    control ctrl_inst (
        .opcode(instruction[6:0]),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .MemReg(MemReg),
        .ALUOp(ALUOp)
    );

    regfile reg_inst (
        .clk(clk),
        .we(RegWrite),
        .rs1_addr(instruction[19:15]),
        .rs2_addr(instruction[24:20]),
        .rd_addr(instruction[11:7]),
        .rd_data(reg_write_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    imm_gen gen_inst (
        .instruction(instruction),
        .imm_out(imm_out)
    );

    alu alu_inst (
        .a(rs1_data),
        .b(alu_b),
        .control(alu_control),
        .result(alu_result),
        .zero(zero_flag)
    );

    alu_control actrl_inst (
        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7_b5(instruction[30]),
        .alu_ctrl(alu_control)
    );

    data_memory dmem_inst (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(alu_result),
        .write_data(rs2_data),
        .read_data(mem_read_data)
    );

endmodule