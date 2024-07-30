module alu_reg(

output [7:0] alu_data,
inout  [7:0] data,
input        clk,
input        rst,
input        clr,
input        in_en,
input        out_en,
input        alu_in,
input        program_mode

);

reg [7:0] data_out;

assign data = (out_en)? data_out: 8'bz;
assign alu_data = (alu_in)? data_out: 8'b0;

always @ (posedge clk or posedge rst)
begin
  if (rst | clr) begin
    data_out = 0;
  end
  else if(program_mode)begin
  end
  else if(in_en) begin
    data_out = data;
  end
end

endmodule
