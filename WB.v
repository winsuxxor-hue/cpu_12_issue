task wb;
  integer c1;
  integer c2;
  for(c1=0;c1<12;c1++)
    for(c2=0;c2<12;c2=c2+1) begin
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c3][c4][0]==treg && en)
        eng_free[f][c1][c2][a]<=0;
    end
endtask
