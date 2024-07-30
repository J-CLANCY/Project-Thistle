module program_counter(

output     [7:0] pc_out,
input            clk,
input            rst,
input      [7:0] pc_in,
input            pc_ld,
input            pc_en,
input            pc_up,
input            program_mode
);

reg [7:0] out;

always @ (posedge clk or posedge rst)
begin

if(rst)
out <= 8'b0;

else if(program_mode)begin
end

else if(pc_ld)
out <= pc_in;

else if(out == 8'hFF)
out <= 8'b0;

else if (pc_up)
out <= out + 1;

end

assign pc_out = (pc_en)? out : 8'bz;

endmodule
