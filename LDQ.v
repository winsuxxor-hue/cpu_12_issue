task LDQ;
  integer ind,phi;
  for(ind=0;ind<20;ind++)
    for(phi=0;phi<32;phi=phi+1) begin
    bump=eng_bump[ldi];
    bumpid=eng_bumpid[ldi];
    bumpid2=eng_bumpid[ldi-bump];
    useh=bumpid==bumpid2 && bumpid[0] && phy<phi;
    preenl=ind || fu>lsass[phi][0][ldi].fu;
    acmpl=lsasdr[phy][fu][ldi].addr[42:3]==
    lsass[phi][0][ldi-ind].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][0][ldi-ind].
    bytes && foo_en;
    acmph=lsasdr[phy][fu][ldi].addr[42:3]==
    lsass[phi][0][ldi-ind-bump].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][0][ldi-ind-bump].
    bytes && foo_en;
  end
endtask
