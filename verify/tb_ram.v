module tb_ram();

reg       clk;
reg       rst;
reg [7:0] mar_in;
reg       mar_wr;
reg       we;
reg       oe;
reg       program_mode;
reg       pm_we;
reg       pm_mar_wr;
reg [7:0] pm_mar_in;
reg [7:0] pm_data;

wire [7:0] data;

reg [7:0] data_in;
reg       data_valid;

wire [7:0] data_out;


ram ram (

.clk(clk),
.rst(rst),
.data(data),
.mar_in(mar_in),
.mar_wr(mar_wr),
.we(we),
.oe(oe),
.program_mode(program_mode),
.pm_we(pm_we),
.pm_mar_wr(pm_mar_wr),
.pm_mar_in(pm_mar_in),
.pm_data(pm_data)

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
  mar_in = 8'h01;
  mar_wr = 0;
  we = 0;
  oe = 0;
  program_mode = 1;
  pm_we = 0;
  pm_mar_wr = 0;
  pm_mar_in = 8'h00;
  pm_data = 8'hDD;
  data_in = 8'hz;
  data_valid = 1;

  #2  rst = 1;
  #3  rst = 0;

  #5  pm_mar_wr = 1;
  #5  pm_mar_wr = 0;
  #5  pm_we = 1;
  #5  pm_we = 0;
      program_mode = 0;
  #5  oe = 1;
  #5  oe = 0;
      
  #10 $finish;
  
end

initial
begin
  $recordfile("tb_ram");
  $recordvars();
end

endmodule




