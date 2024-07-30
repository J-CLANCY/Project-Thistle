module tb_id();

reg       clk;
reg       rst;
reg [7:0] inst;
reg       ir_en;
reg       cyIn;

wire      HLT;
wire      RI;
wire      RO;
wire      MI;
wire      PI;
wire      PO;
wire      PE;
wire      II;
wire      AI;
wire      AO;
wire      BI;
wire      BO;
wire      AC;
wire      BC;
wire      ALI;
wire      ALO;
wire      CYI;

inst_decoder id (

.clk(clk),
.rst(rst),
.inst(inst),
.ir_en(ir_en),
.cyIn(cyIn),
.HLT(HLT),
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
.AC(AC),
.BC(BC),
.ALI(ALI),
.ALO(ALO),
.CYI(CYI)

);

initial 
begin 
  clk = 1;
end

always
  #5 clk = !clk;

initial
begin
  
  rst = 0;
  inst = 8'hB0;
  ir_en = 0;
  cyIn = 0;

  #2 rst = 1;
  #4 rst = 0;
  #4 //ir_en = 1;
  #5 //ir_en = 0;

  #45 $finish;
end

initial
begin
  $recordfile("tb_id");
  $recordvars();
end

endmodule






