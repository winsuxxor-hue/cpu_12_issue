task alu;
  input [65:0] dataA_add;
  input [65:0] dataA_sub;
  input [65:0] dataA_logcmov;
  input [65:0] dataA_shf;
  input [65:0] dataB_add;
  input [65:0] dataB_sub;
  input [65:0] dataB_logcmov;
  input [65:0] dataB_shf;
  input true;
  input [4:0] opcode;
  reg true2;
  true2=true;
  case(opcode[4:3])
    0: begin
      case(opcode[2:1])
        0: res={dataA_add[63],dataA_add
                [63:0]}+{dataB_add[63],
                         dataB_add[63:0]};
        1: begin
          res={dataA_add[63],dataA_add
                [63:0]}+{dataB_add[63],
                         dataB_add[63:0]}
                         +true;
          true2=0;
        end
        2: res={dataA_sub[63],dataA_sub
                [63:0]}-{dataB_sub[63],
                         dataB_sub[63:0]};
        3:begin
          res={dataA_sub[63],dataA_sub
                [63:0]}-{dataB_sub[63],
                         dataB_sub[63:0]}
                         -!true;
          true2=0;
        end
      endcase
    end
  endcase
endtask
  
