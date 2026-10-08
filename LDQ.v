task LDQ;
  integer ind,phi;
  for(ind=0;ind<20;ind++)
    for(phi=0;phi<32;phi=phi+1) begin
    bump=eng_bump[ldi];
    bumpid=eng_bumpid[ldi];
    bumpid2=eng_bumpid[ldi-bump];
    useh=bumpid==bumpid2 && bumpid[0] && phy<phi;
    preenl=ind || fu>lsass[phi][s][ldi].fu;
    acmpl=lsasdr[phy][fu][ldi].addr[42:3]==
      lsass[phi][s][ldi-ind].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][s][ldi-ind].
    bytes && foo_en;
    acmph=lsasdr[phy][fu][ldi].addr[42:3]==
      lsass[phi][s][ldi-ind-bump].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][s][ldi-ind-bump].
    bytes && foo_en;
    confl=useh? acmph && preenl : acmpl && 
      preenl;
    if (!lsasdr[phy][fu][ldi].ldq) confl=0;
    confl_ex|=confl && !lsasdr[phy][fu][ldi].
      delayed;
    confl_wait|=confl && lsasdr[phy][fu][ldi].
      delayed && useh ? !lsass[phi][s][ldi-
        ind-bump].drdy : !lsass[phi][s]
      [ldi-ind].drdy;
  end
endtask
