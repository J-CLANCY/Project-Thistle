module io_reg(

inout [7:0] port,
inout [7:0] data,
input       clk,
input       rst,
input       clr,
input       in_en,
input       out_en,
input       port_in,
input       port_out,
input       program_mode

);

reg [7:0] data_out;

assign data = (out_en)? data_out: 8'bz;
assign port = (port_out)? data_out: 8'bz;

always @ (posedge clk or posedge rst)
begin
  if(rst | clr) begin
    data_out = 0;
  end
  else if(program_mode)begin
  end
  else if(port_in) begin
    data_out = port;
  end
  else if(in_en) begin
    data_out = data;
  end
end

endmodule



