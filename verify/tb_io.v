module tb_io();

reg     clk;
reg     rst;
reg     clr; 
reg     in_en;
reg     out_en;
reg     port_in;
reg     port_out;
reg     program_mode;

wire [7:0] port;
wire [7:0] data;

reg [7:0] data_in;
reg [7:0] prt_in;
reg       data_valid;
reg       port_valid;

wire [7:0] data_out;
wire [7:0] prt_out;

io_reg io(

.port(port),
.data(data),
.clk(clk),
.rst(rst),
.clr(clr),
.in_en(in_en),
.out_en(out_en),
.port_in(port_in),
.port_out(port_out),
.program_mode(program_mode)

);

assign data_out = data;
assign prt_out = port;
 
assign data = (data_valid)? data_in: 8'bz;
assign port = (port_valid)? prt_in: 8'bz;

initial
begin
  clk = 1;
end

always
 #5 clk = !clk;

initial begin

  rst = 0;
  clr = 0;
  in_en = 0;
  out_en = 0;
  port_in = 0;
  port_out = 0;
  program_mode = 0;
  data_valid = 1;
  port_valid = 1;
  data_in = 8'hAA;
  prt_in = 8'hBB;

  #2  rst = 1;
  #3  rst = 0;

  #5  in_en = 1;
  #5  in_en = 0;
  #5  out_en = 1;
  #5  out_en = 0;
  #5  port_in = 1;
  #5  port_in = 0;
  #5  port_out = 1;
  #5  port_out = 0;
  #5  clr = 1;
  #5  clr = 0;

  #10 $finish;
 
end

initial
begin
  $recordfile("tb_io");
  $recordvars;
end

endmodule


