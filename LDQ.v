task LDQ;
  integer ind;
  for(ind=0;ind<20;ind++) begin
    bump=eng_bump[ldi];
    bumpid=eng_bumpid[ldi];
    bumpid2=eng_bumpid[ldi-bump];
    useh=bumpid==bumpid2 && bumpid[0];
    acmpl=lsasdr[ldi].addr[42:3]==
    lsass[ldi-ind].addr[42:3] && 
    lsasdr[ldi].bytes & lsass[ldi-ind].
    bytes && foo_en;
    acmph=lsasdr[ldi].addr[42:3]==
    lsass[ldi-ind-bump].addr[42:3] && 
    lsasdr[ldi].bytes & lsass[ldi-ind-bump].
    bytes && foo_en;
  end
endtask
