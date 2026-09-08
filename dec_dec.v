task dec_dec;
input [39:0] instr;
input en;
reg [1:0] cls;
reg [3:0][3:0] rehhs;
reg flipped;
reg [3:0] cond;
reg [3:0] flg;
reg [4:0] opc;
reg [1:0] cls_lsu;
reg [3:0][11:0] ra;
reg [3:0][4:0] rax;
reg [4:0] ruse;
reg signed [22:0] imm18;
reg signed [17:0] imm17;
integer f,a;
begin
  cls=instr[39:38];
  rehhs=instr[11:0];
  flipped=instr[12];
  cond=cls==0 ? 4'hf : 
    instr[16:13];
  flg={2'b0,instr[18:17]};
  opc=instr[37:33];
  cls_lsu=instr[36:35];
  
  if (cls_lsu==1 && cls==1) begin
    if (instr[34]) begin
      case(instr[33:32])
        0: begin
          imm=instr[31:0];
          rehhs[0]=15;
          ruse=8;
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
    end
  end else if (cls==0) begin
    imm18={cond,flg,rehhs[1],instr[32:19]};
    has_alu=flipped;
    flipped=0;
    if (has_alu && vecinit) imm=imm18*phy;
    else if (has_alu && vecmode) imm=imm18*32;
    else imm=imm18;
    postinc=has_alu && ~vecmode;
    ruse=74;
  end else if (cls==1) begin
    imm17={rehhs[0],instr[32:19]};
    has_alu=flipped;
    flipped=0;
    if (has_alu && vecinit) imm=imm17*phy;
    else if (has_alu && vecmode) imm=imm17*32;
    else imm=imm17;
    postinc=has_alu && ~vecmode;
    ruse=54;
  end else if (cls==2) begin
    imm=instr[32:19];
    opc[0]=0;
    ruse=47+64*&opc[4:3];
  end else if (cls==3) begin
    imm={rehhs[2],instr[32:19]};
    if (opc[0]]) imm<<17;
    opc=opc|1;
    ruse=43+64*&opc[4:3];
  end 
  rehhs[3]=flg;
  for(a==0;a<4;a=a+1) begin
    rax[a]={rttr[rehhs[a]],rehhs[a]};
    ra[a]=rttr2[{rttr[rehhs[a]],rehhs[a]}];
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
    rttr2[rehhs[0]]<=flipped;
    rttr[{flipped,rehhs[0]}]<=alloc[fu];
  end
end
endtask
