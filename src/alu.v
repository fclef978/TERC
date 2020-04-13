// ALU
`include "define.v"

module alu(l, r, op, clk, res, o, a);
input  [`WIDTH-1:0]     l, r;
input  [`OP_WIDTH-1:0]  op;
input                   clk, res;
output [`WIDTH-1:0]     o;
output [`RAM_WIDTH-1:0] a;
reg    [`WIDTH-1:0]     o;
reg    [`RAM_WIDTH-1:0] a;

always @(posedge clk or negedge res) begin
	if (res == `FALSE) begin
		o <= `ZERO;
		a <= 9'h000;
	end else begin
		case (op)
			`OP_ADD: o <= l + r;
			`OP_SUB: o <= l - r;
			`OP_AND: o <= l & r;
			`OP_OR : o <= l | r;
			`OP_XOR: o <= l ^ r;
			`OP_LOADI: o <= r;
			`OP_LOAD : o <= `HIZ;
			`OP_STORE: o <= r;
			default: o <= `ZERO;
		endcase
		
		case (op)
			`OP_LOAD : a <= l[`RAM_WIDTH-1:0];
			`OP_STORE: a <= l[`RAM_WIDTH-1:0];
			default: a <= 9'h000;
		endcase
	end
end

endmodule
