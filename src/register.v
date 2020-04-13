// general register
`include "define.v"

module register(lSel, LOUT, rSel, ROUT, oSel, OIN, o, r, l, clk, res);
input  [`REG_WIDTH-1:0] lSel, rSel, oSel;
input                    LOUT, ROUT, OIN, clk, res;
input  [`WIDTH-1:0]      o;
output [`WIDTH-1:0]      r, l;

reg    [`WIDTH-1:0]      r, l, ff[`REG_SIZE-1:0];

integer i;

always @(posedge clk or negedge res) begin
	if (res == `FALSE) begin
		for (i = 0; i < `REG_SIZE; i = i + 1)
			ff[i] <= `ZERO;
		r <= `HIZ; l <= `HIZ;
	end
	else begin
		if (LOUT == `TRUE)
			l <= ff[lSel];
		else
			l <= `HIZ;
		if (ROUT == `TRUE)
			r <= ff[rSel];
		else
			r <= `HIZ;
		if (OIN == `TRUE)
			ff[oSel] <= o;
	end
end

endmodule
