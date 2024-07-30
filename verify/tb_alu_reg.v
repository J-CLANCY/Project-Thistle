module tb_alu_reg();

reg      clk;
reg      rst;
reg      clr;
reg      in_en;
reg      out_en;
reg      alu_in;

wire [7:0] alu_data;
wire [7:0] data;

reg [7:0] data_in;
reg       data_valid;

wire [7:0] data_out;

alu_reg alu_reg (

.alu_data(alu_data),
.data(data),
.clk(clk),
.rst(rst),
.clr(clr),
.in_en(in_en),
.out_en(out_en),
.alu_in(alu_in)

);

assign data_out = data;
assign data = (data_valid)? data_in: 8'bz;

initial
begin
  clk = 1;
end

always
  #5 clk = !clk;

initial
begin

  rst = 0;
  clr = 0;
  in_en = 0;
  out_en = 0;
  alu_in = 0;
  data_in = 8'hAA;
  data_valid = 1;

  #4  rst = 1;
  #2  rst = 0;
  #4  in_en = 1;
  #10 in_en = 0;
      data_in = 8'hz;
  #10 alu_in = 1;
  #10 alu_in = 0;
  #10 out_en = 1;
  #10 out_en = 0;
  #10 clr = 1;
  #10 clr = 0;

  #10 $finish;
  
end

initial
begin
  $recordfile("tb_alu_reg");
  $recordvars();
end

endmodule

