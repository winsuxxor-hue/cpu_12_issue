task LDQ;
  integer ind,phi,b,bump;
  rddata=lsasdr[phy][fu][ldi].data;
  rdbytes=lsasdr[phy][fu][ldi].bytes;
  for(ind=0;ind<20;ind++)
    for(phi=0;phi<128;phi=phi+1) begin
    bump=-eng_bump[ldi];
    bumpid=eng_bumpid[ldi];
    bumpid2=eng_bumpid[ldi-bump];
    useh=bumpid==bumpid2 && bumpid[0] && phy<phi;
    preenl=ind || fu>lsass[phi][ldi].fu;
    acmpl=lsasdr[phy][fu][ldi].addr[42:3]==
      lsass[phi][ldi-ind].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][ldi-ind].
    bytes && foo_en;
    acmph=lsasdr[phy][fu][ldi].addr[42:3]==
      lsass[phi][ldi-ind-bump].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][ldi-ind-bump].
    bytes && foo_en;
    acmpm=lsasdr[phy][fu][ldi].addr[42:3]==
      lsass[phi][ldi+ind].addr[42:3] && 
    lsasdr[phy][fu][ldi].bytes & 
      lsass[phi][ldi+ind].
    bytes && foo_en;
    confl=useh? acmph && preenl : acmpl && 
      preenl;
    conflm=acmpm && preenl;
    if (!lsasdr[phy][fu][ldi].ldq) confl=0;
    confl_ex|=confl && !lsasdr[phy][fu][ldi].
      delayed;
    confl_wait|=conflm && lsasdr[phy][fu][ldi].
      delayed && !lsass[phi][ldi+
        ind].drdy;
      datal=useh ? lsass[phi][ldi-ind-
        bump].data : lsass[phi][ldi-ind].data;
      if (useh ?lsass[phi][ldi-ind-bump].l:
        lsass[phi][ldi-ind].l)
        data<<=useh ?lsass[phi][ldi-ind-bump].
        addr[2:0]*3:
        lsass[phi][ldi-ind].
        addr[2:0]*3;
      else
        data>>=64-useh ? lsass[phi][ldi-ind-bump].
        addr[2:0]*3:
        lsass[phi][ldi-ind].
        addr[2:0]*3;
      for(b=0;b<9;b++)
        if (confl && useh ? lsass[phi]
            [ldi-ind-bump].bytes[b] : lsass
            [phi][ldi-ind-bump].bytes[b])
          begin
            rddata[8*b+:8]=data[8*b+:8];
            rdbytes[b]=1;
          end
  end
  if (confl_ex) eng_xc[phy][fu][ldi]
    <=1;
endtask
