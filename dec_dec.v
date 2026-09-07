task dec_dec;
input [39:0] instr;
reg [1:0] cls;
reg [2:0][3:0] rehhs;
reg flipped;
reg [3:0] cond;
reg [3:0] flg;
begin
  cls=instr[39:38];
  rehhs=instr[11:0];
  flipped=instr[12];
  cond=cls==1 ? rehhs[0] : cls==0 ? 4'hf : instr[16:13];
end
endtask
