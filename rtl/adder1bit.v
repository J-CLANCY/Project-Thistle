module adder1bit(

output     out,
output      co,
input        a,
input        b,
input        ci
);

assign {co,out} = a + b + ci;

endmodule
