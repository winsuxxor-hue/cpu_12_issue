static task cache;
  input [42:0] eng_addr;
  input [2:0] dreq;
  reg [3:0][11:0][7:0][7:0][7:0][1:0][11:0][67:0] data;
  reg [67:0] rddata;
  integer bank;
  for(bank=0;bank<12;bank++) begin
    rddata=data[phy[4:3]][bank]
      [eng_addr[5:3]][eng_addr[8:6]]
      [eng_addr[11:9]][eng_addr[12]]
      [fu];
    rdatas=rddara>>eng_addr[2:0];
    rdataA=eng_addr&~(3'd7<<dreq[1:0])==0;
    if (dreq==3) rdatas={2'b0,rdatas[7:0],rdatas[15:8],
      rdatas[23:16],rdatas[31:24],rdatas[39:32],
      rdatas[47:40],rdatas[55:48],rdatas[63:56]};
  end
endtask
