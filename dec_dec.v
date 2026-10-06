task dec_dec;
input [42:0] instr;
input en;
reg [1:0] cls;
reg [3:0][4:0] rehhs;
//reg flipped;
reg [3:0] cond;
reg [3:0] flg;
reg [4:0] opc;
reg [5:0] opmem;
reg [1:0] cls_lsu;
reg [3:0][11:0] ra;
reg [3:0][4:0] rax;
reg [4:0] ruse;
reg signed [22:0] imm18;
reg signed [17:0] imm17;
integer f,a;
begin
  cls=instr[42:41];
  rehhs=instr[14:0];
  //flipped=instr[12];
  cond=cls==0 ? 4'hf : 
    instr[18:15];
  flg=instr[22:19];
  opc=instr[40:36];
  memcmov=0;
  cls_lsu=instr[39:38];
  immff=0;
  imm=0;
  if (cls_lsu==1 && cls==1) begin
    if (instr[34]) begin
      case(instr[33:32])
        0: begin
          imm=instr[31:0];
          rehhs[0]=15;
          ruse=8;
          opc=15;
        end
        1,2: begin
          imm=IP+instr[31:0];
          if (instr[32]) rehhs[0]=4;
          ruse=8*instr[32];
        end
        3: begin
          imm=IP+instr[31:6];
          cond=instr[3:0];
          flg=instr[5:4];
          ruse=32;
        end
      endcase
    end else begin
      case(instr[33:32])
        0: begin
          if (rehhs[2][0]) begin
            immff=1;
            imm=instr[35:23]+IP*rehhs[2][1];
            alret=rehhs[2][3:2];
          end else begin
            immff=0;
            imm=instr[35:23];
            alret=rehhs[2][3:2];
            opc=2+rehhs[2][1];
          end
        end
      endcase
    end
  end else if (cls==0) begin
    imm18={cond,flg,rehhs[1],instr[35:23]};
    has_alu=opc[0];
   // flipped=0;
    if (has_alu && vecinit) imm=imm18*phy;
    else if (has_alu && vecmode) imm=imm18*32;
    else imm=imm18;
    postinc=has_alu && ~vecmode;
    opmem={1'b0,opc};
    ruse=74;
    opc=1;
    if (cls_lsu==2 && !instr[40] && instr
        [37]) begin
        opc=8;
        ruse=78;
        opmem[3:2]=1;
    end
  end else if (cls==1) begin
    imm17={rehhs[0],instr[35:23]};
    has_alu=opc[4];
   // flipped=0;
    if (has_alu && vecinit) imm=imm17*phy;
    else if (has_alu && vecmode) imm=imm17*32;
    else imm=imm17;
    postinc=has_alu && ~vecmode;
    ruse=54;
    opmem={1'b1,opc};
  end else if (cls==2) begin
    imm=instr[35:23];
    opc[0]=0;
    ruse=47+64*&opc[4:3];
  end else if (cls==3) begin
    imm={rehhs[2],instr[35:23]};
    if (opc[0]]) begin
      imm=imm[17:1]<<17+{17{imm[0]}};
    end
    opc=opc|1;
    ruse=43+64*&opc[4:3];
  end 
  rehhs[3]=flg;
  for(a==0;a<4;a=a+1) begin
    rax[a]={rttr[rehhs[a]};
    ra[a]=rttr2[{rehhs[a]}];
    for(f=0;f<fu;f=f+1) if (rax[a]==
                          rtx[phy][f] &&
                          wrt[phy][f])
      ra[a]=alloc[f];
    eng_ra[fu][a]=ra[a];
  end
  if (en)
  eng_free[alloc[fu][7:4]][alloc[fu][3:0]]
    <=ruse;
  if (en && ruse[3]) begin
    rttr[{rehhs[0]}]<=alloc[fu];
  end
  if (en)
    foo[f][alloc[7:4]][alloc[3:0]]<=0;
  if (en)
    eng_opc[f][alloc[7:4]][alloc[3:0]]<= 
    opc;
  if (en)
    eng_opmem[f][alloc[7:4]][alloc[3:0]]<=
    opmem;
end
endtask
