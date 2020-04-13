// define

`define WIDTH 16
`define ZERO  16'd0
`define ZERO_REG  3'd0
`define TRUE  1'b1
`define FALSE 1'b0
`define OP_WIDTH 4
`define OP_NOP 4'h0
`define OP_ADD 4'h1
`define OP_SUB 4'h2
`define OP_AND 4'h3
`define OP_OR  4'h4
`define OP_XOR 4'h5
`define OP_LOADI 4'h6 // J-type
`define OP_LOAD  4'h7
`define OP_STORE 4'h8
`define OP_JMP 4'h9 // J-type
`define OP_BGE 4'hA
`define OP_BL  4'hB
`define REG_SIZE  8
`define REG_WIDTH 3
`define HIZ 16'hzzzz
`define IM_WIDTH 9
`define RD_OFFSET 4
`define RS_OFFSET 7
`define RT_OFFSET 10
`define IM_OFFSET 7
`define CPU_STATE_WIDTH 3
`define CPU_STATE_NUMBER 7
`define CPU_CYCLE 6
`define CPU_STATE_RS 3'h0
`define CPU_STATE_ID 3'h1
`define CPU_STATE_RG 3'h2
`define CPU_STATE_EX 3'h3
`define CPU_STATE_MM 3'h4
`define CPU_STATE_WB 3'h5
`define CPU_STATE_BL 3'h6
`define REG_A 3'd0
`define REG_B 3'd1
`define REG_C 3'd2
`define REG_D 3'd3
`define REG_E 3'd4
`define REG_F 3'd5
`define REG_G 3'd6
`define REG_H 3'd7
`define RAM_WIDTH 9
`define RAM_SIZE  512