function bnd;
  input [65:0] A;
  input [65:0] B;
  input [63:0] res;
  reg [65:0] ptr;
  reg [65:0] addend;
  reg upper;
  reg [23:0] bndx;
  ptr=A[65]^A[64] && A[64]^A[63] ? A:B;
  addend=A[65]^A[64] && A[64]^A[63] ? B:A;
  upper=~addend[42];
  error=~&addend[63:35] && |addend[63:35];
  if (!(^ptr[65:64] && ^ptr[64:64]))
    error=1;
  casez({ptr[43+7],ptr[43+15],ptr[43+:8]
         <ptr[51+:8]})
    3'bzz1: bndx=upper?{ptr[42:13]>>exp,
                        ptr[51+:8],5'h1f} :
              {ptr[42:13]>>exp,
               ptr[43+:8],5'b0};
    3'bzz0: bndx=upper?{(ptr[42:12]>>exp)+
                       ptr[58]^ptr[12],
                        ptr[51+:7],5'h1f} :
                {(ptr[42:12]>>exp)-
                 ptr[50]^ptr[12],
                 ptr[43+:7],5'b0};
  endcase
  if (error) bnd=0;
  else if (upper) bnd=((bndx<<exp)|
           ~(24'hffffff<<exp))>=res;
  else bnd=(bndx<<exp)<=res;
endfunction           
