/* and2.v と and2test.v の統合化 */

/* AND2 テストベンチ */
module TERC;

reg a, b;
wire out;

AND2 bbb (a, b, out);

initial begin
    $dumpfile("TERC.vcd");
    $dumpvars(0, TERC);
    $monitor ("%t: a = %b, b = %b, out = %b", $time, a, b, out);

        a = 0; b = 0;
    #10 a = 1;
    #10 a = 0; b = 1;
    #10 a = 1;
    #10 a = 0; b = 0;
    #10 $finish;
end

endmodule

/* AND2 */

module AND2 ( A, B, X );

input A, B;
output X;

    and AAA (X, A, B);

endmodule
