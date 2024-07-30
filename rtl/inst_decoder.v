module inst_decoder(

input       clk,
input       rst,
input [7:0] inst,
input       ir_en,
input       cyOut,
input       program_mode,
output  reg    HLT,
output  reg    RI,
output  reg    RO,
output  reg    MI,
output  reg    PI,
output  reg    PO,
output  reg    PE,
output  reg    II,
output  reg    AI,
output  reg    AO,
output  reg    BI,
output  reg    BO,
output  reg    OI,
output  reg    OO,
output  reg    AC,
output  reg    BC,
output  reg    OC,
output  reg    PTI,
output  reg    PTO,
output  reg    ALI,
output  reg    ALO,
output  reg    CYI

);

reg [7:0] instruction;

parameter LD = 4'b0000;
parameter ST = 4'b0001;
parameter ADD = 4'b0010;
parameter SUB = 4'b0011;
parameter MOV = 4'b0100;
parameter CLR = 4'b0101;
parameter HALT = 4'b0110;
parameter JC = 4'b0111;
parameter JNC = 4'b1000;
parameter JMP = 4'b1001;
parameter JR = 4'b1010;
parameter IN = 4'b1011;
parameter OUT = 4'b1100;
parameter NOP = 4'b1101;

parameter A = 4'b0000;
parameter B = 4'b0001;

parameter AtB = 4'b0001;
parameter AtIO = 4'b0010;
parameter BtA = 4'b0100;
parameter BtIO = 4'b0110;
parameter IOtA = 4'b1000;
parameter IOtB = 4'b1001;


always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    instruction = NOP;
  end
  else if (program_mode)begin
  end
  else if(ir_en | II) begin
    instruction = inst;
  end
end

