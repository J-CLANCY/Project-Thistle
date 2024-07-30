module ram(

input       clk,
input       rst,
inout [7:0] data,
input [7:0] mar_in,
input       mar_wr,
input       we,
input       oe,
input       program_mode,
input       pm_we,
input       pm_mar_wr,
input [7:0] pm_mar_in,
input [7:0] pm_data

);

reg [7:0] mem [0:255];
reg [7:0] data_out;
reg [7:0] address;

integer i;

assign data = (oe && !we)? data_out: 8'bz;

always @ (posedge clk or posedge rst)
begin: MAR_IN
  if (rst) begin
      address = 0;
      data_out = 8'bz;
  end
  else if (program_mode) begin
    if(pm_mar_wr) begin
      address = pm_mar_in;
    end
  end
  else begin
    if (mar_wr) begin
      address = mar_in;
    end
  end
end

always @ (posedge clk or posedge rst)
begin: WRITE
  if (rst) begin
    for (i=0;i<256;i=i+1) begin
      mem[i] = 0;
    end
  end
  else if(program_mode) begin
    if(pm_we) begin
      mem[address] = pm_data;
    end
  end
  else begin 
    if (we) begin
      mem[address] = data;
    end
  end
end

always @ (posedge clk or posedge rst)
begin: READ
  if (rst) begin
    for (i=0;i<256;i=i+1) begin
      mem[i] = 0;
    end
  end
  else if (!we && oe) begin
    data_out = mem[address];
  end
end

endmodule
