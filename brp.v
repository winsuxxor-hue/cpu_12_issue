task bro;
  brpa_rd=brpa[ip[11:4]];
  ebrp_rd=brpb[ip_reg[10:4]];
  br=brA[{ip[7:0],ght[7:0]}]^brB[{ip[6:0],
                                  ght[8:0]}]^
  brC[{ip[2:0],ght[12:0]}]^brp_rd.statik;
  if (brpa_rd.indir[0]) tgt[0]=br ? ebrp_rd
    .addr[0] : brpa_rd.addr[0];
  else if (brpa_rd.ret[0]) tgt[0]=stacktop;
  else tgt[0]=brpa_rd.addr[0];
  if (brpa_rd.indir[1]) tgt[1]=br ? ebrp_rd
    .addr[1] : brpa_rd.addr[1];
  else if (brpa_rd.ret[1]) tgt[1]=stacktop;
  else tgt[1]=brpa_rd.addr[1];
  tgt[2]=ebrp_rd.addr[0];
  tgt[3]=ebrp_rd.addr[1];
  br[2]=&brpa_rd.cond & brpa_rd.xs[0];
  br[3]=&brpa_rd.cond & brpa_rd.xs[1];
  for(b=0;b<2;b++)
  if (mispred[b]) casex($random(128))
    7'bx000000: brC[excip[2:0],excght[12:0]]
      [b]^=1;
    7'bxxx0000:brB[excip[6:0],excght[8:0]]
      [b]^=1;
    7'bxxxxx00:brA[excip[7:0],excght[7:0]]
      [b]^=1;
  endcase
endtask
