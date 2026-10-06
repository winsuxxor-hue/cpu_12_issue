task alu;
  input [65:0] dataA_add;
  input [65:0] dataA_sub;
  input [65:0] dataA_logcmov;
  input [65:0] dataA_shf;
  input real dataA_real;
  input [65:0] dataB_add;
  input [65:0] dataB_sub;
  input [65:0] dataB_logcmov;
  input [65:0] dataB_shf;
  input real dataB_real;
  input true;
  input [4:0] opcode;
  input postinc;
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
      0: resshf=((dataA_shf&{{12{~passimm[7]}},52'hfffffffffffff}|{12'b1,52'b0})<<(passimm[7] ? 
                             dataB_shf[56:53]:dataB_shf[5:0]))&{{32{passimm[6]}},32'hffffffff};
      1: resshf=(dataA_shf>>>dataB_shf[5:0])&{{32{passimm[6]}},32'hffffffff};
      2: resshf=(dataA_shf>>dataB_shf[5:0])&{{32{passimm[6]}},32'hffffffff};
    endcase
    3: case(opcode[2:1])
      0: resm=dataA_sgn[31:0]*dataB_sgn[31:0];
      1: resm=dataA_uns[31:0]*dataB_uns[31:0];
      2: resm=dataA_sgn*dataB_sgn;
      3: begin
        if (passimm[0])
          resm=dataA_uns*dataB_uns>>64;
        else 
          resm=passimm[2] ? dataA_logcmov/real'(1<<passimm[6:3])
          : pasimm[1] ?
          dataA_real * dataB_real :
          dataA_real + dataB_real;
      end
    endcase
  endcase
  if ((opcode[4:3]==1 || opcode[4:3]==2 &&
       opcode[2:1]==3) && true2)
    res=resl;
  else if (opcode[4:3]==2)
    res=resshf;
  if (~true2) res=dataC;
  resm2<=resm;
  resm3<=resm2;
  if (fu>9) resmul={1'b0,resm3[63],resm3[63:0]};
  resaddr=postinc ? dataA_sub[42:0] : res[42:0];
endtask
  
