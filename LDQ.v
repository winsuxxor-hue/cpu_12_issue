task LDQ;
  integer ind,phi,b;
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
      datal=useh ? lsass[phi][s][ldi-ind-
        bump].data : lsass[phi][s][ldi-ind].data;
      if (useh ?lsass[phi][s][ldi-ind-bump].l:
        lsass[phi][s][ldi-ind].l)
        data<<=useh ?lsass[phi][s][ldi-ind-bump].
        addr[2:0]*3:
        lsass[phi][s][ldi-ind].
        addr[2:0]*3;
      else
        data>>=64-useh ? lsass[phi][s][ldi-ind-bump].
        addr[2:0]*3:
        lsass[phi][s][ldi-ind].
        addr[2:0]*3;
      for(b=0;b<9;b++)
        if (confl && useh ? lsass[phi][s]
            [ldi-ind-bump].bytes[b] : lsass
            [phi][s][ldi-ind-bump].bytes[b])
          begin
            rddata[8*b+:8]=data[8*b+:8];
            rdbytes[b]=1;
          end
  end
endtask
