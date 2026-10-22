static task l2cache;
  input [42:0] addr;
  input [1:0] en_rd;
  input [3:0] dreq;
  input [8*66-1:0] data_wr;
  output [8*66-1:0] data_rd;
  input [6:0] phi;
  integer bank;
  tlb tlbdata [3:0][11:0][7:0][7:0][7:0][7:0][7:0];
  logic [3:0][11:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][65:0] data;
  logic [3:0][11:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][7:0][65:0] tag;
  for(bank=0;bank<12;bank++) begin
  end
endtask
