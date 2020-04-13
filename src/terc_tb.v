// Test bench of cpu1
`include "define.v"

// Set 1unit 1ps
`timescale 1ps/1ps

module terc_tb;
reg  	[`WIDTH-1:0]	inst;
reg                  clk, res;

wire [`OP_WIDTH-1:0] op;
wire [`WIDTH-1:0] l, r, o, result;
wire [`RAM_WIDTH-1:0] a;
wire [`CPU_STATE_WIDTH-1:0] state;
wire [`REG_WIDTH-1:0] lSel, rSel, oSel;
wire OINdec, OINreg;
wire LOUTdec, LOUTreg;
wire ROUTdec, ROUTreg;
wire CSdec, CSmem, RW;
integer i;

parameter STEP = 100000;

// Call test target

terc cpu(inst, clk, res);

assign l = cpu.l;
assign r = cpu.r;
assign o = cpu.o;
assign a = cpu.a;
assign lSel = cpu.lSel;
assign rSel = cpu.rSel;
assign oSel = cpu.oSel;
assign state = cpu.state;
assign OINdec = cpu.OINdec;
assign OINreg = cpu.OINreg;
assign LOUTdec = cpu.LOUTdec;
assign LOUTreg = cpu.LOUTreg;
assign ROUTdec = cpu.ROUTdec;
assign ROUTreg = cpu.ROUTreg;
assign CSdec = cpu.CSdec;
assign CSmem = cpu.CSmem;
assign RW = cpu.RW;
assign op = cpu.op;
assign result = cpu.REG.ff[oSel];

always begin
	clk = 0; #(STEP/2);
	clk = 1; #(STEP/2);
end

// Input test
initial begin
	inst <= 16'h0000; res <= `FALSE;
	#STEP res <= `TRUE;
	for (i = 0; i < 4; i = i + 1) begin
		#(STEP*`CPU_CYCLE)	inst <= loadi(i, i);
		#(STEP*`CPU_CYCLE)	inst <= loadi(i + 4, i * 7);
		#(STEP*`CPU_CYCLE)	inst <= memType(`OP_STORE, i, i + 4);
		#(STEP*`CPU_CYCLE)	inst <= loadi(i + 4, 0);
	end
	for (i = 0; i < 4; i = i + 1) begin
		#(STEP*`CPU_CYCLE)	inst <= memType(`OP_LOAD, i + 4, i);
	end
	#(STEP*`CPU_CYCLE);
	#(STEP*2) $finish;
end
				
// Display

initial $monitor($stime, "l=%h r=%h o=%h", l, r, o);
						

function [`WIDTH-1:0] rType;
input [`OP_WIDTH-1:0]  op;
input [`REG_WIDTH-1:0] rd, rs, rt;
	rType = {op, rd, rs, rt, 3'b000};
endfunction

function [`WIDTH-1:0] loadi;
input [`REG_WIDTH-1:0] rd;
input [`IM_WIDTH-1:0] im;
	loadi = {4'h6, rd, im};
endfunction

function [`WIDTH-1:0] memType;
input [`OP_WIDTH-1:0]  op;
input [`REG_WIDTH-1:0] rd, rs;
	memType = {op, rd, rs, 3'b000, 3'b000};
endfunction

endmodule
