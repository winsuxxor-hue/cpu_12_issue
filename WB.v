task wb;
  input[11:0] treg;
  input en;
  input[11:0] tregmul;
  input enmul;
  input[11:0] treg2;
  input en2;
  input[11:0] treg3;
  input en3;
  input[11:0] treg_reg;
  input en_reg;
  integer c1;
  integer c2;
  for(c1=0;c1<12;c1++) for(c2=0;c2<12;c2++)
    for(f=0;f<12;f=f+1)
    begin
      for(a=0;a<3;a++)
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c1][c2][a]==treg && en)
        eng_free[f][c1][c2][a]<=0;
      for(a=0;a<3;a++)
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c1][c2][a]==tregmul && enmul)
        eng_free[f][c1][c2][a]<=0;
      a=4;
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c1][c2][2]==treg2 && en2)
        eng_free[f][c1][c2][a]<=0;
      a=3;
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c2][c3][0]==treg3 && en3)
        eng_free[f][c1][c2][a]<=0;
      a=5;
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c1][c2][3]==treg_reg && en_reg)
        eng_free[f][c1][c2][a]<=0;
      if (eng_free[f][c1][c2][a] && eng_ra[fu]
          [c1][c2][3]==treg_flgse && en_flgse)
       begin
         if (flcond(dataflx[fu],dataopx[`op_inv])
           eng_free[f][c1][c2][0]<=0;
         else begin
           eng_free[f][c1][c2][1]<=0;
           eng_free[f][c1][c2][2]<=0;
         end
       end
    end
endtask
