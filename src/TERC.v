// cpu test 1
`include "define.v"

module terc(inst, clk, res);
input  [`WIDTH-1:0]	inst;
input						clk, res;

reg [`CPU_STATE_WIDTH-1:0] state;

wire [`WIDTH-1:0] l, r, o;
wire [`OP_WIDTH-1:0] op;
wire [`REG_WIDTH-1:0] lSel, rSel, oSel;
wire [`RAM_WIDTH-1:0] a;
wire OINdec, OINreg;
wire LOUTdec, LOUTreg;
wire ROUTdec, ROUTreg;
wire CSdec, CSmem, RW;

assign CSmem  =  (state == `CPU_STATE_MM || state == `CPU_STATE_WB || state == `CPU_STATE_BL) ? CSdec   : `FALSE;
assign OINreg  = (state == `CPU_STATE_WB || state == `CPU_STATE_BL) ? OINdec  : `FALSE;
assign LOUTreg = (state == `CPU_STATE_RG || state == `CPU_STATE_EX || state == `CPU_STATE_MM) ? LOUTdec : `FALSE;
assign ROUTreg = (state == `CPU_STATE_RG || state == `CPU_STATE_EX || state == `CPU_STATE_MM) ? ROUTdec : `FALSE;

decoder DEC(
.r(r),
.lSel(lSel), .rSel(rSel), .oSel(oSel),
.LOUT(LOUTdec), .ROUT(ROUTdec), .OIN(OINdec),
.op(op), .inst(inst),
.CS(CSdec), .RW(RW),
.clk(clk), .res(res));

register REG(
.l(l), .r(r), .o(o),
.lSel(lSel), .rSel(rSel), .oSel(oSel),
.LOUT(LOUTreg), .ROUT(ROUTreg), .OIN(OINreg),
.clk(clk), .res(res));

alu ALU(
.l(l), .r(r), .o(o), .a(a),
.op(op),
.clk(clk), .res(res));

memory MEM(
.a(a), .d(o),
.RW(RW), .CS(CSmem),
.clk(clk), .res(res));

always @(posedge clk or negedge res) begin
	if (res == `FALSE) state <= `CPU_STATE_RS;
	else begin
		case (state)
			`CPU_STATE_RS: state <= `CPU_STATE_ID;
			`CPU_STATE_ID: state <= `CPU_STATE_RG;
			`CPU_STATE_RG: state <= `CPU_STATE_EX;
			`CPU_STATE_EX: state <= `CPU_STATE_MM;
			`CPU_STATE_MM: state <= `CPU_STATE_WB;
			`CPU_STATE_WB: state <= `CPU_STATE_BL;
			`CPU_STATE_BL: state <= `CPU_STATE_ID;
		endcase
	end
end

endmodule