always @ (posedge clk or posedge rst)
begin
  HLT = 0;
  RI = 0;
  RO = 0;
  MI = 0;
  PI = 0;
  PO = 0;
  PE = 0;
  II = 0;
  AI = 0;
  AO = 0;
  BI = 0;
  BO = 0;
  OI = 0;
  OO = 0;
  AC = 0;
  BC = 0;
  OC = 0;
  PTI = 0;
  PTO = 0;
  ALI = 0;
  ALO = 0;
  CYI = 0;

  if(!program_mode) begin
    // FETCH 
    PO = 1;
    MI = 1;
  
    #5  PO = 0;
        MI = 0;
    #5  RO = 1;
        II = 1;

    #5  RO = 0;
        II = 0;

    case(instruction[7:4])
      // LOAD
      LD:
      begin
        #5  PE = 1;
            PO = 1;
            MI = 1;
        #5  PE = 0;
            PO = 0;
            MI = 0;
        #5  RO = 1;
            MI = 1;
        #5  RO = 0;
            MI = 0;
        case(instruction[3:0])
          A:
          begin
            #5 AI = 1;
               RO = 1;
            #5 AI = 0;
               RO = 0;
          end
          B:
          begin
            #5 BI = 1;
               RO = 1;
            #5 BI = 0;
               RO = 0;
          end
        endcase
      end
      // STORE
      ST:
      begin
        #5  PE = 1;
            PO = 1;
            MI = 1;
        #5  PE = 0;
            PO = 0;
            MI = 0;
        #5  RO = 1;
            MI = 1;
        #5  RO = 0;
            MI = 0;
        case(instruction[3:0])
          A:
          begin
            #5 RI = 1;
               AO = 1;
            #5 RI = 0;
               AO = 0;
          end
          B:
          begin
            #5 RI = 1;
               BO = 1;
            #5 RI = 0;
               BO = 0;
          end
        endcase
      end
      // ADD
      ADD:
      begin
         #5  ALI = 1;
         #5  ALI = 0;
         #5  ALO = 1;
             AI = 1;
         #5  ALO = 0;
             AI = 0;
         #10;
      end
      // SUBTRACT
      SUB:
      begin
         #5  ALI = 1;
             CYI = 1;
         #5  ALI = 0;
         #5  ALO = 1;
             AI = 1;
         #5  ALO = 0;
             AI = 0;
             CYI = 0;
         #10;
      end
      // MOVE
      MOV:
      begin
        case(instruction[3:0])
          AtB:
          begin
            #5 AO = 1;
               BI = 1;
            #5 AO = 0;
               BI = 0;
          end
          AtIO:
          begin
            #5 AO = 1;
               OI = 1;
            #5 AO = 0;
               OI = 0;
          end
          BtA:
          begin
            #5 BO = 1;
               AI = 1;
            #5 BO = 0;
               AI = 0;
          end
          BtIO:
          begin
            #5 BO = 1;
               OI = 1;
            #5 BO = 0;
               OI = 0;
          end
          IOtA:
          begin
            #5 OO = 1;
               AI = 1;
            #5 OO = 0;
               AI = 0;
          end
          IOtB:
          begin
            #5 OO = 1;
               BI = 1;
            #5 OO = 0;
               BI = 0;
          end
        endcase
        #20;
      end
      // CLEAR
      CLR:
      begin
        case(instruction[3:0])
          A:
          begin
            #5 AC = 1;
            #5 AC = 0;
          end
          B:
          begin
            #5 BC = 1;
            #5 BC = 0;
          end
        endcase
        #20;
      end
      // HALT
      HALT:
      begin
         #5 HLT = 1;
         #5 HLT = 0;
         #20;
      end
      // JUMP IF CARRY SET
      JC:
      begin
        #5  PE = 1;
            PO = 1;
            MI = 1;
        #5  PE = 0;
            PO = 0;
            MI = 0;
        #5  RO = 1;
            MI = 1;
        #5  RO = 0;
            MI = 0;
            if(cyOut == 1'b1) begin
              #5 RO = 1;
                 PI = 1;
              #5 RO = 0;
                 PI = 0;
            end
            else begin
              #10;
            end
      end  
      // JUMP IF CARRY NOT SET
      JNC:
      begin
        #5  PE = 1;
            PO = 1;
            MI = 1;
        #5  PE = 0;
            PO = 0;
            MI = 0;
        #5  RO = 1;
            MI = 1;
        #5  RO = 0;
            MI = 0;
            if(cyOut == 1'b0) begin
              #5 RO = 1;
                 PI = 1;
              #5 RO = 0;
                 PI = 0;
            end 
            else begin
              #10;
            end
      end  
      // JUMP
      JMP:
      begin
        #5  PE = 1;
            PO = 1;
            MI = 1;
        #5  PE = 0;
            PO = 0;
            MI = 0;
        #5  RO = 1;
            MI = 1;
        #5  RO = 0;
            MI = 0;
        #5  RO = 1;
            PI = 1;
        #5  RO = 0;
            PI = 0;  
      end  
      // JUMP REGISTER  
      JR:
      begin
        #5  PE = 1;
            PO = 1;
            MI = 1;
        #5  PE = 0;
            PO = 0;
            MI = 0;
        #5  RO = 1;
            MI = 1;
        #5  RO = 0;
            MI = 0;
        case(instruction[3:0])
          A:
          begin
            #5 AO = 1;
               PI = 1;
            #5 AO = 0;
               PI = 0;
          end
          B:
          begin
            #5 BO = 1;
               PI = 1;
            #5 BO = 0;
               PI = 0;
          end
         endcase
      end
      // INPUT
      IN:
      begin
        #5 PTI = 1;
        #5 PTI = 0;
        #20;
      end
      // OUTPUT
      OUT:
      begin
        #5 PTO = 1;
        #5 PTO = 0;
        #20;
      end
      // NO OPERATION
      NOP: 
      begin
        #30;
      end 
      default: instruction[7:4] = NOP;
    endcase

    #5 PE = 1;
    #5 PE = 0;
  end
end

endmodule
  
