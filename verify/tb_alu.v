module tb_alu();

reg [7:0] a,b;
reg       carryIn;
reg       en_b;

wire [7:0] out;
wire       carryOut;

alu ALU (

.out      (out),
.carryOut (carryOut),
.a        (a),
.b        (b),
.carryIn  (carryIn),
.en_b     (en_b)
);

initial
begin
  a = 0;
  b = 0;
  carryIn = 0;
  en_b = 0;
end

initial
begin
  $recordfile("alu.vcd");
  $recordvars();
end

initial
begin
  #5 a = 8'h10;
     b = 8'h20;
     carryIn = 1'b1;
  #5 a = 8'h00;
  #5 en_b = 1;
  #5 a = 8'h01;
  #5 b = 8'h02;
  #10 $finish;
end

endmodule
