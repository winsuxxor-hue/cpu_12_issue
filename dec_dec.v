task dec_dec;
input [39:0] instr;
reg [1:0] cls;
reg [2:0][3:0] rehhs;
reg flipped;
reg [3:0] cond;
reg [3:0] flg;
reg [4:0] opc;
reg [1:0] cls_lsu;
  reg [7:0] ra,rb,ri;
  integer f;
begin
  cls=instr[39:38];
  rehhs=instr[11:0];
  flipped=instr[12];
  cond=cls==0 ? 4'hf : 
    instr[16:13];
  flg={2'b0,instr[18:17]};
  opc=instr[37:33];
  cls_lsu=instr[36:35];
  rax[phy][fu]={rttr[rehhs[1]],rehhs[1]};
  ra=rttr2[{rttr[rehhs[1]],rehhs[1]}];
  for(f=0;f<fu;f=f+1) if (rax[phy][fu]==
                          rtx[phy][f] &&
                          wrt[phy][f])
    ra=alloc[phy][f];
  eng_ra[phy][fu]=ra;
  if (cls_lsu==1 && cls==1) begin
  end else if (cls==0) begin
  end else if (cls==1) begin
  end else if (cls==2) begin
  end else if (cls==3) begin
  end 
end
endtask
