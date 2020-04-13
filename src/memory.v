// RAM
`include "define.v"

module memory(a, RW, CS, d, clk, res);
input  [`RAM_WIDTH-1:0]     a;
input                       RW, CS, clk, res;
inout  [`WIDTH-1:0]         d;
wire   [`WIDTH-1:0]         d;
reg    [`WIDTH-1:0]         out, ff[`RAM_SIZE-1:0];
integer i;

assign d = (CS == `TRUE && RW == `TRUE) ? out : `HIZ;

always @(posedge clk or negedge res) begin
	if (res == `FALSE) begin
		out <= `ZERO;
		for (i = 0; i < `RAM_SIZE; i = i + 1)
			ff[i] <= `ZERO;
	end else begin
		if (CS == `TRUE) begin
			if (RW == `TRUE) begin
				out <= ff[a];
			end else begin
				ff[a] <= d;
			end
		end
	end
end

endmodule
