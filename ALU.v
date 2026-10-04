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
    2: begin
      case(opcode[2:1])
        0: resl=~opcode[0] ? (passimm[0] 
                    
                              ? dataB_logcmov : passimm[1] ?
                              {dataB_logcmov[65:32],
                               dataA_logcmov[31:0]} :
                              |dataB_logcmov[63:32] &
                              |dataA_logcmov[31:0]);
                             
        1: resl=~opcode[0] ? dataA_ipx[dataB_logcmov[4:0]] :
          dataA_ipx[loopstop-dataB_logcmov[0]];
        2: resl=dataA_logcmov|dataB_logcmov;
        3: resl=dataA_logcmov&dataB_logcmov;
      endcase
    end
    1: case(opcode[2:1])
      3: resl=dataA_logcmov^dataB_logcmov;
      0: resshf=(dataA_shf<<dataB_shf[5:0])&{{32{passimm[6]}},32'hffffffff};
      1: resshf=(dataA_shf>>>dataB_shf[5:0])&{{32{passimm[6]}},32'hffffffff};
      2: resshf=(dataA_shf>>dataB_shf[5:0])&{{32{passimm[6]}},32'hffffffff};
    endcase
  endcase
endtask
  
