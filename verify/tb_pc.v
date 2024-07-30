module tb_pc();

reg clk; 
reg rst;
reg pc_ld;
reg pc_en;
reg pc_up;
reg [7:0] pc_in;

wire [7:0] pc_out;

program_counter pc (

.pc_out(pc_out),
.clk(clk),
.rst(rst),
.pc_in(pc_in),
.pc_ld(pc_ld),
.pc_ens(pc_en),
.pc_up(pc_up)
);

initial
begin
  clk = 0;
end

always
  #5 clk = !clk;

initial
begin
  
  rst = 1;
  pc_in = 8'b10101010;
  pc_up = 0;
  pc_ld = 0;
  pc_en = 0;

  #20 rst = 0;
      pc_up = 1;
  #50 pc_ld = 1;
  #20 pc_ld = 0;
  #20 pc_up = 0;
  #50 rst = 1;
  
  #20 $finish;
end

initial
begin
  $recordfile("tb_pc");
  $recordvars();
end

endmodule

