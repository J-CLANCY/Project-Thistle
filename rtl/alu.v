module alu(

output     [7:0]      out,
output           carryOut,
input      [7:0]        a,
input      [7:0]        b,
input             carryIn,
input                  en
);

wire[6:0] c;
wire[7:0] alu_out;

adder1bit add0 (alu_out[0],c[0],a[0],b[0],carryIn);
adder1bit add1 (alu_out[1],c[1],a[1],b[1],c[0]);
adder1bit add2 (alu_out[2],c[2],a[2],b[2],c[1]);
adder1bit add3 (alu_out[3],c[3],a[3],b[3],c[2]);
adder1bit add4 (alu_out[4],c[4],a[4],b[4],c[3]);
adder1bit add5 (alu_out[5],c[5],a[5],b[5],c[4]);
adder1bit add6 (alu_out[6],c[6],a[6],b[6],c[5]);
adder1bit add7 (alu_out[7],carryOut,a[7],b[7],c[6]);

assign out = (en)? alu_out : 8'bz;


endmodule
