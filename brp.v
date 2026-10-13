task bro;
  brpa_rd=brpa[ip[11:4]];
  ebrpb_rd=brpb[ip_reg[10:4]];
  br=brA[{ip[7:0],ght[7:0]}]^brB[{ip[6:0],
                                  ght[8:0]}]^
  brC[{ip[2:0],ght[12:0]}]^brp_rd.statik;
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
