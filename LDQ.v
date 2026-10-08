task LDQ;
  integer ind;
  for(ind=0;ind<20;ind++) begin
    bump=eng_bump[ldi];
    bumpid=eng_bumpid[ldi];
    bumpid2=eng_bumpid[ldi-bump];
    useh=bumpid==bumpid2 && bumpid[0];
    acmpl=lsasdr[phy][fu][ldi].addr[42:3]==
    lsass[phy][0][ldi-ind].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
    lsass[phy][0][ldi-ind].
    bytes && foo_en;
    acmph=lsasdr[phy][fu][ldi].addr[42:3]==
    lsass[phy][0][ldi-ind-bump].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
    lsass[phy][0][ldi-ind-bump].
    bytes && foo_en;
  end
endtask
