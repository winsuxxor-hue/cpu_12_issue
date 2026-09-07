task dec_dec;
input [39:0] instr;
reg [1:0] cls;
reg [2:0][3:0] rehhs;
reg flipped;
reg [3:0] cond;
reg [3:0] flg;
reg [4:0] opc;
reg [1:0] cls_lsu;
begin
  cls=instr[39:38];
  rehhs=instr[11:0];
  flipped=instr[12];
  cond=cls==1 ? rehhs[0] : cls==0 ? 4'hf : 
    instr[16:13];
  flg={2'b0,instr[18:17]};
  opc=instr[37:33];
  cls_lsu=instr[36:35];
  if (cls_lsu==1 && cls==1) begin
  end else if (cls==0) begin
  end else if (cls==1) begin
  end else if (cls==2) begin
  end else if (cls==3) begin
  end 
end
endtask
