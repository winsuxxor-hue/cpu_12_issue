task wb;
  integer c1;
  integer c2;
  for(c1=0;c1<12;c1++) for(c2=0;c2<12;c2++)
    for(c3=0;c3<12;c3++)
    for(c4=0;c4<12;c4=c4+1)
    for(f=0;f<12;f=f+1)
    begin
      for(a=0;a<4;a++)
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c3][c4][0]==treg && en)
        eng_free[f][c1][c2][a]<=0;
      a=5;
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
           [c3][c4][0]==treg2 && en2)
        eng_free[f][c1][c2][a]<=0;
      a=4;
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
           [c3][c4][0]==treg3 && en3)
        eng_free[f][c1][c2][a]<=0
    end
endtask
