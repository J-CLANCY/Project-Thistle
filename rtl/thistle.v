module thistle(

inout [7:0] port,
input       sys_clk,
input       rst,
input       program_mode,
input       pm_data_we,
input       pm_addr_we,
input [7:0] pm_data,
input [7:0] pm_address

);

wire [7:0] bus = 8'bz;
wire       clk;
wire       cyOut;
wire       HALT;
wire       RI;
wire       RO;
wire       MI;
wire       PI;
wire       PO; 
wire       PE;
wire       II;
wire       AI;
wire       AO;
wire       BI;
wire       BO;
wire       OI;
wire       OO;
wire       AC;
wire       BC;
wire       OC;
wire       PTI;
wire       PTO;
wire       ALI;
wire       ALO;
wire       CYI;    
wire [7:0] a_alu_data;
wire [7:0] b_alu_data;

assign clk = (!HALT)? sys_clk: 1'b0;

ram ram(

.clk(clk),
.rst(rst),
.data(bus),
.mar_in(bus),
.mar_wr(MI),
.we(RI),
.oe(RO),
.program_mode(program_mode),
.pm_we(pm_data_we),
.pm_mar_wr(pm_addr_we),
.pm_mar_in(pm_address),
.pm_data(pm_data)

);

alu alu(

.out(bus),
.carryOut(cyOut),
.a(a_alu_data),
.b(b_alu_data),
.carryIn(CYI),
.en(ALO)

);

io_reg io(

.port(port),
.data(bus),
.clk(clk),
.rst(rst),
.clr(OC),
.in_en(OI),
.out_en(OO),
.port_in(PTI),
.port_out(PTO),
.program_mode(program_mode)

);

alu_reg a(

.alu_data(a_alu_data),
.data(bus),
.clk(clk),
.rst(rst),
.clr(AC),
.in_en(AI),
.out_en(AO),
.alu_in(ALI),
.program_mode(program_mode)

);

alu_reg b(

.alu_data(b_alu_data),
.data(bus),
.clk(clk),
.rst(rst),
.clr(BC),
.in_en(BI),
.out_en(BO),
.alu_in(ALI),
.program_mode(program_mode)

);

program_counter pc(

.pc_out(bus),
.clk(clk),
.rst(rst),
.pc_in(bus),
.pc_ld(PI),
.pc_en(PO),
.pc_up(PE),
.program_mode(program_mode)

);

inst_decoder id(

.clk(clk),
.rst(rst),
.inst(bus),
.ir_en(II),
.cyOut(cyOut),
.program_mode(program_mode),
.HLT(HALT),
.RI(RI),
.RO(RO),
.MI(MI),
.PI(PI),
.PO(PO),
.PE(PE),
.II(II),
.AI(AI),
.AO(AO),
.BI(BI),
.BO(BO),
.OI(OI),
.OO(OO),
.PTI(PTI),
.PTO(PTO),
.AC(AC),
.BC(BC),
.OC(OC),
.ALI(ALI),
.ALO(ALO),
.CYI(CYI)

);

endmodule
















