module tb_thistle();

reg       sys_clk;
reg       rst;
reg       program_mode;
reg       pm_data_we;
reg       pm_addr_we;
reg [7:0] pm_data;
reg [7:0] pm_address;

wire [7:0] port;

reg [7:0] port_data_in;
reg       port_data_valid;

wire      port_data_out;

integer j;

thistle thistle(

.port(port),
.sys_clk(sys_clk),
.rst(rst),
.program_mode(program_mode),
.pm_data_we(pm_data_we),
.pm_addr_we(pm_addr_we),
.pm_data(pm_data),
.pm_address(pm_address)

);

assign port_data_out = port;
assign port = (port_data_valid)? port_data_in: 8'bz;

initial
begin
  sys_clk = 1;
end
 
always
  #5 sys_clk = !sys_clk;

initial
begin
   
  rst = 0;
  program_mode = 1;
  pm_data_we = 0;
  pm_addr_we = 0;
  pm_data = 8'h00;
  pm_address = 8'h00;
  port_data_in = 8'hz;
  port_data_valid = 1;

  #2 rst = 1;
  #3 rst = 0;
  
  // LD instruction
  #5 pm_addr_we = 1;  
  #5 pm_addr_we = 0;
  #5 pm_data_we = 1;
  #5 pm_data_we = 0;
     

  // LD address
  #5 pm_address = 8'h01;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h20;
     pm_data_we = 1;
  #5 pm_data_we = 0;
  
  // LD instruction
  #5 pm_address = 8'h02;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h01;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // LD address
  #5 pm_address = 8'h03;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h20;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // ADD instruction
  #5 pm_address = 8'h04;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h20;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // MOV instruction
  #5 pm_address = 8'h05;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h42;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // ST instruction
  #5 pm_address = 8'h06;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h10;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // ST address
  #5 pm_address = 8'h07;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h22;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // HLT
  #5 pm_address = 8'h08;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h60;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // Loading 6 into address 32
  #5 pm_address = 8'h20;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h06;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  // Loading 9 into address 33
  #5 pm_address = 8'h21;
     pm_addr_we = 1;
  #5 pm_addr_we = 0;

  #5 pm_data = 8'h09;
     pm_data_we = 1;
  #5 pm_data_we = 0;

  #5 program_mode = 0;
  
  #400 $finish;   
   
end

initial
begin
  $recordfile("tb_thistle");
  $recordvars();
  for(j=0;j<256;j=j+1) begin
    $recordvars(thistle.ram.mem[j]);
  end
end

endmodule
