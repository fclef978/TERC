// instruction decoder
`include "define.v"

module decoder(inst, clk, res, op, lSel, rSel, oSel, LOUT, ROUT, OIN, CS, RW, r);
input  [`WIDTH-1:0]     inst;
input							clk, res;
output [`OP_WIDTH-1:0]  op;
output [`REG_WIDTH-1:0] lSel, rSel, oSel;
output                 	LOUT, ROUT, OIN, CS, RW;
output [`WIDTH-1:0]     r;

reg [`OP_WIDTH-1:0]  op;
reg [`REG_WIDTH-1:0] lSel, rSel, oSel;
reg              	   LOUT, ROUT, OIN, CS, RW;
reg [`WIDTH-1:0]     r;

wire [`OP_WIDTH-1:0]  code;
wire [`REG_WIDTH-1:0] rd, rs, rt;
wire [`IM_WIDTH-1:0]  im;


assign code = inst[`WIDTH-1:`WIDTH-`OP_WIDTH];
assign rd = inst[`WIDTH-`RD_OFFSET-1:`WIDTH-`RD_OFFSET-`REG_WIDTH];
assign rs = inst[`WIDTH-`RS_OFFSET-1:`WIDTH-`RS_OFFSET-`REG_WIDTH];
assign rt = inst[`WIDTH-`RT_OFFSET-1:`WIDTH-`RT_OFFSET-`REG_WIDTH];
assign im = inst[`WIDTH-`IM_OFFSET-1:`WIDTH-`IM_OFFSET-`IM_WIDTH];

always @(posedge clk or negedge res) begin
	if (res == `FALSE) begin
		op <= 4'h0;
		LOUT <= `FALSE; ROUT <= `FALSE; OIN <= `FALSE;
		lSel <= 3'b000; rSel <= 3'b000; oSel <= 3'b000;
		RW <= `FALSE; CS <= `FALSE;
		r <= `HIZ;
	end else begin
		op <= code;
		if (code == `OP_NOP) begin
			LOUT <= `FALSE; ROUT <= `FALSE; OIN <= `FALSE;
			lSel <= 3'b000; rSel <= 3'b000; oSel <= 3'b000;
			RW <= `FALSE; CS <= `FALSE;
		end else if (isArith(code) == `TRUE) begin
			LOUT <= `TRUE;	ROUT <= `TRUE;	OIN <= `TRUE;
			lSel <= rs; 	rSel <= rt; 	oSel <= rd;
			RW <= `FALSE; CS <= `FALSE;
		end else if (code == `OP_LOADI) begin
			LOUT <= `FALSE; ROUT <= `FALSE; OIN <= `TRUE;
			lSel <= 3'b000; rSel <= 3'b000; oSel <= rd;
			RW <= `FALSE; CS <= `FALSE;
		end else if (code == `OP_STORE) begin
			LOUT <= `TRUE;	ROUT <= `TRUE;	OIN <= `FALSE;
			lSel <= rd; 	rSel <= rs; 	oSel <= rd;
			RW <= `FALSE; CS <= `TRUE;
		end else if (code == `OP_LOAD) begin
			LOUT <= `TRUE;	ROUT <= `FALSE;	OIN <= `TRUE;
			lSel <= rs; 	rSel <= rt; 	oSel <= rd;
			RW <= `TRUE; CS <= `TRUE;
		end else begin
			LOUT <= `FALSE; ROUT <= `FALSE; OIN <= `FALSE;
			lSel <= 3'b000; rSel <= 3'b000; oSel <= 3'b000;
			RW <= `FALSE; CS <= `FALSE;
		end
		
		if (code != `OP_LOADI) r <= `HIZ;
		else r <= {{7{im[`IM_WIDTH-1]}}, im};
	end
end

function isArith;
input [`OP_WIDTH-1:0] op;
	case (op)
		`OP_ADD:   isArith = `TRUE;
		`OP_SUB:   isArith = `TRUE;
		`OP_AND:   isArith = `TRUE;
		`OP_OR :   isArith = `TRUE;
		`OP_XOR:   isArith = `TRUE;
		default:  isArith = `FALSE;
	endcase
endfunction

endmodule
