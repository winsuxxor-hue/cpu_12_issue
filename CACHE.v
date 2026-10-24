static task cache;
  input [42:0] eng_addr;
  input [2:0] dreq;
  input [5:0] eng_lsi;
  input [11:0] mreg_reg2;
  reg [15:0][11:0][7:0][7:0][7:0][1:0][67:0] data;
  l1tag [15:0][11:0][7:0][7:0][1:0] tag;
  reg [67:0] rddata;
  integer bank;
  integer phi;
  for(bank=0;bank<12;bank++) begin
    rddata=data[{phy[4:3],phy[1:0]}][bank]
      [eng_addr[5:3]][eng_addr[8:6]]
      [eng_addr[11:9]][eng_addr[12]];
    rdatas=rddata>>eng_addr[2:0];
    sxt=rddata>>(eng_addr[2:0]+8<<dreq[1:0]
                 +7);
    rdataA=eng_addr&~(3'd7<<dreq[1:0])==0;
    if (dreq==3) rdatas={2'b0,rdatas[7:0],rdatas[15:8],
      rdatas[23:16],rdatas[31:24],rdatas[39:32],
      rdatas[47:40],rdatas[55:48],rdatas[63:56]};
    if (dreq[2]) case (dreq[1:0])
      0: rdatas[64:8]={57{sxt}};
      1: rdatas[64:16]={49{sxt}};
      2: rdatas[65:32]={rdatas[31],~rdatas[31],
                        {32{sxt}}};
    endcase
    rdtag=tag[{phy[4:3],phy[1:0]}][bank]
      [eng_addr[8:6]]
    [eng_addr[11:9]][eng_addr[12]];
    if (rdtag_reg[phy][fu].v && 
        rdtag_reg[phy][fu].rd &&
        rdtag_reg[phy][fu].addr==
        eng_addr_reg[phy][fu][42:6]) begin
      if (hit) $display("double hit %u",
                        eng_addr_reg[phy][fu]);
      hit=1;
      eng_data[phy][mreg_reg2[11:8]]
        [mreg_reg2[7:4]][mreg_reg2[3:0]]<=
        rdataS_reg[phy][fu]
        [65:0];
      expt=rdtag_reg[phy][fu].ex & !
      rdtag_reg[phy][fu].elid ||
      rdataA_reg[phy][fu]^1;
      eng_xc[phy][fu][eng_lsi]<={1'b1,
                                 expt};
      if (rdtag.pos==7) wbank=bank;
      if ({fu,phy}==myrnd) begin
        for(b=0;b<12;b++) begin
          bx=tag[phy[1:0]][b]
            [eng_addr[8:6]][eng_addr[11:9]]
            [eng_addr[12]].pos;
          if (bx==11) tag[phy[1:0]][b]
            [eng_addr[8:6]][eng_addr[11:9]]
            [eng_addr[12]].pos<=0;
          if (bx<11) tag[phy[1:0]][b]
            [eng_addr[8:6]][eng_addr[11:9]]
            [eng_addr[12]].pos+<=1;
        end
      end
    end
    if (!hit && eng_en) begin
      eng_amiss[(fu[3:0]+phy[6:3])%12][phy[2]]
      [eng_addr[4:3]*3+ins[phy][fu]++]
      [phy[1:0]][phy[6:3]]
      <={1'b1,eng_rd,eng_addr,dreq,wbank};
      tag[phy[1:0]][wbank][eng_addr[8:6]]
      [eng_addr[11:9]][eng_addr[12]].v
      &<=!rdtag.dirty;
      wbank++;
    end
    for(phi=0;phi<256;phi++) begin
    if (rdtag_reg[phy][fu].v && 
        rdtag_reg[phy][fu].wr &&
        rdtag_reg[phy][fu].addr==
        lsass[phi][fu][ldi+16].addr[42:6]) begin
      wdata[phi][fu]<=lsass[phi][ldi+19].data<<(lsass[phi][ldi+19].addr[2:0]*8);
      bytes[phi][fu]<=lsass[phi][ldi+19].bytes;
      whit[phi][fu]<=lsass[phi][ldi+19].en;
    end
      bytes2[phi][fu]<=bytes[phi][fu];
      bytes3[phi][fu]<=bytes2[phi][fu];
      bytes4[phi][fu]<=bytes3[phi][fu];
      whit2[phi][fu]<=whit[phi][fu];
      whit3[phi][fu]<=whit[phi][fu];
      whit4[phi][fu]<=whit[phi][fu];
      wdata2[phi][fu]<=wdata[phi][fu];
      wdata3[phi][fu]<=wdata2[phi][fu];
      wdata4[phi][fu]<=wdata3[phi][fu];
      if (whit4[phi][fu]) begin
        for(b=0;b<8;b++) if (bytes4[phi][fu][b])
          data[{phi[4:3],phi[1:0]}][bank][lsass[phi][ldi+20].addr[5:3]]
               [lsass[phi][ldi+20].addr[8:6]]
               [lsass[phi][ldi+20].addr[11:9]]
               [lsass[phi][ldi+20].addr[12]]
               [8*b+:8]=wdata4[phi][fu][8*b+:8];
          if (bytes[phi][fu][8])
            data[{phi[4:3],phi[1:0]}][bank][lsass[phi][ldi+20].addr[5:3]]
               [lsass[phi][ldi+20].addr[8:6]]
               [lsass[phi][ldi+20].addr[11:9]]
               [lsass[phi][ldi+20].addr[12]]
                 [65:64]=wdata4[phi][fu][65:64];
      end
  end
endtask
